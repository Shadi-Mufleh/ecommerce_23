import 'package:ecommerce/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/product_details.dart';

class ProductServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot result= await _firestore.collection(collection).get();
        List<ProductModel> product = [];
        for (DocumentSnapshot products in result.docs) {
          products.add(ProductModel.fromSnapshot(products));
        }
        return product;
      }


  Future<List<ProductModel>> searchProducts({required String ProductName}) {
    // code to convert the first character to uppercase
    String searchKey = ProductName[0].toUpperCase() + ProductName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
      List<ProductModel> products = [];
      for (DocumentSnapshot product in result.docs) {
        products.add(ProductModel.fromSnapshot(product));
      }
      return products;
    });
  }
}
