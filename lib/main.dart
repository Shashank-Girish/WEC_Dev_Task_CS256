import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/home_page.dart';
import 'pages/stats.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/info.dart';
import 'pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var a= await Hive.openBox("Information");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false ,
    initialRoute: '/',
    routes: {
      '/': (context) => StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting || snapshot.connectionState==ConnectionState.none ){

          return Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError){
          return Text("Something went wrong");
        }
        else if (snapshot.hasData){
          return MainPage();
        }
        else{
          return Login();
        }
      }),
      '/home': (context)=> MainPage(),
      '/stats': (context)=> Stats(),
      '/info':(context)=>Info(),
      '/signup': (context) => SignUp()

    },
  ));
}

