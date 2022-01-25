xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace woposs="http://woposs.unine.ch" at "../functions.xql";

(: convenience variable to hold the dataset :)
declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');
declare variable $doc := $documents/descendant::tei:TEI[@xml:id eq 'luke'];
woposs:getWorkMetadata('john', 'transmission')
