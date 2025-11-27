import 'package:flutter/material.dart';

import 'src/themes/index.dart';
import 'src/presentation/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmsit',
      debugShowCheckedModeBanner: false,
      theme: getGeneralTheme(Brightness.dark),
      routes: AppRoutes.routes,
      initialRoute: '/',
    );
  }
}