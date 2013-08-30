<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>Organization</sch:title>
    <sch:rule context="/f:Organization">
      <sch:assert test="count(f:identifier | f:name) &gt; 0">Inv-1: The organization must at least have a name or an id, and possibly more</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:identifier/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:identifier/f:assigner">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:type">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:telecom">
      <sch:assert test="count(f:use[@value='home']) = 0">Inv-3: The telecom of an organization can never be of use 'home'</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:telecom">
      <sch:assert test="not(exists(f:value)) or exists(f:system)">Inv-2: A system is required if a value is provided.</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:telecom/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:address">
      <sch:assert test="count(f:use[@value='home']) = 0">Inv-2: An address of an organization can never be of use 'home'</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:address/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:partOf">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:contact/f:purpose">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:contact/f:name/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:contact/f:telecom">
      <sch:assert test="not(exists(f:value)) or exists(f:system)">Inv-2: A system is required if a value is provided.</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:contact/f:telecom/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:contact/f:address/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Organization/f:contact/f:gender">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
