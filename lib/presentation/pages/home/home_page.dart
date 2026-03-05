import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              _buildHomeContent(context), // 0: Home
              _buildPlaceholderScreen('My Trips',
                  Icons.confirmation_number_outlined), // 1: My Trips
              const SizedBox.shrink(), // 2: Placeholder for FAB (Center)
              _buildPlaceholderScreen(
                  'Wishlist', Icons.favorite_border), // 3: Wishlist
              _buildPlaceholderScreen(
                  'Account', Icons.person_outline), // 4: Account
            ],
          )),
      floatingActionButton: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00B4DB),
              Color(0xFF6A1B9A),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6A1B9A).withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            controller.changePage(2);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          child: const Icon(
            Icons.auto_awesome_mosaic_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 60,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNavItem(
                        icon: Icons.home_filled,
                        label: 'Home',
                        index: 0,
                        isSelected: controller.currentIndex.value == 0,
                      ),
                      _buildNavItem(
                        icon: Icons.confirmation_number_outlined,
                        label: 'My Trips',
                        index: 1,
                        isSelected: controller.currentIndex.value == 1,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNavItem(
                        icon: Icons.favorite_border,
                        label: 'Wishlist',
                        index: 3,
                        isSelected: controller.currentIndex.value == 3,
                      ),
                      _buildNavItem(
                        icon: Icons.person_outline,
                        label: 'Account',
                        index: 4,
                        isSelected: controller.currentIndex.value == 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon,
      required String label,
      required int index,
      required bool isSelected}) {
    final color = isSelected ? const Color(0xFF5C65D6) : Colors.grey.shade600;
    return MaterialButton(
      minWidth: 40,
      onPressed: () => controller.changePage(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderScreen(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 24, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(context),
          const SizedBox(height: 16),
          _buildRecentSearch(),
          const SizedBox(height: 32),
          _buildHotTrending(),
          const SizedBox(height: 32),
          _buildLifeExperience(),
          const SizedBox(height: 32),
          _buildFlashDeals(),
          const SizedBox(height: 24),
          _buildVisaBanner(),
          const SizedBox(height: 24),
          _buildBanners(),
          const SizedBox(height: 120), // padding for bottom nav
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Blue Gradient Background
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF00B4DB), // Cyan
                Color(0xFF6200EE), // Royal Blue
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 40,
              left: 16,
              right: 16,
              bottom: 8),
          child: _buildSearchCard(),
        ),
      ],
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryIcon("assets/images/Hotel.png", 'Hotels',
                  isSelected: true),
              _buildCategoryIcon(
                'assets/images/Transport Gradient_Plane 1.png',
                'Flights',
              ),
              _buildCategoryIcon(
                'assets/images/Tourism Gradient_Map.png',
                'Life\nExperience®',
              ),
              _buildCategoryIcon(
                'assets/images/Travel & Tourism Gradient_Taxi-10.png',
                'Cars',
              ),
              _buildCategoryIcon(
                'assets/images/Transport Gradient_Yatch.png',
                'Cruises',
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Inputs
          _buildInputField(Icons.location_on_outlined, 'Destination',
              'Dubai, United Arab Emirates'),
          const SizedBox(height: 12),
          _buildInputField(
              Icons.calendar_today_outlined, 'Date', '1 July - 3 July'),
          const SizedBox(height: 12),
          _buildInputField(
              Icons.person_outline, 'Travelers', '2 Travelers - 1 room'),
          const SizedBox(height: 24),
          // Search Button
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF00B4DB), Color(0xFF6200EE)],
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text('Search',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(String icon, String label,
      {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.red.withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: Colors.red.shade200, width: 1.5)
                : Border.all(color: Colors.transparent),
          ),
          child: Image.asset(
            icon,
            height: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(IconData icon, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFFE2E8F0), width: 1.5), // Light grey border
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Color(0xFF1E293B), // Dark slate bold text
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: Icon(icon,
                color: const Color(0xFF475569), size: 22), // Slate icon
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
          labelText: title,
          labelStyle: const TextStyle(
            color: Color(0xFF64748B), // Slate muted label
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  Widget _buildRecentSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Recent Search',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 122,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildRecentCard('HOTELS', 'Dubai', '12 Aug - 25 Aug',
                  '1 Room • 2 travellers'),
              _buildRecentCard('FLIGHTS', 'Dubai.. to Delhi (DEL)',
                  '12 Aug - 25 Aug', '2 travellers'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCard(
      String type, String title, String dates, String details) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type,
              style: const TextStyle(
                  color: Color(0xFF5C65D6),
                  fontSize: 11,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text(dates,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          const SizedBox(height: 4),
          Text(details,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFlashDeals() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color(0xFF8C9DF9).withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Center(
                    child: Text('Explore more',
                        style: TextStyle(
                            color: Color(0xFF5C65D6),
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF1B1B1B),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1542314831-c6a4d140e628?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Flash Deals',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                      SizedBox(height: 4),
                      Text(
                          'Every day, we bring you 3 world-class\nunbeatable hotel offers!',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 320,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.only(left: 20, right: 8, bottom: 20),
                    children: [
                      _buildFlashDealCard(
                          'Millennium Plaza Downtown Hotel, Dubai',
                          'Dubai, United Arab Emirates',
                          4.5),
                      _buildFlashDealCard(
                          'Millennium Plaza Downtown Hotel, Dubai',
                          'Dubai, United Arab Emirates',
                          4.5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashDealCard(String title, String location, double rating) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
              height: 138,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF5C65D6).withOpacity(0.8),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('Deals from 07/09/2025 to 07/31/2025',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text(location,
              style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 12),
              const SizedBox(width: 4),
              Text(rating.toString(),
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B4DB),
              minimumSize: const Size(100, 32),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            onPressed: () {},
            child: const Text('Book now!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildBanners() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Image.asset(
        "assets/images/Frame 1116606616.png",
        width: double.infinity,
      ),
    );
  }

  Widget _buildVisaBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6FB), // Light bluish background
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Visa Graphic Mockup
            SizedBox(
              width: 56,
              height: 48,
              child: Stack(
                children: [
                  Positioned(
                    left: 6,
                    top: 10,
                    child: Transform.rotate(
                      angle: 0.15,
                      child: Container(
                        height: 34,
                        width: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24), // amber/orange card
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 2,
                    child: Transform.rotate(
                      angle: -0.1,
                      child: Container(
                        height: 36,
                        width: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E90FF), // blue card
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: [
                            Container(
                                height: 8,
                                margin: const EdgeInsets.only(top: 6),
                                color: const Color(0xFF4169E1)
                                    .withOpacity(0.5)), // card strip
                            const Expanded(
                              child: Center(
                                child: Icon(Icons.airplanemode_active,
                                    color: Colors.white, size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 2,
                    bottom: -2,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.gpp_good,
                          color: Color(0xFF10B981), size: 24), // green shield
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Apply for your\nTravel visa today',
                style: TextStyle(
                  color: Color(0xFF111827), // Dark text
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5), // Indigo button
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Get Started',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLifeExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Life Experience®',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('Discover the magic of a Life Experience.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 360,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildLifeExpCard(
                  'Mediterranean Cruise Experience',
                  'Starts 2nd Nov 2025',
                  '8 Days 7 Nights',
                  '\$699',
                  'https://images.unsplash.com/photo-1599640842225-85d111c60e6b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
              _buildLifeExpCard(
                  'Mediterranean Cruise Experience',
                  'Starts 2nd Nov 2025',
                  '8 Days 7 Nights',
                  '\$699',
                  'https://images.unsplash.com/photo-1599640842225-85d111c60e6b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLifeExpCard(String title, String date, String duration,
      String price, String imageUrl) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl,
                height: 180, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 15),
                    maxLines: 2),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        color: Colors.amber, size: 16),
                    const SizedBox(width: 8),
                    Text(date,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade700)),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(duration,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                ),
                const SizedBox(height: 16),
                Text(price,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: Color(0xFF0B1120))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotTrending() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hot & Trending',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('We bring exclusive offers for The Club members, daily.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFF5C65D6), width: 2)),
                ),
                child: const Text('The Club Select',
                    style: TextStyle(
                        color: Color(0xFF5C65D6),
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
              const SizedBox(width: 24),
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('The Club Hotel',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 310,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildHotTrendingCard('Bali Seascape Beach Club-Rental',
                  'Candidasa, Indonesia', 4.5),
              _buildHotTrendingCard('Bali Seascape Beach Club-Rental',
                  'Candidasa, Indonesia', 4.5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHotTrendingCard(String title, String location, double rating) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              'https://images.unsplash.com/photo-1537996194471-e657df975ab4?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF0FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('Use Maximum Loyalty Points',
                      style: TextStyle(
                          color: Color(0xFF5C65D6),
                          fontSize: 9,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(location,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12)),
                    // Small golden loyalty icon mock
                    Image.asset('assets/images/Loyalty Points stacked.png'),
                    // Container(
                    //     height: 32,
                    //     width: 32,
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.purple.shade900),
                    //     child: const Icon(Icons.monetization_on,
                    //         color: Colors.amber, size: 16)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    const SizedBox(width: 4),
                    Text(rating.toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
