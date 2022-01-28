xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace woposs = "http://woposs.unine.ch" at "../functions.xql";

declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');
declare variable $mk_fs := $documents//tei:fs[ft:query-field(., "type:marker")];
declare variable $minCentury := xs:integer(-3);
declare variable $maxCentury := xs:integer(7);
declare variable $simpleFilters := <fields>
    
    
    
    <!-- restrictive filter related to the work metadata -->
    
    <field
        name="work">
        <value>{request:get-parameter("title", ())}</value></field>
    
    
    <!-- frestricted filter related to the author metadata -->
    
    <field
        name="author">
        <value>{request:get-parameter("author", ())}</value></field>
    
    
    <!-- filter by lemma  -->
    
    <field
        name="lemma">
        {
            for $x in request:get-parameter("lemma", ())
            return
                <value>{$x}</value>
        }
    </field>
    
    
    <!-- other filters related to the author metadata -->
    
    <field
        name="authorGender">
        <value>{request:get-parameter("gender", ())}</value></field>
    <field
        name="authorPlace">
        <value>{request:get-parameter("place", ())}</value></field>
    
    
    
    <!-- other filters related to the work metadata -->
    
    
    <field
        name="genre">
        {
            for $x in request:get-parameter("genre", ())
            return
                <value>{$x}</value>
        }
    </field>
    
    <field
        name="textualFeature">
        {
            for $x in request:get-parameter("textualFeature", ())
            return
                <value>{$x}</value>
        }
    </field>
    <field
        name="transmission">
        {
            for $x in request:get-parameter("transmission", ())
            return
                <value>{$x}</value>
        }
    </field>
    
    
    <!-- filter concerning the modal meaning -->
    
    <field
        name="modalRelation">
        {
            for $x in request:get-parameter("modality", ())
            return
                <value>{$x}</value>
        }
    </field>
    
    <field
        name="modalRelationFunction">
        <value>{
                if (request:get-parameter("rhetoric", ()) eq 'true') then
                    'rhetoric'
                else
                    ()
            }</value>
        <value>{
                if (request:get-parameter("pragmatic", ()) eq 'true') then
                    'pragmatic'
                else
                    ()
            }</value>
        <value>{
                if (request:get-parameter("pragmatic", ()) eq 'false' or request:get-parameter("rhetoric", ()) eq 'false') then
                    'function-false'
                else
                    ()
            }</value>
        {
            if (request:get-parameter("pragmatic", ()) eq 'false' or request:get-parameter("rhetoric", ()) eq '') then
                (<value>function-false</value>, <value>rhetoric</value>)
            else
                ()
        }
        {
            if (request:get-parameter("rhetoric", ()) eq 'false' or request:get-parameter("pragmatic", ()) eq '') then
                (<value>function-false</value>, <value>pragmatic</value>)
            else
                ()
        }
    </field>
    
    <field
        name="modalRelationAmbiguity">
        <value>{request:get-parameter("ambiguity", ())}</value>
    </field>
    
    
    <!-- filters related to the markers descriptions -->
    
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

declare variable $centuryFilter := <fields>
    <field
        name="notBefore"><value>{request:get-parameter("notBefore", ())}</value></field>
    <field
        name="notAfter"><value>{request:get-parameter("notAfter", ())}</value></field></fields>;

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

(:values of the form that are not as straigtforward :)

declare function local:get-seg($fs as item()?, $id as xs:string?) as item()* {
    let $query := "ana:" || $id
    let $segs := $fs/ancestor::tei:TEI/descendant::tei:seg[ft:query-field(., $query)]
    return
        $segs
};


declare function local:not-pertinent($fs as node()?) as item()* {
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

declare function local:pertinent($fs as node()?) as item()* {
    let $id := $fs/@xml:id
    let $segs := local:get-seg($fs, $id)
    let $marker := string-join($segs, ' ')
    let $s := $segs/ancestor::tei:s
    let $locus := woposs:locus($s)
    let $relation_query := "markerId:" || $id
    let $relation := $documents/descendant::tei:fs[ft:query-field(., $relation_query)]
    let $mods := distinct-values($relation/tei:f[@name eq 'type']/tei:symbol/@value)
    for $mod in $mods
    let $modality := distinct-values($relation[ft:query-field(., woposs:prepareQuery("modalType", $mod))]/tei:f[@name eq 'modality']/tei:symbol/@value)
    let $other := distinct-values($relation[ft:query-field(., woposs:prepareQuery("modalType", $mod))]/tei:f[@name eq 'meaning']/tei:symbol/@value)
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

declare function local:getScope($markers as node()*) as node()* {
    let $query := woposs:prepareQuery("markerId", $markers/@xml:id)
    let $docs := $markers/ancestor::tei:TEI
    let $relations := $docs/descendant::tei:fs[ft:query-field(., $query)]
    let $scopes := $docs/descendant::tei:fs[ft:query-field(., "type:scope")]
    let $scopeIds := $relations/tei:f[@name eq 'scope']/@fVal
    return
        $scopes[ft:query-field(., woposs:prepareQuery("id", $scopeIds))]
};

declare function local:getMarker($scopes as node()*) as node()* {
    let $query := woposs:prepareQuery("scopeId", $scopes/@xml:id)
    let $docs := $scopes/ancestor::tei:TEI
    let $relations := $docs/descendant::tei:fs[ft:query-field(., $query)]
    let $markers := $docs/descendant::tei:fs[ft:query-field(., "type:marker")]
    let $markerIds := $relations/tei:f[@name eq 'marker']/@fVal
    return
        $markers[ft:query-field(., woposs:prepareQuery("id", $markerIds))]
};

declare function local:filterWords($ws as node()+, $params as item()) as node()* {
    let $msdIds := $ws/substring(@msd, 2)
    let $msdFeatures := $ws/ancestor::tei:TEI/descendant::tei:fs[ft:query-field(., woposs:prepareQuery("id", $msdIds))]
    let $query := woposs:filterParams($params)
    let $filteredIds := $msdFeatures[ft:query-field(., $query)]/@xml:id
    let $filteredWords := if (exists($filteredIds)) then
        $ws[ft:query-field(., woposs:prepareQuery("msd", $filteredIds))]
    else
        ()
    return
        $filteredWords
};

declare function local:morph($fs as node()*) as node()* {
    if ($fs) then
        (
        let $segs := for $x in $fs
        return
            local:get-seg($x, $x/@xml:id)
        let $ws := $segs/ancestor::tei:w[@msd] | $segs/descendant::tei:w[@msd]
        let $ws_filtered := local:filterWords($ws, $morphologicalFeatures)
        let $seg_filtered := if (exists($ws_filtered)) then
            $ws_filtered/ancestor::tei:seg[ft:query-field(., "function:marker")] | $ws_filtered/descendant::tei:seg[ft:query-field(., "function:marker")]
        else
            ()
        let $anas := for $x in $seg_filtered/tokenize(@ana, '\s+')
        return
            substring($x, 2)
        return
            $fs[ft:query-field(., woposs:prepareQuery("id", $anas))]
        )
    else
        ()
};

declare function local:morphScope($markers as node()*) as node()* {
    let $scopes := if (exists($markers)) then
        local:getScope($markers)
    else
        ()
    let $segs := for $x in $scopes
    return
        local:get-seg($x, $x/@xml:id)
    let $ws := $segs/ancestor::tei:w[@msd][ft:query-field(., "function:main")] | $segs/descendant::tei:w[@msd][ft:query-field(., "function:main")]
    let $ws_filtered := if (exists($ws)) then
        local:filterWords($ws, $morphologicalFeaturesScope)
    else
        ()
    let $seg_filtered := $ws_filtered/ancestor::tei:seg[ft:query-field(., "function:scope")] | $ws_filtered/descendant::tei:seg[ft:query-field(., "function:scope")]
    let $anas := for $x in $seg_filtered/tokenize(@ana, '\s+')
    return
        substring($x, 2)
    let $filtered_scopes := if (exists($anas)) then
        $scopes[ft:query-field(., woposs:prepareQuery("id", $anas))]
    else
        ()
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
    $scopes[ft:query-field(., $query)]
    
    let $filtered_markers := if (exists($filtered_scopes)) then
        local:getMarker($filtered_scopes)
    else
        ()
    return
        $filtered_markers
};

declare function local:filterByCentury($fs as node()*) as node()* {
    if ($fs) then
        (
        let $selectionMin := if (exists($centuryFilter/field[@name eq 'notBefore']/value/node())) then
            $centuryFilter/field[@name eq 'notBefore']/xs:integer(value)
        else
            $minCentury
        let $selectionMax := if (exists($centuryFilter/field[@name eq 'notAfter']/value/node())) then
            $centuryFilter/field[@name eq 'notAfter']/xs:integer(value)
        else
            $maxCentury
        let $numbers := for $x in $selectionMin to $selectionMax
        return
            replace(xs:string($x), '-', 'BCE')
        let $filtered := $fs[ft:query-field(., woposs:prepareQuery("century", $numbers))]
        return
            $filtered
        )
    else
        ()
};


<tbody>{
        let $mk_filtered := if (exists($simpleFilters//value/node())) then
            woposs:simpleFilter($mk_fs, $simpleFilters)
        else
            $mk_fs
        let $mk_filtered1 := if (exists($centuryFilter//value/node())) then
            local:filterByCentury($mk_filtered)
        else
            $mk_filtered
        
        let $mk_filtered2 := if (exists($morphologicalFeatures//value/node())) then
            local:morph($mk_filtered1)
        else
            $mk_filtered1
        let $mk_filtered3 := if (exists($SoADesc//value/node())) then
            local:SoaDesc($mk_filtered2)
        else
            $mk_filtered2
        let $mk_filtered4 := if (exists($morphologicalFeaturesScope//value/node())) then
            local:morphScope($mk_filtered3)
        else
            $mk_filtered3
        for $mk in $mk_filtered4
        let $output := if ($mk[ft:query-field(., "pertinence:false")]) then
            local:not-pertinent($mk)
        else
            local:pertinent($mk)
        return
            $output
    }
</tbody>