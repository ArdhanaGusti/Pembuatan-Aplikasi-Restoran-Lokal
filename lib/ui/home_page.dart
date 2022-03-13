import 'package:flutter/material.dart';
import 'package:local_restaurant_2/ui/detail_page.dart';
import 'package:local_restaurant_2/ui/favourite_page.dart';
import 'package:local_restaurant_2/ui/search_page.dart';
import 'package:local_restaurant_2/ui/settings_page.dart';
import 'package:provider/provider.dart';
import '../json/restaurant.dart';
import 'package:google_fonts/google_fonts.dart';
import '../provider/provider_restaurant.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Material(
          color: Colors.indigo[600],
          child: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.food_bank)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: const TabBarView(children: [
          HomeList(),
          Favourite(),
          Settings(),
        ]),
      ),
    );
  }
}

class HomeList extends StatelessWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF90AFc5),
                      Color(0xFF336b87),
                      Color(0xFF2a3132),
                      Color(0xFF763626),
                    ])),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  "Daftar Restoran",
                  style: GoogleFonts.merriweather(
                      color: Colors.white, fontSize: 18),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    primaryColor: Colors.redAccent,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Search();
                        },
                      ));
                    },
                    child: const Text("Go Search ->"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Consumer<ResProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return buildRestaurantItem(context, restaurant);
                  },
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        )
      ],
    );
  }
}

Widget buildRestaurantItem(BuildContext context, Restaurantz restaurant) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Detail(
          id: restaurant.id,
          restaurantz: restaurant,
        );
      }));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}"))),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: GoogleFonts.libreFranklin(fontSize: 20),
                  ),
                  Text(
                    restaurant.city,
                    style: GoogleFonts.poppins(),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Icon(Icons.star),
                  Text("${restaurant.rating}"),
                ],
              ))
        ],
      ),
    ),
  );
}
