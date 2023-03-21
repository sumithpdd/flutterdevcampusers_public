// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'login_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircleAvatar(
        backgroundColor: const Color(0xfff5f6f8),
        child: Column(children: [
          Spacer(),
          Text(
            'Sumith Flutter Devcamp Mentee',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: 15,
          ),
          Text(' "Learn. Change. Yourself"',
              style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                  fontSize: 29)),
          SizedBox(
            height: 50,
          ),
          TextButton.icon(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xff69639f),
                  textStyle: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              icon: Icon(Icons.login_rounded),
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sign in to get started'),
              )),
          Spacer()
        ]),
      ),
    );
  }
}
