import 'package:ecommerce/helpers/style.dart';
import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/provider/app.dart';
import 'package:ecommerce/provider/user.dart';
import 'package:ecommerce/services/order.dart';
import 'package:ecommerce/widgets/custom_text.dart';
import 'package:ecommerce/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart", color: Colors.red, weight: FontWeight.bold, size: 20),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: appProvider.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: userProvider.userModel.cart.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: red.withOpacity(0.2),
                              offset: Offset(3, 2),
                              blurRadius: 30)
                        ]),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            userProvider.userModel.cart[index].image,
                            height: 120,
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: userProvider
                                              .userModel.cart[index].name +
                                          "\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          "\$${userProvider.userModel.cart[index].price / 100} \n\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                ]),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: red,
                                  ),
                                  onPressed: () async {
                                    appProvider.changeIsLoading();
                                    bool success =
                                        await userProvider.removeFromCart(
                                            cartItem: userProvider
                                                .userModel.cart[index]);
                                    if (success) {
                                      userProvider.reloadUserModel();
                                      print("Item added to cart");
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                      Text("Remove from cart !")));

                                      appProvider.changeIsLoading();
                                      return;
                                    } else {
                                      appProvider.changeIsLoading();
                                    }
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: " \$${userProvider.userModel.totalCartPrice / 100}",
                      style: TextStyle(
                          color: black,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: black),
                child: ElevatedButton(
                    onPressed: () {
                      if (userProvider.userModel.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Your cart is emty',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You will be charged \$${userProvider.userModel.totalCartPrice / 100} upon delivery!',
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            var uuid = Uuid();
                                            String id = uuid.v4();
                                            _orderServices.createOrder(
                                                userId: userProvider.user.uid,
                                                id: id,
                                                description:
                                                    "Some random description",
                                                status: "complete",
                                                totalPrice: userProvider
                                                    .userModel.totalCartPrice,
                                                cart: userProvider
                                                    .userModel.cart);
                                            for (CartItemModel cartItem
                                                in userProvider
                                                    .userModel.cart) {
                                              bool value = await userProvider
                                                  .removeFromCart(
                                                      cartItem: cartItem);
                                              if (value) {
                                                userProvider.reloadUserModel();
                                                print("Item added to cart");
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                                Text("Removed from cart")));






                                              } else {
                                                print("ITEM WAS NOT REMOVED");
                                              }
                                            }
                                            var currentState;
                                            currentState.ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Order created!")));
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Accept",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                       ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "Check out",
                      size: 20,
                      color: white,
                      weight: FontWeight.normal,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
