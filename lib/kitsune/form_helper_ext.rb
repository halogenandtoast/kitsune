module ActionView
  module Helpers
    class FormBuilder
      def wysiwyg(method, options={})
        sanitized_object_name = @object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
        sanitized_method_name = method.to_s.sub(/\?$/,"")
        id = "#{sanitized_object_name}_#{sanitized_method_name}"
        @template.send('text_area', @object_name, method, objectify_options(options.merge({:class => 'wysiwyg'}))) + @template.content_tag('script', "new nicEditor().panelInstance('#{id}');")
      end
    end
  end
end