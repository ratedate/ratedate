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

    var countDownDate = 1519480800000;

    var x = setInterval(function(){
        var now = Date.now();
        var distance = countDownDate - now;
        if(distance < 0) {
            var endICODate = 1522260000000;
            distance = endICODate - now;
            var elem = document.getElementById('presaletext');
            elem.innerText = 'Token Sale Live!';

            var bonusEndDate = null;
            var bonus = '';
            var bonusEnd1 = 1519689599000;
            var bonusEnd2 = 1520294399000;
            var bonusEnd3 = 1520899199000;
            var bonusEnd4 = 1521503999000;
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
            $('#hoursb').text(hoursB);
            $('#minutesb').text(minutesB);
            $('#bonus-timer').show();
//          вызов функции отвечающей за заливку сайта на боевой сервер
        }

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