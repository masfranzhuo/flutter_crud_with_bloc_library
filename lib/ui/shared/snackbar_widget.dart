import 'package:flutter/material.dart';

SnackBar snackBar(String message) {
  return SnackBar(content: Text(message), duration: (Duration(seconds: 1)),);
}