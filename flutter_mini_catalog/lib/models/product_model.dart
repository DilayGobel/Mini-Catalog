class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Product',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? 'General',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating,
      'quantity': quantity,
    };
  }

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    double? rating,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ProductService {
  static final List<Map<String, dynamic>> _dummyData = [
    {
      'id': 1,
      'title': 'Premium Wireless Headphones',
      'price': 159.99,
      'description':
          'High-quality wireless headphones with noise cancellation, 30-hour battery life, and premium sound quality. Perfect for music lovers and professionals.',
      'category': 'Electronics',
      'image':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
      'rating': 4.8,
    },
    {
      'id': 2,
      'title': 'Smart Watch Pro',
      'price': 299.99,
      'description':
          'Advanced fitness tracking smartwatch with heart rate monitor, GPS, and 7-day battery life. Compatible with iOS and Android.',
      'category': 'Wearables',
      'image':
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&h=500&fit=crop',
      'rating': 4.6,
    },
    {
      'id': 3,
      'title': 'Ultra HD Webcam',
      'price': 89.99,
      'description':
          '4K resolution webcam with auto-focus and built-in microphone. Ideal for streaming, video conferencing, and content creation.',
      'category': 'Electronics',
      'image':
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=500&h=500&fit=crop',
      'rating': 4.5,
    },
    {
      'id': 4,
      'title': 'Portable SSD 1TB',
      'price': 129.99,
      'description':
          'Fast portable solid-state drive with 1TB capacity. USB-C 3.2 interface for quick file transfers and backup.',
      'category': 'Storage',
      'image':
          'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=500&h=500&fit=crop',
      'rating': 4.7,
    },
    {
      'id': 5,
      'title': 'Mechanical Keyboard RGB',
      'price': 149.99,
      'description':
          'Premium mechanical keyboard with RGB lighting, 104 keys, and customizable switches. Perfect for gaming and typing.',
      'category': 'Peripherals',
      'image':
          'https://images.unsplash.com/photo-1587829191301-dc798b83add3?w=500&h=500&fit=crop',
      'rating': 4.9,
    },
    {
      'id': 6,
      'title': 'Wireless Mouse',
      'price': 49.99,
      'description':
          'Ergonomic wireless mouse with precision tracking and 18-month battery life. Compatible with all major operating systems.',
      'category': 'Peripherals',
      'image':
          'https://images.unsplash.com/photo-1527814050087-3793815479db?w=500&h=500&fit=crop',
      'rating': 4.4,
    },
    {
      'id': 7,
      'title': 'USB-C Hub Multi-Port',
      'price': 79.99,
      'description':
          'Compact 7-in-1 USB-C hub with HDMI, USB 3.0, and SD card reader. Expand your laptop connectivity instantly.',
      'category': 'Accessories',
      'image':
          'https://images.unsplash.com/photo-1625948515291-69613efd103f?w=500&h=500&fit=crop',
      'rating': 4.3,
    },
    {
      'id': 8,
      'title': '4K Monitor Display',
      'price': 449.99,
      'description':
          'Professional 32-inch 4K monitor with 99% Adobe RGB color accuracy. Ideal for designers and video editors.',
      'category': 'Displays',
      'image':
          'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500&h=500&fit=crop',
      'rating': 4.8,
    },
  ];

  static List<Product> getDummyProducts() {
    return _dummyData.map((json) => Product.fromJson(json)).toList();
  }

  static Product getProductById(int id) {
    final data = _dummyData.firstWhere((p) => p['id'] == id);
    return Product.fromJson(data);
  }

  static List<Product> searchProducts(String query, List<Product> products) {
    if (query.isEmpty) return products;
    return products
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
