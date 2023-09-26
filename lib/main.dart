import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product("Product 1", 10.0),
    Product("Product 2", 20.0),
    Product("Product 3", 30.0),
    Product("Product 4", 40.0),
    Product("Product 5", 50.0),
    Product("Product 6", 60.0),
    Product("Product 7", 70.0),
    Product("Product 8", 80.0),
    Product("Product 9", 90.0),
    Product("Product 10", 100.0),
    Product("Product 12", 120.0),
    Product("Product 13", 130.0),

  ];

  Map<String, int> productCount = {};

  void _addToCart(String productName) {
    setState(() {
      if (productCount.containsKey(productName)) {
        productCount[productName] = 1;
      }
      else {
        productCount[productName] = 1;
      }

      if (productCount[productName] == 5) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Congratulations!"),
              content: Text("You've bought 5 $productName!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _goToCartPage() {
    int totalProductsBought = productCount.values.fold(0, (a, b) => a + b);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(totalProductsBought),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product List"),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     onPressed: _goToCartPage,
        //   ),
        // ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final productName = product.name;

          return ListTile(
            title: Text(productName),
            subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(productCount.containsKey(productName)
                        ? productCount[productName].toString()
                        : "0"
                    ),
                  ],
                ),

                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _addToCart(productName);
                  },
                  child: Text("Buy Now"),
                ),
              ],
            ),

          );
          },
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: _goToCartPage,
        child:
        Icon(Icons.shopping_cart),
      ) ,
    );
  }
}

class CartPage extends StatelessWidget {
  final int totalProductsBought;

  CartPage(this.totalProductsBought);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Center(
        child: Text("Total Products Bought: $totalProductsBought"),
      ),
    );
  }
}
