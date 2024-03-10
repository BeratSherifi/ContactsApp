import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact.dart';

class ContactDetailsPage extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onDelete;

  const ContactDetailsPage({
    Key? key,
    required this.contact,
    required this.onDelete,
  }) : super(key: key);

  void _deleteContact(BuildContext context) async {
    await contact.contact.delete();
    onDelete();
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${contact.contact.name.first} ${contact.contact.name.last}",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        toolbarHeight: 100, 
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.orange),
            onPressed: () {
              String? num = contact.contact.phones.isNotEmpty ? contact.contact.phones.first.number : null;
              if (num != null) {
                launch('tel: $num'); 
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.orange),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Delete Contact", style: TextStyle(color: Colors.white)),
                content: Text("Are you sure you want to delete this contact?", style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.black,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel", style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () => _deleteContact(context),
                    child: Text("Delete", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact.image != null)
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: CircleAvatar(
                  backgroundImage: MemoryImage(contact.image!),
                  radius: 50,
                ),
              ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.orange),
              title: Text(
                'Phone',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                '${contact.contact.phones.isNotEmpty ? contact.contact.phones.first.number : "N/A"}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.orange),
              title: Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                '${contact.contact.emails.isNotEmpty ? contact.contact.emails.first.address : "N/A"}',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.orange),
              title: Text(
                'Contact Type',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                '${contact.contact.groups.isNotEmpty ? contact.contact.groups.first.name : "N/A"}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
