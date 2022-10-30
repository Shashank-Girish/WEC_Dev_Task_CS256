import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var uname=FirebaseAuth.instance.currentUser!.email;
  var a=Hive.box("Information");
  //List <dynamic>? data;
  var name= TextEditingController();
  int priority=1;
  int type=1;
  //bool value=true;
  var clr=Colors.blue[500];
  Future? f;




  @override
  void initState(){
    super.initState();
    f = j();//a.get(uname);
    /*data =a.get(uname);
    var m=(data==null)? 0:data!.length;
    for(int i=0;i<m;i++){
      var nam=data![i].keys.first.toString();
      if (DateTime.now().difference(data![i][nam][5]).inDays>=1){
        data![i][nam][4]=true;
      }
    }*/
  }

  Future j() async{
    //f = a.get(uname);
    //await Future.delayed(Duration(seconds: 5));
    List<dynamic>? data;
    data =a.get(uname);
    var m=(data==null)? 0:data!.length;
    for(int i=0;i<m;i++){
      var nam=data![i].keys.first.toString();
      if (DateTime.now().difference(data![i][nam][5]).inDays>=1){
        data![i][nam][4]=true;
      }
    }

    return Future.value(data);
  }

  @override
  void dispose(){
    name.dispose();
    super.dispose();
  }

  /*Map info={
    String habit
    DateTime initial_date
    int no_of_days
    int priority
    int type
    bool value
    Date_time last_clicked
  }*/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: Text("Your Habits"),
        backgroundColor: Colors.green[600],
        leading: Icon(Icons.home),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: f,
          builder: (context, snapshot) {
            switch(snapshot.connectionState)
            {
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                var data = snapshot.data;
                return ListView.builder(
                    itemCount: data != null ? data!.length : 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (data == null || data!.isEmpty) {
                        return Text("No data to show");
                      }


                      return Card(
                        color: (data![index][data![index].keys.first
                            .toString()][3] == 0) ? Colors.green[200] : Colors
                            .blue[200],
                        child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/3,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          data![index].keys.first.toString(),
                                          style: TextStyle(fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      var days_tlt = DateTime
                                          .now()
                                          .difference(
                                          data![index][data![index].keys.first
                                              .toString()][0])
                                          .inDays;
                                      var act_days = data![index][data![index].keys
                                          .first.toString()][1];
                                      //print(days_tlt);
                                      //print(data![index][data![index].keys.first.toString()][1]);

                                      var alert = AlertDialog(
                                        title: Text("${data![index].keys.first
                                            .toString()} Statistics"),
                                        scrollable: true,
                                        content: Column(
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: PieChart(
                                                  PieChartData(
                                                      sections: [
                                                        PieChartSectionData(
                                                            value: double.parse(
                                                                (act_days)
                                                                    .toString()),
                                                            color: Colors.green),
                                                        PieChartSectionData(
                                                            value: double.parse(
                                                                (days_tlt -
                                                                    act_days + 1)
                                                                    .toString()),
                                                            color: Colors.red)
                                                      ]
                                                  )
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: Text("Exit")
                                            )
                                          ],
                                        ),
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          }
                                      );
                                    },
                                    icon: Icon(Icons.query_stats_rounded),
                                    label: Text("Habit Stats",
                                      style: TextStyle(fontSize: 18),),

                                  ),
                                  IconButton(
                                      onPressed: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                            return AlertDialog(
                                              scrollable: true,
                                              title: Text("${data![index].keys.first.toString()} information"),
                                              content: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Habit Name: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text("${data![index].keys.first.toString()}")

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Habit Type: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text("${(data![index][data![index].keys.first.toString()][3]==0)? "Good Habit":"Bad Habit"}")

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Priority: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text("${(data![index][data![index].keys.first.toString()][2]==0)? "High Priority":"Low Priority"}")
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Date started: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text("${DateFormat("dd-MM-yyyy").format(data![index][data![index].keys.first.toString()][0])}")
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(child: Text("Number of days maintained/combated: ",style: TextStyle(fontWeight: FontWeight.bold),)),
                                                      Expanded(child:Text("${data![index][data![index].keys.first.toString()][1]}"))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );

                                          }
                                        );

                                        },
                                      icon: Icon(Icons.info,color: Colors.blue[400],)
                                  )
                                ],
                              ),
                              //Text("Date of Beginning: ${data[index]}"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        data!.removeAt(index);
                                        a.put(uname, data);
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                    label: Text("Delete"),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        name= TextEditingController(text: data![index].keys.first.toString());
                                        priority=data![index][data![index].keys.first.toString()][2];
                                        type=data![index][data![index].keys.first.toString()][3];
                                        var alert =
                                        StatefulBuilder(

                                            builder: (BuildContext context,
                                                StateSetter setDialogState) {
                                              return AlertDialog(
                                                scrollable: true,
                                                title: Text("Edit Habit Info"),
                                                icon: Icon(Icons.edit),
                                                content: Column(
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
                                                      onChanged: (value) {
                                                        setDialogState(() {
                                                          priority = value!.toInt();
                                                        });
                                                      },
                                                    ),

                                                    RadioListTile(
                                                      title: Text("Low Priority"),
                                                      value: 1,
                                                      groupValue: priority,
                                                      onChanged: (value) {
                                                        setDialogState(() {
                                                          priority = value!.toInt();
                                                        });
                                                      },
                                                    ),
                                                    Text("Habit Type: "),
                                                    RadioListTile(
                                                      title: Text("Positive Habit"),
                                                      value: 0,
                                                      groupValue: type,
                                                      onChanged: (value) {
                                                        setDialogState(() {
                                                          type = value!.toInt();
                                                        });
                                                      },
                                                    ),

                                                    RadioListTile(
                                                      title: Text("Negative Habit"),
                                                      value: 1,
                                                      groupValue: type,
                                                      onChanged: (value) {
                                                        setDialogState(() {
                                                          type = value!.toInt();
                                                        });
                                                      },
                                                    ),

                                                    TextButton(onPressed: () {
                                                      setState(() {
                                                        Map<String, List> dt = {
                                                          name.text: [
                                                            data![index][data![index]
                                                                .keys.first
                                                                .toString()][0],
                                                            data![index][data![index]
                                                                .keys.first
                                                                .toString()][1],
                                                            priority,
                                                            type,
                                                            data![index][data![index]
                                                                .keys.first
                                                                .toString()][4],
                                                            data![index][data![index]
                                                                .keys.first
                                                                .toString()][5]
                                                          ]
                                                        };
                                                        data![index] = dt;
                                                      });
                                                      Navigator.of(context).pop();
                                                    }, child: Text("Save")
                                                    )
                                                  ],
                                                ),

                                              );
                                            }
                                        );
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            }
                                        );
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                    label: Text("Edit"),
                                  ),

                                  TextButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        var nm = data![index].keys.first.toString();

                                        var value = data![index][nm][4];
                                        if (value == true) {
                                          int n = data![index][nm][1] + 1;
                                          Map<String, List> dt = {
                                            nm: [
                                              data![index][nm][0],
                                              n,
                                              data![index][nm][2],
                                              data![index][nm][3],
                                              false,
                                              DateTime.now()
                                            ]
                                          };
                                          data![index] = dt;
                                          a.put(uname, data);
                                        }
                                        //value=false;
                                            ;
                                        //print(data);
                                      });
                                    },
                                    label: Text("Task Done", style: TextStyle(
                                        color: (data![index][data![index].keys.first
                                            .toString()][4]) ? Colors.blue : Colors
                                            .grey),),
                                    icon: Icon(Icons.add,
                                        color: (data![index][data![index].keys.first
                                            .toString()][4]) ? Colors.blue : Colors
                                            .grey),


                                  )
                                  /*Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ), //SizedBox
                                  Text(
                                    'Task done ',
                                    style: TextStyle(fontSize: 17.0),
                                  ), //Text
                                  SizedBox(width: 10), //SizedBox

                                  Checkbox(
                                    value: value,
                                    onChanged: ( _value) {
                                      setState(() {
                                        value = true;
                                        //print(value);
                                      });
                                    },
                                  ), //Checkbox
                                ], //<Widget>[]
                              ),*/
                                ],
                              )
                            ]
                        ),
                      );
                    }
                );
            }

          }
        )
        ),


      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(Icons.add),
                onTap: (){
                    setState(() {
                      Navigator.pushNamed(context, '/info');
                    });
                },
              ),
              label: "Add Habit"
          ),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(Icons.query_stats),
                  onTap: (){
                    setState(() {
                      Navigator.pushNamed(context, '/stats');
                    });
                  },
              ),
            label: "View Stats"
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[600],
        child: Icon(Icons.logout),
        onPressed: () {
          setState(() {
            FirebaseAuth.instance.signOut();
          });
        }
    ),


    );
  }
}
