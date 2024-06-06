import 'package:delivery_frontend/services/network_service.dart';
import 'package:delivery_frontend/utils/popup_utils.dart';
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  final NetworkService networkService = NetworkService();
  OrderCard({required this.order});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.order.rating;
  }

  Future<void> _updateRating(int rating) async {
    if (widget.order.rating != 0) {
      return;
    }
    print("selamun: ${widget.order.o_id}, ${rating}");
    final response =
        await widget.networkService.rateOrderByOid(widget.order.o_id, rating);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _currentRating = rating;
        widget.order.rating = rating; // Update the rating in the order model
      });
    } else {
      showErrorPopup(context, "Network error");
    }
  }

  void _showBasket(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Basket Items',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.order.basket.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.order.basket.items[index];
                    return ListTile(
                      leading: Image.asset(item.product.image,
                          width: 50, height: 50),
                      title: Text(item.product.name,
                          style: TextStyle(fontSize: 16)),
                      subtitle: Text('Count: ${item.count}',
                          style: TextStyle(fontSize: 16)),
                      trailing: Text(
                          '\$${(item.product.price * item.count).toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'Total: \$${widget.order.paidPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBasket(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${widget.order.date}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Status: ${widget.order.status}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Order Method: ${widget.order.orderMethod}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              if (widget.order.voucher != null)
                Text(
                  'Voucher: ${widget.order.voucher}',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 8),
              Text(
                'Total Price: \$${widget.order.paidPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              _buildRatingStars(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _currentRating ? Icons.star : Icons.star_border,
            color: index < _currentRating ? Colors.amber : Colors.grey,
          ),
          onPressed: () => _updateRating(index + 1),
        );
      }),
    );
  }
}
