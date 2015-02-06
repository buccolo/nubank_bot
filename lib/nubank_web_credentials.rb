class NubankWebCredentials < Struct.new(:cpf, :senha)
  def self.from_env
    new(ENV['NUBANK_BOT_CPF'],
        ENV['NUBANK_BOT_SENHA'])
  end
end

