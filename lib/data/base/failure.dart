
abstract class Failure{
  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ResponseFailure extends Failure {
  ResponseFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message);
}

class CommonFailure extends Failure {
  CommonFailure(String message) : super(message);
}

