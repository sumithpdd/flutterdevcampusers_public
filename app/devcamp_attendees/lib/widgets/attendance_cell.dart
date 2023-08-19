// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:country_flags/country_flags.dart';
import 'package:devcamp_attendees/util/util.dart';
import 'package:devcamp_attendees/widgets/user_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../models/dev_camp_user.dart';
import '../service/database_service.dart';

class AttendanceCell {
  DevCampUser user;
  String propertyName;
  AttendanceCell({
    Key? key,
    required this.user,
    required this.propertyName,
  });

  DataCell generateCells() {
    var data = user.get(propertyName) ?? "";

    if (propertyName == "country") {
      var countryCode = 'us';
      if (allCountriesWithCodes.containsKey(data)) {
        countryCode = allCountriesWithCodes[data]!;
      }
      return DataCell(CountryFlag.fromCountryCode(
        countryCode,
        height: 48,
        width: 62,
        borderRadius: 8,
      ));
    }

    return DataCell((data is bool)
        ? ToggleSwitch(
            minWidth: 100,
            cornerRadius: 20.0,
            customWidths: const [43.0, 43.0],
            initialLabelIndex: data ? 1 : 0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: const ['N', 'Y'],
            icons: const [
              FontAwesomeIcons.x,
              FontAwesomeIcons.checkDouble,
            ],
            activeBgColors: const [
              [Colors.pink],
              [Colors.green],
            ],
            onToggle: (index) {
              DatabaseService()
                  .updateUserAttendance(user, propertyName, index != 0);
            },
          )
        : Text(data));
  }

  actionCell(BuildContext context) {
    return DataCell(SizedBox(
        child: MaterialButton(
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
        showDialog(
          context: context,
          builder: (context) {
            return UserDetailsDialog(
              devcampusers: user,
            );

            // DatabaseService().deleteUser(user.id!);
          },
        );
      },
    )));
  }
}
