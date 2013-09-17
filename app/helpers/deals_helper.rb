module DealsHelper
  # def link_to_add_fields(name, f, association, options={})
#     new_object = f.object.class.reflect_on_association(association).klass.new
#     fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
#       if options[:local].present?
#         render(association.to_s, :f => builder)
#       else
#         render( partial_path(f, options) + association.to_s, :f => builder)
#       end
#     end
#     link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'add_form_field')
#   end
#   
#   def partial_path(f, options={})
#     if options[:partial].present?
#       view_path = options[:partial] + "/"
#     else
#       view_path = "#{f.object.class.to_s.tableize}/"
#     end
#   end
#   
#  
#     def link_to_remove_fields(name, f)
#       f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
#     end
# 
#     def link_to_remove_partial(name, f)
#       f.hidden_field(:_destroy) + link_to_function(name, "remove_form_partial(this)", :class => "buttony top")
#     end

end
