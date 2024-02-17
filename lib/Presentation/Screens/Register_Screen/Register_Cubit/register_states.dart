abstract class RegisterStates {} 

class RegisterInitialState extends RegisterStates {} 

class RegisterLoadingState extends RegisterStates {} 

class RegisterSuccessState extends RegisterStates {} 

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterErrorState extends RegisterStates 
{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangeVisibilityState extends RegisterStates {}
class RegisterSelectVehicleTypeState extends RegisterStates {}