<?xml version="1.0" encoding="UTF-8"?>
<!--  matricule /ISEPAT202602912 — Nom :Diassy Prénom :Fatou -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<!--  Étape 5 : seuil modifiable en un seul endroit  -->
<xsl:param name="seuil" select="10"/>
<!--  Étape 8 : regroupement par classe  -->
<xsl:key name="par-classe" match="etudiant" use="@classe"/>
<xsl:template match="/promotion">
<html lang="fr">
<head>
<meta charset="UTF-8"/>
<title>
Promotion
<xsl:value-of select="@filiere"/>
</title>
<link rel="stylesheet" href="style.css"/>
</head>
<body>
<header>
<h1>
Promotion
<xsl:value-of select="@filiere"/>
</h1>
<p>
Année
<xsl:value-of select="@annee"/>
</p>
</header>
<main>
<!--  Étape 7 : chiffres clés  -->
<div class="stats">
<div class="carte">
<span class="valeur">
<xsl:value-of select="count(etudiant)"/>
</span>
<span class="legende">étudiants</span>
</div>
<div class="carte">
<span class="valeur">
<xsl:value-of select="count(etudiant[sum(notes/note) div count(notes/note) >= $seuil])"/>
</span>
<span class="legende">
admis (moyenne ≥
<xsl:value-of select="$seuil"/>
)
</span>
</div>
<div class="carte">
<span class="valeur">
<xsl:value-of select="format-number(sum(etudiant/notes/note[@matiere='XML']) div count(etudiant/notes/note[@matiere='XML']), '0.00')"/>
</span>
<span class="legende">moyenne en XML</span>
</div>
<div class="carte">
<span class="valeur">
<xsl:value-of select="count(etudiant[not(email)])"/>
</span>
<span class="legende">emails manquants</span>
</div>
</div>
<!--  Étape 8 : un tableau par classe (méthode muenchienne)  -->
<xsl:for-each select="etudiant[generate-id() = generate-id(key('par-classe', @classe)[1])]">
<xsl:sort select="@classe"/>
<xsl:variable name="groupe" select="key('par-classe', @classe)"/>
<h2>
Classe
<xsl:value-of select="@classe"/>
(
<xsl:value-of select="count($groupe)"/>
étudiants)
</h2>
<table>
<thead>
<tr>
<th>Rang</th>
<th>Matricule</th>
<th>Nom</th>
<th>Prénom</th>
<th>Classe</th>
<th>Email</th>
<th>Moyenne</th>
<th>Résultat</th>
</tr>
</thead>
<tbody>
<xsl:apply-templates select="$groupe">
<!--  Étape 6 : tri numérique décroissant  -->
<xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending"/>
</xsl:apply-templates>
</tbody>
</table>
</xsl:for-each>
</main>
<footer>Page générée par XSLT à partir de etudiants.xml</footer>
</body>
</html>
</xsl:template>
<xsl:template match="etudiant">
<xsl:variable name="moy" select="sum(notes/note) div count(notes/note)"/>
<tr>
<xsl:if test="position() = 1">
<xsl:attribute name="class">major</xsl:attribute>
</xsl:if>
<td class="rang">
<xsl:value-of select="position()"/>
</td>
<td>
<xsl:value-of select="@matricule"/>
</td>
<td>
<xsl:value-of select="nom"/>
</td>
<td>
<xsl:value-of select="prenom"/>
</td>
<td>
<xsl:value-of select="@classe"/>
</td>
<td>
<xsl:choose>
<xsl:when test="email">
<xsl:value-of select="email"/>
</xsl:when>
<xsl:otherwise>
<span class="absent">non renseigné</span>
</xsl:otherwise>
</xsl:choose>
</td>
<td class="moyenne">
<xsl:value-of select="format-number($moy, '0.00')"/>
</td>
<td>
<xsl:choose>
<xsl:when test="$moy >= $seuil">
<span class="badge reussite">Admis</span>
</xsl:when>
<xsl:otherwise>
<span class="badge echec">À revoir</span>
</xsl:otherwise>
</xsl:choose>
</td>
</tr>
</xsl:template>
</xsl:stylesheet>