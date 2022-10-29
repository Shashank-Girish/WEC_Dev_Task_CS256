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
        title: Text("Habit Info"),
        backgroundColor: Colors.green[600],
      ),
      body: Column(
        children: [
          Text("Your habit information"),
          Column(
            children: [
              Text("Habit Name: "),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    icon: Icon(Icons.list),
                    hintText: "Enter Habit Name",
                    labelText: "Habit Name"
                ),

              ),
              Text("Priority: "),
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
              Text("Habit Type: "),
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

              TextButton(onPressed: (){
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
              )


            ],
          ),
        ],
      ),
    );
  }
}
