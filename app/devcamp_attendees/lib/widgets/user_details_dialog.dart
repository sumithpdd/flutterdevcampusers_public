import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devcamp_attendees/service/constants.dart';
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
  late double _rating;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTextController =
        TextEditingController(text: widget.devcampusers.name);
    TextEditingController bioTextController =
        TextEditingController(text: widget.devcampusers.bio);
    TextEditingController photoTextController =
        TextEditingController(text: widget.devcampusers.profileImageUrl);

    return AlertDialog(
      title: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage:
                    NetworkImage(widget.devcampusers.profileImageUrl!),
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
          Text(widget.devcampusers.bio!)
        ],
      ),
      content: Form(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameTextController,
                    decoration: buildInputDecoration(
                        label: 'User name', hintText: 'Sam'),
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
                    onPressed: widget.devcampusers.userStatus == null
                        ? () {
                            setState(() {
                              if (acceptedClicked == false) {
                                acceptedClicked = true;
                              } else {
                                acceptedClicked = false;
                              }
                            });
                          }
                        : null,
                    icon: const Icon(Icons.bookmark_outline_sharp),
                    label: (widget.devcampusers.userStatus == null)
                        ? (!acceptedClicked)
                            ? const Text('Accept')
                            : Text(
                                'Accepted...',
                                style:
                                    TextStyle(color: Colors.blueGrey.shade300),
                              )
                        : Text(
                            'Accepted on: ${formatDate(widget.devcampusers.acceptedOn!)}')),
                TextButton.icon(
                    onPressed: widget.devcampusers.userStatus == null
                        ? () {
                            setState(() {
                              if (isConfirmedClicked == false) {
                                isConfirmedClicked = true;
                              } else {
                                isConfirmedClicked = false;
                              }
                            });
                          }
                        : null,
                    icon: const Icon(Icons.done),
                    label: (widget.devcampusers.userStatus == null)
                        ? (!isConfirmedClicked)
                            ? const Text('Mark as Confirmed')
                            : const Text(
                                'Confirmed!',
                                style: TextStyle(color: Colors.grey),
                              )
                        : Text(
                            'Finished on ${formatDate(widget.devcampusers.confirmedOn!)}')),
                RatingBar.builder(
                    allowHalfRating: true,
                    initialRating: widget.devcampusers.rating ?? 4.5,
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
                    controller: bioTextController,
                    decoration: buildInputDecoration(
                        label: 'Your thoughts', hintText: 'Enter bio'),
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
                            widget.devcampusers.name != nameTextController.text;
                        final userChangedBio =
                            widget.devcampusers.bio != bioTextController.text;
                        final userChangedPhotoUrl =
                            widget.devcampusers.profileImageUrl !=
                                photoTextController.text;

                        final userChangedRating =
                            widget.devcampusers.rating != _rating;

                        final userUpdate = userChangedName ||
                            userChangedBio ||
                            userChangedRating ||
                            userChangedPhotoUrl ||
                            userChangedBio;
                        if (userUpdate) {
                          usersRef
                              .doc(widget.devcampusers.id)
                              .update(DevCampUser(
                                name: nameTextController.text,
                                bio: bioTextController.text,
                                profileImageUrl: photoTextController.text,
                                rating: _rating,
                                acceptedOn: acceptedClicked
                                    ? Timestamp.now()
                                    : widget.devcampusers.acceptedOn,
                                confirmedOn: isConfirmedClicked
                                    ? Timestamp.now()
                                    : widget.devcampusers.confirmedOn,
                              ).toMap());
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
                                      usersRef
                                          .doc(widget.devcampusers.id)
                                          .delete();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreenPage(),
                                          ));
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
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
      ),
    );
  }
}
