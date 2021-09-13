const animateNavbar = () => {
  let navExpand = document.querySelectorAll(".nav__expand");
  let nav = document.querySelector(".nav");
  let navLink = document.querySelectorAll(".menu-link");
  let main = document.querySelector(".main");

  navExpand.forEach((expandBtn) => expandBtn.addEventListener("click", () => {
    nav.classList.toggle("nav-closed");
    main.classList.toggle("main-closed");
    navExpand.forEach((expandBtn) => expandBtn.classList.toggle("hide"));
  }));

  navLink.forEach((link) => link.addEventListener("click", listActive));

  function listActive() {
    navLink.forEach((link) => link.classList.remove("link-active"));
    console.log(this);
    this.classList.add("link-active");
  }
}

export { animateNavbar }
