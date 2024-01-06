import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobpro/constant.dart';
import 'package:mobpro/widget/textbox.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // all user
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                "Edit $field",
                style: TextStyle(color: Colors.black),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                // cancel button
                TextButton(
                  child: Text('Cancel', style: TextStyle(color: Colors.black)),
                  onPressed: () => Navigator.pop(context),
                ),
                // save button
                TextButton(
                  child: Text('Save', style: TextStyle(color: Colors.black)),
                  onPressed: () => Navigator.of(context).pop(newValue),
                )
              ],
            ));
    if (newValue.trim().length > 0) {
      //only update if there is something in the textfield
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: backgroundColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  SizedBox(height: 30),
                  //profile pic
                  Icon(Icons.person, size: 72),

                  SizedBox(height: 50),

                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      'MY DETAILS',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),

                  textbox(
                      text: userData['username'],
                      sectionName: 'U S E R N A M E',
                      onPressed: () => editField('username')),

                  textbox2(
                    text2: userData['email'],
                    sectionName2: 'E M A I L',
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
