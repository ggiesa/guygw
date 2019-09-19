/* Set the width of the side navigation to 250px and the left margin of the page content to 250px */
function openNav() {
  sideBar = document.getElementById("sideNavClosed");
  sideBar.style.width = "220px";
  sideBar.id = "sideNavOpen";
  document.getElementById("main").style.marginLeft = "220px";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0 */
function closeNav() {
  sideBar = document.getElementById("sideNavOpen");
  sideBar.style.width = "20px";
  sideBar.id = "sideNavClosed";
  document.getElementById("main").style.marginLeft = "20px";
}

function toggleNav() {
  let nav = document.getElementById("sideNavOpen");
  if (nav === null) {
    openNav()
  } else {
    closeNav()
  }
}
