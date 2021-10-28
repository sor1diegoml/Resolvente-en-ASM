
extern printf

section .data

valor_a dq 1.5
valor_b dq 5.0
valor_c dq -1.0

t_menosb dq 0.0
t_2a dq 0.0
t_menos4ac dq 0.0
t_bcuad dq 0.0
t_rad dq 0.0
t_radcuad dq 0.0
t_raiz1 dq 0.0
t_raiz2 dq 0.0

formato db "El resultado es:%f",10.0
constante0 dq -1.0
constante1 dq 2.0
constante2 dq -4.0


section .text
	global cuadratica

	cuadratica:

    push ebp ;enter
    mov ebp, esp 
    
    ;-b
    finit
    fld qword [ valor_b] ; apilo b
    fld qword [ constante0]; apilo -1
    fmul ; ;mul STO*ST1=ST0
    fst qword[t_menosb];lo guardo en su variable temp.
    
    ;2a
    finit 
    fld qword [ valor_a] ; apilo a
    fld qword [ constante1]; apilo 2
    fmul ; ;mul STO*ST1=ST0
    fst qword[t_2a];lo guardo en su variable temp.
    

    
    ;b*2
    finit 
    fld qword [ valor_b] ; apilo b
    fld qword [ valor_b]; apilo b nuevamente
    fmul ; ;mul STO*ST1=ST0
    fst qword[t_bcuad];lo guardo en su variable temp.
    
     ;-4ac
    finit 
    fld qword [ valor_a] ; apilo a
    fld qword [ valor_c]; apilo c
    fmul ; ;mul STO*ST1=ST0
    fld qword[constante2];apilo la constante de -4
    fmul; ;mul STO*ST1=ST0
    fst qword[t_menos4ac];lo guardo en su variable temp.
    
    ;resuelvo radicando
    finit
    fld qword [ t_bcuad] ; apilo bcuad
    fld qword [ t_menos4ac]; apilo b nuevamente
    fadd ;  STO*ST1=ST0
    fst qword[t_rad];lo guardo en su variable temp.
    
    ;resuelvo su raiz
    finit
    fld qword [ t_rad] ; apilo t_rad
    fsqrt  ; raiz cuadrada STO => ST0
    fst qword[t_radcuad];lo guardo en su variable temp
    
    ;raiz1
    finit 
    fld qword [ t_radcuad] ; apilo resultado de raiz
    fld qword [ t_menosb]; apilo -b
    fadd  ; sumo STO+ST1=ST0
    fld qword [t_2a]; apilo 2a.
    fdiv 
    fst qword [t_raiz1];guardo st0 en su variable temp.
    
    ;raiz2
    finit 
    fld qword [ t_radcuad] ; apilo resultado de raiz
    fld qword [ constante0]; apilo b nuevamente
    fmul  ; mul STO*ST1=ST0
    fld qword [t_menosb]; apilo -b.
    fadd  ;sumo STO+ST1=ST0
    fld qword [t_2a]; apilo 2a
    fdiv ; divido st1 por st0, el resultado en st0
    fst qword [t_raiz2];guardo st0 en su variable temp.
    
    ;llamo a print de raiz1
    push dword [t_raiz1+4]; parte baja de la pila
    push dword [t_raiz1]; parte alta de la pila
    push formato ;envio el formato a pila
    call printf ; llamo funcion
    add esp,12 ;
    
    ;llamo a print de raiz2
    push dword [t_raiz2+4]; parte baja de la pila
    push dword [t_raiz2]; parte alta de la pila
    push formato ;envio el formato a pila
    call printf ; llamo funcion
    add esp,12 ;
     
     mov ebp,esp
     pop ebp
     ret  
    
    
