import 'package:flutter/material.dart';

import '../../../resources/strings_maneger.dart';
import '../../../shared/component/app_background.dart';

class EnteredParkingSuccessfullyScreen extends StatelessWidget {
  const EnteredParkingSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        showAppBarIcons: true,
        customWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "you have successfully enter the parking Please adhere to the reserved period to not be charged a fine",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 32),
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(AppStrings.ok),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
