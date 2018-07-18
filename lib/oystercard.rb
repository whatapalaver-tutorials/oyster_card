class Oystercard
    MAXIMUM_BALANCE = 90
    MINIMUM_FARE = 1
    attr_reader :balance, :journeys, :entry_station, :exit_station
   
    def initialize
        @balance = 0   
        @journeys = []
    end

    def top_up(amount)
        @amount = amount
        raise "Cannot top_up: Maximum balance of #{MAXIMUM_BALANCE} would be exceeded" if exceeds_limit?
        @balance += amount
    end

    def touch_in(station)
        raise "Touch in failed: Minimum fare of at least #{MINIMUM_FARE} required" unless minimum_fare_balance?
        @entry_station = station
        journeys << {entry_station: station, exit_station: nil}
    end

    def touch_out(station)
        deduct(MINIMUM_FARE)
        @exit_station = station
        journeys.last[:exit_station] = station
        @entry_station = nil
        @exit_station
    end

    def in_journey?
        !!entry_station
    end

    private

    def deduct(fare)
        @balance -= fare
    end

    def exceeds_limit?
        @balance + @amount > MAXIMUM_BALANCE
    end

    def minimum_fare_balance?
        @balance >= MINIMUM_FARE
    end
end