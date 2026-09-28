<#
.SYNOPSIS
    Instala as skills nativas do Software Engineering Agent no Gemini CLI / Antigravity.

.DESCRIPTION
    Copia as skills de .agents/skills/ para o diretório de configuração global (~/.gemini/config/skills/)
    ou local do workspace, tornando os slash commands (/audit, /sdd, /architect, etc.) disponíveis nativamente.

.PARAMETER Global
    Instala no diretório de configuração global da máquina (~/.gemini/config/skills). Padrão: $true.

.PARAMETER Force
    Sobrescreve skills existentes sem confirmação.

.EXAMPLE
    .\scripts\install-skills.ps1
    Instala todas as skills globalmente.

.EXAMPLE
    .\scripts\install-skills.ps1 -Force
    Reinstala e atualiza todas as skills globalmente.
#>

[CmdletBinding()]
param(
    [switch]$Global = $true,
    [switch]$Force = $false
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceSkillsDir = Join-Path $repoRoot ".agents\skills"

if (-not (Test-Path $sourceSkillsDir)) {
    Write-Error "Diretorio de origem das skills nao encontrado: $sourceSkillsDir"
}

if ($Global) {
    $targetDir = Join-Path $HOME ".gemini\config\skills"
} else {
    $targetDir = $sourceSkillsDir
    Write-Host "As skills ja estao instaladas no workspace local (.agents/skills)." -ForegroundColor Green
    return
}

if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Write-Host "Diretorio de destino criado: $targetDir" -ForegroundColor Cyan
}

$skills = Get-ChildItem -Directory -Path $sourceSkillsDir

Write-Host "Instalando skills nativas no Gemini CLI..." -ForegroundColor Cyan
Write-Host "Origem : $sourceSkillsDir"
Write-Host "Destino: $targetDir"
Write-Host ""

$installedCount = 0

foreach ($skill in $skills) {
    $skillName = $skill.Name
    $destSkillPath = Join-Path $targetDir $skillName

    if (Test-Path $destSkillPath) {
        if ($Force) {
            Remove-Item -Path $destSkillPath -Recurse -Force
            Copy-Item -Path $skill.FullName -Destination $destSkillPath -Recurse -Force
            Write-Host " [ATUALIZADO] /$skillName -> $destSkillPath" -ForegroundColor Yellow
            $installedCount++
        } else {
            Write-Host " [IGNORADO]   /$skillName ja existe. Use -Force para sobrescrever." -ForegroundColor DarkGray
        }
    } else {
        Copy-Item -Path $skill.FullName -Destination $destSkillPath -Recurse -Force
        Write-Host " [INSTALADO]  /$skillName -> $destSkillPath" -ForegroundColor Green
        $installedCount++
    }
}

Write-Host ""
Write-Host "Concluido: $installedCount skills registradas com sucesso." -ForegroundColor Green
Write-Host "Comandos disponiveis no CLI: /audit, /sdd, /review, /analyze, /architect, /security, /test, /performance, /refactor" -ForegroundColor Cyan
