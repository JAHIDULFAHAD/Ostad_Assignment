import 'package:flutter/material.dart';

void ShowSnackbarMessage(BuildContext context,title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}