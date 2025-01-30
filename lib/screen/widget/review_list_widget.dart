import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/widget/review_card_widget.dart';

import '../../data/model/customer_review.dart';

class ReviewListWidget extends StatelessWidget {
  final List<CustomerReview> reviews;

  const ReviewListWidget({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    if (reviews.isNotEmpty) {
      for (int i = 0; i < reviews.length; i++) {
        widgets.add(ReviewCardWidget(review: reviews[i]));
      }
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
