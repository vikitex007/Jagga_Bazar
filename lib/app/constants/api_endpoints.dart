class ApiEndpoints{
  ApiEndpoints._(); // private constructor


   static const Duration connectionTimeOut = Duration(seconds: 5000);
   static const Duration receiveTimeOut = Duration(seconds: 5000);
   static const baseUrl = "http://10.0.2.2:300/api/";

   //==========================================  Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";

  // static const String getAllStudent = "auth/getAllStudents";
  // static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  // static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  //
  // static const String updateStudent = "auth/updateStudent/";
  // static const String deleteStudent = "auth/deleteStudent/";
  //
  // static const String imageUrl = "hhtp://10.0.2.2:3000/uploads/";
  // static const String uploadImage = "auth/uploadImage";




}