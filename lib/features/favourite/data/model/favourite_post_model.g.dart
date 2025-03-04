// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritePostModelAdapter extends TypeAdapter<FavouritePostModel> {
  @override
  final int typeId = 2;

  @override
  FavouritePostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritePostModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as String,
      location: fields[4] as String,
      image: fields[5] as String?,
      negotiable: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritePostModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.negotiable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritePostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
