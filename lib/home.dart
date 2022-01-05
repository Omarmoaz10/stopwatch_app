import 'dart:async';


import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'StopWatch',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                 Center(
                  child: Text(
                    '$digitalhours:$digitalminutes:$digitalseconds',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 360,
                    decoration: BoxDecoration(
                      color: const Color(0xFF323F68),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lap ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                '${laps[index]}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          (!started) ? start() : stop();
                        },
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Text(
                          (!started) ? "Start" : 'Pause',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    IconButton(
                      onPressed: () {
                        addlaps();
                      },
                      color: Colors.white,
                      icon: const Icon(Icons.flag),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          reset();
                        },
                        fillColor: Colors.blue,
                        shape: const StadiumBorder(),
                        child: const Text(
                          "Rest",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // the Logic
  int seconds = 0, minutes = 0, hours = 0;
  String digitalseconds = '00', digitalminutes = '00', digitalhours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  // stop function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // rest function
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitalseconds = '00';
      digitalminutes = '00';
      digitalhours = '00';
      started = false;
    });
  }

  // lap
  void addlaps() {
    String lap = "$digitalhours:$digitalminutes:$digitalseconds";
    setState(() {
      laps.add(lap);
    });
  }

  // start function
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHour = hours;
      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHour++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHour;
        digitalseconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitalhours = (hours >= 10) ? "$hours" : "0$hours";
        digitalminutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }
}
