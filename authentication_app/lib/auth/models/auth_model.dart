class AuthModel {
  
  // Variables to store user email and password
  String? userEmail;
  String? password;

  // Constructor to initialize AuthModel with optional parameters
  AuthModel({this.userEmail, this.password});

  // Factory method to create an AuthModel instance from a JSON object
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userEmail: json['user_email'], 
      password: json['password'], 
    );
  }

  // Method to convert AuthModel instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'user_email': userEmail, 
      'password': password, 
    };
  }
}
