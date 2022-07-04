import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/item_card.dart';
import 'package:ditonton/utils/route/route_observer_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistBloc>().add(const GetList());
    });
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    Future.microtask(() {
      context.read<WatchlistBloc>().add(const GetList());
    });
    super.didPopNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: ((context, state) {
            if (state is WatchlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WatchlistLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final item = state.watchlist[index];
                  return ItemCard(
                    id: item.id,
                    title: item.title,
                    overview: item.overview,
                    posterPath: item.posterPath,
                    isMovie: item.isMovie,
                  );
                },
                itemCount: state.watchlist.length,
              );
            } else if (state is WatchlistError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is WatchlistNoData) {
              return Center(
                child: Text(
                  "Watchlist anda masih kosong",
                  style: kHeading6,
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Failed',
                  style: kHeading6,
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
