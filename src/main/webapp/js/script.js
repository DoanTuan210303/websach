let navMenu = document.querySelector('.header__menu-container');
let navUser = document.querySelector('.header__user-container');
let menuButton = document.querySelector('#menu-btn');
function showMenu() {
  navMenu.classList.add('active');
  navUser.classList.add('active');
}
function hideMenu() {
  navMenu.classList.remove('active');
  navUser.classList.remove('active');
}
function handleResize() {
  if (window.innerWidth > 0) {
    showMenu();
  } else {
    hideMenu();
  }
}
menuButton.addEventListener('click', function () {
  navMenu.classList.toggle('active');
  navUser.classList.toggle('active');
});
window.addEventListener('resize', handleResize);
handleResize();
// slider
$(document).ready(function() {
  $('.content__slider-container').slick({
    slidesToShow: 6,
    infinite: true,
    arrows: false,
    autoplay: true,
    autoplaySpeed: 4000,
    dots: true
  });
});
// filter
const toggleButton = document.querySelector('.filter-toggle-button');
const contentFilter = document.querySelector('.content-filter');
const ul = document.querySelector('ul');

toggleButton.addEventListener('click', function() {
  contentFilter.classList.toggle('closed');
  // toggleButton.classList.toggle('open');
  ul.classList.toggle('display');
});
// cash
const paymentCashRadio = $("#payment-cash");
const phoneInput = $(".content-pay__info-phone input");
const addressInput = $(".content-pay__info-address input");

paymentCashRadio.on("change", function () {
  if (paymentCashRadio.is(":checked")) {
    phoneInput.prop("disabled", false);
    addressInput.prop("disabled", false);
  } else {
    phoneInput.prop("disabled", true);
    addressInput.prop("disabled", true);
  }
});