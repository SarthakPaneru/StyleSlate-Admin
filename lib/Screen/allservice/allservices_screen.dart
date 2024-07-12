import 'package:barberside/Screen/allservice/allservice_card.dart';
import 'package:barberside/Screen/allservice/allservice_model.dart';
import 'package:barberside/config/api_requests.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  late Future<List<Service>> futureService;
  final ApiRequests _apiRequests = ApiRequests();

  @override
  void initState() {
    super.initState();
    futureService = _apiRequests.fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff323345),
        appBar: AppBar(
          title: const Text(
            'Services',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff323345),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(
                  context); // This will navigate back to the previous screen
            },
          ),
        ),
        body: FutureBuilder<List<Service>>(
          future: futureService,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No services available'));
            } else {
              List<Service> services = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                    crossAxisSpacing: 8.0, // Spacing between columns
                    childAspectRatio: 3 / 2, // Aspect ratio of each card
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                        service: services[index]); // Use the custom card widget
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
