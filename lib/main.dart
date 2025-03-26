import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/providers/portfolio_provider.dart';

import 'utils/app_router.dart';
import 'utils/theme.dart';
import 'views/pointer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PortfolioProvider(),
        ),        
      ],
      child: WebPointer(
        circleColor: const Color(0xFFD9279B),
        roundColor: const Color(0xFFD9279B),
        child: MaterialApp.router(
          title: 'Jackpotloot',
          debugShowCheckedModeBanner: false,
          theme: lightPinkTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
