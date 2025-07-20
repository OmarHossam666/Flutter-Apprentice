import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import '../models/order_manager.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key,
      required this.cartManager,
      required this.onSubmit,
      required this.didUpdate});

  final CartManager cartManager;
  final void Function(Order order) onSubmit;
  final void Function() didUpdate;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Map<int, Widget> myTabs = <int, Widget>{
    0: const Text('Delivery'),
    1: const Text('Self Pick-Up'),
  };
  Set<int> selectedSegment = {0};
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);
  final TextEditingController _nameController = TextEditingController();

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Select Date';
    } else {
      final formatter = DateFormat('yyyy:MM:dd');
      return formatter.format(dateTime);
    }
  }

  String _formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return 'Select Time';
    } else {
      final hours = timeOfDay.hour.toString().padLeft(2, '0');
      final minutes = timeOfDay.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    }
  }

  void onSegmentSelected(Set<int> segmentIndex) {
    setState(() {
      selectedSegment = segmentIndex;
    });
  }

  Widget _buildSegmentedControl() {
    return SegmentedButton(
      segments: [
        ButtonSegment(
          value: 0,
          icon: const Icon(Icons.motorcycle),
          label: myTabs.values.first,
        ),
        ButtonSegment(
          value: 1,
          icon: const Icon(Icons.local_mall),
          label: myTabs.values.last,
        ),
      ],
      selected: selectedSegment,
      onSelectionChanged: onSegmentSelected,
      showSelectedIcon: false,
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        label: Text('Contact Name'),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: _firstDate,
      lastDate: _lastDate,
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        });
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Widget _buildOrderSummary(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme =
        Theme.of(context).textTheme.apply(displayColor: colorScheme.onPrimary);

    return Expanded(
      child: ListView.builder(
        itemCount: widget.cartManager.items.length,
        itemBuilder: (context, index) {
          final item = widget.cartManager.itemAt(index);
          return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                widget.cartManager.removeItem(item.id);
              });
              widget.didUpdate();
            },
            key: Key(item.id),
            background: Container(),
            secondaryBackground: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete),
              ],
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Text('x${item.quantity}'),
                ),
              ),
              title: Text(
                item.name,
                style: textTheme.titleSmall,
              ),
              subtitle: Text(
                'Price: \$${item.price}',
                style: textTheme.labelLarge,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitOrderButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: widget.cartManager.isEmpty
          ? null
          : () {
              final selectedSegment = this.selectedSegment;
              final name = _nameController.text;
              final selectedDate = this.selectedDate;
              final selectedTime = this.selectedTime;
              final items = widget.cartManager.items;

              final order = Order(
                selectedSegment: selectedSegment,
                selectedTime: selectedTime,
                selectedDate: selectedDate,
                name: name,
                items: items,
              );

              widget.onSubmit(order);

              widget.cartManager.resetCart();
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.inversePrimary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.all(24.0),
        elevation: 5,
      ),
      child: Text(
        'Submit Order - ${widget.cartManager.totalCost}',
        style: textTheme.labelMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order Details',
              style: textTheme.headlineSmall,
            ),
            _buildSegmentedControl(),
            _buildNameTextField(),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    formatDate(selectedDate),
                  ),
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    _formatTimeOfDay(selectedTime),
                  ),
                ),
              ],
            ),
            Text(
              'Order Summary',
              style: textTheme.titleMedium,
            ),
            _buildOrderSummary(context),
            _buildSubmitOrderButton(context),
          ],
        ),
      ),
    );
  }
}
