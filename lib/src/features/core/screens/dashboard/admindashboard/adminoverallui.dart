import 'package:flutter/material.dart';

class Adminoverallui extends StatelessWidget {
  const Adminoverallui({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        automaticallyImplyLeading: width < 800,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.black),
        ),
      ),

      /// 🔥 SAFE SCROLL (VERTICAL ONLY)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: width < 800 ? _mobileLayout() : _desktopLayout(),
      ),
    );
  }

  /// 📱 MOBILE (STACKED)
  Widget _mobileLayout() {
    return Column(
      children: [
        _statCard("Students", "120", Icons.people),
        const SizedBox(height: 10),
        _statCard("Active", "35", Icons.online_prediction),
        const SizedBox(height: 10),
        _statCard("Completion", "78%", Icons.check_circle),

        const SizedBox(height: 15),

        _progressPanel(),

        const SizedBox(height: 15),

        _rightPanel(),
      ],
    );
  }

  /// 💻 DESKTOP (NO OVERFLOW - FLEX BASED)
  Widget _desktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔵 LEFT CONTENT
        Expanded(
          flex: 65,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _statCard("Students", "120", Icons.people)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard("Active", "35", Icons.online_prediction),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard("Completion", "78%", Icons.check_circle),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _progressPanel(),
                const SizedBox(height: 20),
                _progressPanel(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        /// 🟡 RIGHT PANEL
        Expanded(
          flex: 35,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: _rightPanel(),
          ),
        ),
      ],
    );
  }

  /// 🔹 STAT CARD
  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: _cardStyle(),
      child: Row(
        children: [
          Icon(icon, size: 26, color: Colors.blue),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 PROGRESS PANEL
  Widget _progressPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: _cardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Progress Overview",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _progressBar("Simulation 1", 0.7),
          _progressBar("Simulation 2", 0.5),
          _progressBar("Simulation 3", 0.9),
        ],
      ),
    );
  }

  /// 🔹 RIGHT PANEL
  Widget _rightPanel() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: _cardStyle(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("• Juan completed Simulation 3"),
              Text("• Maria scored 95%"),
              Text("• New student registered"),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: _cardStyle(color: Colors.redAccent),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Alerts",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text("• 5 students below 60%"),
              Text("• Low activity detected"),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 PROGRESS BAR
  Widget _progressBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: value),
        ],
      ),
    );
  }

  /// 🔹 CARD STYLE
  BoxDecoration _cardStyle({Color color = Colors.white}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
    );
  }
}
