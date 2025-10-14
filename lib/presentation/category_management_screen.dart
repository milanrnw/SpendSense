import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendsense/models/categories.dart';
import 'package:spendsense/services/firestore_service.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    String categoryType = 'expense';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Add New Category"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Category Name",
                    ),
                    autofocus: true,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      const Text("Type:"),
                      Radio<String>(
                        value: 'expense',
                        groupValue: categoryType,
                        onChanged: (value) =>
                            setDialogState(() => categoryType = value!),
                      ),
                      const Text("Expense"),
                      Radio<String>(
                        value: 'income',
                        groupValue: categoryType,
                        onChanged: (value) =>
                            setDialogState(() => categoryType = value!),
                      ),
                      const Text("Income"),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      final newCategory = CategoryModel(
                        id: name.toLowerCase().replaceAll(' ', '_'),
                        name: name,
                        type: categoryType,
                      );
                      _firestoreService.addCategory(newCategory);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Manage Categories",
          style: TextStyle(color: const Color(0xFF1B3253)),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF1B3253)),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: _firestoreService.getCategoriesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No categories found."));
          }
          final categories = snapshot.data!;
          return ListView.separated(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                leading: Icon(
                  category.type == 'income'
                      ? Icons.arrow_circle_up
                      : Icons.arrow_circle_down,
                  color: category.type == 'income' ? Colors.green : Colors.red,
                ),
                title: Text(category.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.grey),
                  onPressed: () =>
                      _firestoreService.deleteCategory(category.id),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCategoryDialog,
        icon: const Icon(Icons.add),
        label: const Text("Add Category"),
      ),
    );
  }
}
