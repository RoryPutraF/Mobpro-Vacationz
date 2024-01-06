import 'package:flutter/material.dart';
import 'package:mobpro/constant.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String address;
  final String id;

  DetailsPage({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.address,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text('Details'),
        ),
        body: ListView(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              height: 250,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title,
                style: textTextStyle.copyWith(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "D E S C R I P T I O N",
                style: textTextStyle.copyWith(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.description,
                style: textTextStyle.copyWith(fontSize: 15),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "A D D R E S S",
                style: textTextStyle.copyWith(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.address,
                style: textTextStyle.copyWith(fontSize: 15),
              ),
            ),
          ],
        ));
  }
}
