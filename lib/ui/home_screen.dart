import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEBFA), // latar abu-abu muda
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/images/logo.png',
            width: 130,
            height: 130
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // ubah ke start, biar teks kiri
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 40,
              left: 30
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/profile-pict.png"),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hai, Ney!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your QR Code Buddy",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30), // jarak antara profile dan teks "Welcome"
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // buat teks tetep di tengah-tengah
              children: [
                Text(
                  "Welcome to",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                Text(
                  "QRode",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40), // jarak antara teks "Welcome" dan tombol
          // Button Cards Section (Center)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // First row of buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(
                      icon: Icons.qr_code,
                      label: "CREATE",
                      iconColor: const Color(0xFF754E9D),
                      backgroundColor: const Color(0xFFE1E0F4),
                      onTap: () {
                        Navigator.pushNamed(context, "/generator");
                      },
                    ),
                    _buildButton(
                      icon: Icons.qr_code_scanner,
                      label: "SCAN",
                      iconColor: const Color(0xFFFC8939),
                      backgroundColor: const Color(0xFFF6E4CB),
                      onTap: () {
                        Navigator.pushNamed(context, "/scan");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20), // space between rows
                // Second row of buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(
                      icon: Icons.send,
                      label: "SEND",
                      iconColor: const Color(0xFFFCD968),
                      backgroundColor: const Color(0xFFFCEDBC),
                      onTap: () {},
                    ),
                    _buildButton(
                      icon: Icons.print,
                      label: "PRINT",
                      iconColor: const Color(0xFF17861E),
                      backgroundColor: const Color(0xFFD6EFC8),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150, // Lebar tetap untuk setiap tombol
        height: 150, // Tinggi tetap untuk setiap tombol
        decoration: BoxDecoration(
          color: Colors.white, // Latar tombol abu-abu terang
          borderRadius: BorderRadius.circular(20), // Sudut membulat
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Bayangan lembut
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor, // Warna latar ikon
                borderRadius: BorderRadius.circular(12), // Sudut membulat ikon
              ),
              padding: const EdgeInsets.all(15),
              child: Icon(
                icon,
                color: iconColor, // Warna ikon
                size: 30, // Ukuran ikon lebih besar
              ),
            ),
            const SizedBox(height: 15), // Jarak antara ikon dan teks
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16, // Ukuran teks
              ),
            ),
          ],
        ),
      ),
    );
  }
}
