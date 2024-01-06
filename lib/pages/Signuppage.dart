import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobpro/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobpro/widget/form_container_widget.dart';
import 'package:mobpro/pages/Loginpage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _Registerpage();
}

class _Registerpage extends State<Registerpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool passwordVisible = true;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username': emailController.text.split('@')[0],
          'email': emailController.text
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have successfully signed up!'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => Loginpage())),
      );
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/images/Logo.png',
                width: 400,
                height: 300,
              ),
              Text(
                "Sign Up To Vacationz",
                style: textTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),

              // Register username Box dan Text
              Column(children: [
                FormContainerWidget(
                  controller: emailController,
                  hintText: "Enter Your Email",
                  isPasswordField: false,
                ),

                SizedBox(height: 15),

                FormContainerWidget(
                  controller: passwordController,
                  hintText: "Enter Your Password",
                  isPasswordField: true,
                ),

                SizedBox(height: 15),

                FormContainerWidget(
                  controller: confirmpasswordController,
                  hintText: "Confirm Your Password",
                  isPasswordField: true,
                ),

                SizedBox(height: 15),

                // Tombol Sign Up
                GestureDetector(
                  onTap: signUp,
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
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
