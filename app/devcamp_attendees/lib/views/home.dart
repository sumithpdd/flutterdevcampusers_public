import 'package:devcamp_attendees/views/leaderboard.dart';
import 'package:devcamp_attendees/views/map_screen.dart';
import 'package:devcamp_attendees/views/view_all_attendance.dart';
import 'package:devcamp_attendees/views/view_all_attendees.dart';
import 'package:devcamp_attendees/views/view_all_mentors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => GetBuilder(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(controller.listUsers.isNotEmpty
                  ? "Flutter devcamp users - ${controller.listUsers.length}"
                  : "Getting users"),
              actions: [
                IconButton(
                  onPressed: () {
                    controller.getWinners();
                    controller.getAcceptedUsersForGame();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaderBoard(
                            listWinners: controller.listWinners,
                            gameUsers: controller.listGameUsers),
                      ),
                    );
                  },
                  icon: const Icon(Icons.leaderboard),
                ),
                IconButton(
                  onPressed: () {
                    controller.getAcceptedUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAttendanceAll(
                          devcampusers: controller.listAcceptedUsers,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.show_chart),
                ),
                IconButton(
                  onPressed: () {
                    controller.getAcceptedUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllAttendeesScreen(
                          devcampusers: controller.listAcceptedUsers,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.group_sharp),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAllMentorScreen(
                          devcampmentors: controller.listMentors,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.school_outlined),
                ),
              ],
            ),
            body: SafeArea(
              child: controller.listUsers.isNotEmpty
                  ? MapScreen(listUsers: controller.listUsers)
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
