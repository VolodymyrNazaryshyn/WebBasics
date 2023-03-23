<%@ page import="itstep.learning.data.entity.User" %>
<%@ page import="itstep.learning.data.entity.Team" %>
<%@ page import="java.util.List" %>
<%@ page import="itstep.learning.data.entity.Task" %>
<%@ page import="itstep.learning.data.entity.Entity" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String domain = request.getContextPath();
    User authUser = (User) request.getAttribute("authUser");
    List<Team> teams = (List<Team>) request.getAttribute("teams");
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
%>

<div style="display: block; width: 100%; background: lightblue; border-radius: 20px">
    <!-- region Блок задач -->
    <div style="display: flex; flex-direction: column; width: 95%; margin: auto;">
        <h4 style="text-align: center">Активные задачи</h4>
        <% for (int i = 1; i <= tasks.size(); ++i) { %>
            <div class="task" id="task<%= i %>" style="padding: 10px; margin-bottom: 10px; display: flex; align-items: center; justify-content: space-between">
                <div style="display: flex; align-items: center;">
                    <i id="task<%= i %>_priority_icon" class="material-icons" style="margin-right: 10px;"></i>
                    <b id="task<%= i %>_name"><%= tasks.get(i - 1).getName() %></b>
                    <b hidden id="task<%= i %>_team">
                        <% for(Team team : teams) { %>
                            <% if(team.getId().equals(tasks.get(i - 1).getIdTeam())) %><%= team.getName() %>
                        <% } %>
                    </b>
                    <b hidden id="task<%= i %>_createdDt"><%= Entity.sqlDatetimeFormat.format(tasks.get(i - 1).getCreatedDt()) %></b>
                    <b hidden id="task<%= i %>_deadline"><%= Entity.sqlDatetimeFormat.format(tasks.get(i - 1).getDeadline()) %></b>
                    <b hidden id="task<%= i %>_priority"><%= tasks.get(i - 1).getPriority() %></b>
                    <b hidden id="task<%= i %>_status"><%= tasks.get(i - 1).getStatus() %></b>
                </div>
                <div style="display: flex; align-items: center">
                    <i id="check_box_icon<%= i %>" style="cursor: pointer" class="material-icons">check_box_outline_blank</i>
                    <i id="eye_icon<%= i %>" style="cursor: pointer" class="material-icons">remove_red_eye</i>
                    <i id="edit_icon<%= i %>" class="material-icons">edit</i>
                    <i id="delete_icon<%= i %>" class="material-icons">delete</i>
                    <a href="#<%= tasks.get(i - 1).getId() %>" style="color: black; text-decoration: underline">Discus</a>
                </div>
            </div>
        <% } %>
    </div>
    <!-- endregion Конец блока задач -->

        </div>
        <div class="row input-field"><i class="material-icons prefix">event_available</i>
            <input id="task-deadline" type="text" class="datepicker" name="task-deadline">
            <label for="task-deadline">Завершение</label>
    <!-- region Добавить задачу -->
    <div class="row" style="width: 100%">
        <h4 style="text-align: center">Добавить задачу</h4>
        <form class="col s10 offset-s1 m8 offset-m2 l6 offset-l3" method="post" id="task-form">
            <div class="row input-field">
                <i class="material-icons prefix">content_paste</i>
                <input id="task-name" type="text" name="task-name">
                <label for="task-name">Название</label>
            </div>
            <div class="row input-field">
                <div id="task-team">
                    <i class="material-icons prefix" id="people-icon" style="position: absolute; top: 0; padding-top: 9px; padding-bottom: 9px;">people_outline</i>
                    <select name="task-team">
                        <option value="" disabled selected>Выберите команду</option>
                        <% for (Team team : teams) { %>
                            <option value="<%= team.getId() %>"><%= team.getName() %></option>
                        <% } %>
                    </select>
                    <label style="margin-top: 10px">Команда</label>
                </div>
            </div>
            <div class="row input-field">
                <i class="material-icons prefix">event_available</i>
                <input id="task-deadline" type="text" class="datepicker" name="task-deadline">
                <label for="task-deadline">Завершение</label>
            </div>
            <div class="row input-field">
                <div id="task-priority">
                    <i class="material-icons prefix" id="exclamation-mark-icon" style="position: absolute; top: 0; padding-top: 9px; padding-bottom: 9px;">priority_high</i>
                    <select name="task-priority">
                        <option value="" disabled selected>Выберите приоритет</option>
                        <option value="0">Обычный</option>
                        <option value="1">Высокий</option>
                        <option value="2">Экстремальный</option>
                    </select>
                    <label style="margin-top: 10px">Приоритет</label>
                </div>
            </div>
            <div class="row input-field right-align">
                <button class="btn waves-effect waves-teal" type="submit">
                    создать<i class="material-icons right">add</i>
                </button>
            </div>
        </form>
    </div>
    <!-- endregion -->
</div>

<!-- region open task Modal -->
<div id="open_task_modal" class="modal">
    <div class="modal-content">
        <h5 id="task_name_modal"></h5>
        <h5 id="task_team_modal"></h5>
        <h5 id="task_createdDt_modal"></h5>
        <h5 id="task_deadline_modal"></h5>
        <h5 id="task_priority_modal"></h5>
        <h5 id="task_status_modal"></h5>
    </div>
    <div class="modal-footer">
        <div class="btn" id="save_task_button">
            <i class="material-icons left">save</i>Save
        </div>
        <div class="btn" id="close_task_button">
            <span>Close</span>
        </div>
    </div>
</div>
<!-- endregion -->

<!-- region add task error Modal -->
<div id="error_modal" class="modal">
    <div class="modal-content">
        <h4>Ошибка:</h4>
        <h5 id="error_message_modal"></h5>
    </div>
    <div class="modal-footer">
        <div class="btn" id="ok_button">
            <span>Ok</span>
        </div>
    </div>
</div>
<!-- endregion -->

<script>
    const new_task_name = document.getElementById("task-name");
    const new_task_team = document.getElementById("task-team");
    const new_task_deadline = document.getElementById("task-deadline");
    const new_task_priority = document.getElementById("task-priority");
    const error_message = document.getElementById("error_message_modal");

    document.addEventListener('DOMContentLoaded', function () {
        let elems = document.querySelectorAll('select');
        let instances = M.FormSelect.init(elems, {});
        elems = document.querySelectorAll('.datepicker');
        instances = M.Datepicker.init(elems, {format: "yyyy-mm-dd"});

        const tasks = document.getElementsByClassName("task");

        for (let i = 0; i < tasks.length; ++i) {
            const task_name = document.getElementById(`task${i + 1}_name`);
            const task_team = document.getElementById(`task${i + 1}_team`);
            const task_createdDt = document.getElementById(`task${i + 1}_createdDt`);
            const task_deadline = document.getElementById(`task${i + 1}_deadline`);
            const task_priority = document.getElementById(`task${i + 1}_priority`);
            const task_status = document.getElementById(`task${i + 1}_status`);

            const task_priority_icon = document.getElementById(`task${i + 1}_priority_icon`);
            const eye_icon = document.getElementById(`eye_icon${i + 1}`);
            const check_box_icon = document.getElementById(`check_box_icon${i + 1}`);
            const priority = parseInt(task_priority.innerText) + 1;
            const task = document.getElementById(`task${i + 1}`);
            let isChecked = task_status.innerText === "0" ? false : true;

            if (isChecked) {
                task_name.style.textDecoration = "line-through";
                check_box_icon.innerText = "check_box";
            }
            else {
                task_name.style.textDecoration = "none";
                check_box_icon.innerText = "check_box_outline_blank";
            }

            if (priority === 1) {
                task.style.border = "1px solid brown";
                task.style.background = "#1DC38B";
                task_priority_icon.innerText = "looks_one";
            }
            else if (priority === 2) {
                task.style.border = "4px solid brown";
                task.style.background = "#939F41";
                task_priority_icon.innerText = "looks_two";
            }
            else if (priority === 3) {
                task.style.border = "7px solid brown";
                task.style.background = "#B4654B";
                task_priority_icon.innerText = "looks_3";
            }

            eye_icon.addEventListener('click', () => {
                document.getElementById("task_name_modal").innerHTML = "<b>Название:</b> " + task_name.innerText;
                document.getElementById("task_team_modal").innerHTML = "<b>Команда:</b> " + task_team.innerText;
                document.getElementById("task_createdDt_modal").innerHTML = "<b>Создание:</b> " + task_createdDt.innerText;
                document.getElementById("task_deadline_modal").innerHTML = "<b>Завершение:</b> " + task_deadline.innerText;
                document.getElementById("task_priority_modal").innerHTML = "<b>Приоритет:</b> "
                    + (priority === 1 ? "(1) Обычный" : priority === 2 ? "(2) Высокий" : "(3) Экстремальный");
                document.getElementById("task_status_modal").innerHTML = "<b>Статус:</b> "
                    + (isChecked ? "Выполнено ✅" : "Не выполнено ❌");

                M.Modal.init(document.getElementById('open_task_modal'), {}).open();
            });

            check_box_icon.addEventListener('click', () => {
                if (!isChecked) {
                    task_name.style.textDecoration = "line-through";
                    check_box_icon.innerText = "check_box";
                }
                else {
                    task_name.style.textDecoration = "none";
                    check_box_icon.innerText = "check_box_outline_blank";
                }
                fetch(window.location.href, {
                    method: "PUT",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                        "taskNumber": i.toString()
                    }
                }).then(r => r.text()).then(t => {
                    if (t !== "OK") alert("Invalid credentials: " + t);
                });
                isChecked = !isChecked;
            });
        }

        close_task_button.addEventListener("click", () => {
            M.Modal.getInstance(window.open_task_modal).close();
        });
    });
    document.addEventListener('submit', e => {
        e.preventDefault();
        switch(e.target.id) {
            case 'task-form': sendTaskForm(); break;
        }
    });

    function sendTaskForm() {
        fetch(window.location.href, {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded",},
            body: new URLSearchParams(new FormData(document.querySelector("#task-form")))
        }).then(r => r.text()).then(t => {
            console.log(t)
            if (t === "Unauthorized") error_message.innerText = "Неавторизован!";
            else if (t === "Missing required parameter: task-name") {
                error_message.innerText = "Отсутствует название задачи!";
                new_task_name.style.background = "rgba(255,0,0,.2)";
            }
            else if (t === "Missing required parameter: task-team") {
                error_message.innerText = "Отсутствует команда!";
                people_icon.style.background = "lightblue";
                new_task_team.style.background = "rgba(255,0,0,.2)";
            }
            else if (t === "Missing required parameter: task-deadline") {
                error_message.innerText = "Отсутствует завершение задачи!";
                new_task_deadline.style.background = "rgba(255,0,0,.2)";
            }
            else if (t === "Missing required parameter: task-priority") {
                error_message.innerText = "Отсутствует приоритет задачи!";
                exclamation_mark_icon.style.background = "lightblue";
                new_task_priority.style.background = "rgba(255,0,0,.2)";
            }
            else if (t === "OK") {
                window.location.reload();
                return
            }

            M.Modal.init(document.getElementById('error_modal'), {}).open();
        });
    }

    new_task_name.addEventListener("input", () => {
        new_task_name.style.background = "none";
        error_message.innerText = "";
    });

    new_task_team.addEventListener("change", () => {
        new_task_team.style.background = "none";
        error_message.innerText = "";
    });

    new_task_deadline.addEventListener("change", () => {
        new_task_deadline.style.background = "none";
        error_message.innerText = "";
    });

    ok_button.addEventListener("click", () => {
        M.Modal.getInstance(window.error_modal).close();
    });

    });
</script>