xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $documents as document-node()+ := 
	collection('/db/apps/woposs/data');
declare variable $titles as node()+ := 
    $documents/descendant::tei:titleStmt/tei:title[not(@type)];    
<div xmlns="http://www.w3.org/1999/xhtml" data-template="templates:surround" data-template-with="templates/page_woposs.html" data-template-at="content">
 <div style="width:100%"><h1>About</h1>
 <h2>Corpus</h2>
 <p>At the moment, this interface provides access to the following works:</p>
 <ul>
 {
for $title in $titles
let $author:= doc('/db/apps/woposs/aux/metadata.xml')//tei:person[@xml:id = substring($title/ancestor::tei:TEI/descendant::tei:particDesc/descendant::tei:person/@corresp, 2)]/tei:persName
return
<li>{$title/string()} by {$author}</li>}</ul>
</div>

</div>