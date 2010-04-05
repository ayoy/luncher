# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def to_currency(number)
    number_to_currency(number, :precision => 2, :unit => "zł", :format => "%n%u")
  end

  def observe_fields(fields, options)

    # prepare a value of the :with parameter
    with = ""
    fields.each do |field|
      with += "'"
      with += "&" if field != fields.first
      with += field + "='+escape($('" + field + "').value)"
      with += " + " if field != fields.last
    end

    # generate a call of the observer_field helper for each field
    ret = "";
    fields.each do |field|
      ret += observe_field(field, options.merge( { :with => with }))
    end

    ret
  end
end
