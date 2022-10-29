import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  var uname=FirebaseAuth.instance.currentUser!.email;
  var a=Hive.box("Information");
  List <dynamic>? data;
  int gd_hgh=0,gd_low=0,bd_hgh=0,bd_low=0;

  @override
  void initState(){
    super.initState();
    data =a.get(uname);
    var m=(data==null)? 0:data!.length;
    for(int i=0;i<m;i++){
      var nam=data![i].keys.first.toString();
      if (data![i][nam][3]==0 && data![i][nam][2]==0){
        gd_hgh+=1;

      }
      else if (data![i][nam][3]==1 && data![i][nam][2]==0){
        bd_hgh+=1;

      }
      else if (data![i][nam][3]==0 && data![i][nam][2]==1){
        gd_low+=1;

      }
      else if (data![i][nam][3]==1 && data![i][nam][2]==1){
        bd_low+=1;

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text("Habit Statistics"),
        elevation: 10,
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("User Habit Statistics",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/4,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(title: "",value: double.parse(gd_hgh.toString()),color: Colors.green),
                      PieChartSectionData(title: "",value: double.parse(gd_low.toString()),color: Colors.green[300]),
                      PieChartSectionData(title: "",value: double.parse(bd_hgh.toString()),color: Colors.blue),
                      PieChartSectionData(title: "",value: double.parse(bd_low.toString()),color: Colors.blue[300])
                    ]
                  )
                ),
              ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Good Habit, High Priority",style: TextStyle(backgroundColor: Colors.green,color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Good Habit, Low Priority",style: TextStyle(backgroundColor: Colors.green[300],color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Bad Habit, High Priority",style: TextStyle(backgroundColor: Colors.blue,color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Bad Habit, Low Priority",style: TextStyle(backgroundColor: Colors.blue[300],color: Colors.white),),
                  ),


            ],

          ),
        ),
      ),


    );
  }
}
