<#
.SYNOPSIS
    Configuração Dinâmica do Cérebro do Agente (BRAIN) com o Cofre do Obsidian no Windows.
.DESCRIPTION
    Este script estabelece a conexão bidirecional em tempo real entre a pasta BRAIN do agente
    e o seu cofre local do Obsidian através de uma Junção NTFS de Diretório (Junction).
.PARAMETER VaultPath
    Caminho absoluto do seu cofre do Obsidian.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false, Position = 0)]
    [string]$VaultPath
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$BrainDir = Join-Path $ProjectRoot "BRAIN"
$EnvFile = Join-Path $ProjectRoot ".env"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  SE-OS: Configuração Dinâmica do Cofre do Obsidian (BRAIN)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# 1. Resolver o caminho do cofre
if (-not $VaultPath) {
    if (Test-Path $EnvFile) {
        $envContent = Get-Content $EnvFile
        foreach ($line in $envContent) {
            if ($line -match "^OBSIDIAN_VAULT_PATH\s*=\s*(.*)$") {
                $VaultPath = $matches[1].Trim().Trim('"').Trim("'")
                Write-Host "-> Caminho obtido do arquivo .env: $VaultPath" -ForegroundColor Yellow
                break
            }
        }
    }
}

if (-not $VaultPath -or $VaultPath -like "*SeuUsuario*") {
    $VaultPath = Read-Host "Por favor, digite o caminho completo do seu Cofre do Obsidian"
}

if (-not $VaultPath) {
    Write-Error "Caminho do cofre não fornecido. Operação abortada."
    exit 1
}

# Normalizar caminho
$VaultPath = [System.IO.Path]::GetFullPath($VaultPath)

# 2. Validar existência do cofre
if (-not (Test-Path $VaultPath)) {
    Write-Host "-> O diretório '$VaultPath' não existe. Deseja criá-lo agora? (S/N): " -NoNewline -ForegroundColor Yellow
    $confirm = Read-Host
    if ($confirm -match "^[sSyY]") {
        New-Item -ItemType Directory -Path $VaultPath -Force | Out-Null
        Write-Host "-> Cofre criado em: $VaultPath" -ForegroundColor Green
    } else {
        Write-Error "O diretório informado não existe. Operação abortada."
        exit 1
    }
}

# 3. Gerenciar o diretório BRAIN existente
if (Test-Path $BrainDir) {
    $item = Get-Item $BrainDir -Force
    if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
        Write-Host "-> Uma junção existente para BRAIN foi detectada. Atualizando..." -ForegroundColor Yellow
        cmd /c rmdir "$BrainDir"
    } else {
        Write-Host "-> Pasta BRAIN padrão encontrada. Conectando com o cofre..." -ForegroundColor Yellow
    }
}

# 4. Criar a junção NTFS dinâmica
Write-Host "-> Estabelecendo junção NTFS: BRAIN <===> $VaultPath" -ForegroundColor Cyan
cmd /c mklink /J "$BrainDir" "$VaultPath"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ SUCESSO: O Cérebro do Agente (BRAIN) está conectado dinamicamente ao seu Obsidian!" -ForegroundColor Green
    Write-Host "   Cofre Ativo: $VaultPath" -ForegroundColor Green
} else {
    Write-Error "Falha ao criar a junção NTFS. Verifique suas permissões de diretório."
}
