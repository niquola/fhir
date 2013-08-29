class OperationOutcome
  include Virtus
  # Additional Content defined by implementations
  attribute :extension, Extension

  # Text summary of the resource, for human interpretation
  attribute :text, Narrative

  # Contained, inline Resources
  attribute :contained, Resource

  # A single issue associated with the action
  attribute :issue, Issue

  class Issue
    include Virtus::ValueObject
    # error | warning | information
    attribute :severity, code

    # Error or warning code
    attribute :type, Coding

    # Additional description of the issue
    attribute :details, String

    # XPath of element(s) related to issue
    attribute :location, String

  end
end
