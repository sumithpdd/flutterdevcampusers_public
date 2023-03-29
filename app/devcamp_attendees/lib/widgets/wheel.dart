import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/dev_camp_user.dart';
import '../models/luck.dart';
import '../util/navigator.dart';
import '../views/home.dart';
import 'board_view.dart';

class WhellFortune extends StatefulWidget {
  final List<DevCampUser> gameUsers;
  const WhellFortune({super.key, required this.gameUsers});

  @override
  State<WhellFortune> createState() => _WhellFortuneState(gameUsers);
}

class _WhellFortuneState extends State<WhellFortune>
    with SingleTickerProviderStateMixin {
  List<DevCampUser> gameUsers;
  _WhellFortuneState(this.gameUsers);
  double _angle = 0;
  double _current = 0;
  late AnimationController _ctrl;
  late Animation _ani;
  final List<Color> _colors = [
    const Color(0xFF9F6083),
    const Color(0xFFFDB78B),
    const Color(0xFF57CFE2),
    const Color(0xFF606B7E),
    const Color(0xFF24ACE9),
    const Color(0xFFFB7C7A),
    const Color(0xFF1BD3AC),
    const Color(0xFFa73737),
  ];
  final List<Luck> _items = [];

  void _createList() {
    // _items.addAll([
    //   Luck("apple", _colors[Random().nextInt(_colors.length - 1)],
    //       gameUsers[0].name!),
    //   Luck("raspberry", _colors[Random().nextInt(_colors.length - 1)],
    //       gameUsers[1].name!),
    //   Luck("grapes", _colors[Random().nextInt(_colors.length - 1)],
    //       gameUsers[2].name!),
    //   Luck("fruit", _colors[Random().nextInt(_colors.length - 1)],
    //       gameUsers[3].name!),
    // ]);
    for (var user in gameUsers) {
      _items.add(Luck(
          "apple", _colors[Random().nextInt(_colors.length - 1)], user.name!));
    }
  }

  @override
  void initState() {
    super.initState();
    _createList();
    var duration = const Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/wheel.jpg"),
          fit: BoxFit.cover,
        ),
      ),
//        decoration: BoxDecoration(
//            gradient: LinearGradient(
//                begin: Alignment.topCenter,
//                end: Alignment.bottomCenter,
//                colors: [Color(0xCCf857a6), Color(0xCCff5858)])),
      child: AnimatedBuilder(
          animation: _ani,
          builder: (context, child) {
            final value = _ani.value;
            final angle = value * _angle;
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: Text(
                      "Flutter DevCamp Wheel",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                BoardView(items: _items, current: _current, angle: angle),
                _buildGo(),
                _buildResult(value),
              ],
            );
          }),
    );
  }

  _buildGo() {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _animation,
        child: Container(
          alignment: Alignment.center,
          height: 84,
          width: 84,
          child: const Text(
            "START",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  _animation() {
    if (!_ctrl.isAnimating) {
      var random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + random);
        _current = _current - _current ~/ 1;
        _alert(context); //end whell
        _ctrl.reset();
      });
    }
  }

  _alert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: const TextStyle(fontWeight: FontWeight.bold),
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: const TextStyle(
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.none,
      title: "Winner",
      desc: "You have won!!.",
      buttons: [
        DialogButton(
          onPressed: () => {}, // => Nav.route(context, const Home()),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Home",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }

  int _calIndex(value) {
    var base = (2 * pi / _items.length / 2) / (2 * pi);
    return (((base + value) % 1) * _items.length).floor();
  }

  _buildResult(value) {
    var index = _calIndex(value * _angle + _current);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _items[index].point,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.amber,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ), //gosterim
      ),
    );
  }
}
