import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final Map<String, String> resto = {
    "Nama": "Rumah Makan Sedap Rasa",
    "Email": "sedaprasa@example.com",
    "Kontak": "(024) 3517261",
    "Alamat": "Jl. Imam Bonjol No.207, Pendrikan Kidul, Kec. Semarang Tengah, Kota Semarang, Jawa Tengah 50131",
    "Deskripsi":
    "Rumah Makan Sedap Rasa adalah tempat yang menyajikan masakan khas Indonesia dengan cita rasa autentik dan bahan-bahan berkualitas.",
    "Jam Buka": "10:00 - 22:00 WIB",
    "Image": "assets/image.jpg",
  };

  final List<String> menu = [
    "Nasi Goreng",
    "Sate Ayam",
    "Soto Ayam",
    "Mie Goreng",
    "Gado-Gado",
    "Es Teh Manis",
  ];

  MainApp({super.key});

  void _launchEmail() async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: resto["Email"],
      query: 'subject=Tanya Seputar Resto',
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Tidak dapat membuka email client.';
    }
  }

  void _launchPhone() async {
    final phoneUri = Uri(
      scheme: 'tel',
      path: resto["Kontak"],
    );
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Tidak dapat membuka aplikasi telepon.';
    }
  }

  void _launchMap() async {
    final mapUri = Uri(
      scheme: 'geo',
      path: '-6.982859, 110.409089', // Latitude and Longitude if needed
      queryParameters: {
        'q': resto["Alamat"],
      },
    );
    if (await canLaunch(mapUri.toString())) {
      await launch(mapUri.toString());
    } else {
      throw 'Tidak dapat membuka aplikasi peta.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplikasi Resto",
      home: Scaffold(
        appBar: AppBar(title: const Text("Aplikasi Resto")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                resto["Nama"]!,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Gambar
              Image.asset(
                resto["Image"]!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),

              // Ikon Email, Telepon, Map
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _launchEmail,
                    child: Column(
                      children: const [
                        Icon(Icons.email, color: Colors.blue, size: 30),
                        SizedBox(height: 5),
                        Text("Email"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _launchPhone,
                    child: Column(
                      children: const [
                        Icon(Icons.phone, color: Colors.green, size: 30),
                        SizedBox(height: 5),
                        Text("Telepon"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _launchMap,
                    child: Column(
                      children: const [
                        Icon(Icons.map, color: Colors.red, size: 30),
                        SizedBox(height: 5),
                        Text("Map"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Deskripsi
              Text(
                resto["Deskripsi"]!,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // List Menu
              const Text(
                "Menu:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true, // To prevent the list from taking up infinite space
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.restaurant_menu),
                    title: Text(menu[index]),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Alamat
              const Text(
                "Alamat:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 5),
                  Text(
                    resto["Alamat"]!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Jam Buka
              const Text(
                "Jam Buka:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                resto["Jam Buka"]!,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
