import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/constants.dart';

import '../../style/typography/dine_in_text_styles.dart';

class DetailBannerWidget extends StatelessWidget {
  final String id;
  final String name;
  final String city;
  final String address;
  final double rating;
  final String pictureId;

  const DetailBannerWidget({
    super.key,
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.rating,
    required this.pictureId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.5),
                      BlendMode.srcOver,
                    ),
                    child: Hero(
                      tag: "hero_banner_$id",
                      child: Image.network(
                        "${Constants.imageBaseUrl}$pictureId",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "hero_name_$id",
                      child: Text(
                        name,
                        style: DineInTextStyles.displaySmall
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox.square(dimension: 96),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: "hero_city_$id",
                                child: Text(
                                  city,
                                  style: DineInTextStyles.bodyLargeBold
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Text(
                                address,
                                style:
                                    DineInTextStyles.bodyLargeMedium.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox.square(dimension: 8),
                        Hero(
                          tag: "hero_rating_icon_$id",
                          child: Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        SizedBox.square(dimension: 4),
                        Hero(
                          tag: "hero_rating_$id",
                          child: Text(
                            rating.toString(),
                            style: DineInTextStyles.bodyLargeExtraBold
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
