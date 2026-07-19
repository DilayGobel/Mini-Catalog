import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_mini_catalog/models/product_model.dart';
import 'package:flutter_mini_catalog/screens/discover_screen.dart';

void main() {
  testWidgets('tapping favorite toggles icon state', (
    WidgetTester tester,
  ) async {
    final products = ProductService.getDummyProducts();
    bool isFavorite = false;

    await tester.pumpWidget(
      MaterialApp(
        home: DiscoverScreen(
          allProducts: products,
          cartItems: const [],
          favorites: const [],
          onAddToCart: (_) {},
          onToggleFavorite: (_) {
            isFavorite = !isFavorite;
          },
          isFavorite: (_) => isFavorite,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsAtLeastNWidgets(1));

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsAtLeastNWidgets(1));
  });
}
