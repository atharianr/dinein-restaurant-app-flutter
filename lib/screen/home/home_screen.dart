import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/widget/dine_in_text_field_widget.dart';

import '../../static/navigation/navigation_route.dart';
import '../../static/state/restaurant_list_result_state.dart';
import '../../style/color/dine_in_colors.dart';
import '../../style/typography/dine_in_text_styles.dart';
import '../widget/restaurant_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 48, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: DineInColors.colorPrimary.getColor(context),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: DineInTextStyles.headlineLarge.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Find the perfect spot for your next meal.",
                  style: DineInTextStyles.bodyLargeMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DineInTextFieldWidget(
                    hint: "Find restaurant",
                    prefixIcon: Icon(Icons.search),
                    onChanged: (text) {
                      if (_debounce?.isActive ?? false) {
                        _debounce!.cancel();
                      }
                      _debounce = Timer(
                        const Duration(milliseconds: 800),
                        () {
                          context
                              .read<RestaurantListProvider>()
                              .fetchSearchRestaurant(text);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Consumer<RestaurantListProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                RestaurantListLoadingState() => Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                RestaurantListLoadedState(data: var restaurantList) => Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];
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
                  ),
                RestaurantListErrorState(error: var message) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: DineInTextStyles.bodyLargeBold,
                        ),
                      ),
                    ),
                  ),
                _ => const SizedBox(),
              };
            },
          ),
        ],
      ),
    );
  }
}
