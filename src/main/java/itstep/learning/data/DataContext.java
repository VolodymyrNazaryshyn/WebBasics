package itstep.learning.data;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import itstep.learning.data.dao.TeamDao;
import itstep.learning.data.dao.UserDao;

@Singleton
public class DataContext {
    private final UserDao userDao;
    private final TeamDao teamDao;
    private final TaskDao taskDao;

    @Inject
    public DataContext(UserDao userDao, TeamDao teamDao) {
        this.userDao = userDao;
        this.teamDao = teamDao;
    }

    public UserDao getUserDao() {
        return userDao;
    }

    public TeamDao getTeamDao() {
        return teamDao;
    }
}
