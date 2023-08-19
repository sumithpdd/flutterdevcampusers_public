import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devcamp_attendees/service/constants.dart';
import 'package:devcamp_attendees/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants/constants.dart';
import '../models/dev_camp_user.dart';
import '../screens/main_screen.dart';
import '../util/util.dart';
import 'input_decoration.dart';
import 'two_sided_roundbutton.dart';

class UserDetailsDialog extends StatefulWidget {
  const UserDetailsDialog({super.key, required this.devcampusers});
  final DevCampUser devcampusers;
  @override
  State<UserDetailsDialog> createState() => _UserDetailsDialogState();
}

class _UserDetailsDialogState extends State<UserDetailsDialog> {
  bool acceptedClicked = false;
  bool isConfirmedClicked = false;
  double _rating = 3.5;
  late String userStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DevCampUser devCampUser = widget.devcampusers;
    TextEditingController nameTextController =
        TextEditingController(text: devCampUser.name);
    TextEditingController bioTextController =
        TextEditingController(text: devCampUser.bio);
    TextEditingController photoTextController =
        TextEditingController(text: devCampUser.profileImageUrl);
    TextEditingController feedbackTextController =
        TextEditingController(text: devCampUser.feedback);

    return AlertDialog(
      title: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    devCampUser.profileImageUrl == null
                        ? 'https://i.pravatar.cc/300'
                        : devCampUser.profileImageUrl!),
                radius: 50,
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 100),
                child: TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    label: const Text('')),
              )
            ],
          ),
          Text(devCampUser.bio == null ? '' : devCampUser.bio!)
        ],
      ),
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameTextController,
                  decoration:
                      buildInputDecoration(label: 'User name', hintText: 'Sam'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: bioTextController,
                  decoration:
                      buildInputDecoration(label: 'Bio', hintText: 'Jeff A.'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: photoTextController,
                  decoration:
                      buildInputDecoration(label: 'User cover', hintText: ''),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      if (acceptedClicked == false) {
                        acceptedClicked = true;
                        userStatus = "accepted";
                      } else {
                        acceptedClicked = false;
                        userStatus = "";
                      }
                    });
                  },
                  icon: const Icon(Icons.bookmark_outline_sharp),
                  label: (devCampUser.userStatus == null)
                      ? (!acceptedClicked)
                          ? const Text('Accept')
                          : Text(
                              'Accepted...',
                              style: TextStyle(color: Colors.blueGrey.shade300),
                            )
                      : Text(
                          'Accepted on: ${formatDate(devCampUser.acceptedOn == null ? devCampUser.nowTimestamp! : devCampUser.acceptedOn!)}')),
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      if (isConfirmedClicked == false) {
                        isConfirmedClicked = true;
                        userStatus = "confirmed";
                      } else {
                        isConfirmedClicked = false;
                        userStatus = "";
                      }
                    });
                  },
                  icon: const Icon(Icons.done),
                  label: (devCampUser.userStatus != null &&
                          devCampUser.userStatus != "confirmed")
                      ? (!isConfirmedClicked)
                          ? const Text('Mark as Confirmed')
                          : const Text(
                              'Confirmed!',
                              style: TextStyle(color: Colors.grey),
                            )
                      : Text(
                          'Confirmed on ${formatDate(devCampUser.confirmedOn == null ? devCampUser.nowTimestamp! : devCampUser.confirmedOn!)}')),
              RatingBar.builder(
                  allowHalfRating: true,
                  initialRating: devCampUser.rating ?? 4.5,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return const Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return const Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return Container();
                    }
                  },
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: feedbackTextController,
                  decoration: buildInputDecoration(
                      label: 'Your thoughts', hintText: 'Enter feedback'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TwoSidedRoundButton(
                    text: 'Update',
                    radius: 12,
                    color: kIconColor,
                    press: () {
                      // Only update if new data was entered
                      final userChangedName =
                          devCampUser.name != nameTextController.text;
                      final userChangedBio =
                          devCampUser.bio != bioTextController.text;
                      final userChangedPhotoUrl = devCampUser.profileImageUrl !=
                          photoTextController.text;

                      final userChangedRating = devCampUser.rating != _rating;
                      final saveUserStatus =
                          (acceptedClicked || isConfirmedClicked)
                              ? userStatus
                              : devCampUser.userStatus;
                      final userUpdate = userChangedName ||
                          userChangedBio ||
                          userChangedRating ||
                          userChangedPhotoUrl ||
                          userChangedBio;
                      if (userUpdate) {
                        DatabaseService().updateUser(
                            devCampUser.id!,
                            nameTextController.text,
                            bioTextController.text,
                            photoTextController.text,
                            _rating,
                            saveUserStatus,
                            (acceptedClicked
                                ? Timestamp.now()
                                : devCampUser.acceptedOn),
                            (isConfirmedClicked
                                ? Timestamp.now()
                                : devCampUser.confirmedOn));
                      }

                      Navigator.of(context).pop();
                    },
                  ),
                  TwoSidedRoundButton(
                    text: 'Delete',
                    radius: 12,
                    color: Colors.red,
                    press: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text(
                                'Once the User is deleted you can\'t retrieve it back.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    usersRef.doc(devCampUser.id).delete();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreenPage(),
                                        ));
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('No'))
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
