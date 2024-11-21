import 'package:diktionary/screen/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchView extends GetView<SearchViewController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.shade200,
              ),
              child: TextField(
                controller: controller.wordController,
                onSubmitted: (value) =>
                    controller.fetchUrbanDictionaryDefinition(value),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Search..'),
              ),
            ),
            // In your view
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator(); // Show loading spinner
              } else if (controller.txtdata.isEmpty) {
                return const Text("No data available");
              } else {
                // Safely extract the list and calculate the length
                List<dynamic> definitions = controller.txtdata['list'] ?? [];
                int dataLength = definitions.length;

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Number of definitions found: $dataLength"), // Display the length
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: dataLength,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.wordController.text,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                  ),
                                  controller.formatText(
                                    definitions[index]['definition'] ??
                                        "No definition available",
                                    (text) {
                                      // Update TextField with clicked text
                                      controller.wordController.text = text;
                                    },
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Example',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red),
                                    ),
                                    controller.formatText(
                                      definitions[index]['example'] ??
                                          "No example available",
                                      (text) {
                                        // Update TextField with clicked text
                                        controller.wordController.text = text;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: [
                                          const TextSpan(text: 'By '),
                                          TextSpan(
                                              text: definitions[index]
                                                  ['author'],
                                              style: const TextStyle(
                                                color: Colors.blue,
                                              )),
                                          TextSpan(
                                            text:
                                                " ${DateFormat("MMMM dd, yyyy").format(
                                              DateTime.parse(definitions[index]
                                                  ['written_on']),
                                            )}",
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.thumb_up),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              definitions[index]['thumbs_up']
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.thumb_down),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              definitions[index]['thumbs_down']
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
