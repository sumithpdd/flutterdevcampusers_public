import 'package:cloud_firestore/cloud_firestore.dart';

class DevCampMentor {
  DevCampMentor({
    this.id,
    this.name,
    this.bio,
    this.email,
    this.profileImageUrl,
    this.sessionTitle,
    this.sessionTranscript,
    this.sessionTranscriptSummary,
    this.twitterhandle,
    this.linkedInhandle,
    this.slackId,
  });
  String? id;
  String? name;
  String? email;
  String? bio;
  String? sessionTitle, sessionTranscript, sessionTranscriptSummary = "";
  String? profileImageUrl;
  String? twitterhandle;
  String? linkedInhandle;
  String? slackId;
  final Timestamp? nowTimestamp = Timestamp.fromDate(DateTime.now());

  DevCampMentor.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    bio = json['bio'];
    email = json['email'];

    profileImageUrl = json['profileImageUrl'];
    sessionTitle = json['sessionTitle'] ?? '';
    sessionTranscript = json['sessionTranscript'] ?? '';
    sessionTranscriptSummary = json['sessionTranscriptSummary'] ?? '';
    twitterhandle = json['twitterhandle'];
    linkedInhandle = json['linkedInhandle'];
    slackId = json['slackId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['bio'] = bio;
    data['email'] = email;
    data['profileImageUrl'] = profileImageUrl;
    data['sessionTitle'] = sessionTitle;
    data['sessionTranscript'] = sessionTranscript;
    data['sessionTranscriptSummary'] = sessionTranscriptSummary;
    data['twitterhandle'] = twitterhandle;
    data['linkedInhandle'] = linkedInhandle;
    data['slackId'] = slackId;
    data['timestamp'] = Timestamp.fromDate(DateTime.now());
    return data;
  }

  factory DevCampMentor.fromDoc(DocumentSnapshot doc) {
    final dynamic data = doc.data();

    return DevCampMentor(
      id: doc.id,
      name: data['name'],
      profileImageUrl: data['profileImageUrl'],
      email: data['email'],
      bio: data['bio'] ?? "",
      sessionTitle: data['sessionTitle'] ?? '',
      sessionTranscript: data['sessionTranscript'] ?? '',
      sessionTranscriptSummary: data['sessionTranscriptSummary'] ?? '',
      twitterhandle: data['twitterhandle'] ?? '',
      linkedInhandle: data['linkedInhandle'] ?? '',
      slackId: data['slackId'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'sessionTitle': sessionTitle,
      'sessionTranscript': sessionTranscript,
      'sessionTranscriptSummary': sessionTranscriptSummary,
      'twitterhandle': twitterhandle,
      'linkedInhandle': linkedInhandle,
      'slackId': slackId,
      'timestamp': Timestamp.fromDate(DateTime.now())
    };
  }

  dynamic get(String propertyName) {
    var mapRep = toMap();

    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}
