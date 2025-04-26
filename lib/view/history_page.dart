import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../view_model/history_viewmodel.dart';

class HistoryPage extends StatefulWidget {
  final int userId;

  const HistoryPage({super.key, required this.userId});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int? expandedIndex; // Qaysi ExpansionTile ochilganini ushlab turish uchun

  @override
  void initState() {
    super.initState();
    Provider.of<HistoryViewModel>(context, listen: false)
        .fetchHistory(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.teal
        : Colors.blue;
    final Color borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.teal
        : Colors.blue;

    return GestureDetector(
      onTap: () {
        setState(() {
          expandedIndex = 5; // Boshqa joyga bosilganda yopiladi
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Тарих'),
        ),
        body: Consumer<HistoryViewModel>(
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

            if (viewModel.historyList.isEmpty) {
              return const Center(child: Text('Тарих мавжуд эмас'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: viewModel.historyList.length,
              itemBuilder: (context, index) {
                final history = viewModel.historyList[index];
                final client =
                    history.client.isNotEmpty ? history.client.first : null;
                final product = client?.products.isNotEmpty == true
                    ? client!.products.first
                    : null;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Card(
                    elevation: 3,
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        key: Key(index.toString()),
                        initiallyExpanded: expandedIndex == index,
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            expandedIndex = isExpanded ? index : null;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        tilePadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        title: Text(
                          product?.name ?? "Маҳсулот йўқ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        subtitle: Text(
                          'From: ${product?.fromLocation ?? "Номаълум"} → To: ${product?.toLocation ?? "Номаълум"}',
                          style: const TextStyle(fontSize: 13),
                        ),
                        leading: Icon(Icons.local_shipping, color: iconColor),
                        trailing: Icon(Icons.expand_more, color: iconColor),
                        children: [
                          _infoTile(iconColor, Icons.person, 'Хайдовчи',
                              history.driver.fullname),
                          _infoTile(iconColor, Icons.phone, 'Телефон рақам',
                              history.driver.phoneNumber),
                          _infoTile(
                              iconColor,
                              Icons.directions_car,
                              'Автомобил',
                              '${history.car.name} (${history.car.number})'),
                          _infoTile(iconColor, Icons.fire_truck, 'Фургон',
                              '${history.fourgon.name} (${history.fourgon.number})'),
                          _infoTile(iconColor, Icons.speed, 'Километер',
                              '${history.kilometer} км'),
                          _infoTile(iconColor, Icons.monetization_on,
                              'Умумий нарх', '${history.price} сўм'),
                          _infoTile(
                              iconColor,
                              Icons.calendar_today,
                              'Сана',
                              DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(history.createdAt))),
                          const SizedBox(height: 6),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "Маҳсулотлар",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          ...history.products.map((p) => ListTile(
                                dense: true,
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: -4),
                                minVerticalPadding: 0,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                leading: Icon(Icons.shopping_bag,
                                    color: iconColor, size: 20),
                                title: Text(
                                  p.name,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                subtitle: Text(
                                  'From: ${p.fromLocation ?? "Номаълум"} → To: ${p.toLocation ?? "Номаълум"}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                trailing: Text('x${p.count}',
                                    style: const TextStyle(fontSize: 12)),
                              )),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "Харажатлар",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          if (history.expenses.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Харажатлар мавжуд эмас",
                                style: TextStyle(fontSize: 13),
                              ),
                            )
                          else
                            ...history.expenses.map((e) => ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  minVerticalPadding: 0,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  leading: Icon(Icons.attach_money_sharp,
                                      color: iconColor, size: 20),
                                  title: Text(
                                    '${e.name}: ${e.price}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    e.description ?? '',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _infoTile(Color iconColor, IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Icon(icon, color: iconColor, size: 20),
        title: Text(
          '$title: $value',
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
