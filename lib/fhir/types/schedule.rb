# A schedule that specifies an event that may occur multiple
# times. Schedules are not used for recording when things did
# happen, but when they are expected or requested to occur.
class Fhir::Schedule < Fhir::DataType
  # When the event occurs
  attribute :event, Array[Fhir::Period]

  # Identifies a repeating pattern to the intended time
  # periods.
  class Repeat < Fhir::ValueObject
    invariants do
      validates_presence_of :duration
      validates_presence_of :units
    end

    # Event occurs frequency times per duration
    attribute :frequency, Integer

    # HS | WAKE | AC | ACM | ACD | ACV | PC | PCM | PCD | PCV -
    # common life events
    attribute :when, Fhir::Code

    # Repeating or event-related duration
    attribute :duration, Float

    # s | min | h | d | wk | mo | a - unit of time (UCUM)
    attribute :units, Fhir::Code

    # Number of times to repeat
    attribute :count, Integer

    # When to stop repeats
    attribute :end, DateTime
  end

  attribute :repeat, Repeat
end

Fhir.load_extension('schedule')
