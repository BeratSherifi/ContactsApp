import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_contactsapp/models/contact.dart';
import 'contact_details_page.dart';
import 'add_contact_page.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ContactModel>? contacts;

  @override
  void initState() {
    super.initState();
    getContact();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      final contactsData = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        contacts = contactsData
            .map((contact) => ContactModel(
          contact: contact,
          image: contact.photo,
          num: contact.phones.isNotEmpty ? contact.phones.first.number : "--",
        ))
            .toList();
      });
    }
  }

  void navigateToAddContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddContactPage()),
    ).then((value) {
      getContact();
    });
  }

  void navigateToList() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contacts App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        toolbarHeight: 200, 
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _SearchDelegate(contacts ?? [], () {
                  setState(() {});
                }),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: navigateToAddContact,
          ),
        ],
      ),

      body: contacts == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: contacts!.length,
        itemBuilder: (BuildContext context, int index) {
          final contact = contacts![index];
          return ListTile(
            tileColor: Colors.grey[900], 
            leading: CircleAvatar(
              backgroundColor: Colors.orange, 
              child: (contact.image == null)
                  ? const Icon(Icons.person, color: Colors.black)
                  : null,
              backgroundImage: contact.image != null ? MemoryImage(contact.image!) : null,
            ),
            title: Text(
              "${contact.contact.name.first} ${contact.contact.name.last}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            subtitle: Text(
              contact.num,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailsPage(
                    contact: contact,
                    onDelete: () {
                      setState(() {
                        contacts!.removeAt(index);
                      });
                      navigateToList(); 
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _SearchDelegate extends SearchDelegate<String> {
  final List<ContactModel> contacts;
  final VoidCallback onUpdate;

  _SearchDelegate(this.contacts, this.onUpdate);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        toolbarHeight: 100, 
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey[850],
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? contacts
        : contacts
        .where((contact) =>
        '${contact.contact.name.first} ${contact.contact.name.last}'.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final contact = suggestionList[index];
        return ListTile(
          tileColor: Colors.grey[900], 
          leading: CircleAvatar(
            backgroundColor: Colors.orange, 
            child: (contact.image == null)
                ? const Icon(Icons.person, color: Colors.black)
                : null,
            backgroundImage: contact.image != null ? MemoryImage(contact.image!) : null,
          ),
          title: Text(
            '${contact.contact.name.first} ${contact.contact.name.last}',
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(contact.num, style: const TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetailsPage(
                  contact: contact,
                  onDelete: () {
                    onUpdate();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
