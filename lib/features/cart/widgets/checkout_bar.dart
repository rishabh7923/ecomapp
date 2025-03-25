import 'package:ecomapp/data/cart_items.dart';
import 'package:flutter/material.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({super.key});

  double getPrice() {
    double totalPrice = 0;
    
    cartItems.forEach((element) {
      totalPrice += element.price * element.quantity;
    });
    
    return totalPrice;
  }

  int getCartItemCount() => cartItems.fold(0, (total, element) => total + element.quantity);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amounted Price', style: TextStyle(fontSize: 15),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${getPrice().toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pink),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const Text('Checkout'),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: Text(
                        '${getCartItemCount()}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}