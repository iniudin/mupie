import 'package:ditonton/presentation/blocs/movie/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieTopRatedPage extends StatefulWidget {
  const MovieTopRatedPage({Key? key}) : super(key: key);

  @override
  State<MovieTopRatedPage> createState() => _MovieTopRatedPageState();
}

class _MovieTopRatedPageState extends State<MovieTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieTopRatedBloc>().add(const GetMovieTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
          builder: ((context, state) {
            if (state is MovieTopRatedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movieList[index];
                  return ItemCard(
                    title: movie.title,
                    overview: movie.overview,
                    posterPath: movie.posterPath,
                    isMovie: 1,
                  );
                },
                itemCount: state.movieList.length,
              );
            } else if (state is MovieTopRatedError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(child: Text('Failed'));
            }
          }),
        ),
      ),
    );
  }
}
