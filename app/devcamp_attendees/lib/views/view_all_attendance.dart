import 'package:flutter/material.dart';

import '../models/user.dart';

class ViewAttendanceAll extends StatelessWidget {
  final List<User> users;
  const ViewAttendanceAll({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewAttendanceAllScreen(
        users: users,
      ),
    );
  }
}

class ViewAttendanceAllScreen extends StatefulWidget {
  final List<User> users;
  const ViewAttendanceAllScreen({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  State<ViewAttendanceAllScreen> createState() =>
      _ViewAttendanceAllScreenState();
}

class _ViewAttendanceAllScreenState extends State<ViewAttendanceAllScreen> {
  late double _height;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    //_width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('flutter devcamp mentees - Attendance'),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: _buildBody(context))));
  }

  Widget _buildBody(BuildContext context) {
    return DataTable(
      columnSpacing: 45,
      columns: generateColumns(
          ['NAME', "SESSION 1", "SESSION 2", "SESSION 3", "SESSION 4"]),
      rows: widget.users.map((user) => generateRows(user)).toList(),
    );
  }

  List<DataColumn> generateColumns(List columns) {
    return columns
        .map((data) => DataColumn(
                label: Center(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(data,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: _height / 80),
              ],
            ))))
        .toList();
  }

  DataRow generateRows(User user) {
    return DataRow(cells: [
      generateCells(user.name!),
      generateCells(user.session1 ?? ""),
      generateCells(user.session2 ?? ""),
      generateCells(user.session3 ?? ""),
      generateCells(user.session4 ?? ""),
    ]);
  }

  DataCell generateCells(String data) {
    return DataCell(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (data == '1')
            ? const Icon(Icons.check_circle_outlined, color: Colors.green)
            : (data == '0')
                ? const Icon(Icons.close, color: Colors.redAccent)
                : Text(data),
      ],
    ));
  }
}
