import 'package:chatx/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ProfleController Proflecontroller = ProfleController();
void bottomsheet(BuildContext context) {
  final profilecontroler =
      Provider.of<ProfleController>(context, listen: false);
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    context: context,
    builder: (context) => ListView(
      padding: EdgeInsets.all(12.0),
      shrinkWrap: true,
      children: [
        Text(
          'Pick Profle Picture',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 23),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    fixedSize: Size(150, 150)),
                onPressed: () {
                  profilecontroler.pickImageFromCamera();
                },
                child: Image.asset(
                  'assets/file.jpg',
                  fit: BoxFit.cover,
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.white,
                    fixedSize: Size(150, 150)),
                onPressed: () {
                  // Provider.of<ProfleController>(context, listen: false)
                  // .pickImageFromGallery();

                  profilecontroler.pickImageFromGallery();
                },
                child: Image.asset(
                  'assets/gallery.jpg',
                  fit: BoxFit.cover,
                ))
          ],
        )
      ],
    ),
  );
}
