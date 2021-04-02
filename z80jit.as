;Gocaine Z80 JIT Codename:Space-Lightning
;This software is unlicenced.
;So,You can use this software freely!
#ifdef z80moduledefined
#ifndef z80jitmoduledefined
#define global z80jitmoduledefined
#module
#deffunc z80jit_init
z80jitinterval=65536
ldim z80jitintervaljob,1
sdim jitcache,8192*1024
dim memorystocker,65536
dim opcodelistaddr,12
dim opcodelistaddrget,256
for cntx,0,256,1:opcodelistaddrget(cntx)=0:next
opcodelistaddrget(0xCB)=1
opcodelistaddrget(0xDD)=2
opcodelistaddrget(0xED)=4
opcodelistaddrget(0xFD)=5
ldim z80jitcreamaddr,24
dim jitforjumpaddrx,65536
z80jitcreamaddr(0)=*z80jitcream1,*z80jitcream2,*z80jitcream3,*z80jitjumpctrl,*z80jitcream4
z80jitcreamaddrptr=*getz80jitcreamaddrptr
dupptr z80jitcreamaddrgetteraddrdata,lpeek(z80jitcreamaddrptr,0),256,2
if wpeek(z80jitcreamaddrgetteraddrdata,0)&0x8000{z80jitcreamaddrptr=lpeek(z80jitcreamaddrgetteraddrdata,2)}else{z80jitcreamaddrptr=wpeek(z80jitcreamaddrgetteraddrdata,2)}
z80jitopcodeaddr0ptr=*getjitopcodeaddr0
dupptr z80jitopcodeaddrgetteraddrdata,lpeek(z80jitopcodeaddr0ptr,0),256,2
if wpeek(z80jitopcodeaddrgetteraddrdata,0)&0x8000{z80jitopcodeaddr0ptr=lpeek(z80jitopcodeaddrgetteraddrdata,2)}else{z80jitopcodeaddr0ptr=wpeek(z80jitopcodeaddrgetteraddrdata,2)}
opcodelistaddr(0)=z80jitopcodeaddr0ptr
z80jitopcodeaddr0ptr=*getjitopcodeaddr1
dupptr z80jitopcodeaddrgetteraddrdata,lpeek(z80jitopcodeaddr0ptr,0),256,2
if wpeek(z80jitopcodeaddrgetteraddrdata,0)&0x8000{z80jitopcodeaddr0ptr=lpeek(z80jitopcodeaddrgetteraddrdata,2)}else{z80jitopcodeaddr0ptr=wpeek(z80jitopcodeaddrgetteraddrdata,2)}
opcodelistaddr(1)=z80jitopcodeaddr0ptr
z80jitopcodeaddr0ptr=*getjitopcodeaddr2
dupptr z80jitopcodeaddrgetteraddrdata,lpeek(z80jitopcodeaddr0ptr,0),256,2
if wpeek(z80jitopcodeaddrgetteraddrdata,0)&0x8000{z80jitopcodeaddr0ptr=lpeek(z80jitopcodeaddrgetteraddrdata,2)}else{z80jitopcodeaddr0ptr=wpeek(z80jitopcodeaddrgetteraddrdata,2)}
opcodelistaddr(2)=z80jitopcodeaddr0ptr
z80jitopcodeaddr0ptr=*getjitopcodeaddr3
dupptr z80jitopcodeaddrgetteraddrdata,lpeek(z80jitopcodeaddr0ptr,0),256,2
if wpeek(z80jitopcodeaddrgetteraddrdata,0)&0x8000{z80jitopcodeaddr0ptr=lpeek(z80jitopcodeaddrgetteraddrdata,2)}else{z80jitopcodeaddr0ptr=wpeek(z80jitopcodeaddrgetteraddrdata,2)}
opcodelistaddr(3)=z80jitopcodeaddr0ptr
z80jitopcodeaddr0ptr=*getjitopcodeaddr4
dupptr z80jitopcodeaddrgetteraddrdata,lpeek(z80jitopcodeaddr0ptr,0),256,2
if wpeek(z80jitopcodeaddrgetteraddrdata,0)&0x8000{z80jitopcodeaddr0ptr=lpeek(z80jitopcodeaddrgetteraddrdata,2)}else{z80jitopcodeaddr0ptr=wpeek(z80jitopcodeaddrgetteraddrdata,2)}
opcodelistaddr(4)=z80jitopcodeaddr0ptr
z80jitopcodeaddr0ptr=*getjitopcodeaddr5
dupptr z80jitopcodeaddrgetteraddrdata,lpeek(z80jitopcodeaddr0ptr,0),256,2
if wpeek(z80jitopcodeaddrgetteraddrdata,0)&0x8000{z80jitopcodeaddr0ptr=lpeek(z80jitopcodeaddrgetteraddrdata,2)}else{z80jitopcodeaddr0ptr=wpeek(z80jitopcodeaddrgetteraddrdata,2)}
opcodelistaddr(5)=z80jitopcodeaddr0ptr
z80jitopcodeaddr0ptr=*getjitopcodeaddr6
dupptr z80jitopcodeaddrgetteraddrdata,lpeek(z80jitopcodeaddr0ptr,0),256,2
if wpeek(z80jitopcodeaddrgetteraddrdata,0)&0x8000{z80jitopcodeaddr0ptr=lpeek(z80jitopcodeaddrgetteraddrdata,2)}else{z80jitopcodeaddr0ptr=wpeek(z80jitopcodeaddrgetteraddrdata,2)}
opcodelistaddr(6)=z80jitopcodeaddr0ptr
sdim jitstack,64,2
ldim jitforjumpaddr,65536
z80freezeblocker=0
return
#deffunc z80jitintervalset int prm_0
z80jitinterval=prm_0
return
#deffunc z80jitintervaljobset label prm_0,int prm_1
z80jitintervaljob=prm_0
z80jitintervaljobgotoflag=prm_1
return
#defcfunc z80jitfreezeblockerget
return z80freezeblocker
#deffunc z80jitrun var startaddr
gosub *compiler
z80freezeblocker=0

memcpy stack@z80moduleaccess(0),jitstack(0),64,0,0
memcpy stack@z80moduleaccess(1),jitstack(1),64,0,0
wpoke stack@z80moduleaccess(0),10,startaddr
ldim jitrundbtedaddress,1
lpoke jitrundbtedaddress,0,varptr(jitcache)
gosub jitforjumpaddr(startaddr)
lpoke startaddr,0,wpeek(stack@z80moduleaccess(0),10)
memcpy jitstack(0),stack@z80moduleaccess(0),64,0,0
memcpy jitstack(1),stack@z80moduleaccess(1),64,0,0
return
*z80jitcream1
if (memorystocker(wpeek(stack@z80moduleaccess(0),10)&0xFFFF)&0xFF)!z80readmem(wpeek(stack@z80moduleaccess(0),10)){jitcntaddr=jitforjumpaddrx(wpeek(stack@z80moduleaccess(0),10)):compiledaddrz80=wpeek(stack@z80moduleaccess(0),10):gosub *compilegen}
//if opcodelistaddrget(wpeek(stack@z80moduleaccess(0),10))!0{wpoke stack@z80moduleaccess(0),10,wpeek(stack@z80moduleaccess(0),10)+1}
wpoke stack@z80moduleaccess(0),10,wpeek(stack@z80moduleaccess(0),10)+1
return
*z80jitcream2
#ifdef __useslowz80jitemulation_flag__
poke stack@z80moduleaccess(0),14,peek(stack@z80moduleaccess(0),14)+1
#else
poke stack@z80moduleaccess(0),14,peek(stack@z80moduleaccess(0),14)+1+(opcodelistaddrget(z80opcodexedchk)!0)
#endif
return
*z80jitcream3
return
*z80jitcream4
if memorystocker(wpeek(stack@z80moduleaccess(0),10)&0xFFFF)!z80readmem16(wpeek(stack@z80moduleaccess(0),10)){jitcntaddr=jitforjumpaddrx(wpeek(stack@z80moduleaccess(0),10)):compiledaddrz80=wpeek(stack@z80moduleaccess(0),10):gosub *compilegen}
opcodeforsubcall@z80moduleaccess=z80readmem(wpeek(stack@z80moduleaccess(0),10)+1):wpoke stack@z80moduleaccess(0),10,wpeek(stack@z80moduleaccess(0),10)+2
return
*getjitopcodeaddr0
opcodeaddr@z80moduleaccess=opcodeaddropa
return
*getjitopcodeaddr1
opcodeaddr_cb@z80moduleaccess=opcodeaddropa
return
*getjitopcodeaddr2
opcodeaddr_dd@z80moduleaccess=opcodeaddropa
return
*getjitopcodeaddr3
opcodeaddr_dd_cb@z80moduleaccess=opcodeaddropa
return
*getjitopcodeaddr4
opcodeaddr_ed@z80moduleaccess=opcodeaddropa
return
*getjitopcodeaddr5
opcodeaddr_fd@z80moduleaccess=opcodeaddropa
return
*getjitopcodeaddr6
opcodeaddr_fd_cb@z80moduleaccess=opcodeaddropa
return
*getz80jitcreamaddrptr
z80jitcreamaddr=opcodeaddropa
return
*z80jitjumpctrl
if z80freezeblocker=z80jitinterval{if ((z80jitintervaljobgotoflag>>1)&0x01)=0{await}:z80freezeblocker=0:lpoke startaddr,0,wpeek(stack@z80moduleaccess(0),10):memcpy jitstack(0),stack@z80moduleaccess(0),64,0,0:memcpy jitstack(1),stack@z80moduleaccess(1),64,0,0:if lpeek(z80jitintervaljob,0)!0{if (z80jitintervaljobgotoflag&0x01)=0{gosub z80jitintervaljob}else{goto z80jitintervaljob}}:memcpy stack@z80moduleaccess(0),jitstack(0),64,0,0:memcpy stack@z80moduleaccess(1),jitstack(1),64,0,0:wpoke stack@z80moduleaccess(0),10,startaddr}else{z80freezeblocker+=1}
if lpeek(jitforjumpaddr(wpeek(stack@z80moduleaccess(0),10)),0)!0{goto jitforjumpaddr(wpeek(stack@z80moduleaccess(0),10))}
return
*compiler
jitcntaddr=0:compiledaddrz80=0
for cntx,0,65536,1
compiledaddrz80=cntx:gosub *compilegen
next
wpoke jitcache,jitcntaddr,0x200F|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,0:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0001|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,z80jitcreamaddrptr:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0028:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0004:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0002:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0029:jitcntaddr+=2

wpoke jitcache,jitcntaddr,0x200F:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0002:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x200F:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0011:jitcntaddr+=2
/*wpoke jitcache,jitcntaddr,0x200F:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2*/
return

*compilegen
z80opcodexedchk=z80readmem(compiledaddrz80)
opcodeforsubcall=z80readmem(compiledaddrz80+1)
lpoke jitforjumpaddr(compiledaddrz80),0,varptr(jitcache)+jitcntaddr
lpoke jitforjumpaddrx(compiledaddrz80),0,jitcntaddr
wpoke jitcache,jitcntaddr,0x200F|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,1:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0001|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,z80jitcreamaddrptr:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0028:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0004:jitcntaddr+=2
#ifdef __useslowz80jitemulation_flag__
wpoke jitcache,jitcntaddr,0:jitcntaddr+=2
#else
wpoke jitcache,jitcntaddr,((opcodelistaddrget(z80opcodexedchk)>0)*4):jitcntaddr+=2
#endif
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0029:jitcntaddr+=2

/*switch z80opcodexedchk
case 0xcb
compiledaddrz80+=1
swbreak
case 0xdd
compiledaddrz80+=1
if z80readmem(compiledaddrz80+1)=0xCB{compiledaddrz80+=2}
swbreak
case 0xed
compiledaddrz80+=1
swbreak
case 0xfd
compiledaddrz80+=1
if z80readmem(compiledaddrz80+1)=0xCB{compiledaddrz80+=2}
swbreak
swend*/

wpoke jitcache,jitcntaddr,0x200F|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,1:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0001|0x8000:jitcntaddr+=2
//lpoke jitcache,jitcntaddr,opcodelistaddr(opcodelistaddrget(z80opcodexedchk)):jitcntaddr+=4
#ifdef __useslowz80jitemulation_flag__
lpoke jitcache,jitcntaddr,opcodelistaddr(0):jitcntaddr+=4
#else
lpoke jitcache,jitcntaddr,opcodelistaddr(opcodelistaddrget(z80opcodexedchk)):jitcntaddr+=4
#endif
//lpoke jitcache,jitcntaddr,opcodelistaddr(0):jitcntaddr+=4
//if opcodelistaddrget(z80opcodexedchk)!0{z80opcodexedchk=z80readmem(compiledaddrz80+1)}
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0028:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0004:jitcntaddr+=2
#ifdef __useslowz80jitemulation_flag__
wpoke jitcache,jitcntaddr,z80opcodexedchk:jitcntaddr+=2
#else
if opcodelistaddrget(z80opcodexedchk)!0{wpoke jitcache,jitcntaddr,opcodeforsubcall}else{wpoke jitcache,jitcntaddr,z80opcodexedchk}:jitcntaddr+=2
#endif
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0029:jitcntaddr+=2

wpoke jitcache,jitcntaddr,0x200F|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,1:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0001|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,z80jitcreamaddrptr:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0028:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0004:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0001:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0029:jitcntaddr+=2

wpoke jitcache,jitcntaddr,0x200F|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,0:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0001|0x8000:jitcntaddr+=2
lpoke jitcache,jitcntaddr,z80jitcreamaddrptr:jitcntaddr+=4
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0028:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0004:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0003:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0000:jitcntaddr+=2
wpoke jitcache,jitcntaddr,0x0029:jitcntaddr+=2

lpoke memorystocker(compiledaddrz80&0xFFFF),0,z80opcodexedchk|(z80readmem(compiledaddrz80+1)<<(8*1))

compiledaddrz80+=1//:if opcodex@z80moduleaccess(z80opcodexedchk)=0{compiledaddrz80+=1}else{compiledaddrz80+=opcodex@z80moduleaccess(z80opcodexedchk)}
return

#deffunc z80jitinterrupt var startaddr,int iomemoryidforz80, int threadidforrunthez80
if z80haltmodesw@z80moduleaccess(threadidforrunthez80)=1{z80haltmodesw(threadidforrunthez80)=0:startaddr=startaddr+1}
if (peek(jitstack(1),14) & 0x01){
if z80runmode@z80moduleaccess(threadidforrunthez80)=0{
memcpy stack@z80moduleaccess(0),jitstack(0),64,0,0
memcpy stack@z80moduleaccess(1),jitstack(1),64,0,0
wpoke stack@z80moduleaccess(0),10,startaddr
//opcode=z80readmem(wpeek(stack(0),10))
//lpoke jumplabel,0,opcodeaddr(opcode)
#ifdef __useslowz80emulation_flag__
opcode=(iomemoryidforz80 & 0xff)
gosub *z80opcodeinterpretsw@z80moduleaccess
#else
gosub opcodeaddr@z80moduleaccess(iomemoryidforz80 & 0xff)//opcodeaddr(opcode)//jumplabel
#endif
lpoke startaddr,0,wpeek(stack@z80moduleaccess(0),10)
memcpy jitstack(0),stack@z80moduleaccess(0),64,0,0
memcpy jitstack(1),stack@z80moduleaccess(1),64,0,0
}
if z80runmode@z80moduleaccess(threadidforrunthez80)=1{
z80writemem wpeek(jitstack(0),12)-2,peek(jitstack(0),10)
z80writemem wpeek(jitstack(0),12)-1,peek(jitstack(0),11)
wpoke jitstack(0),12,wpeek(jitstack(0),12)-2
wpoke jitstack(0),10,0x38
startaddr=0x38
}
if z80runmode@z80moduleaccess(threadidforrunthez80)=2{
z80writemem wpeek(jitstack(0),12)-2,peek(jitstack(0),10)
z80writemem wpeek(jitstack(0),12)-1,peek(jitstack(0),11)
wpoke jitstack(0),12,wpeek(jitstack(0),12)-2
startaddr=z80readmem16((peek(jitstack(0),15)<<8)+(iomemoryidforz80 & 0xff))
}
poke jitstack(1),14,0
poke jitstack(1),15,0
}
return


#deffunc z80jitnminterrupt var startaddr, int threadidforrunthez80
if z80haltmodesw(threadidforrunthez80)=1{z80haltmodesw(threadidforrunthez80)=0:startaddr=startaddr+1}
z80writemem wpeek(jitstack(0),12)-2,peek(jitstack(0),10)
z80writemem wpeek(jitstack(0),12)-1,peek(jitstack(0),11)
wpoke jitstack(0),12,wpeek(jitstack(0),12)-2
wpoke jitstack(0),10,0x66
poke jitstack(1),14,0
startaddr=0x66
return

#global
#endif
z80jit_init
#endif