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

    var countDownDate = 1526392800000;

    function fix_len(num) {
        return num<10?'0'+num:num;
    }

    var x = setInterval(function(){
        var now = Date.now();
        var distance = countDownDate - now;
        if(distance < 0) {
            var endICODate = 1522260000000;
            distance = endICODate - now;
            var elem = document.getElementById('presaletext');
            elem.innerText = 'Token Sale Live!';

//          вызов функции отвечающей за заливку сайта на боевой сервер
        }

        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);


        $(dayNum).text(days);
        $(dayText).text(units(days, {nom: 'день', gen: 'дня', plu: 'дней'}));

        $(hourNum).text(fix_len(hours));
        $(hourText).text(units(hours, {nom: 'час', gen: 'часа', plu: 'часов'}));

        $(minNum).text(fix_len(minutes));
        $(minText).text(units(minutes, {nom: 'минута', gen: 'минуты', plu: 'минут'}));

        $(secNum).text(fix_len(seconds));
        $(secText).text(units(seconds, {nom: 'секунда', gen: 'секунды', plu: 'секунд'}));
        var bonusEndDate = null;
        var bonus = '';
        var bonusEnd1 = 1519689600000;
        var bonusEnd2 = 1520294400000;
        var bonusEnd3 = 1520899200000;
        var bonusEnd4 = 1521504000000;
        if(now<=bonusEnd1) {bonusEndDate = bonusEnd1; bonus = '20%'}
        if(now>bonusEnd1 && now<=bonusEnd2) {bonusEndDate = bonusEnd2; bonus = '15%'}
        if(now>bonusEnd2 && now<=bonusEnd3) {bonusEndDate = bonusEnd3; bonus = '10%'}
        if(now>bonusEnd3 && now<=bonusEnd4) {bonusEndDate = bonusEnd4; bonus = '5%'}
        var distanceBonus = bonusEndDate - now;
        var daysB = Math.floor(distanceBonus / (1000 * 60 * 60 * 24));
        var hoursB = Math.floor((distanceBonus % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutesB = Math.floor((distanceBonus % (1000 * 60 * 60)) / (1000 * 60));
        var secondsB = Math.floor((distanceBonus % (1000 * 60)) / 1000);
        $('#bonusp').text(bonus);
        $('#daysb').text(daysB);
        $('#hoursb').text(fix_len(hoursB));
        $('#minutesb').text(fix_len(minutesB));
        $('#secondsb').text(fix_len(secondsB));


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