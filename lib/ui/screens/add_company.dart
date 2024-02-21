import 'package:first_app/models/address.dart';
import 'package:first_app/ui/screens/search_address.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/company.dart';

class AddCompany extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  Address? address;
  AddCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une entreprise'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Nom de l\'entreprise',
                    filled: true,
                    errorStyle: TextStyle(color: Color.fromRGBO(120, 9, 9, 1)),
                    fillColor: Color.fromRGBO(0, 0, 0, .05),
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.business)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Le nom de l'entreprise est vide.";
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _addressController,
                  readOnly: true,
                  decoration: const InputDecoration(
                      labelText: 'Adresse de l\'entreprise',
                      filled: true,
                      errorStyle:
                          TextStyle(color: Color.fromRGBO(120, 9, 9, 1)),
                      fillColor: Color.fromRGBO(0, 0, 0, .05),
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.location_on)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "L'adresse de l'entreprise est vide.";
                    }
                    return null;
                  },
                  onTap: () async {
                    address = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchAddress()),
                    );
                    if (address != null) {
                      _addressController.text =
                          '${address?.street}, ${address?.postCode} ${address?.city}';
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final newCompany = Company(
                          _nameController.text,
                          address as Address);
                      Navigator.pop(context, newCompany);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Colors.transparent))),
                  child: const Text(
                    'Ajouter une nouvelle entreprise',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
