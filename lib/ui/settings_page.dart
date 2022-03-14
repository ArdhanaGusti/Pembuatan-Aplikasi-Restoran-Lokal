import 'package:flutter/material.dart';
import 'package:local_restaurant_2/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ListTile(
            title: Text('Restaurant Notification'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    scheduled.scheduledNews(value);
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
