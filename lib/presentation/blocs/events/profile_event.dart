/// [ProfileEvent] is the abstract class that will be extended by the events of the profile bloc.
abstract class ProfileEvent {}

/// [FetchProfileEvent] is the event to fetch the profile data.
/// This event will be used to fetch the profile data.
class FetchProfileEvent extends ProfileEvent {}
