import 'package:ditonton/domain/entities/content_arguments.dart';
import 'package:ditonton/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/widgets/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final ContentArguments arguments;
  const MovieDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<MovieDetailPage> with RouteAware {
  @override
  void initState() {
    Future.microtask(
      () => context
          .read<MovieDetailBloc>()
          .add(GetDetailMovie(widget.arguments.id)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoaded) {
            final detail = state.movieDetail;
            return DetailContent(
              id: detail.id,
              title: detail.title,
              posterPath: detail.posterPath,
              overview: detail.overview,
              genres: detail.genres,
              runtime: detail.runtime,
              voteAverage: detail.voteAverage,
              isMovie: widget.arguments.isMovie,
            );
          } else if (state is MovieDetailError) {
            return Center(child: Text(state.message));
          } else {
            return const Text("Empty");
          }
        },
      ),
    );
  }
}
