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
    
    <!-- MODULE  -->
    <xsl:template match="op:ue">
        
        <!-- RNG -->
        <xsl:processing-instruction name="oxygen">
            RNGSchema="http://scenari.utc.fr/hdoc/schemas/xhtml/hdoc1-xhtml.rng" type="xml"
        </xsl:processing-instruction>
        
        <!-- HTML -->
        <html>
            
            <!-- MODULE"s HEADER -->
            <head>
                <xsl:apply-templates select="op:ueM/sp:title"/>
                <meta charset="utf-8"/>
                <meta generator="HdocConverter/Opale3.4"/>
                <xsl:apply-templates select="op:ueM/sp:info"/>
            </head>
            
            <!-- MODULE's COMPONENTS  -->
            <body>
                <xsl:apply-templates select="child::*[name() != 'op:ueM']"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Information -->
    <xsl:template match="op:ueM/sp:info">
        <xsl:apply-templates select="op:info/sp:keywds/op:keywds/sp:keywd" />
        <xsl:apply-templates select="op:info/sp:cc" />
        <xsl:apply-templates select="op:info/sp:cpyrgt/op:sPara/sc:para" />
    </xsl:template>
    
    <!-- Titles -->
    <xsl:template match="op:uM/sp:title | op:expUcDivM/sp:title">
        <h1><xsl:value-of select="." /></h1>
    </xsl:template>
    <xsl:template match="op:ueM/sp:title">
        <title><xsl:value-of select="." /></title>
    </xsl:template>
    <xsl:template match="op:pbTi/sp:title">
        <h6><xsl:value-of select="." /></h6>
    </xsl:template>
    
    <!-- Subtitle -->
    <xsl:template match="op:uM/sp:sTitle">
        <h2><xsl:value-of select="." /></h2>
    </xsl:template>
        
    <!-- Liscences -->
    <xsl:template match="op:ueM/sp:info/op:info/sp:cc">
        <meta name="rights" content="{.}" />
    </xsl:template>
    <xsl:template match="op:uM/sp:info/op:info/sp:cc">
        <div data-hdoc-type="rights">
            <xsl:value-of select="." />
        </div>
    </xsl:template>
    
    <!-- Keywords -->
    <xsl:template match="op:ueM/sp:info/op:info/sp:keywds/op:keywds/sp:keywd">
        <meta name="keywords" content="{.}" />
    </xsl:template>
    <xsl:template match="op:uM/sp:info/op:info/sp:keywds">
        <div data-hdoc-type="tags">
            <xsl:apply-templates select="./op:keywds/sp:keywd" />
        </div>
    </xsl:template>
    <xsl:template match="op:uM/sp:info/op:info/sp:keywds/op:keywds/sp:keywd">
        <span><xsl:value-of select="." /></span>
    </xsl:template>
    
    <!-- Author -->
    <xsl:template match="op:ueM/sp:info/op:info/sp:cpyrgt/op:sPara/sc:para">
        <meta name="author" content="{.}" />
    </xsl:template>
    <xsl:template match="op:uM/sp:info/op:info/sp:cpyrgt/op:sPara/sc:para">
        <div data-hdoc-type="author">
            <xsl:value-of select="." />
        </div>
    </xsl:template>
      
    <!-- Activity -->
    <xsl:template match="sp:courseUa">
        <section>
            <header>
                <xsl:apply-templates select="./op:courseUa/op:uM/sp:title"/>
                <xsl:apply-templates select="./op:courseUa/op:uM/sp:info/op:info/sp:cpyrgt/op:sPara/sc:para"/>
                <xsl:apply-templates select="./op:courseUa/op:uM/sp:info/op:info/sp:cc"/>
            </header>
            
            <!-- currently : grain & introduction & conclusion -->
            <xsl:apply-templates select="./op:courseUa/child::*[name() != 'op:uM'][name() != 'sp:quest']"/>
           
            <!-- overview questions : regroup questions into a section-->
            <xsl:if test="./op:courseUa/sp:quest">
                <section>
                    <header>
                        <h1>Questions de synthèse</h1>
                    </header>
                    <!-- a conclusion has only a bloc -->
                    <div>
                        <xsl:apply-templates select="./op:courseUa/sp:quest" />
                    </div>          
                </section>
            </xsl:if>
            
            <footer>
                <xsl:apply-templates select="./op:courseUa/op:uM/sp:info/op:info/sp:keywds"/>
            </footer> 
        </section>
    </xsl:template>
    
    <!-- Grain -->
    <xsl:template match="sp:courseUc">
        <section>
            <header>
                <xsl:apply-templates select="./op:expUc/op:uM/sp:title"/>
                <xsl:apply-templates select="./op:expUc/op:uM/sp:info/op:info/sp:cpyrgt/op:sPara/sc:para"/>
                <xsl:apply-templates select="./op:expUc/op:uM/sp:info/op:info/sp:cc"/>
            </header>
            
            <!-- call for blocs and parts -->
            <xsl:apply-templates select="./op:expUc/child::*[name() != 'op:uM']"/>
            
            <footer>
                <xsl:apply-templates select="./op:expUc/op:uM/sp:info/op:info/sp:keywds"/>
            </footer>                  
        </section>
    </xsl:template>
    
    <!-- Introduction (a introduction doesn't have metadata) -->
    <xsl:template match="sp:intro">
        <section data-hdoc-type="introduction">
            <header>
                <h1>Introduction</h1>
            </header>
            <!-- a introduction has only a bloc -->
            <div>
                <xsl:apply-templates select="./op:res/*"/>
            </div>          
        </section>
    </xsl:template>
    
    <!-- Conclusion (a conclusion doesn't have metadata) -->
    <xsl:template match="sp:conclu">
        <section data-hdoc-type="conclusion">
            <header>
                <h1>Conclusion</h1>
            </header>
            <!-- a conclusion has only a bloc -->
            <div>
                <xsl:apply-templates select="./op:res/*"/>
            </div>          
        </section>
    </xsl:template>
    
    <!-- Overview questions (fr : question de synthèse) -->
    <xsl:template match="sp:quest">
        <xsl:apply-templates select="./op:txt/*"/>
    </xsl:template>
    
    <!-- Parts (of a Grain) -->
    <xsl:template match="sp:div">
        <section>
            <header>
                <!-- only title - parts don't have other metadata -->
                <xsl:apply-templates select="./op:expUcDiv/op:expUcDivM/sp:title"/>
            </header>
            
            <!-- a part can contain blocs and other parts -->
            <xsl:apply-templates select="./op:expUcDiv/child::*[name() != 'op:expUcDivM']"/> 
            
        </section>
    </xsl:template>

    
    <!-- ***** BLOCS START ***** -->
    
    <!-- content Information : no microformat -->
    <xsl:template match="sp:pb/op:pb/sp:info">
        <div>
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />                
        </div>
    </xsl:template>
    <!-- content definition : definition -->
    <xsl:template match="sp:pb/op:pb/sp:def">
        <div data-hdoc-type="definition">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- content example : example -->
    <xsl:template match="sp:pb/op:pb/sp:ex">
        <div data-hdoc-type="example">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- content remark : remark -->
    <xsl:template match="sp:pb/op:pb/sp:rem">
        <div data-hdoc-type="remark">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- content advice : advice -->
    <xsl:template match="sp:pb/op:pb/sp:adv">
        <div data-hdoc-type="advice">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- content warning : warning -->
    <xsl:template match="sp:pb/op:pb/sp:warning">
        <div data-hdoc-type="warning">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- content complement : complement -->
    <xsl:template match="sp:pb/op:pb/sp:comp">
        <div data-hdoc-type="complement">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- content method : advice -->
    <xsl:template match="sp:pb/op:pb/sp:meth">
        <div data-hdoc-type="advice">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- contenu review : complement -->
    <xsl:template match="sp:pb/op:pb/sp:remind">
        <div data-hdoc-type="complement">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    <!-- content fondamental : emphasis -->
    <xsl:template match="sp:pb/op:pb/sp:basic">
        <div data-hdoc-type="emphasis">
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />            
        </div>
    </xsl:template>
    
    <!-- content syntax : no microformat (we lose this information) -->
    <xsl:template match="sp:pb/op:pb/sp:syntax">
        <div>
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />                
        </div>
    </xsl:template>
    <!-- content legal :  no microformat (we lose this information) -->
    <xsl:template match="sp:pb/op:pb/sp:legal">
        <div>
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />                
        </div>
    </xsl:template>
    <!-- content simulation :  no microformat (we lose this information) -->
    <xsl:template match="sp:pb/op:pb/sp:simul">
        <div>
            <xsl:apply-templates select="./op:pbTi/sp:title" />
            <xsl:apply-templates select="op:res/*" />                
        </div>
    </xsl:template>
    
    <!-- ***** BLOCS END ***** -->
    
    <!-- ***** TEXT START ***** -->
    
    <!-- Simple text -->
    <xsl:template match="op:res/sp:txt">
        <xsl:apply-templates select="./op:txt/*" />
    </xsl:template>
    
        <!-- Paragraph -->
        <xsl:template match="sc:para">
            <p>
                <xsl:apply-templates select="./* | ./text()" />
            </p>
        </xsl:template>
    
            <!-- ***** PARAGRAPH ITEMS START ***** -->
    
            <!-- citation -->
            <xsl:template match="sc:para/sc:inlineStyle[@role='quote']" priority="2">
            <q>
                <xsl:value-of select="." />
            </q>
            </xsl:template>
            <!-- important -->
            <xsl:template match="sc:para/sc:inlineStyle[@role='emp']" priority="2">
            <em>
                <xsl:value-of select="." />
            </em>
            </xsl:template>
            <!-- foreign term -->
            <xsl:template match="sc:para/sc:inlineStyle[@role='spec']" priority="2">
            <i>
              <xsl:value-of select="." />
            </i>
            </xsl:template>
            <!-- syntax -->
            <xsl:template match="sc:para/sc:inlineStyle[@role='code']" priority="2">
            <span data-hdoc-type="syntax">
              <xsl:value-of select="." />
            </span>
            </xsl:template>
            <!-- email or url -->
            <xsl:template match="sc:para/sc:uLink" priority="2">
            <a href="{./@url}">
              <xsl:value-of select="." />
            </a>
            </xsl:template>
            <!-- exponent -->
            <xsl:template match="sc:para/sc:textLeaf[@role='exp']" priority="2">
            <sup>
              <xsl:value-of select="." />
            </sup>
            </xsl:template>
            <!-- subscript -->
            <xsl:template match="sc:para/sc:textLeaf[@role='ind']" priority="2">
            <sub>
              <xsl:value-of select="." />
            </sub>
            </xsl:template>
            <!-- latex -->
            <xsl:template match="sc:para/sc:textLeaf[@role='mathtex']" priority="2">
                <span data-hdoc-type="latex">
                    <xsl:value-of select="." />
                </span>
            </xsl:template>
            <!-- default behaviour for other balises -->
            <xsl:template match="sc:para/sc:inlineStyle|sc:para/sc:textLeaf" priority="1">
                <xsl:value-of select="." />
            </xsl:template>
    
            <!-- ***** PARAGRAPH ITEMS END ***** -->

        <!-- List-->
        <xsl:template match="sc:itemizedList">
            <ul>
                <xsl:apply-templates select="./sc:listItem" />
            </ul>
        </xsl:template>
    
        <!-- Ordered list -->
        <xsl:template match="sc:orderedList">
            <ol>
                <xsl:apply-templates select="./sc:listItem" />
            </ol>
        </xsl:template>
    
            <!-- ***** LIST ITEMS START ***** -->
        
             <!-- List item -->
             <xsl:template match="sc:listItem">
                 <li>
                     <xsl:apply-templates select="./*" />
                 </li>
             </xsl:template>
             
            <!-- ***** LIST ITEMS END ***** -->
    
        <!-- Table -->
        <xsl:template match="sc:table">
               <table>
                   <xsl:apply-templates select="./*" />
               </table>
        </xsl:template>
    
            <!-- ***** TABLE ITEMS START ***** -->
    
            <!-- caption -->
            <xsl:template match="sc:table/sc:caption">
                <caption>
                    <xsl:value-of select="."></xsl:value-of>
                </caption>
            </xsl:template>
            <!-- table row -->
            <xsl:template match="sc:table/sc:row">
                <tr>
                    <xsl:apply-templates select="./*" />
                </tr>
            </xsl:template>
            <!-- table cell -->
            <xsl:template match="sc:table/sc:row/sc:cell">
                <td>
                    <xsl:apply-templates select="./*" />
                </td>
            </xsl:template>
    
            <!-- ***** TABLE ITEMS END ***** -->
    
    <!-- ***** TEXT END ***** -->
    
</xsl:stylesheet>
