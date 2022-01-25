xquery version "3.1";

module namespace woposs = "http://woposs.unine.ch";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare variable $woposs:metadataFile := doc('/db/apps/woposs/aux/metadata.xml');

declare function woposs:getAuthorMetadata($id as xs:string, $elementName as xs:string) as item()* {
    let $node := $woposs:metadataFile//tei:person[@xml:id = $id] | $woposs:metadataFile//tei:object[@xml:id = $id]
    let $values := $node/descendant::*[name() = $elementName]/@value/string() | $node/descendant::*[name() = $elementName]/text()
    return
        $values

};

declare function woposs:getCentury($id as xs:string) as item() {
    let $node := $woposs:metadataFile/descendant::tei:bibl[@xml:id = $id]
    let $value := $node/descendant::tei:date[@type eq 'century']/@when-custom/string()
    return
        $value

};

declare function woposs:getWorkMetadata($id as xs:string, $indexName as xs:string) as item()* {
    let $node := $woposs:metadataFile/descendant::tei:bibl[@xml:id = $id]
    let $values := $node/descendant::tei:index[@indexName eq $indexName]/tei:term/@cRef
    for $value in $values
    return
        substring($value, 2)

};
declare function woposs:getModalMeaning($doc as node(), $id as xs:string) as item()*  {
    let $fs := $doc/descendant::tei:fs[tei:f[@name eq 'marker']/@fVal eq $id]
    return
        $fs/tei:f[@name eq 'modality']/tei:symbol/@value/string()

};

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

declare function woposs:simpleFilter($nodes as node()*, $params as node()) as node()* {
    let $query := woposs:filterParams($params)
    return
        $nodes[ft:query(., $query)]
};

