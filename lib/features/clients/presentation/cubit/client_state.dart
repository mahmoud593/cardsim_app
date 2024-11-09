abstract class ClientState {}

class ClientInitialState extends ClientState {}

class GetAllClientsLoadingState extends ClientState {}
class GetAllClientsSuccessState extends ClientState {}
class GetAllClientsErrorState extends ClientState {}

class AddClientLoadingState extends ClientState {}
class AddClientSuccessState extends ClientState {}
class AddClientErrorState extends ClientState {}