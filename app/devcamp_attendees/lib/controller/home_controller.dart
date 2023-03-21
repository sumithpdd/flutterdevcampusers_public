import 'dart:convert';
import 'package:devcamp_attendees/service/database_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/dev_camp_user.dart';

class HomeController extends GetxController {
  var listUsers = <DevCampUser>[];
  var listWinners = <DevCampUser>[];
  var listAcceptedUsers = <DevCampUser>[];
  var isFavOnly = false;

  @override
  void onReady() {
    onGetUserData();
    super.onReady();
  }

  // void onGetData() async {
  //   final response = await http.get(
  //       //Uri.parse('https://mocki.io/v1/8396dfa6-dc1a-4ff3-8319-56a2d38c47c1'));
  //       Uri.parse(
  //           'https://api.jsonbin.io/v3/b/64158016ace6f33a22f0ee80/latest?meta=false'));

  //   if (response.statusCode == 200) {
  //     list = parseUsers(response.body);
  //     listUsers = list;
  //     update();
  //   } else {
  //     Get.showSnackbar(const GetSnackBar(message: "Error to get users"));
  //   }
  // }

  void onGetUserData() async {
    listUsers = await DatabaseService().getAllUsers();

    update();
  }

  List<DevCampUser> parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed
        .map<DevCampUser>((json) => DevCampUser.fromJson(json))
        .toList();
  }

  onAddFav(int index) {
    if (listUsers[index].isFav != null) {
      if (listUsers[index].isFav!) {
        listUsers[index].isFav = false;
      } else {
        listUsers[index].isFav = true;
      }
    } else {
      listUsers[index].isFav = true;
    }
    update();
  }

  getWinners() {
    listWinners.clear();

    listWinners = listUsers
        .where((user) => user.isWinner != null && user.isWinner!)
        .toList();

    update();
  }

  getAcceptedUser() {
    listAcceptedUsers.clear();

    listAcceptedUsers = listUsers
        // .where(
        //     (user) => user.userStatus != null && user.userStatus == "accepted")
        .toList();
    listAcceptedUsers.sort((usera, userb) =>
        usera.name!.toLowerCase().compareTo(userb.name!.toLowerCase()));

    update();
  }
}
