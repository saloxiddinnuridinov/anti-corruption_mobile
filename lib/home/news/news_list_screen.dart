import 'package:flutter/material.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Demo ma'lumotlar
    final categories = ['Barchasi', 'Ijtimoiy', 'Siyosiy', 'Sport', 'Texnologiya'];
    final newsList = List.generate(
      5,
          (index) => {
        'title': 'Yangilik sarlavhasi $index',
        'description': 'Bu yangilikning qisqacha tavsifi $index.',
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Yangiliklar')),
      body: Column(
        children: [
          // Kategoriyalar
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Chip(
                    label: Text(categories[index]),
                    backgroundColor: Colors.blue.shade100,
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // Yangiliklar ro'yxati
          Expanded(
            child: ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(news['title']!),
                    subtitle: Text(news['description']!),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Harakatlar
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'read',
                          child: Text('O‘qish'),
                        ),
                        const PopupMenuItem(
                          value: 'challenge',
                          child: Text('Challengga qatnashish'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Davlat harajatlari (birja narxlari)
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Davlat harajatlari', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('• Neft: \$85.00'),
                Text('• Gaz: \$3.20'),
                Text('• Bug‘doy: \$280.00'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
