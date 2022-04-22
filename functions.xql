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
declare function woposs:getModalMeaning($doc as node(), $id as xs:string, $f as xs:string) as item()+ {
    let $fs := $doc/descendant::tei:fs[tei:f[@name eq 'marker']/@fVal eq $id]
    let $values := if ($fs/tei:f[@name eq $f]) then
        $fs/tei:f[@name eq $f]/tei:symbol/@value/string()
    else
        $f || '-false'
    return
        $values

};

declare function woposs:getLemma($fs as node()) as xs:string+ {
    let $doc := $fs/ancestor::tei:TEI
    let $markerId := $fs/tei:f[@name eq 'marker']/@fVal
    let $marker := $doc/id($markerId)
    return
        $marker/tei:f[@name eq 'lemma']/tei:symbol/@value
};

declare function woposs:isAmbiguous($doc as node(), $id as xs:string, $type as xs:string) as item() {
   if ($type eq 'marker') then (if ($doc/descendant::tei:fs[tei:f[@name eq 'marker']/@fVal eq $id])
    then
        (let $relations := $doc/descendant::tei:fs[tei:f[@name eq 'marker']/@fVal eq $id]
        let $scopes := $relations/tei:f[@name eq 'scope']/@fVal
        let $value := if (count($relations) gt count(distinct-values($scopes)) or $relations/tei:f[@name eq 'ambiguity']) then
            'true'
        else
            'false'
        return
            $value
        )
    else
        'not-relevant')
        else 
        let $relation := $doc/descendant::tei:fs[@xml:id eq $id]
        let $marker := $relation/tei:f[@name eq 'marker']/@fVal
        let $scope := $relation/tei:f[@name eq 'scope']/@fVal
        let $evaluation := $doc/descendant::tei:fs[tei:f[@name eq 'marker']/@fVal eq $marker][tei:f[@name eq 'scope']/@fVal eq $scope]
        let $value := if (count($evaluation) gt 1 or $relation/tei:f[@name eq 'ambiguity']) then 'true' else 'false'
        return $value

};

(: review cardinalities here!!!!! :)

declare function woposs:locus($s as item()?) as xs:string? {
    let $title := $s/ancestor::tei:TEI/descendant::tei:title[@type eq 'short']
    let $division := if ($s/ancestor::tei:div/@n) then (', ' || $s/ancestor::tei:div/@n) else ''
    let $locus := if ($s/@rend) then ($title || $division || ', ' || $s/@rend) else $title || $division 
    return $locus
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
        $nodes[ft:query-field(., $query)]
};




declare function woposs:lemma($doc as node(), $id as xs:string) as xs:string {
    let $lemma := $doc/id($id)/tei:f[@name eq 'lemma']/tei:symbol/@value/string()
    let $correctedLemma := if (contains($lemma, '_inf')) then
        replace($lemma, '_inf', '+ inf.')
    else
        replace($lemma, '_', ' ')
    return
        $correctedLemma
};

declare function woposs:getSegs($fs as item()?, $id as xs:string?) as item()* {
    let $query := "ana:" || $id
    let $segs := $fs/ancestor::tei:TEI/descendant::tei:seg[ft:query-field(., $query)]
    return
        $segs
};

