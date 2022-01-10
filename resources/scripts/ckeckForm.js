$(document).ready(function () { $('#checkBtn').click(function()
        { checked = $("input[name=modality]:checked").length; if(!checked) 
        { alert("At least one type of modality must be selected"); return false; } }); });