require 'pp'
class TravelportResult

  attr :flight_details,
       :air_segment,
       :pricing_solutions,
       :fare_info

  def initialize(response)
    response.process
    @flight_details = response.flight_details_list.collect { |record| record.last.attributes }
    @air_segment = response.air_segment_list.collect { |record| record.last.attributes }
    @pricing_solutions = response.pricing_solutions.collect { |record| record.last.attributes }
    @fare_info = response.fare_info_list.collect { |record| record.last.attributes }
    merge_air_segments_with_flight_details
  end

  def merged
    extract = %w(booking_info tax_info passenger_type @plating_carrier @e_ticketability @pricing_method)
    remove = %w(total_price approximate_total_price approximate_base_price air_pricing_info)
    @pricing_solutions.collect do |segment|
      #flatten the structure
      extract.each {|node| segment[node.gsub('@','')] = segment['air_pricing_info'][node]}
      remove.each {|node| segment.delete(node)}
      segment['booking_info'] = [segment['booking_info']].flatten.collect do |info|
        details = find_air_segment(info['@segment_ref'])
        fare = find_fare(info['@fare_info_ref'])
        info.merge!(details) if details
        info.merge!(fare) if fare
        info
      end
      if segment['equivalent_base_price'] && segment['equivalent_base_price'].is_a?(Travelport::Model::Price)
        segment['equivalent_base_price'] = "#{segment['equivalent_base_price'].currency}#{segment['equivalent_base_price'].amount}"
      end
      pp segment
      segment
    end
  end

  def merge_air_segments_with_flight_details
    @air_segment.collect! {|segment| segment.merge({'flight' => find_flight_details(segment['flight_details_ref'])})}
  end

  def find_flight_details(key)
    @flight_details.find {|record| record['key'] == key}
  end

  def find_air_segment(key)
    @air_segment.find {|record| record['key'] == key}
  end

  def find_fare(key)
    @fare_info.find {|record| record['key'] == key}
  end
end