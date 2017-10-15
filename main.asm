INCLUDE Irvine32.inc

TAB = 9

.data	
	estados DWORD 24 DUP(0)
	municipios DWORD 9 DUP(0)
	parroquias DWORD 4 DUP (0)
	centros DWORD 26 DUP (0)
	votantespormesas DWORD 200 DUP (0)
	
	msjVotantes DB 'Ingrese cantidad de votantes: ',0
	msjVotoSi BYTE "Votos SI   : ",0
	msjVotoNo BYTE "Votos NO   : ",0
	msjVotoNulo BYTE "Votos Nulos: ",0
	msjGanoSi BYTE "Gano el SI!",0
	msjGanoNo BYTE "Gano el NO!",0
	msjEmpate BYTE "EMPATE!",0
	
	msjEstado	 BYTE "ESTADOS:",0
	msjMunicipio BYTE "MUNICIPIOS:",0
	cantVotantes DWORD 0
	numeroAleatorio DWORD 0
	var1 DWORD 0
	
	Alt1 DWORD 0
	votoSi DWORD 0
	votoNo DWORD 0
	votoNulo DWORD 0
	
	arrayEstados DWORD 24 DUP(0)
	arrayMunicipios DWORD 9 DUP (0)
	arrayParroquias DWORD 4 DUP (0)
	arrayCentro DWORD 26  DUP (0)
	arrayMesa DWORD 4 DUP (0)
	
.code

main PROC
	CALL Randomize

	CALL solicitarDatos
	CALL pasos
	;CALL generarVotos
	;CALL mostrarDatos

	;call verArreglo
	;call ImprimirArreglo
	exit
main ENDP

pasos PROC

	MOV EDX, OFFSET msjEstado
	call wRITEsTRING
	CALL CRLF
		
	MOV ESI, 0
	MOV ECX, cantVotantes
	L90:
		CALL CLRSCR
		
		push esi
		push ecx
		
		CALL alfa
		CALL alfa2
		
		pop ecx
		pop esi
		
		PUSH ECX
		PUSH ESI
		
		call ImprimirArreglo
		call ImprimirArreglo2
		
		POP ESI
		POP ECX
		
		ADD ESI, 4
		LOOP L90
		
	CALL CRLF
	RET
pasos ENDP

mostrarDatos PROC
	
	MOV EDX, OFFSET msjVotoSi      ;imprime un mensaje
	CALL WriteString
	
	MOV	EAX, votoSi
	CALL WriteDec
	CALL Crlf                      ;salto de linea
	
	MOV EDX, OFFSET msjVotoNo
	CALL WriteString
	
	MOV EAX, votoNo
	CALL WriteDec
	CALL Crlf
	
	MOV EDX, OFFSET msjVotoNulo
	CALL WriteString
	
	MOV EAX, votoNulo
	CALL WriteDec
	CALL Crlf
	CALL Crlf
	RET
mostrarDatos ENDP

alfa PROC
	
	;MOV ESI, 0
	;mov edi, esi
	;MOV ECX,LENGTH estados, LENGTH municipios
	;BUCLE:
	;	
	;	mov eax, 24
	;	call RandomRange
	;	mov estados[esi],eax
	;	ADD ESI,4
	;	LOOP BUCLE
	;call crlf
	
	mov EAX, 24
	CALL RandomRange
	MOV EDX, EAX
	;;CALL	WriteDec
	;;CALL	CrLf
	
	MOV EDI, 0	
	CMP EDX,0
	JE continuar_alfa
	MOV ECX, EDX
	L3:
		ADD EDI, 4
		LOOP L3	
	
continuar_alfa:		
	ADD arrayEstados[EDI],1
	
	RET
alfa ENDP

alfa2 PROC
	mov EAX, LENGTH arrayMunicipios
	CALL RandomRange
	MOV EDX, EAX
	
	MOV EDI, 0	
	CMP EDX,0
	JE continuar_alfa2
	MOV ECX, EDX
	L4:
		ADD EDI, 4
		LOOP L4	
	
continuar_alfa2:		
	ADD arrayMunicipios[EDI],1
	
	RET
alfa2 ENDP

ImprimirArreglo PROC

cld
mov esi,0
mov ecx,LENGTHOF arrayEstados

L1:
	mov eax, arrayEstados[esi]
	call writedec
	add esi,4
	mov al, TAB
	call writechar
	loop L1
	call crlf
	ret

ImprimirArreglo ENDP

ImprimirArreglo2 PROC

cld
mov esi,0
mov ecx,LENGTHOF arrayMunicipios

L55:
	mov eax, arrayMunicipios[esi]
	call writedec
	add esi,4
	mov al, TAB
	call writechar
	loop L55
	call crlf
	ret

ImprimirArreglo2 ENDP

generarVotos PROC
	MOV AX, 0
	MOV ECX, cantVotantes
	L9:
		PUSH ECX
		CALL alfa
		POP ECX
		
		CALL generarAleatorio
		 		
		.IF (numeroAleatorio < 3 && numeroAleatorio >= 0)
			INC votoSi
		.ELSEIF (numeroAleatorio >= 3 && numeroAleatorio <= 5)
			INC votoNo
		.ELSE
			INC votoNulo
		.ENDIF
		LOOP L9
		
	;CALL C
	
	RET
generarVotos ENDP

generarAleatorio PROC
	MOV EAX, 24
	CALL RandomRange
	
	MOV numeroAleatorio, EAX
	RET	
generarAleatorio ENDP

verArreglo PROC
	MOV ESI, 0
	MOV ECX, LENGTH arrayEstados
	L2:
		MOV EAX, arrayEstados[ESI]
		CALL WriteDec
		
		ADD ESI, 4
		LOOP L2
	CALL Crlf
	RET
verArreglo ENDP

END main
