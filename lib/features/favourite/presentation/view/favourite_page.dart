// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:proximity_sensor/proximity_sensor.dart';
// import '../../../dashboard/presentation/view/dashboard_view.dart';
// import '../../../post/domain/entity/post_entity.dart';
// import '../view_model/favourite_bloc.dart';
// import '../view_model/favourite_event.dart';
// import '../view_model/favourite_state.dart';
//
// class FavouritePage extends StatefulWidget {
//   const FavouritePage({super.key});
//
//   @override
//   State<FavouritePage> createState() => _FavouritePageState();
// }
//
// class _FavouritePageState extends State<FavouritePage> {
//   PostEntity? _lastTappedPost;
//   bool _objectDetected = false;
//   StreamSubscription<int>? _proximitySubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<FavouriteBloc>().add(LoadFavourites());
//     _startProximityListener();
//   }
//
//   void _startProximityListener() {
//     _proximitySubscription = ProximitySensor.events.listen((int event) {
//       if (event == 1 && !_objectDetected) {
//         _objectDetected = true;
//
//         if (_lastTappedPost != null && _lastTappedPost!.id != null) {
//           context.read<FavouriteBloc>().add(RemovePostFromFavourites(_lastTappedPost!.id!));
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Removed "${_lastTappedPost!.title}" from favourites due to proximity detection'),
//             ),
//           );
//         }
//
//         // Reset detection flag after 2 seconds
//         Future.delayed(const Duration(seconds: 2), () {
//           _objectDetected = false;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _proximitySubscription?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<FavouriteBloc, FavouriteState>(
//         builder: (context, state) {
//           if (state is FavouriteLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is FavouriteLoaded) {
//             if (state.favourites.isEmpty) {
//               return const Center(child: Text("No favourite posts added."));
//             }
//
//             return ListView.builder(
//               itemCount: state.favourites.length,
//               itemBuilder: (context, index) {
//                 final post = state.favourites[index];
//
//                 return GestureDetector(
//                   onTap: () {
//                     _lastTappedPost = post.toPostEntity();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PostDetailView(
//                           post: post.toPostEntity(),
//                           isFromFavourite: true,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: ListTile(
//                       leading: post.image != null
//                           ? Image.network(
//                         post.image!,
//                         width: 50,
//                         height: 50,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return const Icon(Icons.broken_image, color: Colors.grey);
//                         },
//                       )
//                           : const Icon(Icons.image, color: Colors.grey),
//                       title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                       subtitle: Text(post.location),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () {
//                           context.read<FavouriteBloc>().add(RemovePostFromFavourites(post.id));
//                         },
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is FavouriteError) {
//             return const Center(child: Text("Failed to load favourites."));
//           }
//           return const Center(child: Text("Unexpected state."));
//         },
//       ),
//     );
//   }
// }
//
//



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
