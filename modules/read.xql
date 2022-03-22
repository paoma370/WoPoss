xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare variable $documents as document-node()+ := 
	collection('/db/apps/woposs/data');
declare variable $document_id as xs:string := 
	request:get-parameter('document', 'marcus_la', false());
declare variable $document_filename as xs:string: = concat($document_id, '.xml');
declare variable $document as document-node()? := 
	$documents[ends-with(base-uri(), $document_filename)];
	
if ($document) then
       <TEI>{
        $document//(titleStmt/title | text)
    }</TEI>
else
    <error xmlns="">{concat('No such document:', $document_id)}</error>