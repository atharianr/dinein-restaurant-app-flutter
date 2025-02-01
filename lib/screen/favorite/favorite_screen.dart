import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/favorite/local_database_provider.dart';
import '../../static/navigation/navigation_route.dart';
import '../../style/color/dine_in_colors.dart';
import '../../style/typography/dine_in_text_styles.dart';
import '../widget/restaurant_card_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurants();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurants"),
        titleTextStyle: DineInTextStyles.titleLarge,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: DineInColors.colorPrimary.getColor(context),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final favoriteList = value.restaurantList ?? [];
          return switch (favoriteList.isNotEmpty) {
            true => ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (context, index) {
                  final restaurant = favoriteList[index];
                  return RestaurantCardWidget(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: restaurant.id,
                      );
                    },
                  );
                },
              ),
            _ => Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  "You don't have any favorites :((",
                  textAlign: TextAlign.center,
                  style: DineInTextStyles.bodyLargeBold,
                ),
              ),
            ),
          };
        },
      ),
    );
  }
}
