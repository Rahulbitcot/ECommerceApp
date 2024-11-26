class Items {
  const Items({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.price,
    required this.discount,
    required this.description,
  });

  final String id;
  final String title;
  final String imgUrl;
  final String price;
  final String discount;
  final String description;

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'].toString(),
      title: json['title'],
      imgUrl: json['image'],
      price: json['price'].toString(),
      discount: "50 % off ",
      description: json['description'] ?? '',
    );
  }
}
