import 'dart:math';

import 'package:flutter/material.dart';

import '../models/luck.dart';
import 'arrow_view.dart';

class BoardView extends StatefulWidget {
  const BoardView(
      {super.key,
      required this.angle,
      required this.current,
      required this.items});
  final double angle;
  final double current;
  final List<Luck> items;

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  Size get size => Size(MediaQuery.of(context).size.width * 0.8,
      MediaQuery.of(context).size.width * 0.8);

  double _rotote(int index) => (index / widget.items.length) * 2 * pi;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        //shadow
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black38)]),
        ),
        Transform.rotate(
          angle: -(widget.current + widget.angle) * 2 * pi,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              for (var luck in widget.items) ...[_buildCard(luck)],
              for (var luck in widget.items) ...[_buildImage(luck)],
            ],
          ),
        ),
        SizedBox(
          height: size.height,
          width: size.width,
          child: ArrowView(),
        ),
      ],
    );
  }

  _buildCard(Luck luck) {
    var rotate = _rotote(widget.items.indexOf(luck));
    var angle = 2 * pi / widget.items.length;
    return Transform.rotate(
      angle: rotate,
      child: ClipPath(
        clipper: _LuckPath(angle),
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [luck.color, luck.color.withOpacity(0)])),
        ),
      ),
    );
  }

  _buildImage(Luck luck) {
    var rotate = _rotote(widget.items.indexOf(luck));
    return Transform.rotate(
      angle: rotate,
      child: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints:
              BoxConstraints.expand(height: size.height / 3, width: 44),
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: <Widget>[
                Text(
                  luck.point.toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LuckPath extends CustomClipper<Path> {
  final double angle;

  _LuckPath(this.angle);

  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset center = size.center(Offset.zero);
    Rect rect = Rect.fromCircle(center: center, radius: size.width / 2);
    path.moveTo(center.dx, center.dy);
    path.arcTo(rect, -pi / 2 - angle / 2, angle, false);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_LuckPath oldClipper) {
    return angle != oldClipper.angle;
  }
}
