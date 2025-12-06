import 'package:flutter/material.dart';
import '../../add_contact/add_contact_page.dart';

class ContactsEmptyState extends StatelessWidget {
  const ContactsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Spacer(flex: 2),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: const Center(
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'No Contacts',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Contacts you’ve added will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder:
                  (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: const AddContactPage(),
                  ),
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text(
            'Create New Contact',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFF007AFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
