import 'package:first_app/models/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/company_cubit.dart';
import '../../models/company.dart';
import 'add_company.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Company> _companies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des entreprises'),
        ),
        body: BlocBuilder<CompanyCubit, List<Company>>(
          builder: (context, state) {
            return ListView.separated(
              itemCount: state.length,
              itemBuilder: (BuildContext context, int index) {
                final Company company = state[index];
                return ListTile(
                  title: Text(company.name),
                  subtitle: Text(
                      '${company.address.street}, ${company.address.city} \n ${company.address.coordonnees}'),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 0);
              },
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
        bottomNavigationBar: const BottomAppBar(
          color: Color.fromRGBO(219, 0, 0, 1.0),
          shape: CircularNotchedRectangle(),
        ));
  }
}
