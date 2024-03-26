import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_shake/screen/home_screen.dart';
import 'package:sensors_shake/screen/settings_screen.dart';
import 'package:shake/shake.dart';
import 'package:soundpool/soundpool.dart';
import 'package:vibration/vibration.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 1.5;
  int number = 1;
  ShakeDetector? shakeDetector;

  // 사운드 처리
  //Soundpool pool = Soundpool(streamType: StreamType.music);
  Soundpool pool = Soundpool.fromOptions(
      options: const SoundpoolOptions(
    maxStreams: 10,
  ));

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this); // 컨트롤러 초기화하기
    controller!.addListener(tabListener); // 컨트롤러 속성이 변경될 때마다 실행할 함수 등록

    shakeDetector = ShakeDetector.autoStart(
      // 흔들기 감지 즉시 시작
      shakeSlopTimeMS: 25, // 감지 주기
      shakeThresholdGravity: threshold, // 감지 민감도
      onPhoneShake: onPhoneShake, // 감지 후 실행할 함수
    );
  }

  tabListener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener); // 리스너에 등록한 함수 등록 취소
    shakeDetector!.stopListening(); // 흔들기 감지 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller, // 컨트롤러 등록하기
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(
        number: number,
        threshold: threshold,
      ),
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      ),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {
        // 탭이 선택될 때마다 실행되는 함수
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }

  void onThresholdChange(double value) {
    setState(() {
      threshold = value;
    });
  }

  void onPhoneShake() {
    final rand = new Random();

    setState(() {
      number = rand.nextInt(6) + 1;
      Vibration.vibrate(duration: 150);
      playSound("assets/sounds/dice_roll.mp3");
    });
  }

  void playSound(String sound) async {
    int soundId = await rootBundle.load(sound).then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }
}
