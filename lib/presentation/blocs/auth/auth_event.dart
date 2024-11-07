/// [AuthEvent] is the base class for all events that are dispatched by 
/// the [AuthBloc].
abstract class AuthEvent {}

/// [AuthLoginEvent] is an event that is dispatched when the user logs in.
class AuthLoginEvent extends AuthEvent {}

/// [AuthLogoutEvent] is an event that is dispatched when the user logs out.
class AuthLogoutEvent extends AuthEvent {}
