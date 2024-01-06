import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobpro/constant.dart';
import 'package:mobpro/firebase_auth_service.dart';
import 'package:mobpro/widget/form_container_widget.dart';
import 'package:mobpro/pages/Homepage.dart';
import 'package:mobpro/pages/Signuppage.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'Assets/images/Logo.png',
                  width: 400,
                  height: 300,
                ),
                Text(
                  "Welcome To Vacationz",
                  style: textTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Column(children: [
                  FormContainerWidget(
                    controller: emailController,
                    hintText: "Enter Your Email",
                    isPasswordField: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more email validation logic if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  FormContainerWidget(
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    isPasswordField: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // You can add more password validation logic if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: signIn,
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 45),
                      decoration: BoxDecoration(
                        color: ButtonColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You Don't Have An Account Yet?",
                          style: textTextStyle),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registerpage(),
                            ),
                          );
                        },
                        child: Text("Sign Up", style: RegisterTextStyle),
                      )
                    ],
                  )
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (formkey.currentState?.validate() ?? false) {
      String email = emailController.text;
      String password = passwordController.text;

      User? user = await _auth.signInWithEmailAndPassword(email,password);

      if (user != null) {
        print('User is Successfully SignedIn');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have successfully logged in!'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => Homepage(user: user,))),
        );
      } else {
        print("Some Error Happened");
      }
    }
  }
}
