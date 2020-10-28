param(

    [string] $p,
    [string] $t

)

switch ( $p ) 
{

    'comp' { iverilog -Wall -o prueba .\modules\ha_v1_tb.v .\modules\ha_v1.v }
    'sim' { vvp prueba.o }
    'gtkw' { gtkwave ha_v1_tb.vcd }

}

switch ( $t ) 
{

    'compile' { iverilog -Wall -o prueba .\modules\ha_v1.v }
    'simulate' { vvp }
    'gtkwave' { gtkwave }

}

