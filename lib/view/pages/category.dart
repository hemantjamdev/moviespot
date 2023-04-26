import 'package:flutter/material.dart';
import 'package:moviespot/provider/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoryProvider>(
          builder: (context, CategoryProvider provider, child) {
        return GridView.builder(
            itemCount: 10,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, int index) {
              return const Card(
                child: Text("action"),
              );
            });
      }),
    );
  }
}
