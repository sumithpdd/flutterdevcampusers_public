// ignore_for_file: prefer_const_constructors

import 'package:devcamp_attendees/service/database_service.dart';
import 'package:flutter/material.dart';

import '../screens/main_screen.dart';
import 'input_decoration.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm(
      {Key? key,
      required this.formKey,
      required this.emailTextController,
      required this.passwordTextController})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(children: [
        Text(
            'Please enter a valid email and a password that is at least 6 character.'),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              return value!.isEmpty ? 'Please add an email' : null;
            },
            controller: emailTextController,
            decoration: buildInputDecoration(
                label: 'Enter email', hintText: 'john@me.com'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
              validator: (value) {
                return value!.isEmpty ? 'Enter password' : null;
              },
              controller: passwordTextController,
              obscureText: true,
              decoration:
                  buildInputDecoration(label: 'password', hintText: '')),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                backgroundColor: Colors.amber,
                textStyle: TextStyle(fontSize: 18)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String email = emailTextController.text;
                //john@me.com ['john', 'me.com']
                // FirebaseAuth.instance
                //     .createUserWithEmailAndPassword(
                //         email: email, password: passwordTextController.text)
                //     .then((value) {
                //   // ignore: avoid_print
                //   print(value.user);
                //   if (value.user != null) {
                //     String displayName = email.toString().split('@')[0];
                //     DatabaseService().createUser(displayName).then(
                //       (value) {
                //       //  Firebase FirebaseAuth.instance
                //       //       .signInWithEmailAndPassword(
                //       //           email: email,
                //       //           password: passwordTextController.text)
                //       //       .then((value) {
                //       //     return Navigator.push(
                //       //         context,
                //       //         MaterialPageRoute(
                //       //           builder: (context) => MainScreenPage(),
                //       //         ));
                //       //   }).catchError((onError) {
                //       //     return showDialog(
                //       //       context: context,
                //       //       builder: (context) {
                //       //         return AlertDialog(
                //       //           title: Text('Oops!'),
                //       //           content: Text('${onError.message}'),
                //       //         );
                //       //       },
                //       //     );
                //       //   });
                //       },
                //     );
                //   }
                // });
              }
            },
            child: Text('Create Account'))
      ]),
    );
  }
}
