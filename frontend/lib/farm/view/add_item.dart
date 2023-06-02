import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../LocalStroe/Store.dart';
import '../../screens/Error_page.dart';
import '../farm_bloc/farm_bloc.dart';
import '../farm_bloc/farm_event.dart';
import '../farm_bloc/farm_state.dart';
import '../farm_model/farm_model.dart';


class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _expirationDateController =
      TextEditingController();

  final TextEditingController _dosage = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  final TextEditingController _brand = TextEditingController();
  final TextEditingController _type = TextEditingController();
  String _selectedItemType = '';
  Widget _additionalFieldsWidget = SizedBox.shrink();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _expirationDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmBloc, FarmState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Item'),
            backgroundColor: Color.fromRGBO(36, 130, 50, .6),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey2,
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your item name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Item Name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _quantityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Quantity';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _expirationDateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Expiration date';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Expiration Date',
                      ),
                      onTap: () {
                        // Show a date picker dialog
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedItemType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItemType = newValue!;
                          _additionalFieldsWidget =
                              _buildAdditionalFieldsWidget();
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(
                          value: '',
                          child: Text('Select Item Type'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'medication',
                          child: Text('Medication'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'feed',
                          child: Text('Feed'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Item Type',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _additionalFieldsWidget,
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            bool medication = false;
                            bool feed = false;
                            if (_selectedItemType == "medication") {
                              medication = true;
                            }
                            if (_selectedItemType == "feed") {
                              feed = true;
                            }
                            final FarmEvent event = FarmCreate(
                              Farm(
                                userID: UserPreferences.userId,
                                farmName: UserPreferences.farmName,
                                id_: "",
                                expirationDate: _expirationDateController.text,
                                itemName: _nameController.text,
                                dosage: _dosage.text,
                                instructions: _instructions.text,
                                isfeed: feed,
                                ismedication: medication,
                                quantity: _quantityController.text,
                                brand: _brand.text,
                                type: _type.text,
                              ),
                            );
                            BlocProvider.of<FarmBloc>(context).add(event);
                            if (state is FarmDataLoadingError) {
                              const ErrorScreen();
                            }
                            if (state is FarmDataLoaded) {
                              context.go("/inventory");
                            }

                            // context.go("/inventory");
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(8, 103, 136, .9)),
                          ),
                          child: const Text('Add Item'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.go("/inventory");
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(161, 103, 74, .9)),
                          ),
                          child: const Text(
                            "Back",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdditionalFieldsWidget() {
    if (_selectedItemType.isEmpty) {
      return const SizedBox.shrink();
    }

    switch (_selectedItemType) {
      case 'medication':
        return Column(
          children: [
            TextFormField(
              controller: _dosage,
              decoration: InputDecoration(
                labelText: 'Dosage',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _instructions,
              decoration: InputDecoration(
                labelText: 'Instruction',
              ),
            ),
          ],
        );

      case 'feed':
        return Column(
          children: [
            TextFormField(
              controller: _brand,
              decoration: InputDecoration(
                labelText: 'Brand',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _type,
              decoration: InputDecoration(
                labelText: 'Type',
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
