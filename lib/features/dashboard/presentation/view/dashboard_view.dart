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

          final screenWidth = MediaQuery.of(context).size.width;

          // Dynamically determine number of columns based on screen width
          int crossAxisCount = 2; // Default for phones
          if (screenWidth > 1200) {
            crossAxisCount = 4; // Large tablets/laptops
          } else if (screenWidth > 800) {
            crossAxisCount = 3; // Smaller tablets
          }

          // Calculate aspect ratio dynamically (adjust this if needed)
          final cardWidth = screenWidth / crossAxisCount - 16;
          const cardHeight = 240; // Fixed height for cards
          final childAspectRatio = cardWidth / cardHeight;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: state.posts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) {
                final PostEntity post = state.posts[index];

                return GestureDetector(
                  onTap: () {
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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailView(post: post),
                                  ),
                                );
                                print("View Details button clicked for ${post.title}");
                              },
                              child: const Text('View Details'),
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
  final bool isFromFavourite; // Indicates if we arrived from Favourites page

  const PostDetailView({
    super.key,
    required this.post,
    this.isFromFavourite = false,
  });

  /// Constructs the full URL to fetch images from the backend using only the filename.
  String getImageUrl(String? imageName) {
    if (imageName == null || imageName.isEmpty) {
      return "${ApiEndpoints.imageUrl}default_placeholder.png"; // Fallback image
    }
    return "${ApiEndpoints.imageUrl}$imageName";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Added to prevent overflow in smaller screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
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

              // Post Title
              Text(
                post.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                post.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),

              // Price
              Text(
                'Price: Rs ${post.price}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Location
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue),
                  const SizedBox(width: 6),
                  Text(
                    post.location,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Negotiable
              Text(
                post.negotiable ? "Negotiable: Yes" : "Negotiable: No",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: post.negotiable ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 16),

              // Spacer removed (not ideal inside ScrollView)

              // Favourite Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isFromFavourite) {
                      // Remove from Favourites
                      context.read<FavouriteBloc>().add(RemovePostFromFavourites(post.id ?? ''));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Removed from Favourites!"),
                          backgroundColor: Colors.red,
                        ),
                      );

                      // Go back to refresh the favourite list
                      Navigator.pop(context);
                    } else {
                      // Add to Favourites
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
                    isFromFavourite ? "Remove from Favourites" : "Add to Favourites",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


