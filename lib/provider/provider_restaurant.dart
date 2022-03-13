import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:local_restaurant_2/api/apiService.dart';
import 'package:local_restaurant_2/json/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class ResProvider extends ChangeNotifier {
  final ApiService apiService;

  ResProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late Welcome _restaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Welcome get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.loadApiData();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          "Gagal terkoneksi ke server, silahkan restart jaringan anda";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
