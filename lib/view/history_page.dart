import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/history_viewmodel.dart';

class HistoryPage extends StatefulWidget {
  final int userId;

  HistoryPage({required this.userId});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int? expandedIndex;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final viewModel = Provider.of<HistoryViewModel>(context, listen: false);
      viewModel.fetchHistory(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: Consumer<HistoryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          }
          if (viewModel.historyList.isEmpty) {
            return Center(child: Text('Tarix toza'));
          }

          return ListView.builder(
            itemCount: viewModel.historyList.length,
            itemBuilder: (context, index) {
              final history = viewModel.historyList[index];
              final isExpanded = expandedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? null : index;
                  });
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history.products[0].name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                            'From: ${history.products[0].fromLocation} → ${history.products[0].toLocation}'),
                        if (isExpanded) ...[
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.flag, size: 20),
                              SizedBox(width: 8),
                              Text('Country: ${history.country.name}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 20),
                              SizedBox(width: 8),
                              Text('Driver: ${history.driver.fullname}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.directions_car_rounded, size: 20),
                              SizedBox(width: 8),
                              Text(
                                  'Car: ${history.car.name}, ${history.car.number}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.fire_truck, size: 20),
                              SizedBox(width: 8),
                              Text(
                                  'Fourgon: ${history.fourgon.name}, ${history.fourgon.number}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.monetization_on, size: 20),
                              SizedBox(width: 8),
                              Text('Price: ${history.price}'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 20),
                              SizedBox(width: 8),
                              Text('Date: ${history.createdAt}'),
                            ],
                          ),

                          // Clients
                          if (history.clients.isNotEmpty) ...[
                            Divider(),
                            ...history.clients.map((client) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                          'Client: ${client.firstName} ${client.lastName}'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 20),
                                      SizedBox(width: 8),
                                      Text('Phone: ${client.number}'),
                                    ],
                                  ),
                                  ...client.products.map((product) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.shopping_cart,
                                                  size: 20),
                                              SizedBox(width: 8),
                                              Text('Product: ${product.name}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.monetization_on,
                                                  size: 20),
                                              SizedBox(width: 8),
                                              Text('Price: ${product.price}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, size: 20),
                                              SizedBox(width: 8),
                                              Text(
                                                  'From: ${product.fromLocation} → ${product.toLocation}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  SizedBox(height: 12),
                                ],
                              );
                            }).toList(),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
