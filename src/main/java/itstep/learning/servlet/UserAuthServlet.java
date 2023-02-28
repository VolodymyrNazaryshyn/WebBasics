package itstep.learning.servlet;

import com.google.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Singleton
public class UserAuthServlet extends HttpServlet {
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
        }
    }
}
