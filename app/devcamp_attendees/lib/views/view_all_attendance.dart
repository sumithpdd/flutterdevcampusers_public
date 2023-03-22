import 'package:flutter/material.dart';

import '../models/dev_camp_user.dart';
import '../util/util.dart';
import '../widgets/attendance_cell.dart';

class ViewAttendanceAll extends StatelessWidget {
  final List<DevCampUser> devcampusers;
  const ViewAttendanceAll({
    Key? key,
    required this.devcampusers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewAttendanceAllScreen(
        devcampusers: devcampusers,
      ),
    );
  }
}

class ViewAttendanceAllScreen extends StatefulWidget {
  final List<DevCampUser> devcampusers;
  const ViewAttendanceAllScreen({
    Key? key,
    required this.devcampusers,
  }) : super(key: key);

  @override
  State<ViewAttendanceAllScreen> createState() =>
      _ViewAttendanceAllScreenState();
}

class _ViewAttendanceAllScreenState extends State<ViewAttendanceAllScreen> {
  late double _height;
  List<DevCampUser>? _searchList = [];
  bool checkBoxListTileIsCheck = false;
  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    //_width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('flutter devcamp mentees - Attendance'),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       DatabaseService().saveUsers(_searchList).then(
          //           (value) =>
          //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //                 content: Text("migrate $value"),
          //               )));
          //     },
          //     icon: const Icon(Icons.save_sharp),
          //   ),
          // ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 50,
                right: 50,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.0,
                    child: TextField(
                      onChanged: (value) {
                        _search(value);
                      },
                      decoration: ThemeConstants.searchFieldDecoration,
                    ),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: CheckboxListTile(
                        activeColor: Colors.pink[300],
                        dense: true,
                        //font change
                        title: const Text(
                          "Show confirmed",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        value: checkBoxListTileIsCheck,
                        onChanged: (
                          bool? val,
                        ) {
                          setState(() {
                            checkBoxListTileIsCheck = val!;
                            _search('');
                          });
                        }),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _buildBody(context))),
            ),
          ],
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        DataTable(
          columnSpacing: 45,
          columns: generateColumns([
            'NAME',
            "SESSION 1",
            "SESSION 2",
            "SESSION 3",
            "SESSION 4",
            " Actions"
          ]),
          rows: _searchList!.map((user) => generateRows(user)).toList(),
        ),
      ],
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

  DataRow generateRows(DevCampUser devcampuser) {
    return DataRow(cells: [
      AttendanceCell(
        user: devcampuser,
        propertyName: "name",
      ).generateCells(),
      AttendanceCell(user: devcampuser, propertyName: "session1")
          .generateCells(),
      AttendanceCell(user: devcampuser, propertyName: "session2")
          .generateCells(),
      AttendanceCell(user: devcampuser, propertyName: "session3")
          .generateCells(),
      AttendanceCell(
        user: devcampuser,
        propertyName: "session4",
      ).generateCells(),
      AttendanceCell(
        user: devcampuser,
        propertyName: "",
      ).actionCell(context)
    ]);
  }

  void _search(String value) {
    _searchList!.clear();
    var allusers = (checkBoxListTileIsCheck)
        ? widget.devcampusers.where((user) => user.userStatus == 'confirmed')
        : widget.devcampusers;

    if (value.isEmpty) {
      _searchList!.addAll(allusers);
    } else {
      _searchList!.addAll(allusers
          .where(
              (user) => user.name!.toLowerCase().contains(value.toLowerCase()))
          .toList());
    }

    setState(() {});
  }
}
