package itstep.learning.servlet;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import itstep.learning.data.DataContext;
import itstep.learning.data.entity.Team;
import itstep.learning.data.entity.User;
import itstep.learning.service.auth.AuthService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Singleton
public class HomeServlet extends HttpServlet {
    @Inject
    private DataContext dataContext;
    @Inject
    private AuthService authService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User authUser = authService.getAuthUser();

        List<Team> teams = authUser == null ? null : dataContext.getTeamDao().getUserTeams(authUser);
        req.setAttribute("teams", teams);

        System.out.println(tasks);

        req.setAttribute("viewName", "index");
        req.getRequestDispatcher("WEB-INF/_layout.jsp").forward(req, resp);
    }

}
