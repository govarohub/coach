# ==========================================================
# Coach Core Kit
# Generador de Arquitectura
# Versión: 1.0
# Autor: GovaroHub
# ==========================================================

Write-Host ""
Write-Host "============================================="
Write-Host " Coach Core Kit - Arquitectura"
Write-Host "============================================="
Write-Host ""

# Ruta del proyecto Flutter
$project = "C:\Desarrollo\Coach\coach_app"

if (!(Test-Path $project)) {
    Write-Host "ERROR: No existe el proyecto Flutter."
    exit
}

# Lista de carpetas
$folders = @(

"lib/app",

"lib/core",
"lib/core/config",
"lib/core/constants",
"lib/core/enums",
"lib/core/errors",
"lib/core/exceptions",
"lib/core/extensions",
"lib/core/logger",
"lib/core/responsive",
"lib/core/services",
"lib/core/theme",
"lib/core/utils",
"lib/core/validators",

"lib/shared",
"lib/shared/animations",
"lib/shared/components",
"lib/shared/dialogs",
"lib/shared/layouts",
"lib/shared/widgets",

"lib/features",

"lib/features/splash",

"lib/features/authentication",
"lib/features/authentication/data",
"lib/features/authentication/data/datasources",
"lib/features/authentication/data/models",
"lib/features/authentication/data/repositories",
"lib/features/authentication/domain",
"lib/features/authentication/domain/entities",
"lib/features/authentication/domain/repositories",
"lib/features/authentication/domain/usecases",
"lib/features/authentication/presentation",
"lib/features/authentication/presentation/pages",
"lib/features/authentication/presentation/providers",
"lib/features/authentication/presentation/widgets",

"lib/features/user",
"lib/features/user/data",
"lib/features/user/data/datasources",
"lib/features/user/data/models",
"lib/features/user/data/repositories",
"lib/features/user/domain",
"lib/features/user/domain/entities",
"lib/features/user/domain/repositories",
"lib/features/user/domain/usecases",
"lib/features/user/presentation",
"lib/features/user/presentation/pages",
"lib/features/user/presentation/providers",
"lib/features/user/presentation/widgets",

"lib/features/coach",
"lib/features/coach/data",
"lib/features/coach/data/datasources",
"lib/features/coach/data/models",
"lib/features/coach/data/repositories",
"lib/features/coach/domain",
"lib/features/coach/domain/entities",
"lib/features/coach/domain/repositories",
"lib/features/coach/domain/usecases",
"lib/features/coach/presentation",
"lib/features/coach/presentation/pages",
"lib/features/coach/presentation/providers",
"lib/features/coach/presentation/widgets",

"lib/features/reservation",
"lib/features/reservation/data",
"lib/features/reservation/data/datasources",
"lib/features/reservation/data/models",
"lib/features/reservation/data/repositories",
"lib/features/reservation/domain",
"lib/features/reservation/domain/entities",
"lib/features/reservation/domain/repositories",
"lib/features/reservation/domain/usecases",
"lib/features/reservation/presentation",
"lib/features/reservation/presentation/pages",
"lib/features/reservation/presentation/providers",
"lib/features/reservation/presentation/widgets",

"lib/features/payment",
"lib/features/payment/data",
"lib/features/payment/data/datasources",
"lib/features/payment/data/models",
"lib/features/payment/data/repositories",
"lib/features/payment/domain",
"lib/features/payment/domain/entities",
"lib/features/payment/domain/repositories",
"lib/features/payment/domain/usecases",
"lib/features/payment/presentation",
"lib/features/payment/presentation/pages",
"lib/features/payment/presentation/providers",
"lib/features/payment/presentation/widgets",

"lib/features/maps",
"lib/features/maps/data",
"lib/features/maps/domain",
"lib/features/maps/presentation",

"lib/features/chat",
"lib/features/chat/data",
"lib/features/chat/domain",
"lib/features/chat/presentation",

"lib/features/notification",
"lib/features/notification/data",
"lib/features/notification/domain",
"lib/features/notification/presentation",

"lib/features/admin",
"lib/features/admin/data",
"lib/features/admin/domain",
"lib/features/admin/presentation",

"assets",
"assets/images",
"assets/icons",
"assets/fonts",
"assets/logos",
"assets/animations",
"assets/sounds",

"docs"
)

foreach ($folder in $folders) {

    $path = Join-Path $project $folder

    if (!(Test-Path $path)) {

        New-Item -ItemType Directory -Path $path | Out-Null

        Write-Host "[OK] $folder"

    }

}

Write-Host ""
Write-Host "Arquitectura creada correctamente."
Write-Host ""