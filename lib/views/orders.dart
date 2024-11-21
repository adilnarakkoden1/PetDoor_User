import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_door_user/container/additional_confirm.dart';
import 'package:pet_door_user/controllers/db_service.dart';
import 'package:pet_door_user/models/order_model.dart';
import 'package:pet_door_user/widgets/appbar.dart';
import 'package:pet_door_user/widgets/colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  totalQuantityCalculator(List<OrderProductModel> products) {
    int qty = 0;
    products.map((e) => qty += e.quantity).toList();
    return qty;
  }

  Widget statusIcon(String status) {
    if (status == "PAID") {
      return statusContainer(
          text: "PAID", bgColor: Colors.lightGreen, textColor: Colors.white);
    }
    if (status == "ON_THE_WAY") {
      return statusContainer(
          text: "ON THE WAY", bgColor: Colors.yellow, textColor: Colors.black);
    } else if (status == "DELIVERED") {
      return statusContainer(
          text: "DELIVERED",
          bgColor: Colors.green.shade700,
          textColor: Colors.white);
    } else {
      return statusContainer(
          text: "CANCELED", bgColor: Colors.red, textColor: Colors.white);
    }
  }

  Widget statusContainer(
      {required String text,
      required Color bgColor,
      required Color textColor}) {
    return Container(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      color: bgColor,
      padding:const EdgeInsets.all(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgr,
      appBar: const CustomAppBar(title: 'Your Orders'),
      body: StreamBuilder(
        stream: DbService().readOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrdersModel> orders =
                OrdersModel.fromJsonList(snapshot.data!.docs)
                    as List<OrdersModel>;
            if (orders.isEmpty) {
              return const Center(
                child: Text("No orders found"),
              );
            } else {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/view_order",
                          arguments: orders[index]);
                    },
                    title: Text(
                        "${totalQuantityCalculator(orders[index].products)} Items Worth ₹ ${orders[index].total}"),
                    subtitle: Text(
                      "Ordered on ${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(orders[index].created_at))}",
                    ),
                    trailing: statusIcon(orders[index].status),
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrdersModel;
    String formattedDate = DateFormat('dd-MMM-yyyy  HH:mm a')
        .format(DateTime.fromMillisecondsSinceEpoch(args.created_at));

    return Scaffold(
      backgroundColor: bgr,
      appBar: CustomAppBar(
        title: 'Order Summary',
        trailing: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            icon:const Icon(Icons.home)),
      ), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Delivery Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Id : ${args.id}"),
                    Text("Order On : ${formattedDate}"),
                    Text("Order by : ${args.name}"),
                    Text("Phone no : ${args.phone}"),
                    Text("Delivery Address : ${args.address}"),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: args.products
                    .map((e) => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          25), // Rounded corners for a circular shape
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        e.image,
                                        fit: BoxFit
                                            .cover, // Makes the image cover the whole container without distortion
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(e.name)),
                                ],
                              ),
                              Text(
                                "₹${e.single_price.toString()} x ${e.quantity.toString()} quantity",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "₹${e.total_price.toString()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total : ₹${args.total}",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "Status : ${args.status}",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
             const SizedBox(
                height: 8,
              ),
              args.status == "PAID" || args.status == "ON_THE_WAY"
                  ? SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * .9,
                      child: Center(
                        child: ElevatedButton(
                          child: const Text("Modify Order"),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ModifyOrder(
                                      order: args,
                                    ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class ModifyOrder extends StatefulWidget {
  final OrdersModel order;
  const ModifyOrder({super.key, required this.order});

  @override
  State<ModifyOrder> createState() => _ModifyOrderState();
}

class _ModifyOrderState extends State<ModifyOrder> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Modify this order"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Chosse want you want to do"),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => AdditionalConfirm(
                        contentText:
                            "After canceling this cannot be changed you need to order again.",
                        onYes: () async {
                          await DbService().updateOrderStatus(
                              docId: widget.order.id,
                              data: {"status": "CANCELLED"});
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Order Updated")));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        onNo: () {
                          Navigator.pop(context);
                        }));
              },
              child: const Text("Cancel Order"))
        ],
      ),
    );
  }
}
