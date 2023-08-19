// ignore_for_file: prefer_const_constructors

import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/dev_camp_mentor.dart';
import '../util/navigator.dart';
import '../util/util.dart';
import 'modify_mentor.dart';

class ViewAllMentorScreen extends StatefulWidget {
  final List<DevCampMentor> devcampmentors;
  const ViewAllMentorScreen({
    Key? key,
    required this.devcampmentors,
  }) : super(key: key);

  @override
  State<ViewAllMentorScreen> createState() => _ViewAllMentorScreenState();
}

class _ViewAllMentorScreenState extends State<ViewAllMentorScreen> {
  List<DevCampMentor> searchList = [];
  bool checkBoxListTileIsCheck = false;
  int? mentorStatusOptionsIndex;
  String searchText = '';
  int resultCount = 0;
  late MentorDataSource attendeeDataSource;
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
          title: const Text('flutter devcamp Mentor - All'),
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
                            mentorStatusOptionsIndex = null;
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
        createGridColumn('bio'),
        createGridColumn('email'),
        createGridColumn('sessionTitle'),
        createGridColumn('sessionTranscript'),
        createGridColumn('sessionTranscriptSummary'),
        createGridColumn('twitterhandle'),
        createGridColumn('linkedInhandle'),
        createGridColumn('slackId'),
        createGridColumn('profileImageUrl'),
        createGridColumn('Actions'),
      ],
      controller: _dataGridController,
    );
  }

  void _search() {
    searchList.clear();

    var allmentors = widget.devcampmentors;

    if (searchText.isEmpty) {
      searchList.addAll(allmentors);
    } else {
      searchList.addAll(allmentors
          .where((mentor) =>
              mentor.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList());
    }
    attendeeDataSource = MentorDataSource(
        attendeeData: searchList, dataGridController: _dataGridController);

    resultCount = searchList.length;
    setState(() {});
  }
}

class MentorDataSource extends DataGridSource {
  DataGridController dataGridController;
  List<DevCampMentor> attendeeData;

  /// Creates the employee data source class with required details.
  MentorDataSource({
    required this.attendeeData,
    required this.dataGridController,
  }) {
    _attendeeDataGridRow = attendeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'bio', value: e.bio),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(
                  columnName: 'sessionTitle', value: e.sessionTitle),
              DataGridCell<String>(
                  columnName: 'sessionTranscript', value: e.sessionTranscript),
              DataGridCell<String>(
                  columnName: 'sessionTranscriptSummary',
                  value: e.sessionTranscriptSummary),
              DataGridCell<String>(
                  columnName: 'twitterhandle', value: e.twitterhandle),
              DataGridCell<String>(
                  columnName: 'linkedInhandle', value: e.linkedInhandle),
              DataGridCell<String>(columnName: 'slackId', value: e.slackId),
              DataGridCell<String>(
                  columnName: 'profileImageUrl', value: e.profileImageUrl),
              DataGridCell<String>(columnName: 'Actions', value: e.id)
            ]))
        .toList();
  }

  Widget getAttendanceWidget(bool data) {
    return (data)
        ? Icon(FontAwesomeIcons.toggleOn, color: Colors.green)
        : Icon(FontAwesomeIcons.toggleOff, color: Colors.red);
  }

  List<DataGridRow> _attendeeDataGridRow = [];

  @override
  List<DataGridRow> get rows => _attendeeDataGridRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName.toString().startsWith("Actions")) {
        return actionCell(dataGridCell.value);
      }

      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          dataGridCell.value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
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
        var devcampmentor = attendeeData
            .firstWhere((devcampmentor) => devcampmentor.id == value);

        Nav.route(NavigationService.navigatorKey.currentContext!,
            ModifyMentor(devCampMentor: devcampmentor));
        // DatabaseService().deleteMentor(mentor.id!);
      },
    );
  }
}
