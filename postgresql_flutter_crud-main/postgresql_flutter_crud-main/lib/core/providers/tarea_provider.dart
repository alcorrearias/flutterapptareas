import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apptareas_flutter_crud/data/source/tarea_controller.dart';
import '../../data/models/tarea_models.dart';

final tareaControllerProvider =
    StateNotifierProvider<TareaController, AsyncValue<List<Tarea>>>(
  (ref) => TareaController(ref),
);

final tareasProvider = tareaControllerProvider;
