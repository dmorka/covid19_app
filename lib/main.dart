import 'package:covid19_app/pages/home_page.dart';
import 'package:covid19_app/pages/intro_page.dart';
import 'package:covid19_app/utils/services/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/protected_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        )
      ],
      child: MaterialApp(
        title: "COVID 19 App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Ubuntu",
        ),
        home: HomePage(),
      ),
    );
  }
}

//===============================================================================
// import 'dart:async';
// import 'dart:io';
//
// import 'package:covid19_app/pages/intro_page.dart';
// import 'package:covid19_app/utils/services/authentication_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FlutterBase',
//       home: Scaffold(
//         body: MessageHandler(),
//       ),
//     );
//   }
// }
//
// class MessageHandler extends StatefulWidget {
//   @override
//   _MessageHandlerState createState() => _MessageHandlerState();
// }
//
// class _MessageHandlerState extends State<MessageHandler> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging();
//
//   StreamSubscription iosSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isIOS) {
//       iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
//         print(data);
//         _saveDeviceToken();
//       });
//
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     } else {
//       _saveDeviceToken();
//     }
//
//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             content: ListTile(
//               title: Text(message['notification']['title']),
//               subtitle: Text(message['notification']['body']),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 color: Colors.amber,
//                 child: Text('Ok'),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ],
//           ),
//         );
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         // TODO open the page of the announcement to which the notification refers
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         // TODO open the page of the announcement to which the notification refers
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     if (iosSubscription != null) iosSubscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // _handleMessages(context);
//     return MultiProvider(
//       providers: [
//         Provider<AuthenticationProvider>(
//           create: (_) => AuthenticationProvider(FirebaseAuth.instance),
//         ),
//         StreamProvider(
//           create: (context) => context.read<AuthenticationProvider>().authState,
//         )
//       ],
//       child: MaterialApp(
//         title: "COVID 19 App",
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           fontFamily: "Ubuntu",
//         ),
//         home: IntroPage(),
//       ),
//     );
//   }
//
//   /// Get the token, save it to the database for current user
//   _saveDeviceToken() async {
//     // Get the current user
//     String uid = 'jeffd23';
//     // FirebaseUser user = await _auth.currentUser();
//
//     // Get the token for this device
//     String fcmToken = await _fcm.getToken();
//     print("TOOOOOOOOOOOOOOOKEN");
//     print(fcmToken);
//
//     // Save it to Firestore
//     if (fcmToken != null) {
//       var tokens = _db
//           .collection('users')
//           .document(uid)
//           .collection('tokens')
//           .document(fcmToken);
//
//       await tokens.setData({
//         'token': fcmToken,
//         'createdAt': FieldValue.serverTimestamp(), // optional
//         'platform': Platform.operatingSystem // optional
//       });
//     }
//   }
// }
//
// //========================================================================================================
// //
// // /// Define a top-level named handler which background/terminated messages will
// // /// call.
// // ///
// // /// To verify things are working, check out the native platform logs.
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   // If you're going to use other Firebase services in the background, such as Firestore,
// //   // make sure you call `initializeApp` before using other Firebase services.
// //   await Firebase.initializeApp();
// //   print("Handling a background message ${message.messageId}");
// // }
// //
// // /// Create a [AndroidNotificationChannel] for heads up notifications
// // const AndroidNotificationChannel channel = AndroidNotificationChannel(
// //   'high_importance_channel', // id
// //   'High Importance Notifications', // title
// //   'This channel is used for important notifications.', // description
// //   importance: Importance.high,
// //   enableVibration: true,
// //   playSound: true,
// // );
// //
// // /// Initalize the [FlutterLocalNotificationsPlugin] package.
// // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //     FlutterLocalNotificationsPlugin();
// //
// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   //
// //   // // Set the background messaging handler early on, as a named top-level function
// //   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// //   //
// //   // /// Create an Android Notification Channel.
// //   // ///
// //   // /// We use this channel in the `AndroidManifest.xml` file to override the
// //   // /// default FCM channel to enable heads up notifications.
// //   // await flutterLocalNotificationsPlugin
// //   //     .resolvePlatformSpecificImplementation<
// //   //         AndroidFlutterLocalNotificationsPlugin>()
// //   //     ?.createNotificationChannel(channel);
// //   //
// //   // /// Update the iOS foreground notification presentation options to allow
// //   // /// heads up notifications.
// //   // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
// //   //   alert: true,
// //   //   badge: true,
// //   //   sound: true,
// //   // );
// //
// //   final _fire = FirebaseMessaging();
// //   _fire.configure();
// //
// //   runApp(MyApp());
// // }
// //
// // //
// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiProvider(
// //       providers: [
// //         Provider<AuthenticationProvider>(
// //           create: (_) => AuthenticationProvider(FirebaseAuth.instance),
// //         ),
// //         StreamProvider(
// //           create: (context) => context.read<AuthenticationProvider>().authState,
// //         )
// //       ],
// //       child: MaterialApp(
// //         title: "COVID 19 App",
// //         debugShowCheckedModeBanner: false,
// //         theme: ThemeData(
// //           primarySwatch: Colors.blue,
// //           fontFamily: "Ubuntu",
// //         ),
// //         home: IntroPage(),
// //       ),
// //     );
// //   }
// // }
// //
// // // Crude counter to make messages unique
// // int _messageCount = 0;
// //
// // /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// // String constructFCMPayload(String token) {
// //   _messageCount++;
// //   return jsonEncode({
// //     'token': token,
// //     'data': {
// //       'via': 'FlutterFire Cloud Messaging!!!',
// //       'count': _messageCount.toString(),
// //     },
// //     'notification': {
// //       'title': 'Hello FlutterFire!',
// //       'body': 'This notification (#$_messageCount) was created via FCM!',
// //     },
// //   });
// // }
// //
// // /// Renders the example application.
// // class Application extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() => _Application();
// // }
// //
// // class _Application extends State<Application> {
// //   String _token;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     FirebaseMessaging.instance
// //         .getInitialMessage()
// //         .then((RemoteMessage message) {
// //       if (message != null) {
// //         Navigator.pushNamed(context, '/message',
// //             arguments: MessageArguments(message, true));
// //       }
// //     });
// //
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       RemoteNotification notification = message.notification;
// //       AndroidNotification android = message.notification?.android;
// //
// //       if (notification != null && android != null) {
// //         flutterLocalNotificationsPlugin.show(
// //             notification.hashCode,
// //             notification.title,
// //             notification.body,
// //             NotificationDetails(
// //               android: AndroidNotificationDetails(
// //                 channel.id,
// //                 channel.name,
// //                 channel.description,
// //                 // TODO add a proper drawable resource to android, for now using
// //                 //      one that already exists in example app.
// //                 icon: 'launch_background',
// //               ),
// //             ));
// //       }
// //     });
// //
// //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //       print('A new onMessageOpenedApp event was published!');
// //       Navigator.pushNamed(context, '/message',
// //           arguments: MessageArguments(message, true));
// //     });
// //   }
// //
// //   Future<void> sendPushMessage() async {
// //     if (_token == null) {
// //       print('Unable to send FCM message, no token exists.');
// //       return;
// //     }
// //
// //     try {
// //       await http.post(
// //         Uri.parse('https://api.rnfirebase.io/messaging/send'),
// //         headers: <String, String>{
// //           'Content-Type': 'application/json; charset=UTF-8',
// //         },
// //         body: constructFCMPayload(_token),
// //       );
// //       print('FCM request for device sent!');
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// //
// //   void onActionSelected(String value) async {
// //     switch (value) {
// //       case 'subscribe':
// //         {
// //           print(
// //               'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
// //           await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
// //           print(
// //               'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
// //         }
// //         break;
// //       case 'unsubscribe':
// //         {
// //           print(
// //               'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
// //           await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
// //           print(
// //               'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
// //         }
// //         break;
// //       case 'get_apns_token':
// //         {
// //           if (defaultTargetPlatform == TargetPlatform.iOS ||
// //               defaultTargetPlatform == TargetPlatform.macOS) {
// //             print('FlutterFire Messaging Example: Getting APNs token...');
// //             String token = await FirebaseMessaging.instance.getAPNSToken();
// //             print('FlutterFire Messaging Example: Got APNs token: $token');
// //           } else {
// //             print(
// //                 'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
// //           }
// //         }
// //         break;
// //       default:
// //         break;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Cloud Messaging"),
// //         actions: <Widget>[
// //           PopupMenuButton(
// //             onSelected: onActionSelected,
// //             itemBuilder: (BuildContext context) {
// //               return [
// //                 PopupMenuItem(
// //                   value: "subscribe",
// //                   child: Text("Subscribe to topic"),
// //                 ),
// //                 PopupMenuItem(
// //                   value: "unsubscribe",
// //                   child: Text("Unsubscribe to topic"),
// //                 ),
// //                 PopupMenuItem(
// //                   value: "get_apns_token",
// //                   child: Text("Get APNs token (Apple only)"),
// //                 ),
// //               ];
// //             },
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: Builder(
// //         builder: (context) => FloatingActionButton(
// //           onPressed: () => sendPushMessage(),
// //           child: Icon(Icons.send),
// //           backgroundColor: Colors.white,
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(children: [
// //           MetaCard("Permissions", Permissions()),
// //           MetaCard("FCM Token", TokenMonitor((token) {
// //             _token = token;
// //             return token == null
// //                 ? CircularProgressIndicator()
// //                 : Text(token, style: TextStyle(fontSize: 12));
// //           })),
// //           MetaCard("Message Stream", MessageList()),
// //         ]),
// //       ),
// //     );
// //   }
// // }
// //
// // /// UI Widget for displaying metadata.
// // class MetaCard extends StatelessWidget {
// //   final String _title;
// //   final Widget _children;
// //
// //   // ignore: public_member_api_docs
// //   MetaCard(this._title, this._children);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //         width: double.infinity,
// //         margin: EdgeInsets.only(left: 8, right: 8, top: 8),
// //         child: Card(
// //             child: Padding(
// //                 padding: EdgeInsets.all(16),
// //                 child: Column(children: [
// //                   Container(
// //                       margin: EdgeInsets.only(bottom: 16),
// //                       child: Text(_title, style: TextStyle(fontSize: 18))),
// //                   _children,
// //                 ]))));
// //   }
// // }
