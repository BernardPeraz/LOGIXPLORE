import 'package:flutter/material.dart';
import 'package:studydesign2zzdatabaseplaylist/Profilemenu/Image.dart';

class DesktopProfile extends StatelessWidget {
  const DesktopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF4A609C).withValues(alpha: 0.66),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // AVATAR ICON
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // FIRST TEXT
                const Text(
                  'Not connected yet',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // SECOND TEXT
                Text(
                  'Not connected yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // FIRST ELEVATED BUTTON
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      changeProfilePicture(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: Text(
                      'Change Picture',

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // RIGHT SIDE - TEXT FIELDS
        Expanded(
          flex: 1,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF4A609C).withValues(alpha: 0.66),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    labelText: "First name",
                    filled: true,
                    hintText: "First name",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // LAST NAME TEXT FIELD
                TextFormField(
                  maxLength: 30,
                  decoration: InputDecoration(
                    label: const Text("Last Name"),
                    counterText: '',
                    border: InputBorder.none,
                    filled: true,
                    prefixIcon: const Icon(Icons.person_outline),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // EMAIL TEXT FIELD
                TextFormField(
                  maxLength: 30,
                  decoration: InputDecoration(
                    label: const Text("E-Mail"),
                    counterText: '',
                    hintText: "Only @gmail.com is accepted",

                    border: InputBorder.none,
                    filled: true,

                    prefixIcon: const Icon(Icons.email_outlined),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // BIO TEXT FIELD
                TextFormField(
                  maxLength: 30,
                  decoration: InputDecoration(
                    label: const Text("Username"),
                    counterText: '',
                    border: InputBorder.none,

                    filled: true,
                    prefixIcon: const Icon(Icons.person),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(0, 33, 149, 243),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Center(
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 149, 0),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
