import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final usersRef = _db.collection('devcampusers');
final FirebaseStorage _storage = FirebaseStorage.instance;
final storageRef = _storage.ref();
