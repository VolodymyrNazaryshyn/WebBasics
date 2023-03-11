<%@ page import="itstep.learning.data.entity.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User myProfile = (User) request.getAttribute("authUser");
    String contextPath = request.getContextPath();
%>

<div class="row">
    <div class="col l10 m11 s12">
        <h2 class="header" style="text-align: center">My profile</h2>
        <div class="card horizontal">
            <div class="card-image">
                <img id="avatar" style="max-width: 90%" src="<%= contextPath %>/image/<%= myProfile.getAvatar()%>" alt=""/>
                <label for="avatar_uploads" class="btn-floating btn-small waves-effect waves-light teal"
                   style="position: absolute; top: 5px; right: 35px;"
                >
                    <i class="material-icons" style="font-size: 1rem;">edit</i>
                </label>
                <input hidden id="avatar_uploads" type="file" name="avatar_uploads" accept=".jpg, .jpeg, .png" />
            </div>
            <div class="card-stacked">
                <div class="card-content"
                     style="display: flex;
                            flex-direction: column;
                            justify-content: center;
                            gap: 5px;"
                >
                    <div style="display: flex;
                                align-items: center;
                                justify-content: space-between;
                                padding: 10px 0;"
                    >
                        <span>
                            <b>Login: </b><i><%= myProfile.getLogin() %></i>
                        </span>
                    </div>
                    <div style="display: flex;
                                align-items: center;
                                justify-content: space-between;
                                padding: 10px 0;"
                    >
                        <span>
                            <b>Real Name: </b><i id="user-name"><%= myProfile.getName() %></i>
                        </span>
                        <a id="user-name-btn" class="btn-floating btn-small waves-effect waves-light teal">
                            <i class="material-icons" style="font-size: 1rem;">edit</i>
                        </a>
                    </div>
                    <div style="display: flex;
                                align-items: center;
                                justify-content: space-between;
                                padding: 10px 0;"
                    >
                        <span>
                            <b>Email: </b><i id="email"><%= myProfile.getEmail() %></i>
                        </span>
                        <a id="email-btn" class="btn-floating btn-small waves-effect waves-light teal">
                            <i class="material-icons" style="font-size: 1rem;">edit</i>
                        </a>
                    </div>
                    <div style="padding-top: 10px;">
                        <b>Active from:</b> <%= new SimpleDateFormat("dd/MM/yyyy").format(myProfile.getRegDt()) %>
                    </div>
                </div>
                <div class="card-action">
                    <a id="change_password_link" style="cursor: pointer">Change password</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Change password Modal -->
<div id="change_password_modal" class="modal">
    <div class="modal-content">
        <h4>Change Password</h4>
        <div class="row input-field">
            <i class="material-icons prefix">lock_open</i>
            <input id="old-pass" type="password">
            <label for="old-pass">Old password</label>
        </div>
        <label class="auth-error" id="login-err"></label>
        <div class="row input-field">
            <i class="material-icons prefix">lock_open</i>
            <input id="new-pass" type="password">
            <label for="new-pass">New password</label>
        </div>
        <div class="row input-field">
            <i class="material-icons prefix">lock_open</i>
            <input id="repeat-pass" type="password">
            <label for="repeat-pass">Repeat password</label>
        </div>
        <label class="password-error" id="password-err"></label>
    </div>
    <div class="modal-footer">
        <div class="btn" id="change_password_button">
            <span>Change password</span>
        </div>
        <div class="btn" id="cancel_change_password">
            <span>Cancel</span>
        </div>
    </div>
</div>

<script>
    const fileTypes = [
        "image/apng",
        "image/bmp",
        "image/gif",
        "image/jpeg",
        "image/pjpeg",
        "image/png",
        "image/svg+xml",
        "image/tiff",
        "image/webp",
        "image/x-icon"
    ];

    document.addEventListener("DOMContentLoaded", () => {
        const userNameBtn = document.getElementById("user-name-btn");
        userNameBtn.addEventListener("click", (e) => {
            const userName = document.getElementById("user-name");
            if(userName.getAttribute("contenteditable")) { // заверщение редактирования
                userName.removeAttribute("contenteditable")
                e.target.innerHTML = '<i class="material-icons" style="font-size: 1rem;">edit</i>'
            }
            else {
                userName.setAttribute("contenteditable", "true");
                userName.focus();
                e.target.innerHTML = '<i class="material-icons" style="font-size: 1rem;">save</i>'
            }
        });

        const emailBtn = document.getElementById("email-btn");
        emailBtn.addEventListener("click", (e) => {
            const email = document.getElementById("email");
            if(email.getAttribute("contenteditable")) {
                email.removeAttribute("contenteditable")
                e.target.innerHTML = '<i class="material-icons" style="font-size: 1rem;">edit</i>'
            }
            else {
                email.setAttribute("contenteditable", "true");
                email.focus();
                e.target.innerHTML = '<i class="material-icons" style="font-size: 1rem;">save</i>'
            }
        });

        const avatarUploadBtn = document.getElementById("avatar_uploads");
        avatarUploadBtn.addEventListener("change", (e) => {
            const avatar = document.getElementById("avatar");
            const file = e.target.files[0];
            if (fileTypes.includes(file.type)) {
                avatar.src = URL.createObjectURL(file)
            }
            else {
                alert(`File name ${file.name} not a valid file type`)
            }
        });

        const changePasswordLink = document.getElementById("change_password_link");
        changePasswordLink.addEventListener("click", () => {
            let elem = document.getElementById('change_password_modal');
            let instance = M.Modal.init(elem, {});
            instance.open();
        });

        cancel_change_password.addEventListener("click", () => {
            M.Modal.getInstance(window.change_password_modal).close();
        });
    });
</script>
