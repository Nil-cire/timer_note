import 'package:flutter/material.dart';

class TimeUnitVew extends StatelessWidget {
  const TimeUnitVew(this.time, this.unit, {Key? key}) : super(key: key);
  final String time;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time.toString(),
            style: const TextStyle(fontSize: 60, color: Colors.black),
          ),
          Text(
            unit,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )
        ],
      ),
    );
  }
}
