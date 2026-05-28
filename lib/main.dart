import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum PAB 2026',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00ADB5),
          primary: const Color(0xFF00ADB5),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    TokoKesehatanScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: const Color.fromARGB(255, 243, 243, 243),
          unselectedItemColor: const Color(0xFF9E9E9E),
          backgroundColor: const Color.fromARGB(255, 1, 0, 29),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: 'Toko Kesehatan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildSectionTitle('Layanan Utama'),
              _buildLayananUtama(context),


              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

Widget _buildLayananUtama(BuildContext context) {
  final List<Map<String, dynamic>> layanan = [
    {'icon': Icons.medical_services_rounded, 'label': 'Dokter Umum', 'color': const Color(0xFF00ADB5)},
    {'icon': Icons.medical_information_rounded, 'label': 'Dokter Gigi', 'color': const Color(0xFF00ADB5)},
    {'icon': Icons.child_care_rounded, 'label': 'Dokter Anak', 'color': const Color(0xFF48CAE4)},
    {'icon': Icons.pets_rounded, 'label': 'Dokter Hewan', 'color': const Color(0xFF00ADB5)},
  ];

  return Column(
    children: layanan.map((item) {
      final color = item['color'] as Color;
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DokterDetailScreen(
                  namaDokter: item['label'] as String,
                  icon: item['icon'] as IconData,
                  color: color,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  item['label'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

}
class DokterDetailScreen extends StatelessWidget {
  final String namaDokter;
  final IconData icon;
  final Color color;

  const DokterDetailScreen({
    super.key,
    required this.namaDokter,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namaDokter),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            Text("Profile Dokter", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("dr. Muhammad Rizky", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            Text(namaDokter, style: const TextStyle(fontSize: 14)),

            const SizedBox(height: 16),
            Text("Jadwal Praktik", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const Text("Senin - Jumat, 08:00 - 16:00"),

            const SizedBox(height: 16),
            Text("Biografi Singkat", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const Text("Dokter berpengalaman lebih dari 10 tahun di bidangnya."),

            const SizedBox(height: 16),
            Text("Rating", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const Text("⭐ 4.8 / 5"),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  disabledBackgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Buat Janji Temu", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TokoKesehatanScreen extends StatelessWidget {
  const TokoKesehatanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PRAKTIKUM PAB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF00ADB5),
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 28),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 240,  
                  height: 360, 
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7FA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF00ADB5).withOpacity(0.3), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00ADB5),
                        ),
                        child: const Icon(Icons.school_rounded, color: Colors.white, size: 54),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Pemrograman\nAplikasi Bergerak',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0077B6),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 100,
                        height: 2,
                        color: const Color(0xFF00ADB5),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '1462300237',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF00ADB5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              const _CornerFrame(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color.fromARGB(255, 254, 255, 255), Color.fromARGB(255, 255, 255, 255)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 25, 25, 26).withOpacity(0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.account_circle, color: Colors.blue),
                        ),
                      ),
                    const SizedBox(height: 24),


                    Expanded(
                      child: ListView(
                        children: const [
                          ListTile(
                            leading: Icon(Icons.person, color: Colors.blue),
                            title: Text(
                              'MUHAMMAD RIZKY H',
                              style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            ),
                            shape: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                            )
                          ),
                          ListTile(
                            leading: Icon(Icons.numbers, color: Colors.blue),
                            title: Text(
                              '1462300237',
                              style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            ),
                            shape: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                            )
                          ),
                          ListTile(
                            leading: Icon(Icons.school, color: Colors.blue),
                            title: Text(
                              'rizkyharianto02@gmail.com',
                              style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            ),
                            shape: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                            )
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on, color: Colors.blue),
                            title: Text(
                              'GRESIK',
                              style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            ),
                            shape: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                            )
                          ),
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.instagram, color: Colors.blue),
                            title: Text(
                              '@risixky',
                              style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            ),
                            shape: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1.0),
                            )
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _CornerFrame extends StatelessWidget {
  const _CornerFrame();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
    );
  }
}
