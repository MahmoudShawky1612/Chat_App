import 'package:chatapp/screen/anime_screen.dart';
import 'package:chatapp/screen/chat_screen.dart';
import 'package:chatapp/screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'books_chat.dart';

class GroupsScreen extends StatelessWidget {
   GroupsScreen({Key? key}) : super(key: key);
  static const String screenRoute='groups_screen';
  final _auth=FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222831),
      appBar: AppBar(
        backgroundColor:Color(0xFF222831),
        title: Text("Groups",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
            icon: Icon(Icons.logout,color: Colors.white,),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xFF222831),
          
            boxShadow: [
              BoxShadow(
                color: Colors.white, // Shadow color
                spreadRadius: 3, // Spread radius
                blurRadius: 10, // Blur radius
                offset: Offset(0, 1), // Offset in x and y directions
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to food group screen
                      Navigator.pushNamed(context,ChatScreen.screenRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder( // No radius
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Food Group',style: TextStyle(color: Colors.white),),
                          Icon((Icons.fastfood_outlined)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to books group screen
                      Navigator.pushNamed(context, BooksChat.screenRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder( // No radius
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Books Group',style: TextStyle(color: Colors.white)),
                          Icon((Icons.book_outlined)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to anime group screen
                      Navigator.pushNamed(context, AnimeScreen.screenRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button color
                      shape: RoundedRectangleBorder( // No radius
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Anime Group',style: TextStyle(color: Colors.white)),
                          Icon((Icons.movie_creation_outlined)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
