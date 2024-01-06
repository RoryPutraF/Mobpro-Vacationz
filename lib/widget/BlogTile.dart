import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class BlogTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String jamBuka;
  final Function onTap;

  BlogTile({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.jamBuka,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: double.infinity,
        height: 240,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 10,
                child: SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.grey),
                            SizedBox(
                              width: 5,
                            ),
                            Text(jamBuka,
                                style: GoogleFonts.montserrat(fontSize: 12))
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
