transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/computador.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/memory.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/ProcessadorMult.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/contador3Bits.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/controlador.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/multiplexador.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/registrador.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/registrador1b.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/registradorPC.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/ula.v}
vlog -vlog01compat -work work +incdir+D:/Faculdade/LAOC\ II/pratica2/computador {D:/Faculdade/LAOC II/pratica2/computador/decodificadorComportamental.v}

