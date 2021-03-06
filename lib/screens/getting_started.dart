import 'dart:async';
import 'package:flutter/material.dart';
import '../model/slide.dart';
import '../widgets/slide_dots.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import '../widgets/slide_item.dart';

class GettingStarted extends StatefulWidget {
  
  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if(_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 300), 
      curve: Curves.easeInOut);
    });
  }

  _onPageChanged(int index){
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child:
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                       PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: slideList.length,
                        itemBuilder: (ctx, i) => SlideItem(i),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 35),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for(int i = 0; i < slideList.length; i++)
                                if(i == _currentPage)
                                  SlideDots(true) 
                                else
                                  SlideDots(false)
                              ],
                            ),
                          )
                        ]
                      )
                    ],
                  )
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                FlatButton(
                  child: Text('Get Started', style: TextStyle(fontSize: 18,),),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text('Have an Account?', style: TextStyle(fontSize: 18,),),
                  FlatButton(
                    child: 
                    Text('Login', style: 
                    TextStyle(fontSize: 18, color: Colors.blue)
                    ,),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    }
                  ,),
                ],),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}