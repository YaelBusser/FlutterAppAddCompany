import 'dart:async';

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

  bool isError = false;
  Timer? _debounceTimer;

  String? get _errorText {
    final text = _searchValueController.value.text;
    if (text.isNotEmpty && text.length < 3) {
      return 'L\'adresse doit contenir au moins 3 caractères';
    }
    return null;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged(String value) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    if (value.isNotEmpty && value.length < 3) {
      setState(() {
        _addresses.clear();
        _addresses.add(
          const Address(
              'Place du Ralliement', 'Angers', '49000', "41.40338, 2.17403"),
        );
        _addresses.add(
          const Address(
              '19 rue André le Notre', 'Angers', '49066', "41.40338, 2.17403"),
        );
      });
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (value.length >= 3) {
        final addressRepository = AddressRepository();
        final newAddress = await addressRepository.fetchAddresses(value);
        if (newAddress.isNotEmpty) {
          setState(() {
            _addresses.clear();
            _addresses.addAll(newAddress);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cette adresse n'existe pas.")));
        }
      }
    });
  }

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
            decoration: InputDecoration(
              labelText: "Adresse de l'entreprise",
              prefixIcon: const Icon(Icons.location_on),
              errorText: _errorText,
            ),
            onChanged: _onSearchTextChanged,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
                  child:
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minLeadingWidth: 10,
                      title: Text(
                        '${address.street}, ${address.postCode} ${address.city}',
                      ),
                      subtitle: Text("[${address.coordonnees}]"),
                      onTap: () {
                        Navigator.pop(context, address);
                      },
                    )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
