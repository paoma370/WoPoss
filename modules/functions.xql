xquery version "3.1";

module namespace woposs = "http://woposs.unine.ch";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function woposs:locus($s as item()) as xs:string {
    $s/ancestor::tei:TEI/descendant::tei:title[@type eq 'short'] || ', ' || $s/ancestor::tei:div[@type eq 'chapter']/@n || ', ' || $s/@n
};

declare function woposs:prepareQuery($field as xs:string, $values as item()*) {
    let $del := ' OR ' || $field || ':'
    let $query := if (count($values) gt 1) then
        $field || ':' || string-join($values, $del)
    else
        $field || ':' || $values
    return
        $query
};


declare function woposs:filterParams($params as node()) as xs:string+ {
    let $queries := for $param in $params/field[value/node()]
    return
        woposs:prepareQuery($param/@name, $param/value[node()])
    return
        string-join($queries, ' AND ')
};

declare function woposs:getAuthorMetadata($id as xs:string+, $elementName as xs:string) as item()+ {
let $node := doc('/db/apps/woposs/aux/metadata.xml')//tei:person[@xml:id = $id] | doc('/db/apps/woposs/aux/metadata.xml')//tei:object[@xml:id = $id]
let $values := $node//descendant::*[name() = $elementName]/@value | $node//descendant::*[name() = $elementName]/text()
return
$values

};