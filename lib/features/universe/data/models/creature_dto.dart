class CreatureDto {
  CreatureDto({
    required this.name,
    required this.description,
    required this.image,
  });

  final String name;
  final String description;
  final String image;

  factory CreatureDto.fromJson(Map<String, dynamic> json) {
    return CreatureDto(
      name: (json['name'] ?? json['title'] ?? json['creature'] ?? '').toString(),
      description: (json['description'] ?? json['desc'] ?? '').toString(),
      image: (json['image'] ?? json['img'] ?? '').toString(),
    );
  }
}
