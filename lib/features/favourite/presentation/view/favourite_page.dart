// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jagga_bazar/features/favourite/presentation/view_model/favourite_bloc.dart';
// import 'package:jagga_bazar/features/favourite/presentation/view_model/favourite_event.dart';
// import 'package:jagga_bazar/features/post/domain/entity/post_entity.dart';
// import '../view_model/favourite_state.dart';
//
// class FavouritePage extends StatelessWidget {
//   const FavouritePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: BlocBuilder<FavouriteBloc, FavouriteState>(
//         builder: (context, state) {
//           // ✅ Show loading indicator while fetching favourite posts
//           if (state.isLoading  == 5) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           // ✅ Handle empty favourite list
//           if (state.favouritePosts.isEmpty) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.favorite_border, size: 80, color: Colors.grey),
//                   SizedBox(height: 10),
//                   Text("No favourite posts added.",
//                       style: TextStyle(fontSize: 16, color: Colors.grey)),
//                 ],
//               ),
//             );
//           }
//
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView.builder(
//               itemCount: state.favouritePosts.length,
//               itemBuilder: (context, index) {
//                 final PostEntity post = state.favouritePosts[index];
//
//                 return Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(10),
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         post.image ?? 'assets/images/background1.png',
//                         fit: BoxFit.cover,
//                         width: 60,
//                         height: 60,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             'assets/images/background1.png',
//                             fit: BoxFit.cover,
//                             width: 60,
//                             height: 60,
//                           );
//                         },
//                       ),
//                     ),
//                     title: Text(
//                       post.title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       post.description,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         BlocProvider.of<FavouriteBloc>(context)
//                             .add(RemoveFromFavourites(post));
//
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Removed from favourites"),
//                             duration: Duration(seconds: 1),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../view_model/favourite_bloc.dart';
// import '../view_model/favourite_event.dart';
// import '../view_model/favourite_state.dart';
//
// class FavouritePage extends StatelessWidget {
//   const FavouritePage({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final bloc = context.read<FavouriteBloc>();
//     print('✅ FavouriteBloc found in context: $bloc');
//
//     return Scaffold(
//       // appBar: AppBar(title: const Text("Favourites")),
//       body: BlocBuilder<FavouriteBloc, FavouriteState>(
//         builder: (context, state) {
//           print('🟡 BlocBuilder state: $state'); // Debugging Log
//
//           if (state is FavouriteLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           else if (state is FavouriteLoaded) {
//             print('✅ UI received favourites: ${state.favourites.length} items'); // Debug Log
//
//             if (state.favourites.isEmpty) {
//               return const Center(child: Text("No favourite posts added."));
//             }
//
//             return ListView.builder(
//               itemCount: state.favourites.length,
//               itemBuilder: (context, index) {
//                 final post = state.favourites[index];
//
//                 return Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   child: ListTile(
//                     leading: post.image != null
//                         ? Image.network(post.image!, width: 50, height: 50, fit: BoxFit.cover)
//                         : const Icon(Icons.image),
//                     title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                     subtitle: Text(post.location),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         context.read<FavouriteBloc>().add(RemovePostFromFavourites(post.id));
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           else if (state is FavouriteError) {
//             return const Center(child: Text("Failed to load favourites."));
//           }
//
//           return const Center(child: Text("Unexpected state."));
//         },
//       ),
//
//
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../view_model/favourite_bloc.dart';
// import '../view_model/favourite_event.dart';
// import '../view_model/favourite_state.dart';
//
// class FavouritePage extends StatelessWidget {
//   const FavouritePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.read<FavouriteBloc>();
//
//     // Dispatch event to fetch favourites when the page is loaded
//     // bloc.add(FetchFavourites());
//     print('🔄 FetchFavourites event triggered');
//
//     return Scaffold(
//       body: BlocBuilder<FavouriteBloc, FavouriteState>(
//         builder: (context, state) {
//           print('🟡 BlocBuilder state: $state'); // Debugging Log
//
//           if (state is FavouriteLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           else if (state is FavouriteLoaded) {
//             print('✅ UI received favourites: ${state.favourites.length} items');
//
//             if (state.favourites.isEmpty) {
//               return const Center(child: Text("No favourite posts added."));
//             }
//
//             return ListView.builder(
//               itemCount: state.favourites.length,
//               itemBuilder: (context, index) {
//                 final post = state.favourites[index];
//
//                 return Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   child: ListTile(
//                     leading: post.image != null
//                         ? Image.network(
//                       post.image!,
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.broken_image, color: Colors.grey);
//                       },
//                     )
//                         : const Icon(Icons.image, color: Colors.grey),
//                     title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                     subtitle: Text(post.location),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         context.read<FavouriteBloc>().add(RemovePostFromFavourites(post.id));
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           else if (state is FavouriteError) {
//             return const Center(child: Text("Failed to load favourites."));
//           }
//
//           return const Center(child: Text("Unexpected state."));
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard/presentation/view/dashboard_view.dart';
import '../view_model/favourite_bloc.dart';
import '../view_model/favourite_event.dart';
import '../view_model/favourite_state.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouriteBloc>();

    // Trigger loading when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(LoadFavourites());  // Load favourites on first open
    });

    print('🔄 LoadFavourites event triggered');

    return Scaffold(
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          print('🟡 BlocBuilder state: $state'); // Debugging Log

          if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteLoaded) {
            print('✅ UI received favourites: ${state.favourites.length} items');

            if (state.favourites.isEmpty) {
              return const Center(child: Text("No favourite posts added."));
            }

            return ListView.builder(
              itemCount: state.favourites.length,
              itemBuilder: (context, index) {
                final post = state.favourites[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailView(
                          post: post.toPostEntity(),
                          isFromFavourite: true, // This tells PostDetailView to show "Remove from Favourite"
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ListTile(
                      leading: post.image != null
                          ? Image.network(
                        post.image!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, color: Colors.grey);
                        },
                      )
                          : const Icon(Icons.image, color: Colors.grey),
                      title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(post.location),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<FavouriteBloc>().add(RemovePostFromFavourites(post.id));
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is FavouriteError) {
            return const Center(child: Text("Failed to load favourites."));
          }

          return const Center(child: Text("Unexpected state."));
        },
      ),
    );
  }
}
