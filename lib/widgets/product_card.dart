import 'package:ecommerce/helpers/common.dart';
import 'package:ecommerce/helpers/style.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../helpers/common.dart';
import '../helpers/style.dart';




import '../models/product.dart';
import 'loading.dart';


import 'package:ecommerce/screens/product_details.dart';

class Product_Card extends StatelessWidget {

  const Product_Card({ Key? key,
    required this.product

  }) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          changeScreen(context, Product_Details(product: product)
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey,
                    offset: Offset(-2, -1),
                    blurRadius: 5),
              ]),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      )),
                      Center(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: product.picture,
                          fit: BoxFit.cover,
                          height: 140,
                          width: 120,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: '${product.name} \n',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextSpan(
                    text: 'by: ${product.brand} \n\n\n\n',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  TextSpan(
                    text: '\$${product.price / 100} \t',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: product.sale ? 'ON SALE ' : "",

                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                  ),
                ], style: TextStyle(color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }

}
