import 'package:ecomapp/data/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomapp/features/catalogue/bloc/catalogue_bloc.dart';

class CartIconWidget extends StatefulWidget {
  final CatalogueBloc catalogueBloc;

  const CartIconWidget({
    super.key,
    required this.catalogueBloc,
  });

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogueBloc, CatalogueState>(
      bloc: widget.catalogueBloc,
      buildWhen: (previous, current) => 
          current is CatalogueCartRefreshedActionState,
      listener: (context, state) {

      },
      builder: (context, state) {
        int itemCount = cartItems.fold(0, (previousValue, element) => previousValue + element.quantity);
        
        return IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.shopping_cart),
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$itemCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              
              ),
            ],
          ),
          onPressed: () {
            widget.catalogueBloc.add(CatalogueCartButtonNavigationEvent());
          },
        );
      },
    );
  }
}