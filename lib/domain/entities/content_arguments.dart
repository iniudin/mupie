import 'package:equatable/equatable.dart';

class ContentArguments extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final int isMovie;

  const ContentArguments({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.isMovie,
  });

  @override
  List<Object> get props => [
        id,
        title,
        overview,
        posterPath,
        isMovie,
      ];
}
