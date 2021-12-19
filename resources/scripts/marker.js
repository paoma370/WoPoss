function getMarker() {
    var markers = document.getElementsByClassName('marker');
    for (var i = 0; i < markers.length; i++) {
        markers[i].addEventListener('click', showAnalysis, false);
    }
}

function showAnalysis() {
    hideAnalysis();
    var idno = this.dataset.idno;
    var divAna = document.getElementById(idno);
    divAna.classList.add('show');
}

function hideAnalysis() {
    var analysis = document.getElementsByClassName('hide');
    for (var i = 0; i < analysis.length; i++) {
        analysis[i].classList.remove('show');
    }
}


window.addEventListener('load', getMarker, false);