<?xml version="1.0" encoding="UTF-8"?>

<!-- namespaces ajoutés -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    
    xmlns:sc="http://www.utc.fr/ics/scenari/v3/core"
    xmlns:sp="http://www.utc.fr/ics/scenari/v3/primitive"
    xmlns:op="utc.fr:ics/opale3">
        
    <!-- cas d'une activité d'apprentissage (avec contenu externe) -->
    <xsl:template match="sp:courseUa[@sc:refUri]">
        <!-- se copie soit même -->
        <xsl:copy>
            <!-- à faire : copier seulement ce qui est dans la balise sc:item du fichier distant -->
            <xsl:apply-templates select="document(./@sc:refUri)/sc:item/*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- cas d'un grain de contenu (avec contenu externe) -->
    <xsl:template match="sp:courseUc[@sc:refUri]">
        <!-- se copie soit même -->
        <xsl:copy>
           <!-- avec comme contenu ce qui se trouve dans la balise sc:item du fichier distant -->
            <xsl:apply-templates select="document(./@sc:refUri)/sc:item/*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- si j'ai un node de type attribut appelé sc:refUri -->
    <!--<xsl:template match="*[@sc:refUri]"> -->
    <!-- ne pas recopier l'élement ? -->
    <!-- avec comme contenu le fichier distant -->
    <!-- <xsl:apply-templates select="document(./@sc:refUri)/*"/> -->   
    <!--</xsl:template>-->
    
    <!-- pour tous les autres noeuds -->
    <!-- les blocs ne peuvent être externalisés -->
    <xsl:template match="node()|@*">
        <!-- se copie soit même -->
        <xsl:copy>
            <!-- récursion sur tous les autres noeuds -->
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
