
import 'package:chatapp/screen/groups_screen.dart';
import 'package:chatapp/screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
  import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/nutton.dart';
import 'chat_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String screenRoute='signin_screen';


  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth=FirebaseAuth.instance;

  late String email;
  late String password;
  bool show=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: show,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(height: 50),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your Email',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MyButton(
                color: Colors.yellow[900]!,
                title: 'Sign in',
                onPressed: () async{
                  setState(() {
                    show=true;
                  });
                  try {
                    final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(user.user!.emailVerified){
                      Navigator.pushNamed(context,GroupsScreen.screenRoute);
                      setState(() {
                        show=false;
                      });
                    }
                    else{
                      setState(() {
                        show=false;
                      });
                      const snackBar = SnackBar(
                        content: Text('Verify the email'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }



                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      show=false;
                    });
                    if (e.code == 'user-not-found') {
                      const snackBar = SnackBar(
                        content: Text('No user found for that email.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    } else if (e.code == 'wrong-password') {

                      const snackBar = SnackBar(
                        content: Text('Wrong password provided for that user.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }
                  }


                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}