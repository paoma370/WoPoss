xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
import module namespace woposs="http://woposs.unine.ch" at "functions.xql";

(: convenience variable to hold the dataset :)
declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');



(: get the selected types of modality :)
declare variable $modalities := request:get-parameter("modality", 'dynamic');

(: get optional filter: marker lemma :)
 
declare variable $lemmas := request:get-parameter("lemma", ());

(: function to obtain the location of an annotated passage :)
declare function local:lemma($fs as item(), $id as xs:string) as xs:string {
    let $query:= "id:" || $id
    let $lemma := $fs/ancestor::tei:TEI/descendant::tei:fs[ft:query(., 'type:marker')][ft:query(., $query)]/tei:f[@name eq 'lemma']/tei:symbol/@value/string()
    let $correctedLemma := if (contains($lemma, '_inf')) then
        replace($lemma, '_inf', '+ inf.')
    else
        replace($lemma, '_', ' ')
    return
        $correctedLemma
};

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



declare function local:dynParticipants($fs as item()*, $filters as xs:string+) as item()* {
    let $query := woposs:prepareQuery("modalType", $filters)
    return
          $fs[ft:query(., $query)]
};

declare function local:dynSituational($fs as item()*, $filters as xs:string+) as item()* {
    let $query := woposs:prepareQuery("modalSubtype", $filters)
    let $filtered := if ($filters = 'none') then
        $fs[ft:query(., "modalType:situational")][not(tei:f[@name eq 'subtype'])]
    else
        $fs[ft:query(., $query)]
    return
        $filtered
};


declare function local:dynamic($fs as item()*) as item()* {
    let $pos_parts := request:get-parameter("pos_participant_control", "participant-inherent")
    let $nec_parts := request:get-parameter("nec_participant_control", ())
    let $pos_sit_types := request:get-parameter("pos_situational_subtype", ())
    let $nec_sit_types := request:get-parameter("nec_situational_subtype", ())
    let $dyn_fs := $fs[ft:query(., 'modality:dynamic')]
    let $pos_fs_filtered1 := if (count($pos_parts) gt 0) then
        local:dynParticipants($dyn_fs[ft:query(., 'meaning:possibility')], $pos_parts) else ()
    let $pos_fs_filtered2 := if (count($pos_sit_types) gt 0) then
        local:dynSituational($dyn_fs[ft:query(., 'meaning:possibility')], $pos_sit_types) else ()
    let $nec_fs_filtered1 := if (count($nec_parts) gt 0) then
        local:dynParticipants($dyn_fs[ft:query(., 'meaning:necessity')], $nec_parts)
    else
        ()
    let $nec_fs_filtered2 := if (count($nec_sit_types) gt 0) then
    local:dynSituational($dyn_fs[ft:query(., 'meaning:necessity')], $nec_sit_types)
    else
        ()
    let $dyn_fs_filtered := if (count($pos_fs_filtered1) + count($pos_fs_filtered2) + count($nec_fs_filtered1) +  count($nec_fs_filtered2) gt 0) then $pos_fs_filtered1 | $nec_fs_filtered1 | $pos_fs_filtered2 | $nec_fs_filtered2
    else $dyn_fs
    return
       $dyn_fs_filtered

};
declare function local:deonticTypes($fs as item()+, $types as xs:string+) as item()+ {
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

declare function local:volition($fs as item()+, $type as xs:string) as item()* {
    let $filtered := $fs[tei:f[@name eq 'type']/tei:symbol/@value eq $type]
    return
        $filtered
};

declare function local:acceptability($fs as item()+) as item()* {
    let $deontic_degree := request:get-parameter("deontic_degree", ())
    let $filtered := if (count($deontic_degree) gt 0) then
        $fs[tei:f[@name eq 'degree']/tei:symbol[@value = $deontic_degree]]
    else
        $fs[tei:f[@name eq 'type']/tei:symbol/@value eq 'acceptability']
    
    return
        $filtered
};

declare function local:recommendation($fs) as item()* {
    let $contexts := request:get-parameter('rec_context', ())
    let $sources := request:get-parameter('rec_source', ())
    let $subtype := $fs[tei:f[@name eq 'subtype']/tei:symbol/@value eq 'recommendation']
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
    let $subtype := $fs[tei:f[@name eq 'subtype']/tei:symbol/@value eq 'obligation']
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

declare function local:authority-subtype($fs as item()+, $types as xs:string+) as item()* {
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
                    local:recommendation($fs)
            default
            return
                ()
};

declare function local:authority($fs as item()+) as item()* {
    let $authority_subtype := request:get-parameter("authority_subtype", ())
    let $fs_authority := $fs[tei:f[@name eq 'type']/tei:symbol/@value eq 'authority']
    let $filtered_by_type := if (count($authority_subtype) gt 0) then
        local:authority-subtype($fs_authority, $authority_subtype)
    else
        $fs
    let $filtered := $filtered_by_type | $fs_authority
    return
        $filtered
};


declare function local:deontic($fs as item()*) as item()* {
    let $deontic_type := request:get-parameter("deontic_type", ())
    let $deo_fs := $fs[tei:f[@name eq 'modality']/tei:symbol/@value eq 'deontic']
    let $deo_fs_filtered := if (count($deontic_type) gt 0) then
        local:deonticTypes($deo_fs, $deontic_type)
    else
        $deo_fs
    for $deo in $deo_fs_filtered
    let $type := $deo/tei:f[@name eq 'type']/tei:symbol/@value/string()
    let $subtype := if ($deo/tei:f[@name eq 'degree']) then
        $deo/tei:f[@name eq 'degree']/tei:symbol/replace(@value, '_', ' ')
    else
        $deo/tei:f[@name eq 'subtype']/tei:symbol/@value/string()
    let $other := $deo/tei:f[@name eq 'context']/tei:symbol/@value/string()
    let $mk_id := $deo/tei:f[@name eq 'marker']/@fVal
    let $lemma := local:lemma($deo, $mk_id)
    let $marker := string-join($deo/ancestor::tei:TEI/descendant::tei:seg[substring(@ana, 2) eq $mk_id], ' ')
    let $s := $deo/ancestor::tei:TEI/descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $mk_id]]
    let $locus := woposs:locus($s)
    return
        <tr><td1 ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>deontic</td><td>{$type}</td><td>{$subtype}</td><td>{$other}</td><td>{$locus}</td></tr>

};

declare function local:epistemic($fs as item()*) as item()* {
    let $epistemic_degree := request:get-parameter("epistemic_degree", ())
    let $epi_fs := $fs[tei:f[@name eq 'modality']/tei:symbol[@value eq 'epistemic']]
    let $epi_filtered := if (count($epistemic_degree) gt 0) then
        $epi_fs[tei:f[@name eq 'degree']/tei:symbol[@value = $epistemic_degree]]
    else
        $epi_fs
    for $epi in $epi_filtered
    
    let $degree := $epi/tei:f[@name eq 'degree']/tei:symbol/replace(@value, '_', ' ')
    let $mk_id := $epi/tei:f[@name eq 'marker']/@fVal
    let $lemma := local:lemma($epi, $mk_id)
    let $marker := string-join($epi/ancestor::tei:TEI/descendant::tei:seg[substring(@ana, 2) eq $mk_id], ' ')
    let $s := $epi/ancestor::tei:TEI/descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $mk_id]]
    let $locus := woposs:locus($s)
    return
        <tr><td1 ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>epistemic</td><td></td><td>{$degree}</td><td></td><td>{$locus}</td></tr>

};

declare function local:filterByLemma($fs as node()+) as item()* {
     let $query1 := "lemma:" || string-join($lemmas, ' OR ')
        let $markers := $documents//tei:fs[ft:query(., $query1)]/@xml:id
        let $markerIds := string-join($markers, ' OR ')
        let $query2:= "markerId:(" || $markerIds || ')'
        return $fs[ft:query(., $query2)]
};
<tbody>
    {
        
        let $fs := $documents//tei:fs[ft:query(., "type:relation")]
       
        let $fs_filtered := if (count($lemmas) gt 0) then local:filterByLemma($fs) else $fs
        for $modality in $modalities
        return
            local:modality($fs_filtered, $modality)
    }
</tbody>