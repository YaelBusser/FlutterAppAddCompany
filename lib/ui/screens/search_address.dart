import 'dart:math';

import 'package:first_app/repositories/address_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/address.dart';

class SearchAddress extends StatefulWidget {
  const SearchAddress({super.key});

  @override
  State<SearchAddress> createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  final List<Address> _addresses = [
    const Address(
        'Place du Ralliement', 'Angers', '49000', "41.40338, 2.17403"),
    const Address(
        '19 rue André le Notre', 'Angers', '49066', "41.40338, 2.17403"),
  ];
  final TextEditingController _searchValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rechercher une entreprise"),
        ),
        body: Column(
          children: [
            TextField(
              controller: _searchValueController,
              decoration: const InputDecoration(
                  labelText: "Adresse de l'entreprise",
                  prefixIcon: Icon(Icons.location_on)),
              onChanged: (value) async {
                final addressRepository = AddressRepository();
                final newAddress =
                    await addressRepository.fetchAddresses(value);
                if (value.isEmpty) {
                  _addresses.clear();
                  _addresses.add(const Address('Place du Ralliement', 'Angers',
                      '49000', '[41.40338, 2.17403]'));
                  _addresses.add(const Address('19 rue André le Notre',
                      'Angers', '49066', '[41.40338, 2.17403]'));
                  _addresses.clear();
                }
                setState(() {
                  _addresses.clear();
                  _addresses.addAll(newAddress);
                });
              },
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return ListTile(
                  title: Text(
                      '${address.street}, ${address.postCode} ${address.city}'),
                  subtitle: Text("[${address.coordonnees}]"),
                  onTap: () {
                    Navigator.pop(context, address);
                  },
                );
              },
            ))
          ],
        ));
  }
}
