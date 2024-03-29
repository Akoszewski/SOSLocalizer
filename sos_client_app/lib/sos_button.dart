import 'package:flutter/material.dart';

class SosButton extends StatelessWidget {
  final VoidCallback? callback;
  final String text;
  const SosButton({Key? key, required this.text, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * 0.5,
      height: screenHeight * 0.1,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: callback,
        child: Text(text,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}
