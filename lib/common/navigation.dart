import 'package:flutter/material.dart';
import 'package:local_restaurant_2/json/restaurant.dart';
import 'package:local_restaurant_2/ui/detail_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String id, Restaurantz restaurantz) {
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) {
        return Detail(
          id: id,
          restaurantz: restaurantz,
        );
      },
    ));
  }

  static back() => navigatorKey.currentState?.pop();
}
