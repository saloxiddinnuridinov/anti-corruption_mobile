import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foydalanuvchi ma'lumotlari
            _buildProfileSection(
              title: "Shaxsiy ma'lumotlar",
              children: [
                _buildInfoRow(Icons.person, "Ism Familiya", "Azizbek Nuriddinov"),
                _buildInfoRow(Icons.phone, "Telefon raqam", "+998 90 123 45 67"),
                _buildInfoRow(Icons.email, "Email", "azizbek@example.com"),
              ],
            ),

            const SizedBox(height: 30),

            // Aloqa markazi ma'lumotlari
            _buildProfileSection(
              title: "Korrupsiyaga qarshi call-markaz",
              children: [
                _buildInfoRow(Icons.location_on, "Manzil", "Toshkent shahar, Yunusobod tumani"),
                _buildInfoRow(Icons.phone, "Telefon", "+998 71 200 00 01"),
                _buildInfoRow(Icons.access_time, "Ish vaqti", "Dushanba-Juma 09:00-18:00"),
                _buildInfoRow(Icons.language, "Veb-sayt", "www.anticorruption.uz",
                    onTap: () => _launchUrl(AppConstants.websiteUrl)),
              ],
            ),

            const SizedBox(height: 30),

            // Qo'ng'iroq qilish tugmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _launchUrl('tel:${AppConstants.contactPhone}'),
                icon: const Icon(Icons.call),
                label: const Text("Call-markazga qo'ng'iroq qilish"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null) const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}