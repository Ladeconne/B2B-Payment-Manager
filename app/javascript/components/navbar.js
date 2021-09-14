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


  // Init of Pickr
  const pickr = Pickr.create({
    el: '.color-picker',
    theme: 'nano', // or 'monolith', or 'nano'
    closeWithKey: 'Escape',
    default: "#167FFB",
    components: {

        // Main components
        hue: true,

        // Input / output Options
        interaction: {
            hex: true,
            rgba: true,
            input: true,
            save: true
        }

    }
  });

  pickr.on('save', (color, instance) => {
      console.log('Event: "save"', color, instance);
  }).on('change', (color, source, instance) => {
      console.log('Event: "change"', color, source, instance);
  })

}

export { animateNavbar }
