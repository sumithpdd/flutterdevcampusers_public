import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class HomeController extends GetxController {
  var listUsers = <User>[];
  var listWinners = <User>[];
  var listAcceptedUsers = <User>[];
  var list = <User>[];
  var isFavOnly = false;

  @override
  void onReady() {
    onGetData();
    super.onReady();
  }

  void onGetData() async {
    final response = await http.get(
        //Uri.parse('https://mocki.io/v1/8396dfa6-dc1a-4ff3-8319-56a2d38c47c1'));
        Uri.parse(
            'https://api.jsonbin.io/v3/b/64158016ace6f33a22f0ee80/latest?meta=false'));

    if (response.statusCode == 200) {
      list = parseUsers(response.body);
      listUsers = list;
      update();
    } else {
      Get.showSnackbar(const GetSnackBar(message: "Error to get users"));
    }
  }

  List<User> parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  onIsFavOnly() {
    listUsers.clear();
    if (isFavOnly) {
      isFavOnly = false;
      listUsers.addAll(list);
    } else {
      isFavOnly = true;
      for (var i = 0; i < list.length; i++) {
        if (list[i].isFav != null && list[i].isFav!) {
          listUsers.add(list[i]);
        }
      }
    }
    update();
  }

  onAddFav(int index) {
    if (list[index].isFav != null) {
      if (list[index].isFav!) {
        list[index].isFav = false;
      } else {
        list[index].isFav = true;
      }
    } else {
      list[index].isFav = true;
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
        .where((user) => user.accepted != null && user.accepted == "Yes")
        .toList();
    listAcceptedUsers.sort((usera, userb) =>
        usera.name!.toLowerCase().compareTo(userb.name!.toLowerCase()));

    update();
  }
}
