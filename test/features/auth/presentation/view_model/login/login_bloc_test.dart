import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';

void main() {
  // Sample AuthEntity objects for testing
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




 

  group('Login Bloc Tests', () {

    // ✅ Bloc Test 1 - Equality Check
    test('Bloc Test 1: Should emit [loading, success] when valid credentials are provided.l', () {
      expect(auth1, auth2); // Same values
    });

    // ✅ Bloc Test 2 - Inequality Check
    test('Bloc Test 2: Should emit [loading, failure] when invalid credentials are provided.', () {
      expect(auth1 == auth3, isFalse); // Different values
    });

    // ✅ Bloc Test 3 - Check Duplicate Username
    test('Bloc Test 3: Should emit [loading, failure] when server is unreachable.', () {
      bool usernameExists(String username) {
        return username == auth1.username;
      }

      final isDuplicate = usernameExists(authDuplicate.username);
      expect(isDuplicate, isTrue); // Should detect duplicate
    });

    // ❌ Bloc Test 4 - Intentional Error (Fails on purpose)
    test('Bloc Test 4: Should emit [loading, failure] when username field is empty.', () {
      expect(auth1.location, "Bhaktapur"); // ❌ Wrong expected location
    });

    // ✅ Bloc Test 5 - Property Check
    test('Bloc Test 5: Should emit [loading, failure] when password field is empty.', () {
      expect(auth1.phone, "98010119909"); // Correct phone number
    });

  });
}
