import 'package:first_app/models/address.dart';
import 'package:flutter/material.dart';

import '../../models/company.dart';
import 'add_company.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Company> _companies = [
    const Company(
        'Entreprise 1', Address("5 rue principale", "Châtelain", "53200", "41.40338, 2.17403")),
    const Company(
        'Entreprise 2', Address("5 rue principale", "Châtelain", "53200", "41.40338, 2.17403")),
    const Company(
        'Entreprise 3', Address("5 rue principale", "Châtelain", "53200", "41.40338, 2.17403")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des entreprises'),
        ),
        body: ListView.builder(
          itemCount: _companies.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_companies[index].name),
              subtitle: Text(
                  '${_companies[index].address.street}, ${_companies[index].address.postCode} ${_companies[index].address.city} \n [${_companies[index].address.coordonnees}]'),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final Company? newCompany = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCompany()),
            );

            if (newCompany != null) {
              setState(() {
                _companies.add(newCompany);
              });
            }
          },
          tooltip: 'Ajouter une entreprise',
          backgroundColor: const Color.fromRGBO(219, 0, 0, 1),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: const Color.fromRGBO(219, 0, 0, 1.0),
            shape: const CircularNotchedRectangle(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () async {},
                      icon: const Icon(Icons.home, color: Colors.white)),
                ])));
  }
}
