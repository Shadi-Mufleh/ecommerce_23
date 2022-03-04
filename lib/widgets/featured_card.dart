import 'package:ecommerce/helpers/common.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/product_details.dart';
import 'produ';
import 'package:ecommerce/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/product.dart';

class Featured_Card extends StatelessWidget {

const Featured_Card({
  Key? key,
  this.product = ProductModel()
  }) : super(key: key);
final ProductModel= product;

  static get product => null;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: (){
          changeScreen(context, Product_Details(product: product));
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                Color.fromARGB(62, 168, 174, 201),
                offset: Offset(0, 9),
                blurRadius: 14,
              ),
            ],
          ),
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
                    height: 220,
                    width: 200,
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),

                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container()
                      )),
                ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: RichText(text: TextSpan(children: [
                        TextSpan(text: '${product.name} \n', style: TextStyle(fontSize: 18)),
                        TextSpan(text: '\$${product.price / 100} \n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                      ]))
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
