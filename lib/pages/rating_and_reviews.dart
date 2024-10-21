// ignore_for_file: library_private_types_in_public_api, unused_field, unnecessary_nullable_for_final_variable_declarations, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sumiconlineapp/components/appbar.dart';
import 'package:sumiconlineapp/components/elevated_button.dart';
import 'package:sumiconlineapp/components/sumic_button.dart';


class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '4.3',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '23 ratings',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStarRow(5, Colors.green, 12),
              _buildStarRow(4, Colors.green, 5),
              _buildStarRow(3, Colors.green, 4),
              _buildStarRow(2, Colors.green, 2),
              _buildStarRow(1, Colors.green, 0),
            ],
          ),
          const SizedBox(width: 16),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('12', style: TextStyle(fontSize: 12)),
              Text('5', style: TextStyle(fontSize: 12)),
              Text('4', style: TextStyle(fontSize: 12)),
              Text('2', style: TextStyle(fontSize: 12)),
              Text('0', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildStarRow(int stars, Color color, int barWidth) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              stars,
              (index) => const Icon(Icons.star, color: Colors.orange, size: 16),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 8,
          width: barWidth * 10.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

class RatingsAndReviews extends StatefulWidget {
  const RatingsAndReviews({super.key});

  @override
  _RatingsAndReviewsState createState() => _RatingsAndReviewsState();
}

class _RatingsAndReviewsState extends State<RatingsAndReviews> {
  bool isChecked = false; // Variable to track the checkbox state
  final TextEditingController _controller = TextEditingController();
  String _reviewMessage = ''; // Variable to store the message
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Rating & Reviews',
                style: TextStyle(
                  color: Color(0xFF013252),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              const Reviews(), // Integrated Reviews widget
              const SizedBox(height: 10),
              _buildReviewsHeader(),
              const SizedBox(height: 20),
              // First Review Card
              _buildReviewCard(
                reviewerName: 'John Doe',
                reviewTime: '5:20 pm',
                reviewText: 'Very nice, I will definitely buy again.',
                // reviewerPhotoUrl is no longer needed since we're using an icon
              ),
              const SizedBox(height: 20),
              // Second Review Card
              _buildReviewCard(
                reviewerName: 'Jane Smith',
                reviewTime: '4:15 pm',
                reviewText: 'Great product, fast shipping!',
                // Add more review cards as needed
              ),
              const SizedBox(height: 20),
              _buildWriteReviewButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsHeader() {
    return Row(
      children: [
        const Text(
          '8 Reviews',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(), // Space out the checkbox
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          activeColor: const Color(0xFF013252), // Color when checked
          checkColor: Colors.white, // Tick color
        ),
        const Text(
          'With photo',
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildWriteReviewButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SumicButton(text: 'Write Review', onTap: _showReviewModal),
    );
  }

  // Method to show the bottom modal for writing a review
  void _showReviewModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow for height adjustment
      builder: (context) {
        return Container(
          height: 640, // Set fixed height
          width: double.infinity, // Set width to take full screen
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0), // Optional rounded corners
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'What is Your Rate?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < 3
                        ? Colors.orange
                        : Colors.grey, // Example logic for colored stars
                    size: 30, // Set the size of the stars
                  );
                }),
              ),
              const SizedBox(height: 50),
              const Text(
                'Please Share Your Opinion',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true, // Fill the background
                  fillColor: Colors.white, // Set the background color to white
                  labelText: 'Write your review',
                  labelStyle:
                      const TextStyle(color: Colors.grey), // Label color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    borderSide: BorderSide.none, // Remove the border line
                  ),
                  contentPadding:
                      const EdgeInsets.all(16), // Padding inside the TextField
                ),
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF013252),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white, // Icon color
                        ),
                        onPressed: _showPhotoUploadDialog,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Add Your Photo'),
                  ),
                ],
              ),
              const Spacer(),
              CustomElevatedButton(text: 'SEND REVIEW', onTap: _sendMessage),
            ],
          ),
        );
      },
    );
  }

  // Method to show the photo upload dialog and select images
  void _showPhotoUploadDialog() async {
    final selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        // Store the selected images
        // You can implement the logic to display selected images
      });
    }
  }

  // Method to send the review and close the modal
  void _sendMessage() {
    setState(() {
      _reviewMessage = _controller.text; // Get the text from the TextField
      _controller.clear(); // Clear the TextField
      Navigator.pop(context); // Close the modal after sending the review
      // You can also implement logic to add the review to a list
    });
  }

  // Modified Method to build the review card with overlapping icon and repositioned "Helpful" button
  Widget _buildReviewCard({
    required String reviewerName,
    required String reviewTime,
    required String reviewText,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The main card
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4,
          margin: const EdgeInsets.only(left: 40.0), // Leave space for the icon
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 16.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reviewer name and time
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewerName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            reviewTime,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Star rating
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star_border),
                  ],
                ),
                const SizedBox(height: 16),
                // Review text
                Text(
                  reviewText,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                // Helpful button at the bottom right
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton.icon(
                    onPressed: () {
                      // Handle "Helpful" button press
                    },
                    icon: const Icon(Icons.thumb_up, color: Colors.blue),
                    label: const Text(
                      'Helpful',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned icon
        Positioned(
          top: -10, // Adjust this value to control the overlap
          left: 16, // Adjust this value to control the horizontal position
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF013252), // Background color for the icon
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white, // Border color
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person, // The icon you want to display
              color: Colors.white, // Icon color
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
