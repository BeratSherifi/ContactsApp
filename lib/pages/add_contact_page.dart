import 'package:flutter/material.dart';
import 'package:flutter_contactsapp/models/contact.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/properties/email.dart';
import 'package:flutter_contacts/properties/phone.dart';




class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _addContact() async {

    final newContact = Contact()
      ..name.first = _nameController.text
      ..phones = [Phone(_phoneController.text)]
      ..emails = [Email(_emailController.text)];

    
    await newContact.insert();

    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contact added successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact', style: TextStyle(color: Colors.white)),
        toolbarHeight: 100, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addContact,
              child: Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
