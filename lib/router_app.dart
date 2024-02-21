import 'package:first_app/ui/screens/add_company.dart';
import 'package:first_app/ui/screens/home.dart';
import 'package:first_app/ui/screens/search_address.dart';
import 'package:flutter/cupertino.dart';

class RouterApp {
  static const String homeRoute = "/home";
  static const String addCompanyRoute = "/addCompany";
  static const String searchAddressCompanyRoute = "/searchCompany";
  static final routes = {
    homeRoute: (context) => const Home(),
    addCompanyRoute: (context) => AddCompany(),
    searchAddressCompanyRoute: (context) => SearchAddress()
  };
}
