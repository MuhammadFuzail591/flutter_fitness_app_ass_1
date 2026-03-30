import 'package:flutter/material.dart';

class CalorieCounter extends StatefulWidget {
  const CalorieCounter({super.key});

  @override
  State<CalorieCounter> createState() => _CalorieCounterState();
}

class _CalorieCounterState extends State<CalorieCounter> {
  int calorieGoal = 1500;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff92A3FD).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Daily Calorie Goal',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight(600),
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '$calorieGoal',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xff92A3FD),
            ),
          ),
          Text(
            'calories',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff7B6F72),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (calorieGoal >= 100) {
                      calorieGoal -= 100;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff92A3FD),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                ),
                child: Icon(Icons.remove, color: Colors.white),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    calorieGoal += 100;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff92A3FD),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(12),
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
