// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors

import 'package:devcamp_attendees/widgets/wheel.dart';
import 'package:flutter/material.dart';

import '../models/dev_camp_user.dart';

class LeaderBoard extends StatelessWidget {
  List<DevCampUser> listWinners;
  List<DevCampUser> gameUsers;
  LeaderBoard({
    Key? key,
    required this.listWinners,
    required this.gameUsers,
  }) : super(key: key);

  int i = 0;

  Color my = Colors.brown, checkMyColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    var r = const TextStyle(color: Colors.purpleAccent, fontSize: 34);
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image(
                          image: AssetImage(
                              'assets/Flutter_Devcamp-logos_transparent.png')),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15.0, top: 10.0),
                      child: RichText(
                          text: const TextSpan(
                              text: "Leader",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                              children: [
                            TextSpan(
                                text: " Board",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold))
                          ])),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Flutter DevCamp Special 2023 Winner Board: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/win_flutterbook.png'))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Image(
                                image: AssetImage('assets/images/win_f3.png'),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image(
                            image: AssetImage(
                                'assets/images/win_codewithandrea.png'),
                          )),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: listWinners.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: i == 0
                                        ? Colors.amber
                                        : i == 1
                                            ? Colors.grey
                                            : i == 2
                                                ? Colors.brown
                                                : Colors.white,
                                    width: 3.0,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5.0)),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: (listWinners[
                                                                          index]
                                                                      .profileImageUrl ==
                                                                  null)
                                                              ? const AssetImage(
                                                                  'assets/Flutter_Devcamp-logos_transparent.png')
                                                              : (listWinners[
                                                                          index]
                                                                      .profileImageUrl!
                                                                      .isEmpty)
                                                                  ? const AssetImage(
                                                                          'assets/Flutter_Devcamp-logos_transparent.png')
                                                                      as ImageProvider
                                                                  : NetworkImage(
                                                                      listWinners[
                                                                              index]
                                                                          .profileImageUrl!),
                                                          fit: BoxFit.fill)))),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                listWinners[index].name!,
                                                style: const TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontWeight:
                                                        FontWeight.w200),
                                                maxLines: 6,
                                              )),
                                          Text(listWinners[index].winText!),
                                        ],
                                      ),
                                    ),
                                    Flexible(child: Container()),
                                    i == 0
                                        ? Text("🥇", style: r)
                                        : i == 1
                                            ? Text(
                                                "🥈",
                                                style: r,
                                              )
                                            : i == 2
                                                ? Text(
                                                    "🥉",
                                                    style: r,
                                                  )
                                                : const Text(''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                      // } else {
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // }
                    }),
              ),
              Flexible(child: WhellFortune(gameUsers: gameUsers))
            ],
          ),
        ),
      ],
    );
  }
}
