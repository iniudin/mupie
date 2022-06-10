import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/blocs/movie/on_playing/on_playing_bloc.dart';
import 'package:ditonton/presentation/blocs/movie/popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/movie/top_rated/top_rated_bloc.dart';
import 'package:ditonton/utils/route/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieOnPlayingBloc>().add(const GetNowPlaying());
    });
    Future.microtask(() {
      context.read<MovieTopRatedBloc>().add(const GetTopRated());
    });
    Future.microtask(() {
      context.read<MoviePopularBloc>().add(const GetPopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<MovieOnPlayingBloc, MovieOnPlayingState>(
              builder: ((context, state) {
                if (state is MovieOnPlayingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieOnPlayingLoaded) {
                  return MovieList(state.movieList);
                } else if (state is MovieOnPlayingError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Failed'));
                }
              }),
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, moviePopularRoute),
            ),
            BlocBuilder<MoviePopularBloc, MoviePopularState>(
              builder: ((context, state) {
                if (state is MoviePopularLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MoviePopularLoaded) {
                  return MovieList(state.movieList);
                } else if (state is MoviePopularError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Failed'));
                }
              }),
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, movieTopRatedRoute),
            ),
            BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
              builder: ((context, state) {
                if (state is MovieTopRatedLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieTopRatedLoaded) {
                  return MovieList(state.movieList);
                } else if (state is MovieTopRatedError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Failed'));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  // ignore: use_key_in_widget_constructors
  const MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
