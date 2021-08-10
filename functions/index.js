

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// when status changed from admin function in customer think that it was customer then change status of order

// 1-  when new customer just joined


exports.onJoinNewCutomer = functions.firestore.document('users/{userId}').onCreate(async (snapshot , context)=>{
const userId = context.params.userId;
const userData = snapshot.data();

//// create new notification 

var newUserInfo = {'name' : userData['name'], 'id': userId , 'date' : userData['date']};
console.log('newUserInfo is' , newUserInfo);

admin.firestore().collection('notification').doc().set(newUserInfo)});


/******************************************************/

// 2- when customer create order

exports.onCreateOrder = functions.firestore
 .document("/users/{userId}/orders/{orderId}/details/{details}")
  .onCreate(async (snapshot, context) => {
    const orderCreated = snapshot.data();
    const orderId = context.params.orderId;

   ////  add order to orders collection in admin panel
    var firstOrderItemImage = orderCreated['order_items'][0]['image'];
    var basicOrderInfo = {
      'order_id':orderCreated['order_id'],
      'total':orderCreated['total'],
      'orderNumber':orderCreated['orderNumber'],
      'order_status': orderCreated['order_status'],
      'userId': orderCreated['userId'],
      'ordered_at': orderCreated['ordered_at'],
      'image':firstOrderItemImage,
    }

    const ordersRef = admin
      .firestore()
      .collection("orders")
      .doc(orderId);
     await ordersRef.set(basicOrderInfo);
     await ordersRef.collection('details').doc('details').set(orderCreated);
      
      updateAnalytics({orders : true});
    
  });


  /******************************************************/

  // 3-  when customer cancel order

  exports.onCancelOrder = functions.firestore
    .document("/users/{userId}/orders/{orderId}")
    .onUpdate(async (change, context) => {
      const orderCancelled = change.after.data();
      const userId = context.params.userId;
      const orderId = context.params.orderId;
      var status = orderCancelled['order_status']
        console.log('userId is : ', userId);
        console.log('orderId is : ', orderId);
        console.log('status is' , status);
        //// cancel order in admin orders collection
        if(status == 'Canceled'){
          console.log('condition is true');
          var ordersRef = admin
          .firestore()
          .collection("orders")
          .doc(orderId);


          // update basic order info
          ordersRef.get().then(doc =>{
           if (doc.exists)
           {
           console.log('doc is exist');
              doc.ref.update({'order_status':'Canceled'});
             }
          });

          // update order details info

          ordersRef.collection('details').doc('details').get().then((doc)=>{
            if(doc.exists){
              doc.ref.update({'order_status':'Canceled'});
            }
          });

        }
     
    });

    // add date as id to document day

    async function updateAnalytics ( {orders = false,
    cancelledOrders = false,
    users = false,
  }={}){
            // add analytics to total - year - month - day 
      const analyticsRef = admin.firestore().collection('analytics');
      const date = new Date();
      const currentYear = date.getFullYear();
      const currentMonth = date.getMonth();
      const currentDay = date.getDate();
      var fieldName = new String();
      var analyticField;
      var updatingField = new Map();


      if(orders)
      fieldName = 'orders';
      else if(cancelledOrders)
      fieldName = 'cancelledOrders';
      else if (users)
      fieldName = 'users';
    
    

      if(orders || cancelledOrders || users){
    

       // 1-update order to total analytics  

     
       const totalAnalyticsRef = analyticsRef.doc('total');
       const totalDoc =  await totalAnalyticsRef.get();
       const totalData =  totalDoc.data();
      analyticField = totalData[fieldName];
      console.log(fieldName ,'from total is ',analyticField);
      updatingField = {[fieldName] : analyticField+1};
      totalAnalyticsRef.update(updatingField);
     


      // 2 -update order analytics to it is year
      
      const yearAnalyticsRef = analyticsRef.doc('calendar').collection('all_years').doc(String(currentYear));


      const yearDoc = await yearAnalyticsRef.get();
      

      const yearData =  yearDoc.data();


      analyticField = yearData[fieldName];

      console.log(fieldName ,'from year is ',analyticField);

      updatingField = {[fieldName] : analyticField+1};

      yearAnalyticsRef.update(updatingField);
    


     // 3 -update order analytics to it is month
    
      const monthAnalyticsRef = analyticsRef.doc('calendar').collection('all_years').doc(String(currentYear)).collection('months').doc(String(currentMonth+1));
      const monthDoc = await monthAnalyticsRef.get();
      const monthData = monthDoc.data();
      console.log('monthId' ,'is',monthDoc.id);
      analyticField = monthData[fieldName];
      updatingField = {[fieldName] : analyticField+1};
      console.log(fieldName ,'from months is ',analyticField);
      monthAnalyticsRef.update(updatingField);

    

    // 4- update order analytics to it is day 

    
      const currentDayId = new Date(Date.UTC(currentYear,currentMonth ,currentDay,12)).toISOString();
      const dayAnalyticsRef = analyticsRef.doc('calendar').collection('all_days').doc(currentDayId);
      console.log('currentDayId is',currentDayId);
      const dayDoc = await dayAnalyticsRef.get();
      console.log('dayDoc is',dayDoc);
      const dayData =  dayDoc.data();
      analyticField = dayData[fieldName];
      updatingField = {[fieldName] : analyticField+1};
      console.log(fieldName ,'from days is ',analyticField);
      dayAnalyticsRef.update(updatingField);
      }
    
      }
  