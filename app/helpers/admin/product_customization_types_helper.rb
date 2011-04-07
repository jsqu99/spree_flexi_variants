module Admin::ProductCustomizationTypesHelper
    def validation_string(data_type, req)
      validation_str=case data_type 
                   when "string" then ""
                   when "integer" then "digits" # that's what jquery.validate uses
                   when "decimal" then "number" # that's what jquery.validate uses
                   else ""
                 end
      validation_str+= " required" if req
      validation_str
    end
end
