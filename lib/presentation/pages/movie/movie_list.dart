import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/blocs/movie_on_playing/movie_on_playing_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/item_list_card.dart';
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
      context.read<MovieOnPlayingBloc>().add(const GetMovieNowPlaying());
      context.read<MovieTopRatedBloc>().add(const GetMovieTopRated());
      context.read<MoviePopularBloc>().add(const GetMoviePopular());
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
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = state.movieList[index];
                        return ItemListCard(
                          id: item.id,
                          title: item.title,
                          overview: item.overview,
                          posterPath: item.posterPath,
                          isMovie: 1,
                        );
                      },
                      itemCount: state.movieList.length,
                    ),
                  );
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
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = state.movieList[index];
                        return ItemListCard(
                          id: item.id,
                          title: item.title,
                          overview: item.overview,
                          posterPath: item.posterPath,
                          isMovie: 1,
                        );
                      },
                      itemCount: state.movieList.length,
                    ),
                  );
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
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = state.movieList[index];
                        return ItemListCard(
                          id: item.id,
                          title: item.title,
                          overview: item.overview,
                          posterPath: item.posterPath,
                          isMovie: 1,
                        );
                      },
                      itemCount: state.movieList.length,
                    ),
                  );
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
