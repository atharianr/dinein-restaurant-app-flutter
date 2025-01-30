import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/add_review_text_field_provider.dart';

import '../../provider/restaurant_reviews_provider.dart';
import '../../static/state/restaurant_reviews_result_state.dart';
import '../../style/color/dine_in_colors.dart';
import '../../style/typography/dine_in_text_styles.dart';
import 'dine_in_text_field_widget.dart';

class AddReviewDialogWidget extends StatelessWidget {
  final String id;

  const AddReviewDialogWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: DineInColors.cardColor.getColor(context),
      title: Text(
        "Add Review",
        style: DineInTextStyles.titleLarge,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DineInTextFieldWidget(
              hint: "Your name",
              errorText: context.watch<AddReviewTextFieldProvider>().errorName,
              onChanged: (text) {
                context.read<AddReviewTextFieldProvider>().name = text;
              },
            ),
            SizedBox.square(dimension: 8),
            DineInTextFieldWidget(
              hint: "Your review",
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              errorText:
                  context.watch<AddReviewTextFieldProvider>().errorReview,
              onChanged: (text) {
                context.read<AddReviewTextFieldProvider>().review = text;
              },
            ),
            Consumer<RestaurantReviewsProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantReviewsErrorState(error: var message) => Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                      child: Text(message),
                    ),
                  _ => SizedBox(),
                };
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: DineInTextStyles.labelLarge.copyWith(
              color: DineInColors.buttonTextColor.getColor(context),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: DineInColors.buttonFilledColor.getColor(context),
          ),
          onPressed: context.watch<RestaurantReviewsProvider>().resultState !=
                  RestaurantReviewsLoadingState()
              ? () => onSubmit(context)
              : null,
          child: Consumer<RestaurantReviewsProvider>(
            builder: (context, value, child) {
              switch (value.resultState) {
                case RestaurantReviewsLoadingState():
                  return SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  );
                case _:
                  return Text(
                    "OK",
                    style: DineInTextStyles.labelLargeBold.copyWith(
                      color: Colors.white,
                    ),
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  void onSubmit(BuildContext context) {
    var name = context.read<AddReviewTextFieldProvider>().name;
    var review = context.read<AddReviewTextFieldProvider>().review;

    if (name.isNotEmpty && review.isNotEmpty) {
      context
          .read<RestaurantReviewsProvider>()
          .addRestaurantReview(id, name, review);
    } else {
      if (name.isEmpty) {
        context.read<AddReviewTextFieldProvider>().errorName =
            "Please enter your name";
      } else {
        context.read<AddReviewTextFieldProvider>().errorName = null;
      }
      if (review.isEmpty) {
        context.read<AddReviewTextFieldProvider>().errorReview =
            "Please enter your review";
      } else {
        context.read<AddReviewTextFieldProvider>().errorReview = null;
      }
    }
  }
}
