import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'home.dart';

class UploadPage extends StatefulWidget{

  State<StatefulWidget> createState() {

    return _UploadPageState();
  }
}

class _UploadPageState extends State<UploadPage>
{
  File sampleImage;
  String _myValue;
  String url;
  final formKey = new GlobalKey<FormState>();

  Future getImage() async
  {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAnSave()
  {
    final form = formKey.currentState;

    if(form.validate()) {

      form.save();
      return true;
    }
    else
    {
      return false;
    }
    
  }

  void uploadStatusImage() async {

    if(validateAnSave()) {

      final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Post Images");

      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url = ImageUrl.toString();

      print("Image Url = " + url);

      goToHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url)
  {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = 
    {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time
    };

    ref.child("Posts").push().set(data);

  }

  void goToHomePage()
  {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context)
      {
        return new Home();
      }
      )
    );
  }



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: new AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: new Text('Share Story '),
        centerTitle: true,
      ),

      body: new Center (
        child: sampleImage == null ? Text('Select an Image') : enableUpload(),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
      ),

    );
  }

  Widget enableUpload()
  {
    return Container(
      child: new Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Image.file(sampleImage, height: 330.0, width: 660.0,),

            SizedBox(height: 15.0,),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Descrition', contentPadding: EdgeInsets.all(5)),

              validator: (value)
              {
                return value.isEmpty ? 'Please input some description.' : null;
              },

              onSaved: (value)
              {
                return _myValue = value;
              },
            ),

            SizedBox(height: 15.0,),

            RaisedButton(
              elevation: 10.0,
              child: Text('Share'),
              padding: const EdgeInsets.all(15),
              textColor: Colors.white,
              color: Colors.blue,

              onPressed: uploadStatusImage,
            )
          ],
        ),
      ),
    );
  }
}