import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Restaurant Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRestaurantSection(
              context,
              'Crust Bros Jahania',
              'assets/images/CrustBrosLogo.jpg',
              'Fast food restaurant with 4.36 Google reviews. Established in 2018, Crust Bros has become synonymous with quality pizza and innovative fast food in our community.',
              'Loha Bazar, Jahanian, Khanewal, Punjab 58200',
              '0325 8003399',
              'https://www.google.com/maps/place/Crust+Bros+Jahania/@30.0361955,71.8150381,15z/data=!4m2!3m1!1s0x0:0x542b1fe1f3c7d8b1',
            ),
            _buildRestaurantSection(
              context,
              'Eatway',
              'assets/images/eatwaylogo.jpg',
              'Fast food restaurant with 4.3 Google reviews. Features all-you-can-eat options, outdoor seating, and vegan dishes.',
              'Canal Rd, Rahmat villas phase 1 Jahanian, Khanewal, Punjab 58200',
              '0301 0800777\n0310 0800777',
              'https://www.google.com/maps/place/Eatway/@30.0260268,71.808359,15z/data=!4m2!3m1!1s0x0:0xdd761d8091bf4e87',
            ),
            _buildRestaurantSection(
              context,
              'Nawab Hotel Jahanian',
              'assets/images/nawablogo.jpg',
              'Pakistani, Chinese, BBQ and fast food restaurant. Offering dine-in and outdoor seating options.',
              'Main super highway Bahawal pur road Jahanian Punjab',
              '+92 306 9603197',
              'https://www.google.com/maps?q=nawab+hotel+jahanian',
            ),
            _buildRestaurantSection(
              context,
              'Pizza Slice',
              'assets/images/pizzaslice1.jpg',
              'Pizzas and sides with various options.',
              'Main Khanewall Highway Road Infront of Qudas Masjid Jahanian',
              '0308-4824792, 0311-4971155, 0303-4971155',
              'https://www.google.com/maps/place/Pizza+Slice/@30.0405525,71.8235627,17z/data=!3m1!4b1!4m6!3m5!1s0x393b5d2b18b3245f:0x4f36433f450dd7bf!8m2!3d30.0405525!4d71.8235627!16s%2Fg%2F11vbzr0bdj?entry=ttu&g_ep=EgoyMDI0MTIwOS4wIKXMDSoASAFQAw%3D%3D',
            ),
            _buildRestaurantSection(
              context,
              'Meet N Eat',
              'assets/images/meetneat.jpg',
              'Offers a variety of burgers, wraps, and pasta.',
              'Opposite Nadra Office, Multan Road, Jahanian',
              '0328-5500112, 0310-5083300',
              'https://www.google.com/maps?cid=14111823183446339961',
            ),
            _buildRestaurantSection(
              context,
              'Khana Khazana',
              'assets/images/khanakhazana1.jpg',
              'Specializes in traditional Pakistani and Indian cuisine.',
              'Main Super Highway Bahawal Pur Road Near Total Petrol Pump Jahanian',
              '0345-7277634, 0309-4152186',
              'https://www.google.com/maps?cid=9771144465258409027',
            ),
            _buildRestaurantSection(
              context,
              'Meera Jee',
              'assets/images/mfc.jpg',
              'Offers a variety of starters and main courses.',
              'Branch 1: Near Ice Factory Rahim Shah Road, Jahanian',
              '0309-7000178, 0306-7587938',
              'https://www.google.com/maps?cid=2102650666229093667',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantSection(
    BuildContext context,
    String name,
    String logoPath,
    String description,
    String address,
    String phone,
    String mapUrl,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              logoPath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoRow(
                  Icons.location_on,
                  address,
                  Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.phone,
                  phone,
                  Colors.green,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _launchUrl(mapUrl),
                    icon: const Icon(Icons.map),
                    label: const Text('View on Map'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
