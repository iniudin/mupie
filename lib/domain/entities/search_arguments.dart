import 'package:equatable/equatable.dart';

class SearchArguments extends Equatable {
  const SearchArguments({
    required this.isMovie,
  });

  final int isMovie;

  @override
  List<Object> get props => [isMovie];
}
