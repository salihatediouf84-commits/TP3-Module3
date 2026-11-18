<?xml version="1.0" encoding="UTF-8"?>
<!--  matricule : ISEPAT202602912  Nom : Diassy Prénom :Fatou -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
<html>
<head>
<meta charset="UTF-8"/>
<title>Liste des étudiants</title>
</head>
<body>
<ul>
<xsl:apply-templates select="promotion/etudiant"/>
</ul>
</body>
</html>
</xsl:template>
<xsl:template match="etudiant">
<li>
<xsl:value-of select="prenom"/>
<xsl:text> </xsl:text>
<xsl:value-of select="nom"/>
</li>
</xsl:template>
</xsl:stylesheet>