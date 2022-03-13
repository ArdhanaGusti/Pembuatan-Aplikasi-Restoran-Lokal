import 'package:flutter/cupertino.dart';
import 'package:local_restaurant_2/json/restaurant.dart';

import '../data/database_local.dart';

enum ResultStati { loading, noData, hasData, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavourite();
  }

  late ResultStati _state;
  ResultStati get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurantz> _favourite = [];
  List<Restaurantz> get favourite => _favourite;

  void _getFavourite() async {
    _favourite = await databaseHelper.getRestaurant();
    if (_favourite.isNotEmpty) {
      _state = ResultStati.hasData;
    } else {
      _state = ResultStati.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addRestaurant(Restaurantz restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      _getFavourite();
    } catch (e) {
      _state = ResultStati.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourited(String id) async {
    final favouriteRestaurant = await databaseHelper.getRestaurantByUrl(id);
    return favouriteRestaurant.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      _getFavourite();
    } catch (e) {
      _state = ResultStati.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
