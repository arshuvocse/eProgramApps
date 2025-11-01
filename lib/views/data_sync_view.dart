
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/item_viewmodel.dart';

class DataSyncView extends StatefulWidget {
  const DataSyncView({super.key});

  @override
  State<DataSyncView> createState() => _DataSyncViewState();
}

class _DataSyncViewState extends State<DataSyncView> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the provider is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemViewModel>(context, listen: false).fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Sync'),
      ),
      body: Consumer<ItemViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.items.isEmpty) {
            return const Center(child: Text('No items found.'));
          }
          return ListView.builder(
            itemCount: viewModel.items.length,
            itemBuilder: (context, index) {
              final item = viewModel.items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.category),
                trailing: Text('\$${item.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
