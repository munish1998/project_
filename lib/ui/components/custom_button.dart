import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  CustomButton({super.key, required this.title, required this.onTap, this.buttonColor = Colors.blueGrey});
  final String title;
  final VoidCallback onTap;
  final Color buttonColor;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width - 100,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2)
        ),
        child: Center(
          child: Text(widget.title),
        ),
      ),
    );
  }
}
