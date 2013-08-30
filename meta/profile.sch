<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="a" uri="http://www.w3.org/2005/Atom"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <sch:pattern>
    <sch:title>Profile</sch:title>
    <sch:rule context="/f:Profile">
      <sch:assert test="exists(f:structure) or exists(f:extensionDefn) or exists(f:binding)">Inv-8: Must define at least one resource constraint, extension definition or binding</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:telecom">
      <sch:assert test="not(exists(f:value)) or exists(f:system)">Inv-2: A system is required if a value is provided.</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:telecom/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">Inv-1: If present, start must have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:structure">
      <sch:assert test="exists(f:profile) != exists(f:element)">Inv-1: Provide either a profile reference or constraints on the resource elements (but not both)</sch:assert>
      <sch:assert test="upper-case(substring(f:type,1,1))=substring(f:type,1,1)">Inv-12: Only complex types can be constrained, not primitive types such as string etc.</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:structure/f:element/f:definition">
      <sch:assert test="not(exists(f:nameReference) and exists(f:*[starts-with(local-name(.), 'value')]))">Inv-2: Either a namereference or a fixed value (but not both) is permitted</sch:assert>
      <sch:assert test="not(exists(f:*[starts-with(local-name(.), 'value')])) or (count(f:type)=1 and f:type/f:code[substring(@value,1,1)=lower-case(substring(@value,1,1))])">Inv-10: Value may only be specified if the type consists of a single repetition that has a type corresponding to one of the primitive data types.</sch:assert>
      <sch:assert test="not(exists(f:binding)) or f:type/f:code/@value=('code','Coding','CodeableConcept','Quantity')">Inv-7: Binding can only be present for coded elements</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:structure/f:element/f:definition/f:max">
      <sch:assert test="@value='*' or (normalize-space(@value)!='' and normalize-space(translate(@value, '0123456789',''))='')">Inv-6: Max must be a number or "*"</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:structure/f:element/f:definition/f:type">
      <sch:assert test="not(exists(f:bundled)) or exists(f:code[starts-with(@value, 'Resource(')])">Inv-9: Bundled may only be specified if one of the allowed types for the element is a resource</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:extensionDefn/f:code">
      <sch:assert test="count(ancestor::f:Profile/f:extensionDefn/f:code[@value=current()/@value])=1">Inv-5: Codes must be unique in the context of a profile</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:binding">
      <sch:assert test="(exists(f:referenceUri) or exists(f:referenceResource)) or exists(f:description) or exists(f:name)">Inv-3: provide either a reference or a description</sch:assert>
      <sch:assert test="not(f:conformance/@value='example' and f:isExtensible.value='false')">Inv-14: Example value sets are always extensible</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:binding/f:name">
      <sch:assert test="count(ancestor::f:Profile/f:binding/f:name[@value=current()/@value])=1">Inv-11: Binding name must be unique in the context of a profile</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:binding/f:referenceUri">
      <sch:assert test="starts-with(@value, 'http:') or starts-with(@value, 'https:')">Inv-13: uri must start with http:// or https://</sch:assert>
    </sch:rule>
    <sch:rule context="/f:Profile/f:binding/f:referenceResource">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::a:content/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')]|/f:*/f:contained/f:*[local-name(.)=current()/f:type/@value and @id=substring-after(current()/f:reference/@value, '#')])">Inv-2: Must have a local reference if the resource is provided inline</sch:assert>
      <sch:assert test="exists(f:type) or not(exists(f:reference))">Inv-1: Must have a type if a reference is provided</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
