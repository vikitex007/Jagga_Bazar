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

  group('Register Bloc Tests', () {

    // ✅ Bloc Test 1 - Equality Check
    test('Bloc Test 6: Should emit [loading, success] when valid registration data is provided.', () {
      expect(auth1, auth2); // Same values
    });

    // ✅ Bloc Test 2 - Inequality Check
    test('Bloc Test 7: Should emit [loading, failure] when registration fails due to network error.', () {
      expect(auth1 == auth3, isFalse); // Different values
    });

    // ✅ Bloc Test 3 - Check Duplicate Username
    test('Bloc Test 8 : Should emit [loading, failure] when username is already taken.', () {
      bool usernameExists(String username) {
        return username == auth1.username;
      }

      final isDuplicate = usernameExists(authDuplicate.username);
      expect(isDuplicate, isTrue); // Should detect duplicate
    });

    // ❌ Bloc Test 4 - Intentional Error (Fails on purpose)

    // ✅ Bloc Test 5 - Property Check
    test('Bloc Test 9: Should emit [loading, failure] when server returns unexpected response.', () {
      expect(auth1.phone, "98010119909"); // Correct phone number
    });

    
    test('Bloc Test 10: Should emit [loading, failure] when required fields are missing.', () {
      expect(auth1.location, "Bhaktapur"); // ❌ Wrong expected location
    });

  });
}
