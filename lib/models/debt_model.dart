class ClientDebtModel {
  final String client;
  final double amountInUsd;
  final double amountOriginal;
  final String currency;

  ClientDebtModel({
    required this.client,
    required this.amountInUsd,
    required this.amountOriginal,
    required this.currency,
  });

  factory ClientDebtModel.fromJson(Map<String, dynamic> json) {
    return ClientDebtModel(
      client: json['client'],
      amountInUsd: (json['amount_in_usd'] as num).toDouble(),
      amountOriginal: (json['amount_original'] as num).toDouble(),
      currency: json['currency'],
    );
  }
}

class HistoryDebtModel {
  final int raysId;
  final String driver;
  final List<ClientDebtModel> clients;

  HistoryDebtModel({
    required this.raysId,
    required this.driver,
    required this.clients,
  });

  factory HistoryDebtModel.fromJson(Map<String, dynamic> json) {
    return HistoryDebtModel(
      raysId: json['rays_id'],
      driver: json['driver'],
      clients: (json['clients'] as List)
          .map((client) => ClientDebtModel.fromJson(client))
          .toList(),
    );
  }
}
