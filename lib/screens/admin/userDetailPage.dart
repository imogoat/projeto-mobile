import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:imogoat/components/appBarCliente.dart';
import 'package:imogoat/components/loading.dart';
import 'package:imogoat/controllers/user_controller.dart';
import 'package:imogoat/models/rest_client.dart';
import 'package:imogoat/models/user.dart';
import 'package:imogoat/repositories/user_repository.dart';
import 'package:imogoat/styles/color_constants.dart';

class UserDetailPage extends StatefulWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();

  final controller = ControllerUser(userRepository: UserRepository(restClient: GetIt.I.get<RestClient>()));

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.user.username;
    _emailController.text = widget.user.email;
    _numberController.text = widget.user.number;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atualizar Dados do Usuário',
          style: TextStyle(
            color: verde_medio,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Poppins'
          ),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'Número',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
              ),),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
            TextButton(
              child: const Text('Atualizar',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
              ),),
              onPressed: () async { 
                  try {
                    final user = User(username: _usernameController.text, email: _emailController.text, number: _numberController.text, id: widget.user.id);

                    await updateUser(user);

                    if (mounted && Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print('Erro ao atualizar imóvel: $e');
                    if (mounted && Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }                    
                  }
                }
            ),
          ],
        );
      },
    );
  }

  Future<void> updateUser(User data) async {
    final String id = widget.user.id.toString();
    try {
      showDialog(context: context, builder: (context) => const Loading());
      await controller.updateUserDate('/alter-user/$id', data);
      Navigator.pushNamedAndRemoveUntil(context, '/homeAdm', (route) => false);
    } catch (error) {
      print('Erro ao atualizar o imóvel: $error');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCliente(),
      floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFFFFC107),
              foregroundColor: Colors.white,
              child: const Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(context);
              },
            ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Dados do Usuário',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 200,
                      child: Divider(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              // Username
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Username: ${widget.user.username}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // User ID
              Row(
                children: [
                  const Icon(
                    Icons.badge,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'ID: ${widget.user.id}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Email
              Row(
                children: [
                  const Icon(
                    Icons.email,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Email: ${widget.user.email}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Phone Number
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Número: ${widget.user.number}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Role
              Row(
                children: [
                  const Icon(
                    Icons.work,
                    size: 26,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Tipo de usuário: ${widget.user.role}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: Divider(),
              ),
              const SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: Color.fromARGB(255, 24, 157, 130),
                          width: 1.5,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Color.fromARGB(255, 46, 60, 78);
                          }
                          return null;
                        },
                      ),
                      elevation: MaterialStateProperty.all(0),
                      minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                    ),
                    child: Text(
                      'Entrar em contato',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 24, 157, 130),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
