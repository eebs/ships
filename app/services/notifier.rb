class Notifier
  
  attr_reader :options
  attr_reader :who
  attr_accessor :message

  def initialize(who, options = {})
    if who.is_a? Character
      options[:character] = who
      who = :character
    end
    @options = options
    @who = who
  end

  def recipients
    case who
    when :character
      character = options[:character]
      raise "character must be a Character object" unless character.is_a? Character
      characters = [character]
    when :admins
      characters = Character.admins
    when :all
      characters = Character.all
    else
      raise "Invalid option specified for who"
    end

    characters = include_characters(characters, options[:include])
    characters = except(characters, options[:except])
  end

  def send
    if message.nil?
      raise "No message configured to send"
    end

    recipients.each do |recipient|
      recipient.notify(message)
    end
  end

private

  def include_characters(characters, inclusions)
    inclusions = validate_option(inclusions)
    characters + inclusions
  end

  def except(characters, exclusions)
    exclusions = validate_option(exclusions)
    characters.reject { |e| exclusions.include? e }
  end

  def validate_option(option)
    if option.nil?
      return []
    end

    option = [option] unless option.is_a? Array

    if option.any? { |e| !e.is_a?(Character) }
      raise ":include and/or :except must be a Character or an array of Characters"
    end
    return option
  end
end
