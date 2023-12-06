import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:countdowner/ui/components/custom_button.dart';
import 'package:countdowner/utils/play_audio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int seconds = 20;
  int prevValue = 0;
  bool enable = true;
  bool isRunning = false;
  bool isCompleted = true;

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black54,
              Colors.black45,
              Colors.blueGrey,
              Colors.blue,
              Colors.redAccent,
              Colors.black45,
              Colors.black54,
              Colors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularCountDownTimer(
                  controller: _controller,
                  width: 200,
                  strokeWidth: 20,
                  height: 200,
                  duration:seconds,
                  isTimerTextShown: true,
                  isReverse: true,
                  fillColor: Colors.greenAccent,
                  ringColor: Colors.blue,
                  onComplete: () {
                   resetTimer();
                  },
                  isReverseAnimation: true,
                  onChange: (value){
                    if(value != prevValue.toString()){
                      prevValue = int.parse(value);
                      isCompleted = false;
                      debugPrint("Value is $value and audio is $enable");
                      if(!enable && prevValue < 5){
                        PlayKeyAudio().playAudio();
                      }
                      if(int.parse(value) < 0){
                        isCompleted = false;
                      }
                      else {
                        isCompleted = true;
                        try{
                          setState(() {});
                        }
                            catch(e){}
                      }
                    }
                  },
              ),
              const SizedBox(height: 20,),
              Switch(value: !enable, onChanged: (value){
                debugPrint("Value is $value");
                setState(() {
                  enable = !value;
                });
              }),
              const SizedBox(height: 20,),
              CustomButton(
                title: isCompleted? "Start" : isRunning? "Pause": "Resume", onTap: () {
                 toggleTimer();

              },),
              const SizedBox(height: 10,),
              if(!isCompleted) CustomButton(
                title:"LET'S STOP I'M FULL NOW",
                onTap: () {
                  resetTimer();
                },
                buttonColor: Colors.transparent,
              ),
            ],
        ),
      ),
    );
  }

  void toggleTimer() {

    if(isCompleted && !isRunning){
      isCompleted = false;
      startTimer(20);
    }
   else if (isRunning) {
      pauseTimer();
    } else {
      resumeTimer();
    }

    isRunning = !isRunning;
  }



  void startTimer(int seconds) {
    setState(() {
      isCompleted = false;
      isRunning = true;
    });
    _controller.restart(duration: seconds);
  }

  void pauseTimer() {
    _controller.pause();
    setState(() {
      isRunning = false;
    });
  }

  void resumeTimer() {
    _controller.resume();
    isRunning = true;
    setState(() {});

  }

  void resetTimer() {
    _controller.reset();
    isRunning = false;
    isCompleted = true;
    seconds = 20;
    setState(() {

    });

  }
}
