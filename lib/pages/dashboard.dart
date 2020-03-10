import 'package:flutter/material.dart';
import 'package:who_care/pages/stories.dart';
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");

    postsRef.once().then((DataSnapshot snap){

      var KEYS = snap.value.keys;
      var DATA = snap.value;
      
      postsList.clear();

      for(var individualKey in KEYS)
      {
        Posts posts = new Posts
        (
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'],
        );

        postsList.add(posts);
      }

      setState(() {
        
        print('Length : $postsList.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stories'),
        automaticallyImplyLeading: false,
      ),
      body: new Container(
        child: postsList.length == 0 ? new Text('No stories available yet.') : new ListView.builder
        (
          itemCount: postsList.length,
          itemBuilder: (_, index)
          {
            return PostsUI(postsList[index].image, postsList[index].description, postsList[index].date, postsList[index].time);
          }
        )
      ),
    );
  }

  Widget PostsUI(String image, String description, String date, String time)
  {
    return Card
    (
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        padding: new EdgeInsets.all(14.0),

        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>
          [
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                new Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            SizedBox(height: 10.0,),
            new Image.network(image, fit: BoxFit.cover),
            SizedBox(height: 10.0,),
            new Text(
              description,
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.center,
            ),
            new Text(
              '\n ―Anonymous',
              style: TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ]
        ),

      ),
    );
  }
}