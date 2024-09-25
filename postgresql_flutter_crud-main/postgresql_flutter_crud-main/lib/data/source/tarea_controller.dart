import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/tarea_models.dart';

class TareaController extends StateNotifier<AsyncValue<List<Tarea>>> {
  TareaController(this.ref) : super(const AsyncValue.loading());

  final StateNotifierProviderRef<TareaController, AsyncValue<List<Tarea>>>
      ref;

  void notifyConsumers(List<Tarea> updatedProducts) {
    state = AsyncValue.data(updatedProducts);
  }

  //Function for add nueva
  Future<void> agregarTarea(Tarea nuevaTarea) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8001/api/tarea'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(nuevaTarea.toJson()),
      );

      if (response.statusCode == 200) {
        await reloadTareas();
      } else {
        throw Exception('Error agregando nueva tarea');
      }
    } catch (error) {
      throw Exception('Error agregarTarea: $error');
    }
  }

  //Funtion for load list products
  Future<void> cargaTareas() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8001/api/tareas'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(response.body);
        final List<Tarea> tareaList = data
            .map((item) => Tarea(
                id: item['id'],
                titulo: item['titulo'],
                estado: item['estado'],
                ))
            .toList();

        state = AsyncValue.data(tareaList);
      } else {
        throw Exception('Error cargando tareas');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> reloadTareas() async {
    await cargaTareas();
  }

  //Function for delete product
  Future<void> eliminarTarea(int? tareaId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://127.0.0.1:8001/api/tarea/$tareaId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await reloadTareas();
      } else {
        throw Exception('Error CONTROLLER');
      }
    } catch (error) {
      throw Exception('Error eliminarTarea: $error');
    }
  }

  Future<void> editarTarea(int? tareaId, Tarea tareaUp) async {
    try {      
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8001/api/tarea/$tareaId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(tareaUp.toJson()),
      );

      if (response.statusCode == 200) {        
        await reloadTareas();
      } else {
        throw Exception('Error actualizar');
      }
    } catch (error) {
      throw Exception('Error editar Tarea: $error');
    }
  }
}
