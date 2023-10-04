import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'components.dart' show MainButton, NavBar, NearbyPerson;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // PermissionStatus status = await Permission.location.status;

  // if (status.isGranted) {
  //   runApp(App());
  // } else {
  //   // Request location permission
  //   PermissionStatus permissionStatus = await Permission.location.request();
    runApp(App());
  // }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavBar(),
    );
  }
}

class SwapPage extends StatelessWidget {
  const SwapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CashSwap'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Wallet Balance',
            style: TextStyle(fontSize: 25)
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Text(
              '\$20.00',
              style: TextStyle(fontSize: 50)
            ),
          ),
          ElevatedButton(
            onPressed: () => print('Top Up'),
            child: Text('Top Up')
          ),
          SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton(label:'Request Cash'),
              SizedBox(width:40),
              MainButton(label:'Send Cash')
            ]),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: 0,
      //   onTap: (int index) => print(index),
      // )
    );
  }
}

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<StatefulWidget> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  bool validate = true;

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Request Cash'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              focusNode: focusNode,
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                errorText: validate ? null : 'Please enter amount of at least \$10'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height:30),
            ElevatedButton(
              onPressed: () {
                int? amount = int.tryParse(controller.text);
                if (amount != null && amount >= 10) {
                  FocusScope.of(context).unfocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindingPage())
                  );
                } else {
                  setState(() {
                    validate = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text('Request'),
            )
          ],
        ),
      ),
    );
  }
}

class FindingPage extends StatefulWidget {
  const FindingPage({super.key});

  @override
  State<StatefulWidget> createState() => _FindingPageState();
}

class _FindingPageState extends State<FindingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Finding Swappers...'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Finding a match...'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel')
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoundPage())
                );
              },
              child: Text('Found a match')
            ),
          ],
        ),
      )
    );
  }
}

class FoundPage extends StatefulWidget {
  const FoundPage({super.key});

  @override
  State<StatefulWidget> createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Found a swapper!'),
      ),
      body: Center(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Card(
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        SizedBox(width:10),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'https://www.bruegel.org/sites/default/files/styles/profile_picture/public/wp_images/-Tharman-Shanmugaratnam.jpg?h=1f3fdc12&itok=P6q8-Dz6'
                          )),
                        SizedBox(width:20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tharman Shanmugaratnam',
                              style: TextStyle(fontSize: 17)
                            ),
                            Text(
                              '20m away',
                            )
                          ],
                        )
                      ]
                    ),
                  )
                ),
                SizedBox(height:15),
                Card(
                  child: SizedBox(
                    height:100,
                    width:double.infinity,
                    child: Center(
                      child: Text(
                        'I am sitting in front of the zi char stall eating pineapple fried rice',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ),
                ),

                SizedBox(height:15),
                Card(
                  child:SizedBox(
                    height:100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:[
                        SizedBox(
                          width:70,
                          height:70,
                          child: ElevatedButton(
                            onPressed: () => print('Call'),
                            style: ElevatedButton.styleFrom(
                              shape:CircleBorder(),
                              backgroundColor: Colors.blue,
                            ),
                            child: Icon(Icons.call, size:40),
                          ),
                        ),
                        SizedBox(
                          width:70,
                          height:70,
                          child: ElevatedButton(
                            onPressed: () => print('Message'),
                            style: ElevatedButton.styleFrom(
                              shape:CircleBorder(),
                              backgroundColor: Colors.blue,
                            ),
                            child: Icon(Icons.message, size:40),
                          ),
                        ),
                        SizedBox(
                          width:70,
                          height:70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SendPage(nearbyPerson: NearbyPerson(name:'Tharman Shanmugaratnam', distance:'20m away', amount:'10.00')))
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape:CircleBorder(),
                              backgroundColor: Colors.blue,
                            ),
                            child: Icon(Icons.send, size:40),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
                Placeholder(),
              ],
            ),
          ),
        ),
      )
    );
  }
}

class SendPage extends StatefulWidget {
  final NearbyPerson nearbyPerson;

  const SendPage({
    Key? key,
    required this.nearbyPerson,
  }) : super(key: key);

  // const SendPage({super.key});

  @override
  State<StatefulWidget> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.nearbyPerson.name);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Cash'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Placeholder(),
    );
  }
}

class NearbyPage extends StatefulWidget {
  const NearbyPage({super.key});

  @override
  State<StatefulWidget> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  @override
  Widget build(BuildContext context) {
    var people = [
      {'name': 'John', 'distance': '20m away', 'amount': '10.00'},
      {'name': 'Mary', 'distance': '50m away', 'amount': '20.00'},
      {'name': 'Peter', 'distance': '100m away', 'amount': '30.00'},
      {'name': 'Jane', 'distance': '200m away', 'amount': '40.00'},
      {'name': 'Tom', 'distance': '500m away', 'amount': '50.00'},
      {'name': 'Jerry', 'distance': '1km away', 'amount': '60.00'},
      {'name': 'Bob', 'distance': '2km away', 'amount': '70.00'},
      {'name': 'Alice', 'distance': '5km away', 'amount': '80.00'},
      {'name': 'Eve', 'distance': '10km away', 'amount': '90.00'},
      {'name': 'Adam', 'distance': '20km away', 'amount': '100.00'},
    ];

    var nearbyPeople = <NearbyPerson>[];

    for (var person in people) {
      Map<String, dynamic> convertedPerson = {}; // Create a new map to store converted values
      for (var key in person.keys) {
        convertedPerson[key] = person[key].toString(); // Convert each value to String and store it in the new map
      }

      nearbyPeople.add(NearbyPerson(
        name: convertedPerson['name'],
        distance: convertedPerson['distance'],
        amount: convertedPerson['amount'],
      ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Nearby Swappers'),
      ),
      // body: Text('testing')
      body: Column(
        children: [
          Placeholder(),
          Expanded(
            child: ListView.builder(
              itemCount: nearbyPeople.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(nearbyPeople[index].amount),
                  subtitle: Text(nearbyPeople[index].distance),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SendPage(nearbyPerson:nearbyPeople[index]))
                    );
                  },
                );
              }
            )
          )
        ],
      )
    );
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('This is the wallet page');
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('This is the profile page');
  }
}
