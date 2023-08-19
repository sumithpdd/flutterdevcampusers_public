// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:change_case/change_case.dart';
import 'package:devcamp_attendees/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:devcamp_attendees/models/dev_camp_user.dart';

import '../util/util.dart';

class ModifyUser extends StatefulWidget {
  DevCampUser devCampUser;
  ModifyUser({
    Key? key,
    required this.devCampUser,
  }) : super(key: key);

  @override
  State<ModifyUser> createState() {
    return _ModifyUserState();
  }
}

class _ModifyUserState extends State<ModifyUser> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _nameHasError = false;
  bool _emailHasError = false;
  var winTextOptions = [
    'Pawan Kumar Flutter Book Code  topmate.io/yourpawan/434748',
    'Jetbrains License',
    'Code with Andrea course codewithandrea.com',
    'Flutter Firebase Festival f3.events'
  ];
  String country = '';
  final _allCountries = [
    'Algeria',
    'Austria',
    'Azerbaijan',
    'Bangladesh',
    'Brazil',
    'Cameroon',
    'Canada',
    'Colombia',
    'Ecuador',
    'Egypt',
    'Ethiopia',
    'Gabon',
    'Germany',
    'Sri Lanka',
    'India',
    'Israel',
    'Kenya',
    'Mexico',
    'Nepal',
    'Nigeria',
    'Pakistan',
    'Philippines',
    'Scotland',
    'Sénégal',
    'Spain',
    'Tanzania',
    'Turkey',
    'UAE',
    'United Kingdom',
    'Ukraine',
    'United States',
    'Uruguay',
  ];

  Geo geo = Geo(lat: '55.378051', lng: '-3.435973');

  void _onChanged(dynamic val) => debugPrint(val.toString());
  _buildTextField(
      {required String name,
      required bool hasError,
      required Function(String?) onChanged,
      required String? Function(String?)? validator}) {
    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.always,
      name: name,
      decoration: InputDecoration(
        labelText: name.toTitleCase(),
        suffixIcon: hasError
            ? const Icon(Icons.error, color: Colors.red)
            : const Icon(Icons.check, color: Colors.green),
      ),
      onChanged: onChanged,
      // valueTransformer: (text) => num.tryParse(text),
      validator: validator,
      textInputAction: TextInputAction.next,
    );
  }

  @override
  void initState() {
    country = widget.devCampUser.address == null
        ? _allCountries.first
        : widget.devCampUser.address!.country!;
    geo = allCountriesWithGeo[country]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Attendee Info')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString());
                },
                autovalidateMode: AutovalidateMode.disabled,
                initialValue: widget.devCampUser.toMap(),
                skipDisabled: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    _buildTextField(
                        name: "name",
                        hasError: _nameHasError,
                        onChanged: (val) {
                          setState(() {
                            _nameHasError = !(_formKey
                                    .currentState?.fields["name"]
                                    ?.validate() ??
                                false);
                          });
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.max(70),
                        ])),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Flexible(
                          child: FormBuilderSwitch(
                            title: const Text('Is Winner'),
                            name: 'isWinner',
                            onChanged: _onChanged,
                          ),
                        ),
                        Flexible(
                          child: FormBuilderDropdown<String>(
                            // autovalidate: true,
                            name: 'winText',
                            decoration: const InputDecoration(
                              labelText: 'Win Text',
                              hintText: 'Select Win Text',
                            ),

                            items: winTextOptions
                                .map((winText) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: winText,
                                      child: Text(winText),
                                    ))
                                .toList(),

                            valueTransformer: (val) => val?.toString(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: FormBuilderSwitch(
                            title: const Text('Session 1'),
                            name: 'session1',
                            onChanged: _onChanged,
                          ),
                        ),
                        Flexible(
                          child: FormBuilderSwitch(
                            title: const Text('Session 2'),
                            name: 'session2',
                            onChanged: _onChanged,
                          ),
                        ),
                        Flexible(
                          child: FormBuilderSwitch(
                            title: const Text('Session 3'),
                            name: 'session3',
                            onChanged: _onChanged,
                          ),
                        ),
                        Flexible(
                          child: FormBuilderSwitch(
                            title: const Text('Session 4'),
                            name: 'session4',
                            onChanged: _onChanged,
                          ),
                        ),
                        Flexible(
                          child: FormBuilderSwitch(
                            title: const Text('Session 5'),
                            name: 'session5',
                            onChanged: _onChanged,
                          ),
                        ),
                        Flexible(
                          child: FormBuilderSwitch(
                            title: const Text('Session 6'),
                            name: 'session6',
                            onChanged: _onChanged,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: "address.street",
                      decoration: InputDecoration(
                        labelText: "street".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "address.city",
                      decoration: InputDecoration(
                        labelText: "city".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderDropdown<String>(
                      name: 'address.country',
                      decoration: const InputDecoration(
                        label: Text('Countries'),
                      ),
                      initialValue: country,
                      onChanged: (value) {
                        setState(() {
                          country = value ?? '';
                          changeGeo();
                        });
                      },
                      items: _allCountries
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                    FormBuilderTextField(
                      name: "address.zipcode",
                      decoration: InputDecoration(
                        labelText: "zipcode".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "address.geo.lat",
                      decoration: InputDecoration(
                        labelText: "lat".toTitleCase(),
                      ),
                      initialValue: geo.lat,
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "address.geo.lng",
                      decoration: InputDecoration(
                        labelText: "lng".toTitleCase(),
                      ),
                      initialValue: geo.lng,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 15),
                    FormBuilderChoiceChip<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration:
                          const InputDecoration(labelText: 'User Status'),
                      name: 'userStatus',
                      selectedColor: Colors.green,
                      options: const [
                        FormBuilderChipOption(
                          value: 'accepted',
                          avatar: Icon(Icons.check_box),
                        ),
                        FormBuilderChipOption(
                          value: 'confirmed',
                          avatar: Icon(Icons.badge),
                        ),
                        FormBuilderChipOption(
                          value: 'certified',
                          avatar: Icon(FontAwesomeIcons.userGraduate),
                        ),
                      ],
                      onChanged: _onChanged,
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: "assignment1link",
                      decoration: InputDecoration(
                        labelText: "assignment 1 link".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "assignment2link",
                      decoration: InputDecoration(
                        labelText: "assignment 2 link".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "assignment3link",
                      decoration: InputDecoration(
                        labelText: "assignment 3 link".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "githubuserid",
                      decoration: InputDecoration(
                        labelText: "Github user id".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "linkedInhandle",
                      decoration: InputDecoration(
                        labelText: "linkedIn handle".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "slackId",
                      decoration: InputDecoration(
                        labelText: "slack Id".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderTextField(
                      name: "twitterhandle",
                      decoration: InputDecoration(
                        labelText: "twitter handle".toTitleCase(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    _buildTextField(
                      name: "email",
                      hasError: _emailHasError,
                      onChanged: (val) {
                        setState(() {
                          _emailHasError = !(_formKey
                                  .currentState?.fields["email"]
                                  ?.validate() ??
                              false);
                        });
                      },
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                          FormBuilderValidators.max(70),
                        ],
                      ),
                    ),
                    FormBuilderTextField(
                      name: "profileImageUrl",
                      decoration: InputDecoration(
                        labelText: "profileImageUrl".toTitleCase(),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          debugPrint(_formKey.currentState?.value.toString());
                          DatabaseService().updateUserJson(
                              widget.devCampUser.id!,
                              _formKey.currentState?.value);
                        } else {
                          debugPrint(_formKey.currentState?.value.toString());
                          debugPrint('validation failed');
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      // color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeGeo() {
    if (allCountriesWithGeo.containsKey(country)) {
      geo = allCountriesWithGeo[country]!;
      _formKey.currentState!.fields['address.geo.lat']!.didChange(geo.lat);
      _formKey.currentState!.fields['address.geo.lng']!.didChange(geo.lng);
    }
  }
}
