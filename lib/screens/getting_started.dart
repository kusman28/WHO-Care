import 'package:flutter/material.dart';

class GettingStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Column(children: <Widget>[
                Text('Hello'),
              ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                FlatButton(
                  child: Text('Getting Started', style: TextStyle(fontSize: 18,),),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text('Have an account?', style: TextStyle(fontSize: 18,),),
                  FlatButton(child: Text('Login', style: TextStyle(fontSize: 18,),),),
                ],),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}