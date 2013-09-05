# A collection of error, warning or information messages
# that result from a system action.
class Fhir::OperationOutcome < Fhir::Resource
  invariants do
    validates_presence_of :issues
  end

  # An error, warning or information message that results from
  # a system action.
  class Issue < Fhir::ValueObject
    invariants do
      validates_presence_of :severity
    end

    # error | warning | information
    # Should be present
    attribute :severity, Fhir::Code

    # Error or warning code
    attribute :type, Fhir::Coding

    # Additional description of the issue
    attribute :details, String

    # XPath of element(s) related to issue
    attribute :locations, Array[String]
  end

  # Should be present
  attribute :issues, Array[Issue]
end

