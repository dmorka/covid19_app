import 'package:covid19_app/pages/home_page.dart';
import 'package:covid19_app/pages/intro_page.dart';
import 'package:covid19_app/pages/user_profile_page.dart';
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
//         home: IntroPage(),
        initialRoute: '/',
        routes: {'/user-profile': (context) => UserProfilePage()},
      ),
    );
  }
}
