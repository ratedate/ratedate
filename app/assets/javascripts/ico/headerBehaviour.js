//= require underscore
(function($) {

    var mLastScrollValue = -1;
    var mScrollElement = null;
    var $header = null;
    var $mobileMenu = null;
    var mScrollHandler = null;

    function getScrollHandler() {
        return _.throttle(function() {
            // closeMenu();

            var isMovingDown = mScrollElement.scrollTop > mLastScrollValue;
            var moreThanQuarter = mScrollElement.scrollTop >= window.innerHeight * .25;

            if (isMovingDown) {
                (moreThanQuarter && $header.addClass('hidden with-shadow'));
            } else {
                ($header.hasClass('hidden') && $header.removeClass('hidden'));
                (!moreThanQuarter && $header.hasClass('with-shadow') && $header.removeClass('with-shadow'));
            }

            mLastScrollValue = mScrollElement.scrollTop;
        }, 100);
    }

    function openMenu() {
        $mobileMenu.addClass('show');
    }

    function closeMenu() {
        if ($mobileMenu.hasClass('show')) {
            $mobileMenu.removeClass('show');
        }
    }

    function init() {

        $header = $(this);
        $mobileMenu = $(this).find('.header-controls');

        $header.find('.menu-btn').on('click', openMenu);
        $header.find('.menu-close-btn').on('click', closeMenu);

        if (!document.scrollingElement) {
            return;
        }

        mScrollElement = document.scrollingElement;
        mLastScrollValue = mScrollElement.scrollTop;
        mScrollHandler = getScrollHandler();

        $(window).on('scroll', mScrollHandler);
    }

    $.fn.headerBehaviour = init;

}(jQuery));