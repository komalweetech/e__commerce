import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../../favorite/bloc/favorite_bloc.dart';
import '../../../cart/bloc/cart_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = 'M';
  String selectedColor = 'Black';

  @override
  void initState() {
    super.initState();
    selectedColor = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.product.title,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      widget.product.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.brand,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Rating
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < widget.product.rating.floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(${widget.product.rating})',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          widget.product.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Size Selection
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: ['S', 'M', 'L', 'XL'].map((size) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(size),
                                selected: selectedSize == size,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                                backgroundColor: Colors.grey[200],
                                selectedColor: Colors.black,
                                labelStyle: TextStyle(
                                  color: selectedSize == size
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        // Color Selection
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: ['Black', 'White', 'Red', 'Blue'].map((color) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(color),
                                selected: selectedColor == color,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedColor = color;
                                  });
                                },
                                backgroundColor: Colors.grey[200],
                                selectedColor: Colors.black,
                                labelStyle: TextStyle(
                                  color: selectedColor == color
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        // Shipping Info
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Shipping info',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Implement shipping info
                          },
                        ),
                        const Divider(),
                        // Support
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Support',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Implement support
                          },
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      final isFavorite = state.favorites.contains(widget.product);
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            context
                                .read<FavoriteBloc>()
                                .add(RemoveFromFavorite(widget.product));
                          } else {
                            context
                                .read<FavoriteBloc>()
                                .add(AddToFavorite(widget.product));
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.product.stock > 0
                        ? () {
                            // Add to cart
                            context.read<CartBloc>().add(
                                  AddToCart(
                                    product: widget.product,
                                    quantity: 1,
                                  ),
                                );

                            // Show success snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Added to cart'),
                                action: SnackBarAction(
                                  label: 'VIEW CART',
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'cart');
                                  },
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      widget.product.stock > 0 ? 'ADD TO CART' : 'OUT OF STOCK',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}