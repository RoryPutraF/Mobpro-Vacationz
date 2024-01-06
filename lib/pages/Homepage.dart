import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobpro/constant.dart';
import 'package:mobpro/pages/Detailspage.dart';
import 'package:mobpro/pages/Drawer.dart';
import 'package:mobpro/widget/BlogTile.dart';

class Homepage extends StatefulWidget {
  final User? user;
  const Homepage({super.key, this.user});

  @override
  State<Homepage> createState() => homepageState();
}

class homepageState extends State<Homepage> {
  final CollectionReference tempatRef =
      FirebaseFirestore.instance.collection("Tempat");

  TextEditingController searchController = TextEditingController();
  late String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: Mydrawer(user: widget.user,),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
              hintText: 'where do you want to go today?',
              hintStyle: TextStyle(color: Color.fromARGB(151, 135, 135, 135)),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search)),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: tempatRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Error");
          } else if (snapshot.hasData) {
            var filteredDocs = snapshot.data!.docs
                .where((doc) => doc['Title']
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .toList();

            return ListView(
              children: filteredDocs
                  .map((e) => BlogTile(
                        title: e['Title'],
                        imageUrl: e['Image'],
                        description: e['Description'],
                        jamBuka: e['JamBuka'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => DetailsPage(
                                title: e['Title'],
                                imageUrl: e['Image'],
                                description: e['Description'],
                                address: e['Address'],
                                id: e.id,
                              ),
                            ),
                          );
                        },
                      ))
                  .toList(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
