import 'package:ecomapp/features/cart/bloc/cart_bloc.dart';
import 'package:ecomapp/features/cart/widgets/quantity_stepper.dart';
import 'package:ecomapp/features/catalogue/models/product_data.dart';
import 'package:flutter/material.dart';

class CartProductCardWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartProductCardWidget({
    super.key,
    required this.productDataModel,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                productDataModel.thumbnail,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 8.0),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    productDataModel.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, 
                  ),
                  const SizedBox(height: 1.0),
                  Text(
                    productDataModel.brand ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              
                              if (productDataModel.discountPercentage != null &&
                                  productDataModel.discountPercentage! > 0)
                                Text(
                                  '\$${(productDataModel.price / (1 - productDataModel.discountPercentage! / 100)).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    decoration:
                                        TextDecoration
                                            .lineThrough, 
                                  ),
                                ),
                              const SizedBox(width: 4.0),
                              
                              Text(
                                '\$${productDataModel.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            productDataModel.discountPercentage != null &&
                                    productDataModel.discountPercentage! > 0
                                ? '${productDataModel.discountPercentage}% OFF'
                                : '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      QuantityStepperWidget(productDataModel: productDataModel, cartBloc: cartBloc)
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
