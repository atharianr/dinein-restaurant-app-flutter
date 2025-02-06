import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/settings/settings_provider.dart';

import '../../provider/local_notification_provider.dart';
import '../../services/workmanager/workmanager_service.dart';
import '../../style/color/dine_in_colors.dart';
import '../../style/typography/dine_in_text_styles.dart';
import '../widget/switch_text_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        titleTextStyle: DineInTextStyles.titleLarge,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: DineInColors.colorPrimary.getColor(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchTextWidget(
              title: "Dark Mode",
              description: context.watch<SettingsProvider>().isDarkMode
                  ? "Switch to Light Mode"
                  : "Switch to Dark Mode",
              state: context.watch<SettingsProvider>().isDarkMode,
              onChanged: (state) {
                context.read<SettingsProvider>().saveDarkModeSettings(state);
              },
            ),
            SizedBox.square(dimension: 16),
            SwitchTextWidget(
              title: "Restaurant Notifications",
              description:
                  context.watch<SettingsProvider>().isNotificationEnabled
                      ? "Disable Notifications"
                      : "Enable Notifications",
              state: context.watch<SettingsProvider>().isNotificationEnabled,
              onChanged: (state) {
                var isPermissionGranted =
                    context.read<LocalNotificationProvider>().permission ??
                        false;
                if (!isPermissionGranted) {
                  _requestPermission();
                  return;
                }

                if (state) {
                  _runBackgroundPeriodicTask();
                } else {
                  _cancelAllTaskInBackground();
                }

                context
                    .read<SettingsProvider>()
                    .saveNotificationSettings(state);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }

  void _runBackgroundPeriodicTask() async {
    context.read<WorkmanagerService>().runPeriodicTask();
  }

  void _cancelAllTaskInBackground() async {
    context.read<WorkmanagerService>().cancelAllTask();
  }
}
