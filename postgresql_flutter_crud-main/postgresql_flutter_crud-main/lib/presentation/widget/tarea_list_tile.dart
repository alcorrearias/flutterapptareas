import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apptareas_flutter_crud/data/models/tarea_models.dart';
import 'package:apptareas_flutter_crud/presentation/widget/show_modal_tarea.dart';
import 'package:apptareas_flutter_crud/presentation/widget/delete_product_widget.dart';
import 'package:apptareas_flutter_crud/core/providers/tarea_provider.dart';

//Call list products and buttons actions from producto_ui
class TareaTile extends ConsumerWidget {
  final Tarea tarea;

  const TareaTile({super.key, required this.tarea});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estadoText = tarea.estado.toString() == '0' ? 'Pendiente' : 'Completada';
    return Column(
      children: [
        ListTile(
          title: Text('${tarea.titulo.toString()}'),
          subtitle: Text('estado: ${estadoText.toString()}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Image.asset('assets/images/pen.png'),
                iconSize: 24.0, // Ajusta el tamaño del ícono si es necesario
                onPressed: () async {
                  // Mostrar el modal de edición
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ShowModalTarea(
                        onAdd: (titulo, estado) async {
                          final estadoId = estado.toString() == 'Pendiente' ? 0 : 1;
                          final updatedtarea = Tarea(
                            id: tarea.id,
                            titulo: titulo,
                            estado: estadoId,
                          );
                          await ref
                              .read(tareaControllerProvider.notifier)
                              .editarTarea(tarea.id, updatedtarea);
                        },
                        isEditMode: true,
                        editedTarea: tarea,
                      );
                    },
                  );
                },
              ),
              DeleteProductButton(product: tarea),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
