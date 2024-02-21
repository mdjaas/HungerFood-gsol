// CartModel
class CartModel {
  final String documentId;
  final String title;
  int qty;
  final String price;
  final String image;

  CartModel({
    required this.documentId,
    required this.title,
    required this.qty,
    required this.price,
    required this.image,
  });
}
