import 'package:barberside/config/api_requests.dart';
import 'package:flutter/material.dart';

class AddServiceData {
  String serviceName = '';
  String fee = '';
  String serviceTimeInMinutes = '';
  String category = '';
}

void showAddServiceModal(BuildContext context) {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController serviceTimeController = TextEditingController();

  String selectedCategory = '';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: serviceNameController,
                  decoration: const InputDecoration(
                    labelText: 'Service Name',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: feeController,
                  decoration: const InputDecoration(
                    labelText: 'Fee',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: serviceTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Service Time (in minutes)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory.isEmpty ? null : selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  items: ['BEARD', 'HAIRSTYLE', 'HAIRCUT']
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    selectedCategory = newValue ?? '';
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      AddServiceData data = AddServiceData();
                      data.serviceName = serviceNameController.text;
                      data.fee = feeController.text;
                      data.serviceTimeInMinutes = serviceTimeController.text;
                      data.category = selectedCategory;

                      await ApiRequests().postServiceData(data);

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
