import '../customer_review.dart';

class RestaurantReviewsResponse {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  RestaurantReviewsResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantReviewsResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantReviewsResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(json["customerReviews"]!
                .map((x) => CustomerReview.fromJson(x))),
      );
}
