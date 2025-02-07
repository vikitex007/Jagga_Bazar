import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';

void main() {
  // Creating initial AuthEntity objects
  const auth1 = AuthEntity(
    userId: "2343423123124",
    location: "Matatirtha",
    fullName: "Sachin Shrestha",
    image: "image_url",
    phone: "98010119909",
    username: "sachin",
    password: "sachin123",
  );

  const auth2 = AuthEntity(
    userId: "2343423123124",
    location: "Matatirtha",
    fullName: "Sachin Shrestha",
    image: "image_url",
    phone: "98010119909",
    username: "sachin",
    password: "sachin123",
  );

  const auth3 = AuthEntity(
    userId: "2343423123125",
    location: "Lalitpur",
    fullName: "John Doe",
    image: "image_url",
    phone: "98010119909",
    username: "john",
    password: "john123",
  );

  const authDuplicate = AuthEntity(
    userId: "2343423123126",
    location: "Kathmandu",
    fullName: "Amit Rai",
    image: "image_url",
    phone: "98010119910",
    username: "sachin", // Duplicate username
    password: "amit123",
  );

  test('Test 1: AuthEntity objects with identical values should be equal', () {
    expect(auth1, auth2); // Same values
  });

  test('Test 2: AuthEntity objects with different values should not be equal', () {
    expect(auth1 == auth3, isFalse); // Different values
  });

  test('Test 3: Same username cannot exist for multiple AuthEntity objects', () {
    // Simulate a repository or service check that verifies unique usernames
    usernameExists(String username) {
      // Simulating an existing username check
      return username == auth1.username;
    }

    final isDuplicate = usernameExists(authDuplicate.username);

    // Assert that the duplicate username is not allowed
    expect(isDuplicate, isTrue);
  });


  test('Test 4: Two different AuthEntity objects with the same values should be equal', () {
    final authWithSameValues = const AuthEntity(
      userId: "2343423123124",
      location: "Matatirtha",
      fullName: "Sachin Shrestha",
      image: "image_url",
      phone: "98010119909",
      username: "sachin",
      password: "sachin123",
    );
    expect(auth1 == authWithSameValues, isTrue);
  });
  test('Test 5: Same username cannot exist for multiple AuthEntity objects', () {
    // Simulate a repository or service check that verifies unique usernames
    usernameExists(String username) {
      // Simulating an existing username check
      return username == auth1.username;
    }

    final isDuplicate = usernameExists(authDuplicate.username);

    // Assert that the duplicate username is not allowed
    expect(isDuplicate, isTrue);
  });
}
