// ignore_for_file: prefer_const_constructors

import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../models/dev_camp_user.dart';
import '../models/model_util.dart';
import '../util/navigator.dart';
import '../util/util.dart';
import 'modify_user.dart';

class ViewAllAttendeesScreen extends StatefulWidget {
  final List<DevCampUser> devcampusers;
  const ViewAllAttendeesScreen({
    Key? key,
    required this.devcampusers,
  }) : super(key: key);

  @override
  State<ViewAllAttendeesScreen> createState() => _ViewAllAttendeesScreenState();
}

class _ViewAllAttendeesScreenState extends State<ViewAllAttendeesScreen> {
  List<DevCampUser> searchList = [];
  bool checkBoxListTileIsCheck = false;
  int? userStatusOptionsIndex;
  String searchText = '';
  int resultCount = 0;
  late AttendeeDataSource attendeeDataSource;
  final TextEditingController _controller = TextEditingController();
  final DataGridController _dataGridController = DataGridController();
  @override
  void initState() {
    super.initState();
    _controller.text = searchText;
    _search();
  }

  GridColumn createGridColumn(String columnName) {
    var gridColumn = GridColumn(
        columnName: columnName,
        label: Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              columnName.toTitleCase(),
              overflow: TextOverflow.ellipsis,
            )));
    return gridColumn;
  }

  @override
  Widget build(BuildContext context) {
    //_width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('flutter devcamp mentees - All'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.0,
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                          _search();
                        });
                      },
                      decoration: ThemeConstants.searchFieldDecoration,
                    ),
                  ),
                  ToggleSwitch(
                    minWidth: 120.0,
                    initialLabelIndex: userStatusOptionsIndex,
                    totalSwitches: 3,
                    labels: userStatusOptions,
                    onToggle: (index) {
                      setState(() {
                        userStatusOptionsIndex = index!;
                        _search();
                      });
                    },
                  ),
                  SizedBox(
                    width: 130.0,
                    child: CheckboxListTile(
                        activeColor: Colors.pink[300],
                        dense: true,
                        //font change
                        title: const Text(
                          "reset",
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
                            searchText = '';
                            _controller.text = searchText;
                            userStatusOptionsIndex = null;
                            _search();
                          });
                        }),
                  ),
                  Text(
                    'Total Result $resultCount',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
            Expanded(child: SelectionArea(child: _buildBody(context))),
          ],
        ));
  }

  Widget _buildBody(BuildContext context) {
    return SfDataGrid(
      source: attendeeDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      selectionMode: SelectionMode.single,
      onQueryRowHeight: (details) {
        return details.getIntrinsicRowHeight(details.rowIndex);
      },
      columns: <GridColumn>[
        createGridColumn('name'),
        createGridColumn('userStatus'),
        createGridColumn('isWinner'),
        createGridColumn('winText'),
        createGridColumn('session1'),
        createGridColumn('session2'),
        createGridColumn('session3'),
        createGridColumn('session4'),
        createGridColumn('session5'),
        createGridColumn('session6'),
        createGridColumn('assignment1link'),
        createGridColumn('assignment2link'),
        createGridColumn('assignment3link'),
        createGridColumn('githubuserid'),
        createGridColumn('linkedInhandle'),
        createGridColumn('slackId'),
        createGridColumn('twitterhandle'),
        createGridColumn('itexperience'),
        createGridColumn('phone'),
        createGridColumn('website'),
        // createGridColumn('company'),
        createGridColumn('email'),

        createGridColumn('profileImageUrl'),

        createGridColumn('is_fav'),
        createGridColumn('Actions'),
      ],
      controller: _dataGridController,
    );
  }

  void _search() {
    searchList.clear();
    String userStatusOption = userStatusOptionsIndex != null
        ? userStatusOptions[userStatusOptionsIndex!]
        : '';
    var allusers = (userStatusOption.isNotEmpty)
        ? widget.devcampusers
            .where((user) => user.userStatus == userStatusOption.toLowerCase())
        : widget.devcampusers;

    if (searchText.isEmpty) {
      searchList.addAll(allusers);
    } else {
      searchList.addAll(allusers
          .where((user) =>
              user.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList());
    }
    attendeeDataSource = AttendeeDataSource(
        attendeeData: searchList, dataGridController: _dataGridController);

    resultCount = searchList.length;
    setState(() {});
  }
}

class AttendeeDataSource extends DataGridSource {
  DataGridController dataGridController;
  List<DevCampUser> attendeeData;

  /// Creates the employee data source class with required details.
  AttendeeDataSource({
    required this.attendeeData,
    required this.dataGridController,
  }) {
    _attendeeDataGridRow = attendeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'userStatus', value: e.userStatus),
              DataGridCell<bool>(columnName: 'isWinner', value: e.isWinner),
              DataGridCell<String>(columnName: 'winText', value: e.winText),
              DataGridCell<bool>(columnName: 'session1', value: e.session1),
              DataGridCell<bool>(columnName: 'session2', value: e.session2),
              DataGridCell<bool>(columnName: 'session3', value: e.session3),
              DataGridCell<bool>(columnName: 'session4', value: e.session4),
              DataGridCell<bool>(columnName: 'session5', value: e.session5),
              DataGridCell<bool>(columnName: 'session6', value: e.session6),
              DataGridCell<String>(
                  columnName: 'assignment1link', value: e.assignment1link),
              DataGridCell<String>(
                  columnName: 'assignment2link', value: e.assignment2link),
              DataGridCell<String>(
                  columnName: 'assignment3link', value: e.assignment3link),
              DataGridCell<String>(
                  columnName: 'githubuserid', value: e.githubuserid),
              DataGridCell<String>(
                  columnName: 'linkedInhandle', value: e.linkedInhandle),
              DataGridCell<String>(columnName: 'slackId', value: e.slackId),
              DataGridCell<String>(
                  columnName: 'twitterhandle', value: e.twitterhandle),
              DataGridCell<String>(
                  columnName: 'itexperience', value: e.itexperience),
              DataGridCell<String>(columnName: 'phone', value: e.phone),
              DataGridCell<String>(columnName: 'website', value: e.website),
              // DataGridCell<String?>(
              //     columnName: 'company', value: e.company!.name),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(
                  columnName: 'profileImageUrl', value: e.profileImageUrl),

              DataGridCell<bool>(columnName: 'is_fav', value: e.isFav),
              DataGridCell<String>(columnName: 'Actions', value: e.id)
            ]))
        .toList();
  }

  Widget getAttendanceWidget(bool data) {
    return (data)
        ? Icon(FontAwesomeIcons.toggleOn, color: Colors.green)
        : Icon(FontAwesomeIcons.toggleOff, color: Colors.red);
  }

  Widget getUserStatusWidget(String data) {
    return (data.toLowerCase() == 'accepted')
        ? Icon(Icons.check_box, color: Colors.grey)
        : (data.toLowerCase() == 'confirmed')
            ? Icon(Icons.badge, color: Colors.green)
            : (data.toLowerCase() == 'certified')
                ? Icon(FontAwesomeIcons.userGraduate, color: Colors.blue)
                : Text(data);
  }

  Widget getWinnerWidget(bool data) {
    return (data)
        ? Icon(FontAwesomeIcons.trophy, color: Colors.blue)
        : Icon(FontAwesomeIcons.faceSadTear, color: Colors.red);
  }

  List<DataGridRow> _attendeeDataGridRow = [];

  @override
  List<DataGridRow> get rows => _attendeeDataGridRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName.toString().startsWith("session")) {
        return getAttendanceWidget(dataGridCell.value);
      }
      if (dataGridCell.columnName.toString().startsWith("Actions")) {
        return actionCell(dataGridCell.value);
      }
      if (dataGridCell.columnName.toString().startsWith("userStatus")) {
        return getUserStatusWidget(dataGridCell.value.toString());
      }
      if (dataGridCell.columnName.toString().startsWith("isWinner")) {
        return getWinnerWidget(dataGridCell.value);
      }
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }

  Widget actionCell(String value) {
    return MaterialButton(
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Text(
        'info',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        //SelectedIndex
        var devcampuser =
            attendeeData.firstWhere((devcampuser) => devcampuser.id == value);

        Nav.route(NavigationService.navigatorKey.currentContext!,
            ModifyUser(devCampUser: devcampuser));
        // DatabaseService().deleteUser(user.id!);
      },
    );
  }
}
