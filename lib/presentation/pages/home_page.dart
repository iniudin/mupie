import 'package:ditonton/presentation/blocs/home/home_index_cubit.dart';
import 'package:ditonton/presentation/pages/movie/movie_list.dart';
import 'package:ditonton/presentation/pages/tv/tv_list.dart';
import 'package:ditonton/utils/route/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                context.read<HomeIndexCubit>().setIndexPage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Shows'),
              onTap: () {
                context.read<HomeIndexCubit>().setIndexPage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                context.read<HomeIndexCubit>().setIndexPage(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              onTap: () {
                context.read<HomeIndexCubit>().setIndexPage(4);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: IndexedStack(
        index: context.watch<HomeIndexCubit>().state,
        children: const <Widget>[
          MoviePage(),
          TvPage(),
        ],
      ),
    );
  }
}
