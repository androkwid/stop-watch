import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class WatchScreen extends StatefulWidget {
  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  Size _size;
  Stopwatch _stopwatch;
  Timer _timer;
  List<String> _laps;
  final List<Color> _colors = [Color(0XFFf06c00), Color(0XEDf06c00)];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _laps = [];
  }

  void handleStartStop(String btn) {
    switch (btn) {
      case 'r':
        _stopwatch.reset(); // Reset
        break;
      case 's':
        _stopwatch.isRunning
            ? _stopwatch.stop()
            : _stopwatch.start(); // Start /Stop
        break;
      case 'l':
        {
          _laps.add(formatTime(_stopwatch.elapsedMilliseconds).toString());
        } // lap
        break;
    }

    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    setState(() {}); // re-render the page
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: _size.width,
          height: _size.height,
          decoration: BoxDecoration(
            color: Color(0XFF121212),
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: _colors,
            // ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    formatTime(_stopwatch.elapsedMilliseconds),
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 42),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Laps",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor:
                          index % 2 == 0 ? Colors.grey[200] : Colors.grey[350],
                      contentPadding: EdgeInsets.zero,
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _laps.removeAt(index);
                        },
                      ),
                      leading: Icon(Icons.play_arrow),
                      title: Text(_laps[index]),
                    );
                  },
                  itemCount: _laps.length,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      handleStartStop('r');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: NeuCard(
                        width: 75,
                        height: 75,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        bevel: 12,
                        decoration: NeumorphicDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.amber,
                        curveType: CurveType.concave,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _stopwatch.isRunning
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      handleStartStop('s');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: NeuCard(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        bevel: 12,
                        decoration: NeumorphicDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.amber,
                        curveType: CurveType.concave,
                        child: Text(
                          _stopwatch.isRunning ? 'Stop' : 'Start',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: _stopwatch.isRunning
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      handleStartStop('l');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: NeuCard(
                        width: 75,
                        height: 75,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        bevel: 12,
                        decoration: NeumorphicDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.amber,
                        curveType: CurveType.concave,
                        child: Text(
                          'Lap',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: _stopwatch.isRunning
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  var milli = milliseconds > 1000
      ? (milliseconds % 1000).toString().padLeft(3, '0')
      : milliseconds.toString().padLeft(3, '0');
  return "$hours:$minutes:$seconds:$milli";
}
