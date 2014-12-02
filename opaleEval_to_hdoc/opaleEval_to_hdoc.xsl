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
                    <header>
                        <h1><xsl:apply-templates select="op:uM/sp:title"/></h1>
                    </header>
                    <!-- TODO : author, date, rights -->
                    <xsl:apply-templates select="node()[not(self::op:uM/sp:title)]"/>
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
        <xsl:value-of select="."/>
    </xsl:template>
        
    <!-- TODO -->
    <xsl:template match="sp:obj"/>    
     
    <xsl:template match="sp:intro">
        <section data-hdoc-type="introduction">
            <header>
                <h1>Introduction</h1>
            </header>
            <div>
                <p><xsl:value-of select="descendant::node()/sc:para"/></p>
            </div>
        </section>
    </xsl:template>
    
    <xsl:template match="sp:quiz">
        <section data-hdoc-type="quiz">
            <!-- TODO? -->
            <xsl:apply-templates/>
        </section>
    </xsl:template>    

    <!-- TYPES OF QUESTIONS -->
    
    <!-- Multiple Choice Question (QCM) -->
    <xsl:template match="op:mcqMur">
        <section data-hdoc-type="mcqMur">
            <header>
                <h1><xsl:apply-templates select="op:exeM/sp:title"/></h1>
            </header>            
            <xsl:apply-templates select="node()[not(self::op:exeM/sp:title)]"/>
        </section>
    </xsl:template>
    
    <!-- Unique Choice Question (QCU) -->
    <xsl:template match="op:mcqSur">
        <section data-hdoc-type="mcqSur">
            <header>
                <h1><xsl:apply-templates select="op:exeM/sp:title"/></h1>
            </header>
            <xsl:apply-templates select="node()[not(self::op:exeM/sp:title)]"/>            
        </section>
    </xsl:template>
    
    <!-- A single question in a quiz -->    
    <xsl:template match="sc:question">
        <div data-hdoc-type="question">
            <h6>Question</h6>
            <xsl:apply-templates select="op:res"/>            
        </div>
    </xsl:template>
    
    <xsl:template match="op:res">
        <p><xsl:value-of select="descendant::node()/sc:para"/></p>
    </xsl:template>
    
    <!-- Answers -->
    
    <xsl:template match="sc:choices">
        <div data-hdoc-type="choices">
            <ul>
                <xsl:for-each select="sc:choice">
                    <li><xsl:apply-templates select="."/></li>
                </xsl:for-each>
            </ul>
           <!-- <xsl:apply-templates select="sc:choice"/> -->
        </div>
        
        <div data-hdoc-type="solution">            
            
            <h6>Solution</h6>
            
            <!-- In multiple choice, each response checked is displayed. -->
            <xsl:for-each select="sc:choice[@solution='checked']">
                <p><xsl:value-of select="node()[not(self::sc:choiceExplanation)]"/></p>
                <xsl:if test="sc:choiceExplanation">
                    <p><xsl:value-of select="sc:choiceExplanation"/></p>    
                </xsl:if>
                <!-- TODO - explination in different section -->
            </xsl:for-each>
            
            <!-- Solution for unique choice. -->
            <xsl:for-each select="sc:choice">
                <xsl:if test="../../sc:solution/@choice=position()">
                    <p><xsl:value-of select="node()[not(self::sc:choiceExplanation)]"/></p>
                    <xsl:if test="sc:choiceExplanation">
                        <p><xsl:value-of select="sc:choiceExplanation"/></p>    
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
            
            <xsl:if test="../sc:globalExplanation">
                <xsl:apply-templates select="sc:globalExplanation"/>
            </xsl:if>
        </div>
        
    </xsl:template>
    
    
    <xsl:template match="sc:globalExplanation">
        <div>
            <h6>Global Explanation</h6>
            <p><xsl:value-of select="descendant::node()/sc:para"/></p>
        </div>
    </xsl:template>
    
  
    <xsl:template match="sc:choice">
        <p><xsl:value-of select="node()[not(self::sc:choiceExplanation)]"/></p>
    </xsl:template> 
    
</xsl:stylesheet>