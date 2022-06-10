import 'package:ditonton/presentation/blocs/Tv/popular/popular_bloc.dart';
import 'package:ditonton/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvPopularPage extends StatefulWidget {
  const TvPopularPage({Key? key}) : super(key: key);

  @override
  State<TvPopularPage> createState() => _TvPopularPageState();
}

class _TvPopularPageState extends State<TvPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvPopularBloc>().add(const GetPopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: ((context, state) {
            if (state is TvPopularLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvPopularLoaded) {
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
            } else if (state is TvPopularError) {
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
