

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// when status changed from admin function in customer think that it was customer then change status of order

// 1-  when new customer just joined


exports.onJoinNewCustomer = functions.firestore.document('users/{userId}').onCreate(async (snapshot , context)=>{
const userId = context.params.userId;
const userData = snapshot.data();

//// create new notification 

var newUserInfo = {'name' : userData['name'], 'id': userId , 'date' : userData['date']};
console.log('newUserInfo is' , newUserInfo);

admin.firestore().collection('notifications').doc().set(newUserInfo)});


/******************************************************/

// 2- when customer create order

exports.onCreateOrder = functions.firestore
 .document("/orders/{orderId}")
  .onCreate(async (snapshot, context) => {
    const createdOrder = snapshot.data();
    const orderId = context.params.orderId;

   ////  add order to orders collection in admin panel
    const userId = createdOrder['user_id'];

    console.log('userId is ',userId);
    console.log('orderId', orderId);

      const userOrdersRef = admin.firestore().collection('users').doc(userId).collection('orders').doc(orderId);

     await userOrdersRef.set(createdOrder);
//      updateAnalytics({orders : true});
    
  });


  /******************************************************/

  // 3-  when order status changed

  exports.onOrderStatusChanged = functions.firestore
    .document("/orders/{orderId}")
    .onUpdate(async (change, context) => {

      const updatedOrderData = change.after.data();

      const userId = updatedOrderData['user_id'];

      const orderId = context.params.orderId;

      var status = updatedOrderData['order_status'];

        console.log('userId is : ', userId);
        console.log('orderId is : ', orderId);
        console.log('status is' , status);


        var userOrders = admin.firestore().collection('users').doc(userId).collection('orders').doc(orderId);

        if(status == 'Delivering'){
          var orderNumber = updatedOrderData['order_number'];
          // update user order data
          userOrders.update({'order_status':status , 'order_number': orderNumber});

        }else{
          
          // update user order data
          userOrders.update({'order_status':status});
        }

     
    });


    async function updateStatistics ( {orders = false,
    cancelledOrders = false,
    customers = false,
  }={}){
            // add statistics to total - year - month - day 
      const statisticsRef = admin.firestore().collection('statistics');

      const date = new Date();

      const currentYear = date.getFullYear();
      const currentMonth = date.getMonth();
      const currentDay = date.getDate();
      var fieldName = new String();
      var statisticField;
      var updatingField = new Map();


      if(orders)
      fieldName = 'orders';
      else if(cancelledOrders)
      fieldName = 'canceled_orders';
      else if (customers)
      fieldName = 'customers';
    
    

      if(orders || cancelledOrders || customers){
    

       // 1-update order to total statistics  

     
       const totalStatisticsRef = statisticsRef.doc('total');
       const totalDoc =  await totalStatisticsRef.get();
       const totalData =  totalDoc.data();
      statisticField = totalData[fieldName];
      console.log(fieldName ,'from total is ',statisticField);
      updatingField = {[fieldName] : statisticField+1};
      totalStatisticsRef.update(updatingField);
     


      // 2 -update order statistics to it is year
      
      const yearAnalyticsRef = statisticsRef.doc('calendar').collection('all_years').doc(String(currentYear));


      const yearDoc = await yearAnalyticsRef.get();
      

      const yearData =  yearDoc.data();


      statisticField = yearData[fieldName];

      console.log(fieldName ,'from year is ',statisticField);

      updatingField = {[fieldName] : statisticField+1};

      yearAnalyticsRef.update(updatingField);
    


     // 3 -update order statistics to it is month
    
      const monthAnalyticsRef = statisticsRef.doc('calendar').collection('all_years').doc(String(currentYear)).collection('months').doc(String(currentMonth+1));
      const monthDoc = await monthAnalyticsRef.get();
      const monthData = monthDoc.data();
      console.log('monthId' ,'is',monthDoc.id);
      statisticField = monthData[fieldName];
      updatingField = {[fieldName] : statisticField+1};
      console.log(fieldName ,'from months is ',statisticField);
      monthAnalyticsRef.update(updatingField);

    

    // 4- update order statistics to it is day 

    
      const currentDayId = new Date(Date.UTC(currentYear,currentMonth ,currentDay,12)).toISOString();
      const dayAnalyticsRef = statisticsRef.doc('calendar').collection('all_days').doc(currentDayId);
      console.log('currentDayId is',currentDayId);
      const dayDoc = await dayAnalyticsRef.get();
      console.log('dayDoc is',dayDoc);
      const dayData =  dayDoc.data();
      statisticField = dayData[fieldName];
      updatingField = {[fieldName] : statisticField+1};
      console.log(fieldName ,'from days is ',statisticField);
      dayAnalyticsRef.update(updatingField);
      }
    
      }
  

      /*
      // statistics collection
      should I delete products and customers from statistics ? yes

      structure of statistics => statistics => calender => years , months , days

        when should I update statistics ?
        1 - canceled orders when customer or admin cancel order => (orders collection) => // there is a special case ....

        2 - delivered orders when admin mark order as delivered => (orders collection)
        3 - total income when admin mark order as delivered => (orders collection)
        4 - total orders when customer place order => (orders collection)


      (1) scenario solution 
      if new product added then increment added_prdoucts field for days , months , years
      else deleted decrement added_prdoucts field days , months , years
      get day id from product date



      */