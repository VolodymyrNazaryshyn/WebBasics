<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String domain = request.getContextPath();
%>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Java</title>
</head>
<body>
<h2>Java Web</h2>
<a href="<%= domain %>/forms">Передача данных. Формы</a>
<p>
    Сервлеты - разновидность классов, предназначенных для сетевых задач.
    Аналог из ASP - ApiController.
</p>
<h3>Создание сервлета.</h3>
<p>
    Проверяем/добавляем зависимость https://mvnrepository.com/artifact/javax.servlet/servlet-api/2.5
    Создаем пакет "servlet", в нем - новый класс HomeServlet, переопределяем в нем метод doGet
    Регистрируем сервлет и указываем роутинг:
    а) web.xml
    б) [для версии servlet-api > 3.0] при помощи аннотации @WebServlet("/about")
</p>
<p>
    Сервлеты используют как контроллеры для предварительной обработки запросов
    и подготовке для представления финальных данных (чтобы убрать из представления
    логику обработки - только отображение). Основной способ передачи - атрибуты
    запроса
</p>
</body>
</html>
