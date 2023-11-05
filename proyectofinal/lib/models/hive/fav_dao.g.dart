// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavDaoAdapter extends TypeAdapter<FavDao> {
  @override
  final int typeId = 2;

  @override
  FavDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavDao(
      name: fields[0] as String,
      id: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavDao obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
