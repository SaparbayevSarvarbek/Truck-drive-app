class Expense {

  final List<dynamic> texnics;
  final List<dynamic> balons;
  final List<dynamic> balonFurgons;
  final List<dynamic> optols;
  final List<dynamic> chiqimliks;
  final List<dynamic> arizalar;
  final List<dynamic> referenslar;
  final int totalUsd;

  Expense({
    required this.texnics,
    required this.balons,
    required this.balonFurgons,
    required this.optols,
    required this.chiqimliks,
    required this.arizalar,
    required this.referenslar,
    required this.totalUsd,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      texnics: json['texnics'] ?? [],
      balons: json['balons'] ?? [],
      balonFurgons: json['balon_furgons'] ?? [],
      optols: json['optols'] ?? [],
      chiqimliks: json['chiqimliks'] ?? [],
      arizalar: json['arizalar'] ?? [],
      referenslar: json['referenslar'] ?? [],
      totalUsd: json['total_usd'] ?? 0,
    );
  }
}
