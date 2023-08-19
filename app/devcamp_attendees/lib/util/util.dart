import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/dev_camp_user.dart';

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

final allCountriesWithCodes = {
  'Algeria': 'DZ',
  'Austria': 'AT',
  'Azerbaijan': 'AZ',
  'Bangladesh': 'BD',
  'Brazil': 'BR',
  'Cameroon': 'CM',
  'Canada': 'CA',
  'Colombia': 'CO',
  'Ecuador': 'EC',
  'Egypt': 'EG',
  'Ethiopia': 'ET',
  'Gabon': 'GA',
  'Germany': 'DE',
  'Sri Lanka': 'LK',
  'India': 'IN',
  'Israel': 'IL',
  'Kenya': 'KE',
  'Mexico': 'MX',
  'Nepal': 'NP',
  'Nigeria': 'NG',
  'Pakistan': 'PK',
  'Philippines': 'PH',
  'Scotland': 'GB',
  'Sénégal': 'SN',
  'Spain': 'ES',
  'Tanzania': 'TZ',
  'Turkey': 'TR',
  'UAE': 'AE',
  'United Kingdom': 'GB',
  'Ukraine': 'UA',
  'United States': 'US',
  'Uruguay': 'UY',
};

final allCountriesWithGeo = {
  'Algeria': Geo(lat: '28.033886', lng: '1.659626'),
  'Austria': Geo(lat: '47.516231', lng: '14.550072'),
  'Azerbaijan': Geo(lat: '40.143105', lng: '47.576927'),
  'Bangladesh': Geo(lat: '23.684994', lng: '90.356331'),
  'Brazil': Geo(lat: '-14.235004', lng: '-51.92528'),
  'Cameroon': Geo(lat: '7.369722', lng: '12.354722'),
  'Canada': Geo(lat: '56.130366', lng: '-106.346771'),
  'Colombia': Geo(lat: '4.570868', lng: '-74.297333'),
  'Ecuador': Geo(lat: '-1.831239', lng: '-78.183406'),
  'Egypt': Geo(lat: '26.820553', lng: '30.802498'),
  'Ethiopia': Geo(lat: '9.145', lng: '40.489673'),
  'Gabon': Geo(lat: '-0.803689', lng: '11.609444'),
  'Germany': Geo(lat: '51.165691', lng: '10.451526'),
  'Sri Lanka': Geo(lat: '7.873054', lng: '80.771797'),
  'India': Geo(lat: '20.593684', lng: '78.96288'),
  'Israel': Geo(lat: '31.046051', lng: '34.851612'),
  'Kenya': Geo(lat: '-0.023559', lng: '37.906193'),
  'Mexico': Geo(lat: '23.634501', lng: '-102.552784'),
  'Nepal': Geo(lat: '28.394857', lng: '84.124008'),
  'Nigeria': Geo(lat: '9.081999', lng: '8.675277'),
  'Pakistan': Geo(lat: '30.375321', lng: '69.345116'),
  'Philippines': Geo(lat: '12.879721', lng: '121.774017'),
  'Scotland': Geo(lat: '56.4906712', lng: '-4.2026458'),
  'Sénégal': Geo(lat: '14.497401', lng: '-14.452362'),
  'Spain': Geo(lat: '40.463667', lng: '-3.74922'),
  'Tanzania': Geo(lat: '-6.369028', lng: '34.888822'),
  'Turkey': Geo(lat: '38.963745', lng: '35.243322'),
  'UAE': Geo(lat: '23.424076', lng: '53.847818'),
  'United Kingdom': Geo(lat: '55.378051', lng: '-3.435973'),
  'Ukraine': Geo(lat: '48.379433', lng: '31.16558'),
  'United States': Geo(lat: '37.09024', lng: '-95.712891'),
  'Uruguay': Geo(lat: '-32.522779', lng: '-55.765835'),
};
