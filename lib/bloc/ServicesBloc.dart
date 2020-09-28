import '../repository/Repository.dart';

class ServicesBloc 
{
  final repository = Repository();
  getServices()
  {
    return repository.getServices();
  }
}
final servicesBloc = ServicesBloc();