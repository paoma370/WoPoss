xquery version "3.1";
<div xmlns="http://www.w3.org/1999/xhtml" data-template="templates:surround" data-template-with="templates/page_woposs.html" data-template-at="content">
<div>
  <table id="resultsTable" data-toggle="table"    data-show-pagination-switch="true"
  data-search="true"
  data-show-columns="true" data-pagination="true" data-sortable="true"
    data-show-export="true">
        <thead>
    <tr><th data-sortable="true">Passage</th> <th  data-sortable="true">Marker</th> <th  data-sortable="true">Modal meaning</th> <th  data-sortable="true">Type</th>  <th  data-sortable="true">Ambiguous</th> <th  data-sortable="true">Work</th></tr></thead>
    <tbody>{request:get-attribute('html')}</tbody>
</table>
</div>
</div>