import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // RemoteMessage? initialMessage;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  void createNotificationChannel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  void setForegroundNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void showNotification(RemoteNotification? notification) async {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        'notification title',
        'notification body',
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            _channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),

        ));
  }
}

// void subscribeToTopic() async {
//   String topic = 'enCustomersNotifications';
//   try {
//     await FirebaseMessaging.instance.subscribeToTopic(topic);
//     print('subscribed to topic');
//   } catch (e) {
//     print('error is $e');
//   }
// }

//
//
//

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   String token = '';
//
//   // final notificationProvider = getItInstance<NotificationProvider>();
//
//   @override
//   void initState() {
//     super.initState();
//     subscribeToTopic();
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('onMessage data is ${message.data}');
//       print('onMessage notification is ${message.notification}');
//
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       // if (notification != null && android != null) {
//       //   flutterLocalNotificationsPlugin.show(
//       //       notification.hashCode,
//       //       'notification title',
//       //       'notification body',
//       //       // notification.title,
//       //       // notification.body,
//       //       NotificationDetails(
//       //         android: AndroidNotificationDetails(
//       //           channel.id,
//       //           channel.name,
//       //           channel.description,
//       //           color: Colors.blue,
//       //           playSound: true,
//       //           icon: '@mipmap/ic_launcher',
//       //         ),
//       //       ));
//       // }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       if (notification != null && android != null) {
//         showDialog(
//             context: context,
//             builder: (_) {
//               return AlertDialog(
//                 title: Text(notification.title!),
//                 content: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [Text('You came from background message')],
//                   ),
//                 ),
//               );
//             });
//       }
//     });
//
//     if (initialMessage != null) {
//       Future.delayed(Duration(milliseconds: 10)).then((value) => showDialog(
//           context: context,
//           builder: (_) {
//             return AlertDialog(
//               title: Text(initialMessage!.notification!.title!),
//               content: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [Text('You came from background message')],
//                 ),
//               ),
//             );
//           }));
//     }
//   }
//
//   // void showNotification() async {
//   //   setState(() {
//   //     _counter++;
//   //   });
//   //   flutterLocalNotificationsPlugin.show(
//   //       0,
//   //       "Testing $_counter",
//   //       "How you doin ?",
//   //       NotificationDetails(
//   //           android: AndroidNotificationDetails(
//   //               channel.id, channel.name, channel.description,
//   //               importance: Importance.high,
//   //               color: Colors.blue,
//   //               playSound: true,
//   //               icon: '@mipmap/ic_launcher')));
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showNotification,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
