# NubankBot (WIP)
Extraia suas informações financeiras do Nubank!

Você roda o bot com seus dados de acesso, ele extrai as transações do cartão.

## Uso

### Configurações

| Variavel            | Descrição |
| --------------------|---------------|
| `NUBANK_BOT_CPF`    | CPF do titular |
| `NUBANK_BOT_SENHA`  | Senha eletrônica |
| `NUBANK_BOT_URL`    | URL para qual o NubankBot mandará as informações |

### Rodando o NubankBot

```bash
export NUBANK_BOT_CPF="111.333.222-12"
export NUBANK_BOT_SENHA="123oliveira4"
export NUBANK_BOT_URL="http://site.com.br/path"

git clone git@github.com:buccolo/nubank_bot.git
cd nubank_bot/
bundle install
bundle exec rake nubank_bot:run
```

### Lendo o output do NubankBot

Por razões de performance, os dados do NubankBot trafegam em formato Base64 de uma compressão Zlib de um JSON:
```ruby
require 'base64'
require 'zlib'

bot_response = JSON.parse(
  Zlib::Inflate.inflate(
    Base64.decode64(
      request.raw_post
    )
  )
)

return unless bot_response[:success] # o bot pode falhar

bot_response[:credit].each do |transactions|
  ## faça algo incrível aqui
end
```

## LICENSE

The MIT License

Copyright (c) 2015 Bruno de Campos Buccolo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
