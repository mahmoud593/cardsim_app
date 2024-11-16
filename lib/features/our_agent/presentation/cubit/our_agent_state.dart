abstract class OurAgentStates {}

class OurAgentInitialState extends OurAgentStates {}


class LaunchWhatsAppSuccessState extends OurAgentStates {}
class LaunchWhatsAppErrorState extends OurAgentStates {}
class LaunchTelegramSuccessState extends OurAgentStates {}
class LaunchTelegramErrorState extends OurAgentStates {}


class GetAgentSuccessState extends OurAgentStates {}
class GetAgentErrorState extends OurAgentStates {}
class GetAgentLoadingState extends OurAgentStates {}