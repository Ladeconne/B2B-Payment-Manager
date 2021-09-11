const animateNavbar = () => {
  let navExpand = document.querySelectorAll(".nav__expand");
  let nav = document.querySelector(".nav");
  let navListItem = document.querySelectorAll(".nav__listitem");
  let main = document.querySelector(".main");

  navExpand.forEach((expandBtn) => expandBtn.addEventListener("click", () => {
    nav.classList.toggle("nav-closed");
    main.classList.toggle("main-closed");
    navExpand.forEach((expandBtn) => expandBtn.classList.toggle("hide"));
  }));

  navListItem.forEach((link) => link.addEventListener("click", listActive));

  function listActive() {
    navListItem.forEach((link) => link.classList.remove("nav__listitem-active"));
    this.classList.add("nav__listitem-active");
  }
}

export { animateNavbar }
