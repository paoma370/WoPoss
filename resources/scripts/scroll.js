/*Code taken from: https://github.com/bigspotteddog/ScrollToFixed*/

$(document).ready(function() {

    $('#aside').scrollToFixed({
        marginTop: 10,
        limit: function() {
            var limit = $('#limit').offset().top - $('#aside').outerHeight(true) - 10;
            return limit;
        }});
});

