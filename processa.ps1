# Limpa a tela do terminal
Clear-Host

# Exibe o título
Write-Host "SCRIPT PARA RENOMEAR O COMPUTADOR" -ForegroundColor Cyan
Write-Host "==================================="

# Pergunta ao usuário se ele deseja alterar o nome do computador
$changeName = Read-Host "Você deseja alterar o nome do computador? (S/N)"

# Verifica a resposta do usuário
if ($changeName -eq "S" -or $changeName -eq "s") {
    
    # Captura o endereço MAC da interface de rede principal
    $macAddress = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true } | Select-Object -ExpandProperty MACAddress

    # Remove os separadores (dois-pontos) e pega apenas os 6 últimos caracteres do endereço MAC
    $macLast6Digits = ($macAddress -replace ":", "").Substring(6)

    # Solicita que o usuário insira um texto no prompt
    $userInput = Read-Host "Digite o texto que deseja adicionar ao nome do computador"

    # Combina o texto do usuário com os 6 últimos dígitos do MAC, separados por um hífen
    $newComputerName = "$userInput-$macLast6Digits"

    # Renomeia o computador usando o novo nome gerado
    Rename-Computer -NewName $newComputerName

	pause
    # Reinicia o computador para aplicar as alterações
    Restart-Computer -Force

} else {
    # Sai da console sem fazer nenhuma alteração
    Write-Host "O nome do computador não será alterado. Saindo da console..."
    exit
}
