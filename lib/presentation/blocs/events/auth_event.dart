/// [AuthEvent] is the base class for all events that are related to authentication.
abstract class AuthEvent {}

/// [CheckAuthEvent] is an event to check the authentication.
class CheckAuthEvent extends AuthEvent {}
