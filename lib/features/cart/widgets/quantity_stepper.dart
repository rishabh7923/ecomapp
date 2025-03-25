import 'package:ecomapp/data/cart_items.dart';
import 'package:ecomapp/features/cart/bloc/cart_bloc.dart';
import 'package:ecomapp/features/catalogue/models/product_data.dart';
import 'package:flutter/material.dart';

class QuantityStepperWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const QuantityStepperWidget({
    super.key,
    required this.productDataModel,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItems.firstWhere(
      (element) => element.id == productDataModel.id,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(2.0),
      ),

      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed:
                () => cartBloc.add(
                  CartProductQuantityDecreasedEvent(product: product),
                ),
          ),
          Text(
            product.quantity.toString(),
            style: const TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:
                () => cartBloc.add(
                  CartProductQuantityIncreasedEvent(product: product),
                ),
          ),
        ],
      ),
    );
  }
}
