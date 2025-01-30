import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantListResponse {
  bool error;
  String message;
  int count;
  int founded;
  List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json["error"],
        message: json["message"] ?? "",
        count: json["count"] ?? 0,
        founded: json["founded"] ?? 0,
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
