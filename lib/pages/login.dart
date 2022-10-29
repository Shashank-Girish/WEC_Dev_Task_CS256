import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var uname= TextEditingController();
  var psswd= TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: uname.text.trim(),
        password: psswd.text.trim(),
    );
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
        title: Text("Login Page"),
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
                labelText: "Email"
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
                  labelText: "Password",
                  //labelStyle: TextStyle(color: Colors.white)

              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Center(
              child: TextButton.icon(
                  onPressed: (){
                    signIn();
                  },
                  icon: Icon(Icons.login),
                  label: Text("Login"),
                style: ButtonStyle(
                  //backgroundColor: Colors.blue[600],
                ),
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("New user? Register here: "),
                GestureDetector(
                  child: Text("Sign Up", style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    setState(() {
                      Navigator.pushNamed(context, '/signup');
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
