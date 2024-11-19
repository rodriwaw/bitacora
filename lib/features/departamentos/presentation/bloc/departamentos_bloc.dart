import 'package:bloc/bloc.dart';

import '../../../../core/utils/usecases/usecase.dart';
import '../../domain/departamentos_model.dart';
import '../../../../core/utils/api_response.dart';
import '../../domain/departamentos_usecase.dart';

part 'departamentos_event.dart';
part 'departamentos_state.dart';

class DepartamentosBloc extends Bloc<DepartamentosEvent, DepartamentosState> {
  final GetDepartamentosUseCase? getDepartamentosUseCase;

  DepartamentosBloc({
    this.getDepartamentosUseCase,
  }) : super(DepartamentosLoading()) {
    on<GetDepartamentosEvent>(_getDepartamentos);
  }

  Future<void> _getDepartamentos(GetDepartamentosEvent event, Emitter<DepartamentosState> emit) async {
    if (event.loading) {
      emit(DepartamentosLoading());
    }
    if (getDepartamentosUseCase != null) {
      final result = await getDepartamentosUseCase!.call(NoParams());
      result.fold((l) => emit(DepartamentosError(l.message)), (r) => emit(DepartamentosLoaded(r)));
    } else {
      emit(DepartamentosError('GetDepartamentosUseCase was not provided'));
    }
  }
}
