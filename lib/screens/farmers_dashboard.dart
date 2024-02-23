import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:g_solution/widgets/app_bar_widget.dart';

class FarmersDashboard extends StatefulWidget{
  const FarmersDashboard({super.key});

  @override
  _FarmersDashboardState createState() => _FarmersDashboardState();
}

class _FarmersDashboardState extends State<FarmersDashboard>{

  List<dynamic> dataList = []; // Store the fetched data

  Future fetchPrice() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/commodities'));

      if (response.statusCode == 200) {
        setState(() {
          dataList = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Forecast",
        backgroundColor: Colors.transparent,
      ),
      body:
      ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    dataList[index]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Current Price:" +dataList[index]['current_price'].toString()
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, innerIndex) {
                    List<dynamic> forecastData =
                    dataList[index]['forecast_values'][innerIndex];
                    String monthName = forecastData[0];
                    double forecastedPrice = forecastData[1];
                    double percentageChange = forecastData[2];

                    return ListTile(
                      title: Text('$monthName'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Forecasted Price: $forecastedPrice'),
                          Text('Percentage Change: $percentageChange'),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}