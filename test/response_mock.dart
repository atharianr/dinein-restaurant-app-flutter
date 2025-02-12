import 'package:restaurant_app/data/model/category.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/menu.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ResponseMock {
  final RestaurantListResponse restaurantListResponse = RestaurantListResponse(
    error: false,
    message: "success",
    count: 20,
    founded: 0,
    restaurants: [
      Restaurant(
        id: "rqdv5juczeskfw1e867",
        name: "Melting Pot",
        description:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
        pictureId: "14",
        city: "Medan",
        rating: 4.2,
      ),
    ],
  );

  final RestaurantDetailResponse restaurantDetailResponse =
      RestaurantDetailResponse(
    error: false,
    message: "success",
    restaurant: Restaurant(
      id: "rqdv5juczeskfw1e867",
      name: "Melting Pot",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      pictureId: "14",
      city: "Medan",
      rating: 4.2,
      address: "Jln. Pandeglang no 19",
      categories: [
        Category(name: "Italia"),
      ],
      menus: Menu(
        foods: [
          Category(name: "Paket rosemary"),
        ],
        drinks: [
          Category(name: "Es krim"),
        ],
      ),
      customerReviews: [
        CustomerReview(
          name: "Ahmad",
          review: "Tidak rekomendasi untuk pelajar!",
          date: "13 November 2019",
        )
      ],
    ),
  );
}
