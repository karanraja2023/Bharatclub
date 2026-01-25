import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 Add this import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes.dart';
import 'app/routes_name.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  // This line removes the '#' from the URL
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: kIsWeb
          ? const Size(360, 690) // Web design base
          : (Platform.isAndroid || Platform.isIOS)
          ? const Size(411.43, 867.43)
          : const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bharat Club',
          initialRoute: AppRoutes.splashScreen,
          getPages: AppPages.pages,
          builder: (context, widget) {
            // Use MediaQuery to detect width instead of 'constraints'
            double width = MediaQuery.of(context).size.width;
            bool isWeb = width > 800;

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // Logic: If Web, force text scale to 1.0 (Mobile Size).
                // If Mobile, use the system's default text scaling.
                textScaler: TextScaler.linear(isWeb ? 1.0 : 1.0),
              ),
              child: widget!,
            );
          },
          home: child,
        );
      },
    );
  }
}
