import 'package:flutter/material.dart';
import 'package:local_restaurant_2/json/search.dart';
import 'package:local_restaurant_2/provider/provider_search.dart';
import 'package:local_restaurant_2/ui/detail_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _HomeState();
}

class _HomeState extends State<Search> {
  String hasil = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<SeaProvider>(builder: (context, state, _) {
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
                      "Cari Restoran",
                      style: GoogleFonts.merriweather(
                          color: Colors.white, fontSize: 18),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: Colors.redAccent,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            hasil = value;
                            state.fetchAllSearchRestaurant(value);
                          });
                          // state.apiService.loadSearchData(value);
                        },
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 20.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (hasil.isEmpty)
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Silahkan Dicari"),
                      ],
                    ),
                  )
                : Expanded(child: buildListitem(context)),
          ],
        ),
      );
    });
  }
}

Widget buildListitem(BuildContext context) {
  return Consumer<SeaProvider>(builder: (context, state, _) {
    if (state.state == ResultState.loading) {
      return Center(
          child: Container(
        child: const Text('Cari Restoran'),
      ));
    } else if (state.state == ResultState.hasData) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.result!.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result!.restaurants[index];
            return buildRestaurantItem(context, restaurant);
          });
    } else if (state.state == ResultState.noData) {
      return Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset("assets/error.png")),
          Text(state.message),
        ],
      );
    } else if (state.state == ResultState.error) {
      return Center(
        child: Text(state.message),
      );
    } else {
      return const Center(
        child: Text(''),
      );
    }
  });
}

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Detail(
          id: restaurant.id,
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
