package itstep.learning.servlet;

import itstep.learning.model.FormsModel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class FormsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        FormsModel model = new FormsModel();
        model.setMessage("Message from FormsServlet");
        req.setAttribute("formsModel", model);

        req.getRequestDispatcher("WEB-INF/forms.jsp")
                .forward(req, resp);
    }
}
/*
Д.З. Сверстать две формы на странице /forms
Одна методом GET, другая POST, обе на action /forms
Заложить передачу нескольких полей
- строка
- число
- дата
- цвет
 */