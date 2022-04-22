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


(: filters scope :)

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

declare function local:SoaDesc($relations as node()*) as node()* {
    let $query-scopes := woposs:filterParams($SoADesc)
    let $docs := $relations/ancestor::tei:TEI
    for $doc in $docs
    let $relations_by_doc := $relations[ancestor::tei:TEI = $doc]
    let $scope_ids:= $relations_by_doc/tei:f[@name eq 'scope']/@fVal
    let $scopes := $doc/id($scope_ids)
    let $filtered_scopes :=
    $scopes[ft:query-field(., $query-scopes)]/@xml:id
    
    let $filtered_relations := if (exists($filtered_scopes)) then
        $relations_by_doc[ft:query-field(., woposs:prepareQuery("scopeId", $filtered_scopes))]
    else
        ()
    return
        $filtered_relations
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
    let $scope := $doc/id($dyn/tei:f[@name eq 'scope']/@fVal)
    let $soa-bool := if ($scope/tei:f[@name eq 'SoA']) then 'no' else 'yes'
    let $control_fs := $scope/tei:f[@name eq 'control']/*/@value
    let $control := if ($control_fs eq 'true') then '+control' else if ($control_fs eq 'false') then '-control' else if ($control_fs eq 'ambiguous') then '±control' else ''
    let $dynamicity_fs := $scope/tei:f[@name eq 'dynamicity']/*/@value
    let $dynamicity := if ($dynamicity_fs eq 'true') then '+dynamic' else if ($dynamicity_fs eq 'false') then '-dynamic' else if ($dynamicity_fs eq 'ambiguous') then '±dynamic' else ''
    let $participant := if ($scope/tei:f[@name eq 'participant']/tei:symbol/@value eq 'none') then 'no participant' else $scope/tei:f[@name eq 'participantType']/tei:symbol/replace(@value, '_', ' – ')
    let $scope_segs: = $doc/descendant::tei:seg[some $x in tokenize(@ana, '\s+') satisfies substring($x, 2) = $scope/@xml:id]
    let $scope_contents := $doc/string-join($scope_segs, ' ')
    let $main_verb := $scope_segs/child::tei:w[@function eq 'main'] | $scope_segs/parent::tei:w[@function eq 'main']
    let $voice_fs := if ($main_verb) then $doc/descendant::tei:fs[@xml:id = substring($main_verb/@msd, 2)]/tei:f[@name eq 'Voice']/tei:symbol/@value/string() else if (contains($lemma, 'bilis') and contains($participant, 'patient')) then 'Pass' else if ($lemma eq 'bilis') then 'Act' else if (contains($lemma, 'ndus')) then 'Pass' else if (contains($lemma, 'turus')) then 'Act' else ()
    let $voice := if (ends-with($main_verb/@lemma, 'r') and $voice_fs eq 'Pass') then 'Dep' else $voice_fs
    let $segs :=  woposs:getSegs($dyn, $mk_id)
    let $marker := string-join($segs, ' ')
    let $s := $segs/ancestor::tei:s
    let $amb := woposs:isAmbiguous($doc, $dyn/@xml:id, 'relation')
    let $locus := woposs:locus($s)
    return
        <tr><td1
                ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>dynamic</td><td>{$type}</td><td>{$subtype}</td><td>{$other}</td><td>{$amb}</td>
          <!--  <td>{$scope_contents}</td><td>{$main_verb/string()}</td><td>{$voice}</td> -->
            <td>{$soa-bool}</td><td>{$control}</td><td>{$dynamicity}</td><td>{$participant}</td><td>{$locus}</td></tr>

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
    let $scope := $doc/id($deo/tei:f[@name eq 'scope']/@fVal)
    let $soa-bool := if ($scope/tei:f[@name eq 'SoA']) then 'no' else 'yes'
    let $control_fs := $scope/tei:f[@name eq 'control']/*/@value
    let $control := if ($control_fs eq 'true') then '+control' else if ($control_fs eq 'false') then '-control' else if ($control_fs eq 'ambiguous') then '±control' else ''
    let $dynamicity_fs := $scope/tei:f[@name eq 'dynamicity']/*/@value
    let $dynamicity := if ($dynamicity_fs eq 'true') then '+dynamic' else if ($dynamicity_fs eq 'false') then '-dynamic' else if ($dynamicity_fs eq 'ambiguous') then '±dynamic' else ''
    let $participant := if ($scope/tei:f[@name eq 'participant']/tei:symbol/@value eq 'none') then 'no participant' else $scope/tei:f[@name eq 'participantType']/tei:symbol/replace(@value, '_', ' – ')
  let $scope_segs: = $doc/descendant::tei:seg[some $x in tokenize(@ana, '\s+') satisfies substring($x, 2) = $scope/@xml:id]
    let $scope_contents := $doc/string-join($scope_segs, ' ')
    let $main_verb := $scope_segs/child::tei:w[@function eq 'main'] | $scope_segs/parent::tei:w[@function eq 'main']
    let $voice_fs := if ($main_verb) then $doc/descendant::tei:fs[@xml:id = substring($main_verb/@msd, 2)]/tei:f[@name eq 'Voice']/tei:symbol/@value/string() else if (contains($lemma, 'bilis') and contains($participant, 'patient')) then 'Pass' else if ($lemma eq 'bilis') then 'Act' else if (contains($lemma, 'ndus')) then 'Pass' else if (contains($lemma, 'turus')) then 'Act' else ()
      let $voice := if (ends-with($main_verb/@lemma, 'r') and $voice_fs eq 'Pass') then 'Deponent' else $voice_fs
 
    let $segs :=  woposs:getSegs($deo, $mk_id)
    let $marker := string-join($segs, ' ')
    let $s := $segs/ancestor::tei:s
    let $amb := woposs:isAmbiguous($doc, $deo/@xml:id, 'relation')
    let $locus := woposs:locus($s)
    return
        <tr><td1
                ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>deontic</td><td>{$type}</td><td>{$subtype}</td><td>{$other}</td><td>{$amb}</td>
       <!--       <td>{$scope_contents}</td><td>{$main_verb/string()}</td><td>{$voice}</td> -->
            <td>{$soa-bool}</td><td>{$control}</td><td>{$dynamicity}</td><td>{$participant}</td><td>{$locus}</td></tr>

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
    let $scope := $doc/id($epi/tei:f[@name eq 'scope']/@fVal)
     let $soa-bool := if ($scope/tei:f[@name eq 'SoA']) then 'no' else 'yes'
    let $control_fs := $scope/tei:f[@name eq 'control']/*/@value
    let $control := if ($control_fs eq 'true') then '+control' else if ($control_fs eq 'false') then '-control' else if ($control_fs eq 'ambiguous') then '±control' else ''
    let $dynamicity_fs := $scope/tei:f[@name eq 'dynamicity']/*/@value
    let $dynamicity := if ($dynamicity_fs eq 'true') then '+dynamic' else if ($dynamicity_fs eq 'false') then '-dynamic' else if ($dynamicity_fs eq 'ambiguous') then '±dynamic' else ''
    let $participant := if ($scope/tei:f[@name eq 'participant']/tei:symbol/@value eq 'none') then 'no participant' else $scope/tei:f[@name eq 'participantType']/tei:symbol/replace(@value, '_', ' – ')
   let $scope_segs: = $doc/descendant::tei:seg[some $x in tokenize(@ana, '\s+') satisfies substring($x, 2) = $scope/@xml:id]
    let $scope_contents := $doc/string-join($scope_segs, ' ')
    let $main_verb := $scope_segs/child::tei:w[@function eq 'main'] | $scope_segs/parent::tei:w[@function eq 'main']
   let $voice_fs := if ($main_verb) then $doc/descendant::tei:fs[@xml:id = substring($main_verb/@msd, 2)]/tei:f[@name eq 'Voice']/tei:symbol/@value/string() else if (contains($lemma, 'bilis') and contains($participant, 'patient')) then 'Pass' else if ($lemma eq 'bilis') then 'Act' else if (contains($lemma, 'ndus')) then 'Pass' else if (contains($lemma, 'turus')) then 'Act' else ()
     
    let $voice := if (ends-with($main_verb/@lemma, 'r') and $voice_fs eq 'Pass') then 'Dep' else $voice_fs
 
    let $other := $epi/tei:f[@name eq 'function']/tei:symbol/@value
    let $segs :=  woposs:getSegs($epi, $mk_id)
    let $marker := string-join($segs, ' ')
    let $s := $segs/ancestor::tei:s
    let $amb := woposs:isAmbiguous($doc, $epi/@xml:id, 'relation')
    let $locus := woposs:locus($s)
    return
        <tr><td1
                ref="{$mk_id}">{$s}</td1>
            <td>{$marker}</td><td>{$lemma}</td><td>epistemic</td><td></td><td>{$degree}</td><td>{$other}</td><td>{$amb}</td>
            <!--  <td>{$scope_contents}</td><td>{$main_verb/string()}</td><td>{$voice}</td> -->
            <td>{$soa-bool}</td><td>{$control}</td><td>{$dynamicity}</td><td>{$participant}</td><td>{$locus}</td></tr>

};

<tbody>
    {
        
        let $fs := $documents//tei:fs[ft:query-field(., "type:relation")]
        let $fs_filtered := if ($simpleFilters/descendant::value/node())
        then
            woposs:simpleFilter($fs, $simpleFilters)
        else
            $fs
        let $fs_filtered2 := if (exists($SoADesc/descendant::value/node())) then
            local:SoaDesc($fs_filtered)
        else
            $fs_filtered
        for $modality in $modalities
        return
            local:modality($fs_filtered2, $modality)
    }
</tbody>