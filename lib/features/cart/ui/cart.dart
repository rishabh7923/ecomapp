import 'package:ecomapp/features/cart/bloc/cart_bloc.dart';
import 'package:ecomapp/features/cart/widgets/cart_product_card.dart';
import 'package:ecomapp/features/cart/widgets/checkout_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    super.initState();
    cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.pink[50],
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              final totalPrice = successState.cartItems.fold(
                0.0,
                (sum, item) => sum + (item.price * item.quantity),
              );

              return Column(
                children: [
                  // Cart Items List
                  Expanded(
                    child: Container(
                      color: Colors.pink[50],
                      child: ListView.builder(
                        itemCount: successState.cartItems.length,
                        itemBuilder: (context, index) {
                          final product = successState.cartItems[index];
                          return CartProductCardWidget(
                            productDataModel: product,
                            cartBloc: cartBloc,
                          );
                        },
                      ),
                    ),
                  ),

                  CheckoutBar()
                ],
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
