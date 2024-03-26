import 'package:flutter/material.dart';
import 'package:sensors_shake/const/colors.dart';
import 'package:sensors_shake/screen/root_screen.dart';

// https://github.com/codefactory-co/golden-rabbit-flutter-novice/blob/main/ch10/random_dice/lib/screen/root_screen.dart

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor, // 노브 색상
          activeTrackColor: primaryColor, // 노브가 이동한 트랙 색상

          // 노브가 아직 이동하지 않은 트랙 색상
          inactiveTrackColor: primaryColor.withOpacity(0.3),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor, // 선택 상태 색
          unselectedItemColor: secondaryColor, // 비선택 상태 색
          backgroundColor: backgroundColor, // 배경 색
        ),
      ),
      home: RootScreen(),
    ),
  );
}
