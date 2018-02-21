require('./style/style.scss');
require('./scripts/headerBehaviour');
require('velocity-animate');

$(document).ready(function() {
    $('header').headerBehaviour();

    $('.btn-link.trigger').on('click', function() {
        $(this).toggleClass('active')
    });

    

    $('.anchor').on('click', function(event) {
        var anchorTo = $(this).data('anchorTo');
        var $container = $('#' + anchorTo);
        $container.velocity('scroll', { duration: 600, easing: 'linear' });
        event.preventDefault();
    });

    var ScrollSpy = require('scrollspy-js');
    var spy = new ScrollSpy('.scrollspy', {
        nav: '.menu.nav-links > li > a',
        className: 'active'
    });
});