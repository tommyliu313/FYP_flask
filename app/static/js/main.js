/*原始設定*/
//import { CognitoUser } from 'amazon-cognito-identity-js'
//import { Auth } from 'aws-amplify'

//Auth.configure({
//  userPoolId: 'us-east-1_dqiapzBbr',
//  userPoolWebClientId: '57a80fik1473v2up522vav7br2'
//})
var formatword= "<></>";

/*原始網站設定*/
var url={image:"https://picsum.photos/200/300"}
/*機關設定*/
/*導覽列機關設定*/
const triggeritem = document.querySelector('.navbar-burger');
const navbarMenu = document.querySelector('.navbar-menu');
function turnon() {
  var x = document.getElementById("password");
  if (x.type === "password") {
    x.type = "text";
  } else {
    x.type = "password";
  }
}

triggeritem.addEventListener('click',()=>{
  navbarMenu.classList.toggle("is-active")
});
/*登入機關*/
function Login(){
  document.getElementById("login").addEventListener('click',function(){
new swal({
  title: 'Login Form',
  html: `<form method="POST" required>`+`<input type="text" id="login" class="swal2-input" placeholder="Username">
  <input type="password" id="password" class="swal2-input" placeholder="Password">`+`<button class="swal2-input">`+`<p>Forget Password?</p>`+`</button>`+`</form>`+`<button class="swal2-input" onClick="turnon()">`+`<i class="far fa-eye">`+`</i>`+`</button>`+`<div>`+`<button class="swal2-input" onclick="ongoogle()">`+`<i class="fab fa-google">`+`</i>`+`</button>`+`<button class="swal2-input">`+`<i class="fab fa-facebook-square">`+`</i>`+`</button>`+`</div>`,
  confirmButtonText: 'Sign in',
  focusConfirm: false,
  preConfirm: () => {
    const login = Swal.getPopup().querySelector('#login').value
    const password = Swal.getPopup().querySelector('#password').value
    if (!login){Swal.showValidationMessage(`請你輸入電子郵件<br>Please enter email`)}
    if (!password){Swal.showValidationMessage(`請你輸入密碼<br>Please enter password`)}
    if (!login && !password) {
      Swal.showValidationMessage(`請你輸入電子郵件及密碼<br>Please enter login and password`)
    }
    return { login: login, password: password }
}})})}

function ResendPasswordConfirm(){
  Auth.resaendSignUp(currentUserName).then(result =>{
    Swal.fire('Confirmation code resend')
  }).catch(err =>{
    displayObject(err)
  })
}
/*外部資源連結*/
$.ajax({
url:'' ,
success: function(res){}
})

/*Vue設定*/
var vm1 = new Vue({
  el: ".app1",
  data:{
    items:[]
  },
  ready: function(){
    $.ajax({
      url: url.image
    })
  }
})

$(window).scroll(function(e){
  if ($(window).scrollTop()>=240 && $(window).scrollTop() !=0)
     $("button.button.is-link.modal-button").removeClass("hidden");
  else
     $("button.button.is-link.modal-button").addClass("hidden");
});

$("button.button.is-link.modal-button").click(function(){
   
})

function Register(){
  document.getElementById("register").addEventListener('click',function(){
new swal({
  title: 'Register Form',
  html: `<form method="POST" required>`+`<input type="text" id="login" class="swal2-input" placeholder="Username">
  <input type="password" id="password" class="swal2-input" placeholder="Password">
  <input type="password" id="password" class="swal2-input" placeholder="Password">`+
  `</form>`+`<button class="swal2-input" onclick="turnon()">`+`<i class="far fa-eye">`+`</i>`+`</button>`,
  confirmButtonText: 'Sign in',
  focusConfirm: false,
  preConfirm: () => {
    const regemail = Swal.getPopup().querySelector('#email').value;
    const reglogin = Swal.getPopup().querySelector('#login').value;
    const regpassword = Swal.getPopup().querySelector('#password').value;

    const login = Swal.getPopup().querySelector('#login').value
    const password = Swal.getPopup().querySelector('#password').value

    if (!login){Swal.showValidationMessage(`請你輸入電子郵件<br>Please enter email`)}
    if (!password){Swal.showValidationMessage(`請你輸入密碼<br>Please enter password`)}
    if (!login && !password) {
      Swal.showValidationMessage(`請你輸入電子郵件及密碼<br>Please enter login and password`)
    }

   /* else{
      Auth.signUp({
        username: reglogin,
        password: regpassword,
        attributes:{
          email: regemail
        }
      })
      /*.then((result: ISignUpResult) => {
       if(!result.userConfirmed){}
      })
    }*/
    return { login: login, password: password }
  }
}).then((result) => {
  //Swal.fire(`
  //  Login: ${result.value.login}
  //  Password: ${result.value.password}
  //`.trim())
})
})}

//function ongoogle(){
//    Auth.federatedSignIn({ provider: "Google" }).then(result => {
//    displayObject(result)
//  }).catch((err: any) => {
//    displayObject(err)
//  })
//}