import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:local_restaurant_2/api/api_service.dart';
import 'package:local_restaurant_2/json/detail.dart';

enum ResultState { loading, noData, hasData, error }

class DetProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetProvider({required this.apiService, required this.id}) {
    _fetchAllDetailRestaurant(id);
  }

  late Welcome2 _restaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Welcome2 get result => _restaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllDetailRestaurant(String id) async {
    try {
      if (id.isNotEmpty) {
        _state = ResultState.loading;
        notifyListeners();
        final restaurant = await apiService.loadDetailData(id);
        if (restaurant.error) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurant = restaurant;
        }
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
