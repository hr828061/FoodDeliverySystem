import 'package:ecommerce/Pages/login.dart';
import 'package:ecommerce/admin/home_admin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../widget/widget_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();


class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  child: Text("Let's Start With \nAdmin!",style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Image.asset(
                      'images/logo.jpeg', // Replace with your logo image asset path
                      height: 100.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: usernamecontroller,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Username';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Username',
                                prefixIcon: Icon(Icons.verified_user_sharp),
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              controller: userpasswordcontroller,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            SizedBox(height: 10.0),

                          ],
                        ),
                      ),
                    ),

                    // Login Button
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                       LoginAdmin();

                      },
                      child: Container(
                        width: 200.0,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFEFA228),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: AppWidget.semiBoldTextFieldStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Login As? User',
                                style: AppWidget.singUpTextFieldStyle()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your id is not correct",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (result.data()['password'] !=
            userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Your password is not correct",
                style: TextStyle(fontSize: 18.0),
              )));
        } else {
          Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}
