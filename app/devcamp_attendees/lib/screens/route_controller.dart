import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'get_started_page.dart';
import 'login_page.dart';
import 'main_screen.dart';
import 'page_not_found.dart';

class RouteController extends StatelessWidget {
  const RouteController({Key? key, required this.settingName})
      : super(key: key);
  final String settingName;
  @override
  Widget build(BuildContext context) {
    final userSignedIn = Provider.of<User?>(context) != null;

    final signedInGotoMain =
        userSignedIn && settingName == '/main'; // they are good to go!
    final notSignedIngotoMain = !userSignedIn &&
        settingName == '/main'; // not signed in user trying to to the mainPage
    if (settingName == '/') {
      return const GetStartedPage();
    } else if (settingName == '/login' || notSignedIngotoMain) {
      return const LoginPage();
    } else if (signedInGotoMain) {
      return const MainScreenPage();
    } else {
      return const PageNotFound();
    }
  }
}
