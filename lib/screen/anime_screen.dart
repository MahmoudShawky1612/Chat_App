import 'package:chatapp/screen/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _fireStore=FirebaseFirestore.instance;


class AnimeScreen extends StatefulWidget {
  const AnimeScreen({Key? key}) : super(key: key);
  static const String screenRoute='anime_chat';

  @override
  _AnimeScreenState createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  final _auth=FirebaseAuth.instance;
  late String messageText;
  final messageTextController=TextEditingController();
  late final User signedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){

      final user=_auth.currentUser;
      if(user!=null)
      {
        signedUser=user;
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: Color(0xFF070F2B),
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 25,color: Colors.white,),
            SizedBox(width: 10),
            Text('Anime',style: TextStyle(color: Colors.white),)
          ],
        ),
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(

                      controller: messageTextController,
                      onChanged: (value) {
                        messageText=value;
                      },
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _fireStore.collection('anime').add({
                        'text':messageText,
                        'sender':signedUser.displayName,
                        'time':FieldValue.serverTimestamp(),

                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('anime').orderBy('time').snapshots(),
        builder: (context,snapshot){
          List<MessageLine> messageWidgets=[];
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          final messages=snapshot.data!.docs.reversed;
          for(var message in messages){
            final messageText =message.get('text');
            final messageSender =message.get('sender');
            final currentUser =FirebaseAuth.instance.currentUser?.displayName;
            final messageWidget =MessageLine(
              sender: messageSender,
              text: messageText,
              isMe:currentUser==messageSender,
            );
            messageWidgets.add(messageWidget);
          }

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: ListView(
                reverse: true,
                children:
                messageWidgets,

              ),
            ),
          );

        });
  }
}


class MessageLine extends StatelessWidget {
  const MessageLine({this.text,this.sender,required this.isMe,super.key});

  final String? text;
  final String? sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:isMe?CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(fontSize: 12,color: Colors.grey),),
          Material(
              borderRadius:isMe? BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight:Radius.circular(20),
              ): BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight:Radius.circular(20),
              ),
              elevation: 6,
              color: isMe?Color(0xFF481E14):Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$text',style: TextStyle(fontSize: 18,color:isMe? Colors.white:Colors.white),),
              )),
        ],
      ),
    );

  }
}
