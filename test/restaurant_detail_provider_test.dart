import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail_response.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/static/state/restaurant_detail_result_state.dart';
import 'package:restaurant_app/utils/custom_exception.dart';
import 'package:test/test.dart';

import 'response_mock.dart';
import 'restaurant_detail_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices apiServices;
  late RestaurantDetailProvider restaurantDetailProvider;
  late String restaurantId;
  late RestaurantDetailResponse restaurantDetailResponse;

  setUp(() {
    apiServices = MockApiServices();
    restaurantDetailProvider = RestaurantDetailProvider(apiServices);
    restaurantId = "rqdv5juczeskfw1e867";
    restaurantDetailResponse = ResponseMock().restaurantDetailResponse;
  });

  group("Restaurant Detail Provider", () {
    // Memastikan state awal provider harus didefinisikan
    test('Should not return null when provider initialize.', () {
      final initState = restaurantDetailProvider.resultState;
      expect(initState, isNotNull);
      expect(initState, isA<RestaurantDetailNoneState>());
    });

    // Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil.
    test('Should return list of restaurants on successful API call', () async {
      when(apiServices.getRestaurantDetail(restaurantId))
          .thenAnswer((_) async => restaurantDetailResponse);

      await restaurantDetailProvider.fetchRestaurantDetail(restaurantId);

      expect(
        restaurantDetailProvider.resultState,
        isA<RestaurantDetailLoadedState>(),
      );

      final state =
          restaurantDetailProvider.resultState as RestaurantDetailLoadedState;
      expect(state.data, restaurantDetailResponse.restaurant);
    });

    // Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal.
    test('Should return error state on API failure', () async {
      when(apiServices.getRestaurantDetail(restaurantId)).thenThrow(
        CustomException(
          'Oops! Something went wrong. Please check your internet connection and try again.',
        ),
      );

      await restaurantDetailProvider.fetchRestaurantDetail(restaurantId);

      expect(
        restaurantDetailProvider.resultState,
        isA<RestaurantDetailErrorState>(),
      );

      final state =
          restaurantDetailProvider.resultState as RestaurantDetailErrorState;

      expect(
        state.error,
        contains(
          'Oops! Something went wrong. Please check your internet connection and try again.',
        ),
      );
    });
  });
}
