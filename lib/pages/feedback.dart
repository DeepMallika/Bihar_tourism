import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feedback_Pg extends StatefulWidget {
  @override
  _Feedback_PgState createState() => _Feedback_PgState();
}

class _Feedback_PgState extends State<Feedback_Pg> {
  var myFeedbackText = "COULD BE BETTER";
  var sliderValue = 0.0;
  String msg;
  Map data;
  IconData myFeedback = FontAwesomeIcons.sadTear;
     Color myFeedbackColor = Colors.red;

  getsliderValue(sliderValue){
    this.sliderValue=sliderValue;
  }
  getmsg(msg){
    this.msg=msg;
  }
  feedbackData(){
    Map<String, dynamic> feedData = {
      "Rating": sliderValue,
      "Message": msg,
    };
    // ignore: deprecated_member_use
    CollectionReference collectionReference= Firestore.instance.collection('FeedBack');
    collectionReference.add(feedData);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Thank you for your Feedback"),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Rate Us",style: TextStyle(color:Colors.deepOrange,fontSize:20.0,fontWeight: FontWeight.bold),),
        backgroundColor:Colors.black ,
        actions: <Widget>[
          IconButton(icon: Icon(
              FontAwesomeIcons.solidStar), onPressed: () {})],),
      body: Container(
        color: Color(0xffE5E5E5),
        child: Column(
          children: <Widget>[
            Container(child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(child: Text(" On a scale of 1 to 10",
                style: TextStyle(color: Colors.deepOrange, fontSize: 22.0,fontWeight:FontWeight.bold),)),
            ),),
            Container(
              child: Align(
                child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Container(
                      width: 350.0,
                      height: 400.0,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Text(myFeedbackText,
                            style: TextStyle(color: Colors.black, fontSize: 22.0),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Icon(
                            myFeedback, color: myFeedbackColor, size: 100.0,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Slider(
                            min: 0.0,
                            max: 10.0,
                            divisions: 5,
                            value: sliderValue,
                            activeColor: Color(0xffe05f2c),
                            inactiveColor: Colors.blueGrey,
                            onChanged: (newValue) {
                              setState(() {
                                sliderValue = newValue;
                                if (sliderValue >= 0.0 && sliderValue <= 2.0) {
                                  myFeedback = FontAwesomeIcons.sadTear;
                                  myFeedbackColor = Colors.red;
                                  myFeedbackText = "COULD BE BETTER";
                                }
                                if (sliderValue >= 2.1 && sliderValue <= 4.0) {
                                  myFeedback = FontAwesomeIcons.frown;
                                  myFeedbackColor = Colors.yellow;
                                  myFeedbackText = "BELOW AVERAGE";
                                }
                                if (sliderValue >= 4.1 && sliderValue <= 6.0) {
                                  myFeedback = FontAwesomeIcons.meh;
                                  myFeedbackColor = Colors.amber;
                                  myFeedbackText = "NORMAL";
                                }
                                if (sliderValue >= 6.1 && sliderValue <= 8.0) {
                                  myFeedback = FontAwesomeIcons.smile;
                                  myFeedbackColor = Colors.green;
                                  myFeedbackText = "GOOD";
                                }
                                if (sliderValue >= 8.1 && sliderValue <= 10.0) {
                                  myFeedback = FontAwesomeIcons.laugh;
                                  myFeedbackColor = Colors.pink;
                                  myFeedbackText = "EXCELLENT";
                                }
                              });
                              getsliderValue(sliderValue);
                            },
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(child: TextFormField(
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.blueGrey)),
                              hintText: 'Add Comment',
                            ),
                            style: TextStyle(height: 3.0),
                            validator: (msg) => msg.isEmpty ? 'Please enter a message' : null,
                            onChanged: (String msg){
                              getmsg(msg);
                            },
                          ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              color: Color(0xffe05f2c),
                              child: Text('Submit',
                                style: TextStyle(color: Color(0xffffffff)),),
                              onPressed: () {feedbackData();},),)),),],)),),),),],),),);}}