import 'package:cloud_firestore/cloud_firestore.dart';

class DevCampUser {
  String? id;
  String? name;
  String? displayName;
  String? email;
  String? bio;
  Address? address;
  String? phone;
  String? website;
  Company? company;
  bool? isFav = false;

  String? userStatus;
  bool? isWinner = false;
  String? profileImageUrl;
  String? winText;
  String? session1;
  String? session2;
  String? session3;
  String? session4;

  final Timestamp? timestamp = Timestamp.fromDate(DateTime.now());

  double? rating;

  Timestamp? acceptedOn;
  Timestamp? confirmedOn;
  DevCampUser({
    this.id,
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
  });

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
    session1 = json['session1'];
    session2 = json['session2'];
    session3 = json['session3'];
    session4 = json['session4'];
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
      session1: data['session1'] ?? "",
      session2: data['session2'] ?? "",
      session3: data['session3'] ?? "",
      session4: data['session4'] ?? "",
    );
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
