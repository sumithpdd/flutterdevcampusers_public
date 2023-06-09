// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../widgets/create_account_form.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Color(0xffb9c2d1),
              )),
          Text(
            'Sign In',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              SizedBox(
                  width: 300,
                  height: 300,
                  child: isCreateAccountClicked != true
                      ? LoginForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)
                      : CreateAccountForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)),
              TextButton.icon(
                  icon: Icon(Icons.portrait_rounded),
                  style: TextButton.styleFrom(
                      foregroundColor: Color(0xfffd5b28),
                      textStyle:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                  onPressed: () {
                    setState(() {
                      isCreateAccountClicked = !isCreateAccountClicked;
                    });
                  },
                  label: Text(isCreateAccountClicked
                      ? 'Already have an account?'
                      : 'Create Account'))
            ],
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: Color(0xffb9c2d1),
              ))
        ],
      ),
    );
  }
}
