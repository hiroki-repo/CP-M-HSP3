#module
#deffunc fullmemoryaccessmoduleinit
dupptr fullaccessablemem1,0,0x7FFFFFFF,2
dupptr fullaccessablemem2,0x80000000,0x7FFFFFFF,2
memmovefor16bit=0
return
#deffunc mempoke int prm_1,int prm_2
prm_1x=0
prm_1x=prm_1
prm_2x=0
prm_2x=prm_2
if prm_1x<=0xFFFF{
prm_1x=memmovefor16bit+prm_1x
}
if prm_1x<=0x80000000{
poke fullaccessablemem2,prm_1x-0x80000000,prm_2x
}else{
poke fullaccessablemem1,prm_1x,prm_2x
}
return
#deffunc memwpoke int prm_1,int prm_2
prm_1x=0
prm_1x=prm_1
prm_2x=0
prm_2x=prm_2
if prm_1x<=0xFFFF{
prm_1x=memmovefor16bit+prm_1x
}
if prm_1x<=0x80000000{
wpoke fullaccessablemem2,prm_1x-0x80000000,prm_2x
}else{
wpoke fullaccessablemem1,prm_1x,prm_2x
}
return
#deffunc memlpoke int prm_1,int prm_2
prm_1x=0
prm_1x=prm_1
prm_2x=0
prm_2x=prm_2
if prm_1x<=0xFFFF{
prm_1x=memmovefor16bit+prm_1x
}
if prm_1x<=0x80000000{
lpoke fullaccessablemem2,prm_1x-0x80000000,prm_2x
}else{
lpoke fullaccessablemem1,prm_1x,prm_2x
}
return

#defcfunc mempeek int prm_1
prm_1x=0
prm_1x=prm_1
if prm_1x<=0xFFFF{
prm_1x=memmovefor16bit+prm_1x
}
if prm_1x<=0x80000000{
return peek(fullaccessablemem2,prm_1x-0x80000000)
}else{
return peek(fullaccessablemem1,prm_1x)
}
return
#defcfunc memwpeek int prm_1
prm_1x=0
prm_1x=prm_1
if prm_1x<=0xFFFF{
prm_1x=memmovefor16bit+prm_1x
}
if prm_1x<=0x80000000{
return wpeek(fullaccessablemem2,prm_1x-0x80000000)
}else{
return wpeek(fullaccessablemem1,prm_1x)
}
return
#defcfunc memlpeek int prm_1
prm_1x=0
prm_1x=prm_1
if prm_1x<=0xFFFF{
prm_1x=memmovefor16bit+prm_1x
}
if prm_1x<=0x80000000{
return lpeek(fullaccessablemem2,prm_1x-0x80000000)
}else{
return lpeek(fullaccessablemem1,prm_1x)
}
return

#deffunc memmemcpy int prm_1,int prm_2,int prm_3
prm_1xa=0
prm_1xa=prm_1
prm_2xa=0
prm_2xa=prm_2
prm_3xa=0
prm_3xa=prm_3
repeat prm_3xa
mempoke prm_1xa+cnt,mempeek(prm_2xa+cnt)
loop
return
#deffunc mem16bitshiftaddr int var_1
memmovefor16bit=var_1
return
#global
fullmemoryaccessmoduleinit
