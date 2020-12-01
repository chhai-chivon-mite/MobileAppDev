import 'package:flutter/material.dart';

class Utils {
  static Widget actionButton(String title, {bool hasBackground = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: Colors.blueGrey),
          color: hasBackground ? Colors.blueGrey : Colors.white),
      child: Center(
        child: Text(title),
      ),
    );
  }
}
