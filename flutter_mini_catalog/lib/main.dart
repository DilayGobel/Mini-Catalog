import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'screens/discover_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Product> allProducts;
  final List<Product> cartItems = [];
  final List<Product> favorites = [];
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    allProducts = ProductService.getDummyProducts();
  }

  void _addToCart(Product product) {
    setState(() {
      final existingIndex = cartItems.indexWhere(
        (item) => item.id == product.id,
      );
      if (existingIndex >= 0) {
        cartItems[existingIndex] = cartItems[existingIndex].copyWith(
          quantity: cartItems[existingIndex].quantity + product.quantity,
        );
      } else {
        cartItems.add(product);
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      cartItems.removeWhere((item) => item.id == product.id);
    });
  }

  void _updateQuantity(Product product, int quantity) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.id == product.id);
      if (index >= 0) {
        if (quantity <= 0) {
          cartItems.removeAt(index);
        } else {
          cartItems[index] = cartItems[index].copyWith(quantity: quantity);
        }
      }
    });
  }

  void _toggleFavorite(Product product) {
    setState(() {
      final existingIndex = favorites.indexWhere(
        (item) => item.id == product.id,
      );
      if (existingIndex >= 0) {
        favorites.removeAt(existingIndex);
      } else {
        favorites.add(product);
      }
    });
  }

  bool _isFavorite(Product product) {
    return favorites.any((item) => item.id == product.id);
  }

  void _goToDiscover() {
    setState(() {
      _currentTabIndex = 0;
    });
  }

  void _handleCheckout() {
    if (cartItems.isEmpty) {
      return;
    }

    setState(() {
      cartItems.clear();
      _currentTabIndex = 0;
    });

    _scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Checkout complete. Your cart has been cleared.'),
        duration: Duration(milliseconds: 1400),
        backgroundColor: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      title: 'Mini Catalog App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: _buildCurrentScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[400],
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              activeIcon: const Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            cartItems.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: Stack(
                children: [
                  const Icon(Icons.shopping_cart),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            cartItems.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Cart',
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentTabIndex) {
      case 0:
        return DiscoverScreen(
          allProducts: allProducts,
          cartItems: cartItems,
          favorites: favorites,
          onAddToCart: _addToCart,
          onToggleFavorite: _toggleFavorite,
          isFavorite: _isFavorite,
        );
      case 1:
        return FavoritesScreen(
          favorites: favorites,
          cartItems: cartItems,
          onAddToCart: _addToCart,
          onToggleFavorite: _toggleFavorite,
          isFavorite: _isFavorite,
        );
      case 2:
        return CartScreen(
          cartItems: cartItems,
          onRemoveFromCart: _removeFromCart,
          onUpdateQuantity: _updateQuantity,
          onContinueShopping: _goToDiscover,
          onCheckout: _handleCheckout,
        );
      default:
        return DiscoverScreen(
          allProducts: allProducts,
          cartItems: cartItems,
          favorites: favorites,
          onAddToCart: _addToCart,
          onToggleFavorite: _toggleFavorite,
          isFavorite: _isFavorite,
        );
    }
  }
}
