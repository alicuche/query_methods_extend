module QueryMethodsExtend
  class Railtie < Rails::Railtie
    initializer "query_methods_extend.initializer" do
      ActiveSupport.on_load(:active_record) do
        include QueryMethodsExtend
      end
    end
  end
end