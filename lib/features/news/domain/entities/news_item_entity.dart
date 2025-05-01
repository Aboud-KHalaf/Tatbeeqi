import 'package:equatable/equatable.dart';

class NewsItemEntity extends Equatable {
  final String id;
  final String title;
  final String description; // Short description for lists/cards
  final String body; // Full content (potentially Markdown)
  final DateTime date;
  final String imageUrl;
  final String category; // Added category

  const NewsItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.body,
    required this.date,
    required this.imageUrl,
    required this.category,
  });

  @override
  List<Object?> get props =>
      [id, title, description, body, date, imageUrl, category];
}
