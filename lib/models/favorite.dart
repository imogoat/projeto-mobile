import 'package:imogoat/models/immobile.dart';

class Favorite {
  int id;
  int userId;
  int immobileId;
  Immobile immobile;

  Favorite({
    required this.id,
    required this.userId,
    required this.immobileId,
    required this.immobile,
  });

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] ?? 0,
      userId: map['userId'] ?? 0,
      immobileId: map['immobileId'] ?? 0,
      immobile: Immobile.fromMap(map['immobile'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'immobileId': immobileId,
      'immobile': immobile.toMap(),
    };
  }
}
