# A collection of error, warning or information messages
# that result from a system action.
class Fhir::OperationOutcome < Fhir::Resource
  invariants do
    validates_presence_of :issue
  end

  # Extensions that cannot be ignored
  attribute :modifier_extension, Array[Fhir::Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Fhir::Narrative

  # An error, warning or information message that results from
  # a system action.
  class Issue < Fhir::ValueObject
    invariants do
      validates_presence_of :severity
    end

    # Extensions that cannot be ignored
    attribute :modifier_extension, Array[Fhir::Extension]

    # fatal | error | warning | information
    attribute :severity, Fhir::Code

    # Error or warning code
    attribute :type, Fhir::Coding

    # Additional description of the issue
    attribute :details, String

    # XPath of element(s) related to issue
    attribute :location, Array[String]
  end

  attribute :issue, Array[Issue]
end


Fhir.load_extension('operation_outcome')
