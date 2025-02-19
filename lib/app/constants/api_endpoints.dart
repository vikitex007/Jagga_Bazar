class ApiEndpoints{
  ApiEndpoints._(); // private constructor


   static const Duration connectionTimeOut = Duration(seconds: 5000);
   static const Duration receiveTimeOut = Duration(seconds: 5000);
   static const baseUrl = "http://10.0.2.2:3000/api/v1/";

   //==========================================  Auth Routes ======================
  static const String login = "/auth/login";
  static const String register = "/auth/register";

  // static const String getAllStudent = "auth/getAllStudents";
  // static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  // static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  //
  // static const String updateStudent = "auth/updateStudent/";
  // static const String deleteStudent = "auth/deleteStudent/";
  //

  //================================================Post Routes ===============
  static const String createPost = "post/createPost";
  static const String getAllPosts = "post/getAllPosts";
  static const String deletePost = "post/";  // Assuming
  static const String uploadImage1 = "post/uploadImage";

  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";




}