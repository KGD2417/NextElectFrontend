import 'package:flutter/material.dart';
import 'package:next_elect/screens/auth/login_screen.dart';
import 'package:next_elect/screens/homepage.dart';
import 'package:next_elect/screens/profilescreen.dart';
import 'package:next_elect/screens/results_screen.dart';
import 'package:provider/provider.dart';
import 'package:next_elect/providers/auth_provider.dart';
import 'package:next_elect/providers/election_provider.dart';
import 'package:next_elect/screens/admin/create_election_screen.dart';
import 'package:next_elect/screens/election_detail_screen.dart';
import 'package:next_elect/widgets/election_card.dart';


import 'package:flutter/material.dart';
import 'package:next_elect/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:next_elect/providers/auth_provider.dart';
import 'package:next_elect/providers/election_provider.dart';
import 'package:next_elect/screens/admin/create_election_screen.dart';
import 'package:next_elect/screens/election_detail_screen.dart';
import 'package:next_elect/screens/results_screen.dart';
import 'package:next_elect/widgets/election_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track active tab index
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchElections();
  }

  Future<void> _fetchElections() async {
    final electionProvider = Provider.of<ElectionProvider>(context, listen: false);
    await electionProvider.fetchElections(); // Fetch only once
    setState(() {
      _isLoading = false; // Stop loading after fetching
    });
  }

  // List of screens for navigation
  final List<Widget> _screens = [
    HomePage(),  // Home Screen (List of Elections)
    ResultsScreen(),    // Results Page
    ProfileScreen(),    // User Profile Page
  ];

  // Update selected index when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Next Elect',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          if (authProvider.userRole == 'admin')
            IconButton(
              icon: const Icon(Icons.add,
              color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateElectionScreen()),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.white,),
            onPressed: () => authProvider.logout(),
          ),
        ],
      ),
      body: IndexedStack( // Maintains state when switching tabs
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Results"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
//
// class _HomeScreenState extends State<HomeScreen> {
//   final PageController _pageController = PageController();
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     _pageController.jumpToPage(index);
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Next Elect"), backgroundColor: Colors.blueAccent),
//
//       body: PageView(
//         controller: _pageController,
//         children: const [HomePage(), ResultsScreen(), ProfileScreen()],
//         onPageChanged: (index) => setState(() => _selectedIndex = index),
//       ),
//
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         backgroundColor: const Color(0xFFB5D1E7),
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.black54,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Results"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }





// class _HomeScreenState extends State<HomeScreen> {
//   bool _isLoading = true;  // Track loading state
//   int _selectedIndex = 0; // Track selected bottom navigation item
//
//   // List of Screens
//   final List<Widget> _screens = [
//     const HomePage(),       // Home Screen
//     const ResultsScreen(),  // Results Screen
//     const ProfileScreen(),  // Profile Screen
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchElections();
//   }
//
//
//   Future<void> _fetchElections() async {
//     final electionProvider = Provider.of<ElectionProvider>(context, listen: false);
//     await electionProvider.fetchElections();  // Fetch only once
//     setState(() {
//       _isLoading = false;  // Stop loading after fetching
//     });
//   }
//
//   // Function to handle bottom navigation taps
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final electionProvider = Provider.of<ElectionProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Next Elect',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.indigo,
//         elevation: 4,
//         actions: [
//           if (authProvider.userRole == 'admin')
//             IconButton(
//               icon: const Icon(Icons.add, color: Colors.white),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CreateElectionScreen()),
//                 );
//               },
//             ),
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white),
//             onPressed: () => authProvider.logout(),
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator()) // Show loader initially
//           : SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (electionProvider.elections.isEmpty)
//               const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text("No elections found"),
//                 ),
//               )
//             else
//               Column(
//                 children: electionProvider.elections.map((election) {
//                   return ElectionCard(
//                     election: election,
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ElectionDetailScreen(election: election),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             Container(
//               margin: EdgeInsets.fromLTRB(30,10,30,10),
//               child: const Text(
//                 "Guidelines to Vote",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Static text below the elections list
//             const SizedBox(height: 16),
//             const VotingStep(
//               step: 1,
//               title: "Login or Register",
//               description:
//               "To get started, log in or create an account by providing your details. Ensure your identity is verified with your Voter ID and Aadhaar ID for secure access.",
//             ),
//             const VotingStep(
//               step: 2,
//               title: "Access Voting Page",
//               description:
//               "Once logged in, click the 'Vote Now' button on the home page to be redirected to the voting page where you can cast your vote.",
//             ),
//             const VotingStep(
//               step: 3,
//               title: "Select Your Candidate",
//               description:
//               "On the voting page, choose your preferred candidate and click on the 'Submit Vote' button to register your vote.",
//             ),
//             const VotingStep(
//               step: 4,
//               title: "Confirmation of Vote",
//               description:
//               "After submitting your vote, you will be redirected to a confirmation page to review your submission.",
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         backgroundColor: Colors.indigo,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black54,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Results"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }



// class VotingPage extends StatelessWidget {
//   const VotingPage({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Good Morning,",
//                           style: TextStyle(fontSize: 16, color: Colors.grey),
//                         ),
//                         Text(
//                           "Kshitij Desai",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     CircleAvatar(
//                       radius: 24,
//                       backgroundImage: AssetImage("images/profile.png"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF343A72), Color(0xFF6A8DFF)],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "Cast your vote while voting is active",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             "15 hrs 40 min 02 sec",
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Text(
//                         "LEFT",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "\"Lok Sabha General Elections 2025\"",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         "Participate in the 2025 Lok Sabha Election and make your voice count. Vote for your preferred candidates securely and ensure your choice is part of the democratic process.",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         children: const [
//                           Icon(Icons.calendar_today, size: 20, color: Colors.grey),
//                           SizedBox(width: 8),
//                           Text(
//                             "15/01/2025",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: const [
//                           Icon(Icons.access_time, size: 20, color: Colors.grey),
//                           SizedBox(width: 8),
//                           Text(
//                             "9:00 AM to 6:00 PM",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       GradientButton(
//                         text: "VOTE NOW",
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   "Guidelines to Vote",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const VotingStep(
//                   step: 1,
//                   title: "Login or Register",
//                   description:
//                   "To get started, log in or create an account by providing your details. Ensure your identity is verified with your Voter ID and Aadhaar ID for secure access.",
//                 ),
//                 const VotingStep(
//                   step: 2,
//                   title: "Access Voting Page",
//                   description:
//                   "Once logged in, click the 'Vote Now' button on the home page to be redirected to the voting page where you can cast your vote.",
//                 ),
//                 const VotingStep(
//                   step: 3,
//                   title: "Select Your Candidate",
//                   description:
//                   "On the voting page, choose your preferred candidate and click on the 'Submit Vote' button to register your vote.",
//                 ),
//                 const VotingStep(
//                   step: 4,
//                   title: "Confirmation of Vote",
//                   description:
//                   "After submitting your vote, you will be redirected to a confirmation page to review your submission.",
//                 ),
//                 const SizedBox(height: 20), // Adding some padding before the nav bar
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0,
//         backgroundColor: Color(0xFFB5D1E7),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Result"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF343A72), Color(0xFF6A8DFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class VotingStep extends StatelessWidget {
  final int step;
  final String title;
  final String description;

  const VotingStep({Key? key, required this.step, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30,10,30,10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.indigo,
              child: Text(
                "$step",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}