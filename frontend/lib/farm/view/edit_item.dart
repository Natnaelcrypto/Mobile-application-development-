import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../farm_bloc/farm_bloc.dart';
import '../farm_bloc/farm_event.dart';
import '../farm_bloc/farm_state.dart';
import '../farm_model/farm_model.dart';

class EditItemScreen extends StatefulWidget {
  final Farm item;

  const EditItemScreen({super.key, required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();
  final TextEditingController _additionalField1Controller =
      TextEditingController();
  final TextEditingController _additionalField2Controller =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    print(" feed ${widget.item.isfeed} medicaton ${widget.item.isfeed}");

    _nameController.text = widget.item.itemName;
    _quantityController.text = widget.item.quantity.toString();
    _expirationDateController.text = widget.item.expirationDate.toString();

    if (widget.item.ismedication) {
      _additionalField1Controller.text = widget.item.dosage;
      _additionalField2Controller.text = widget.item.instructions;
    } else if (widget.item.isfeed) {
      _additionalField1Controller.text = widget.item.brand;
      _additionalField2Controller.text = widget.item.type;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _expirationDateController.dispose();
    _additionalField1Controller.dispose();
    _additionalField2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmBloc, FarmState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Item'),
            backgroundColor: Color.fromRGBO(36, 130, 50, .6),
          ),
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _expirationDateController,
                    decoration: const InputDecoration(
                      labelText: 'Expiration Date',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _additionalField1Controller,
                    decoration: InputDecoration(
                      labelText: getAdditionalField1Label(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _additionalField2Controller,
                    decoration: InputDecoration(
                      labelText: getAdditionalField2Label(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String newName = _nameController.text;
                          String newQuantity = _quantityController.text;

                          Farm editedItem;

                          if (widget.item.ismedication) {
                            editedItem = Farm(
                              itemName: newName,
                              quantity: _quantityController.text,
                              expirationDate: _expirationDateController.text,
                              dosage: _additionalField1Controller.text,
                              instructions: _additionalField2Controller.text,
                              userID: widget.item.userID,
                              farmName: widget.item.userID,
                              id_: widget.item.id_,
                              isfeed: widget.item.isfeed,
                              ismedication: widget.item.ismedication,
                              brand: widget.item.brand,
                              type: widget.item.type,
                            );
                          } else if (widget.item.isfeed) {
                            editedItem = Farm(
                              itemName: newName,
                              quantity: _quantityController.text,
                              brand: _additionalField1Controller.text,
                              type: _additionalField2Controller.text,
                              expirationDate: _expirationDateController.text,
                              userID: widget.item.userID,
                              farmName: widget.item.userID,
                              id_: widget.item.id_,
                              isfeed: widget.item.isfeed,
                              ismedication: widget.item.ismedication,
                              dosage: _additionalField1Controller.text,
                              instructions: widget.item.instructions,
                            );
                          } else {
                            return;
                          }
                          final FarmEvent event =
                              FarmUpdate(id: widget.item.id_, farm: editedItem);
                          BlocProvider.of<FarmBloc>(context).add(event);

                          if (state is FarmDataLoaded) {
                            context.go("/inventory");
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(8, 103, 136, .9)),
                        ),
                        child: Text('Save Changes'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.go("/inventory");
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(161, 103, 74, .9)),
                          ),
                          child: Text("Back"))
                    ],
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }

  String getAdditionalField1Label() {
    if (widget.item.ismedication) {
      return 'Dosage';
    } else if (widget.item.isfeed) {
      return 'Brand';
    }
    return "";
  }

  String getAdditionalField2Label() {
    if (widget.item.ismedication) {
      return 'Instructions';
    } else if (widget.item.isfeed) {
      return 'Type';
    }
    return "";
  }
}
