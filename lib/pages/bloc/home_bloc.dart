import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_bloc_renatomota/pages/bloc/home_event.dart';
import 'package:teste_bloc_renatomota/pages/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(HomeLoadingState()) {
    on<HomeFetchList>((event, emit) async => emit(await _fetchList()));
    on<HomeFetchListWithError>(
        (event, emit) async => emit(await _fetchListWithError()));
    on<HomeFetchListWithEmptyList>(
        (event, emit) async => emit(await _fetchListWithEmptyList()));
  }

  // Para simular o erro e a lista vazia, vamos criar um método a parte, mas em produção
  // vai ser um método único que vai estourar os erros e tudo mais
  Future<HomeState> _fetchList() async {
    var list = await Future.delayed(
      const Duration(seconds: 2),
      () => <String>[
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
      ],
    );

    return HomeStateLoaded(list: list);
  }

  Future<HomeState> _fetchListWithError() async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => HomeErrorState(message: 'Não foi possível carregar os dados'),
    );
  }

  Future<HomeState> _fetchListWithEmptyList() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return HomeStateEmptyList();
  }
}
