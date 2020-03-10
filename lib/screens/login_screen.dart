import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:who_care/pages/home.dart';
import 'package:who_care/pages/dialog.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DialogBox dialogBox = new DialogBox();
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Login'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formkey,
          child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset('assets/images/logo2.png', height: 200,),
                  TextFormField(
                    validator: (input) {
                      if(input.isEmpty) {
                        return 'Please enter your email.';
                      }
                    },
                    onSaved: (input) => _email = input,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      )
                    )
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    validator: (input) {
                      if(input.length < 6) {
                        return 'Please enter your password.';
                      }
                    },
                    onSaved: (input) => _password = input,
                    obscureText: true,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      )
                    )
                  ),
                  SizedBox(height: 20,),
                  FlatButton( 
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  textColor: Colors.white,
                  onPressed: signIn,
                  ),
                ],
            ),
              ),
          ),
        );
          }
        ),
      )
    );
  }

  Future<void> signIn() async {

    final formState = _formkey.currentState;

    if(formState.validate()) {
      formState.save();
      try{

      AuthResult user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user.user)));
      }catch(e){
        // dialogBox.information(context, "Error", e.toString());
        dialogBox.information(context, "Login Failed", "Please enter correct username and password.");
        print(e.message);
      }
    } 

  }
}