import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/content_arguments.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/presentation/blocs/detail/detail_bloc.dart';
import 'package:ditonton/presentation/blocs/movie/popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/utils/route/route_observer_helper.dart';
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
    Future.microtask(
      () => widget.arguments.isMovie == 1
          ? context.read<DetailBloc>().add(GetMovieDetail(widget.arguments.id))
          : context.read<DetailBloc>().add(GetTvDetail(widget.arguments.id)),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPop() {
    Future.microtask(
        () => context.read<WatchlistBloc>().add(const GetWatchlist()));
    super.didPop();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, DetailState>(
          builder: ((context, state) {
            if (state is DetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvDetailLoaded) {
              final detail = state.tvDetail;
              return DetailContent(id: detail.id, title: detail.title, posterPath: detail.posterPath, overview: detail.overview, genres: detail.genres, runtime: detail.runtime, voteAverage: detail.voteAverage,);
            } else if (state is MovieDetailLoaded) {
              final detail = state.movieDetail;
              return DetailContent(id: detail.id, title: detail.title, posterPath: detail.posterPath, overview: detail.overview, genres: detail.genres, runtime: detail.runtime, voteAverage: detail.voteAverage,);
            } else if (state is DetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Text("");
            }
          }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final List<Genre> genres;
  final int runtime;
  final double voteAverage;

  const DetailContent({
    Key? key,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.genres,
    required this.runtime,
    required this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<MovieDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(movie);
                                } else {
                                  await Provider.of<MovieDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(movie);
                                }

                                final message =
                                    Provider.of<MovieDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        MovieDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        MovieDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
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
                            BlocBuilder<DetailBloc, DetailState>(
                              builder: ((context, state) {
                                if (state is MoviePopularLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is TvRecommendationsLoaded) {
                                  return MovieList(state.movieList);
                                } else if (state is MoviePopularError) {
                                  return Center(child: Text(state.message));
                                } else {
                                  return const Center(child: Text('Failed'));
                                }
                              }),
                            ),
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
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
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
