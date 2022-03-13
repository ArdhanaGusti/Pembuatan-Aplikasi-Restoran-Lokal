import 'package:flutter/material.dart';
import 'package:local_restaurant_2/api/apiService.dart';
import 'package:local_restaurant_2/data/database_local.dart';
import 'package:local_restaurant_2/provider/database_provider.dart';
import 'package:local_restaurant_2/provider/provider_restaurant.dart';
import 'package:local_restaurant_2/provider/provider_search.dart';
import 'package:provider/provider.dart';
import 'ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SeaProvider>(
          create: (_) => SeaProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ResProvider>(
          create: (_) => ResProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
