module AdHocUtils

  def ad_hoc_option_value_ids # (variant_id)
    ids=[]

    params[:ad_hoc_option_values].each do |ignore,pov_id|

      # pov=ProductOptionValue.find(pov_id)   # we don't actually need to load these from the DB just yet.  We might already have them attached to the line item

      # when it's a multi-select
      if pov_id.is_a?(Array)
        pov_id.each do |p|
          ids << p unless p.empty?
        end
      else
        ids << pov_id unless pov_id.empty?
      end
    end if params[:ad_hoc_option_values]

    ids
  end
end
