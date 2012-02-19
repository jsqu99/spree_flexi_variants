module Spree
  ProductsController.class_eval do
    def customize
      # copied verbatim from 0.60 ProductsController#show, except that I changed id to product_id on following line
      # TODO: is there another way?  e.g. render :action => "show", :template => "customize" ?

      @product = Product.find_by_permalink!(params[:product_id])
      return unless @product

      @variants = Variant.active.includes([:option_values, :images]).where(:product_id => @product.id)
      @product_properties = ProductProperty.includes(:property).where(:product_id => @product.id)
      @selected_variant = @variants.detect { |v| v.available? }

      referer = request.env['HTTP_REFERER']

      # HTTP_REFERER_REGEXP (from spree) is unknown constant sometimes.  not sure why.
      if referer && referer.match(/^https?:\/\/[^\/]+\/t\/([a-z0-9\-\/]+)$/)
        @taxon = Taxon.find_by_permalink($1)
      end

      respond_with(@product)
    end
  end
end
