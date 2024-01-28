import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paralelos2/product_entity.dart';
import 'package:paralelos2/product_repository.dart';

class ProductManagementView extends ConsumerStatefulWidget {
  const ProductManagementView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductManagementViewState();
}

class _ProductManagementViewState extends ConsumerState<ProductManagementView> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    void signIn(BuildContext context) async {
      FocusManager.instance.primaryFocus?.unfocus();
      final result = _formKey.currentState?.saveAndValidate() ?? false;

      if (!result) return;

      final nombre = _formKey.currentState?.value['nombre'] as String;
      final descripcion = _formKey.currentState?.value['descripcion'] as String;
      final precio = _formKey.currentState?.value['precio'] as double;
      final cantidad = _formKey.currentState?.value['cantidad'] as int;
      final reorden = _formKey.currentState?.value['reorden'] as int;
      final categoriaId = _formKey.currentState?.value['categoria_id'] as int;
      final proveedorId = _formKey.currentState?.value['proveedor_id'] as int;

      await ref.read(productRepositoryProvider).create(nombre, descripcion,
          precio, cantidad, reorden, categoriaId, proveedorId);
    }

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Text(
                    "nombre",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'nombre',
                        keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "descripcion",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'descripcion',
                        keyboardType: TextInputType.text,
                        obscureText: hidePassword,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "precio",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'precio',
                        keyboardType: TextInputType.text,
                        obscureText: hidePassword,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "cantidad",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'cantidad',
                        keyboardType: TextInputType.text,
                        obscureText: hidePassword,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "reorden",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderTextField(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'reorden',
                        keyboardType: TextInputType.text,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text(
                    "categoria",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[200]
                            : const Color(0xff1c272b),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: FormBuilderDropdown<CategoryEntity>(
                        decoration: const InputDecoration(
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        name: 'categoria_id',
                        items: categories
                            .map((e) => DropdownMenuItem<CategoryEntity>(
                                child: Text(e.nombre)))
                            .toList(),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
                    onPressed: () {
                      signIn(context);
                    },
                    child: const Text(
                      "Guardar",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
