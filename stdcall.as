#module
#deffunc initsyscallinfo
dupptr syscalldatasmgocainexchin,0x50000000,800,2
dupptr syscalldatasmgocainexchin2,lpeek(syscalldatasmgocainexchin,0),800,2
return
#defcfunc syscall int prm_0,int prm_1,var prm_2
lpoke syscalldatasmgocainexchin,4*2,lpeek(prm_2,0)
lpoke syscalldatasmgocainexchin2,0,prm_0
lpoke syscalldatasmgocainexchin2,5,prm_1
if lpeek(syscalldatasmgocainexchin2,5+4*24)=0{
poke syscalldatasmgocainexchin2,4,1
repeat:if peek(syscalldatasmgocainexchin2,4)=0{break}:loop
if prm_0=0{end}
}else{
ldim bdose,1
lpoke bdose,0,lpeek(syscalldatasmgocainexchin2,5+4*24)
gosub bdose
}
lpoke prm_2,0,lpeek(syscalldatasmgocainexchin,4*2)
return lpeek(syscalldatasmgocainexchin,4*1)
#defcfunc get16bitcompatiblememaddr
return lpeek(syscalldatasmgocainexchin,5+4*22)
#defcfunc get32bitfcbaddr
return lpeek(syscalldatasmgocainexchin,5+4*21)
#defcfunc get32bitcmdlineaddr
return lpeek(syscalldatasmgocainexchin,5+4*24)
#global
initsyscallinfo
