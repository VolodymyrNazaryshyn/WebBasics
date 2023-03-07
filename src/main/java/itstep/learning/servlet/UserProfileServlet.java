package itstep.learning.servlet;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import itstep.learning.data.dao.IUserDao;
import itstep.learning.data.entity.User;
import itstep.learning.service.auth.AuthService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Singleton
public class UserProfileServlet extends HttpServlet {
    @Inject
    AuthService authService;
    @Inject
    private IUserDao userDao;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String profileUserLogin = req.getPathInfo();
        User profileUser = null;
        String viewName = "profile-404"; // профиль не найден
        if (profileUserLogin != null && profileUserLogin.length() > 1) {
            profileUserLogin = profileUserLogin.substring(1); // user
            profileUser = userDao.getUserProfile(profileUserLogin);
            if (profileUser != null) {
                User authUser = authService.getAuthUser();
                if (authUser != null && authUser.getId().equals(profileUser.getId())) {
                    // свой профиль
                    viewName = "profile-my";
                }
                else { // чужой профиль
                    req.setAttribute("profileUser", profileUser);
                    viewName = "profile";
                }
            }
        }
        req.setAttribute("viewName", viewName);
        req.getRequestDispatcher("../WEB-INF/_layout.jsp").forward(req, resp);
    }
}
