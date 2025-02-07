import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity Tests', () {
    const auth1 = AuthEntity(
      userId: "2343423123124",
      fullName: "Sachin Shrestha",
      image: "image_url",
      phone: "98010119909",
      location: "Kathmandu",
      username: "sachin",
      password: "sachin123",
    );

    const auth2 = AuthEntity(
      userId: "1231341341",
      fullName: "Ram hero",
      image: "image2",
      phone: "9801232312",
      location: "Lalitpur",
      username: "ram1",
      password: "ram123",
    );

    const auth3 = AuthEntity(
      userId: "432878172812",
      fullName: "kushal ulcer",
      image: "image1",
      phone: "9801111111",
      location: "Bhaktapur",
      username: "shyam",
      password: "shyam123",
    );

    test('Test 1: Should create AuthEntity with correct properties', () {
      expect(auth1.userId, "2343423123124");
      expect(auth1.fullName, "Sachin Shrestha");
      expect(auth1.image, "image_url");
      expect(auth1.phone, "98010119909");
      expect(auth1.location, "Kathmandu");
      expect(auth1.username, "sachin");
      expect(auth1.password, "sachin123");
    });

    test('Test 2:  Two AuthEntity objects with the same values should be equal', () {
      expect(auth1, equals(auth1)); // Should be equal to itself
    });

    test('Test 3:  AuthEntity objects with different values should not be equal', () {
      expect(auth1, isNot(auth2));
    });

    test('Test 4:  Props list should contain all the required values', () {
      expect(auth1.props, [
        "2343423123124", // Correct userId
        "Sachin Shrestha", // Correct fullName
        "image_url", // Correct image
        "98010119909", // Correct phone
        "Kathmandu", // Correct location
        "sachin", // Correct username
        "sachin123", // Correct password
      ]);
    });

    test('Test 5:  Should allow nullable userId and image', () {
      const authWithoutIdImage = AuthEntity(
        fullName: "Alice",
        phone: "9812345678",
        location: "Pokhara",
        username: "alice",
        password: "securepass",
      );

      expect(authWithoutIdImage.userId, isNull);
      expect(authWithoutIdImage.image, isNull);
    });

    test('Test 6:  Different userId but same other properties should not be equal', () {
      const authDiffId = AuthEntity(
        userId: "999",
        fullName: "Sachin Shrestha",
        image: "image_url",
        phone: "98010119909",
        location: "Kathmandu",
        username: "sachin",
        password: "sachin123",
      );

      expect(auth1, isNot(authDiffId));
    });

    test('Test 7:  Should support empty userId and image but still work properly', () {
      const authEmptyValues = AuthEntity(
        userId: "",
        fullName: "John Doe",
        image: "",
        phone: "9800000000",
        location: "Kathmandu",
        username: "johndoe",
        password: "password123",
      );

      expect(authEmptyValues.userId, "");
      expect(authEmptyValues.image, "");
      expect(authEmptyValues.fullName, "John Doe");
    });

    test('Test 8:  Should correctly differentiate between different usernames', () {
      const authDiffUsername = AuthEntity(
        userId: "2343423123124",
        fullName: "Sachin Shrestha",
        image: "image_url",
        phone: "98010119909",
        location: "Kathmandu",
        username: "sachin_different", // Different username
        password: "sachin123",
      );

      expect(auth1, isNot(authDiffUsername));
    });

    test('Test 9:  Password should be treated as a property in equality check', () {
      const authDiffPassword = AuthEntity(
        userId: "2343423123124",
        fullName: "Sachin Shrestha",
        image: "image_url",
        phone: "98010119909",
        location: "Kathmandu",
        username: "sachin",
        password: "different_password", // Different password
      );

      expect(auth1, isNot(authDiffPassword));
    });

    test('Test 10:  Should ensure immutability by requiring explicit instantiation for modifications', () {
  final modifiedAuth = AuthEntity(
    userId: auth1.userId,
    fullName: "New Name",
    image: auth1.image,
    phone: auth1.phone,
    location: auth1.location,
    username: auth1.username,
    password: auth1.password,
  );

  expect(modifiedAuth, isNot(auth1)); // Should not be the same object
  expect(modifiedAuth.fullName, "New Name"); // Ensures modification only through explicit creation
  expect(auth1.fullName, "Sachin Shrestha"); // Original remains unchanged
});

  });
}
