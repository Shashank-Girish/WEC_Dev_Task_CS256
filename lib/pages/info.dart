import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  var uname=FirebaseAuth.instance.currentUser!.email;
  var a=Hive.box("Information");
  List <dynamic>? data;
  var name= TextEditingController();
  int priority=1;
  int type=0;

  @override
  void initState(){
    super.initState();
    data =a.get(uname);

  }

  @override
  void dispose(){
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Information"),
        backgroundColor: Colors.green[600],
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Enter your Habit Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Habit Name: ",style: TextStyle(fontSize: 16),),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    icon: Icon(Icons.list),
                    hintText: "Enter Habit Name",
                    labelText: "Habit Name"
                ),

              ),
              Text("Priority: ",style: TextStyle(fontSize: 16)),
              RadioListTile(
                title: Text("High Priority"),
                value: 0,
                groupValue: priority,
                onChanged: (value){
                  setState(() {
                    priority=value!.toInt();
                  });
                },
              ),

              RadioListTile(
                title: Text("Low Priority"),
                value: 1,
                groupValue: priority,
                onChanged: (value){
                  setState(() {
                    priority=value!.toInt();
                  });
                },
              ),
              Text("Habit Type: ",style: TextStyle(fontSize: 16)),
              RadioListTile(
                title: Text("Positive Habit"),
                value: 0,
                groupValue: type,
                onChanged: (value){
                  setState(() {
                    type=value!.toInt();
                  });
                },
              ),

              RadioListTile(
                title: Text("Negative Habit"),
                value: 1,
                groupValue: type,
                onChanged: (value){
                  setState(() {
                    type=value!.toInt();
                  });
                },
              ),

              Center(
                child: TextButton(onPressed: (){
                  setState(() {
                    Map<String,List> dt={
                      name.text: [DateTime.now(),0,priority,type,true,DateTime.now()]
                    };
                    if (data!=null) {
                      data!.add(dt);
                      a.put(uname,data);
                     // print(a.get('keys'));
                    }
                    else{
                      data=[dt];
                      a.put(uname,data);
                      //var d = a.get('keys');
                      //print(d);
                    }


                  });
                  Navigator.pushReplacementNamed(context, '/home');

                }, child: Text("Save")
                ),
              )


            ],
          ),
        ],
      ),
    );
  }
}
