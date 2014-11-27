<?xml version="1.0" encoding="UTF-8"?>

<!-- Namespaces -->
<xsl:stylesheet 
    xmlns="http://www.utc.fr/ics/hdoc/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:op="utc.fr:ics/opale3">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Autoevaluation - Opale Module -->
    <xsl:template match="op:assmntUa">
        
        <!-- RNG Schema Instruction -->
        <xsl:processing-instruction name="oxygen">
            RNGSchema="http://scenari.utc.fr/hdoc/schemas/xhtml/hdoc1-xhtml.rng" type="xml"
        </xsl:processing-instruction>
        
        <html>
            <head>                
                <title><xsl:apply-templates select="op:uM/sp:title"/></title>
            </head>
            
            <body>
                <section data-hdoc-type="assmntUa">             
                    <xsl:apply-templates/>
                </section>   
            </body>
        </html>
        
        
    </xsl:template>
    
    <!-- Title of Autoevaluation -->
    <xsl:template match="op:uM/sp:title">
        <xsl:value-of select="."/>        
    </xsl:template>
    
    <!-- mcqMur Title -->
    <xsl:template match="op:exeM/sp:title">
        <h2><xsl:value-of select="."/></h2>
    </xsl:template>
        
    <xsl:template match="sp:intro">
        <section data-hdoc-type="introduction">
            <!-- TODO -->
        </section>
    </xsl:template>
    
    <xsl:template match="sp:quiz">
        <section data-hdoc-type="quiz">
            <!-- TODO -->
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    

    <!-- TYPES OF QUESTIONS -->
    
    <!-- Multiple Choice Question (QCM) -->
    <xsl:template match="op:mcqMur">
        <section data-hdoc-type="mcqMur">
            <xsl:apply-templates/>
            <!-- TODO -->
        </section>
    </xsl:template>
    
    <!-- Unique Choice Question (QCU) -->
    <xsl:template match="op:mcqSur">
        <section data-hdoc-type="mcqSur">
            <xsl:apply-templates/>
            <!-- TODO -->
        </section>
    </xsl:template>
    
    
    <!-- A single question in a quiz -->    
    <xsl:template match="sc:question">
        <div data-hdoc-type="question">
            <!-- TODO -->
            
        </div>
    </xsl:template>
    
    
    <!-- Answers -->
    
    <xsl:template match="sc:choices">
        <div data-hdoc-type="choices">
            <xsl:apply-templates select="sc:choice"/>
        </div>
        
        <div data-hdoc-type="solution">            
            
            <h2>Solution</h2>
            
            <!-- In multiple choice, each response checked is displayed. -->
            <xsl:for-each select="sc:choice[@solution='checked']">
                <p><xsl:value-of select="."/></p>
                <!-- TODO - explination in different section -->
            </xsl:for-each>
            
            <!-- Solution for unique choice. -->
            <xsl:for-each select="sc:choice">
                <xsl:if test="../../sc:solution/@choice=position()">
                    <p><xsl:value-of select="."/></p>
                    <!-- TODO - explination in different section -->
                </xsl:if>
            </xsl:for-each>
        </div>
        
    </xsl:template>
    
    <xsl:template match="sc:choice">
        <div data-hdoc-type="choice">
            <h6><xsl:value-of select="."/></h6>
            <!-- TODO -->
        </div>
    </xsl:template>
    
</xsl:stylesheet>