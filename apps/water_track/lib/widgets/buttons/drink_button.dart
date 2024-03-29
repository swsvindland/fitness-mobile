import 'package:flutter/material.dart';

class DrinkButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  final Function()? inc;
  final Function()? dec;

  const DrinkButton(
      {super.key,
      required this.title,
      required this.color,
      required this.inc,
      required this.dec,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          height: 50,
          minWidth: 35,
          elevation: 0,
          onPressed: dec,
          color: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25), right: Radius.zero)),
          child: Icon(
            Icons.remove,
            size: 15.0,
            color: textColor ?? Colors.white,
          ),
        ),
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          minWidth: 175.0,
          height: 50,
          elevation: 0,
          color: color,
          onPressed: inc,
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
              letterSpacing: 2.5,
              fontWeight: FontWeight.w100,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
        MaterialButton(
          height: 50,
          minWidth: 35,
          elevation: 0,
          onPressed: inc,
          color: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.zero, right: Radius.circular(25))),
          child: Icon(
            Icons.add,
            size: 15.0,
            color: textColor ?? Colors.white,
          ),
        )
      ],
    );
  }
}
