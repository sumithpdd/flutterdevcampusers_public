import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp timestamp) {
  return DateFormat.yMMMd().format(timestamp.toDate());
}

class ThemeConstants {
  static InputDecoration searchFieldDecoration = const InputDecoration(
    hintText: 'Search Attendees',
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
  );
}
