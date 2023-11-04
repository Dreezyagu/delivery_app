import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojembaa_mobile/features/preliminary/screens/splash_page.dart';
import 'package:ojembaa_mobile/utils/components/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ojembaa',
      theme: ThemeData(
          fontFamily: "QanelasSoft",
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: AppColors.primary_light,
            centerTitle: true,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary)
              .copyWith(background: AppColors.primary_light)),
      home: const SplashPage(),
    );
  }
}
