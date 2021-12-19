xquery version "3.1";

module namespace woposs="http://woposs.unine.ch";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare function woposs:locus($s as item()) as xs:string {
    $s/ancestor::tei:TEI/descendant::tei:title[@type eq 'short'] || ', ' || $s/ancestor::tei:div[@type eq 'chapter']/@n || ', ' || $s/@n
};

declare function woposs:prepareQuery($field as xs:string, $values as item()+) {
    let $query := if (count($values) gt 1) then
    $field || ':(' || string-join($values, ' OR ') || ')' else $field || ':' || $values
    return $query
};