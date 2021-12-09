xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare function local:dispatch($node as node()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(td1) return local:s($node)
        case element(tr) return local:tr($node)
        case element(td) return local:td($node)
        case element(tei:supplied) return local:supplied($node)
        case element(tei:seg) return local:seg($node)
        default return local:passthru($node)
};

declare function local:passthru($node as node()) as item()* {
    for $child in $node/node() return local:dispatch($child)
};

declare function local:tr($nodes) {
    <tr>{for $node in $nodes return local:passthru($node)}</tr>
};

declare function local:td($node as element(td)) as element(td) {
  <td>{local:passthru($node)}</td>  
};

declare function local:seg($node as element(tei:seg)) as element(span) {
    <span class="{$node/@function}">{local:passthru($node)}</span>};
    

declare function local:supplied($node as element(tei:supplied)) as element(span) {
    <span class="supplied">[{local:passthru($node)}]</span>};
    
declare function local:s($node as node()) as item()* {
     for $s in $node return <td>{local:passthru($s)}</td>};

request:set-attribute('html', local:dispatch(request:get-data()))