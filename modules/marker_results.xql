xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace woposs = "http://woposs.unine.ch" at "functions.xql";

declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');
declare variable $marker := request:get-parameter("marker", ());
declare variable $markerDesc := <fields>
    <field
        name="pertinence">
        {
            for $x in request:get-parameter("pertinence", ())
            return
                <value>{$x}</value>
        }
    
    </field>
    <field
        name="modalStatus">
        {
            for $x in request:get-parameter("modal", ())
            return
                <value>{$x}</value>
        }
    </field>
    <field
        name="diachrony">
        {
            for $x in request:get-parameter("diachrony", ())
            return
                <value>{$x}</value>
        }
    </field>
    <field
        name="markerUtterance">
        {
            for $x in request:get-parameter("marker-utterance", ())
            return
                <value>{$x}</value>
        }
    </field>
    <field
        name="markerPolarity">
        {
            for $x in request:get-parameter("marker-polarity", ())
            return
                <value>{$x}</value>
        }
    </field>
</fields>;

declare variable $SoADesc := <fields>
    <field
        name="control">{
            for $x in request:get-parameter("control", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="dynamicity">{
            for $x in request:get-parameter("dynamic", ())
            return
                <value>{$x}</value>
        }</field>
    
    <field
        name="SoA"><value>{request:get-parameter("SoA", ())}</value>
    </field>
    <field
        name="scopeUtterance">
        {
            for $x in request:get-parameter("scope-utterance", ())
            return
                <value>{$x}</value>
        }
    </field>
    <field
        name="scopePolarity">
        {
            for $x in request:get-parameter("scope-polarity", ())
            return
                <value>{$x}</value>
        }
    </field>
    <field
        name="participant">{
            for $x in request:get-parameter("participant", ())
            return
                <value>{$x}</value>
        }
    </field>
    <field
        name="participantType">{
            for $x in request:get-parameter("participantType", ())
            return
                <value>{$x}</value>
        }
    </field>
</fields>;


declare variable $morphologicalFeaturesScope := <fields>
    <field
        name="Gender">{
            for $x in request:get-parameter("scope_Gender", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Case">{
            for $x in request:get-parameter("scope_Case", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Number">{
            for $x in request:get-parameter("scope_Number", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Person">{
            for $x in request:get-parameter("scope_Person", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="VerbForm">{
            for $x in request:get-parameter("scope_VerbForm", ())
            return
                <value>{$x}</value>
        }</field>
    
    <field
        name="Aspect">{
            for $x in request:get-parameter("scope_Aspect", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Mood">{
            for $x in request:get-parameter("scope_Mood", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Tense">{
            for $x in request:get-parameter("scope_Tense", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Voice">{
            for $x in request:get-parameter("scope_Voice", ())
            return
                <value>{$x}</value>
        }</field>
</fields>;

declare variable $morphologicalFeatures := <fields>
    <field
        name="Gender">{
            for $x in request:get-parameter("Gender", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Case">{
            for $x in request:get-parameter("Case", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Number">{
            for $x in request:get-parameter("Number", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Person">{
            for $x in request:get-parameter("Person", ())
            return
                <value>{$x}</value>
        }</field>
    
    <field
        name="Degree">{
            for $x in request:get-parameter("Degree", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="VerbForm">{
            for $x in request:get-parameter("VerbForm", ())
            return
                <value>{$x}</value>
        }</field>
    
    <field
        name="Aspect">{
            for $x in request:get-parameter("Aspect", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Mood">{
            for $x in request:get-parameter("Mood", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Tense">{
            for $x in request:get-parameter("Tense", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="Voice">{
            for $x in request:get-parameter("Voice", ())
            return
                <value>{$x}</value>
        }</field>
</fields>;


declare function local:get-seg($fs as item()?, $id as xs:string?) as item()* {
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
    
    let $modality := if ($fs/tei:f[@name eq 'modal']/tei:binary/@value eq 'true') then
        'not pertinent, modal'
    else
        'not pertinent, not modal'
    let $type := if ($fs/tei:f[@name eq 'diachrony']) then
        $fs/tei:f[@name eq 'diachrony']/tei:symbol/@value/string()
    else
        '--'
    return
        <tr><td1
                ref="{$id}">{$s}</td1>
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
    let $modality := distinct-values($relation[ft:query(., woposs:prepareQuery("modalType", $mod))]/tei:f[@name eq 'modality']/tei:symbol/@value)
    let $other := distinct-values($relation[ft:query(., woposs:prepareQuery("modalType", $mod))]/tei:f[@name eq 'meaning']/tei:symbol/@value)
    let $type := if (count($other) gt 0) then
        $other || ', ' || $mod
    else
        $mod
    let $amb := if (count($mods) gt 1) then
        'yes'
    else
        'no'
    return
        <tr><td1
                ref="{$id}">{$s}</td1>
            <td>{$marker}</td><td>{$modality}</td><td>{$type}</td><td>{$amb}</td><td>{$locus}</td></tr>

};

declare function local:markerDesc($fs as node()*) as node()* {
    let $query := woposs:filterParams($markerDesc)
    return
        $fs[ft:query(., $query)]
};

declare function local:getScope($markers as node()*) as node()* {
    let $query := woposs:prepareQuery("markerId", $markers/@xml:id)
    let $docs := $markers/ancestor::tei:TEI
    let $relations := $docs/descendant::tei:fs[ft:query(., $query)]
    let $scopes := $docs/descendant::tei:fs[ft:query(., "type:scope")]
    let $scopeIds := $relations/tei:f[@name eq 'scope']/@fVal
    return
        $scopes[ft:query(., woposs:prepareQuery("id", $scopeIds))]
};

declare function local:getMarker($scopes as node()*) as node()* {
    let $query := woposs:prepareQuery("scopeId", $scopes/@xml:id)
    let $docs := $scopes/ancestor::tei:TEI
    let $relations := $docs/descendant::tei:fs[ft:query(., $query)]
    let $markers := $docs/descendant::tei:fs[ft:query(., "type:marker")]
    let $markerIds := $relations/tei:f[@name eq 'marker']/@fVal
    return
        $markers[ft:query(., woposs:prepareQuery("id", $markerIds))]
};

declare function local:filterWords($ws as node()+, $params as item()) as node()* {
    let $msdIds := $ws/substring(@msd, 2)
    let $msdFeatures := $ws/ancestor::tei:TEI/descendant::tei:fs[ft:query(., "type:msd")][ft:query(., woposs:prepareQuery("id", $msdIds))]
    let $query := woposs:filterParams($params)
    let $filteredIds := $msdFeatures[ft:query(., $query)]/@xml:id
    return
        $ws[ft:query(., woposs:prepareQuery("msd", $filteredIds))]
};

declare function local:morph($fs as node()*) as node()* {
    let $segs := for $x in $fs
    return
        local:get-seg($x, $x/@xml:id)
    let $ws := $segs/ancestor::tei:w | $segs/descendant::tei:w
    let $ws_filtered := local:filterWords($ws, $morphologicalFeatures)
    let $seg_filtered := $ws_filtered/ancestor::tei:seg[ft:query(., "function:marker")] | $ws_filtered/descendant::tei:seg[ft:query(., "function:marker")]
    let $anas := for $x in $seg_filtered/tokenize(@ana, '\s+')
    return
        substring($x, 2)
    let $fs_filtered := $fs[ft:query(., woposs:prepareQuery("id", $anas))]
    return
        $fs_filtered
};

declare function local:morphScope($markers as node()*) as node()* {
    let $scopes := if (exists($markers)) then
        local:getScope($markers)
    else
        ()
    let $segs := for $x in $scopes
    return
        local:get-seg($x, $x/@xml:id)
    let $ws := $segs/ancestor::tei:w[ft:query(., "function:main")] | $segs/descendant::tei:w[ft:query(., "function:main")]
    let $ws_filtered := local:filterWords($ws, $morphologicalFeaturesScope)
    let $seg_filtered := $ws_filtered/ancestor::tei:seg[ft:query(., "function:scope")]  | $ws_filtered/descendant::tei:seg[ft:query(., "function:scope")] 
    let $anas := for $x in $seg_filtered/tokenize(@ana, '\s+')
    return
        substring($x, 2)
    let $filtered_scopes := $scopes[ft:query(., woposs:prepareQuery("id", $anas))]
    let $filtered_markers := if (exists($filtered_scopes)) then
        local:getMarker($filtered_scopes)
    else
        ()
    return
        $filtered_markers
};
declare function local:SoaDesc($markers as node()*) as node()* {
    let $query := woposs:filterParams($SoADesc)
    
    let $scopes := if (exists($markers)) then
        local:getScope($markers)
    else
        ()
    
    let $filtered_scopes :=
    $scopes[ft:query(., $query)]
    
    let $filtered_markers := if (exists($filtered_scopes)) then
        local:getMarker($filtered_scopes)
    else
        ()
    return
        $filtered_markers
};

<tbody>{
        let $query := "lemma:" || $marker
        let $mk_fs := $documents//tei:fs[ft:query(., $query)]
        let $mk_filtered := if (exists($markerDesc//value/node())) then
            local:markerDesc($mk_fs)
        else
            $mk_fs
        
        let $mk_filtered2 := if (exists($morphologicalFeatures//value/node())) then
            local:morph($mk_filtered)
        else
            $mk_filtered
        let $mk_filtered3 := if (exists($SoADesc//value/node())) then
            local:SoaDesc($mk_filtered2)
        else
            $mk_filtered2
        let $mk_filtered4 := if (exists($morphologicalFeaturesScope//value/node())) then
            local:morphScope($mk_filtered3)
        else
            $mk_filtered3
        for $mk in $mk_filtered4
        let $output := if ($mk[ft:query(., "pertinence:false")]) then
            local:not-pertinent($mk)
        else
            local:pertinent($mk)
        return
            $output
    }
</tbody>