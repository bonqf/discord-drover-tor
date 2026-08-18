# English

# My comment

I modified the original Drover so that it automatically initializes the Tor Backend and made Drover automatically use it as a "Proxy".

One made to "Bypass" the new restrictions ordered by Janja. I believe this tool provides a better solution than a VPN or other free Proxies that you can find, despite not being the fastest solution in the world... Please share it with anyone you think needs it.

# Discord Drover (Proxy Settings for Discord)

Discord Drover is a program that forces the Discord application for Windows to route its TCP connections (chat, updates) through Tor. This may be necessary because the original Discord application lacks proxy settings, and the global system proxy is also not used.
Additionally, the program slightly modifies Discord's outgoing UDP traffic, which helps bypass some local restrictions on voice chats.
The program works locally at the specific process level (without drivers) and does not affect the operating system globally. This approach serves as an alternative to using a global VPN (such as TUN interfaces and others).

## ⚠️ Warnings

* The call region cannot be set to Brazil.
* File uploads are not possible.
* Connection rotation may log you out of your account or cause Discord to ask you to verify your email or phone number because the connection is considered suspicious.

## ⚠️ Alternative

There is an alternative that works better, but it requires Vencord:
https://github.com/bezumiya/GoLiveBypass

## Installation

The latest version of the program can be downloaded from the [latest release page](https://github.com/bonqf/discord-drover-tor/releases).

### Automatic Installation

For an easier setup, use the included installer `drover.exe`. Run the program, set the path to your Tor executable, then click **Install** to automatically place the necessary files in the correct folder.
The installer defaults to `socks5://127.0.0.1:9050`, which is the standard local SOCKS5 port used by Tor Browser and the standalone Tor daemon. If Tor Browser is installed, the default path is detected automatically.
To uninstall the program and remove all associated files, run `drover.exe` again and click **Uninstall**.

## Features

* Forces Discord to route TCP connections through Tor (SOCKS5 on `127.0.0.1:9050` by default).
* Slight interference with UDP traffic to bypass voice chat restrictions.
* No drivers or system-level modifications are required.
* Works locally at the process level, offering an alternative to global VPN solutions.
* Supports Discord Canary and PTB versions in addition to the main version.
* ## BTW
* I modified the version of the tool for my particular use. If you want to suggest features or find a bug, please open an issue.


# Português

# Meu comentário

Eu modifiquei o Drover (original) para ele inicializar automaticamente o Backend do Tor e fiz o Drover automaticamente usar ele como "Proxy".

Uma feita para "Burlar" as novas restrições ordenadas pela Janja. Creio que essa ferramenta fornece uma solução melhor do que VPN ou outros Proxys gratuitos que você conseguir encontrar, apesar de não ser a solução mais rápida do mundo... Por favor, divulgue para quem você achar que precisa.

# Discord Drover (Proxy Settings for Discord)

Discord Drover é um programa que força o aplicativo Discord para Windows a encaminhar suas conexões TCP (chat, atualizações) através do Tor. Isso pode ser necessário porque o aplicativo original do Discord não possui configurações de proxy, e o proxy global do sistema também não é utilizado.
Além disso, o programa modifica levemente o tráfego UDP de saída do Discord, o que ajuda a contornar algumas restrições locais em chats de voz.
O programa funciona localmente no nível de processo específico (sem drivers) e não afeta o sistema operacional globalmente. Essa abordagem serve como uma alternativa ao uso de uma VPN global (como interfaces TUN e outras).

## ⚠️ Avisos

* A região da call não pode estar definida como Brasil.
* Não é possível fazer upload de arquivos.
* A rotação da conexão pode fazer com que você seja deslogado da sua conta ou que o Discord peça para verificar seu e-mail ou telefone devido à conexão ser considerada suspeita.

## ⚠️ Alternativa

Existe uma alternativa que funciona melhor, porém requer o Vencord:
https://github.com/bezumiya/GoLiveBypass

## Instalação

A versão mais recente do programa pode ser baixada na [página de releases mais recente](https://github.com/bonqf/discord-drover-tor/releases).

### Instalação Automática

Para uma configuração mais fácil, use o instalador incluído `drover.exe`. Execute o programa, defina o caminho para o seu executável do Tor e clique em **Install** para colocar automaticamente os arquivos necessários na pasta correta.
O instalador usa `socks5://127.0.0.1:9050` por padrão, que é a porta SOCKS5 local padrão usada pelo Tor Browser e pelo daemon Tor independente. Se o Tor Browser estiver instalado, o caminho padrão será detectado automaticamente.
Para desinstalar o programa e remover todos os arquivos associados, execute `drover.exe` novamente e clique em **Uninstall**.

## Recursos

* Força o Discord a encaminhar conexões TCP através do Tor (SOCKS5 em `127.0.0.1:9050` por padrão).
* Pequena interferência no tráfego UDP para contornar restrições de chat de voz.
* Nenhum driver ou modificação em nível de sistema é necessária.
* Funciona localmente no nível de processo, oferecendo uma alternativa às soluções de VPN global.
* Suporta as versões Discord Canary e PTB, além da versão principal.
* ## BTW
* Eu modifiquei a versão da ferramenta para meu uso específico. Se quiser sugerir recursos ou encontrar um bug, abra uma issue.
