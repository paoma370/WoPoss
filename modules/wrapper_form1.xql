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
                    
                <li>In the table options (right upper corner) you can filter the rows by content (search field), you can toggle the columns (not all columns are visible by default) and you can export the results (CSV).</li>
                <li>Click in the fist cell (the passage) to read more context and get the full analysis of the passage.</li>
                    <li>Implicit contents appear in italic and in a smaller font</li>
                </ul>
        <table
            id="resultsTable"
            data-show-export="true"
            data-toggle="table"
            data-show-pagination-switch="true"
            data-search="true"
            data-show-columns="true"
            data-pagination="true"
            data-sortable="true"
            data-export-types="csv"
            data-click-to-select="true"
        >
            <thead>
                <tr><th
                        data-sortable="true">Passage</th>
                    <th
                        data-sortable="true">Marker</th>
                    <th
                        data-sortable="true">Modal meaning</th>
                    <th
                        data-sortable="true">Type</th>
                    
                    <th
                        data-sortable="true"
                        data-visible="false">Additional <br/> information</th>
                    <th
                        data-sortable="true"
                        data-visible="true">SoA</th>
                    <th
                        data-sortable="true">Ambiguous <br/> reading</th>
                    <th
                        data-sortable="true">Work</th></tr></thead>
            <tbody>{request:get-attribute('html')}</tbody>
        </table>
    </div>

</div>
