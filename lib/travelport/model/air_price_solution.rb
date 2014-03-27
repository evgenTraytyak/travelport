module Travelport::Model
  class AirPriceSolution < Base
    attr_accessor :air_segment_ref,
      :air_segment_ref,
     :air_pricing_info,
     :fare_note,
     :key,
     :total_price,
     :base_price,
     :approximate_total_price,
     :approximate_base_price,
     :equivalent_base_price,
     :taxes
  end
end
