class ExpensesDataModel{
  String user;
  String expense;
  String price;
  String description;

  ExpensesDataModel(
      { required this.user, required this.expense, required this.price, required this.description});
  Map<String, String> toMap() {
    return {
      "price": price,
      "description": description,
      "driver": user,
      "chiqimlar":expense,
    };
  }
}