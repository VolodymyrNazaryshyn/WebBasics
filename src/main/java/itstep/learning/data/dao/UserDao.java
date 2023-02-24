package itstep.learning.data.dao;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import itstep.learning.data.entity.User;
import itstep.learning.model.UserModel;
import itstep.learning.service.DbService;
import itstep.learning.service.HashService;

import javax.annotation.Nonnull;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Singleton
public class UserDao {   // Data Access Object  for entity.User
    private final DbService dbService ;
    private final HashService hashService ;

    @Inject public UserDao( DbService dbService, HashService hashService ) {
        this.dbService = dbService ;
        this.hashService = hashService ;
    }

    public List<User> getAll() {
        try( Statement statement = dbService.getConnection().createStatement() ) {
            ResultSet res = statement.executeQuery( "SELECT u.* FROM Users u" ) ;
            List<User> users = new ArrayList<>() ;
            while( res.next() )
                users.add( new User( res ) ) ;
            return users ;
        }
        catch( SQLException ex ) {
            System.err.println( "UserDao::getAll " + ex.getMessage() ) ;
            return null ;
        }
    }

    public boolean add( @Nonnull UserModel model ) {
        // Генерируем соль
        String salt = hashService.getHexHash( System.nanoTime() + "" ) ;
        // Создаем хеш пароля
        String hash = getPassHash( model.getPass1(), salt ) ;
        String sql = "INSERT INTO Users(`id`,`login`,`name`,`salt`,`pass`,`email`) " +
                " VALUES( UUID(), ?, ?, ?, ?, ? )" ;
        try( PreparedStatement prep = dbService.getConnection().prepareStatement( sql ) ) {
            /*
            Д.З. Реализовать выполнение запроса по добавлению (регистрации) пользователя
            в БД. Внедрить коды добавления в сервлет. Проверить работоспособность
            через форму регистрации.
            * Стилизация регистрационной формы.
             */
            return true ;
        }
        catch( Exception ex ) {
            System.err.println( "UserDao::add " + ex.getMessage() ) ;
            return false ;
        }
    }
    private String getPassHash( String password, String salt ) {
        return hashService.getHexHash( salt + password ) ;
    }
}