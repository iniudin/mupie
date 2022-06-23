import 'package:ditonton/domain/entities/content_arguments.dart';
import 'package:ditonton/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/widgets/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailPage extends StatefulWidget {
  final ContentArguments arguments;
  const TvDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<TvDetailPage> createState() => TvDetailPageState();
}

class TvDetailPageState extends State<TvDetailPage> with RouteAware {
  @override
  void initState() {
    Future.microtask(
      () => context.read<TvDetailBloc>().add(GetDetailTv(widget.arguments.id)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvDetailLoaded) {
            final detail = state.tvDetail;
            return DetailContent(
              id: detail.id,
              title: detail.title,
              posterPath: detail.posterPath,
              overview: detail.overview,
              genres: detail.genres,
              runtime: detail.runtime,
              voteAverage: detail.voteAverage,
              isMovie: widget.arguments.isMovie,
            );
          } else if (state is TvDetailError) {
            return Center(child: Text(state.message));
          } else {
            return const Text("Empty");
          }
        },
      ),
    );
  }
}
