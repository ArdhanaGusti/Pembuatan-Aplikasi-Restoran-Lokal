import 'package:local_restaurant_2/json/detail.dart';
import 'package:local_restaurant_2/json/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../json/search.dart';

class ApiService {
  String baseUrl = "https://restaurant-api.dicoding.dev";
  Future<Welcome> loadApiData() async {
    final response = await http.get(Uri.parse(baseUrl + "/list"));
    if (response.statusCode == 200) {
      return Welcome.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Welcome2> loadDetailData(String id) async {
    final response = await http.get(Uri.parse(baseUrl + "/detail/$id"));
    if (response.statusCode == 200) {
      return Welcome2.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Welcome3> loadSearchData(String query) async {
    final response = await http.get(Uri.parse(baseUrl + "/search?q=$query"));
    if (response.statusCode == 200) {
      return Welcome3.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  void sendReview(String id, String name, String review) {
    http.post(Uri.parse(baseUrl + "/review"), body: {
      "id": id,
      "name": name,
      "review": review,
    });
  }
}
