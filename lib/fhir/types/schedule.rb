# A schedule that specifies an event that may occur multiple
# times. Schedules are not used for recording when things did
# happen, but when they are expected or requested to occur.
class Fhir::Schedule < Fhir::Type
  # When the event occurs
  attribute :events, Array[Fhir::Period] # Period

  # Identifies a repeating pattern to the intended time
  # periods.
  class Repeat < Fhir::ValueObject
    # Event occurs frequency times per duration
    attribute :frequency, Integer # integer

    # Event occurs duration from common life event
    attribute :when, Fhir::Code # code

    # Repeating or event-related duration
    # Should be present
    attribute :duration, Float # decimal

    # The units of time for the duration
    # Should be present
    attribute :units, Fhir::Code # code

    # Number of times to repeat
    attribute :count, Integer # integer

    # When to stop repeats
    attribute :end, DateTime # dateTime
  end

  attribute :repeat, Repeat # 
end

