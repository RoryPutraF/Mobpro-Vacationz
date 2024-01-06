import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobpro/constant.dart';
import 'package:mobpro/pages/Homepage.dart';
import 'package:mobpro/pages/Loginpage.dart';
import 'package:mobpro/pages/Profilepage.dart';

class Mydrawer extends StatefulWidget {
  final User? user;
  Mydrawer({super.key, this.user});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(''),
          accountEmail: Text(widget.user!.email.toString(),
              style: TextStyle(color: Colors.black)),
          currentAccountPicture: CircleAvatar(
              child: ClipOval(
            child: Icon(Icons.person),
          )),
          decoration: BoxDecoration(color: backgroundColor),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("H O M E P A G E"),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Homepage())));
          },
        ),
        GestureDetector(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text("P R O F I L E"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Profilepage())));
            },
          ),
        ),
        SizedBox(height: 450),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("L O G  O U T"),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => Loginpage())));
          },
        ),
      ],
    ));
  }
}
