<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>SecurityEvent</sch:title>
    <sch:rule context="/f:SecurityEvent/f:event/f:type">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:event/f:subtype">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:participant">
      <sch:assert test="exists(f:userId) != exists(f:reference)">Inv-3: Either an userId or a reference, but not both</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:participant/f:role">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:participant/f:reference">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:object">
      <sch:assert test="exists(f:identifier) != exists(f:reference)">Inv-2: Either an identifier or a reference, but not both</sch:assert>
      <sch:assert test="not(exists(f:name)) or not(exists(f:query))">Inv-1: Either a name or a query (or both)</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:object/f:identifier/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:object/f:identifier/f:assigner">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:object/f:reference">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:SecurityEvent/f:object/f:sensitivity">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
