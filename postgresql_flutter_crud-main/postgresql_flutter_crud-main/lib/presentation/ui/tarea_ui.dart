import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apptareas_flutter_crud/core/providers/tarea_provider.dart';
import 'package:apptareas_flutter_crud/data/models/tarea_models.dart';
import 'package:apptareas_flutter_crud/presentation/widget/show_modal_tarea.dart';
import '../widget/tarea_list_tile.dart';

class TareaUi extends ConsumerStatefulWidget {
  const TareaUi({super.key});

  @override
  ProductUiState createState() => ProductUiState();
}

class ProductUiState extends ConsumerState<TareaUi> {
  
  @override
  void initState() {
    super.initState();
    ref.read(tareaControllerProvider.notifier).reloadTareas();
  }

  @override
  Widget build(BuildContext context) {
    final Tareas = ref.watch(tareasProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas lista'),
        actions: [
          ElevatedButton(
            onPressed: () {
              //Call widget functions for add new product or edit
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ShowModalTarea(
                    onAdd: (titulo, estado) async {
                      final nuevaTarea = Tarea(
                        titulo: titulo,
                        estado: estado,
                      );
                      await ref
                          .read(tareaControllerProvider.notifier)
                          .agregarTarea(nuevaTarea);
                    },
                  );
                },
              );
            },
            child: const Text('Agregar Tarea'),
          ),
        ],
      ),
      body: Tareas.when(
        loading: () {
          return const CircularProgressIndicator();
        },
        error: (error, stackTrace) => Text('Error: $error'),
        data: (tareaList) {
          
          return ListView.builder(
            itemCount: tareaList.length,
            itemBuilder: (context, index) {
              final tarea = tareaList[index];
              return TareaTile(tarea: tarea);
            },
          );
        },
      ),
    );
  }
}
