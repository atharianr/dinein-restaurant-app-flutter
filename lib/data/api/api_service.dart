import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/constants/constants.dart';
import 'package:restaurant_app/data/model/request/restaurant_review_request.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/response/restaurant_reviews_response.dart';

import '../../utils/custom_exception.dart';

class ApiServices {
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("${Constants.baseUrl}/list"));

    if (response.statusCode == 200) {
      var restaurantListResponse =
          RestaurantListResponse.fromJson(jsonDecode(response.body));

      if (restaurantListResponse.restaurants.isNotEmpty) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw CustomException('No restaurants available at the moment');
      }
    } else {
      throw CustomException('Failed to load tourism list');
    }
  }

  Future<RestaurantListResponse> getSearchRestaurant(String query) async {
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/search").replace(
        queryParameters: {
          'q': query,
        },
      ),
    );

    if (response.statusCode == 200) {
      var restaurantListResponse =
          RestaurantListResponse.fromJson(jsonDecode(response.body));

      if (restaurantListResponse.restaurants.isNotEmpty) {
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw CustomException(
          'Oops! No restaurants found. How about trying a different search?',
        );
      }
    } else {
      throw CustomException('Failed to load tourism list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response =
        await http.get(Uri.parse("${Constants.baseUrl}/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw CustomException('Failed to load tourism list');
    }
  }

  Future<RestaurantReviewsResponse> addRestaurantReview(
    String id,
    String name,
    String review,
  ) async {
    var request = RestaurantReviewRequest(id: id, name: name, review: review);
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/review"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return RestaurantReviewsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw CustomException('Failed to add review');
    }
  }
}
