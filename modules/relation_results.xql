xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace woposs = "http://woposs.unine.ch" at "../functions.xql";

(: convenience variable to hold the dataset :)
declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');



(: get the selected types of modality :)
declare variable $modalities := request:get-parameter("modality", ());

declare variable $simpleFilters := <fields>
    
    
    
    <!-- restrictive filter related to the work metadata -->
    
    <field
        name="work">
        <value>{request:get-parameter("title", ())}</value></field>
    
    
    <!-- frestricted filter related to the author metadata -->
    
    <field
        name="author">
        <value>{request:get-parameter("author", ())}</value></field>
    
    
    
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
        name="function">
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
        name="ambiguity">
        <value>{request:get-parameter("ambiguity", ())}</value>
    </field>
    
    
    <!-- filters related to the markers descriptions -->
    
    <field
        name="markerLemma">
        {
            for $x in request:get-parameter("lemma", ())
            return
                <value>{$x}</value>
        }
    </field>
</fields>;

declare variable $dynamicPossFilters := <fields>
    <field
        name="modalType">
        {
            for $x in request:get-parameter("pos_participant_control", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="modalSubtype">
        {
            for $x in request:get-parameter("pos_situational_subtype", ())
            return
                <value>{$x}</value>
        }
    </field></fields>;

declare variable $dynamicNecFilters := <fields>
    <field
        name="modalType">
        {
            for $x in request:get-parameter("nec_participant_control", ())
            return
                <value>{$x}</value>
        }</field>
    <field
        name="modalSubtype">
        {
            for $x in request:get-parameter("nec_situational_subtype", ())
            return
                <value>{$x}</value>
        }
    </field></fields>;

(: function to  :)
declare function local:modality($fs as item()*, $modality as xs:string) as item()* {
    switch ($modality)
        case 'dynamic'
            return
                local:dynamic($fs)
        case 'deontic'
            return
                local:deontic($fs)
        case 'epistemic'
            return
                local:epistemic($fs)
        default
        return
            ()
};



declare function local:dynamic($fs as item()*) as item()* {
    let $dyn_fs := $fs[ft:query-field(., 'modality:dynamic')]
    let $pos_fs_filtered := if (exists($dynamicPossFilters/descendant::value/node())) then
        woposs:simpleFilter($dyn_fs[ft:query-field(., 'modalMeaning:possibility')], $dynamicPossFilters)
    else
        ()
    let $nec_fs_filtered := if (exists($dynamicNecFilters/descendant::value/node())) then
        woposs:simpleFilter($dyn_fs[ft:query-field(., 'modalMeaning:necessity')], $dynamicNecFilters)
    else
        ()
    let $dyn_fs_filtered := if (exists($pos_fs_filtered) or exists($nec_fs_filtered)) then
        $pos_fs_filtered |
        $nec_fs_filtered
    else
        $dyn_fs
    for $dyn in $dyn_fs_filtered
    let $doc := $dyn/ancestor::tei:TEI
    let $type := $dyn/tei:f[@name eq 'meaning']/tei:symbol/@value/string()
    let $subtype := $dyn/tei:f[@name eq 'type']/tei:symbol/@value/string()
    let $function := if ($dyn//tei:f[@name eq 'function']) then
        'Function: ' || $dyn//tei:f[@name eq 'function']/tei:symbol/@value
    else
        ()
    let $sitSubtype := if ($dyn/tei:f[@name eq 'subtype'][tei:symbol/@value ne 'none']) then
        'Situational modality subtype: ' || $dyn/tei:f[@name eq 'subtype']/tei:symbol/@value
    else
        ()
    let $other := string-join(($sitSubtype, $function), '. ')
    let $mk_id := $dyn/tei:f[@name eq 'marker']/@fVal
    let $lemma := woposs:lemma($doc, $mk_id)
    let $marker := string-join($doc/descendant::tei:seg[substring(@ana, 2) eq $mk_id], ' ')
    let $s := $doc/descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $mk_id]]
    let $amb := woposs:isAmbiguous($doc, $dyn/@xml:id, 'relation')
    let $locus := woposs:locus($s)
    return
        <tr><td1
                ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>dynamic</td><td>{$type}</td><td>{$subtype}</td><td>{$other}</td><td>{$amb}</td><td>{$locus}</td></tr>

};

declare function local:deonticTypes($fs as item()*, $types as xs:string+) as item()* {
    for $type in $types
    return
        switch ($type)
            case 'acceptability'
                return
                    local:acceptability($fs)
            case 'authority'
                return
                    local:authority($fs)
            case 'volition'
                return
                    local:volition($fs, $type)
            case 'intention'
                return
                    local:volition($fs, $type)
            default
            return
                ()
};

declare function local:volition($fs as item()*, $type as xs:string) as item()* {
    let $query := woposs:prepareQuery("modalType", $type)
    let $filtered := $fs[ft:query-field(., $query)]
    return
        $filtered
};

declare function local:acceptability($fs as item()*) as item()* {
    let $deontic_degree := request:get-parameter("deontic_degree", ())
    let $filtered := if (count($deontic_degree) gt 0) then
        $fs[ft:query-field(., woposs:prepareQuery("degree", $deontic_degree))]
    else
        $fs[ft:query-field(., "modalType:acceptability")]
    
    return
        $filtered
};

declare function local:recommendation($fs) as item()* {
    let $contexts := request:get-parameter('rec_context', ())
    let $sources := request:get-parameter('rec_source', ())
    let $subtype := $fs[ft:query-field(., "modalSubtype:recommendation")]
    let $filtered := if (count($contexts) gt 0 and count($sources) gt 0) then
        $subtype[tei:f[@name eq 'context']/tei:symbol[@value = $contexts]]
        [tei:f[@name eq 'source']/tei:symbol[@value = $sources]]
    else
        if (count($contexts) gt 0 and count($sources) eq 0) then
            $subtype[tei:f[@name eq 'context']/tei:symbol[@value = $contexts]]
        else
            if (count($contexts) eq 0 and count($sources) gt 0) then
                $subtype[tei:f[@name eq 'source']/tei:symbol[@value = $sources]]
            else
                $subtype
    return
        $filtered
};

declare function local:permission($fs) as item()* {
    let $contexts := request:get-parameter('per_context', ())
    let $sources := request:get-parameter('per_source', ())
    let $subtype := $fs[tei:f[@name eq 'subtype']/tei:symbol/@value eq 'permission']
    let $filtered := if (count($contexts) gt 0 and count($sources) gt 0) then
        $subtype[tei:f[@name eq 'context']/tei:symbol[@value = $contexts]]
        [tei:f[@name eq 'source']/tei:symbol[@value = $sources]]
    else
        if (count($contexts) gt 0 and count($sources) eq 0) then
            $subtype[tei:f[@name eq 'context']/tei:symbol[@value = $contexts]]
        else
            if (count($contexts) eq 0 and count($sources) gt 0) then
                $subtype[tei:f[@name eq 'source']/tei:symbol[@value = $sources]]
            else
                $subtype
    return
        $filtered
};

declare function local:obligation($fs) as item()* {
    let $contexts := request:get-parameter('ob_context', ())
    let $sources := request:get-parameter('ob_source', ())
    let $subtype := $fs[ft:query-field(., "modalSubtype:obligation")]
    let $filtered := if (count($contexts) gt 0 and count($sources) gt 0) then
        $subtype[tei:f[@name eq 'context']/tei:symbol[@value = $contexts]]
        [tei:f[@name eq 'source']/tei:symbol[@value = $sources]]
    else
        if (count($contexts) gt 0 and count($sources) eq 0) then
            $subtype[tei:f[@name eq 'context']/tei:symbol[@value = $contexts]]
        else
            if (count($contexts) eq 0 and count($sources) gt 0) then
                $subtype[tei:f[@name eq 'source']/tei:symbol[@value = $sources]]
            else
                $subtype
    return
        $filtered
};

declare function local:authority-subtype($fs as item()*, $types as xs:string+) as item()* {
    for $type in $types
    return
        switch ($type)
            case 'recommendation'
                return
                    local:recommendation($fs)
            case 'permission'
                return
                    local:permission($fs)
            case 'obligation'
                return
                    local:obligation($fs)
            default
            return
                ()
};

declare function local:authority($fs as item()*) as item()* {
    let $authority_subtype := request:get-parameter("authority_subtype", ())
    let $fs_authority := $fs[ft:query-field(., "modalType:authority")]
    let $filtered := if (count($authority_subtype) gt 0) then
        local:authority-subtype($fs_authority, $authority_subtype)
    else
        $fs_authority
    return
        $filtered
};


declare function local:deontic($fs as item()*) as item()* {
    let $deontic_type := request:get-parameter("deontic_type", ())
    let $deo_fs := $fs[ft:query-field(., "modality:deontic")]
    let $deo_fs_filtered := if (count($deontic_type) gt 0) then
        local:deonticTypes($deo_fs, $deontic_type)
    else
        $deo_fs
    for $deo in $deo_fs_filtered
    let $doc := $deo/ancestor::tei:TEI
    let $type := $deo/tei:f[@name eq 'type']/tei:symbol/@value/string()
    let $subtype := if ($deo/tei:f[@name eq 'degree']) then
        $deo/tei:f[@name eq 'degree']/tei:symbol/replace(@value, '_', ' ')
    else
        $deo/tei:f[@name eq 'subtype']/tei:symbol/@value/string()
    let $context := if ($deo/tei:f[@name eq 'context']) then
        $deo/tei:f[@name eq 'context']/tei:symbol/@value/string()
    else
        ()
    let $source := if ($deo/tei:f[@name eq 'source']) then
        $deo/tei:f[@name eq 'source']/tei:symbol/replace(@value, '_', ' ')
    else
        ()
    let $add := string-join(($context, $source), ', ')
    let $function := 'Function: ' || $deo/tei:f[@name eq 'function']/tei:symbol/@value
    let $other := if ($deo/tei:f[@name eq 'function'] and $add) then
        string-join(($add, $function), '. ')
    else
        if ($deo/tei:f[@name eq 'function']) then $function else $add
    let $mk_id := $deo/tei:f[@name eq 'marker']/@fVal
    let $lemma := woposs:lemma($doc, $mk_id)
    let $marker := string-join($doc/descendant::tei:seg[substring(@ana, 2) eq $mk_id], ' ')
    let $s := $doc/descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $mk_id]]
    let $amb := woposs:isAmbiguous($doc, $deo/@xml:id, 'relation')
    let $locus := woposs:locus($s)
    return
        <tr><td1
                ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>deontic</td><td>{$type}</td><td>{$subtype}</td><td>{$other}</td><td>{$amb}</td><td>{$locus}</td></tr>

};

declare function local:epistemic($fs as item()*) as item()* {
    let $epistemic_degree := request:get-parameter("epistemic_degree", ())
    let $epi_fs := $fs[ft:query-field(., "modality:epistemic")]
    let $epi_filtered := if (count($epistemic_degree) gt 0) then
        $epi_fs[ft:query-field(., woposs:prepareQuery("degree", $epistemic_degree))]
    else
        $epi_fs
    for $epi in $epi_filtered
    let $doc := $epi/ancestor::tei:TEI
    let $degree := $epi/tei:f[@name eq 'degree']/tei:symbol/replace(@value, '_', ' ')
    let $mk_id := $epi/tei:f[@name eq 'marker']/@fVal
    let $lemma := woposs:lemma($doc, $mk_id)
    let $other := $epi/tei:f[@name eq 'function']/tei:symbol/@value
    let $marker := string-join($doc/descendant::tei:seg[substring(@ana, 2) eq $mk_id], ' ')
    let $s := $doc/descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $mk_id]]
    let $amb := woposs:isAmbiguous($doc, $epi/@xml:id, 'relation')
    let $locus := woposs:locus($s)
    return
        <tr><td1
                ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>epistemic</td><td></td><td>{$degree}</td><td>{$other}</td><td>{$amb}</td><td>{$locus}</td></tr>

};

<tbody>
    {
        
        let $fs := $documents//tei:fs[ft:query-field(., "type:relation")]
        let $fs_filtered := if ($simpleFilters/descendant::value/node())
        then
            woposs:simpleFilter($fs, $simpleFilters)
        else
            $fs
        for $modality in $modalities
        return
            local:modality($fs_filtered, $modality)
    }
</tbody>