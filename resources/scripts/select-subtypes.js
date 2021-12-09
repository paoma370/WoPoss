function findInputs() {
    var checkboxes = document.querySelectorAll('.modalMeaning input:not(.nec-sit,.poss-sit,.sit)');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener('click', checkParent, false);
}}

function checkParent() {
    var parents = document.getElementsByClassName(this.id);
    for (var i = 0; i < parents.length; i++) {
        if (this.checked == true) {
        parents[i].checked = true;
}}
}

window.addEventListener('load', findInputs, false);