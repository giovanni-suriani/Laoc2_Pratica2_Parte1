transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/ProcessadorMulticiclo.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/ULA.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/registradoresR.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/registradoresI.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/Processador.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/mux.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/decodificador.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/dec3to8.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/counter.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/contadoresR.v}
vlog -vlog01compat -work work +incdir+E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2 {E:/Documentos/CEFET/OneDrive/2023-2/2ECOM028_LAB-ARQUITETURA-ORGANIZACAO-DE-COMPUTADORES-II_T02_6T34/P02/Part1rev2/MemLPM.v}

