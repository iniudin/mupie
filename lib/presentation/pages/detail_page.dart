import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/content_arguments.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/item_list_card.dart';
import 'package:ditonton/utils/route/route_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  final ContentArguments arguments;

  const DetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> with RouteAware {
  @override
  void initState() {
    Future.microtask(() {
      context
          .read<WatchlistBloc>()
          .add(StatusWatchlist(widget.arguments.id, widget.arguments.isMovie));
      if (widget.arguments.isMovie == 1) {
        context
            .read<MovieDetailBloc>()
            .add(GetDetailMovie(widget.arguments.id));
        context
            .read<MovieRecommendationBloc>()
            .add(GetMovieRecommendation(widget.arguments.id));
      } else {
        context.read<TvDetailBloc>().add(
              GetDetailTv(widget.arguments.id),
            );
        context
            .read<TvRecommendationBloc>()
            .add(GetTvRecommendation(widget.arguments.id));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.arguments.isMovie == 1 ? _movieBuilder() : _tvBuilder(),
    );
  }

  Widget _movieBuilder() {
    return BlocListener<WatchlistBloc, WatchlistState>(
      listener: (context, state) {
        if (state is WatchlistSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          context.read<WatchlistBloc>().add(StatusWatchlist(
                widget.arguments.id,
                widget.arguments.isMovie,
              ));
        }
      },
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoaded) {
            final detail = state.movieDetail;
            final isWatchlist = (context.watch<WatchlistBloc>().state
                    is WatchlistStatusLoaded)
                ? (context.read<WatchlistBloc>().state as WatchlistStatusLoaded)
                    .status
                : false;
            return _detailContent(
              detail.title,
              detail.posterPath,
              detail.overview,
              detail.genres,
              detail.runtime,
              detail.voteAverage,
              isWatchlist,
            );
          } else if (state is MovieDetailError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _tvBuilder() {
    return BlocListener<WatchlistBloc, WatchlistState>(
      listener: (context, state) {
        if (state is WatchlistSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          context.read<WatchlistBloc>().add(StatusWatchlist(
                widget.arguments.id,
                widget.arguments.isMovie,
              ));
        }
      },
      child: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvDetailLoaded) {
            final detail = state.tvDetail;
            final isWatchlist = (context.watch<WatchlistBloc>().state
                    is WatchlistStatusLoaded)
                ? (context.read<WatchlistBloc>().state as WatchlistStatusLoaded)
                    .status
                : false;
            if (kDebugMode) print(isWatchlist);
            return _detailContent(
              detail.title,
              detail.posterPath,
              detail.overview,
              detail.genres,
              detail.runtime,
              detail.voteAverage,
              isWatchlist,
            );
          } else if (state is TvDetailError) {
            return Center(child: Text(state.message));
          } else {
            return const Text("");
          }
        },
      ),
    );
  }

  Widget _detailContent(
    String title,
    String posterPath,
    String overview,
    List<Genre> genres,
    int runtime,
    double voteAverage,
    bool isWatchlist,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500$posterPath',
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
                              title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                isWatchlist
                                    ? context
                                        .read<WatchlistBloc>()
                                        .add(RemoveWatchlist(
                                          Watchlist(
                                            id: widget.arguments.id,
                                            title: title,
                                            overview: overview,
                                            posterPath: posterPath,
                                            isMovie: widget.arguments.isMovie,
                                          ),
                                        ))
                                    : context
                                        .read<WatchlistBloc>()
                                        .add(AddWatchlist(
                                          Watchlist(
                                            id: widget.arguments.id,
                                            title: title,
                                            overview: overview,
                                            posterPath: posterPath,
                                            isMovie: widget.arguments.isMovie,
                                          ),
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
                              _showGenres(genres),
                            ),
                            Text(
                              _showDuration(runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('$voteAverage')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _buildRecommendations(),
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

  Widget _buildRecommendations() {
    return widget.arguments.isMovie == 1
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
                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              detailRoute,
                              arguments: ContentArguments(
                                id: item.id,
                                title: item.title,
                                overview: item.overview,
                                posterPath: item.posterPath,
                                isMovie: widget.arguments.isMovie,
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: CachedNetworkImage(
                              imageUrl: '$baseImageUrl${item.posterPath}',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
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
                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              detailRoute,
                              arguments: ContentArguments(
                                id: item.id,
                                title: item.title,
                                overview: item.overview,
                                posterPath: item.posterPath,
                                isMovie: widget.arguments.isMovie,
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: CachedNetworkImage(
                              imageUrl: '$baseImageUrl${item.posterPath}',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
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
