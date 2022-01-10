function findAll() {
    var sitRadios = document.querySelectorAll('.includsRadio input');
    for (var i = 0; i < sitRadios.length; i++) {
        sitRadios[i].addEventListener('click', deselectCheck, false);
    }
}

function deselectCheck() {
    var sitChecks = document.getElementsByClassName(this.id);
    for (var i = 0; i < sitChecks.length; i++) {
        if (this.checked == true) {
            sitChecks[i].checked = false;
            /*document.getElementById('dynamic').checked = true;*/

        }
    }
}


window.addEventListener('load', findAll, false);