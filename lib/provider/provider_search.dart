import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:local_restaurant_2/api/apiService.dart';
import 'package:local_restaurant_2/json/search.dart';

enum ResultState { loading, noData, hasData, error }

class SeaProvider extends ChangeNotifier {
  final ApiService apiService;

  SeaProvider({required this.apiService}) {
    fetchAllSearchRestaurant(query);
  }

  Welcome3? _restaurant;
  ResultState? _state;
  String _message = '';
  final String _query = '';

  String get message => _message;

  String get query => _query;

  Welcome3? get result => _restaurant;

  ResultState? get state => _state;

  Future<dynamic> fetchAllSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.loadSearchData(query);
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
      return _message = 'Error ->$e';
    }
  }
}
