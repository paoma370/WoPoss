function getMarker() {
    var markers = document.getElementsByClassName('seg');
    for (var i = 0; i < markers.length; i++) {
        markers[i].addEventListener('click', showAnalysis, false);
    }
}

function showAnalysis() {
    hideAnalysis();
    var idnoContents = this.dataset.idno;
    var idno = idnoContents.split(" ");
    for (var i = 0; i < idno.length; i++) {
        var identifier = idno[i];
        var divAna = document.getElementById(identifier);
        divAna.classList.add('show');
    }
}

function hideAnalysis() {
    var analysis = document.getElementsByClassName('hide');
    for (var i = 0; i < analysis.length; i++) {
        analysis[i].classList.remove('show');
    }
}


window.addEventListener('load', getMarker, false);