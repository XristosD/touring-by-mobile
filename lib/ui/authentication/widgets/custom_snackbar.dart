import 'package:flutter/material.dart';

class CustomSnackbar{

  static show(String message, BuildContext context){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black.withOpacity(0.9),
        duration: const Duration(seconds: 10),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return SnackBar(
  //       backgroundColor: Colors.black.withOpacity(0.9),
  //   duration: const Duration(seconds: 10),
  //   content: Text(
  //   this.errorMessage,
  //   style: TextStyle(
  //   color: Colors.white,
  //   ),
  //   ),
  //   action: SnackBarAction(
  //   label: 'OK',
  //   textColor: Colors.white,
  //   onPressed: () {},
  //   );
  // }
}
