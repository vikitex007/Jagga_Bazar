import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jagga_bazar/features/favourite/presentation/view_model/favourite_bloc.dart';
import 'package:jagga_bazar/features/favourite/presentation/view_model/favourite_event.dart';
import 'package:jagga_bazar/features/post/domain/entity/post_entity.dart';
import '../view_model/favourite_state.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          // ✅ Show loading indicator while fetching favourite posts
          if (state.isLoading  == 5) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ Handle empty favourite list
          if (state.favouritePosts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No favourite posts added.",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.favouritePosts.length,
              itemBuilder: (context, index) {
                final PostEntity post = state.favouritePosts[index];

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        post.image ?? 'assets/images/background1.png',
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/background1.png',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      post.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        BlocProvider.of<FavouriteBloc>(context)
                            .add(RemoveFromFavourites(post));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Removed from favourites"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
