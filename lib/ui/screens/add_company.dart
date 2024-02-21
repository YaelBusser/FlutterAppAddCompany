import 'package:first_app/models/address.dart';
import 'package:first_app/ui/screens/search_address.dart';
import 'package:flutter/material.dart';
import 'package:first_app/models/company.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/company_cubit.dart';

class AddCompany extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  Address? _address;
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
                    _address = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchAddress()),
                    );
                    if (_address != null) {
                      _addressController.text =
                          '${_address?.street}, ${_address?.postCode} ${_address?.city}';
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _address != null) {
                      final String name = _nameController.text;
                      final Company company = Company(name, _address!);
                      context.read<CompanyCubit>().addCompany(company);
                      Navigator.of(context).pop();
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
