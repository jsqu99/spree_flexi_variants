module SpreeFlexiVariants
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file "app/assets/javascripts/store/all.js", "//= require store/exclusions\n"
        append_file "app/assets/javascripts/store/all.js", "//= require jquery.formatCurrency-1.4.0.min\n"
      end

      def add_stylesheets
        inject_into_file "app/assets/stylesheets/store/all.css", " *= require store/flexi-variants\n", :before => /\*\//, :verbose => true
      end
    end
  end
end
