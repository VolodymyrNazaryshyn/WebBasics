package itstep.learning.servlet;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import itstep.learning.data.dao.IUserDao;
import itstep.learning.data.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Singleton
public class UserAuthServlet extends HttpServlet {
    private IUserDao userDao;

    @Inject
    public UserAuthServlet(IUserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String authLogin = req.getParameter("auth-login");
        String authPass = req.getParameter("auth-pass");

        if (authPass == null || authLogin == null
                || authLogin.equals("") || authPass.equals("")) {
            resp.getWriter().print("NO");
        }
        else {
            resp.getWriter().print("OK");
            User user = userDao.getUser("Visitor", "eec53a2bc0bb9fac8b80ec9a2c66db4f");
            System.out.println(user.toString());
        }
    }
}
