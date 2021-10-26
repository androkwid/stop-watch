import 'dart:async';

import 'package:flushbar/flushbar.dart';
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
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Color> _colors = [Color(0XFFf06c00), Color(0XEDf06c00)];
  double _bevelr = 5.0, _bevels = 5.0, _bevell = 5.0;
  CurveType _curveTyper = CurveType.flat,
      _curveTypes = CurveType.flat,
      _curveTypel = CurveType.flat;
  int _previousLap = 0;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _laps = [];
    _previousLap = 0;
  }

  void handleStartStop(String btn) {
    switch (btn) {
      case 'r':
        _previousLap = 0;
        _stopwatch.reset(); // Reset
        break;
      case 's':
        _stopwatch.isRunning
            ? _stopwatch.stop()
            : _stopwatch.start(); // Start /Stop
        break;
      case 'l':
        {
          int lap = _stopwatch.elapsedMilliseconds - _previousLap;
          _previousLap = _stopwatch.elapsedMilliseconds;
          _laps.add(formatTime(lap).toString());
          Flushbar(
            message: "New lap added",
            flushbarStyle: FlushbarStyle.FLOATING,
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 2),
          )..show(context);
        } // lap
        break;
    }

    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    setState(() {
      _curveTyper = CurveType.flat;
      _curveTypes = CurveType.flat;
      _curveTypel = CurveType.flat;
      _bevelr = 5.0;
      _bevels = 5.0;
      _bevell = 5.0;
    }); // re-render the page
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 0),
          width: _size.width,
          height: _size.height,
          decoration: BoxDecoration(
            color: Color(0XFF121212),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: NeuText(
                    formatTime(_stopwatch.elapsedMilliseconds),
                    emboss: false,
                    parentColor: Colors.black,
                    spread: 2,
                    depth: 100,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 62),
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
                    onTapDown: (details) {
                      setState(() {
                        _curveTyper = CurveType.concave;
                        _bevelr = 0.0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: NeuCard(
                        width: 75,
                        height: 75,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        bevel: _bevelr,
                        decoration: NeumorphicDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.amber,
                        curveType: _curveTyper,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: _stopwatch.isRunning
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      handleStartStop('s');
                    },
                    onTapDown: (details) {
                      setState(() {
                        _curveTypes = CurveType.concave;
                        _bevels = 0.0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: NeuCard(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        bevel: _bevels,
                        decoration: NeumorphicDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.amber,
                        curveType: _curveTypes,
                        child: Text(
                          _stopwatch.isRunning ? 'Stop' : 'Start',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: _stopwatch.isRunning
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      handleStartStop('l');
                    },
                    onTapDown: (details) {
                      setState(() {
                        _curveTypel = CurveType.concave;
                        _bevell = 0.0;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: NeuCard(
                        width: 75,
                        height: 75,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        bevel: _bevell,
                        decoration: NeumorphicDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.amber,
                        curveType: _curveTypel,
                        child: Text(
                          'Lap',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: _stopwatch.isRunning
                                  ? Colors.red
                                  : Colors.blue),
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
