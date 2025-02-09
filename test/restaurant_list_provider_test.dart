import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/restaurant_list_response.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/static/state/restaurant_list_result_state.dart';
import 'package:restaurant_app/utils/custom_exception.dart';
import 'package:test/test.dart';

import 'response_mock.dart';
import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices apiServices;
  late RestaurantListProvider restaurantListProvider;
  late RestaurantListResponse restaurantListResponse;

  setUp(() {
    apiServices = MockApiServices();
    restaurantListProvider = RestaurantListProvider(apiServices);
    restaurantListResponse = ResponseMock().restaurantListResponse;
  });

  group("Restaurant List Provider", () {
    // Memastikan state awal provider harus didefinisikan
    test('Should not return null when provider initialize.', () {
      final initState = restaurantListProvider.resultState;
      expect(initState, isNotNull);
      expect(initState, isA<RestaurantListNoneState>());
    });

    // Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil.
    test(
        'Should return loaded state and list of restaurants on API call success',
        () async {
      when(apiServices.getRestaurantList())
          .thenAnswer((_) async => restaurantListResponse);

      await restaurantListProvider.fetchRestaurantList();

      expect(
        restaurantListProvider.resultState,
        isA<RestaurantListLoadedState>(),
      );

      final state =
          restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(state.data.length, restaurantListResponse.restaurants.length);
    });

    // Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal.
    test('Should return error state on API failure', () async {
      when(apiServices.getRestaurantList()).thenThrow(
        CustomException(
          'Oops! Something went wrong. Please check your internet connection and try again.',
        ),
      );

      await restaurantListProvider.fetchRestaurantList();

      expect(
          restaurantListProvider.resultState, isA<RestaurantListErrorState>());

      final state =
          restaurantListProvider.resultState as RestaurantListErrorState;

      expect(
        state.error,
        contains(
          'Oops! Something went wrong. Please check your internet connection and try again.',
        ),
      );
    });
  });
}
