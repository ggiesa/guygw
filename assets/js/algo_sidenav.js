
$(document).ready(function(){

  $("#sideNav").dblclick(function(){
    if ($(".sideNavOpen").length) {
      $(".sideNavOpen").css("width", "20px");
      $(".sideNavOpen").attr("class", "sideNavClosed");
      $("#main").css("marginLeft", "20px");
    } else {
      $(".sideNavClosed").css("width", "220px");
      $(".sideNavClosed").attr("class", "sideNavOpen");
      $("#main").css("marginLeft", "220px");
    }
  });

  // Prevent click events from propagating and hiding sideNav
  $("#sidenav .sideNavItemHome").click(function(e) {
    e.stopPropagation();
  });

  $("#sideNav .sideNavCategory").click(function(e) {
    e.stopPropagation();
  });

  $("#sideNav .sideNavItem").click(function(e) {
    e.stopPropagation();
  });

});
