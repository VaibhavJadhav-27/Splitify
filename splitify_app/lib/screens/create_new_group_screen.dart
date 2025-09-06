import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitify_app/providers/bottom_nav_provider.dart';

class CreateNewGroup extends StatefulWidget {
  const CreateNewGroup({super.key});

  @override
  State<CreateNewGroup> createState() => _CreateNewGroupState();
}

class _CreateNewGroupState extends State<CreateNewGroup> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupDescriptionController =
      TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String groupType = "";
  String currency = "USD";
  bool isCreating = false;
  bool allowMembersToAdd = true;
  bool groupNotifications = true;

  List<int> selectedMembers = [];
  List<Map<String, dynamic>> availableFriends = [
    {
      "id": 1,
      "name": "Sarah Connor",
      "avatar": "SC",
      "email": "sarah@example.com",
    },
    {
      "id": 2,
      "name": "Mike Johnson",
      "avatar": "MJ",
      "email": "mike@example.com",
    },
    {
      "id": 3,
      "name": "Emma Davis",
      "avatar": "ED",
      "email": "emma@example.com",
    },
    {"id": 4, "name": "Alex Kim", "avatar": "AK", "email": "alex@example.com"},
    {"id": 5, "name": "Tom Wilson", "avatar": "TW", "email": "tom@example.com"},
    {
      "id": 6,
      "name": "Lisa Moore",
      "avatar": "LM",
      "email": "lisa@example.com",
    },
    {
      "id": 7,
      "name": "Jake Smith",
      "avatar": "JS",
      "email": "jake@example.com",
    },
    {
      "id": 8,
      "name": "Rachel Green",
      "avatar": "RG",
      "email": "rachel@example.com",
    },
  ];

  List<Map<String, String>> groupTypes = [
    {"value": "home", "label": "Home & Roommates"},
    {"value": "trip", "label": "Trip & Vacation"},
    {"value": "work", "label": "Work & Office"},
    {"value": "friends", "label": "Friends & Social"},
    {"value": "family", "label": "Family"},
    {"value": "couple", "label": "Couple"},
    {"value": "other", "label": "Other"},
  ];

  List<Map<String, String>> currencies = [
    {"value": "USD", "label": "USD (\$)"},
    {"value": "EUR", "label": "EUR (€)"},
    {"value": "GBP", "label": "GBP (£)"},
    {"value": "CAD", "label": "CAD (\$)"},
    {"value": "AUD", "label": "AUD (\$)"},
    {"value": "JPY", "label": "JPY (¥)"},
  ];

  void toggleMember(int id) {
    setState(() {
      if (selectedMembers.contains(id)) {
        selectedMembers.remove(id);
      } else {
        selectedMembers.add(id);
      }
    });
  }

  void handleCreateGroup() async {
    if (groupNameController.text.trim().isEmpty) return;

    setState(() => isCreating = true);
    await Future.delayed(const Duration(seconds: 1));

    final newGroup = {
      "name": groupNameController.text.trim(),
      "description": groupDescriptionController.text.trim(),
      "type": groupType,
      "currency": currency,
      "members": [
        {"name": "You", "avatar": "JD"},
        ...selectedMembers.map((id) {
          final friend = availableFriends.firstWhere((f) => f["id"] == id);
          return {"name": friend["name"], "avatar": friend["avatar"]};
        }),
      ],
      "allowMembersToAdd": allowMembersToAdd,
      "notifications": groupNotifications,
    };

    //widget.onCreateGroup(newGroup);
    setState(() => isCreating = false);
  }

  void handleBackGroupScreen(BuildContext context) {
    // Navigate to Group screen
    context.read<BottomNavProvider>().setIndex(1);
    //Navigator.pushReplacementNamed(context, '/groups');
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final filteredFriends =
        availableFriends.where((f) {
          final q = searchController.text.toLowerCase();
          return f["name"].toString().toLowerCase().contains(q) ||
              f["email"].toString().toLowerCase().contains(q);
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Group'),
        centerTitle: true,
        leading: BackButton(onPressed: () => handleBackGroupScreen(context)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        actions: [
          TextButton(
            onPressed: isCreating ? null : handleCreateGroup,
            child: Text(
              isCreating ? "Creating..." : "Create",
              style: TextStyle(
                color:
                    isCreating || groupNameController.text.isEmpty
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Group Image
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.camera_alt, size: 32, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Add Group Photo"),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Optional: Add a photo to personalize your group",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Group Details
          TextField(
            controller: groupNameController,
            decoration: const InputDecoration(
              labelText: "Group Name *",
              hintText: "e.g., Roommates, Weekend Trip, Work Lunch",
            ),
          ),

          const SizedBox(height: 12),
          TextField(
            controller: groupDescriptionController,
            decoration: const InputDecoration(
              labelText: "Description (Optional)",
              hintText: "Add details about this group...",
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          //Dropdowns
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: groupType.isEmpty ? null : groupType,
                  decoration: const InputDecoration(labelText: "Group Type"),
                  items:
                      groupTypes.map((type) {
                        return DropdownMenuItem(
                          value: type['value'],
                          child: Text(type['label']!),
                        );
                      }).toList(),
                  onChanged: (value) => setState(() => groupType = value ?? ""),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: currency,
                  decoration: const InputDecoration(labelText: "Currency"),
                  items:
                      currencies.map((cur) {
                        return DropdownMenuItem(
                          value: cur['value'],
                          child: Text(cur['label']!),
                        );
                      }).toList(),
                  onChanged:
                      (value) => setState(() => currency = value ?? "USD"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Members
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Members",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${selectedMembers.length + 1} members",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search friends...",
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),

          if (selectedMembers.isNotEmpty)
            Wrap(
              spacing: 6,
              children:
                  selectedMembers.map((id) {
                    final friend = availableFriends.firstWhere(
                      (f) => f["id"] == id,
                    );
                    return Chip(
                      label: Text(friend["name"]),
                      onDeleted: () => toggleMember(id),
                    );
                  }).toList(),
            ),
          const SizedBox(height: 8),

          ...filteredFriends.map((f) {
            final isSelected = selectedMembers.contains(f["id"]);
            return ListTile(
              leading: CircleAvatar(child: Text(f["avatar"]!)),
              title: Text(f["name"]!),
              subtitle: Text(f["email"]!),
              trailing: Checkbox(
                value: isSelected,
                onChanged: (_) => toggleMember(f["id"]),
              ),
              onTap: () => toggleMember(f["id"]),
            );
          }),

          if (filteredFriends.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text("No friends found"),
              ),
            ),
          const SizedBox(height: 16),

          // Privacy Settings
          SwitchListTile(
            title: const Text("Allow members to add others"),
            subtitle: const Text("Members can invite new people to the group"),
            value: allowMembersToAdd,
            onChanged: (val) => setState(() => allowMembersToAdd = val),
          ),

          SwitchListTile(
            title: const Text("Group activity notifications"),
            subtitle: const Text(
              "Get notified about new expenses and settlements",
            ),
            value: groupNotifications,
            onChanged: (val) => setState(() => groupNotifications = val),
          ),
        ],
      ),
    );
    //);
  }
}
