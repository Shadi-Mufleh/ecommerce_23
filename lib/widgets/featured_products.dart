

import 'package:ecommerce/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import 'featured_card.dart';
import 'package:ecommerce/widgets/featured_card.dart' show Featured_Card;

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
        height: 230,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productProvider.products.length,
            itemBuilder: (_, index) {
              return Featured_Card(
                product: productProvider.products[index],
              );
            }));
  }
}
