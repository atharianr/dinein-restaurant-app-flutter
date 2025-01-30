import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/constants.dart';
import 'package:restaurant_app/style/color/dine_in_colors.dart';

import '../../data/model/restaurant.dart';
import '../../style/typography/dine_in_text_styles.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestaurantCardWidget({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: DineInColors.cardColor.getColor(context),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 100,
                          minWidth: 100,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Hero(
                            tag: "hero_banner_${restaurant.id}",
                            child: Image.network(
                              "${Constants.imageBaseUrl}${restaurant.pictureId}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox.square(dimension: 16),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 48,
                          bottom: 12,
                          right: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: "hero_name_${restaurant.id}",
                              child: Text(
                                restaurant.name ?? "",
                                style: DineInTextStyles.titleLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox.square(dimension: 8),
                            Hero(
                              tag: "hero_city_${restaurant.id}",
                              child: Text(
                                restaurant.city ?? "",
                                style: DineInTextStyles.titleSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox.square(dimension: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: "hero_rating_icon_${restaurant.id}",
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                SizedBox.square(dimension: 4),
                                Hero(
                                  tag: "hero_rating_${restaurant.id}",
                                  child: Text(
                                    restaurant.rating.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: DineInTextStyles.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
