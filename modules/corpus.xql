xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');
declare variable $titles as node()+ :=
$documents/descendant::tei:titleStmt/tei:title[not(@type)];
<div
    xmlns="http://www.w3.org/1999/xhtml"
    data-template="templates:surround"
    data-template-with="templates/page_woposs.html"
    data-template-at="content">
    <div
        style="width:100%">
         <h1>Corpus description</h1>
        <p>The WoPoss corpus spans from the 3rd century BCE to the 7th century CE. Texts are selected in terms of
        representativeness in order to track the variations in the uses of modal markers: the diversity of
        text types
        guarantees that any potential source of knowledge about (socio-)linguistic variation is covered. Thus, the corpus
        includes both literary and documentary texts taking into consideration the diverse sources of transmission of
        ancient texts –manuscripts, inscriptions and papyri–, in the various Latin-speaking regions of the ancient world.
        Different textual genres are also included: philosophical texts like <em>De Rerum Natura</em> by Lucretius, comedian
        pieces
        like <em>Poenulus</em> by Plautus or technical writing like the
        <em>Res rustica</em> by Columella.</p>

    <p>The setting-up of the corpus builds upon projects that provide open access materials (see the <a href="credits.php">credits page</a> for the list of projects with whom we have either informal or formal agreements). A full description of the annotated
        corpus will be provided soon.</p>
        <p>At the moment, this interface provides access to the following works:</p>
        <ul>
            {
                for $title in $titles
                let $author := $title/../tei:author[not(@role)]
                let $translator := $title/../tei:author[@role]
                order by $title
                return
                    <li>{$title/string()}
                        {
                            if ($author) then
                                ' by ' || $author
                            else
                                if ($translator) then
                                    ' translated by ' || $translator
                                else
                                    ()
                        }</li>
            }</ul>
    </div>

</div>