// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require profiles
//= require jquery.Jcrop
// require_tree .

$(document).ready(function(){
//   variables
    var dayNum = "#tDayNum";
    var dayText = "#tDayText";

    var hourNum = "#tHourNum";
    var hourText = "#tHourText";

    var minNum = "#tMinNum";
    var minText = "#tMinText";

    var secNum = "#tSecNum";
    var secText = "#tSecText";
//   variables

    var countDownDate = new Date("2018-01-15T14:00:00+00:00").getTime();

    var x = setInterval(function(){
        var now = Date.now();
        var distance = countDownDate - now;

        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        $(dayNum).text(days);
        $(dayText).text(units(days, {nom: 'день', gen: 'дня', plu: 'дней'}));

        $(hourNum).text(hours);
        $(hourText).text(units(hours, {nom: 'час', gen: 'часа', plu: 'часов'}));

        $(minNum).text(minutes);
        $(minText).text(units(minutes, {nom: 'минута', gen: 'минуты', plu: 'минут'}));

        $(secNum).text(seconds);
        $(secText).text(units(seconds, {nom: 'секунда', gen: 'секунды', plu: 'секунд'}));

        if(distance < 0) {
            clearInterval(x);
//          вызов функции отвечающей за заливку сайта на боевой сервер
        }
    }, 1000);

    function units(num, cases) {
        num = Math.abs(num);

        var word = '';

        if (num.toString().indexOf('.') > -1) {
            word = cases.gen;
        } else {
            word = (
                num % 10 == 1 && num % 100 != 11
                    ? cases.nom
                    : num % 10 >= 2 && num % 10 <= 4 && (num % 100 < 10 || num % 100 >= 20)
                        ? cases.gen
                        : cases.plu
            );
        }
        return word;
    }
});