function find() {
    var inputs = document.querySelectorAll('[name="modality"]');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('click', Select, false);
}}

function Select() {
    var selections = document.getElementsByClassName(this.id);
    for (var i = 0; i < selections.length; i++) {
        if (this.checked == true) {
        selections[i].checked = true;
} else {
    selections[i].checked = false;
}}
}

window.addEventListener('load', find, false);