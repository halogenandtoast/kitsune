module ActionView
  module Helpers
    class FormBuilder
      def wysiwyg(method, options={})
        sanitized_object_name = @object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
        sanitized_method_name = method.to_s.sub(/\?$/,"")
        id = "#{sanitized_object_name}_#{sanitized_method_name}"
        if @object.kitsune_admin[:media]
          @template.content_for(:head) do 
            @template.capture do
              "<script>
              $(function() {
                $('textarea.wysiwyg').upload_maker('#{@template.url_for({:id => @object.kitsune_admin[:media].keys.first.to_s.classify, :action=>"new", :controller=>"admin/kitsune/media"})}');
              })
              </script>"
            end
          end
        end
        @template.send('text_area', @object_name, method, objectify_options(options.merge({:class => 'wysiwyg'}))) + @template.content_tag('script', "tinyMCE.execCommand('mceAddControl', true, '#{id}');")
      end
    end
  end
end