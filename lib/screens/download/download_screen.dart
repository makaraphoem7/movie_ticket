import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/downloading.dart';
import '../../widgets/downloaded.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 50), // Space for status bar
          // Title "Download"
          const Text(
            "Download",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10), // Spacing below title
          // TabBar
          Container(
            color: Colors.black,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.red,
              tabs: const [
                Tab(text: "Downloaded"),
                Tab(text: "Downloading"),
              ],
            ),
          ),
          // TabBarView Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Downloaded(),
                Downloading(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
