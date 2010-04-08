module VendorsHelper
  def select_tag_for_name(vendor)
    Vendor.all.map {|v| "<option value=#{v.id}" +
                        (vendor == v ? " selected='selected'" : "") +
                        ">#{v.name}</option>"}.join('')
  end
end
