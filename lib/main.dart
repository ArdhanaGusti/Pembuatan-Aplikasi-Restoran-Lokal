import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_restaurant_2/api/api_service.dart';
import 'package:local_restaurant_2/data/database_local.dart';
import 'package:local_restaurant_2/provider/database_provider.dart';
import 'package:local_restaurant_2/provider/provider_restaurant.dart';
import 'package:local_restaurant_2/provider/provider_search.dart';
import 'package:local_restaurant_2/provider/scheduling_provider.dart';
import 'package:local_restaurant_2/utils/background_service.dart';
import 'package:local_restaurant_2/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'ui/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SeaProvider>(
          create: (_) => SeaProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ResProvider>(
          create: (_) => ResProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
