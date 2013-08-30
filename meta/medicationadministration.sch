<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>MedicationAdministration</sch:title>
    <sch:rule context="/f:MedicationAdministration/f:identifier/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:identifier/f:assigner">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:patient">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:practitioner">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:encounter">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:prescription">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:reasonNotGiven">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:whenGiven">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:medication">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:administrationDevice">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage">
      <sch:assert test="exists(f:quantity) or exists(f:rate)">Inv-1: Must have at least one of dosage.quantity and dosage.rate</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:timing">
      <sch:assert test="not(exists(f:repeat)) or count(f:event) &lt; 2">Inv-1: There can only be a repeat element if there is none or one event</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:timing/f:event">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:timing/f:repeat">
      <sch:assert test="not(exists(f:count) and exists(f:end))">Inv-3: At most, only one of count and end can be present</sch:assert>
      <sch:assert test="exists(f:frequency) != exists(f:when)">Inv-2: Either frequency or when must be present, but not both</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:timing/f:repeat/f:duration">
      <sch:assert test="@value &gt; 0 or not(@value)">Inv-4: duration must be a positive value</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:site">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:route">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:method">
      <sch:assert test="not(exists(f:primary)) or count(f:coding[@id=current()/f:primary/@value])=1">Inv-2: If a primary reference is present, it must point to one of the codings</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:quantity">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:rate/f:numerator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:rate/f:denominator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:maxDosePerPeriod/f:numerator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
    <sch:rule context="/f:MedicationAdministration/f:dosage/f:maxDosePerPeriod/f:denominator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">Inv-3: If a code for the units is present, the system must also be present</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
