// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavDataModelAdapter extends TypeAdapter<FavDataModel> {
  @override
  final int typeId = 0;

  @override
  FavDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavDataModel(
      movieId: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FavDataModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.movieId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
