import 'package:flutter/material.dart';
import 'package:machine_test_firebase/model/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDescriptionWidget extends StatelessWidget {
  final ProductModel data;

  const ProductDescriptionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Text(
            data.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ),

        // Product Rating and Review Count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Row(
            children: [
              // Star Rating
              RatingBarIndicator(
                rating: data.rating.rate,
                unratedColor: Colors.white,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              const SizedBox(width: 10),
              // Review Count
              Text(
                "(${data.rating.count} reviews)",
                style: const TextStyle(fontSize: 14.0, color:  Colors.white),
              ),
            ],
          ),
        ),

        // Product Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          child: Text(
            data.description,
            style: const TextStyle(fontSize: 15,color: Colors.white),
          ),
        ),

        const SizedBox(height: 10),

        // Product Color
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Color: BLACK',
            style: const TextStyle(fontSize: 15,color: Colors.white,),
          ),
        ),

        // Product Price
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Price: \$${data.price.toString()}",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
          ),
        ),

        const SizedBox(height: 20.0),

        // Dummy Reviews Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: const Text(
            "Customer Reviews",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),

        const SizedBox(height: 10.0),

        // Dummy Review 1
        _buildReview(
          username: "John Doe",
          rating: 4.5,
          review:
          "Great product! The quality is amazing, and it arrived on time. Highly recommend.",
        ),

        // Dummy Review 2
        _buildReview(
          username: "Alice Smith",
          rating: 5.0,
          review: "Absolutely love this! Worth every penny.",
        ),

        // Dummy Review 3
        _buildReview(
          username: "Michael Brown",
          rating: 3.5,
          review: "Decent product, but the delivery took longer than expected.",
        ),

        const SizedBox(height: 30.0),
      ],
    );
  }

  Widget _buildReview({required String username, required double rating, required String review}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle, size: 30, color: Colors.grey),
              const SizedBox(width: 10),
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white,),
              ),
            ],
          ),
          const SizedBox(height: 5),
          RatingBarIndicator(
            rating: rating,
            unratedColor: Colors.white,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 18.0,
            direction: Axis.horizontal,
          ),
          const SizedBox(height: 5),
          Text(
            review,
            style: const TextStyle(fontSize: 14, color: Colors.white,),
          ),
          const Divider(thickness: 1, height: 20),
        ],
      ),
    );
  }
}
