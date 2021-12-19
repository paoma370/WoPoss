xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace woposs="http://woposs.unine.ch" at "functions.xql";

declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');
declare variable $marker := request:get-parameter("marker","debeo");
declare function local:get-seg($fs as item(), $id as xs:string) as item()+ {
    let $query := "ana:" || $id
    let $segs := $fs/ancestor::tei:TEI/descendant::tei:seg[ft:query(., $query)]
    return
    $segs
};

declare function local:not-pertinent($fs as node()) as item()+ {
     let $id := $fs/@xml:id
        let $segs := local:get-seg($fs, $id)
        let $marker := string-join($segs, ' ')
        let $s := $segs/ancestor::tei:s
        let $locus := woposs:locus($s)
       
    let $modality := if ($fs/tei:f[@name eq 'modal']/tei:binary/@value eq 'true') then 'not pertinent, modal'
        else 'not pertinent, not modal'
    let $type := if ($fs/tei:f[@name eq 'diachrony']) then $fs/tei:f[@name eq 'diachrony']/tei:symbol/@value/string() else '--'
    return 
        <tr><td1 ref="{$id}">{$s}</td1>
                <td>{$marker}</td><td>{$modality}</td><td>{$type}</td><td>--</td><td>{$locus}</td></tr>
};

declare function local:pertinent($fs as node()) as item()+ {
        let $id := $fs/@xml:id
        let $segs := local:get-seg($fs, $id)
        let $marker := string-join($segs, ' ')
        let $s := $segs/ancestor::tei:s
        let $locus := woposs:locus($s)
        let $relation_query := "markerId:" || $id
        let $relation := $documents/descendant::tei:fs[ft:query(., $relation_query)]
        let $mods := distinct-values($relation/tei:f[@name eq 'type']/tei:symbol/@value)
        for $mod in $mods
        let $modality := distinct-values($relation[tei:f[@name eq 'type']/tei:symbol[@value eq $mod]]/tei:f[@name eq 'modality']/tei:symbol/@value)
        let $other := distinct-values($relation[tei:f[@name eq 'type']/tei:symbol[@value eq $mod]]/tei:f[@name eq 'meaning']/tei:symbol/@value)
        let $type := if (count($other) gt 0) then
            $other || ', ' || $mod
        else
            $mod
        let $amb := if (count($mods) gt 1) then
            'yes'
        else
            'no'
            return 
                <tr><td1 ref="{$id}">{$s}</td1>
                <td>{$marker}</td><td>{$modality}</td><td>{$type}</td><td>{$amb}</td><td>{$locus}</td></tr>
    
};
<tbody>{
    let $query:= "lemma:" || $marker
        let $mk_fs := $documents//tei:fs[ft:query(., $query)]
        for $mk in $mk_fs
        let $output:= if ($mk[ft:query(., "pertinence:false")]) then local:not-pertinent($mk) else local:pertinent($mk)
        return
            $output
    }
</tbody>