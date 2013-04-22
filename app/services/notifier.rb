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

    except(characters, options[:except])
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

  def except(characters, exclusions)
    if exclusions.nil?
      return characters 
    end

    exclusions = [exclusions] unless exclusions.is_a? Array

    if exclusions.any? { |e| !e.is_a?(Character) }
      raise ":except must be a Character or an array of Characters"
    end
    characters.reject { |e| exclusions.include? e }
  end
end
