import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/blocs/tv/on_the_air/on_the_air_bloc.dart';
import 'package:ditonton/presentation/blocs/tv/popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/tv/top_rated/top_rated_bloc.dart';
import 'package:ditonton/utils/route/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvOnTheAirBloc>().add(const GetOnTheAir());
    });
    Future.microtask(() {
      context.read<TvTopRatedBloc>().add(const GetTopRated());
    });
    Future.microtask(() {
      context.read<TvPopularBloc>().add(const GetPopular());
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
              'On The Air',
              style: kHeading6,
            ),
            BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
              builder: ((context, state) {
                if (state is TvOnTheAirLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TvOnTheAirLoaded) {
                  return TvList(state.tvList);
                } else if (state is TvOnTheAirError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Failed'));
                }
              }),
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, tvPopularRoute),
            ),
            BlocBuilder<TvPopularBloc, TvPopularState>(
              builder: ((context, state) {
                if (state is TvPopularLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TvPopularLoaded) {
                  return TvList(state.tvList);
                } else if (state is TvPopularError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Failed'));
                }
              }),
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, tvTopRatedRoute),
            ),
            BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
              builder: ((context, state) {
                if (state is TvTopRatedLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TvTopRatedLoaded) {
                  return TvList(state.tvList);
                } else if (state is TvTopRatedError) {
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

class TvList extends StatelessWidget {
  final List<Tv> tvList;

  // ignore: use_key_in_widget_constructors
  const TvList(this.tvList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailRoute,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvList.length,
      ),
    );
  }
}
