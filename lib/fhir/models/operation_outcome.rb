# A collection of error, warning or information messages
# that result from a system action.
class Fhir::OperationOutcome < Fhir::Resource
  # Additional Content defined by implementations
  attribute :extension, Array[Extension]

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Array[ResourceLink[Resource]]

  # An error, warning or information message that results from
  # a system action.
  class Issue < Fhir::ValueObject
    # error | warning | information
    # Should be present
    attribute :severity, code

    # Error or warning code
    attribute :type, Coding

    # Additional description of the issue
    attribute :details, string

    # XPath of element(s) related to issue
    attribute :location, Array[string]
  end

  # Should be present
  attribute :issue, Array[Issue]
end

