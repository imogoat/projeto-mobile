class Immobile {
  int id;
  String name;
  String type;
  int proprietaryId;
  List<ImmobileImage> images;

  Immobile({
    required this.id,
    required this.name,
    required this.type,
    required this.proprietaryId,
    required this.images,
  });

  // Método para converter um Map em uma instância de Immobile
  factory Immobile.fromMap(Map<String, dynamic> map) {
    return Immobile(
      id: map['id'] ?? 0, 
      name: map['name'] ?? 'Não informado', 
      type: map['type'] ?? 'Não informado',
      proprietaryId: map['proprietaryId'] ?? 'Não informado',
      images: map['images'] != null
          ? List<ImmobileImage>.from(map['images'].map<ImmobileImage>((image) => ImmobileImage.fromMap(image)))
          : [],
    );
  }

  // Método toMap (opcional) para converter uma instância de Immobile em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'proprietaryId': proprietaryId,
      'images': images.map((image) => image.toMap()).toList(),
    };
  }
}


class ImmobileImage {
  int id;
  String url;

  ImmobileImage({
    required this.id,
    required this.url,
  });

  // Método para converter um Map em uma instância de ImmobileImage
  factory ImmobileImage.fromMap(Map<String, dynamic> map) {
    return ImmobileImage(
      id: map['id'] ?? 0,
      url: map['url'] ?? "https://storage.googleapis.com/imogoat-oficial-ab14c.appspot.com/imoveis/default_image.jpg",
    );
  }

  // Método toMap (opcional) para converter uma instância de ImmobileImage em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }
}

