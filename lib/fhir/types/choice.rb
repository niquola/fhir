# A code taken from a short list of codes that are not
# defined in a formal code system.
class Fhir::Choice < Fhir::DataType
  invariants do
    validates_presence_of :options
  end

  # Selected code
  attribute :code, Fhir::Code

  # A list of possible values for the code.
  class Option < Fhir::ValueObject
    invariants do
      validates_presence_of :code
    end

    # Possible code
    attribute :code, Fhir::Code

    # Display for the code
    attribute :display, String
  end

  attribute :options, Array[Option]

  # If order of the values has meaning
  attribute :is_ordered, Boolean
end

