import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/address.dart';
import '../models/company.dart';

/// Déclaration d'un "Cubit" pour stocker la liste d'entreprise
class CompanyCubit extends Cubit<List<Company>> {
  /// Constructeur + initialisation du Cubit avec un tableau vide d'entreprise
  CompanyCubit() : super([]);

  /// Méthode pour charger la liste d'entreprise
  Future<void> loadCompanies() async {
    emit([
      const Company('Entreprise 1', Address('street', 'city', 'postcode', "[41.40338, 2.17403]")),
      const Company('Entreprise 2', Address('street', 'city', 'postcode', "[41.40338, 2.17403]")),
      const Company('Entreprise 3', Address('street', 'city', 'postcode', "[41.40338, 2.17403]")),
    ]);
  }

  /// Méthode pour ajouter une entreprise
  void addCompany(Company company) {
    emit([...state, company]);
  }
}
