import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../view_model/post_bloc.dart';
import 'package:path_provider/path_provider.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> _postViewFormKey = GlobalKey<FormState>();

  bool isNegotiable = false;
  File? _img;
  Future _browseImage(ImageSource imageSource)async{
    try{
      final image = await ImagePicker().pickImage(source: imageSource);
      if(image!=null){
        setState(() {
          _img =File(image.path);
          context.read<PostBloc>().add(
            LoadImage(file: _img!),
          );

        });
      }else{
        return;
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  void _addPost() async {
    if (_postViewFormKey.currentState!.validate()) {

      final registerState = context.read<PostBloc>().state;
      final imageName =registerState.imageName;
      FormData formData = FormData.fromMap({
        "title": titleController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        "location": locationController.text,
        "negotiable": isNegotiable,
        "image":imageName,
        "postedBy": "", // Replace with current user ID
      });

      context.read<PostBloc>().add(
        AddPost(
          title: titleController.text,
          description: descriptionController.text,
          price: priceController.text,
          location: locationController.text,
          negotiable: isNegotiable,
          image: imageName, // Ensure this matches your API expectations
          postedBy: "", // Replace with current user ID
        ),
      );
    }
  }

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
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Post Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: isNegotiable,
                    onChanged: (value) {
                      setState(() {
                        isNegotiable = value ?? false;
                      });
                    },
                  ),
                  const Text('Negotiable'),
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.grey[300],
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              await _browseImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await _browseImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: Center(
                    child: _img == null
                        ? const Text('Tap to Upload Image')
                        : Image.file(
                      File(_img!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addPost,
                child: const Text('Add Post'),
              ),
              const SizedBox(height: 10),
              BlocListener<PostBloc, PostState>(
                listener: (context, state) {
                  if (state.error != null) {
                    showMySnackBar(
                      context: context,
                      message: state.error!,
                      color: Colors.red,
                    );
                  }
                },
                child: BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.posts.isEmpty) {
                      return const Center(child: Text('No Posts Added Yet'));
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.posts[index].title),
                              subtitle: Text(state.posts[index].price),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context2) {
                                      return AlertDialog(
                                        title: const Text('Delete Post'),
                                        content: Text('Are you sure you want to delete ${state.posts[index].title}?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                          TextButton(
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              context.read<PostBloc>().add(DeletePost(state.posts[index].id!));
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
