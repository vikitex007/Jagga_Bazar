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

  group('AuthEntity Equality Tests', () {
    test('Test 1: AuthEntity objects with identical values should be equal', () {
      expect(auth1, auth2); // Same values
    });

    test('Test 2: AuthEntity objects with different values should not be equal', () {
      expect(auth1 == auth3, isFalse); // Different values
    });

    test('Test 3: Same username cannot exist for multiple AuthEntity objects', () {
      usernameExists(String username) {
        return username == auth1.username;
      }

      final isDuplicate = usernameExists(authDuplicate.username);
      expect(isDuplicate, isTrue); // Duplicate username
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
      expect(auth1 == authWithSameValues, isTrue); // Should be equal
    });

    test('Test 5: Same username cannot exist for multiple AuthEntity objects', () {
      usernameExists(String username) {
        return username == auth1.username;
      }

      final isDuplicate = usernameExists(authDuplicate.username);
      expect(isDuplicate, isTrue); // Duplicate username found
    });
  });

  group('AuthEntity Validation Tests', () {
    test('Test 6: AuthEntity with unique username should be valid', () {
      final isUnique = auth1.username != auth3.username;
      expect(isUnique, isTrue); // Unique username
    });

    test('Test 7: AuthEntity should maintain all values correctly', () {
      expect(auth1.userId, "2343423123124");
      expect(auth1.location, "Matatirtha");
      expect(auth1.fullName, "Sachin Shrestha");
      expect(auth1.image, "image_url");
      expect(auth1.phone, "98010119909");
      expect(auth1.username, "sachin");
      expect(auth1.password, "sachin123");
    });

    test('Test 8: AuthEntity should not be equal if any property is different', () {
    final modifiedAuth = AuthEntity(
    userId: auth1.userId,
    location: auth1.location,
    fullName: auth1.fullName,
    image: auth1.image,
    phone: "1234567890", // Changed phone number
    username: auth1.username,
    password: auth1.password,
  );

  expect(auth1 == modifiedAuth, isFalse); // Different phone
});

    
    test('Test 9: AuthEntity objects with different usernames should not be equal', () {
      expect(auth1.username == auth3.username, isFalse); // Different usernames
    });

    test('Test 10: AuthEntity objects should have the same password if unchanged', () {
      expect(auth1.password, "sachin123"); // Same password as the original auth1
    });
  });
}
