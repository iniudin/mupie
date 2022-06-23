import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/item_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailContent extends StatefulWidget {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final List<Genre> genres;
  final int runtime;
  final double voteAverage;
  final int isMovie;

  const DetailContent({
    Key? key,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.genres,
    required this.runtime,
    required this.voteAverage,
    required this.isMovie,
  }) : super(key: key);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> with RouteAware {
  @override
  void initState() {
    Future.microtask(() {
      widget.isMovie == 1
          ? context
              .read<MovieRecommendationBloc>()
              .add(GetMovieRecommendation(widget.id))
          : context
              .read<TvRecommendationBloc>()
              .add(GetTvRecommendation(widget.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWatchlist =
        (context.watch<WatchlistBloc>().state is WatchlistListed);
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.posterPath}',
          width: screenWidth,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error_outline)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                isWatchlist
                                    ? context
                                        .read<WatchlistBloc>()
                                        .add(RemoveWatchlist(
                                          Watchlist(
                                              id: widget.id,
                                              title: widget.title,
                                              overview: widget.overview,
                                              posterPath: widget.posterPath,
                                              isMovie: widget.isMovie),
                                        ))
                                    : context
                                        .read<WatchlistBloc>()
                                        .add(AddWatchlist(
                                          Watchlist(
                                              id: widget.id,
                                              title: widget.title,
                                              overview: widget.overview,
                                              posterPath: widget.posterPath,
                                              isMovie: widget.isMovie),
                                        ));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.genres),
                            ),
                            Text(
                              _showDuration(widget.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _buildRecommendations(widget.id, widget.isMovie),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildRecommendations(int id, int isMovie) {
    return isMovie == 1
        ? BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
            builder: (context, state) {
              if (state is MovieRecommendationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieRecommendationLoaded) {
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
              } else if (state is MovieRecommendationError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Failed'));
              }
            },
          )
        : BlocBuilder<TvRecommendationBloc, TvRecommendationState>(
            builder: (context, state) {
              if (state is TvRecommendationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TvRecommendationLoaded) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = state.tvList[index];
                      return ItemListCard(
                        id: item.id,
                        title: item.title,
                        overview: item.overview,
                        posterPath: item.posterPath,
                        isMovie: 0,
                      );
                    },
                    itemCount: state.tvList.length,
                  ),
                );
              } else if (state is TvRecommendationError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('Failed'));
              }
            },
          );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
