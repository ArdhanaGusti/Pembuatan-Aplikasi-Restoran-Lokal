import 'package:flutter/material.dart';
import 'package:local_restaurant_2/api/apiService.dart';

import 'package:local_restaurant_2/json/restaurant.dart';

import 'package:local_restaurant_2/widget/list_item.dart';
import 'package:local_restaurant_2/provider/provider_detail.dart';

import 'package:provider/provider.dart';

class Detail extends StatelessWidget {
  const Detail({
    Key? key,
    required this.id,
    this.restaurantz,
  }) : super(key: key);
  final String id;
  final Restaurantz? restaurantz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DetProvider>(
        create: (_) => DetProvider(apiService: ApiService(), id: id),
        child: Consumer<DetProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return ListItem(
                restaurant: state.result.restaurant,
                restaurantz: restaurantz!,
              );
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
