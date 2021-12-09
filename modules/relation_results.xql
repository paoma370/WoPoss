xquery version "3.1";
declare namespace tei = "http://www.tei-c.org/ns/1.0";

(: convenience variable to hold the dataset :)
declare variable $documents as document-node()+ :=
collection('/db/apps/woposs/data');



(: get the selected types of modality :)
declare variable $modalities := request:get-parameter("modality", 'dynamic');

(: function to obtain the location of an annotated passage :)
declare function local:lemma($fs as item(), $id as xs:string) as xs:string {
    let $lemma := $fs/preceding-sibling::tei:fs[@type eq 'marker'][@xml:id eq $id]/tei:f[@name eq 'lemma']/tei:symbol/@value/string()
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

declare function local:locus($s as item()) as xs:string {
    $s/ancestor::tei:TEI/descendant::tei:title[@type eq 'short'] || ', ' || $s/ancestor::tei:div[@type eq 'chapter']/@n || ', ' || $s/@n
};

declare function local:possParticipants($fs as item()*, $pos_parts as xs:string*, $pos_sit_types as xs:string*) as item()* {
    let $possMeaning := $fs[tei:f[@name eq 'meaning']/tei:symbol/@value eq 'possibility']
    let $firstFilter := $possMeaning[tei:f[@name eq 'type']/tei:symbol/@value = $pos_parts]
    let $secondFilter := if ($pos_sit_types = 'none') then
        $possMeaning[tei:f[@name eq 'type']/tei:symbol/@value = 'situational'][not(tei:f[@name eq 'subtype'])]
    else
        $possMeaning[tei:f[@name eq 'subtype']/tei:symbol/@value = $pos_sit_types]
    let $filtered := $firstFilter | $secondFilter
    return
        $filtered
};

declare function local:necParticipants($fs as item()*, $nec_parts as xs:string*, $nec_sit_types as xs:string*) as item()* {
    let $necMeaning := $fs[tei:f[@name eq 'meaning']/tei:symbol/@value eq 'necessity']
    let $firstFilter := $necMeaning[tei:f[@name eq 'type']/tei:symbol/@value = $nec_parts]
    let $secondFilter := if ($nec_sit_types = 'none') then
        $necMeaning[tei:f[@name eq 'type']/tei:symbol/@value = 'situational'][not(tei:f[@name eq 'subtype'])]
    else
        $necMeaning[tei:f[@name eq 'subtype']/tei:symbol/@value = $nec_sit_types]
    let $filtered := $firstFilter | $secondFilter
    return
        $filtered
};


declare function local:dynamic($fs as item()*) as item()* {
    let $pos_parts := request:get-parameter("pos_participant_control", ())
    let $nec_parts := request:get-parameter("nec_participant_control", ())
    let $pos_sit_types := request:get-parameter("pos_situational_subtype", ())
    let $nec_sit_types := request:get-parameter("nec_situational_subtype", ())
    let $dyn_fs := $fs[tei:f[@name eq 'modality']/tei:symbol/@value eq 'dynamic']
    let $pos_fs_filtered := if (count($pos_parts) gt 0 or count($pos_sit_types) gt 0) then
        local:possParticipants($dyn_fs, $pos_parts, $pos_sit_types)
    else
        ()
    let $nec_fs_filtered := if (count($nec_parts) gt 0 or count($nec_sit_types) gt 0) then
        local:necParticipants($dyn_fs, $nec_parts, $nec_sit_types)
    else
        ()
    let $dyn_fs_filtered := $pos_fs_filtered | $nec_fs_filtered
    for $dyn in $dyn_fs_filtered
    let $type := $dyn/tei:f[@name eq 'meaning']/tei:symbol/@value/string()
    let $subtype := $dyn/tei:f[@name eq 'type']/tei:symbol/@value/string()
    let $other := $dyn/tei:f[@name eq 'subtype']/tei:symbol/@value/string()
    let $mk_id := $dyn/tei:f[@name eq 'marker']/@fVal
    let $lemma := local:lemma($dyn, $mk_id)
    let $marker := string-join($dyn/ancestor::tei:TEI/descendant::tei:seg[substring(@ana, 2) eq $mk_id], ' ')
    let $s := $dyn/ancestor::tei:TEI/descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $mk_id]]
    let $locus := local:locus($s)
    return
        <tr><td1>{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>dynamic</td><td>{$type}</td><td>{$subtype}</td><td>{$other}</td><td>{$locus}</td></tr>

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
    let $filtered := $fs
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
    let $locus := local:locus($s)
    return
        <tr><td1>{$s}</td1>
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
    let $locus := local:locus($s)
    return
        <tr><td1>{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>epistemic</td><td></td><td>{$degree}</td><td></td><td>{$locus}</td></tr>

};
<tbody>
    {
        let $lemmas := request:get-parameter("lemma", ())
        let $options := map {
            "facets": map {
                "lemma": "possum"
            }
        }
        let $fs := $documents//tei:fs[@type eq 'relation']
        let $fs_filtered := $fs[ft:query(., "delete", $options)]
        (:let $fs_filtered := if (count($lemmas) gt 0) then
            $fs[tei:f[@name eq 'marker'][@fVal = $fs/parent::*/tei:fs[tei:f[@name eq 'lemma']/tei:symbol[@value = $lemmas]]/@xml:id]]
        else
            $fs:)
        for $modality in $modalities
        return
            local:modality($fs_filtered, $modality)
    }
</tbody>