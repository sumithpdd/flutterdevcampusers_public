// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:change_case/change_case.dart';
import 'package:devcamp_attendees/service/database_service.dart';
import 'package:devcamp_attendees/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/dev_camp_mentor.dart';

class ModifyMentor extends StatefulWidget {
  DevCampMentor devCampMentor;
  ModifyMentor({
    Key? key,
    required this.devCampMentor,
  }) : super(key: key);

  @override
  State<ModifyMentor> createState() {
    return _ModifyMentorState();
  }
}

const apiKey = '';

class _ModifyMentorState extends State<ModifyMentor> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _nameHasError = false;
  bool _emailHasError = false;
  String country = '';
  final TextEditingController _textController = TextEditingController();
  String _textSocial = 'Summary...';
  bool _loading = false;
  late final ChatSession _chat;

  late final GenerativeModel _model;

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
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.0-pro',
      apiKey: apiKey,
    );

    _chat = _model.startChat(history: [
      Content.text(
          "For socal media, please use @gdg_london. and create a post using this transcript"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Mentor Info')),
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
                initialValue: widget.devCampMentor.toMap(),
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
                          // FormBuilderValidators.required(),
                          // FormBuilderValidators.email(),
                          // FormBuilderValidators.max(70),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                        name: "bio",
                        hasError: false,
                        onChanged: (p0) {},
                        validator: null),
                    _buildTextField(
                        name: "sessionTitle",
                        hasError: false,
                        onChanged: (p0) {},
                        validator: null),
                    _buildTextField(
                        name: "sessionTranscript",
                        hasError: false,
                        onChanged: (p0) {},
                        validator: null),
                    const SizedBox(height: 15),
                    _buildTextField(
                        name: "twitterhandle",
                        hasError: false,
                        onChanged: (p0) {},
                        validator: null),
                    _buildTextField(
                        name: "linkedInhandle",
                        hasError: false,
                        onChanged: (p0) {},
                        validator: null),
                    _buildTextField(
                        name: "slackId",
                        hasError: false,
                        onChanged: (p0) {},
                        validator: null),
                    _buildTextField(
                        name: "profileImageUrl",
                        hasError: false,
                        onChanged: (p0) {},
                        validator: null),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.black87),
                            autofocus: true,
                            decoration: ThemeConstants.textFieldDecoration(
                                context, 'transcript...'),
                            controller: _textController,
                            onSubmitted: (String value) {
                              _sendChatMessage(value);
                            },
                          ),
                        ),
                        const SizedBox.square(
                          dimension: 15,
                        ),
                        if (!_loading)
                          IconButton(
                            onPressed: () async {
                              _sendChatMessage(_textController.text);
                            },
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        else
                          const CircularProgressIndicator(),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Markdown(
                            shrinkWrap: true,
                            data: _textSocial,
                            selectable: true,
                          ),
                        ),
                        const SizedBox.square(
                          dimension: 15,
                        ),
                        Expanded(
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildSocialButton(
                                  icon: FontAwesomeIcons.facebookSquare,
                                  color: Color(0xFF0075FC),
                                  onClicked: () => share(SocialMedia.facebook),
                                ),
                                buildSocialButton(
                                  icon: FontAwesomeIcons.twitter,
                                  color: Color(0xFF1da1f2),
                                  onClicked: () => share(SocialMedia.twitter),
                                ),
                                buildSocialButton(
                                  icon: FontAwesomeIcons.linkedin,
                                  color: Color(0xFF0072b1),
                                  onClicked: () => share(SocialMedia.linkedln),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                debugPrint(
                                    _formKey.currentState?.value.toString());
                                DatabaseService().updateMentorJson(
                                    widget.devCampMentor.id!,
                                    _formKey.currentState?.value);
                              } else {
                                debugPrint(
                                    _formKey.currentState?.value.toString());
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      var response = await _chat.sendMessage(
        Content.text(message),
      );
      var text = response.text;

      if (text == null) {
        return;
      } else {
        setState(() {
          _textSocial = text;
          _loading = false;
        });
      }
    } catch (e) {
      print(e.toString());
      _textSocial = e.toString();
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
    }
  }
}

Future share(SocialMedia platform) async {
  final urls = {
    SocialMedia.facebook: ('face book shareable link'),
    SocialMedia.twitter: ('twitter shareable link'),
    SocialMedia.linkedln: ('face book linkedln link')
  };
  final url = urls[platform]!;
  await launchUrl(Uri(path: url));
}

enum SocialMedia { facebook, twitter, linkedln }

Widget buildSocialButton(
        {required IconData icon,
        Color? color,
        required Function() onClicked}) =>
    InkWell(
      child: Container(
        width: 60,
        height: 60,
        child: Center(child: FaIcon(icon, color: color, size: 40)),
      ),
      onTap: onClicked,
    );
