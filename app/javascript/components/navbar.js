import Pickr from '@simonwep/pickr';

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

  if (document.querySelector(".color-picker")){
    let initColor = `${window.getComputedStyle(document.documentElement).getPropertyValue('--primary-color')}`
    initColor = initColor.substring(1);
    // Init of Pickr
    const pickr = Pickr.create({
      el: '.color-picker',
      theme: 'nano', // or 'monolith', or 'nano'
      closeWithKey: 'Escape',
      default: initColor,
      components: {

          // Main components
          hue: true,

          // Input / output Options
          interaction: {
              hex: true,
              input: true,
              save: true
          }

      }
    });

    pickr.on('save', (color, instance) => {
      // Write in the database

      pickr.hide();
    })
    pickr.on('change', (color, source, instance) => {
      document.documentElement.style.setProperty("--primary-color", `${color.toHEXA().toString()}`);
    })

  }
}
export { animateNavbar }
