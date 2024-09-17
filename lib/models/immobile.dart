class Immobile {
  int id;
  String name;
  String type;
  List<ImmobileImage> images;

  Immobile({
    required this.id,
    required this.name,
    required this.type,
    required this.images,
  });

  factory Immobile.toMap(Map<String, dynamic> map) {
    return Immobile(
      id: map['id'] ?? 0, 
      name: map['name'] ?? 'Não informado', 
      type: map['type'] ?? 'Não informado', 
      images: map['images'] != null
          ? List<ImmobileImage>.from(map['images'].map<ImmobileImage>((image) => ImmobileImage.toMap(image)))
          : [],
    );
  }
}

class ImmobileImage {
  int id;
  String url;

  ImmobileImage({
    required this.id,
    required this.url,
  });

  factory ImmobileImage.toMap(Map<String, dynamic> map) {
    return ImmobileImage(
      id: map['id'] ?? 0,
      url: map['url'] ?? "https://storage.googleapis.com/imogoat-oficial-ab14c.appspot.com/imoveis/default_image.jpg",
    );
  }
}
