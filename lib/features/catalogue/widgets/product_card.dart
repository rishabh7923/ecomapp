import 'package:ecomapp/features/catalogue/bloc/catalogue_bloc.dart';
import 'package:ecomapp/features/catalogue/models/product_data.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CatalogueBloc catalogueBloc;

  const ProductCardWidget({
    super.key,
    required this.productDataModel,
    required this.catalogueBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    productDataModel.thumbnail,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  bottom: 4,
                  right: 4,
                  child: ElevatedButton(
                    onPressed: () {
                      catalogueBloc.add(
                        CatalogueProductCartButtonClickedEvent(
                          clickedProduct: productDataModel,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      elevation: 2,
                      padding: EdgeInsets.zero,
                      minimumSize: Size(32, 32),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),

            
            Text(
              productDataModel.name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              maxLines: 2, 
              overflow: TextOverflow.ellipsis, 
            ),

            
            Text(
              productDataModel.brand ?? '',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              maxLines: 1, 
              overflow: TextOverflow.ellipsis, 
            ),

            const Spacer(), 
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (productDataModel.discountPercentage != null &&
                    productDataModel.discountPercentage! > 0)
                  Row(
                    children: [
                      
                      Text(
                        '\$${(productDataModel.price / (1 - productDataModel.discountPercentage! / 100)).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
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
                  )
                else
                  
                  Text(
                    '\$${productDataModel.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                if (productDataModel.discountPercentage != null &&
                    productDataModel.discountPercentage! > 0)
                  Text(
                    '${productDataModel.discountPercentage!.toStringAsFixed(1)}% OFF',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
