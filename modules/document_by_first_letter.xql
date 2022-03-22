xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $documents as document-node()+ := 
	collection('/db/apps/woposs/data');
declare variable $initial as xs:string := 
	request:get-parameter('initial', 'A');
declare variable $hits as document-node()* := 
    $documents[descendant::tei:titleStmt/tei:title[starts-with(., $initial)]];
$hits/descendant::tei:titleStmt/tei:title ! string()