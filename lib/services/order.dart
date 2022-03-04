import 'package:ecommerce/main.dart';
import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OrderServices{
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createOrder({required String userId ,required String id,required String description,required String status ,required List<CartItemModel> cart, required int totalPrice}) async {
    List<Map> convertedCart = [];

    for(CartItemModel item in cart){
      convertedCart.add(item.toMap());
    }

    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({required String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });

}