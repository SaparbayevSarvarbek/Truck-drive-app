import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/view_model/debt_view_model.dart';

class DebtPage extends StatefulWidget {
  final int userId;

  const DebtPage({super.key, required this.userId});

  @override
  State<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DebtViewModel>(context, listen: false)
        .fetchHistory(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color iconColor = isDark ? Colors.teal : Colors.blue;

    return Scaffold(
      appBar: AppBar(title: const Text("Қарздорлик")),
      body: Consumer<DebtViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Lottie.asset('assets/lottie/circle.json'),
              ),
            );
          }

          if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          }

          if (viewModel.histories.isEmpty) {
            return const Center(child: Text("Qarzdorliklar topilmadi"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: viewModel.histories.length,
            itemBuilder: (context, index) {
              final item = viewModel.histories[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: iconColor, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...item.clients.map((client) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person,
                                      color: iconColor, size: 22),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Мижоз: ${client.client}",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.monetization_on,
                                      color: iconColor, size: 22),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Сумма: ${client.amountInUsd.toStringAsFixed(2)} ${client.currency}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
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
