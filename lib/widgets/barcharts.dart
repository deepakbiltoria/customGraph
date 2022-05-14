import 'package:abc/helper/get_color_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarCharts extends StatelessWidget {
  final List<double> expences;

  const BarCharts(this.expences);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;

    expences.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Weekly Spending',
              style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                ),
              ),
              Text(
                'Nov 10, 2019 - Dec 10, 2020',
                style: TextStyle(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                  size: 30.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                  label: 'Su',
                  amountSpent: expences[0],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Mo',
                  amountSpent: expences[1],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Tu',
                  amountSpent: expences[2],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'We',
                  amountSpent: expences[3],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Th',
                  amountSpent: expences[4],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Fr',
                  amountSpent: expences[5],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Sa',
                  amountSpent: expences[6],
                  mostExpensive: mostExpensive)
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double _maxBarHeight = 150.0;
  const Bar(
      {required this.label,
      required this.amountSpent,
      required this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    var barHeight = amountSpent / mostExpensive * _maxBarHeight;
    //double percent = amountSpent / mostExpensive;
    return Column(
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Theme.of(context).primaryColor,
          ), //getColor(context, percent)),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          label,
          style: TextStyle(
              letterSpacing: 1.2, fontWeight: FontWeight.w600, fontSize: 16.0),
        )
      ],
    );
  }
}
