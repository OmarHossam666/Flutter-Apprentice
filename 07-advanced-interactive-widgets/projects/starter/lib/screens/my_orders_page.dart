import 'package:flutter/material.dart';

import '../models/order_manager.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key, required this.orderManager});

  final OrderManager orderManager;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: colorScheme.onSurfaceVariant);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'My Orders',
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderTile(
            order: orderManager.orders[index],
            textTheme: textTheme,
          );
        },
        itemCount: orderManager.totalOrders,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: true,
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.order,
    required this.textTheme,
  });

  final Order order;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/food/burger.webp',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scheduled',
            style: textTheme.titleMedium,
          ),
          Text(
            order.getFormattedOrderInfo(),
            style: textTheme.bodyMedium,
          ),
          Text(
            '${order.items.length} Items',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
