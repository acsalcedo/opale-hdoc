<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:op="utc.fr:ics/opale3">
    

    <xsl:template match="sc:item">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="sp:quiz[@sc:refUri]">
        <xsl:apply-templates select="document(./@sc:refUri)/sc:item/*"/>
    </xsl:template>
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
