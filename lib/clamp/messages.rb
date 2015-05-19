module Clamp

  def self.messages=(messages)
    @user_defined_messages = messages
  end

  def self.message(key, options={})
    @user_defined_messages ||= {}
    msg = @user_defined_messages[key] || messages[key]
    format_string(msg, options)
  end

  def self.messages
    {
      :too_many_arguments => "too many arguments",
      :option_required => "option '%<option>s' is required",
      :option_or_env_required => "option '%<option>s' (or env %<env>s) is required",
      :option_argument_error => "option '%<switch>s': %<message>s",
      :parameter_argument_error => "parameter '%<param>s': %<message>s",
      :env_argument_error => "$%<env>s: %<message>s",
      :unrecognised_option => "Unrecognised option '%<switch>s'",
      :no_such_subcommand => "No such sub-command '%<name>s'",
      :no_value_provided => "no value provided",
      :usage_heading => "Usage",
      :parameters_heading => "Parameters",
      :subcommands_heading => "Subcommands",
      :options_heading => "Options"
    }
  end

  private

  if (("%{foo}" % {:foo => "bar"}) == "bar")

    def self.format_string(format, params = {})
      format % params
    end

  else

    # string formatting for ruby 1.8
    def self.format_string(format, params = {})
      array_params = format.scan(/%[<{]([^>}]*)[>}]/).collect do |name|
        name = name[0]
        params[name.to_s] || params[name.to_sym]
      end
      format.gsub(/%[<]([^>]*)[>]/, '%').gsub(/%[{]([^}]*)[}]/, '%s') % array_params
    end

  end

end