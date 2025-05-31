import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';

class NewsItemModel extends NewsItemEntity {
  const NewsItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.body,
    required super.date, // Consider parsing this to DateTime if needed
    required super.imageUrl,
    required super.category,
  });

  factory NewsItemModel.fromJson(Map<String, dynamic> json) {
    return NewsItemModel(
      id: json['id'] as String? ?? '', // Handle potential null ID from Supabase
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? '',
      body: json['body'] as String? ?? '', // Assuming 'body' field in Supabase
      date: DateTime.parse(json['date']),
      imageUrl:
          json['image_url'] as String? ?? '', // Assuming 'image_url' field
      category:
          json['category'] as String? ?? 'News', // Assuming 'category' field
    );
  }

  // toJson might be needed if you plan to create/update news items
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'body': body,
      'created_at': date, // Match Supabase column name if needed
      'image_url': imageUrl,
      'category': category,
    };
  }
}
