%include "io.inc"

extern _printf

section .data

puntero dq 25.0,1.5,1.0,0.5
resul dq 0.0
formato db "el numero es : %f", 10,13,0
n dq 2.0
temp dq 0.0
ind dd 0
cont db 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    push puntero
    mov edx, [n+4]
    push edx
    mov edx, [n]
    push edx
    call producto_rvf
    add esp, 12
    ;push dword[resul+4]
;    push dword[resul] 
;    push formato
;    call printf
;    add esp, 12
    xor eax, eax
    ret
    
    producto_rvf:
   
        ;Considerar metodo enter y leave
        ;Desarrollar la logica para recorrer el vector y hacer el producto escalar
        
        ;enter
        push ebp
        mov ebp,esp
        
       _ciclo: 
       
        mov esi,[ind]; esi tiene tamaño de 32bits y ind tiene que tener el mismo tamaño
        mov dx,[puntero + esi*8]; 
        
        fld qword [puntero + esi*8] ; acccedo el primer valor del vector
        fld qword [n]; accedo al numero entero a multiplicar
        fmul
        fst qword [temp] ; guardo a variable temporal el resultado.
        
                
        push dword [temp +4]
        push dword [temp]   
        push formato
        call printf   
        add esp,12
        
        
        mov cl,[ind] ; me guardo el ind en ch para poder incrementarlo enla prox iteracion
        inc cl
        mov [ind],cl
        ;PRINT_UDEC 1,cl
        
        
        mov cl,[cont] ;  recupero mi variable cont a registro
        DEC Cl ; decremento el cl 
        mov [cont],cl ;aviso a la variable cont q el cl va a decrementar
        CMP Cl,0 ; comparo a 0
        JG _ciclo
        
             
                  
                            
        ;leave      
        mov ebp,esp
        pop ebp         
 
    ret
