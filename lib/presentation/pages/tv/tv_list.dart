import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/blocs/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/item_list_card.dart';
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
      context.read<TvTopRatedBloc>().add(const GetTopRated());
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
