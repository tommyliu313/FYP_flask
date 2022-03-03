"use strict";
exports.__esModule = true;
var aws_amplify_1 = require("aws-amplify");
require("amazon-cognito-js");
var sweetalert2_1 = require("sweetalert2");
aws_amplify_1.Auth.configure({
    userPoolId: 'us-east-1_dqiapzBbr',
    userPoolWebClientId: '57a80fik1473v2up522vav7br2',
    oauth: {
        region: "us-east-1",
        domain: 'https://lineinthecloud.auth.us-east-1.amazoncognito.com',
        scope: ['email', 'openid', 'aws.cognito.signin.user.admin'],
        redirectSignIn: 'https://172.31.50.168:5000',
        redirectSignOut: 'https://172.31.50.168:5000',
        responseType: 'code'
    }
});
function displayObject(data) {
    return sweetalert2_1["default"].fire({
        title: data && (data.message || data.title || ''),
        html: "<div class=\"text-danger\" style=\"text-align:left\">  ".concat(JSON.stringify(data || {}, null, 6)
            .replace(/\n( *)/g, function (match, p1) {
            return '<br>' + '&nbsp;'.repeat(p1.length);
        }), "</div>")
    });
}
function onLogout() {
    aws_amplify_1.Auth.signOut().then(function (result) {
        setUserState(null);
    })["catch"](function (err) {
        displayObject(err);
    });
}
function Login() {
    document.getElementById("login").addEventListener('click', function () {
        return sweetalert2_1["default"].fire({
            title: 'Login Form',
            html: "<form method=\"POST\" required>" + "<input type=\"text\" id=\"login\" class=\"swal2-input\" placeholder=\"Username\">\n  <input type=\"password\" id=\"password\" class=\"swal2-input\" placeholder=\"Password\">" + "<button class=\"swal2-input\" onclick=\"ForgetPassword()\">" + "<p>Forget Password?</p>" + "</button>" + "</form>" + "<button class=\"swal2-input\" onClick=\"turnon()\">" + "<i class=\"far fa-eye\">" + "</i>" + "</button>" + "<div>" + "<button class=\"swal2-input\" onclick=\"ongoogle()\">" + "<i class=\"fab fa-google\">" + "</i>" + "</button>" + "<button class=\"swal2-input\">" + "<i class=\"fab fa-facebook-square\">" + "</i>" + "</button>" + "</div>",
            confirmButtonText: 'Sign in',
            focusConfirm: false,
            preConfirm: function () {
                var login = sweetalert2_1["default"].getPopup().querySelector('#login');
                var password = sweetalert2_1["default"].getPopup().querySelector('#password');
                if (!login) {
                    sweetalert2_1["default"].showValidationMessage("\u8ACB\u4F60\u8F38\u5165\u96FB\u5B50\u90F5\u4EF6<br>Please enter email");
                }
                if (!password) {
                    sweetalert2_1["default"].showValidationMessage("\u8ACB\u4F60\u8F38\u5165\u5BC6\u78BC<br>Please enter password");
                }
                if (!login && !password) {
                    sweetalert2_1["default"].showValidationMessage("\u8ACB\u4F60\u8F38\u5165\u96FB\u5B50\u90F5\u4EF6\u53CA\u5BC6\u78BC<br>Please enter login and password");
                }
            }
        });
    });
}
function ForgetPassword() {
    var usernameprompt = sweetalert2_1["default"].fire({ html: "<input type=\"text\" id=\"forgetlogin\" class=\"swal2-input\" placeholder=\"Enter your username:\">" });
    // @ts-ignore
    aws_amplify_1.Auth.forgotPassword(usernameprompt).then(function (result) {
        var renewcodeprompt = sweetalert2_1["default"].fire({ html: "<input type=\"text\" id=\"renewcode\" class=\"swal2-input\" placeholder=\"Enter your confirmation code:\">" });
        var newpasswordprompt = sweetalert2_1["default"].fire({ html: "<input type=\"password\" id=\"newpassword\" class=\"swal2-input\" placeholder=\"Enter your new password\">" });
        // @ts-ignore
        aws_amplify_1.Auth.forgotPasswordSubmit(usernameprompt, renewcodeprompt, newpasswordprompt).then(function (confirationResult) {
            displayObject(confirationResult);
        })["catch"](function (err) { return displayObject(err); });
    })["catch"](function (err) { return displayObject(err); });
}
function setUserState(user) {
    var usernamePlaceholder = document.getElementById('username-placeholder');
    var loginButton = document.getElementById('login-button');
    var logoutButton = document.getElementById('logout-button');
    if (!user) {
        usernamePlaceholder.innerHTML = '';
        usernamePlaceholder.style.display = 'none';
        loginButton.style.display = 'block';
        logoutButton.style.display = 'none';
    }
    else {
        usernamePlaceholder.innerHTML = user.username;
        usernamePlaceholder.style.display = 'block';
        loginButton.style.display = 'none';
        logoutButton.style.display = 'block';
    }
}
