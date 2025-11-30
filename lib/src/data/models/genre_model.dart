import '../../domain/entities/genre_entity.dart';

class GenreModel extends Genre {
  GenreModel({
    required super.id,
    required super.name
  });

  // Create a Factory From JSON ---> To Model
  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  // From Model ---> To JSON, for sending data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  // From Model ---> To Entity
  Genre toEntity() {
    return Genre(
      id: id,
      name: name,
    );
  }

}