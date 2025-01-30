import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

import '../../static/state/restaurant_detail_result_state.dart';
import '../../style/color/dine_in_colors.dart';
import '../../style/typography/dine_in_text_styles.dart';
import '../widget/body_of_detail_screen_widget.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;

  const DetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
        titleTextStyle: DineInTextStyles.titleLarge,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: DineInColors.colorPrimary.getColor(context),

      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestaurantDetailLoadedState(data: var restaurant) =>
              BodyOfDetailScreenWidget(restaurant: restaurant),
            RestaurantDetailErrorState(error: var message) => Expanded(
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
    );
  }
}
