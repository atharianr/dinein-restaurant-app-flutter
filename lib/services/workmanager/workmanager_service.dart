import 'dart:math';

import 'package:workmanager/workmanager.dart';

import '../../data/api/api_service.dart';
import '../../static/workmanager/dine_in_workmanager.dart';
import '../notification/local_notification_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final notificationService = LocalNotificationService()
      ..init()
      ..configureLocalTimeZone();

    final ApiServices apiServices = ApiServices();
    final apiResult = await apiServices.getRestaurantList();

    if (!apiResult.error) {
      var restaurants = apiResult.restaurants;
      var randomRestaurant =
          restaurants[Random().nextInt(restaurants.length - 1)];

      await notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: "How about lunch at ${randomRestaurant.name}?",
        body: "Located in ${randomRestaurant.city}, it is worth a visit!",
        payload: "one_off_task",
      );
    }

    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.cancelAll();

    // Get the current time
    final now = DateTime.now();

    // Set the target time for 11 AM
    DateTime targetTime = DateTime(now.year, now.month, now.day, 11);

    // If it's already past 11 AM today, schedule for tomorrow
    if (now.isAfter(targetTime)) {
      targetTime = targetTime.add(Duration(days: 1));
    }

    // Calculate the delay
    final initialDelay = targetTime.difference(now);
    print("Initial Delay: ${initialDelay.inHours} hours");
    print(
        "Initial Delay: ${initialDelay.inMinutes - initialDelay.inHours * 60} minutes");
    print(
        "Initial Delay: ${initialDelay.inSeconds - initialDelay.inMinutes * 60} seconds");

    await _workmanager.registerPeriodicTask(
      DineInWorkmanager.periodic.uniqueName,
      DineInWorkmanager.periodic.taskName,
      // frequency: const Duration(hours: 24), // Repeat every 24 hours
      frequency: const Duration(minutes: 16),
      initialDelay: initialDelay, // Start at the calculated 11 AM
      inputData: {
        "data": "This is a valid payload from periodic task workmanager",
      },
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
