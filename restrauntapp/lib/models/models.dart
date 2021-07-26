class Item {
  late final String name;
  final String image;
  int quantity;
  final String itemID;
  final num price;
  final String description;
  Item(
      {required this.image,
      required this.itemID,
      required this.description,
      required this.name,
      required this.quantity,
      required this.price});
}
