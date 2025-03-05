import 'package:flutter_test/flutter_test.dart';
import 'package:jagga_bazar/features/auth/data/model/auth_api_model.dart';
import 'package:jagga_bazar/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthApiModel Tests', () {
    final json = {
      '_id': '123',
      'fullName': 'John Doe',
      'userName': 'johndoe',
      'location': 'Matatirtha',
      'phoneNo': '1234567890',
      'password': 'password123',
      'image': 'profile.jpg',
    };

    // test('should convert from JSON correctly', () {
    //   final model = AuthApiModel.fromJson(json);

    //   expect(model.userId, '123');
    //   expect(model.fullName, 'John Doe'); // Fixed expected value
    //   expect(model.username, 'johndoe');
    //   expect(model.location, 'Matatirtha');
    //   expect(model.phone, '1234567890');
    //   expect(model.password, 'password123');
    //   expect(model.image, 'profile.jpg');
    // });

    // test('should convert to JSON correctly', () {
    //   final model = AuthApiModel.fromJson(json);
    //   final convertedJson = model.toJson();

    //   expect(convertedJson['_id'], '123');
    //   expect(convertedJson['fullName'], 'John Doe');
    //   expect(convertedJson['userName'], 'johndoe');
    //   expect(convertedJson['location'], 'Matatirtha');
    //   expect(convertedJson['phoneNo'], '1234567890');
    //   expect(convertedJson['password'], 'password123');
    //   expect(convertedJson['image'], 'profile.jpg');
    // });

    test('should convert between Entity and Model correctly', () {
      const entity = AuthEntity(
        userId: '123',
        fullName: 'John Doe',
        username: 'johndoe',
        location: 'Matatirtha',
        phone: '1234567890',
        password: 'password123',
        image: 'profile.jpg',
      );

      final model = AuthApiModel.fromEntity(entity);
      final convertedEntity = model.toEntity();

      expect(convertedEntity, equals(entity));
    });
  });
}
