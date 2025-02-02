import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/add_review_text_field_provider.dart';
import 'package:restaurant_app/provider/favorite/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/restaurant_reviews_provider.dart';
import 'package:restaurant_app/provider/settings/settings_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/shared_preferences_service.dart';
import 'package:restaurant_app/static/navigation/navigation_route.dart';
import 'package:restaurant_app/style/theme/dine_in_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api/api_service.dart';
import 'data/local/local_database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiServices(),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        Provider(
          create: (context) => SharedPreferencesService(prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(
            context.read<SharedPreferencesService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteIconProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddReviewTextFieldProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantReviewsProvider(
            context.read<ApiServices>(),
          ),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DineIn",
      theme: DineInTheme.lightTheme,
      darkTheme: DineInTheme.darkTheme,
      // themeMode: ThemeMode.system,
      themeMode: context.watch<SettingsProvider>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
