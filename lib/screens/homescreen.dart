import 'package:abc/data/data.dart';
import 'package:abc/helper/get_color_helper.dart';
import 'package:abc/models/category_model.dart';
import 'package:abc/models/expense_model.dart';
import 'package:abc/widgets/barcharts.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryScreen(category),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${category.name}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${(category.maxAmount).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double maxBarWidth = constraints.maxWidth;
              double percent =
                  (category.maxAmount - totalAmountSpent) / category.maxAmount;
              double barwidth = percent *
                  maxBarWidth; // here percent will be btw 0-1 so after multiplication of percent and MaxbarWidth the resultant will always be less then or equal to  MaxbarWidth

              if (barwidth < 0) {
                barwidth = 0;
              } // condtion check in case percent is negative or greater than 1 thus making barwidth negetive or greater than MaxBarWidth
              return Stack(
                children: [
                  Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  Container(
                    height: 18.0,
                    width: barwidth,
                    decoration: BoxDecoration(
                        color: getColor(context, percent),
                        borderRadius: BorderRadius.circular(15.0)),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            expandedHeight: 100.0,
            floating: true,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 30.0,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Simple Budget'),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    size: 30.0,
                  ))
            ],
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ]),
                  child: BarCharts(weeklySpending),
                );
              } else {
                final Category category = categories[index -
                    1]; // we use index-1 becoz we need to start categories list from index zero thus we modify index from 1 to back to 0
                double totalAmountSpent = 0;
                category.expenses.forEach((Expense expense) {
                  totalAmountSpent += expense.cost;
                });
                return _buildCategory(category, totalAmountSpent);
              }
            }, childCount: 1 + categories.length),
          ),
        ],
      ),
    );
  }
}
