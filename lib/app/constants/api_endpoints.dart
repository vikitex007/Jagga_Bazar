class ApiEndpoints {
  ApiEndpoints._(); // private constructor

  static const Duration connectionTimeOut = Duration(seconds: 5000);
  static const Duration receiveTimeOut = Duration(seconds: 5000);
  static const baseUrl = "http://10.0.2.2:3000/api/v1/";
  // for physical device
  // static const baseUrl = "http://192.168.1.71:3000/api/v1/";

  //==========================================  Auth Routes ======================
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String updateUser = "/users";

  //================================================ Post Routes ===============
  static const String createPost = "post/createPost";
  static const String getAllPosts = "post/getAllPosts";
  static const String deletePost = "post/"; // Assuming
  static const String uploadImage1 = "post/uploadImage";

  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  // for physical device
  // static const String imageUrl = "http://192.168.1.71:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  //========================================== Favourite Routes ======================
  static const String addToFavourites = "post/{id}/favourite"; // Add a post to favourites
  static const String removeFromFavourites = "post/{id}/favourite"; // Remove a post from favourites
  static const String getFavouritePosts = "post/favourites"; // Get all favourite posts
}
