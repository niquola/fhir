# A collection of error, warning or information messages
# that result from a system action.
class Fhir::OperationOutcome < Fhir::Resource
  # An error, warning or information message that results from
  # a system action.
  class Issue < Fhir::ValueObject
    # error | warning | information
    # Should be present
    attribute :severity, Fhir::Code # code

    # Error or warning code
    attribute :type, Fhir::Coding # Coding

    # Additional description of the issue
    attribute :details, String # string

    # XPath of element(s) related to issue
    attribute :locations, Array[String] # string
  end

  # Should be present
  attribute :issues, Array[Issue] # 
end

