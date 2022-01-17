<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:woposs="https://www.woposs.unine.ch" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:param name="id"/>
    <xsl:function name="woposs:capitalize-first" as="xs:string?">
        <xsl:param name="string" as="xs:string?"/>
        <xsl:sequence select="concat(upper-case(substring($string, 1, 1)), substring($string, 2))"/>

    </xsl:function>
    <xsl:function name="woposs:getId" as="xs:string">
        <xsl:param name="seg"/>
        <xsl:choose>
            <xsl:when test="$seg/@ana">
                <xsl:value-of select="                         for $x in $seg/tokenize(@ana, '\s+')                         return                             substring($x, 2)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="corresp" select="                         for $i in $seg/tokenize(@corresp, '\s+')                         return                             substring($i, 2)"/>
                <xsl:value-of select="'id_' || string-join($corresp, '')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="woposs:unitContents">
        <xsl:param name="doc" as="node()"/>
        <xsl:param name="idno" as="xs:string"/>
        <xsl:apply-templates select="                 $doc/descendant::tei:seg[some $x in tokenize(@ana, '\s+')                     satisfies substring($x, 2) = $idno]" mode="getContents"/>
    </xsl:function>
    <xsl:function name="woposs:marker">
        <xsl:param name="fs" as="node()"/>
        <xsl:variable name="lemma_string" select="$fs/tei:f[@name eq 'lemma']/tei:symbol/@value"/>
        <xsl:variable name="lemma" select="                 if (contains($lemma_string, '_inf')) then                     replace($lemma_string, '_inf', ' + inf.')                 else                     replace($lemma_string, '_', ' ')"/>
        <li>Pertinent: yes</li>
        <li>Lemma: <xsl:value-of select="$lemma"/></li>
        <li>Type of utterance: <xsl:value-of select="$fs/tei:f[@name eq 'utterance']/tei:symbol/@value"/></li>
        <li>Polarity: <xsl:value-of select="$fs/tei:f[@name eq 'polarity']/tei:symbol/@value"/></li>
    </xsl:function>
    <xsl:function name="woposs:scope">
        <xsl:param name="fs" as="node()?"/>
        <xsl:variable name="id" select="$fs/@xml:id"/>
        <li>Type of utterance: <xsl:value-of select="$fs/tei:f[@name eq 'utterance']/tei:symbol/@value"/></li>
        <li>Polarity: <xsl:value-of select="$fs/tei:f[@name eq 'polarity']/tei:symbol/@value"/></li>
        <li>State of affairs: <ul>
                <li><xsl:apply-templates select="$fs/tei:f[@name = ('SoA', 'dynamicity', 'control')]" mode="analysis"/></li>
                <xsl:if test="not($fs/tei:f[@name = 'SoA'])">
                    <li>Participant: <xsl:choose>
                            <xsl:when test="$fs/tei:f[@name eq 'participant']">
                                <ul><xsl:apply-templates select="$fs/tei:f[@name eq 'participant']" mode="features"/></ul>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="participant" select="$fs/ancestor::tei:TEI/descendant::tei:seg[@function eq 'participant'][substring(@corresp, 2) eq $id]"/>
                                <xsl:for-each select="$participant">
                                    <ul>
                                        <xsl:apply-templates select="current()" mode="features"/>
                                    </ul>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose></li></xsl:if>
            </ul></li>

    </xsl:function>
    <xsl:function name="woposs:relation">
        <xsl:param name="fs" as="node()"/>
        <li>Modal meaning: <xsl:value-of select="$fs/tei:f[@name eq 'modality']/tei:symbol/@value"/>
            <ul>
                <xsl:if test="$fs/tei:f[@name eq 'meaning']">
                    <li>Meaning: <xsl:value-of select="$fs/tei:f[@name eq 'meaning']/tei:symbol/@value"/></li></xsl:if>
                <xsl:if test="$fs/tei:f[@name eq 'type']">
                    <li>Type: <xsl:value-of select="$fs/tei:f[@name eq 'type']/tei:symbol/@value"/></li></xsl:if>
                <xsl:if test="$fs/tei:f[@name eq 'subtype']">
                    <li>Subtype: <xsl:value-of select="$fs/tei:f[@name eq 'subtype']/tei:symbol/@value"/></li></xsl:if>
                <xsl:if test="$fs/tei:f[@name eq 'degree']">
                    <li>Degree: <xsl:value-of select="$fs/tei:f[@name eq 'degree']/tei:symbol/@value"/></li></xsl:if>
                <xsl:if test="$fs/tei:f[@name eq 'context']">
                    <li>Context: <xsl:value-of select="$fs/tei:f[@name eq 'context']/tei:symbol/@value =&gt; replace('_', ' ')"/></li></xsl:if>
                <xsl:if test="$fs/tei:f[@name eq 'source']">
                    <li>Source: <xsl:value-of select="$fs/tei:f[@name eq 'source']/tei:symbol/@value =&gt; replace('_', ' ')"/></li></xsl:if>
            </ul></li>
    </xsl:function>
    <xsl:function name="woposs:participant">
        <xsl:param name="seg"/>
        <li>Type: <xsl:value-of select="$seg/@type =&gt; replace('_', ' ')"/></li>
    </xsl:function>


    <!--    Main template -->

    <xsl:template match="tei:TEI">
        <xsl:variable name="s" select="descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $id]]"/>
        <xsl:variable name="contextLeft" select="                 for $x in 1 to 3                 return                     $s/preceding-sibling::tei:s[$x]"/>
        <xsl:variable name="contextRight" select="                 for $x in 1 to 3                 return                     $s/following-sibling::tei:s[$x]"/>
        <p><span style="color:red">Important</span>: Click on an element (coloured and bold words)
            to read its analysis. Hover over the words of those elements to get the lemma and
            morphological description.</p>
        <div class="containerResults">
            <div class="text">
                <xsl:apply-templates select="$contextLeft">
                    <xsl:sort order="descending" select="position()"/>
                </xsl:apply-templates>
                <xsl:apply-templates select="$s"/>
                <xsl:apply-templates select="$contextRight"/>
            </div>
            <div class="analysis">
                <xsl:apply-templates select="$contextLeft//tei:seg" mode="analysis"/>
                <xsl:apply-templates select="$s//tei:seg" mode="analysis"/>
                <xsl:apply-templates select="$contextRight//tei:seg" mode="analysis"/>
            </div>
        </div>
        <script type="text/javascript" src="../resources/scripts/marker.js"/>
    </xsl:template>
    <xsl:template match="tei:s">
        <p>
            <xsl:if test="descendant::tei:seg[substring(@ana, 2) eq $id]">
                <xsl:attribute name="class">selected</xsl:attribute>
            </xsl:if>
            <span class="n">[<xsl:value-of select="@n"/>]</span>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:seg">
        <span class="{current()/@function} seg" data-idno="{woposs:getId(current())}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:supplied">
        <span class="supplied">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:w[parent::tei:seg or descendant::tei:seg]">
        <span class="w">
            <xsl:apply-templates/>
            <span class="msd">
                <xsl:apply-templates select="self::node()" mode="msd"/>
            </span>
        </span>
    </xsl:template>
    <xsl:template match="tei:seg" mode="analysis">
        <xsl:choose>
            <xsl:when test="@part">
                <xsl:choose>
                    <xsl:when test="preceding::tei:seg[@part][@ana eq current()/@ana]"/>
                    <xsl:otherwise>
                        <xsl:call-template name="modalUnit_template"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="@function = ('marker', 'scope')">
                    <xsl:call-template name="modalUnit_template"/>

                </xsl:if>
                <xsl:if test="@function = ('negation', 'participant')">
                    <xsl:call-template name="ancillary_template"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="ancillary_template">
        <xsl:variable name="idno" select="woposs:getId(current())"/>
        <xsl:variable name="function" select="@function"/>
        <xsl:variable name="doc" select="ancestor::tei:TEI"/>
        <xsl:variable name="corresp" select="                 for $x in tokenize(@corresp, '\s+')                 return                     substring($x, 2)"/>
        <div id="{$idno}" class="hide">
            <xsl:if test="$function eq 'negation'">
                <h3>Negative particle: <xsl:value-of select="current()"/></h3>
                <ul>
                    <xsl:for-each select="$corresp">
                        <xsl:variable name="unit" select="$doc/descendant::tei:fs[@xml:id eq current()]"/>
                        <li>Negation of: <ul>
                                <li><xsl:value-of select="woposs:capitalize-first($unit/@type)"/>:
                                            <em><xsl:sequence select="woposs:unitContents($doc, current())"/></em>
                                </li>
                            </ul></li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
            <xsl:if test="$function eq 'participant'">
                <h3>Participant: <xsl:value-of select="current()"/></h3>
                <ul>
                    <xsl:sequence select="woposs:participant(current())"/>
                    <xsl:for-each select="$corresp">
                        <xsl:variable name="unit" select="$doc/descendant::tei:fs[@xml:id eq current()]"/>
                        <li>Participant of: <ul>
                                <li><xsl:value-of select="woposs:capitalize-first($unit/@type)"/>:
                                            <em><xsl:sequence select="woposs:unitContents($doc, current())"/></em></li>
                            </ul></li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template name="modalUnit_template">
        <xsl:variable name="idno" select="tokenize(woposs:getId(current()), '\s+')"/>
        <xsl:variable name="function" select="@function"/>
        <xsl:variable name="doc" select="ancestor::tei:TEI"/>
        <xsl:for-each select="$idno">
            <!--            enhancement: if scope is the same, only one-->
            <div id="{current()}" class="hide">
                <xsl:if test="$function eq 'marker'">
                    <h3>Marker: <xsl:sequence select="woposs:unitContents($doc, current())"/></h3>
                    <xsl:call-template name="marker-description">
                        <xsl:with-param name="fs" select="$doc/descendant::tei:fs[@xml:id eq current()]" as="node()"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="$function eq 'scope'">
                    <h3>Scope: <xsl:sequence select="woposs:unitContents($doc, current())"/></h3>
                    <xsl:call-template name="scope-description">
                        <xsl:with-param name="fs" select="$doc/descendant::tei:fs[@xml:id eq current()]" as="node()?"/>
                    </xsl:call-template>
                </xsl:if>
            </div>
        </xsl:for-each>

    </xsl:template>
    <xsl:template name="marker-description">
        <xsl:param name="fs" as="node()"/>
        <xsl:variable name="relations" select="$fs/ancestor::tei:TEI/descendant::tei:fs[tei:f/@fVal = $fs/@xml:id]"/>
        <ul>
            <xsl:choose>
                <xsl:when test="$fs/tei:f[@name eq 'pertinence']/tei:binary/@value eq 'true'">
                    <xsl:sequence select="woposs:marker($fs)"/>
                    <li>Modal relations: <xsl:value-of select="count($relations)"/><ol>
                            <xsl:for-each select="$relations">
                                <xsl:variable name="scopeFs" select="current()/ancestor::tei:TEI/descendant::tei:fs[@xml:id eq current()/tei:f[@name eq 'scope']/@fVal]"/>
                                <li>Scope and meaning: <ul>
                                        <li>Scope: <em><xsl:value-of select="woposs:unitContents(current()/ancestor::tei:TEI, $scopeFs/@xml:id)"/></em>
                                            <ul><xsl:sequence select="woposs:scope($scopeFs)"/></ul>
                                        </li>
                                        <xsl:sequence select="woposs:relation(current())"/>
                                    </ul></li>
                            </xsl:for-each></ol></li>
                </xsl:when>
                <xsl:otherwise>
                    <li>Pertinent: no</li>
                    <xsl:choose>
                        <xsl:when test="$fs/tei:f[@name eq 'modal']/tei:binary/@value eq 'true'">
                            <li>Modal: yes</li>
                        </xsl:when>
                        <xsl:otherwise>
                            <li>Modal: no</li>
                            <xsl:if test="$fs/tei:f[@name eq 'diachrony']">
                                <li>Diachrony: <xsl:value-of select="$fs/tei:f[@name eq 'diachrony']/tei:symbol/@value"/></li>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </ul>
    </xsl:template>

    <xsl:template name="scope-description">
        <xsl:param name="fs"/>
        <xsl:variable name="relations" select="$fs/ancestor::tei:TEI/descendant::tei:fs[tei:f/@fVal = $fs/@xml:id]"/>
        <ul>
            <xsl:sequence select="woposs:scope($fs)"/>
            <li>Modal relations: <xsl:value-of select="count($relations)"/><ol>
                    <xsl:for-each select="$relations">
                        <xsl:variable name="markerFs" select="current()/ancestor::tei:TEI/descendant::tei:fs[@xml:id eq current()/tei:f[@name eq 'marker']/@fVal]"/>
                        <li>Marker and meaning: <ul>
                                <li>Marker: <em><xsl:value-of select="woposs:unitContents(current()/ancestor::tei:TEI, $markerFs/@xml:id)"/></em>
                                    <ul><xsl:sequence select="woposs:marker($markerFs)"/></ul>
                                </li>
                                <xsl:sequence select="woposs:relation(current())"/>
                            </ul></li>
                    </xsl:for-each></ol></li>
        </ul>
    </xsl:template>

    <xsl:template match="tei:seg" mode="getContents">
        <xsl:apply-templates mode="getContents"/>
    </xsl:template>
    <xsl:template mode="getContents" match="tei:supplied">
        <span class="suppliedPlain">
            <xsl:apply-templates mode="getContents"/>
        </span>
    </xsl:template>
    <xsl:template match="tei:f[@name eq 'SoA']" mode="analysis">
        <xsl:text>None</xsl:text>
    </xsl:template>
    <xsl:template match="tei:f[@name eq 'dynamicity']" mode="analysis">
        <xsl:choose>
            <xsl:when test="tei:binary/@value eq 'true'">
                <xsl:text> +dynamic</xsl:text>
            </xsl:when>
            <xsl:when test="tei:binary/@value eq 'false'">
                <xsl:text> -dynamic</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> +/-dynamic</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:f[@name eq 'control']" mode="analysis">
        <xsl:choose>
            <xsl:when test="tei:binary/@value eq 'true'">
                <xsl:text> +control</xsl:text>
            </xsl:when>
            <xsl:when test="tei:binary/@value eq 'false'">
                <xsl:text> -control</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> +/-control</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:seg[@function eq 'participant']" mode="features">
        <li>
            <em>
                <xsl:value-of select="."/>
            </em>
        </li>
        <xsl:sequence select="woposs:participant(current())"/>
    </xsl:template>
    <xsl:template match="tei:f[@name eq 'participant']" mode="features">
        <li>Implicit</li>
        <li>Type: <xsl:value-of select="tei:symbol/@value =&gt; replace('_', ' ')"/></li>
    </xsl:template>
    
    
<!--   <xsl:template match="tei:w" mode="msd">
       <ul>
           <li>Lemma: <xsl:value-of select="@lemma"/></li>
           <li>PoS: <xsl:value-of select="@pos"/></li>
           <xsl:if test="@msd">
               <xsl:variable name="msd" select="ancestor::tei:TEI/descendant::tei:fs[@type eq 'msd'][@xml:id = substring(current()/@msd, 2)]"/>
          <xsl:for-each select="$msd/tei:f">
              <li><xsl:value-of select="current()/@name"/>: <xsl:value-of select="current()/tei:symbol/@value"/></li>
          </xsl:for-each>
           </xsl:if>
       </ul>
   </xsl:template>-->
    <xsl:template match="tei:w" mode="msd"><strong>Lemma</strong>: <em><xsl:value-of select="@lemma"/></em><br/>
        <strong>PoS</strong>: <xsl:value-of select="@pos"/><br/>
            <xsl:if test="@msd">
                <xsl:variable name="msd" select="ancestor::tei:TEI/descendant::tei:fs[@type eq 'msd'][@xml:id = substring(current()/@msd, 2)]"/>
                <xsl:for-each select="$msd/tei:f">
                    <strong><xsl:value-of select="current()/@name"/></strong>: <xsl:value-of select="current()/tei:symbol/@value"/><br/>
                </xsl:for-each>
            </xsl:if>
       
    </xsl:template>
</xsl:stylesheet>