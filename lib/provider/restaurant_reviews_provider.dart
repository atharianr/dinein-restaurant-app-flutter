import 'package:flutter/widgets.dart';

import '../data/api/api_service.dart';
import '../static/state/restaurant_reviews_result_state.dart';

class RestaurantReviewsProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantReviewsProvider(this._apiServices);

  RestaurantReviewsResultState _resultState = RestaurantReviewsNoneState();

  RestaurantReviewsResultState get resultState => _resultState;

  String _restaurantId = "";

  String get restaurantId => _restaurantId;

  set restaurantId(String value) {
    _restaurantId = value;
    notifyListeners();
  }

  bool _isSubmitted = false;

  bool get isSubmitted => _isSubmitted;

  set isSubmitted(bool value) {
    _isSubmitted = value;
    notifyListeners();
  }

  void resetState() {
    _resultState = RestaurantReviewsNoneState();
  }

  Future<void> addRestaurantReview(
    String id,
    String name,
    String review,
  ) async {
    try {
      _restaurantId = "";
      _isSubmitted = false;
      _resultState = RestaurantReviewsLoadingState();
      notifyListeners();
      final result = await _apiServices.addRestaurantReview(id, name, review);
      if (result.error) {
        _resultState = RestaurantReviewsErrorState(result.message);
        notifyListeners();
      } else {
        _restaurantId = id;
        _isSubmitted = true;
        _resultState = RestaurantReviewsLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantReviewsErrorState(e.toString());
      notifyListeners();
    }
  }
}
