import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/provider/search_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/strings.dart';
import '../widgets/movie_card_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, SearchProvider provider, child) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: TextField(
                    controller: provider.searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search movies',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        provider.searchMovie(provider.searchController.text);
                      } else if (provider.searchController.text.isEmpty) {
                        provider.clearList();
                      }
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        provider.searchMovie(provider.searchController.text);
                      } else if (provider.searchController.text.isEmpty) {
                        provider.clearList();
                      }
                    },
                  ),
                ),
              ),
              provider.movieModel.isNotEmpty
                  ? Expanded(child: movieCardList(provider.movieModel))
                  : Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Lottie.asset(Strings.searchImage),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
