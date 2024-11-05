/* import 'package:bitacora/features/asociados/presentation/bloc/asociados_bloc.dart';
import 'package:test/test.dart';

import 'package:bitacora/core/utils/injections.dart';
import 'package:bitacora/features/asociados/domain/asociado_usecase.dart';

void main() {
  group(AsociadosBloc(asociadoUseCase: sl<AsociadoUseCase>()), () {
    //Let’s start by creating an instance of our CounterBloc which will be used across all of our tests.
    late AsociadosBloc asociadosBloc;
    setUp(() {
      asociadosBloc = AsociadosBloc(asociadoUseCase: sl<AsociadoUseCase>());
    });
    test('initial state is loading', () {
      expect(asociadosBloc.state, equals(AsociadosLoading()));
      expect(asociadosBloc.state, equals(AsociadosInitial()));
    });
  });
}
 */