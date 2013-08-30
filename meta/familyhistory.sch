<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>FamilyHistory</sch:title>
    <sch:rule context="/f:FamilyHistory/f:subject">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:relationship">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:deceasedAge">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:deceasedRange">
      <sch:assert test="not(exists(f:low/f:comparator) or exists(f:high/f:comparator))">Inv-3: Quantity values cannot have a comparator when used in a Range</sch:assert>
      <sch:assert test="not(exists(f:low/f:value/@value)) or not(exists(f:high/f:value/@value)) or (number(f:low/f:value/@value) &lt;= number(f:high/f:value/@value))">Inv-2: If present, low must have a lower value than high</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:deceasedRange/f:low">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:deceasedRange/f:high">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:condition/f:type">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:condition/f:outcome">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:condition/f:onsetAge">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:condition/f:onsetRange">
      <sch:assert test="not(exists(f:low/f:comparator) or exists(f:high/f:comparator))">Inv-3: Quantity values cannot have a comparator when used in a Range</sch:assert>
      <sch:assert test="not(exists(f:low/f:value/@value)) or not(exists(f:high/f:value/@value)) or (number(f:low/f:value/@value) &lt;= number(f:high/f:value/@value))">Inv-2: If present, low must have a lower value than high</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:condition/f:onsetRange/f:low">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:FamilyHistory/f:relation/f:condition/f:onsetRange/f:high">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
