require('./styles/style.scss');

require('select2');
require('slick-carousel');
require('./scripts/vendor/fullpage');


var wNumb = require('wnumb');
var noUiSlider = require('nouislider');
var $navLinks = null;

$(document).ready(function() {

    var galleryConfig = {
        arrows: false,
        dots: true,
        dotsClass: 'controls',
        responsive: [
            {
                breakpoint: 9999,
                settings: "unslick"
            },
            {
                breakpoint: 1136,
                settings: {
                    slidesToShow: 3,
                    slidesToScroll: 3
                }
            }
        ]
    };

    var giftsConfig = {
        arrows: false,
        dots: true,
        dotsClass: 'controls',
        responsive: [
            {
                breakpoint: 9999,
                settings: "unslick"
            },
            {
                breakpoint: 620,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1
                }
            }
        ]
    };

    $('#profile-gallery').slick(galleryConfig);
    $('#gifts-gallery').slick(giftsConfig);

    $(window).on('resize orientationchange', function() {
        if (document.body.clientWidth < 1136 && !$('#profile-gallery.slick-initialized').length) {
            $('#profile-gallery').slick(galleryConfig);
        }
        if (document.body.clientWidth < 620 && !$('#gifts-gallery.slick-initialized').length) {
            $('#gifts-gallery').slick(giftsConfig);
        }
    });

    $('select').select2({
        // theme: 'custom'
    });

    $('.range').each(function() {
        var self = this;
        var slider = noUiSlider.create(this, {
            start: [18, 45],
            tooltips: true,
            step: 1,
            format: wNumb({
                decimals: 0
            }),
            range: {
                min: 18,
                max: 60
            }
        });
        slider.on('update', function(values) {
            $(self).find('input.range-from').val(values[0]);
            $(self).find('input.range-to').val(values[1]);
        })
    });

    //SHOW HIDE MODAL
    $('#policy').on('click', function() {
        $('.modal').addClass('show');
    });

    $('.modal-close').on('click', function() {
        $('.modal').removeClass('show');
    });

    //SHOW HIDE MOBILE CHAT
    $('.chat-person').on('click', function() {
        $('.chat-page').addClass('show-chat');
    });

    $('.to-chats').on('click', function() {
        $('.chat-page').removeClass('show-chat');
    });

    //SHOW/HIDE USER MENU
    $('.user-menu').on('click', function() {
        $('.right-nav').toggleClass('show');
    });

    $('#side-menu-open').on('click', function() {
        $('.navs').toggleClass('show');
    });
    $('#close-user-menu').on('click', function() {
        $('.navs').removeClass('show');
    });

    //SHOW/HIDE PROFILES FILTERS
    $('#show-filters').on('click', function() {
        $('#filters-form').addClass('show');
    });

    $('#hide-filters').on('click', function() {
        $('#filters-form').removeClass('show');
    })
    
    //FULLPAGE CONFIG
    $('#fullpage').fullpage({
        scrollingSpeed: 800,
        // navigation: 'true',
        navigationPosition: 'right',
		easingcss3: 'ease-out',
        menu: '.nav-dots',
        anchors: ['section-1', 'section-2', 'section-3', 'section-4', 'section-5', 'foot-section'],
        onLeave: handleFullpageOnLeave
    });

    //TOGGLE SIDE FORM
    $('#show-menu').on('click', function() {
        $('.side-form').addClass('show');
        $.fn.fullpage.setAllowScrolling(false);
    });

    $('#hide-menu').on('click', function() {
        $('.side-form').removeClass('show');
        $.fn.fullpage.setAllowScrolling(true);
    });

    //DISABLE SCROLLING WHILE HOVER OVER SIDE FORM
    $('.side-form').hover(function() {
        $.fn.fullpage.setAllowScrolling(false);
    }, function() {
        $.fn.fullpage.setAllowScrolling(true);
    });

    //TRIGGERING LOG IN/SIGN UP
    $('.trigger .left').on('click', function() {
        $(this).parent().removeClass('active');
    });

    $('.trigger .right').on('click', function() {
        $(this).parent().addClass('active');
    });
});



function handleFullpageOnLeave(index, nextIndex, direction) {
    if (nextIndex > 2) {
        return;
    }

    //SHOW/HIDE EXTRA TEXT
    if (nextIndex == 2) {
        $textBlock = $('.happiness');
        $textBlock && $textBlock.removeClass('to-first').addClass('to-second');
        $textBlock && $textBlock.find('.hidden-text').removeClass('hide').addClass('show');
    } else if (nextIndex == 1) {
        $textBlock = $('.happiness');
        $textBlock && $textBlock.removeClass('to-second').addClass('to-first');
        $textBlock && $textBlock.find('.hidden-text').removeClass('show').addClass('hide');
    }
}

function initSlick($container, config) {
    
}