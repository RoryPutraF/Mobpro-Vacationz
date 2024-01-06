import 'package:flutter/material.dart';

class textbox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  textbox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffC7C7C7), borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              //edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.settings, color: Colors.black),
              ),
            ],
          ),
          Text(text)
        ],
      ),
    );
  }
}

class textbox2 extends StatelessWidget {
  final String text2;
  final String sectionName2;

  textbox2({super.key, required this.text2, required this.sectionName2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffC7C7C7), borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionName2,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(text2)
        ],
      ),
    );
  }
}
