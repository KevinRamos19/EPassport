function signup() {
  const email = document.getElementById('signup-email').value.trim();
  const password = document.getElementById('signup-password').value;
  const confirm = document.getElementById('signup-confirm').value;
  if (!email || !password || !confirm) {
    alert("Please fill in all fields.");
    return;
  }
  if (password !== confirm) {
    alert("Passwords do not match.");
    return;
  }
  alert("Sign up successful! (Demo only)");
  // Here you would send data to your server
}
function goToLogin() {
  window.location.href = "logindesign.html";
}