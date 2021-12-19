<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:param name="id"/>
    <xsl:template match="tei:TEI">
        <xsl:variable name="s" select="descendant::tei:s[descendant::tei:seg[substring(@ana, 2) eq $id]]"/>
        <xsl:variable name="contextLeft" select="                 for $x in 1 to 3                 return                     $s/preceding-sibling::tei:s[$x]"/>
        <xsl:variable name="contextRight" select="                 for $x in 1 to 3                 return                     $s/following-sibling::tei:s[$x]"/>
        <p><span style="color:red">Important</span>: Click on a marker (purple) to read its
            analysis. This same functionality will be available for any other component in the
            future.</p>
        <div class="containerResults">
            <div class="text">
                <xsl:apply-templates select="$contextLeft"/>
                <xsl:apply-templates select="$s"/>
                <xsl:apply-templates select="$contextRight"/>
            </div>
            <div class="analysis">
                <xsl:apply-templates select="$contextLeft//tei:seg[@function eq 'marker']" mode="analysis"/>
                <xsl:apply-templates select="$s//tei:seg[@function eq 'marker']" mode="analysis"/>
                <xsl:apply-templates select="$contextRight//tei:seg[@function eq 'marker']" mode="analysis"/>
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
        <span class="{current()/@function} {substring(@corresp, 2)}" data-idno="{substring(@ana, 2)}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:supplied">
        <span class="supplied">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:w[tei:seg]">
        <span class="w">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template mode="analysis" match="tei:seg[@function eq 'marker'][not(@part)]">
        <xsl:call-template name="marker-description"/>
    </xsl:template>
    <xsl:template mode="analysis" match="tei:seg[@function eq 'marker'][@part]">
        <xsl:choose>
            <xsl:when test="preceding::tei:seg[@part][@ana eq current()/@ana]"/>
            <xsl:otherwise>
                <xsl:call-template name="marker-description"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="marker-description">
        <xsl:variable name="s" select="ancestor::tei:s"/>
        <xsl:variable name="idno" select="substring(@ana, 2)"/>
        <xsl:variable name="fs" select="ancestor::tei:TEI/descendant::tei:fs[@xml:id eq $idno]"/>
        <xsl:variable name="relations" select="ancestor::tei:TEI/descendant::tei:fs[tei:f[@name eq 'marker']/@fVal = $idno]"/>
        <div id="{$idno}" class="hide">
            <h3>Marker: <xsl:value-of select="$s/descendant::tei:seg[@ana eq current()/@ana]"/></h3>
            <ul>
                <xsl:choose>
                    <xsl:when test="$fs/tei:f[@name eq 'pertinence']/tei:binary/@value eq 'true'">
                        <xsl:variable name="lemma_string" select="$fs/tei:f[@name eq 'lemma']/tei:symbol/@value"/>
                        <xsl:variable name="lemma" select="                                 if (contains($lemma_string, '_inf')) then                                     replace($lemma_string, '_inf', ' + inf.')                                 else                                     replace($lemma_string, '_', ' ')"/>
                        <li>Pertinent: yes</li>
                        <li>Lemma: <xsl:value-of select="$lemma"/></li>
                        <li>Type of utterance: <xsl:value-of select="$fs/tei:f[@name eq 'utterance']/tei:symbol/@value"/></li>
                        <li>Polarity: <xsl:value-of select="$fs/tei:f[@name eq 'polarity']/tei:symbol/@value"/></li>
                        <li>Modal relations:<ol>
                                <xsl:for-each select="$relations">
                                    <xsl:variable name="scopeFs" select="ancestor::tei:TEI/descendant::tei:fs[@xml:id eq current()/tei:f[@name eq 'scope']/@fVal]"/>
                                    <xsl:variable name="scopeId" select="$scopeFs/@xml:id"/>
                                    <xsl:variable name="scopeSegs" select="ancestor::tei:TEI/descendant::tei:seg[@function eq 'scope'][substring(@ana, 2) eq $scopeId]"/>
                                    <li>Description: <ul>
                                            <li>Scope: <em><xsl:apply-templates select="$scopeSegs" mode="scope"/></em>
                                                <ul>
                                                  <li>Type of utterance: <xsl:value-of select="$scopeFs/tei:f[@name eq 'utterance']/tei:symbol/@value"/></li>
                                                  <li>Polarity: <xsl:value-of select="$scopeFs/tei:f[@name eq 'polarity']/tei:symbol/@value"/></li>
                                                  <li>State of affairs: <ul>
                                                  <li><xsl:apply-templates select="$scopeFs/tei:f[@name = ('SoA', 'dynamicity', 'control')]" mode="analysis"/></li>
                                                  <li>Participant: <xsl:choose>
                                                  <xsl:when test="$scopeFs/tei:f[@name eq 'participant']">
                                                  <xsl:apply-templates select="$scopeFs/tei:f[@name eq 'participant']" mode="analysis"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:variable name="participant" select="ancestor::tei:TEI/descendant::tei:seg[@function eq 'participant'][substring(@corresp, 2) eq $scopeId]"/>
                                                  <xsl:for-each select="$participant">
                                                  <ul>
                                                  <xsl:apply-templates select="current()" mode="analysis"/>
                                                  </ul>
                                                  </xsl:for-each>
                                                  </xsl:otherwise>
                                                  </xsl:choose></li>
                                                  </ul></li>
                                                </ul></li>
                                            <li>Modal meaning: <xsl:value-of select="current()/tei:f[@name eq 'modality']/tei:symbol/@value"/>
                                                <ul>
                                                  <xsl:if test="current()/tei:f[@name eq 'meaning']">
                                                  <li>Meaning: <xsl:value-of select="current()/tei:f[@name eq 'meaning']/tei:symbol/@value"/></li></xsl:if>
                                                  <xsl:if test="current()/tei:f[@name eq 'type']">
                                                  <li>Type: <xsl:value-of select="current()/tei:f[@name eq 'type']/tei:symbol/@value"/></li></xsl:if>
                                                  <xsl:if test="current()/tei:f[@name eq 'subtype']">
                                                  <li>Subtype: <xsl:value-of select="current()/tei:f[@name eq 'subtype']/tei:symbol/@value"/></li></xsl:if>
                                                  <xsl:if test="current()/tei:f[@name eq 'degree']">
                                                  <li>Degree: <xsl:value-of select="current()/tei:f[@name eq 'degree']/tei:symbol/@value"/></li></xsl:if>
                                                  <xsl:if test="current()/tei:f[@name eq 'context']">
                                                  <li>Context: <xsl:value-of select="current()/tei:f[@name eq 'context']/tei:symbol/@value =&gt; replace('_', ' ')"/></li></xsl:if>
                                                  <xsl:if test="current()/tei:f[@name eq 'source']">
                                                  <li>Source: <xsl:value-of select="current()/tei:f[@name eq 'source']/tei:symbol/@value =&gt; replace('_', ' ')"/></li></xsl:if>
                                                </ul></li>
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
        </div>

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
    <xsl:template match="tei:seg[@function eq 'participant']" mode="analysis">
        <li>
            <em>
                <xsl:value-of select="."/>
            </em>
        </li>
        <li>Type: <xsl:value-of select="@type =&gt; replace('_', ' ')"/></li>
    </xsl:template>
    <xsl:template match="tei:f[@name eq 'participant']" mode="analysis">
        <li>Implicit</li>
        <li>Type: <xsl:value-of select="tei:symbol/@value =&gt; replace('_', ' ')"/></li>
    </xsl:template>
</xsl:stylesheet>