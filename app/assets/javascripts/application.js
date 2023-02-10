//= require chartkick
//= require Chart.bundle

  function open_nav(id) {
    var e = document.getElementById(id);
    e.classList.add('nav-veil-fadein');
    e.classList.remove('nav-veil-fadeout');
  }
  function close_nav(id) {
    var e = document.getElementById(id);
    e.classList.remove('nav-veil-fadein');
    e.classList.add('nav-veil-fadeout');
  }
  function unveil(id) {
    var e = document.getElementById(id);
    e.classList.add('veil-fadeout');
  }
  function remove_toast(id) {
    var e = document.getElementById(id);
    e.classList.remove('show');
  }