abstract class Product {
  String productID;
  String productName;
  String productPhotoUrl;
  String productType;
  int productStock;
  int productPrice;
  Product({
    required this.productID,
    required this.productName,
    required this.productPhotoUrl,
    required this.productType,
    required this.productStock,
    required this.productPrice,
  });

  Map<String, dynamic> toMap();

  @override
  String toString() {
    return 'Product(productID: $productID, productName: $productName, photoUrl: $productPhotoUrl, productStock: $productStock, productPrice: $productPrice)';
  }
}
