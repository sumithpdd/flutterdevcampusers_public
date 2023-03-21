import 'package:devcamp_attendees/views/leaderboard.dart';
import 'package:devcamp_attendees/views/map_screen.dart';
import 'package:devcamp_attendees/views/view_all_attendance.dart';
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaderBoard(
                          listWinners: controller.listWinners,
                        ),
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
                        builder: (context) => ViewAttendanceAllScreen(
                          devcampusers: controller.listAcceptedUsers,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.show_chart),
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
