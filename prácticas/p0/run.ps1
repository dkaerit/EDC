param(

    [string] $n,   # se especifica un nombre del obj a simular

    [switch] $c,  # 
    [switch] $W,

    [switch] $vvp, # crear fichero de simulación

    [switch] $clr, # limmpiar sim
    [switch] $vf,  # se especifica a clr para limpiar los vcd
    [switch] $of   # se especifica a clr para limpiar los obj

)

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# Directories
$deps = "deps"
$mods = "mods"
$sim = "sim"
$obj_ext = "obj"

# Compilación
if ( $c ) {
    cd $mods
    $my_mods = (dir *.v)

    $name = "def"
    $confirm = "Y"
    if ( !$n ) { $confirm = Read-Host -Prompt "No especifica nombre, se va a utilizar '$name' por defecto, `r`n [Y (utilizar por defecto) / N (utilizar otro nombre)]" }
    else { $name = $n }
    if ( $confirm -ne 'Y' ) { $name = Read-Host -Prompt "Introduce nuevo nombre" }

    if ( $W ) { iverilog -Wall -o "..\$sim\$name.$obj_ext" $my_mods }
    else { iverilog -o "..\$sim\$name.$obj_ext" $my_mods }
    cd ..
}

# generate vcd
if ( $vvp ) {
    cd $sim
    
    $name = "def"
    $confirm = "Y"
    if ( !$n ) { $confirm = Read-Host -Prompt "No especifica nombre, se va a utilizar '$name' por defecto: $name, ¿Estoy de acuerdo? [Y/N]" }
    else { $name = $n }
    if ( $confirm -ne 'Y' ) { $name = Read-Host -Prompt "Introduce nuevo nombre: " }
    
    vvp ".\$name.$obj_ext"
    cd ..
}


# clean obj
if ( $clr ) {
    $path = ".\$sim\*"
    if ( $vf ) { Remove-Item –path $path -include *.vcd }
    if ( $of ) { Remove-Item –path $path -include *.$obj_ext }
}