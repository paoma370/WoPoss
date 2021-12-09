xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare variable $documents as document-node()+ := 
	collection('/db/apps/woposs/data');
declare variable $marker := request:get-parameter("marker", ());
<tbody>
{ let $options := map { 
    "facets": map { 
        "marker": $marker
    }
}
    let $mk_fs := $documents//tei:fs[tei:f[@name eq 'lemma']/tei:symbol/@value eq $marker]
    (:let $mk_fs := $documents//tei:fs[@type eq 'marker'][ft:query(., (), $options)]:)
for $mk in $mk_fs
let $id := $mk/@xml:id
let $marker := string-join($mk/ancestor::tei:TEI/descendant::tei:seg[substring(@ana, 2) eq $id], ' ')
let $s := $mk/ancestor::tei:TEI/descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $id]]
let $locus := $s/ancestor::tei:TEI/descendant::tei:title[@type eq 'short'] || ', ' || $s/ancestor::tei:div[@type eq 'chapter']/@n ||', '|| $s/@n
let $relation := $mk/following-sibling::tei:fs[@type eq 'relation'][tei:f[@name eq 'marker'][@fVal eq $id]]
let $mods := distinct-values($relation/tei:f[@name eq 'type']/tei:symbol/@value)
for $mod in $mods
let $modality := distinct-values($relation[tei:f[@name eq 'type']/tei:symbol[@value eq $mod]]/tei:f[@name eq 'modality']/tei:symbol/@value)
let $other := distinct-values($relation[tei:f[@name eq 'type']/tei:symbol[@value eq $mod]]/tei:f[@name eq 'meaning']/tei:symbol/@value)
let $type := if (count($other) gt 0) then $other || ', ' || $mod else $mod
let $amb := if (count($mods) gt 1) then 'yes' else 'no'
return
  <tr><td1>{$s}</td1> <td>{$marker}</td><td>{$modality}</td><td>{$type}</td><td>{$amb}</td><td>{$locus}</td></tr>}
</tbody>