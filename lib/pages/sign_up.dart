import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var uname= TextEditingController();
  var psswd= TextEditingController();

  Future signUp() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: uname.text.trim(),
      password: psswd.text.trim(),

    );
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  void dispose(){
    uname.dispose();
    psswd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New User Page"),
        leading: Icon(Icons.person),
        backgroundColor: Colors.green[600],
      ),
      backgroundColor: Colors.green[100],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            TextFormField(
              controller: uname,
              decoration: InputDecoration(
                  icon: Icon(Icons.person_outline),
                  hintText: "Enter Email",
                  labelText: "User Email"
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),

            TextFormField(

              obscureText: true,
              obscuringCharacter: "*",
              controller: psswd,
              decoration: InputDecoration(
                icon: Icon(Icons.key),
                hintText: "Enter Password",
                labelText: "Set Password",
                //labelStyle: TextStyle(color: Colors.white)

              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Center(
              child: TextButton.icon(
                onPressed: (){
                  signUp();
                },
                icon: Icon(Icons.arrow_forward),
                label: Text("New User"),
                style: ButtonStyle(
                  //backgroundColor: Colors.blue[600],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
