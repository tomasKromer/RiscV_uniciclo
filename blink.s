	and x4,x4,x0
	and x6,x6,x0	
	ld x4,0(x0)
	ld x5,0(x4)
led:	add x6,x6,x4 
	and x2,x2,x0  
sumar:	add x2,x2,x4
	beq x2,x5,led
	beq x2,x2,sumar
	
