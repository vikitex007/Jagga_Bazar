import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/auth_hive_model.dart';
import '../../features/post/data/model/post_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}jagga_bazar_mobile.db';

    Hive.init(path);

    // Register Adapters
    // Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(PostHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  //Post Queries
  // Add a new Post
  Future<void> addPost(PostHiveModel post) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.put(post.postId, post);
  }

  // Delete a Post by ID
  Future<void> deletePost(String id) async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    await box.delete(id);
  }

  // Get all Posts, sorted by title
  Future<List<PostHiveModel>> getAllPosts() async {
    var box = await Hive.openBox<PostHiveModel>(HiveTableConstant.postBox);
    return box.values.toList()
      ..sort((a, b) => a.title.compareTo(b.title)); // Sorting by title
  }








  // // Course Queries
  // Future<void> addCourse(CourseHiveModel course) async {
  //   var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
  //   await box.put(course.courseId, course);
  // }
  //
  // Future<void> deleteCourse(String id) async {
  //   var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
  //   await box.delete(id);
  // }
  //
  // Future<List<CourseHiveModel>> getAllCourses() async {
  //   var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
  //   return box.values.toList();
  // }

/*
  register box
  {
    fname : "asd",
    lname : "asd",
    batch : {batchId : 1, batchName : "Batch 1"},
    courses : [{courseId : 1, courseName : "Course 1"}, {courseId : 2, courseName : "Course 2"}],
  }
*/

// OR

/*
 {
    fname : "asd",
    lname : "asd",
    batch : 1,
    courses : [1,3,4],
  }
*/

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String username, String password) async {
    // var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
    // var auth = box.values.firstWhere(
    //     (element) =>
    //         element.username == username && element.password == password,
    //     orElse: () => AuthHiveModel.initial());
    // return auth;

    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
    element.username == username && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAll() async {
    // await Hive.deleteBoxFromDisk(HiveTableConstant.batchBox);
    // await Hive.deleteBoxFromDisk(HiveTableConstant.courseBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear Student Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
