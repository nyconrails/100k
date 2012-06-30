class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private

        def build_flash_messages
          if flash.keys.any?
            div :class => 'flashes' do
              flash.each do |type, message|
                div(raw(message), :class => "flash flash_#{type}")
              end
            end
          end
        end
end
