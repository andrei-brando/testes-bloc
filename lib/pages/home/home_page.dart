import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_bloc_renatomota/pages/home/bloc/home_bloc.dart';
import 'package:teste_bloc_renatomota/pages/home/bloc/home_event.dart';
import 'package:teste_bloc_renatomota/pages/home/bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo Bloc'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              bloc.add(HomeFetchListWithError());
            },
          ),
        ],
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomeStateLoaded) {
            return ListView.builder(
              itemCount: 50,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            );
          }

          if (state is HomeErrorState) {
            return Center(child: Text(state.message));
          }

          if (state is HomeStateEmptyList) {
            return const Center(child: Text('Não há dados disponíveis'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
