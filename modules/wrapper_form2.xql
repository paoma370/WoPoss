xquery version "3.1";
<div
    xmlns="http://www.w3.org/1999/xhtml"
    data-template="templates:surround"
    data-template-with="templates/page_woposs.html"
    data-template-at="content">
    <div>
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
            data-click-to-select="true">
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
                        data-sortable="true" data-visible="false">Additional <br/>analysis</th>
                    <th
                        data-sortable="true">Work</th></tr></thead>
            <tbody>{request:get-attribute('html')}</tbody>
        </table>
    </div>
</div>
