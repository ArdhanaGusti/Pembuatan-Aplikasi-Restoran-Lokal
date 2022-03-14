import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_restaurant_2/provider/database_provider.dart';
import 'package:local_restaurant_2/ui/add_review.dart';
import 'package:local_restaurant_2/ui/home_page.dart';
import 'package:provider/provider.dart';
import '../json/detail.dart';
import '../json/restaurant.dart';

class ListItem extends StatelessWidget {
  final Restaurant restaurant;
  final Restaurantz restaurantz;
  const ListItem(
      {Key? key, required this.restaurant, required this.restaurantz})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavourited(restaurant.id),
          builder: (context, snapshot) {
            var isFavourited = snapshot.data ?? false;
            return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      actions: [
                        isFavourited == true
                            ? IconButton(
                                onPressed: () =>
                                    provider.removeRestaurant(restaurantz.id),
                                icon: const Icon(Icons.favorite))
                            : IconButton(
                                onPressed: () =>
                                    provider.addRestaurant(restaurantz),
                                icon:
                                    const Icon(Icons.favorite_border_outlined))
                      ],
                      leading: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const Home();
                            },
                          ));
                        },
                      ),
                      pinned: true,
                      backgroundColor: Colors.brown[200],
                      expandedHeight: MediaQuery.of(context).size.width / 2,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        background: Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(restaurant.name),
                      ),
                    ),
                  ];
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Description",
                        style: GoogleFonts.spectral(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(restaurant.description,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.oswald(
                            fontSize: 15,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "Customer Reviews",
                            style: GoogleFonts.spectral(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return AddReview(
                                      id: restaurant.id,
                                      restaurantz: restaurantz,
                                    );
                                  },
                                ));
                              },
                              child: Text(
                                "Tambah Review",
                                style: GoogleFonts.spectral(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.customerReviews.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            // ignore: prefer_const_constructors
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.brown[100]),
                            margin: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(restaurant.customerReviews[index].name),
                                Text(restaurant.customerReviews[index].date),
                                Text(restaurant.customerReviews[index].review),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "You can find it on: ",
                        style: GoogleFonts.adamina(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(restaurant.address + ", " + restaurant.city,
                          style: GoogleFonts.actor(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Menu",
                          style: GoogleFonts.arsenal(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return buildDrinkItem(
                                    context, restaurant.menus.drinks[index]);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                return buildFoodItem(
                                    context, restaurant.menus.foods[index]);
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          });
    });
  }
}

Widget buildDrinkItem(BuildContext context, Category drink) {
  Tween<double> _animationTween = Tween(
    begin: 0,
    end: 1,
  );

  return TweenAnimationBuilder<double>(
      tween: _animationTween,
      duration: const Duration(seconds: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            height: 150,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF90AFc5),
                    Color(0xFF336b87),
                    Color(0xFF2a3132),
                    Color(0xFF763626),
                  ]),
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                drink.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.antic(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      });
}

Widget buildFoodItem(BuildContext context, Category foods) {
  Tween<double> _animationTween = Tween(
    begin: 0,
    end: 1,
  );

  return TweenAnimationBuilder<double>(
      tween: _animationTween,
      duration: const Duration(seconds: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            height: 150,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF90AFc5),
                    Color(0xFF336b87),
                    Color(0xFF2a3132),
                    Color(0xFF763626),
                  ]),
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                foods.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.antic(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      });
}
