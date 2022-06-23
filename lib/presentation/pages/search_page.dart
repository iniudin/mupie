import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/search_arguments.dart';
import 'package:ditonton/presentation/blocs/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  final SearchArguments arguments;
  const SearchPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  late MovieSearchBloc _movieSearchBloc;
  late TvSearchBloc _tvSearchBloc;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.arguments.isMovie == 1
        ? _movieSearchBloc = context.read<MovieSearchBloc>()
        : _tvSearchBloc = context.read<TvSearchBloc>();
    super.initState();
  }

  void _onClearTapped() {
    _textController.text = '';
    widget.arguments.isMovie == 1
        ? _movieSearchBloc.add(const MovieTextChanged(query: ''))
        : _tvSearchBloc.add(const TvTextChanged(query: ''));
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (query) {
        widget.arguments.isMovie == 1
            ? _movieSearchBloc.add(MovieTextChanged(query: query))
            : _tvSearchBloc.add(TvTextChanged(query: query));
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: _onClearTapped,
          child: const Icon(Icons.clear),
        ),
        border: const OutlineInputBorder(),
        hintText: 'Search title',
      ),
    );
  }

  Widget _buildSearchBody(BuildContext context) {
    return widget.arguments.isMovie == 1
        ? BlocBuilder<MovieSearchBloc, MovieSearchState>(
            builder: (context, state) {
              if (state is MovieSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is MovieSearchLoaded) {
                return state.movies.isEmpty
                    ? const Text("Tidak ditemukan")
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final item = state.movies[index];
                            return ItemCard(
                              id: item.id,
                              title: item.title,
                              overview: item.overview,
                              posterPath: item.posterPath,
                              isMovie: 1,
                            );
                          },
                          itemCount: state.movies.length,
                        ),
                      );
              }
              if (state is MovieSearchError) {
                return Center(child: Text(state.message));
              }
              return const Text('');
            },
          )
        : BlocBuilder<TvSearchBloc, TvSearchState>(
            builder: (context, state) {
              if (state is TvSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TvSearchLoaded) {
                return state.tvs.isEmpty
                    ? const Text("Tidak ditemukan")
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final item = state.tvs[index];
                            return ItemCard(
                              id: item.id,
                              title: item.title,
                              overview: item.overview,
                              posterPath: item.posterPath,
                              isMovie: 0,
                            );
                          },
                          itemCount: state.tvs.length,
                        ),
                      );
              }
              if (state is TvSearchError) {
                return Center(child: Text(state.message));
              }
              return const Text('');
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.arguments.isMovie == 1
            ? const Text('Search Movie')
            : const Text('Search Tv Show'),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchBar(context),
          const SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          _buildSearchBody(context),
        ],
      ),
    );
  }
}
