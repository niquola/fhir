class OperationOutcome
  attribute :extension, Extension
  attribute :text, Narrative
  attribute :contained, Resource
  attribute :issue, Issue
  class Issue
    attribute :severity, code
    attribute :type, Coding
    attribute :details, String
    attribute :location, String
  end
end
