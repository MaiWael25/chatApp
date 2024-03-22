import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
   CustomButton({this.onTap,required this.text});
   final String text;
   VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color:Color.fromARGB(255, 33, 18, 59),
          borderRadius: BorderRadius.circular(8),
    
        ),
        child: Center(child: Text(text,style: const TextStyle(color: Colors.white),)),
      ),
    );
  }
}
