import 'package:aaishani_store_user_app/models/model_album.dart';
import 'package:aaishani_store_user_app/repository/Repository.dart';

class NavHomeBloc
{
  Future <List<Model_Album>> modelAlbum;
  Repository repository = Repository();
  get_album_data() async
  {
    modelAlbum = repository.get_album_data();
    return modelAlbum;
  }
}

final NavHomeBloc navHomeBloc = NavHomeBloc();
