import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../view_model/post_bloc.dart';

class PostView extends StatelessWidget {
  PostView({super.key});

  // Controllers for Post properties
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

  final _postViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _postViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Post Title Field
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Post Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Post Description Field
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Post Price Field
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Optional Image Field
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (Optional)',
                ),
              ),
              SizedBox(height: 10),

              // Add Post Button
              ElevatedButton(
                onPressed: () {
                  if (_postViewFormKey.currentState!.validate()) {
                    context.read<PostBloc>().add(
                      AddPost(
                        title: titleController.text,
                        description: descriptionController.text,
                        price: priceController.text,
                        image: imageController.text.isNotEmpty
                            ? imageController.text
                            : null,
                        postedBy: "", // Ideally replace with current user's ID
                      ),
                    );
                  }
                },
                child: Text('Add Post'),
              ),
              SizedBox(height: 10),

              // Post List with Delete Option
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.error != null) {
                    return showMySnackBar(
                      context: context,
                      message: state.error!,
                      color: Colors.red,
                    );
                  } else if (state.posts.isEmpty) {
                    return Center(child: Text('No Posts Added Yet'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (BuildContext context, index) {
                          return ListTile(
                            title: Text(state.posts[index].title),
                            subtitle: Text(state.posts[index].price),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context2) {
                                    return AlertDialog(
                                      title: Text('Delete Post'),
                                      content: Text(
                                          'Are you sure you want to delete ${state.posts[index].title}?'),
                                      actions: [
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            context.read<PostBloc>().add(
                                              DeletePost(
                                                state.posts[index].id!,
                                              ),
                                            );

                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
