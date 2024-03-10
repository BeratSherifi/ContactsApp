import 'dart:typed_data';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactModel {
  final Contact contact;
  final Uint8List? image;
  final String num;

  ContactModel({
    required this.contact,
    required this.image,
    required this.num,
  });
}
