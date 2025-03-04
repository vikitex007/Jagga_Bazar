import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jagga_bazar/features/post/domain/entity/post_entity.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/di/di.dart';
import '../../../favourite/domain/entity/favourite_post_entity.dart';
import '../../../favourite/presentation/view_model/favourite_bloc.dart';
import '../../../favourite/presentation/view_model/favourite_event.dart';
import '../../../post/presentation/view_model/post_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  /// Constructs the full URL to fetch images from the backend using only the filename.
  String getImageUrl(String? imageName) {
    if (imageName == null || imageName.isEmpty) {
      return "${ApiEndpoints.imageUrl}default_placeholder.png"; // Default placeholder image
    }
    return "${ApiEndpoints.imageUrl}$imageName"; // Construct full image URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text("Error: ${state.error}"));
          } else if (state.posts.isEmpty) {
            return const Center(child: Text("No posts available."));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: state.posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final PostEntity post = state.posts[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to Post Details Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailView(post: post),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            getImageUrl(post.image),
                            fit: BoxFit.cover,
                            height: 120,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/background1.png',
                                fit: BoxFit.cover,
                                height: 120,
                                width: double.infinity,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    post.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Flexible(
                                  child: Text(
                                    post.description,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
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
//
// class PostDetailView extends StatelessWidget {
//   final PostEntity post;
//
//   const PostDetailView({super.key, required this.post});
//
//   /// Constructs the full URL to fetch images from the backend using only the filename.
//   String getImageUrl(String? imageName) {
//     if (imageName == null || imageName.isEmpty) {
//       return "${ApiEndpoints.imageUrl}default_placeholder.png"; // Default placeholder image
//     }
//     return "${ApiEndpoints.imageUrl}$imageName"; // Construct full image URL
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(post.title)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 getImageUrl(post.image),
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 200,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Image.asset(
//                     'assets/images/background1.png',
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: 200,
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               post.title,
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               post.description,
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '\$${post.price}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Location: ${post.location}",
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               post.negotiable ? "Negotiable: Yes" : "Negotiable: No",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: post.negotiable ? Colors.green : Colors.red,
//               ),
//             ),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Convert PostEntity to FavouritePostEntity
//                   final favouritePost = FavouritePostEntity(
//                     id: post.id ?? '',
//                     title: post.title,
//                     description: post.description,
//                     price: post.price,
//                     location: post.location,
//                     image: post.image,
//                     negotiable: post.negotiable,
//                   );
//
//                   // Trigger the add event via FavouriteBloc
//                   getIt<FavouriteBloc>().add(AddPostToFavourites(favouritePost));
//
//                   // Show a success snackbar
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("Added to Favourites!"),
//                       backgroundColor: Colors.green, // Set the color to green
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text("Add to Favourite", style: TextStyle(fontSize: 16)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class PostDetailView extends StatelessWidget {
  final PostEntity post;
  final bool isFromFavourite; // <-- New flag

  const PostDetailView({
    super.key,
    required this.post,
    this.isFromFavourite = false, // Defaults to false for dashboard flow
  });

  /// Constructs the full URL to fetch images from the backend using only the filename.
  String getImageUrl(String? imageName) {
    if (imageName == null || imageName.isEmpty) {
      return "${ApiEndpoints.imageUrl}default_placeholder.png"; // Default placeholder image
    }
    return "${ApiEndpoints.imageUrl}$imageName"; // Construct full image URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                getImageUrl(post.image),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/background1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              post.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${post.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Location: ${post.location}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              post.negotiable ? "Negotiable: Yes" : "Negotiable: No",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: post.negotiable ? Colors.green : Colors.red,
              ),
            ),
            const Spacer(),

            // Show either Add or Remove button based on `isFromFavourite`
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isFromFavourite) {
                    context.read<FavouriteBloc>().add(RemovePostFromFavourites(post.id ?? ''));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Removed from Favourites!"),
                        backgroundColor: Colors.red,
                      ),
                    );

                    Navigator.pop(context);  // Go back after removal to refresh the list
                  } else {
                    final favouritePost = FavouritePostEntity(
                      id: post.id ?? '',
                      title: post.title,
                      description: post.description,
                      price: post.price,
                      location: post.location,
                      image: post.image,
                      negotiable: post.negotiable,
                    );

                    context.read<FavouriteBloc>().add(AddPostToFavourites(favouritePost));

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Favourites!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isFromFavourite ? "Remove from Favourite" : "Add to Favourite",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

