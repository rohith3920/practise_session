import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:smart_home_animation/api/local_auth_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? currentIndex = 0;
  var items = [
    'T - Shirts',
    'Crop tops',
    'Blouses',
    'Shoes',
    'Watches',
    'Shirts',
    'Mobiles',
    'SweatShirt',
    'Shorts',
    'Hoddies',
    'T - Shirts',
    'Crop tops',
    'Blouses',
    'Shoes',
    'Watches',
    'Shirts',
    'Mobiles',
    'SweatShirt',
    'Shorts',
    'Hoddies',
  ];
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isBiometricAvailable = false;
  bool _isAuthenticated = false;
  String? _errorMessage;
  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    setState(() {
      _isBiometricAvailable = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ), // Set to false if you want to allow fallback options
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
    setState(() {
      _isAuthenticated = isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HeaderWidget(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                if (_isBiometricAvailable) {
                  _authenticate();
                } else {
                  setState(() {
                    _errorMessage = 'Biometrics not available on the device';
                  });
                }
              },
              child: const Text('Biometric'),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex!,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            elevation: 80,
            selectedLabelStyle: TextStyle(color: Colors.red),
            unselectedLabelStyle: TextStyle(color: Colors.green),
            backgroundColor: Colors.white,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                    )
                  ],
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shop_two,
                    )
                  ],
                ),
                label: "Shop",
              ),
              BottomNavigationBarItem(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.backpack,
                    )
                  ],
                ),
                label: "Bag",
              ),
              BottomNavigationBarItem(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                    )
                  ],
                ),
                label: "Favourites",
              ),
              BottomNavigationBarItem(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_off_outlined,
                    )
                  ],
                ),
                label: "Profile",
              ),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index ?? 0;
              });
            },
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatefulWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(150.0);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  var items = [
    'T - Shirts',
    'Crop tops',
    'Blouses',
    'Shoes',
    'Watches',
    'Shirts',
    'Mobiles',
    'SweatShirt',
    'Shorts',
    'Hoddies'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              Center(
                  child: Text(
                'Womens tops',
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
              Icon(
                Icons.search,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 40, // Adjust the height as needed

            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < items.length; i++)
                  Container(
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                            20)), // Adjust the width as needed
                    margin: const EdgeInsets.symmetric(horizontal: 2),

                    child: Center(
                      child: Text(
                        items[i],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                  Text('Filters'),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    color: Colors.black,
                  ),
                  Text(
                    'Price : lowest to high',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
