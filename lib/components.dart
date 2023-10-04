import 'package:flutter/material.dart';
import 'main.dart' show SwapPage, WalletPage, ProfilePage, RequestPage, SendPage, NearbyPage;

class MainButton extends StatelessWidget {
  final String label;
  
  const MainButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 120,
        height: 100,
        child: ElevatedButton(
            onPressed: () => {
              if (label == 'Request Cash') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestPage()),
                )
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NearbyPage()),
                )
              }
            },
            child: Text(
              label,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,)
        ),
      ),
    );
  }
}

class NearbyPerson {
  final String name;
  final String distance;
  final String amount;

  NearbyPerson({
    required this.name,
    required this.distance,
    required this.amount,
  });
}

// class NearbyButton extends StatelessWidget {
//   final String name;
//   final String distance;
//   final String amount;

//   const NearbyButton({
//     super.key,
//     required this.name,
//     required this.distance,
//     required this.amount,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: SizedBox(
//         height: 100,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(name, style: TextStyle(fontSize: 20)),
//             Text(distance, style: TextStyle(fontSize: 20)),
//             Text('\$$amount', style: TextStyle(fontSize: 20))
//           ]
//         )
//       ),
//       onPressed: () => {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SendPage()),
//         )
//       },
//     );
//   }
// }

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  final List<Widget> pages = <Widget>[
    const SwapPage(),
    const WalletPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.swap_horiz_outlined),
            icon: Icon(Icons.swap_horiz),
            label: 'Swap',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.wallet_outlined),
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_outline),
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    body: pages[currentPageIndex],
    );
  }
}