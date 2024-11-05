import 'package:bitacora/features/asociados/domain/asociados_usecase.dart';
import 'package:bloc/bloc.dart';
import '../../../../core/utils/api_response.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../domain/asociados_model.dart';

//usa los archivos que tienen part of asociados a este archivo
part 'asociados_event.dart';
part 'asociados_state.dart';

class AsociadosBloc extends Bloc<AsociadosEvent, AsociadosState> {
  final GetAsociadosUseCase asociadoUseCase;
  final CreateAsociadoUseCase createAsociadoUseCase;

  AsociadosBloc({required this.asociadoUseCase, required this.createAsociadoUseCase}) : super(AsociadosLoading()) {
    on<GetAsociadosEvent>(_getAsociados);
  }

  Future<void> _getAsociados(GetAsociadosEvent event, Emitter<AsociadosState> emit) async {
    if (event.loading) {
      emit(AsociadosLoading());
    }
    final result = await asociadoUseCase.call(NoParams());
    result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosLoaded(r)));
  }

  Future<void> _createAsociado(AddAsociadoEvent event, Emitter<AsociadosState> emit) async {
    final result = await createAsociadoUseCase.call(event.asociado);
    result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosCreated(r)));
  }
}
