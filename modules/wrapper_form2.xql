xquery version "3.1";
<div
    xmlns="http://www.w3.org/1999/xhtml"
    data-template="templates:surround"
    data-template-with="templates/page_woposs.html"
    data-template-at="content">
    <div>
    <p><span
                style="color:red;font-weight:bold">Important</span>:</p>
                <ul>
                <li>In the table options (right upper corner) you can filter the rows by content (search field), you can toggle the columns (not all columns are visible by default) and you can export the 
                results (CSV).</li>
                
                <li>Click on the fist cell (the passage) to read more context and get the full analysis of the passage.</li>
                    <li>Implicit contents appear in italic and in a smaller font</li>
                </ul>
 
        <table
            id="resultsTable"
            data-show-export="true"
            data-pagination="true"
            data-toggle="table"
            data-show-pagination-switch="true"
            data-search="true"
            data-show-columns="true"
            data-sortable="true"
            data-export-types="csv"
            data-click-to-select="true"
            data-query-params="queryParams">
            <thead>
                <tr><th
                        data-sortable="true">Passage</th>
                    <th
                        data-sortable="true">Marker <br/> (form)</th>
                    <th
                        data-sortable="true">Marker <br/> (lemma)</th>
                    <th
                        data-sortable="true">Modal <br/> meaning</th>
                    <th
                        data-sortable="true">Type</th>
                    <th
                        data-sortable="true">Subtype /<br/>Degree</th>
                    <th
                        data-sortable="true"
                        data-visible="false">Additional <br/>analysis</th>
                  
                    <th
                        data-sortable="true">Ambiguous <br/>reading</th>
              <!--        <th data-sortable="true"
                        data-visible="false">Scope</th>
                    <th data-sortable="true"
                        data-visible="false">Main verb</th>
                    <th data-sortable="true"
                        data-visible="false">Voice of main verb</th> -->
                    <th
                        data-sortable="true"
                        data-visible="true">SoA</th>
                    <th data-sortable="true"
                        data-visible="false">SoA: control</th>
                    <th data-sortable="true"
                        data-visible="false">SoA: dynamicity</th>
                    <th data-sortable="true"
                        data-visible="false">SoA: participant</th>
                    <th
                        data-sortable="true">Work</th></tr></thead>
            <tbody>{request:get-attribute('html')}</tbody>
        </table>

        <script><![CDATA[
  var $table = $('#resultsTable')

  $(function() {
    $table.bootstrapTable()
  })

  function queryParams(params) {
    var options = $table.bootstrapTable('getOptions')
    if (!options.pagination) {
      params.limit = options.totalRows
    }
    return params

}]]></script>

    </div>
</div>
