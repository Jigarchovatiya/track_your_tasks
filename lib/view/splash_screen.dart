import 'package:flutter/material.dart';
import 'package:todo_app/res/constant/app_assets.dart';
import 'package:todo_app/res/constant/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //     const Duration(seconds: 4),
  //     () => Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const HomeScreen(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.splashBg,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppAssets.logo,
                height: height / 3,
              ),
            ),
            SizedBox(height: height / 50),
            const Center(
              child: Text(
                "Track your Tasks",
                style: TextStyle(
                  color: AppColors.logoText,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
