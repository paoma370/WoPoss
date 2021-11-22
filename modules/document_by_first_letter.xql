xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $stories as document-node()+ := 
	collection('/db/apps/woposs/data');
declare variable $initial as xs:string := 
	request:get-parameter('initial', 'G');
declare variable $hits as document-node()* := 
    $stories[descendant::tei:titleStmt/tei:title[starts-with(., $initial)]];
$hits/descendant::tei:titleStmt/tei:title ! string()