import 'package:cloud_firestore/cloud_firestore.dart';

class DevCampUser {
  DevCampUser(
      {this.id,
      this.name,
      this.bio,
      this.displayName,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company,
      this.isFav,
      this.isWinner,
      this.winText,
      this.profileImageUrl,
      this.userStatus,
      this.acceptedOn,
      this.confirmedOn,
      this.rating,
      this.session1,
      this.session2,
      this.session3,
      this.session4,
      this.session5,
      this.session6,
      this.assignment1link,
      this.assignment2link,
      this.assignment3link,
      this.githubuserid,
      this.linkedInhandle,
      this.slackId,
      this.twitterhandle,
      this.itexperience,
      this.feedback});
  String? id;
  String? name;
  String? displayName;
  String? email;
  String? bio;
  Address? address;
  String? phone;
  Company? company;
  bool? isFav = false;
  bool? isWinner = false;
  String? profileImageUrl;
  bool? session1, session2, session3, session4, session5, session6 = false;
  String? assignment1link, assignment2link, assignment3link = "";
  String? githubuserid, linkedInhandle, slackId, twitterhandle = "0";
  String? userStatus;
  String? website;
  String? itexperience = "0";
  String? winText;

  double? rating;
  Timestamp? acceptedOn, confirmedOn;
  String? feedback;
  final Timestamp? timestamp = Timestamp.fromDate(DateTime.now());
  DevCampUser.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    displayName = json['displayName'];
    email = json['email'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    isFav = json['is_fav'];
    isWinner = json['isWinner'];
    userStatus = json['userStatus'];
    acceptedOn = json['acceptedOn'];
    confirmedOn = json['confirmedOn'];
    rating = json['rating'];
    winText = json['winText'];
    profileImageUrl = json['profileImageUrl'];
    session1 = json['session1'] ?? false;
    session2 = json['session2'] ?? false;
    session3 = json['session3'] ?? false;
    session4 = json['session4'] ?? false;
    session5 = json['session5'] ?? false;
    session6 = json['session6'] ?? false;
    assignment1link = json['assignment1link'];
    assignment2link = json['assignment2link'];
    assignment3link = json['assignment3link'];
    githubuserid = json['githubuserid'];
    linkedInhandle = json['linkedInhandle'];
    slackId = json['slackId'];
    twitterhandle = json['twitterhandle'];
    itexperience = json['itexperience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['displayName'] = displayName;
    data['email'] = email;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['phone'] = phone;
    data['website'] = website;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['is_fav'] = isFav;

    data['userStatus'] = userStatus;
    data['isWinner'] = isWinner;
    data['winText'] = winText;
    data['profileImageUrl'] = profileImageUrl;
    data['session1'] = session1;
    data['session2'] = session2;
    data['session3'] = session3;
    data['session4'] = session4;
    data['session5'] = session5;
    data['session6'] = session6;

    data['assignment1link'] = assignment1link;
    data['assignment2link'] = assignment2link;
    data['assignment3link'] = assignment3link;
    data['githubuserid'] = githubuserid;
    data['linkedInhandle'] = linkedInhandle;
    data['slackId'] = slackId;
    data['twitterhandle'] = twitterhandle;
    data['itexperience'] = itexperience;
    data['timestamp'] = Timestamp.fromDate(DateTime.now());
    return data;
  }

  factory DevCampUser.fromDoc(DocumentSnapshot doc) {
    final dynamic data = doc.data();

    return DevCampUser(
        id: doc.id,
        name: data['name'],
        profileImageUrl: data['profileImageUrl'],
        email: data['email'],
        bio: data['bio'] ?? "",
        displayName: data['displayname'] ?? "",
        address:
            data['address'] != null ? Address.fromDoc(data['address']) : null,
        phone: data['phone'] ?? "",
        website: data['website'] ?? "",
        company:
            data['company'] != null ? Company.fromDoc(data['company']) : null,
        isFav: data['is_fav'] ?? false,
        isWinner: data['isWinner'] ?? false,
        userStatus: data['userStatus'] ?? "",
        acceptedOn: data['acceptedOn'] ?? Timestamp.fromDate(DateTime.now()),
        confirmedOn: data['confirmedOn'] ?? Timestamp.fromDate(DateTime.now()),
        rating: data['rating'] ?? 2,
        winText: data['winText'] ?? "",
        session1: data['session1'] ?? false,
        session2: data['session2'] ?? false,
        session3: data['session3'] ?? false,
        session4: data['session4'] ?? false,
        session5: data['session5'] ?? false,
        session6: data['session6'] ?? false,
        assignment1link: data['assignment1link'],
        assignment2link: data['assignment2link'],
        assignment3link: data['assignment3link'],
        githubuserid: data['githubuserid'],
        linkedInhandle: data['linkedInhandle'],
        slackId: data['slackId'],
        twitterhandle: data['twitterhandle'],
        itexperience: data['itexperience']);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'displayName': displayName,
      'email': email,
      'address': address!.toMap(),
      'phone': phone,
      'website': website,
      'company': company == null ? company : company!.toMap(),
      'is_fav': isFav,
      'userStatus': userStatus,
      'isWinner': isWinner,
      'winText': winText,
      'profileImageUrl': profileImageUrl,
      'session1': session1,
      'session2': session2,
      'session3': session3,
      'session4': session4,
      'session5': session5,
      'session6': session6,
      'assignment1link': assignment1link,
      'assignment2link': assignment2link,
      'assignment3link': assignment3link,
      'githubuserid': githubuserid,
      'linkedInhandle': linkedInhandle,
      'slackId': slackId,
      'twitterhandle': twitterhandle,
      'itexperience': itexperience,
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

class Address {
  String? street;
  String? suite;
  String? city;
  String? country;
  String? zipcode;
  Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.country,
    this.zipcode,
    this.geo,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    country = json['country'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['country'] = country;

    data['zipcode'] = zipcode;
    if (geo != null) {
      data['geo'] = geo!.toJson();
    }
    return data;
  }

  factory Address.fromDoc(Map<String, dynamic> data) {
    return Address(
        street: data['street'] ?? "",
        suite: data['suite'] ?? "",
        city: data['city'] ?? "",
        country: data['country'] ?? "",
        zipcode: data['zipcode'] ?? "",
        geo: data['geo'] != null ? Geo.fromDoc(data['geo']) : null);
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'suite': suite,
      'city': city,
      'country': country,
      'zipcode': zipcode,
      'geo': geo!.toMap()
    };
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] ?? "";
    lng = json['lng'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'lng': lng};
  }

  factory Geo.fromDoc(Map<String, dynamic> data) {
    return Geo(lat: data['lat'] ?? "", lng: data['lng'] ?? "");
  }
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'catchPhrase': catchPhrase, 'bs': bs};
  }

  factory Company.fromDoc(Map<String, dynamic> data) {
    return Company(
        name: data['name'],
        catchPhrase: data['catchPhrase'] ?? "",
        bs: data['bs'] ?? "");
  }
}
