import 'package:flutter/material.dart';
import 'package:local_restaurant_2/provider/database_provider.dart';
import 'package:local_restaurant_2/ui/detail_page.dart';
import 'package:provider/provider.dart';
import '../json/restaurant.dart';
import 'package:google_fonts/google_fonts.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    "Daftar Favorit",
                    style: GoogleFonts.merriweather(
                        color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Consumer<DatabaseProvider>(
            builder: (context, state, _) {
              if (state.state == ResultStati.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultStati.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.favourite.length,
                    itemBuilder: (context, index) {
                      var restaurant = state.favourite[index];
                      return buildRestaurantItem(context, restaurant);
                    },
                  ),
                );
              } else if (state.state == ResultStati.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultStati.error) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text(''));
              }
            },
          )
        ],
      ),
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
