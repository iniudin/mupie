import 'package:ditonton/presentation/blocs/tv/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvTopRatedPage extends StatefulWidget {
  const TvTopRatedPage({Key? key}) : super(key: key);

  @override
  State<TvTopRatedPage> createState() => _TvTopRatedPageState();
}

class _TvTopRatedPageState extends State<TvTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvTopRatedBloc>().add(const GetTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: ((context, state) {
            if (state is TvTopRatedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvList[index];
                  return ItemCard(
                    title: tv.title,
                    overview: tv.overview,
                    posterPath: tv.posterPath,
                    isMovie: 0,
                  );
                },
                itemCount: state.tvList.length,
              );
            } else if (state is TvTopRatedError) {
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
