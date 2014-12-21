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
                <meta charset="utf-8"/>
                <meta name="generator" content="HdocConverter/Opale3.4"/>
                <xsl:apply-templates select="op:uM/sp:info"/>
            </head>
            <body>
                <section>
                    <header>
                        <h1><xsl:apply-templates select="op:uM/sp:title"/></h1>
                        <xsl:apply-templates select="sp:intro"/>
                    </header>                    
                    <xsl:apply-templates select="node()[not(self::op:uM/sp:title or self::sp:intro)]"/>
                </section>   
            </body>
        </html> 
    </xsl:template>
    
    <!-- Title of Autoevaluation -->
    <xsl:template match="op:uM/sp:title">
        <xsl:value-of select="."/>        
    </xsl:template>
    
    <!-- Question Title -->
    <xsl:template match="op:exeM/sp:title">
        <xsl:value-of select="."/>
    </xsl:template>
        
    <!-- TODO? -->
    <xsl:template match="sp:obj"/>  
    
    <!-- Metadata -->
    <xsl:template match="sp:info | op:info">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="sp:keywds | op:keywds">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="sp:keywd">
        <meta name="keywords">
            <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
        </meta>
    </xsl:template>
    
    <xsl:template match="sp:cpyrgt">
        <meta name="rights">
            <xsl:attribute name="content"><xsl:value-of select="op:sPara/sc:para"/></xsl:attribute>
        </meta>
    </xsl:template>
     
     <xsl:template match="sp:cc"/>
    
     <!-- Introduction of autoevaluation -->
    <xsl:template match="sp:intro">
        <div data-hdoc-type="introduction">
            <xsl:value-of select="descendant::node()/sc:para"/>
        </div>
    </xsl:template>
    
    <xsl:template match="sp:quiz">
        <xsl:apply-templates/>
    </xsl:template>    
    
    <!-- Multiple or Unique Choice Questions -->
    <xsl:template match="op:mcqMur | op:mcqSur">
        <section data-hdoc-type="multiple-choice-question">
            <header>
                <h1><xsl:apply-templates select="op:exeM/sp:title"/></h1>
            </header>            
            <xsl:apply-templates select="node()[not(self::op:exeM/sp:title)]"/>
        </section>
    </xsl:template>
    
    <!-- Question -->    
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
        <xsl:for-each select="sc:choice">
            <div>
                <!-- The type of division depends if the choice is correct or not. -->
                <xsl:choose>
                    <xsl:when test="@solution='checked' or ../../sc:solution/@choice=position()"> 
                        <xsl:attribute name="data-hdoc-type">choice-correct</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="data-hdoc-type">choice-incorrect</xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>            
                <xsl:apply-templates/>             
            </div>
        </xsl:for-each> 
        
        <xsl:if test="../sc:globalExplanation">
            <xsl:apply-templates select="sc:globalExplanation"/>
        </xsl:if>
    </xsl:template>    
    
    <xsl:template match="sc:choice">
        <p><xsl:value-of select="node()[not(self::sc:choiceExplanation)]"/></p>
    </xsl:template>
    
    <!-- Division with the explanations of each choice and the global explanation. -->
    <xsl:template match="sc:globalExplanation">
        <div data-hdoc-type="explanation">
            <h6>Global Explanation</h6>            
            <xsl:apply-templates select="preceding-sibling::node()/descendant::node()/sc:choiceExplanation"/>
            <p><xsl:value-of select="descendant::node()/sc:para"/></p>
        </div>
    </xsl:template>    
  
    <xsl:template match="sc:choiceExplanation">
        <p><xsl:value-of select="."/></p> 
    </xsl:template>
       
    <!-- Fill in the blank quizzes -->
    <xsl:template match="op:cloze">
        <section data-hdoc-type="fill-in-the-blank">
            <header>
                <h1><xsl:apply-templates select="op:exeM/sp:title"/></h1>
            </header>
            <xsl:apply-templates select="node()[not(self::op:exeM/sp:title)]"/>
        </section>
    </xsl:template>
    
    <xsl:template match="sc:gapTxt">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="op:txt">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="op:clozeTxt">
        <div data-hdoc-type="question">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- A blank is added as a span -->
    <xsl:template match="sc:textLeaf[@role='gap']">
        <span data-hdoc-type="blank">
            <xsl:value-of select="."/>
        </span>
    </xsl:template> 
    
    <!-- Paragraphs and text styles -->
    <xsl:template match="sc:para">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="sc:inlineStyle[@role='emp']">
        <em><xsl:value-of select="."/></em>
    </xsl:template>
    
    <xsl:template match="sc:inlineStyle[@role='ind']">
        <sub><xsl:value-of select="."/></sub>
    </xsl:template>
    
    <xsl:template match="sc:inlineStyle[@role='exp']">
        <sup><xsl:value-of select="."/></sup>
    </xsl:template>
    
    <xsl:template match="sc:inlineStyle[@role='spec']">
        <i><xsl:value-of select="."/></i>
    </xsl:template>
    
    <!-- TODO - What to do with consigne in fill in the blank? -->
</xsl:stylesheet>