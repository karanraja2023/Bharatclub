import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 Add this import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes.dart';
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
      designSize: const Size(411.43, 867.43),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bharat Club',
          initialRoute: AppRoutes.splashScreen,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
