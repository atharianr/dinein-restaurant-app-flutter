import 'package:restaurant_app/data/model/customer_review.dart';

sealed class RestaurantReviewsResultState {}

class RestaurantReviewsNoneState extends RestaurantReviewsResultState {}

class RestaurantReviewsLoadingState extends RestaurantReviewsResultState {}

class RestaurantReviewsErrorState extends RestaurantReviewsResultState {
  final String error;

  RestaurantReviewsErrorState(this.error);
}

class RestaurantReviewsLoadedState extends RestaurantReviewsResultState {
  final List<CustomerReview> data;

  RestaurantReviewsLoadedState(this.data);
}
