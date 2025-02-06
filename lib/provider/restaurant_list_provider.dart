import 'package:flutter/widgets.dart';
import 'package:restaurant_app/static/state/restaurant_list_result_state.dart';

import '../data/api/api_service.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(this._apiServices);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(
          "Oops! Something went wrong. Please check your internet connection and try again.");
      notifyListeners();
    }
  }

  Future<void> fetchSearchRestaurant(String query) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getSearchRestaurant(query);

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception {
      _resultState = RestaurantListErrorState(
          "Oops! Something went wrong. Please check your internet connection and try again.");
      notifyListeners();
    }
  }
}
