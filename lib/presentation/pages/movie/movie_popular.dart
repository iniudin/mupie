import 'package:ditonton/presentation/blocs/movie/popular/popular_bloc.dart';
import 'package:ditonton/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePopularPage extends StatefulWidget {
  const MoviePopularPage({Key? key}) : super(key: key);

  @override
  State<MoviePopularPage> createState() => _MoviePopularPageState();
}

class _MoviePopularPageState extends State<MoviePopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MoviePopularBloc>().add(const GetMoviePopular());
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
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: ((context, state) {
            if (state is MoviePopularLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MoviePopularLoaded) {
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
            } else if (state is MoviePopularError) {
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
