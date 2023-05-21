import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class AlertCustomAuth{

  scaffoldMessenger(String title ,String message, ContentType type, BuildContext context){
    final snackBar = SnackBar(
                  elevation: 0,
                  duration:  const Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: title,
                    message: message,
                    contentType: type,
                  ),
                );
                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
  }
}