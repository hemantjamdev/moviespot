import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/provider/category_provider.dart';
import 'package:moviespot/view/pages/search_by_genre.dart';
import 'package:provider/provider.dart';

import '../widgets/loading.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: Strings.categories.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) {
          return Card(child: Consumer<CategoryProvider>(
            builder: (context, CategoryProvider provider, child) {
              return MovieGridCard(
                posterUrl: Strings.imageList[index],
                categoryName: Strings.categories[index],
              );
            },
          ));
        },
      ),
    );
  }
}

class MovieGridCard extends StatelessWidget {
  final String posterUrl;
  final String categoryName;

  const MovieGridCard({
    Key? key,
    required this.posterUrl,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchByGenre(
              genreName: categoryName,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Image.network(
              posterUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : shimmer(width: 500, height: 500);
              },
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
