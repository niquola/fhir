<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>DeviceCapabilities</sch:title>
    <sch:rule context="/f:DeviceCapabilities/f:type">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceCapabilities/f:identity">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceCapabilities/f:virtualDevice/f:code">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceCapabilities/f:virtualDevice/f:channel/f:code">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceCapabilities/f:virtualDevice/f:channel/f:metric/f:code">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceCapabilities/f:virtualDevice/f:channel/f:metric/f:info">
      <sch:assert test="((f:type/@value = 'Quantity') and (f:ucum)) or ((f:type/@value != 'Quantity') and not (f:ucum))">Inv-3: If the type is "Quantity", ucum must be provided</sch:assert>
      <sch:assert test="(f:type/@value != 'Coding') or f:system">Inv-2: If the type is "Coding', system must be provided</sch:assert>
      <sch:assert test="((f:type/@value = 'Quantity') and (f:units)) or (not (f:type/@value != 'Quantity') and not (f:units))">Inv-1: If the type is "Quantity", units must be provided</sch:assert>
      <sch:assert test="((f:type/@value = 'SampledData') and (f:template)) or ((f:type/@value != 'SampledData') and not (f:template))">Inv-4: If the type is "SampledData", an sampling template must be provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceCapabilities/f:virtualDevice/f:channel/f:metric/f:info/f:template/f:origin">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:DeviceCapabilities/f:virtualDevice/f:channel/f:metric/f:facet/f:code">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
