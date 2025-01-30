import 'package:flutter/widgets.dart';

class AddReviewTextFieldProvider extends ChangeNotifier {
  String _name = "";

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String _review = "";

  String get review => _review;

  set review(String value) {
    _review = value;
    notifyListeners();
  }

  String? _errorName;

  String? get errorName => _errorName;

  set errorName(String? value) {
    _errorName = value;
    notifyListeners();
  }

  String? _errorReview;

  String? get errorReview => _errorReview;

  set errorReview(String? value) {
    _errorReview = value;
    notifyListeners();
  }
}
