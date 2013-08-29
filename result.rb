class ValueSet
  attribute :ValueSet, Resource
  class ValueSetExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, string
    attribute :version, string
    attribute :name, string
    attribute :publisher, string
    attribute :telecom, Contact
    attribute :description, string
    attribute :copyright, string
    attribute :status, code
    attribute :experimental, boolean
    attribute :date, dateTime
    attribute :define, 
    class ValueSetDefineSystem
      attribute :system, uri
      attribute :caseSensitive, boolean
      attribute :concept, 
      class ValueSetDefineConceptCode
        attribute :code, code
        attribute :abstract, boolean
        attribute :display, string
        attribute :definition, string
        attribute :concept, @ValueSet.define.concept
      end
    end
    class ValueSetComposeImport
      attribute :import, uri
      attribute :include, 
      class ValueSetComposeIncludeSystem
        attribute :system, uri
        attribute :version, string
        attribute :code, code
        attribute :filter, 
        class ValueSetComposeIncludeFilterProperty
          attribute :property, code
          attribute :op, code
          attribute :value, code
        end
      end
    end
    class ValueSetExpansionTimestamp
      attribute :timestamp, instant
      attribute :contains, 
      class ValueSetExpansionContainsSystem
        attribute :system, uri
        attribute :code, code
        attribute :display, string
        attribute :contains, @ValueSet.expansion.contains
      end
    end
  end
end
class AdverseReaction
  attribute :AdverseReaction, Resource
  class AdverseReactionExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :reactionDate, dateTime
    attribute :subject, Resource(Patient)
    attribute :didNotOccurFlag, boolean
    attribute :recorder, Resource(Practitioner|Patient)
    attribute :symptom, 
    class AdverseReactionSymptomCode
      attribute :code, CodeableConcept
      attribute :severity, code
    end
    class AdverseReactionExposureExposureDate
      attribute :exposureDate, dateTime
      attribute :exposureType, code
      attribute :causalityExpectation, code
      attribute :substance, Resource(Substance)
    end
  end
end
class Alert
  attribute :Alert, Resource
  class AlertExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :category, CodeableConcept
    attribute :status, code
    attribute :subject, Resource(Patient)
    attribute :author, Resource(Practitioner|Patient|Device)
    attribute :note, string
  end
end
class AllergyIntolerance
  attribute :AllergyIntolerance, Resource
  class AllergyIntoleranceExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :criticality, code
    attribute :sensitivityType, code
    attribute :recordedDate, dateTime
    attribute :status, code
    attribute :subject, Resource(Patient)
    attribute :recorder, Resource(Practitioner|Patient)
    attribute :substance, Resource(Substance)
    attribute :reaction, Resource(AdverseReaction)
    attribute :sensitivityTest, Resource(Observation)
  end
end
class CarePlan
  attribute :CarePlan, Resource
  class CarePlanExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :patient, Resource(Patient)
    attribute :status, code
    attribute :period, Period
    attribute :modified, dateTime
    attribute :concern, Resource(Condition)
    attribute :participant, 
    class CarePlanParticipantRole
      attribute :role, CodeableConcept
      attribute :member, Resource(Practitioner|RelatedPerson|Patient|Organization)
    end
    class CarePlanGoalDescription
      attribute :description, string
      attribute :status, code
      attribute :notes, string
    end
    class CarePlanActivityCategory
      attribute :category, code
      attribute :code, CodeableConcept
      attribute :status, code
      attribute :prohibited, boolean
      attribute :timing[x], Schedule
      attribute :location, Resource(Location)
      attribute :performer, Resource(Practitioner|Organization|RelatedPerson|Patient)
      attribute :product, Resource(Medication|Substance)
      attribute :dailyAmount, Quantity
      attribute :quantity, Quantity
      attribute :details, string
      attribute :actionTaken, Resource(Any)
      attribute :notes, string
    end
  end
end
class Condition
  attribute :Condition, Resource
  class ConditionExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :subject, Resource(Patient)
    attribute :encounter, Resource(Encounter)
    attribute :asserter, Resource(Practitioner|Patient)
    attribute :dateAsserted, date
    attribute :code, CodeableConcept
    attribute :category, CodeableConcept
    attribute :status, code
    attribute :certainty, CodeableConcept
    attribute :severity, CodeableConcept
    attribute :onset[x], date
    attribute :abatement[x], date
    attribute :stage, 
    class ConditionStageSummary
      attribute :summary, CodeableConcept
      attribute :assessment, Resource(Any)
    end
    class ConditionEvidenceCode
      attribute :code, CodeableConcept
      attribute :detail, Resource(Any)
    end
    class ConditionLocationCode
      attribute :code, CodeableConcept
      attribute :detail, string
    end
    class ConditionRelatedItemType
      attribute :type, code
      attribute :code, CodeableConcept
      attribute :target, Resource(Condition|Procedure|Substance)
    end
  end
end
class Conformance
  attribute :Conformance, Resource
  class ConformanceExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, string
    attribute :version, string
    attribute :name, string
    attribute :publisher, string
    attribute :telecom, Contact
    attribute :description, string
    attribute :status, code
    attribute :experimental, boolean
    attribute :date, dateTime
    attribute :software, 
    class ConformanceSoftwareName
      attribute :name, string
      attribute :version, string
      attribute :releaseDate, dateTime
    end
    class ConformanceImplementationDescription
      attribute :description, string
      attribute :url, uri
    end
    attribute :acceptUnknown, boolean
    attribute :format, code
    attribute :rest, 
    class ConformanceRestMode
      attribute :mode, code
      attribute :documentation, string
      attribute :security, 
      class ConformanceRestSecurityService
        attribute :service, CodeableConcept
        attribute :description, string
        attribute :certificate, 
        class ConformanceRestSecurityCertificateType
          attribute :type, code
          attribute :blob, base64Binary
        end
      end
      class ConformanceRestResourceType
        attribute :type, code
        attribute :profile, Resource(Profile)
        attribute :operation, 
        class ConformanceRestResourceOperationCode
          attribute :code, code
          attribute :documentation, string
        end
        attribute :searchInclude, string
        attribute :searchParam, 
        class ConformanceRestResourceSearchParamName
          attribute :name, string
          attribute :source, uri
          attribute :type, code
          attribute :documentation, string
          attribute :xpath, string
          attribute :target, code
          attribute :chain, string
        end
      end
      attribute :history, boolean
      attribute :query, 
      class ConformanceRestQueryName
        attribute :name, string
        attribute :documentation, string
        attribute :parameter, @Conformance.rest.resource.searchParam
      end
    end
    class ConformanceMessagingEndpoint
      attribute :endpoint, uri
      attribute :reliableCache, integer
      attribute :documentation, string
      attribute :event, 
      class ConformanceMessagingEventCode
        attribute :code, code
        attribute :mode, code
        attribute :protocol, Coding
        attribute :focus, code
        attribute :request, Resource(Profile)
        attribute :response, Resource(Profile)
        attribute :documentation, string
      end
    end
    class ConformanceDocumentMode
      attribute :mode, code
      attribute :documentation, string
      attribute :profile, Resource(Profile)
    end
  end
end
class Coverage
  attribute :Coverage, Resource
  class CoverageExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :issuer, Resource(Organization)
    attribute :period, Period
    attribute :type, Coding
    attribute :identifier, Identifier
    attribute :group, Identifier
    attribute :plan, Identifier
    attribute :subplan, Identifier
    attribute :dependent, integer
    attribute :sequence, integer
    attribute :subscriber, 
    class CoverageSubscriberName
      attribute :name, HumanName
      attribute :address, Address
      attribute :birthdate, date
    end
  end
end
class Device
  attribute :Device, Resource
  class DeviceExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :type, CodeableConcept
    attribute :manufacturer, string
    attribute :model, string
    attribute :version, string
    attribute :expiry, date
    attribute :identity, 
    class DeviceIdentityGtin
      attribute :gtin, string
      attribute :lot, string
      attribute :serialNumber, string
    end
    attribute :assignedId, Identifier
    attribute :location, Resource(Location)
    attribute :patient, Resource(Patient)
    attribute :contact, Contact
    attribute :url, uri
  end
end
class DeviceCapabilities
  attribute :DeviceCapabilities, Resource
  class DeviceCapabilitiesExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :name, string
    attribute :type, CodeableConcept
    attribute :manufacturer, string
    attribute :identity, Resource(Device)
    attribute :virtualDevice, 
    class DeviceCapabilitiesVirtualDeviceCode
      attribute :code, CodeableConcept
      attribute :channel, 
      class DeviceCapabilitiesVirtualDeviceChannelCode
        attribute :code, CodeableConcept
        attribute :metric, 
        class DeviceCapabilitiesVirtualDeviceChannelMetricCode
          attribute :code, CodeableConcept
          attribute :key, string
          attribute :info, 
          class DeviceCapabilitiesVirtualDeviceChannelMetricInfoType
            attribute :type, code
            attribute :units, string
            attribute :ucum, code
            attribute :template, SampledData
            attribute :system, uri
          end
          class DeviceCapabilitiesVirtualDeviceChannelMetricFacetCode
            attribute :code, CodeableConcept
            attribute :scale, decimal
            attribute :key, string
            attribute :info, @DeviceCapabilities.virtualDevice.channel.metric.info
          end
        end
      end
    end
  end
end
class DeviceLog
  attribute :DeviceLog, Resource
  class DeviceLogExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :instant, instant
    attribute :capabilities, Resource(DeviceCapabilities)
    attribute :subject, Resource(Patient|Group|Device)
    attribute :item, 
    class DeviceLogItemKey
      attribute :key, string
      attribute :value, string
      attribute :flag, code
    end
  end
end
class DeviceObservation
  attribute :DeviceObservation, Resource
  class DeviceObservationExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :code, CodeableConcept
    attribute :identifier, Identifier
    attribute :issued, instant
    attribute :subject, Resource(Patient|Group|Device)
    attribute :device, Resource(Device)
    attribute :measurement, Resource(Observation)
  end
end
class DiagnosticOrder
  attribute :DiagnosticOrder, Resource
  class DiagnosticOrderExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :subject, Resource(Patient|Group|Location|Device)
    attribute :orderer, Resource(Practitioner)
    attribute :identifier, Identifier
    attribute :encounter, Resource(Encounter)
    attribute :clinicalNotes, string
    attribute :specimen, Resource(Specimen)
    attribute :status, code
    attribute :priority, code
    attribute :event, 
    class DiagnosticOrderEventStatus
      attribute :status, code
      attribute :date, dateTime
      attribute :actor, Resource(Practitioner|Device)
    end
    class DiagnosticOrderItemCode
      attribute :code, CodeableConcept
      attribute :specimen, Resource(Specimen)
      attribute :bodySite, CodeableConcept
      attribute :status, code
      attribute :event, @DiagnosticOrder.event
    end
  end
end
class DiagnosticReport
  attribute :DiagnosticReport, Resource
  class DiagnosticReportExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :status, code
    attribute :issued, dateTime
    attribute :subject, Resource(Patient|Group|Device)
    attribute :performer, Resource(Organization)
    attribute :reportId, Identifier
    attribute :requestDetail, 
    class DiagnosticReportRequestDetailEncounter
      attribute :encounter, Resource(Encounter)
      attribute :requestOrderId, Identifier
      attribute :receiverOrderId, Identifier
      attribute :requestTest, CodeableConcept
      attribute :bodySite, CodeableConcept
      attribute :requester, Resource(Organization|Practitioner)
      attribute :clinicalInfo, string
    end
    attribute :diagnosticTime, dateTime
    attribute :results, 
    class DiagnosticReportResultsName
      attribute :name, CodeableConcept
      attribute :specimen, Resource(Specimen)
      attribute :group, @DiagnosticReport.results
      attribute :result, Resource(Observation)
    end
    attribute :conclusion, string
    attribute :codedDiagnosis, CodeableConcept
    attribute :representation, Attachment
  end
end
class Document
  attribute :Document, Resource
  class DocumentExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :versionIdentifier, Identifier
    attribute :created, instant
    attribute :type, CodeableConcept
    attribute :subtype, CodeableConcept
    attribute :title, string
    attribute :status, code
    attribute :confidentiality, Coding
    attribute :subject, Resource(Patient|Practitioner|Group|Device)
    attribute :author, Resource(Practitioner|Device)
    attribute :attester, 
    class DocumentAttesterMode
      attribute :mode, code
      attribute :time, dateTime
      attribute :party, Resource(Patient|Practitioner|Organization)
    end
    attribute :event, 
    class DocumentEventCode
      attribute :code, CodeableConcept
      attribute :period, Period
      attribute :detail, Resource(Any)
    end
    attribute :replaces, id
    attribute :provenance, Resource(Provenance)
    attribute :stylesheet, Attachment
    attribute :representation, Attachment
    attribute :section, 
    class DocumentSectionCode
      attribute :code, CodeableConcept
      attribute :subject, Resource(Patient|Group|Device)
      attribute :content, Resource(Any)
      attribute :section, @Document.section
    end
  end
end
class DocumentReference
  attribute :DocumentReference, Resource
  class DocumentReferenceExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :masterIdentifier, Identifier
    attribute :identifier, Identifier
    attribute :subject, Resource(Patient|Practitioner|Group|Device)
    attribute :type, CodeableConcept
    attribute :subtype, CodeableConcept
    attribute :author, Resource(Practitioner|Device)
    attribute :custodian, Resource(Organization)
    attribute :authenticator, Resource(Practitioner|Organization)
    attribute :created, dateTime
    attribute :indexed, instant
    attribute :status, code
    attribute :docStatus, CodeableConcept
    attribute :supercedes, Resource(DocumentReference)
    attribute :description, string
    attribute :confidentiality, CodeableConcept
    attribute :primaryLanguage, code
    attribute :mimeType, code
    attribute :format, CodeableConcept
    attribute :size, integer
    attribute :hash, string
    attribute :location, uri
    attribute :service, 
    class DocumentReferenceServiceType
      attribute :type, CodeableConcept
      attribute :address, string
      attribute :parameter, 
      class DocumentReferenceServiceParameterName
        attribute :name, string
        attribute :value, string
      end
    end
    class DocumentReferenceContextCode
      attribute :code, CodeableConcept
      attribute :period, Period
      attribute :facilityType, CodeableConcept
    end
  end
end
class Encounter
  attribute :Encounter, Resource
  class EncounterExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :status, code
    attribute :class, code
    attribute :type, CodeableConcept
    attribute :subject, Resource(Patient)
    attribute :participant, 
    class EncounterParticipantType
      attribute :type, code
      attribute :practitioner, Resource(Practitioner)
    end
    attribute :start, dateTime
    attribute :length, Duration
    attribute :reason[x], string
    attribute :indication, Resource(Any)
    attribute :priority, CodeableConcept
    attribute :hospitalization, 
    class EncounterHospitalizationPreAdmissionIdentifier
      attribute :preAdmissionIdentifier, Identifier
      attribute :origin, Resource(Location)
      attribute :admitSource, CodeableConcept
      attribute :period, Period
      attribute :accomodation, 
      class EncounterHospitalizationAccomodationBed
        attribute :bed, Resource(Location)
        attribute :period, Period
      end
      attribute :specialCourtesy, CodeableConcept
      attribute :specialArrangement, CodeableConcept
      attribute :destination, Resource(Location)
      attribute :dischargeDisposition, CodeableConcept
      attribute :reAdmission, boolean
    end
    class EncounterLocationLocation
      attribute :location, Resource(Location)
      attribute :period, Period
    end
    attribute :partOf, Resource(Encounter)
  end
end
class FamilyHistory
  attribute :FamilyHistory, Resource
  class FamilyHistoryExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :subject, Resource(Patient)
    attribute :note, string
    attribute :relation, 
    class FamilyHistoryRelationName
      attribute :name, string
      attribute :relationship, CodeableConcept
      attribute :deceased[x], boolean
      attribute :note, string
      attribute :condition, 
      class FamilyHistoryRelationConditionType
        attribute :type, CodeableConcept
        attribute :outcome, CodeableConcept
        attribute :onset[x], Age
        attribute :note, string
      end
    end
  end
end
class Group
  attribute :Group, Resource
  class GroupExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :type, code
    attribute :actual, boolean
    attribute :code, CodeableConcept
    attribute :name, string
    attribute :quantity, integer
    attribute :characteristic, 
    class GroupCharacteristicType
      attribute :type, CodeableConcept
      attribute :value[x], CodeableConcept
      attribute :exclude, boolean
    end
  end
end
class ImagingStudy
  attribute :ImagingStudy, Resource
  class ImagingStudyExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :dateTime, dateTime
    attribute :subject, Resource(Patient)
    attribute :uid, oid
    attribute :accessionNo, Identifier
    attribute :identifier, Identifier
    attribute :modality, code
    attribute :referrer, Resource(Practitioner)
    attribute :availability, code
    attribute :url, uri
    attribute :numberOfSeries, integer
    attribute :numberOfInstances, integer
    attribute :clinicalInformation, string
    attribute :procedure, Coding
    attribute :interpreter, Resource(Practitioner)
    attribute :description, string
    attribute :series, 
    class ImagingStudySeriesNumber
      attribute :number, integer
      attribute :modality, code
      attribute :uid, oid
      attribute :description, string
      attribute :numberOfInstances, integer
      attribute :availability, code
      attribute :url, uri
      attribute :bodySite, Coding
      attribute :dateTime, dateTime
      attribute :instance, 
      class ImagingStudySeriesInstanceNumber
        attribute :number, integer
        attribute :uid, oid
        attribute :sopclass, oid
        attribute :type, string
        attribute :title, string
        attribute :url, uri
        attribute :attachment, Resource(Any)
      end
    end
  end
end
class Immunization
  attribute :Immunization, Resource
  class ImmunizationExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :date, dateTime
    attribute :vaccineType, CodeableConcept
    attribute :subject, Resource(Patient)
    attribute :refusedIndicator, boolean
    attribute :reported, boolean
    attribute :performer, Resource(Practitioner)
    attribute :requester, Resource(Practitioner)
    attribute :manufacturer, Resource(Organization)
    attribute :location, Resource(Location)
    attribute :lotNumber, string
    attribute :expirationDate, date
    attribute :site, CodeableConcept
    attribute :route, CodeableConcept
    attribute :doseQuantity, Quantity
    attribute :explanation, 
    class ImmunizationExplanationReason
      attribute :reason, CodeableConcept
      attribute :refusalReason, CodeableConcept
    end
    class ImmunizationReactionDate
      attribute :date, dateTime
      attribute :detail, Resource(AdverseReaction|Observation)
      attribute :reported, boolean
    end
    class ImmunizationVaccinationProtocolDoseSequence
      attribute :doseSequence, integer
      attribute :description, string
      attribute :authority, Resource(Organization)
      attribute :series, string
      attribute :seriesDoses, integer
      attribute :doseTarget, CodeableConcept
      attribute :doseStatus, CodeableConcept
      attribute :doseStatusReason, CodeableConcept
    end
  end
end
class ImmunizationProfile
  attribute :ImmunizationProfile, Resource
  class ImmunizationProfileExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :subject, Resource(Patient)
    attribute :recommendation, 
    class ImmunizationProfileRecommendationRecommendationDate
      attribute :recommendationDate, dateTime
      attribute :vaccineType, CodeableConcept
      attribute :doseNumber, integer
      attribute :forecastStatus, code
      attribute :dateCriterion, 
      class ImmunizationProfileRecommendationDateCriterionCode
        attribute :code, CodeableConcept
        attribute :value, dateTime
      end
      class ImmunizationProfileRecommendationProtocolDoseSequence
        attribute :doseSequence, integer
        attribute :description, string
        attribute :authority, Resource(Organization)
        attribute :series, string
      end
      attribute :supportingAdverseEventReport, 
      class ImmunizationProfileRecommendationSupportingAdverseEventReportIdentifier
        attribute :identifier, id
        attribute :reportType, CodeableConcept
        attribute :reportDate, dateTime
        attribute :text, string
        attribute :reaction, Resource(AdverseReaction)
      end
    end
  end
end
class List
  attribute :List, Resource
  class ListExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :code, CodeableConcept
    attribute :source, Resource(Practitioner|Patient|Device)
    attribute :date, dateTime
    attribute :ordered, boolean
    attribute :mode, code
    attribute :entry, 
    class ListEntryFlag
      attribute :flag, CodeableConcept
      attribute :deleted, boolean
      attribute :date, dateTime
      attribute :item, Resource(Any)
    end
  end
end
class Location
  attribute :Location, Resource
  class LocationExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :name, string
    attribute :description, string
    attribute :type, CodeableConcept
    attribute :telecom, Contact
    attribute :address, Address
    attribute :position, 
    class LocationPositionLongitude
      attribute :longitude, decimal
      attribute :latitude, decimal
      attribute :altitude, decimal
    end
    attribute :active, boolean
    attribute :partOf, Resource(Location)
  end
end
class Media
  attribute :Media, Resource
  class MediaExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :type, code
    attribute :subtype, CodeableConcept
    attribute :identifier, Identifier
    attribute :dateTime, dateTime
    attribute :subject, Resource(Patient|Practitioner|Group|Device|Specimen)
    attribute :requester, Resource(Practitioner)
    attribute :operator, Resource(Practitioner)
    attribute :view, CodeableConcept
    attribute :deviceName, string
    attribute :height, integer
    attribute :width, integer
    attribute :frames, integer
    attribute :length, integer
    attribute :content, Attachment
  end
end
class Medication
  attribute :Medication, Resource
  class MedicationExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :name, string
    attribute :code, CodeableConcept
    attribute :isBrand, boolean
    attribute :manufacturer, Resource(Organization)
    attribute :kind, code
    attribute :product, 
    class MedicationProductForm
      attribute :form, CodeableConcept
      attribute :ingredient, 
      class MedicationProductIngredientItem
        attribute :item, Resource(Substance|Medication)
        attribute :amount, Ratio
      end
    end
    class MedicationPackageContainer
      attribute :container, CodeableConcept
      attribute :content, 
      class MedicationPackageContentItem
        attribute :item, Resource(Medication)
        attribute :amount, Quantity
      end
    end
  end
end
class MedicationAdministration
  attribute :MedicationAdministration, Resource
  class MedicationAdministrationExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :status, code
    attribute :patient, Resource(Patient)
    attribute :practitioner, Resource(Practitioner)
    attribute :encounter, Resource(Encounter)
    attribute :prescription, Resource(MedicationPrescription)
    attribute :wasNotGiven, boolean
    attribute :reasonNotGiven, CodeableConcept
    attribute :whenGiven, Period
    attribute :medication, Resource(Medication)
    attribute :administrationDevice, Resource(Device)
    attribute :dosage, 
    class MedicationAdministrationDosageTiming
      attribute :timing, Schedule
      attribute :site, CodeableConcept
      attribute :route, CodeableConcept
      attribute :method, CodeableConcept
      attribute :quantity, Quantity
      attribute :rate, Ratio
      attribute :maxDosePerPeriod, Ratio
    end
  end
end
class MedicationDispense
  attribute :MedicationDispense, Resource
  class MedicationDispenseExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :status, code
    attribute :patient, Resource(Patient)
    attribute :dispenser, Resource(Practitioner)
    attribute :authorizingPrescription, Resource(MedicationPrescription)
    attribute :dispense, 
    class MedicationDispenseDispenseIdentifier
      attribute :identifier, Identifier
      attribute :status, code
      attribute :type, CodeableConcept
      attribute :quantity, Quantity
      attribute :medication, Resource(Medication)
      attribute :whenPrepared, Period
      attribute :whenHandedOver, Period
      attribute :destination, Resource(Location)
      attribute :receiver, Resource(Practitioner)
      attribute :dosage, 
      class MedicationDispenseDispenseDosageAdditionalInstructions[x]
        attribute :additionalInstructions[x], string
        attribute :timing[x], dateTime
        attribute :site, CodeableConcept
        attribute :route, CodeableConcept
        attribute :method, CodeableConcept
        attribute :quantity, Quantity
        attribute :rate, Ratio
        attribute :maxDosePerPeriod, Ratio
      end
    end
    class MedicationDispenseSubstitutionType
      attribute :type, CodeableConcept
      attribute :reason, CodeableConcept
      attribute :responsibleParty, Resource(Practitioner)
    end
  end
end
class MedicationPrescription
  attribute :MedicationPrescription, Resource
  class MedicationPrescriptionExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :dateWritten, dateTime
    attribute :status, code
    attribute :patient, Resource(Patient)
    attribute :prescriber, Resource(Practitioner)
    attribute :encounter, Resource(Encounter)
    attribute :reasonForPrescribing[x], string
    attribute :medication, Resource(Medication)
    attribute :dosageInstruction, 
    class MedicationPrescriptionDosageInstructionDosageInstructionsText
      attribute :dosageInstructionsText, string
      attribute :additionalInstructions[x], string
      attribute :timing[x], dateTime
      attribute :site, CodeableConcept
      attribute :route, CodeableConcept
      attribute :method, CodeableConcept
      attribute :doseQuantity, Quantity
      attribute :rate, Ratio
      attribute :maxDosePerPeriod, Ratio
    end
    class MedicationPrescriptionDispenseMedication
      attribute :medication, Resource(Medication)
      attribute :validityPeriod, Period
      attribute :numberOfRepeatsAllowed, integer
      attribute :quantity, Quantity
      attribute :expectedSupplyDuration, Duration
    end
    class MedicationPrescriptionSubstitutionType
      attribute :type, CodeableConcept
      attribute :reason, CodeableConcept
    end
  end
end
class MedicationStatement
  attribute :MedicationStatement, Resource
  class MedicationStatementExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :patient, Resource(Patient)
    attribute :wasNotGiven, boolean
    attribute :reasonNotGiven, CodeableConcept
    attribute :whenGiven, Period
    attribute :medication, Resource(Medication)
    attribute :administrationDevice, Resource(Device)
    attribute :dosage, 
    class MedicationStatementDosageTiming
      attribute :timing, Schedule
      attribute :site, CodeableConcept
      attribute :route, CodeableConcept
      attribute :method, CodeableConcept
      attribute :quantity, Quantity
      attribute :rate, Ratio
      attribute :maxDosePerPeriod, Ratio
    end
  end
end
class Message
  attribute :Message, Resource
  class MessageExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, id
    attribute :timestamp, instant
    attribute :event, code
    attribute :response, 
    class MessageResponseIdentifier
      attribute :identifier, id
      attribute :code, code
      attribute :details, Resource(OperationOutcome)
    end
    class MessageSourceName
      attribute :name, string
      attribute :software, string
      attribute :version, string
      attribute :contact, Contact
      attribute :endpoint, uri
    end
    class MessageDestinationName
      attribute :name, string
      attribute :target, Resource(Device)
      attribute :endpoint, uri
    end
    attribute :author, Resource(Practitioner)
    attribute :receiver, Resource(Practitioner|Organization)
    attribute :responsible, Resource(Practitioner|Organization)
    attribute :effective, Period
    attribute :reason, CodeableConcept
    attribute :data, Resource(Any)
  end
end
class Observation
  attribute :Observation, Resource
  class ObservationExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :name, CodeableConcept
    attribute :value[x], Quantity
    attribute :interpretation, CodeableConcept
    attribute :comments, string
    attribute :applies[x], Period
    attribute :issued, instant
    attribute :status, code
    attribute :reliability, code
    attribute :bodySite, CodeableConcept
    attribute :method, CodeableConcept
    attribute :identifier, Identifier
    attribute :subject, Resource(Patient|Group|Device)
    attribute :performer, Resource(Practitioner|Device|Organization)
    attribute :referenceRange, 
    class ObservationReferenceRangeMeaning
      attribute :meaning, CodeableConcept
      attribute :range[x], Quantity
    end
    class ObservationComponentName
      attribute :name, CodeableConcept
      attribute :value[x], Quantity
    end
  end
end
class OperationOutcome
  attribute :OperationOutcome, Resource
  class OperationOutcomeExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :issue, 
    class OperationOutcomeIssueSeverity
      attribute :severity, code
      attribute :type, Coding
      attribute :details, string
      attribute :location, string
    end
  end
end
class Order
  attribute :Order, Resource
  class OrderExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :date, dateTime
    attribute :subject, Resource(Patient)
    attribute :source, Resource(Practitioner)
    attribute :target, Resource(Organization|Device)
    attribute :reason, string
    attribute :authority, Resource(Any)
    attribute :when, 
    class OrderWhenCode
      attribute :code, CodeableConcept
      attribute :schedule, Schedule
    end
  end
end
class OrderResponse
  attribute :OrderResponse, Resource
  class OrderResponseExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :request, Resource(Order)
    attribute :date, dateTime
    attribute :who, Resource(Practitioner|Organization)
    attribute :authority, Resource(Any)
    attribute :cost, Money
    attribute :code, code
    attribute :description, string
    attribute :fulfillment, Resource(Any)
  end
end
class Organization
  attribute :Organization, Resource
  class OrganizationExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :name, string
    attribute :type, CodeableConcept
    attribute :telecom, Contact
    attribute :address, Address
    attribute :partOf, Resource(Organization)
    attribute :contact, 
    class OrganizationContactPurpose
      attribute :purpose, CodeableConcept
      attribute :name, HumanName
      attribute :telecom, Contact
      attribute :address, Address
      attribute :gender, CodeableConcept
    end
  end
end
class Other
  attribute :Other, Resource
  class OtherExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :code, CodeableConcept
    attribute :subject, Resource(Any)
    attribute :author, Resource(Practitioner|Patient|RelatedPerson)
    attribute :created, date
  end
end
class Patient
  attribute :Patient, Resource
  class PatientExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :name, HumanName
    attribute :telecom, Contact
    attribute :gender, CodeableConcept
    attribute :birthDate, dateTime
    attribute :deceased[x], boolean
    attribute :address, Address
    attribute :maritalStatus, CodeableConcept
    attribute :multipleBirth[x], boolean
    attribute :photo, Attachment
    attribute :contact, 
    class PatientContactRelationship
      attribute :relationship, CodeableConcept
      attribute :name, HumanName
      attribute :telecom, Contact
      attribute :address, Address
      attribute :gender, CodeableConcept
      attribute :organization, Resource(Organization)
    end
    class PatientAnimalSpecies
      attribute :species, CodeableConcept
      attribute :breed, CodeableConcept
      attribute :genderStatus, CodeableConcept
    end
    attribute :provider, Resource(Organization)
    attribute :link, Resource(Patient)
    attribute :active, boolean
  end
end
class Practitioner
  attribute :Practitioner, Resource
  class PractitionerExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :name, HumanName
    attribute :telecom, Contact
    attribute :address, Address
    attribute :gender, CodeableConcept
    attribute :birthDate, dateTime
    attribute :photo, Attachment
    attribute :organization, Resource(Organization)
    attribute :role, CodeableConcept
    attribute :specialty, CodeableConcept
    attribute :period, Period
    attribute :qualification, 
    class PractitionerQualificationCode
      attribute :code, CodeableConcept
      attribute :period, Period
      attribute :issuer, Resource(Organization)
    end
  end
end
class Procedure
  attribute :Procedure, Resource
  class ProcedureExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :subject, Resource(Patient)
    attribute :type, CodeableConcept
    attribute :bodySite, CodeableConcept
    attribute :indication, string
    attribute :performer, 
    class ProcedurePerformerPerson
      attribute :person, Resource(Practitioner)
      attribute :role, CodeableConcept
    end
    attribute :encounter, Resource(Encounter)
    attribute :outcome, string
    attribute :report, Resource(DiagnosticReport)
    attribute :complication, string
    attribute :followUp, string
    attribute :relatedItem, 
    class ProcedureRelatedItemType
      attribute :type, code
      attribute :target, Resource(Procedure|MedicationPrescription)
    end
  end
end
class Profile
  attribute :Profile, Resource
  class ProfileExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, string
    attribute :version, string
    attribute :name, string
    attribute :publisher, string
    attribute :telecom, Contact
    attribute :description, string
    attribute :code, Coding
    attribute :status, code
    attribute :experimental, boolean
    attribute :date, dateTime
    attribute :fhirVersion, id
    attribute :structure, 
    class ProfileStructureType
      attribute :type, code
      attribute :name, string
      attribute :publish, boolean
      attribute :purpose, string
      attribute :element, 
      class ProfileStructureElementPath
        attribute :path, string
        attribute :name, string
        attribute :slicing, 
        class ProfileStructureElementSlicingDiscriminator
          attribute :discriminator, id
          attribute :ordered, boolean
          attribute :rules, code
        end
        class ProfileStructureElementDefinitionShort
          attribute :short, string
          attribute :formal, string
          attribute :comments, string
          attribute :requirements, string
          attribute :synonym, string
          attribute :min, integer
          attribute :max, string
          attribute :type, 
          class ProfileStructureElementDefinitionTypeCode
            attribute :code, code
            attribute :profile, uri
            attribute :bundled, boolean
          end
          attribute :value[x], *
          attribute :example[x], *
          attribute :maxLength, integer
          attribute :condition, id
          attribute :constraint, 
          class ProfileStructureElementDefinitionConstraintKey
            attribute :key, id
            attribute :name, string
            attribute :severity, code
            attribute :human, string
            attribute :xpath, string
            attribute :ocl, string
          end
          attribute :isModifier, boolean
          attribute :binding, uri
          attribute :mapping, 
          class ProfileStructureElementDefinitionMappingTarget
            attribute :target, uri
            attribute :map, string
          end
        end
      end
    end
    class ProfileExtensionDefnCode
      attribute :code, code
      attribute :contextType, code
      attribute :context, string
      attribute :definition, @Profile.structure.element.definition
    end
    class ProfileBindingName
      attribute :name, string
      attribute :isExtensible, boolean
      attribute :conformance, code
      attribute :description, string
      attribute :reference[x], uri
    end
  end
end
class Provenance
  attribute :Provenance, Resource
  class ProvenanceExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :target, Resource(Any)
    attribute :period, Period
    attribute :recorded, instant
    attribute :reason, CodeableConcept
    attribute :location, Resource(Location)
    attribute :policy, uri
    attribute :agent, 
    class ProvenanceAgentRole
      attribute :role, Coding
      attribute :type, Coding
      attribute :reference, uri
      attribute :display, string
    end
    class ProvenanceEntityRole
      attribute :role, code
      attribute :type, Coding
      attribute :reference, uri
      attribute :display, string
      attribute :agent, @Provenance.agent
    end
  end
end
class Query
  attribute :Query, Resource
  class QueryExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, uri
    attribute :parameter, Extension
    attribute :response, 
    class QueryResponseIdentifier
      attribute :identifier, uri
      attribute :outcome, code
      attribute :total, integer
      attribute :parameter, Extension
      attribute :first, Extension
      attribute :previous, Extension
      attribute :next, Extension
      attribute :last, Extension
      attribute :reference, Resource(Any)
    end
  end
end
class Questionnaire
  attribute :Questionnaire, Resource
  class QuestionnaireExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :status, code
    attribute :authored, dateTime
    attribute :subject, Resource(Patient|RelatedPerson)
    attribute :author, Resource(Practitioner|Patient|RelatedPerson)
    attribute :source, Resource(Patient|Practitioner|RelatedPerson)
    attribute :name, CodeableConcept
    attribute :identifier, Identifier
    attribute :encounter, Resource(Encounter)
    attribute :question, 
    class QuestionnaireQuestionName
      attribute :name, CodeableConcept
      attribute :text, string
      attribute :answer[x], decimal
      attribute :choice, Coding
      attribute :options[x], uri
      attribute :data[x], *
      attribute :remarks, string
    end
    class QuestionnaireGroupName
      attribute :name, CodeableConcept
      attribute :header, string
      attribute :text, string
      attribute :subject, Resource(Any)
      attribute :question, @Questionnaire.question
      attribute :group, @Questionnaire.group
    end
  end
end
class RelatedPerson
  attribute :RelatedPerson, Resource
  class RelatedPersonExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :patient, Resource(Patient)
    attribute :relationship, CodeableConcept
    attribute :name, HumanName
    attribute :telecom, Contact
    attribute :gender, CodeableConcept
    attribute :address, Address
    attribute :photo, Attachment
  end
end
class SecurityEvent
  attribute :SecurityEvent, Resource
  class SecurityEventExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :event, 
    class SecurityEventEventType
      attribute :type, CodeableConcept
      attribute :subtype, CodeableConcept
      attribute :action, code
      attribute :dateTime, instant
      attribute :outcome, code
      attribute :outcomeDesc, string
    end
    class SecurityEventParticipantRole
      attribute :role, CodeableConcept
      attribute :reference, Resource(Practitioner|Patient|Device)
      attribute :userId, string
      attribute :authId, string
      attribute :name, string
      attribute :requestor, boolean
      attribute :media, Coding
      attribute :network, 
      class SecurityEventParticipantNetworkIdentifier
        attribute :identifier, string
        attribute :type, code
      end
    end
    class SecurityEventSourceSite
      attribute :site, string
      attribute :identifier, string
      attribute :type, Coding
    end
    class SecurityEventObjectIdentifier
      attribute :identifier, Identifier
      attribute :reference, Resource(Any)
      attribute :type, code
      attribute :role, code
      attribute :lifecycle, code
      attribute :sensitivity, CodeableConcept
      attribute :name, string
      attribute :query, base64Binary
      attribute :detail, 
      class SecurityEventObjectDetailType
        attribute :type, string
        attribute :value, base64Binary
      end
    end
  end
end
class Specimen
  attribute :Specimen, Resource
  class SpecimenExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :type, CodeableConcept
    attribute :source, 
    class SpecimenSourceRelationship
      attribute :relationship, code
      attribute :target, Resource(Specimen)
    end
    attribute :accessionIdentifier, Identifier
    attribute :receivedTime, dateTime
    attribute :collection, 
    class SpecimenCollectionCollector
      attribute :collector, Resource(Practitioner)
      attribute :comment, string
      attribute :collectedTime, dateTime
      attribute :quantity, Quantity
      attribute :method, CodeableConcept
      attribute :sourceSite, CodeableConcept
    end
    class SpecimenTreatmentDescription
      attribute :description, string
      attribute :procedure, CodeableConcept
      attribute :additive, Resource(Substance)
    end
    class SpecimenContainerIdentifier
      attribute :identifier, Identifier
      attribute :description, string
      attribute :type, CodeableConcept
      attribute :capacity, Quantity
      attribute :specimenQuantity, Quantity
      attribute :additive, Resource(Substance)
    end
  end
end
class Substance
  attribute :Substance, Resource
  class SubstanceExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :identifier, Identifier
    attribute :name, string
    attribute :type, CodeableConcept
    attribute :description, string
    attribute :status, CodeableConcept
    attribute :effectiveTime, Period
    attribute :quantity, Quantity
    attribute :ingredient, Resource(Substance)
    attribute :quantityMode, CodeableConcept
  end
end
class Supply
  attribute :Supply, Resource
  class SupplyExtension
    attribute :extension, Extension
    attribute :text, Narrative
    attribute :contained, Resource
    attribute :name, CodeableConcept
    attribute :identifier, Identifier
    attribute :status, code
    attribute :orderedItem, Resource(Medication|Substance|Device)
    attribute :patient, Resource(Patient)
    attribute :dispense, 
    class SupplyDispenseIdentifier
      attribute :identifier, Identifier
      attribute :status, code
      attribute :type, CodeableConcept
      attribute :quantity, Quantity
      attribute :suppliedItem, Resource(Medication|Substance|Device)
      attribute :supplier, Resource(Practitioner)
      attribute :whenPrepared, Period
      attribute :whenHandedOver, Period
      attribute :destination, Resource(Location)
      attribute :receiver, Resource(Practitioner)
    end
  end
end
