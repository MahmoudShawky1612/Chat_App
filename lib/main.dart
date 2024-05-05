import 'package:chatapp/screen/anime_screen.dart';
import 'package:chatapp/screen/books_chat.dart';
import 'package:chatapp/screen/chat_screen.dart';
import 'package:chatapp/screen/groups_screen.dart';
import 'package:chatapp/screen/regestration_screen.dart';
import 'package:chatapp/screen/signin_screen.dart';
import 'package:chatapp/screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:(FirebaseAuth.instance.currentUser!=null&&FirebaseAuth.instance.currentUser!.emailVerified) ? GroupsScreen.screenRoute:WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute:(context)=>WelcomeScreen(),
        SignInScreen.screenRoute:(context)=>SignInScreen(),
        RegistrationScreen.screenRoute:(context)=>RegistrationScreen(),
        ChatScreen.screenRoute:(context)=>ChatScreen(),
        GroupsScreen.screenRoute:(context)=>GroupsScreen(),
        BooksChat.screenRoute:(context)=>BooksChat(),
        AnimeScreen.screenRoute:(context)=>AnimeScreen(),
      },
    );
  }
}
