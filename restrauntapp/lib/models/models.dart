class Item {
  late final String name;
  final String image;
  int quantity;
  final num price;
  final String? description;
  Item(
      {required this.image,
      this.description,
      required this.name,
      required this.quantity,
      required this.price});
}
