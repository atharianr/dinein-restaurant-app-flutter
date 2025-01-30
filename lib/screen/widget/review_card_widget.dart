import 'package:flutter/material.dart';

import '../../data/model/customer_review.dart';
import '../../style/color/dine_in_colors.dart';
import '../../style/typography/dine_in_text_styles.dart';

class ReviewCardWidget extends StatelessWidget {
  final CustomerReview review;

  const ReviewCardWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Container(
        width: 256,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: DineInColors.cardColor.getColor(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.name ?? "",
              style: DineInTextStyles.bodyLargeExtraBold,
            ),
            Text(
              review.date ?? "",
              style: DineInTextStyles.labelSmall,
            ),
            SizedBox.square(dimension: 8),
            Text(
              review.review ?? "",
              style: DineInTextStyles.bodyLargeMedium,
            ),
          ],
        ),
      ),
    );
  }
}
