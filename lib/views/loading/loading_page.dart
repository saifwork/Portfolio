import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/providers/portfolio_provider.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double height = 100;
  double width = 100;
  Color color = Colors.amber;
  BorderRadiusGeometry radiusGeometry = BorderRadius.circular(8);
  final Random random = Random();
  Timer? _timer; // ✅ Timer for automatic updates

  @override
  void initState() {
    super.initState();

    /// ✅ Start API call after screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Provider.of<PortfolioProvider>(context, listen: false).getConfig();
        }
      });
    });

    /// ✅ Start auto-animation every 700ms
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (mounted) {
        setState(() {
          height = random.nextInt(150).toDouble() + 50; // Min 50px height
          width = random.nextInt(300).toDouble() + 50; // Min 50px width
          color = Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1,
          );
          radiusGeometry = BorderRadius.circular(random.nextInt(100).toDouble());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ✅ Stop the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          height: height,
          width: width,
          decoration: BoxDecoration(color: color, borderRadius: radiusGeometry),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }
}