import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/provider/detail/restaurant_reviews_provider.dart';
import 'package:restaurant_app/screen/widget/add_review_dialog_widget.dart';
import 'package:restaurant_app/screen/widget/review_list_widget.dart';
import 'package:restaurant_app/static/state/restaurant_reviews_result_state.dart';

import '../../data/model/restaurant.dart';
import '../../provider/detail/add_review_text_field_provider.dart';
import '../../style/typography/dine_in_text_styles.dart';
import 'detail_banner_widget.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  final Restaurant restaurant;

  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final List<CustomerReview> reviewList = restaurant.customerReviews ?? [];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailBannerWidget(
            id: restaurant.id ?? "",
            name: restaurant.name ?? "",
            city: restaurant.city ?? "",
            address: restaurant.address ?? "",
            rating: restaurant.rating ?? 0,
            pictureId: restaurant.pictureId ?? "",
          ),
          SizedBox.square(dimension: 8),
          SizedBox(
            height: 32,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: restaurant.categories?.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final category = restaurant.categories?[index];
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                        child: Text(
                      category?.name ?? "",
                      style: DineInTextStyles.labelLarge,
                    )),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Text(
              restaurant.description ?? "",
              style: DineInTextStyles.bodyLargeMedium.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Text(
              "Menus",
              style: DineInTextStyles.titleLarge,
            ),
          ),
          SizedBox.square(dimension: 8),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Food(s): ",
                  style: DineInTextStyles.bodyLargeMedium,
                ),
                Expanded(
                  child: Text(
                    foodMenusString(),
                    style: DineInTextStyles.bodyLargeMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox.square(dimension: 4),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Drink(s): ",
                  style: DineInTextStyles.bodyLargeMedium,
                ),
                Expanded(
                  child: Text(
                    drinkMenusString(),
                    style: DineInTextStyles.bodyLargeMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Reviews",
                  style: DineInTextStyles.titleLarge,
                ),
                GestureDetector(
                  onTap: () {
                    final reviewsProvider =
                        context.read<RestaurantReviewsProvider>();
                    reviewsProvider.restaurantId = "";
                    reviewsProvider.isSubmitted = false;

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Consumer<RestaurantReviewsProvider>(
                          builder: (context, value, child) {
                            if (value.isSubmitted) {
                              Navigator.of(context).pop();
                            }
                            return AddReviewDialogWidget(
                              id: restaurant.id ?? "",
                            );
                          },
                        );
                      },
                    ).then((value) {
                      context.read<RestaurantReviewsProvider>().resetState();
                      context.read<AddReviewTextFieldProvider>().name = "";
                      context.read<AddReviewTextFieldProvider>().errorName =
                          null;
                      context.read<AddReviewTextFieldProvider>().review = "";
                      context.read<AddReviewTextFieldProvider>().errorReview =
                          null;
                    });
                  },
                  child: Text(
                    "Add Review",
                    style: DineInTextStyles.titleSmallBold
                        .copyWith(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
          Consumer<RestaurantReviewsProvider>(
            builder: (context, value, child) {
              if (value.restaurantId == restaurant.id &&
                  value.resultState is RestaurantReviewsLoadedState) {
                final reviews =
                    (value.resultState as RestaurantReviewsLoadedState).data;
                reviewList
                  ..clear()
                  ..addAll(reviews);
              }
              return ReviewListWidget(
                reviews: reviewList.reversed.toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  String foodMenusString() {
    return (restaurant.menus?.foods ?? []).map((food) => food.name).join(", ");
  }

  String drinkMenusString() {
    return (restaurant.menus?.drinks ?? [])
        .map((drink) => drink.name)
        .join(", ");
  }
}
