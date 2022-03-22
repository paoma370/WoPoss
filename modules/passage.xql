xquery version "3.1";
import module namespace config = "https://woposs.unine.ch/apps/woposs/config" at "config.xqm";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');
let $marker := request:get-parameter("marker", "u_q11048")
let $xsl := doc(concat($config:app-root, "/resources/xslt/reading-view.xsl"))
let $params := <parameters>
    <param
        name="id"
        value="{$marker}"/>
</parameters>
let $query := "id:" || $marker
let $xml := $documents//tei:TEI[descendant::tei:fs[ft:query(., $query)]]
let $output := transform:transform($xml, $xsl, $params)
return
    request:set-attribute('html', $output)