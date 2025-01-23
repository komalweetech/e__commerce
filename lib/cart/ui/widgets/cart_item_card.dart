import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cart_bloc.dart';
import '../../data/models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
            ),
            child: Image.network(
              item.product.thumbnail,
              width: 100,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),

          // Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context.read<CartBloc>().add(RemoveFromCart(item));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.product.brand,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.product.discountPercentage > 0) ...[
                            Text(
                              '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '\$${(item.product.price * (1 - item.product.discountPercentage / 100) * item.quantity).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ] else ...[
                            Text(
                              '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          _QuantityButton(
                            icon: Icons.remove,
                            onPressed: item.quantity > 1
                                ? () {
                                    context.read<CartBloc>().add(
                                          UpdateQuantity(
                                            item,
                                            item.quantity - 1,
                                          ),
                                        );
                                  }
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _QuantityButton(
                            icon: Icons.add,
                            onPressed: () {
                              context.read<CartBloc>().add(
                                    UpdateQuantity(
                                      item,
                                      item.quantity + 1,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _QuantityButton({
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
      ),
    );
  }
}