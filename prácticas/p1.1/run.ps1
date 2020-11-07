[Console]::OutputEncoding = [System.Text.Encoding]::UTF8


# Directorios
$deps = "deps"
$mods = "mods"
$sim = "sim"
$obj_ext = "vvp"

function MenuOptions {
    cls
    $modo = Read-Host -Prompt "Elija un modo: 
    `r`n 
    C - Compilar
    S - Generar simulación
    L - Limpiar directorio /$sim
    T - Terminar
    `r`nOption"
    return $modo
}


function SwitchMenu($modo) {
    switch ( $modo )
    {
        'C' {             
            cd $mods
            $name = Read-Host -Prompt "Especifique un nombre"
            $my_mods = (dir *.v)
            iverilog -o "..\$sim\$name.$obj_ext" $my_mods

            "`r`n"
            $ba = @((dir *.v) -join "`n`r")
            $ba
            "`r`n" 

            cd ..
            break 
        }

        'S' {
            cd $sim
            $name = Read-Host -Prompt "Especifique el fichero (sin extension) que quiera simular"
            
            "`r`n"
            vvp ".\$name.$obj_ext"
            "`r`n"

            cd ..
            break
        }

        'T' { exit }
        
        default { }
    }
}

Do {
    $modo = MenuOptions
    SwitchMenu( $modo )
} until( $modo -in 'C', 'S', 'L' )