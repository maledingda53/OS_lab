
obj/__user_ls.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <opendir>:
  800020:	7139                	addi	sp,sp,-64
  800022:	f822                	sd	s0,48(sp)
  800024:	00001417          	auipc	s0,0x1
  800028:	fdc40413          	addi	s0,s0,-36 # 801000 <dirp>
  80002c:	f426                	sd	s1,40(sp)
  80002e:	6004                	ld	s1,0(s0)
  800030:	4581                	li	a1,0
  800032:	fc06                	sd	ra,56(sp)
  800034:	068000ef          	jal	ra,80009c <open>
  800038:	c088                	sw	a0,0(s1)
  80003a:	02054663          	bltz	a0,800066 <opendir+0x46>
  80003e:	601c                	ld	a5,0(s0)
  800040:	858a                	mv	a1,sp
  800042:	4388                	lw	a0,0(a5)
  800044:	068000ef          	jal	ra,8000ac <fstat>
  800048:	ed19                	bnez	a0,800066 <opendir+0x46>
  80004a:	4782                	lw	a5,0(sp)
  80004c:	669d                	lui	a3,0x7
  80004e:	6709                	lui	a4,0x2
  800050:	8ff5                	and	a5,a5,a3
  800052:	00e79a63          	bne	a5,a4,800066 <opendir+0x46>
  800056:	6008                	ld	a0,0(s0)
  800058:	70e2                	ld	ra,56(sp)
  80005a:	7442                	ld	s0,48(sp)
  80005c:	00053423          	sd	zero,8(a0)
  800060:	74a2                	ld	s1,40(sp)
  800062:	6121                	addi	sp,sp,64
  800064:	8082                	ret
  800066:	70e2                	ld	ra,56(sp)
  800068:	7442                	ld	s0,48(sp)
  80006a:	74a2                	ld	s1,40(sp)
  80006c:	4501                	li	a0,0
  80006e:	6121                	addi	sp,sp,64
  800070:	8082                	ret

0000000000800072 <readdir>:
  800072:	1141                	addi	sp,sp,-16
  800074:	e022                	sd	s0,0(sp)
  800076:	842a                	mv	s0,a0
  800078:	4108                	lw	a0,0(a0)
  80007a:	0421                	addi	s0,s0,8
  80007c:	85a2                	mv	a1,s0
  80007e:	e406                	sd	ra,8(sp)
  800080:	1ca000ef          	jal	ra,80024a <sys_getdirentry>
  800084:	00153513          	seqz	a0,a0
  800088:	40a00533          	neg	a0,a0
  80008c:	8d61                	and	a0,a0,s0
  80008e:	60a2                	ld	ra,8(sp)
  800090:	6402                	ld	s0,0(sp)
  800092:	0141                	addi	sp,sp,16
  800094:	8082                	ret

0000000000800096 <closedir>:
  800096:	4108                	lw	a0,0(a0)
  800098:	00c0006f          	j	8000a4 <close>

000000000080009c <open>:
  80009c:	1582                	slli	a1,a1,0x20
  80009e:	9181                	srli	a1,a1,0x20
  8000a0:	17a0006f          	j	80021a <sys_open>

00000000008000a4 <close>:
  8000a4:	1820006f          	j	800226 <sys_close>

00000000008000a8 <write>:
  8000a8:	1880006f          	j	800230 <sys_write>

00000000008000ac <fstat>:
  8000ac:	1920006f          	j	80023e <sys_fstat>

00000000008000b0 <dup2>:
  8000b0:	1a60006f          	j	800256 <sys_dup>

00000000008000b4 <_start>:
  8000b4:	208000ef          	jal	ra,8002bc <umain>
  8000b8:	a001                	j	8000b8 <_start+0x4>

00000000008000ba <__warn>:
  8000ba:	715d                	addi	sp,sp,-80
  8000bc:	e822                	sd	s0,16(sp)
  8000be:	fc3e                	sd	a5,56(sp)
  8000c0:	8432                	mv	s0,a2
  8000c2:	103c                	addi	a5,sp,40
  8000c4:	862e                	mv	a2,a1
  8000c6:	85aa                	mv	a1,a0
  8000c8:	00001517          	auipc	a0,0x1
  8000cc:	94850513          	addi	a0,a0,-1720 # 800a10 <main+0x76>
  8000d0:	ec06                	sd	ra,24(sp)
  8000d2:	f436                	sd	a3,40(sp)
  8000d4:	f83a                	sd	a4,48(sp)
  8000d6:	e0c2                	sd	a6,64(sp)
  8000d8:	e4c6                	sd	a7,72(sp)
  8000da:	e43e                	sd	a5,8(sp)
  8000dc:	088000ef          	jal	ra,800164 <cprintf>
  8000e0:	65a2                	ld	a1,8(sp)
  8000e2:	8522                	mv	a0,s0
  8000e4:	05a000ef          	jal	ra,80013e <vcprintf>
  8000e8:	00001517          	auipc	a0,0x1
  8000ec:	98050513          	addi	a0,a0,-1664 # 800a68 <main+0xce>
  8000f0:	074000ef          	jal	ra,800164 <cprintf>
  8000f4:	60e2                	ld	ra,24(sp)
  8000f6:	6442                	ld	s0,16(sp)
  8000f8:	6161                	addi	sp,sp,80
  8000fa:	8082                	ret

00000000008000fc <cputch>:
  8000fc:	1141                	addi	sp,sp,-16
  8000fe:	e022                	sd	s0,0(sp)
  800100:	e406                	sd	ra,8(sp)
  800102:	842e                	mv	s0,a1
  800104:	10e000ef          	jal	ra,800212 <sys_putc>
  800108:	401c                	lw	a5,0(s0)
  80010a:	60a2                	ld	ra,8(sp)
  80010c:	2785                	addiw	a5,a5,1
  80010e:	c01c                	sw	a5,0(s0)
  800110:	6402                	ld	s0,0(sp)
  800112:	0141                	addi	sp,sp,16
  800114:	8082                	ret

0000000000800116 <fputch>:
  800116:	1101                	addi	sp,sp,-32
  800118:	87b2                	mv	a5,a2
  80011a:	e822                	sd	s0,16(sp)
  80011c:	00a107a3          	sb	a0,15(sp)
  800120:	842e                	mv	s0,a1
  800122:	853e                	mv	a0,a5
  800124:	00f10593          	addi	a1,sp,15
  800128:	4605                	li	a2,1
  80012a:	ec06                	sd	ra,24(sp)
  80012c:	f7dff0ef          	jal	ra,8000a8 <write>
  800130:	401c                	lw	a5,0(s0)
  800132:	60e2                	ld	ra,24(sp)
  800134:	2785                	addiw	a5,a5,1
  800136:	c01c                	sw	a5,0(s0)
  800138:	6442                	ld	s0,16(sp)
  80013a:	6105                	addi	sp,sp,32
  80013c:	8082                	ret

000000000080013e <vcprintf>:
  80013e:	1101                	addi	sp,sp,-32
  800140:	872e                	mv	a4,a1
  800142:	75dd                	lui	a1,0xffff7
  800144:	86aa                	mv	a3,a0
  800146:	0070                	addi	a2,sp,12
  800148:	00000517          	auipc	a0,0x0
  80014c:	fb450513          	addi	a0,a0,-76 # 8000fc <cputch>
  800150:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <dir+0xffffffffff7f5ad1>
  800154:	ec06                	sd	ra,24(sp)
  800156:	c602                	sw	zero,12(sp)
  800158:	24e000ef          	jal	ra,8003a6 <vprintfmt>
  80015c:	60e2                	ld	ra,24(sp)
  80015e:	4532                	lw	a0,12(sp)
  800160:	6105                	addi	sp,sp,32
  800162:	8082                	ret

0000000000800164 <cprintf>:
  800164:	711d                	addi	sp,sp,-96
  800166:	02810313          	addi	t1,sp,40
  80016a:	f42e                	sd	a1,40(sp)
  80016c:	75dd                	lui	a1,0xffff7
  80016e:	f832                	sd	a2,48(sp)
  800170:	fc36                	sd	a3,56(sp)
  800172:	e0ba                	sd	a4,64(sp)
  800174:	86aa                	mv	a3,a0
  800176:	0050                	addi	a2,sp,4
  800178:	00000517          	auipc	a0,0x0
  80017c:	f8450513          	addi	a0,a0,-124 # 8000fc <cputch>
  800180:	871a                	mv	a4,t1
  800182:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <dir+0xffffffffff7f5ad1>
  800186:	ec06                	sd	ra,24(sp)
  800188:	e4be                	sd	a5,72(sp)
  80018a:	e8c2                	sd	a6,80(sp)
  80018c:	ecc6                	sd	a7,88(sp)
  80018e:	e41a                	sd	t1,8(sp)
  800190:	c202                	sw	zero,4(sp)
  800192:	214000ef          	jal	ra,8003a6 <vprintfmt>
  800196:	60e2                	ld	ra,24(sp)
  800198:	4512                	lw	a0,4(sp)
  80019a:	6125                	addi	sp,sp,96
  80019c:	8082                	ret

000000000080019e <fprintf>:
  80019e:	715d                	addi	sp,sp,-80
  8001a0:	02010313          	addi	t1,sp,32
  8001a4:	f032                	sd	a2,32(sp)
  8001a6:	f436                	sd	a3,40(sp)
  8001a8:	f83a                	sd	a4,48(sp)
  8001aa:	86ae                	mv	a3,a1
  8001ac:	0050                	addi	a2,sp,4
  8001ae:	85aa                	mv	a1,a0
  8001b0:	871a                	mv	a4,t1
  8001b2:	00000517          	auipc	a0,0x0
  8001b6:	f6450513          	addi	a0,a0,-156 # 800116 <fputch>
  8001ba:	ec06                	sd	ra,24(sp)
  8001bc:	fc3e                	sd	a5,56(sp)
  8001be:	e0c2                	sd	a6,64(sp)
  8001c0:	e4c6                	sd	a7,72(sp)
  8001c2:	e41a                	sd	t1,8(sp)
  8001c4:	c202                	sw	zero,4(sp)
  8001c6:	1e0000ef          	jal	ra,8003a6 <vprintfmt>
  8001ca:	60e2                	ld	ra,24(sp)
  8001cc:	4512                	lw	a0,4(sp)
  8001ce:	6161                	addi	sp,sp,80
  8001d0:	8082                	ret

00000000008001d2 <syscall>:
  8001d2:	7175                	addi	sp,sp,-144
  8001d4:	f8ba                	sd	a4,112(sp)
  8001d6:	e0ba                	sd	a4,64(sp)
  8001d8:	0118                	addi	a4,sp,128
  8001da:	e42a                	sd	a0,8(sp)
  8001dc:	ecae                	sd	a1,88(sp)
  8001de:	f0b2                	sd	a2,96(sp)
  8001e0:	f4b6                	sd	a3,104(sp)
  8001e2:	fcbe                	sd	a5,120(sp)
  8001e4:	e142                	sd	a6,128(sp)
  8001e6:	e546                	sd	a7,136(sp)
  8001e8:	f42e                	sd	a1,40(sp)
  8001ea:	f832                	sd	a2,48(sp)
  8001ec:	fc36                	sd	a3,56(sp)
  8001ee:	f03a                	sd	a4,32(sp)
  8001f0:	e4be                	sd	a5,72(sp)
  8001f2:	4522                	lw	a0,8(sp)
  8001f4:	55a2                	lw	a1,40(sp)
  8001f6:	5642                	lw	a2,48(sp)
  8001f8:	56e2                	lw	a3,56(sp)
  8001fa:	4706                	lw	a4,64(sp)
  8001fc:	47a6                	lw	a5,72(sp)
  8001fe:	00000073          	ecall
  800202:	ce2a                	sw	a0,28(sp)
  800204:	4572                	lw	a0,28(sp)
  800206:	6149                	addi	sp,sp,144
  800208:	8082                	ret

000000000080020a <sys_exit>:
  80020a:	85aa                	mv	a1,a0
  80020c:	4505                	li	a0,1
  80020e:	fc5ff06f          	j	8001d2 <syscall>

0000000000800212 <sys_putc>:
  800212:	85aa                	mv	a1,a0
  800214:	4579                	li	a0,30
  800216:	fbdff06f          	j	8001d2 <syscall>

000000000080021a <sys_open>:
  80021a:	862e                	mv	a2,a1
  80021c:	85aa                	mv	a1,a0
  80021e:	06400513          	li	a0,100
  800222:	fb1ff06f          	j	8001d2 <syscall>

0000000000800226 <sys_close>:
  800226:	85aa                	mv	a1,a0
  800228:	06500513          	li	a0,101
  80022c:	fa7ff06f          	j	8001d2 <syscall>

0000000000800230 <sys_write>:
  800230:	86b2                	mv	a3,a2
  800232:	862e                	mv	a2,a1
  800234:	85aa                	mv	a1,a0
  800236:	06700513          	li	a0,103
  80023a:	f99ff06f          	j	8001d2 <syscall>

000000000080023e <sys_fstat>:
  80023e:	862e                	mv	a2,a1
  800240:	85aa                	mv	a1,a0
  800242:	06e00513          	li	a0,110
  800246:	f8dff06f          	j	8001d2 <syscall>

000000000080024a <sys_getdirentry>:
  80024a:	862e                	mv	a2,a1
  80024c:	85aa                	mv	a1,a0
  80024e:	08000513          	li	a0,128
  800252:	f81ff06f          	j	8001d2 <syscall>

0000000000800256 <sys_dup>:
  800256:	862e                	mv	a2,a1
  800258:	85aa                	mv	a1,a0
  80025a:	08200513          	li	a0,130
  80025e:	f75ff06f          	j	8001d2 <syscall>

0000000000800262 <exit>:
  800262:	1141                	addi	sp,sp,-16
  800264:	e406                	sd	ra,8(sp)
  800266:	fa5ff0ef          	jal	ra,80020a <sys_exit>
  80026a:	00000517          	auipc	a0,0x0
  80026e:	7c650513          	addi	a0,a0,1990 # 800a30 <main+0x96>
  800272:	ef3ff0ef          	jal	ra,800164 <cprintf>
  800276:	a001                	j	800276 <exit+0x14>

0000000000800278 <initfd>:
  800278:	1101                	addi	sp,sp,-32
  80027a:	87ae                	mv	a5,a1
  80027c:	e426                	sd	s1,8(sp)
  80027e:	85b2                	mv	a1,a2
  800280:	84aa                	mv	s1,a0
  800282:	853e                	mv	a0,a5
  800284:	e822                	sd	s0,16(sp)
  800286:	ec06                	sd	ra,24(sp)
  800288:	e15ff0ef          	jal	ra,80009c <open>
  80028c:	842a                	mv	s0,a0
  80028e:	00054463          	bltz	a0,800296 <initfd+0x1e>
  800292:	00951863          	bne	a0,s1,8002a2 <initfd+0x2a>
  800296:	8522                	mv	a0,s0
  800298:	60e2                	ld	ra,24(sp)
  80029a:	6442                	ld	s0,16(sp)
  80029c:	64a2                	ld	s1,8(sp)
  80029e:	6105                	addi	sp,sp,32
  8002a0:	8082                	ret
  8002a2:	8526                	mv	a0,s1
  8002a4:	e01ff0ef          	jal	ra,8000a4 <close>
  8002a8:	85a6                	mv	a1,s1
  8002aa:	8522                	mv	a0,s0
  8002ac:	e05ff0ef          	jal	ra,8000b0 <dup2>
  8002b0:	84aa                	mv	s1,a0
  8002b2:	8522                	mv	a0,s0
  8002b4:	df1ff0ef          	jal	ra,8000a4 <close>
  8002b8:	8426                	mv	s0,s1
  8002ba:	bff1                	j	800296 <initfd+0x1e>

00000000008002bc <umain>:
  8002bc:	1101                	addi	sp,sp,-32
  8002be:	e822                	sd	s0,16(sp)
  8002c0:	e426                	sd	s1,8(sp)
  8002c2:	842a                	mv	s0,a0
  8002c4:	84ae                	mv	s1,a1
  8002c6:	4601                	li	a2,0
  8002c8:	00000597          	auipc	a1,0x0
  8002cc:	78058593          	addi	a1,a1,1920 # 800a48 <main+0xae>
  8002d0:	4501                	li	a0,0
  8002d2:	ec06                	sd	ra,24(sp)
  8002d4:	fa5ff0ef          	jal	ra,800278 <initfd>
  8002d8:	02054263          	bltz	a0,8002fc <umain+0x40>
  8002dc:	4605                	li	a2,1
  8002de:	00000597          	auipc	a1,0x0
  8002e2:	7aa58593          	addi	a1,a1,1962 # 800a88 <main+0xee>
  8002e6:	4505                	li	a0,1
  8002e8:	f91ff0ef          	jal	ra,800278 <initfd>
  8002ec:	02054563          	bltz	a0,800316 <umain+0x5a>
  8002f0:	85a6                	mv	a1,s1
  8002f2:	8522                	mv	a0,s0
  8002f4:	6a6000ef          	jal	ra,80099a <main>
  8002f8:	f6bff0ef          	jal	ra,800262 <exit>
  8002fc:	86aa                	mv	a3,a0
  8002fe:	00000617          	auipc	a2,0x0
  800302:	75260613          	addi	a2,a2,1874 # 800a50 <main+0xb6>
  800306:	45e9                	li	a1,26
  800308:	00000517          	auipc	a0,0x0
  80030c:	76850513          	addi	a0,a0,1896 # 800a70 <main+0xd6>
  800310:	dabff0ef          	jal	ra,8000ba <__warn>
  800314:	b7e1                	j	8002dc <umain+0x20>
  800316:	86aa                	mv	a3,a0
  800318:	00000617          	auipc	a2,0x0
  80031c:	77860613          	addi	a2,a2,1912 # 800a90 <main+0xf6>
  800320:	45f5                	li	a1,29
  800322:	00000517          	auipc	a0,0x0
  800326:	74e50513          	addi	a0,a0,1870 # 800a70 <main+0xd6>
  80032a:	d91ff0ef          	jal	ra,8000ba <__warn>
  80032e:	b7c9                	j	8002f0 <umain+0x34>

0000000000800330 <printnum>:
  800330:	02071893          	slli	a7,a4,0x20
  800334:	7139                	addi	sp,sp,-64
  800336:	0208d893          	srli	a7,a7,0x20
  80033a:	e456                	sd	s5,8(sp)
  80033c:	0316fab3          	remu	s5,a3,a7
  800340:	f822                	sd	s0,48(sp)
  800342:	f426                	sd	s1,40(sp)
  800344:	f04a                	sd	s2,32(sp)
  800346:	ec4e                	sd	s3,24(sp)
  800348:	fc06                	sd	ra,56(sp)
  80034a:	e852                	sd	s4,16(sp)
  80034c:	84aa                	mv	s1,a0
  80034e:	89ae                	mv	s3,a1
  800350:	8932                	mv	s2,a2
  800352:	fff7841b          	addiw	s0,a5,-1
  800356:	2a81                	sext.w	s5,s5
  800358:	0516f163          	bleu	a7,a3,80039a <printnum+0x6a>
  80035c:	8a42                	mv	s4,a6
  80035e:	00805863          	blez	s0,80036e <printnum+0x3e>
  800362:	347d                	addiw	s0,s0,-1
  800364:	864e                	mv	a2,s3
  800366:	85ca                	mv	a1,s2
  800368:	8552                	mv	a0,s4
  80036a:	9482                	jalr	s1
  80036c:	f87d                	bnez	s0,800362 <printnum+0x32>
  80036e:	1a82                	slli	s5,s5,0x20
  800370:	020ada93          	srli	s5,s5,0x20
  800374:	00001797          	auipc	a5,0x1
  800378:	95c78793          	addi	a5,a5,-1700 # 800cd0 <error_string+0xc8>
  80037c:	9abe                	add	s5,s5,a5
  80037e:	7442                	ld	s0,48(sp)
  800380:	000ac503          	lbu	a0,0(s5)
  800384:	70e2                	ld	ra,56(sp)
  800386:	6a42                	ld	s4,16(sp)
  800388:	6aa2                	ld	s5,8(sp)
  80038a:	864e                	mv	a2,s3
  80038c:	85ca                	mv	a1,s2
  80038e:	69e2                	ld	s3,24(sp)
  800390:	7902                	ld	s2,32(sp)
  800392:	8326                	mv	t1,s1
  800394:	74a2                	ld	s1,40(sp)
  800396:	6121                	addi	sp,sp,64
  800398:	8302                	jr	t1
  80039a:	0316d6b3          	divu	a3,a3,a7
  80039e:	87a2                	mv	a5,s0
  8003a0:	f91ff0ef          	jal	ra,800330 <printnum>
  8003a4:	b7e9                	j	80036e <printnum+0x3e>

00000000008003a6 <vprintfmt>:
  8003a6:	7119                	addi	sp,sp,-128
  8003a8:	f4a6                	sd	s1,104(sp)
  8003aa:	f0ca                	sd	s2,96(sp)
  8003ac:	ecce                	sd	s3,88(sp)
  8003ae:	e4d6                	sd	s5,72(sp)
  8003b0:	e0da                	sd	s6,64(sp)
  8003b2:	fc5e                	sd	s7,56(sp)
  8003b4:	f862                	sd	s8,48(sp)
  8003b6:	ec6e                	sd	s11,24(sp)
  8003b8:	fc86                	sd	ra,120(sp)
  8003ba:	f8a2                	sd	s0,112(sp)
  8003bc:	e8d2                	sd	s4,80(sp)
  8003be:	f466                	sd	s9,40(sp)
  8003c0:	f06a                	sd	s10,32(sp)
  8003c2:	89aa                	mv	s3,a0
  8003c4:	892e                	mv	s2,a1
  8003c6:	84b2                	mv	s1,a2
  8003c8:	8db6                	mv	s11,a3
  8003ca:	8b3a                	mv	s6,a4
  8003cc:	5bfd                	li	s7,-1
  8003ce:	00000a97          	auipc	s5,0x0
  8003d2:	6dea8a93          	addi	s5,s5,1758 # 800aac <main+0x112>
  8003d6:	05e00c13          	li	s8,94
  8003da:	000dc503          	lbu	a0,0(s11)
  8003de:	02500793          	li	a5,37
  8003e2:	001d8413          	addi	s0,s11,1
  8003e6:	00f50f63          	beq	a0,a5,800404 <vprintfmt+0x5e>
  8003ea:	c529                	beqz	a0,800434 <vprintfmt+0x8e>
  8003ec:	02500a13          	li	s4,37
  8003f0:	a011                	j	8003f4 <vprintfmt+0x4e>
  8003f2:	c129                	beqz	a0,800434 <vprintfmt+0x8e>
  8003f4:	864a                	mv	a2,s2
  8003f6:	85a6                	mv	a1,s1
  8003f8:	0405                	addi	s0,s0,1
  8003fa:	9982                	jalr	s3
  8003fc:	fff44503          	lbu	a0,-1(s0)
  800400:	ff4519e3          	bne	a0,s4,8003f2 <vprintfmt+0x4c>
  800404:	00044603          	lbu	a2,0(s0)
  800408:	02000813          	li	a6,32
  80040c:	4a01                	li	s4,0
  80040e:	4881                	li	a7,0
  800410:	5d7d                	li	s10,-1
  800412:	5cfd                	li	s9,-1
  800414:	05500593          	li	a1,85
  800418:	4525                	li	a0,9
  80041a:	fdd6071b          	addiw	a4,a2,-35
  80041e:	0ff77713          	andi	a4,a4,255
  800422:	00140d93          	addi	s11,s0,1
  800426:	22e5e363          	bltu	a1,a4,80064c <vprintfmt+0x2a6>
  80042a:	070a                	slli	a4,a4,0x2
  80042c:	9756                	add	a4,a4,s5
  80042e:	4318                	lw	a4,0(a4)
  800430:	9756                	add	a4,a4,s5
  800432:	8702                	jr	a4
  800434:	70e6                	ld	ra,120(sp)
  800436:	7446                	ld	s0,112(sp)
  800438:	74a6                	ld	s1,104(sp)
  80043a:	7906                	ld	s2,96(sp)
  80043c:	69e6                	ld	s3,88(sp)
  80043e:	6a46                	ld	s4,80(sp)
  800440:	6aa6                	ld	s5,72(sp)
  800442:	6b06                	ld	s6,64(sp)
  800444:	7be2                	ld	s7,56(sp)
  800446:	7c42                	ld	s8,48(sp)
  800448:	7ca2                	ld	s9,40(sp)
  80044a:	7d02                	ld	s10,32(sp)
  80044c:	6de2                	ld	s11,24(sp)
  80044e:	6109                	addi	sp,sp,128
  800450:	8082                	ret
  800452:	4705                	li	a4,1
  800454:	008b0613          	addi	a2,s6,8
  800458:	01174463          	blt	a4,a7,800460 <vprintfmt+0xba>
  80045c:	28088563          	beqz	a7,8006e6 <vprintfmt+0x340>
  800460:	000b3683          	ld	a3,0(s6)
  800464:	4741                	li	a4,16
  800466:	8b32                	mv	s6,a2
  800468:	a86d                	j	800522 <vprintfmt+0x17c>
  80046a:	00144603          	lbu	a2,1(s0)
  80046e:	4a05                	li	s4,1
  800470:	846e                	mv	s0,s11
  800472:	b765                	j	80041a <vprintfmt+0x74>
  800474:	000b2503          	lw	a0,0(s6)
  800478:	864a                	mv	a2,s2
  80047a:	85a6                	mv	a1,s1
  80047c:	0b21                	addi	s6,s6,8
  80047e:	9982                	jalr	s3
  800480:	bfa9                	j	8003da <vprintfmt+0x34>
  800482:	4705                	li	a4,1
  800484:	008b0a13          	addi	s4,s6,8
  800488:	01174463          	blt	a4,a7,800490 <vprintfmt+0xea>
  80048c:	24088563          	beqz	a7,8006d6 <vprintfmt+0x330>
  800490:	000b3403          	ld	s0,0(s6)
  800494:	26044563          	bltz	s0,8006fe <vprintfmt+0x358>
  800498:	86a2                	mv	a3,s0
  80049a:	8b52                	mv	s6,s4
  80049c:	4729                	li	a4,10
  80049e:	a051                	j	800522 <vprintfmt+0x17c>
  8004a0:	000b2783          	lw	a5,0(s6)
  8004a4:	46e1                	li	a3,24
  8004a6:	0b21                	addi	s6,s6,8
  8004a8:	41f7d71b          	sraiw	a4,a5,0x1f
  8004ac:	8fb9                	xor	a5,a5,a4
  8004ae:	40e7873b          	subw	a4,a5,a4
  8004b2:	1ce6c163          	blt	a3,a4,800674 <vprintfmt+0x2ce>
  8004b6:	00371793          	slli	a5,a4,0x3
  8004ba:	00000697          	auipc	a3,0x0
  8004be:	74e68693          	addi	a3,a3,1870 # 800c08 <error_string>
  8004c2:	97b6                	add	a5,a5,a3
  8004c4:	639c                	ld	a5,0(a5)
  8004c6:	1a078763          	beqz	a5,800674 <vprintfmt+0x2ce>
  8004ca:	873e                	mv	a4,a5
  8004cc:	00001697          	auipc	a3,0x1
  8004d0:	a0c68693          	addi	a3,a3,-1524 # 800ed8 <error_string+0x2d0>
  8004d4:	8626                	mv	a2,s1
  8004d6:	85ca                	mv	a1,s2
  8004d8:	854e                	mv	a0,s3
  8004da:	25a000ef          	jal	ra,800734 <printfmt>
  8004de:	bdf5                	j	8003da <vprintfmt+0x34>
  8004e0:	00144603          	lbu	a2,1(s0)
  8004e4:	2885                	addiw	a7,a7,1
  8004e6:	846e                	mv	s0,s11
  8004e8:	bf0d                	j	80041a <vprintfmt+0x74>
  8004ea:	4705                	li	a4,1
  8004ec:	008b0613          	addi	a2,s6,8
  8004f0:	01174463          	blt	a4,a7,8004f8 <vprintfmt+0x152>
  8004f4:	1e088e63          	beqz	a7,8006f0 <vprintfmt+0x34a>
  8004f8:	000b3683          	ld	a3,0(s6)
  8004fc:	4721                	li	a4,8
  8004fe:	8b32                	mv	s6,a2
  800500:	a00d                	j	800522 <vprintfmt+0x17c>
  800502:	03000513          	li	a0,48
  800506:	864a                	mv	a2,s2
  800508:	85a6                	mv	a1,s1
  80050a:	e042                	sd	a6,0(sp)
  80050c:	9982                	jalr	s3
  80050e:	864a                	mv	a2,s2
  800510:	85a6                	mv	a1,s1
  800512:	07800513          	li	a0,120
  800516:	9982                	jalr	s3
  800518:	0b21                	addi	s6,s6,8
  80051a:	ff8b3683          	ld	a3,-8(s6)
  80051e:	6802                	ld	a6,0(sp)
  800520:	4741                	li	a4,16
  800522:	87e6                	mv	a5,s9
  800524:	8626                	mv	a2,s1
  800526:	85ca                	mv	a1,s2
  800528:	854e                	mv	a0,s3
  80052a:	e07ff0ef          	jal	ra,800330 <printnum>
  80052e:	b575                	j	8003da <vprintfmt+0x34>
  800530:	000b3703          	ld	a4,0(s6)
  800534:	0b21                	addi	s6,s6,8
  800536:	1e070063          	beqz	a4,800716 <vprintfmt+0x370>
  80053a:	00170413          	addi	s0,a4,1 # 2001 <opendir-0x7fe01f>
  80053e:	19905563          	blez	s9,8006c8 <vprintfmt+0x322>
  800542:	02d00613          	li	a2,45
  800546:	14c81963          	bne	a6,a2,800698 <vprintfmt+0x2f2>
  80054a:	00074703          	lbu	a4,0(a4)
  80054e:	0007051b          	sext.w	a0,a4
  800552:	c90d                	beqz	a0,800584 <vprintfmt+0x1de>
  800554:	000d4563          	bltz	s10,80055e <vprintfmt+0x1b8>
  800558:	3d7d                	addiw	s10,s10,-1
  80055a:	037d0363          	beq	s10,s7,800580 <vprintfmt+0x1da>
  80055e:	864a                	mv	a2,s2
  800560:	85a6                	mv	a1,s1
  800562:	180a0c63          	beqz	s4,8006fa <vprintfmt+0x354>
  800566:	3701                	addiw	a4,a4,-32
  800568:	18ec7963          	bleu	a4,s8,8006fa <vprintfmt+0x354>
  80056c:	03f00513          	li	a0,63
  800570:	9982                	jalr	s3
  800572:	0405                	addi	s0,s0,1
  800574:	fff44703          	lbu	a4,-1(s0)
  800578:	3cfd                	addiw	s9,s9,-1
  80057a:	0007051b          	sext.w	a0,a4
  80057e:	f979                	bnez	a0,800554 <vprintfmt+0x1ae>
  800580:	e5905de3          	blez	s9,8003da <vprintfmt+0x34>
  800584:	3cfd                	addiw	s9,s9,-1
  800586:	864a                	mv	a2,s2
  800588:	85a6                	mv	a1,s1
  80058a:	02000513          	li	a0,32
  80058e:	9982                	jalr	s3
  800590:	e40c85e3          	beqz	s9,8003da <vprintfmt+0x34>
  800594:	3cfd                	addiw	s9,s9,-1
  800596:	864a                	mv	a2,s2
  800598:	85a6                	mv	a1,s1
  80059a:	02000513          	li	a0,32
  80059e:	9982                	jalr	s3
  8005a0:	fe0c92e3          	bnez	s9,800584 <vprintfmt+0x1de>
  8005a4:	bd1d                	j	8003da <vprintfmt+0x34>
  8005a6:	4705                	li	a4,1
  8005a8:	008b0613          	addi	a2,s6,8
  8005ac:	01174463          	blt	a4,a7,8005b4 <vprintfmt+0x20e>
  8005b0:	12088663          	beqz	a7,8006dc <vprintfmt+0x336>
  8005b4:	000b3683          	ld	a3,0(s6)
  8005b8:	4729                	li	a4,10
  8005ba:	8b32                	mv	s6,a2
  8005bc:	b79d                	j	800522 <vprintfmt+0x17c>
  8005be:	00144603          	lbu	a2,1(s0)
  8005c2:	02d00813          	li	a6,45
  8005c6:	846e                	mv	s0,s11
  8005c8:	bd89                	j	80041a <vprintfmt+0x74>
  8005ca:	864a                	mv	a2,s2
  8005cc:	85a6                	mv	a1,s1
  8005ce:	02500513          	li	a0,37
  8005d2:	9982                	jalr	s3
  8005d4:	b519                	j	8003da <vprintfmt+0x34>
  8005d6:	000b2d03          	lw	s10,0(s6)
  8005da:	00144603          	lbu	a2,1(s0)
  8005de:	0b21                	addi	s6,s6,8
  8005e0:	846e                	mv	s0,s11
  8005e2:	e20cdce3          	bgez	s9,80041a <vprintfmt+0x74>
  8005e6:	8cea                	mv	s9,s10
  8005e8:	5d7d                	li	s10,-1
  8005ea:	bd05                	j	80041a <vprintfmt+0x74>
  8005ec:	00144603          	lbu	a2,1(s0)
  8005f0:	03000813          	li	a6,48
  8005f4:	846e                	mv	s0,s11
  8005f6:	b515                	j	80041a <vprintfmt+0x74>
  8005f8:	fd060d1b          	addiw	s10,a2,-48
  8005fc:	00144603          	lbu	a2,1(s0)
  800600:	846e                	mv	s0,s11
  800602:	fd06071b          	addiw	a4,a2,-48
  800606:	0006031b          	sext.w	t1,a2
  80060a:	fce56ce3          	bltu	a0,a4,8005e2 <vprintfmt+0x23c>
  80060e:	0405                	addi	s0,s0,1
  800610:	002d171b          	slliw	a4,s10,0x2
  800614:	00044603          	lbu	a2,0(s0)
  800618:	01a706bb          	addw	a3,a4,s10
  80061c:	0016969b          	slliw	a3,a3,0x1
  800620:	006686bb          	addw	a3,a3,t1
  800624:	fd06071b          	addiw	a4,a2,-48
  800628:	fd068d1b          	addiw	s10,a3,-48
  80062c:	0006031b          	sext.w	t1,a2
  800630:	fce57fe3          	bleu	a4,a0,80060e <vprintfmt+0x268>
  800634:	b77d                	j	8005e2 <vprintfmt+0x23c>
  800636:	fffcc713          	not	a4,s9
  80063a:	977d                	srai	a4,a4,0x3f
  80063c:	00ecf7b3          	and	a5,s9,a4
  800640:	00144603          	lbu	a2,1(s0)
  800644:	00078c9b          	sext.w	s9,a5
  800648:	846e                	mv	s0,s11
  80064a:	bbc1                	j	80041a <vprintfmt+0x74>
  80064c:	864a                	mv	a2,s2
  80064e:	85a6                	mv	a1,s1
  800650:	02500513          	li	a0,37
  800654:	9982                	jalr	s3
  800656:	fff44703          	lbu	a4,-1(s0)
  80065a:	02500793          	li	a5,37
  80065e:	8da2                	mv	s11,s0
  800660:	d6f70de3          	beq	a4,a5,8003da <vprintfmt+0x34>
  800664:	02500713          	li	a4,37
  800668:	1dfd                	addi	s11,s11,-1
  80066a:	fffdc783          	lbu	a5,-1(s11)
  80066e:	fee79de3          	bne	a5,a4,800668 <vprintfmt+0x2c2>
  800672:	b3a5                	j	8003da <vprintfmt+0x34>
  800674:	00001697          	auipc	a3,0x1
  800678:	85468693          	addi	a3,a3,-1964 # 800ec8 <error_string+0x2c0>
  80067c:	8626                	mv	a2,s1
  80067e:	85ca                	mv	a1,s2
  800680:	854e                	mv	a0,s3
  800682:	0b2000ef          	jal	ra,800734 <printfmt>
  800686:	bb91                	j	8003da <vprintfmt+0x34>
  800688:	00001717          	auipc	a4,0x1
  80068c:	83870713          	addi	a4,a4,-1992 # 800ec0 <error_string+0x2b8>
  800690:	00001417          	auipc	s0,0x1
  800694:	83140413          	addi	s0,s0,-1999 # 800ec1 <error_string+0x2b9>
  800698:	853a                	mv	a0,a4
  80069a:	85ea                	mv	a1,s10
  80069c:	e03a                	sd	a4,0(sp)
  80069e:	e442                	sd	a6,8(sp)
  8006a0:	0b2000ef          	jal	ra,800752 <strnlen>
  8006a4:	40ac8cbb          	subw	s9,s9,a0
  8006a8:	6702                	ld	a4,0(sp)
  8006aa:	01905f63          	blez	s9,8006c8 <vprintfmt+0x322>
  8006ae:	6822                	ld	a6,8(sp)
  8006b0:	0008079b          	sext.w	a5,a6
  8006b4:	e43e                	sd	a5,8(sp)
  8006b6:	6522                	ld	a0,8(sp)
  8006b8:	864a                	mv	a2,s2
  8006ba:	85a6                	mv	a1,s1
  8006bc:	e03a                	sd	a4,0(sp)
  8006be:	3cfd                	addiw	s9,s9,-1
  8006c0:	9982                	jalr	s3
  8006c2:	6702                	ld	a4,0(sp)
  8006c4:	fe0c99e3          	bnez	s9,8006b6 <vprintfmt+0x310>
  8006c8:	00074703          	lbu	a4,0(a4)
  8006cc:	0007051b          	sext.w	a0,a4
  8006d0:	e80512e3          	bnez	a0,800554 <vprintfmt+0x1ae>
  8006d4:	b319                	j	8003da <vprintfmt+0x34>
  8006d6:	000b2403          	lw	s0,0(s6)
  8006da:	bb6d                	j	800494 <vprintfmt+0xee>
  8006dc:	000b6683          	lwu	a3,0(s6)
  8006e0:	4729                	li	a4,10
  8006e2:	8b32                	mv	s6,a2
  8006e4:	bd3d                	j	800522 <vprintfmt+0x17c>
  8006e6:	000b6683          	lwu	a3,0(s6)
  8006ea:	4741                	li	a4,16
  8006ec:	8b32                	mv	s6,a2
  8006ee:	bd15                	j	800522 <vprintfmt+0x17c>
  8006f0:	000b6683          	lwu	a3,0(s6)
  8006f4:	4721                	li	a4,8
  8006f6:	8b32                	mv	s6,a2
  8006f8:	b52d                	j	800522 <vprintfmt+0x17c>
  8006fa:	9982                	jalr	s3
  8006fc:	bd9d                	j	800572 <vprintfmt+0x1cc>
  8006fe:	864a                	mv	a2,s2
  800700:	85a6                	mv	a1,s1
  800702:	02d00513          	li	a0,45
  800706:	e042                	sd	a6,0(sp)
  800708:	9982                	jalr	s3
  80070a:	8b52                	mv	s6,s4
  80070c:	408006b3          	neg	a3,s0
  800710:	4729                	li	a4,10
  800712:	6802                	ld	a6,0(sp)
  800714:	b539                	j	800522 <vprintfmt+0x17c>
  800716:	01905663          	blez	s9,800722 <vprintfmt+0x37c>
  80071a:	02d00713          	li	a4,45
  80071e:	f6e815e3          	bne	a6,a4,800688 <vprintfmt+0x2e2>
  800722:	00000417          	auipc	s0,0x0
  800726:	79f40413          	addi	s0,s0,1951 # 800ec1 <error_string+0x2b9>
  80072a:	02800513          	li	a0,40
  80072e:	02800713          	li	a4,40
  800732:	b50d                	j	800554 <vprintfmt+0x1ae>

0000000000800734 <printfmt>:
  800734:	7139                	addi	sp,sp,-64
  800736:	02010313          	addi	t1,sp,32
  80073a:	f03a                	sd	a4,32(sp)
  80073c:	871a                	mv	a4,t1
  80073e:	ec06                	sd	ra,24(sp)
  800740:	f43e                	sd	a5,40(sp)
  800742:	f842                	sd	a6,48(sp)
  800744:	fc46                	sd	a7,56(sp)
  800746:	e41a                	sd	t1,8(sp)
  800748:	c5fff0ef          	jal	ra,8003a6 <vprintfmt>
  80074c:	60e2                	ld	ra,24(sp)
  80074e:	6121                	addi	sp,sp,64
  800750:	8082                	ret

0000000000800752 <strnlen>:
  800752:	c185                	beqz	a1,800772 <strnlen+0x20>
  800754:	00054783          	lbu	a5,0(a0)
  800758:	cf89                	beqz	a5,800772 <strnlen+0x20>
  80075a:	4781                	li	a5,0
  80075c:	a021                	j	800764 <strnlen+0x12>
  80075e:	00074703          	lbu	a4,0(a4)
  800762:	c711                	beqz	a4,80076e <strnlen+0x1c>
  800764:	0785                	addi	a5,a5,1
  800766:	00f50733          	add	a4,a0,a5
  80076a:	fef59ae3          	bne	a1,a5,80075e <strnlen+0xc>
  80076e:	853e                	mv	a0,a5
  800770:	8082                	ret
  800772:	4781                	li	a5,0
  800774:	853e                	mv	a0,a5
  800776:	8082                	ret

0000000000800778 <getstat>:
  800778:	1101                	addi	sp,sp,-32
  80077a:	e426                	sd	s1,8(sp)
  80077c:	84ae                	mv	s1,a1
  80077e:	4581                	li	a1,0
  800780:	e822                	sd	s0,16(sp)
  800782:	ec06                	sd	ra,24(sp)
  800784:	919ff0ef          	jal	ra,80009c <open>
  800788:	842a                	mv	s0,a0
  80078a:	00054a63          	bltz	a0,80079e <getstat+0x26>
  80078e:	85a6                	mv	a1,s1
  800790:	91dff0ef          	jal	ra,8000ac <fstat>
  800794:	84aa                	mv	s1,a0
  800796:	8522                	mv	a0,s0
  800798:	90dff0ef          	jal	ra,8000a4 <close>
  80079c:	8426                	mv	s0,s1
  80079e:	8522                	mv	a0,s0
  8007a0:	60e2                	ld	ra,24(sp)
  8007a2:	6442                	ld	s0,16(sp)
  8007a4:	64a2                	ld	s1,8(sp)
  8007a6:	6105                	addi	sp,sp,32
  8007a8:	8082                	ret

00000000008007aa <lsstat>:
  8007aa:	411c                	lw	a5,0(a0)
  8007ac:	1101                	addi	sp,sp,-32
  8007ae:	669d                	lui	a3,0x7
  8007b0:	e822                	sd	s0,16(sp)
  8007b2:	e426                	sd	s1,8(sp)
  8007b4:	ec06                	sd	ra,24(sp)
  8007b6:	6705                	lui	a4,0x1
  8007b8:	8ff5                	and	a5,a5,a3
  8007ba:	842a                	mv	s0,a0
  8007bc:	84ae                	mv	s1,a1
  8007be:	06e78963          	beq	a5,a4,800830 <lsstat+0x86>
  8007c2:	6709                	lui	a4,0x2
  8007c4:	06400613          	li	a2,100
  8007c8:	00e79463          	bne	a5,a4,8007d0 <lsstat+0x26>
  8007cc:	2601                	sext.w	a2,a2
  8007ce:	a031                	j	8007da <lsstat+0x30>
  8007d0:	670d                	lui	a4,0x3
  8007d2:	06c00613          	li	a2,108
  8007d6:	06e79163          	bne	a5,a4,800838 <lsstat+0x8e>
  8007da:	00000597          	auipc	a1,0x0
  8007de:	7b658593          	addi	a1,a1,1974 # 800f90 <error_string+0x388>
  8007e2:	4505                	li	a0,1
  8007e4:	9bbff0ef          	jal	ra,80019e <fprintf>
  8007e8:	6410                	ld	a2,8(s0)
  8007ea:	00000597          	auipc	a1,0x0
  8007ee:	7ae58593          	addi	a1,a1,1966 # 800f98 <error_string+0x390>
  8007f2:	4505                	li	a0,1
  8007f4:	9abff0ef          	jal	ra,80019e <fprintf>
  8007f8:	6810                	ld	a2,16(s0)
  8007fa:	00000597          	auipc	a1,0x0
  8007fe:	7a658593          	addi	a1,a1,1958 # 800fa0 <error_string+0x398>
  800802:	4505                	li	a0,1
  800804:	99bff0ef          	jal	ra,80019e <fprintf>
  800808:	6c10                	ld	a2,24(s0)
  80080a:	00000597          	auipc	a1,0x0
  80080e:	79e58593          	addi	a1,a1,1950 # 800fa8 <error_string+0x3a0>
  800812:	4505                	li	a0,1
  800814:	98bff0ef          	jal	ra,80019e <fprintf>
  800818:	6442                	ld	s0,16(sp)
  80081a:	60e2                	ld	ra,24(sp)
  80081c:	8626                	mv	a2,s1
  80081e:	64a2                	ld	s1,8(sp)
  800820:	00000597          	auipc	a1,0x0
  800824:	79058593          	addi	a1,a1,1936 # 800fb0 <error_string+0x3a8>
  800828:	4505                	li	a0,1
  80082a:	6105                	addi	sp,sp,32
  80082c:	973ff06f          	j	80019e <fprintf>
  800830:	02d00613          	li	a2,45
  800834:	2601                	sext.w	a2,a2
  800836:	b755                	j	8007da <lsstat+0x30>
  800838:	6711                	lui	a4,0x4
  80083a:	06300613          	li	a2,99
  80083e:	f8e78ee3          	beq	a5,a4,8007da <lsstat+0x30>
  800842:	6715                	lui	a4,0x5
  800844:	06200613          	li	a2,98
  800848:	f8e789e3          	beq	a5,a4,8007da <lsstat+0x30>
  80084c:	03f00613          	li	a2,63
  800850:	2601                	sext.w	a2,a2
  800852:	b761                	j	8007da <lsstat+0x30>

0000000000800854 <lsdir>:
  800854:	7139                	addi	sp,sp,-64
  800856:	00000517          	auipc	a0,0x0
  80085a:	72250513          	addi	a0,a0,1826 # 800f78 <error_string+0x370>
  80085e:	fc06                	sd	ra,56(sp)
  800860:	f822                	sd	s0,48(sp)
  800862:	f426                	sd	s1,40(sp)
  800864:	f04a                	sd	s2,32(sp)
  800866:	fbaff0ef          	jal	ra,800020 <opendir>
  80086a:	c125                	beqz	a0,8008ca <lsdir+0x76>
  80086c:	892a                	mv	s2,a0
  80086e:	a809                	j	800880 <lsdir+0x2c>
  800870:	f09ff0ef          	jal	ra,800778 <getstat>
  800874:	84aa                	mv	s1,a0
  800876:	85a2                	mv	a1,s0
  800878:	850a                	mv	a0,sp
  80087a:	ec95                	bnez	s1,8008b6 <lsdir+0x62>
  80087c:	f2fff0ef          	jal	ra,8007aa <lsstat>
  800880:	854a                	mv	a0,s2
  800882:	ff0ff0ef          	jal	ra,800072 <readdir>
  800886:	87aa                	mv	a5,a0
  800888:	00850413          	addi	s0,a0,8
  80088c:	858a                	mv	a1,sp
  80088e:	8522                	mv	a0,s0
  800890:	f3e5                	bnez	a5,800870 <lsdir+0x1c>
  800892:	00000597          	auipc	a1,0x0
  800896:	6ee58593          	addi	a1,a1,1774 # 800f80 <error_string+0x378>
  80089a:	4505                	li	a0,1
  80089c:	903ff0ef          	jal	ra,80019e <fprintf>
  8008a0:	854a                	mv	a0,s2
  8008a2:	ff4ff0ef          	jal	ra,800096 <closedir>
  8008a6:	4481                	li	s1,0
  8008a8:	70e2                	ld	ra,56(sp)
  8008aa:	7442                	ld	s0,48(sp)
  8008ac:	8526                	mv	a0,s1
  8008ae:	7902                	ld	s2,32(sp)
  8008b0:	74a2                	ld	s1,40(sp)
  8008b2:	6121                	addi	sp,sp,64
  8008b4:	8082                	ret
  8008b6:	854a                	mv	a0,s2
  8008b8:	fdeff0ef          	jal	ra,800096 <closedir>
  8008bc:	70e2                	ld	ra,56(sp)
  8008be:	7442                	ld	s0,48(sp)
  8008c0:	8526                	mv	a0,s1
  8008c2:	7902                	ld	s2,32(sp)
  8008c4:	74a2                	ld	s1,40(sp)
  8008c6:	6121                	addi	sp,sp,64
  8008c8:	8082                	ret
  8008ca:	54fd                	li	s1,-1
  8008cc:	bff1                	j	8008a8 <lsdir+0x54>

00000000008008ce <ls>:
  8008ce:	7139                	addi	sp,sp,-64
  8008d0:	858a                	mv	a1,sp
  8008d2:	f822                	sd	s0,48(sp)
  8008d4:	f426                	sd	s1,40(sp)
  8008d6:	fc06                	sd	ra,56(sp)
  8008d8:	84aa                	mv	s1,a0
  8008da:	e9fff0ef          	jal	ra,800778 <getstat>
  8008de:	842a                	mv	s0,a0
  8008e0:	ed49                	bnez	a0,80097a <ls+0xac>
  8008e2:	4782                	lw	a5,0(sp)
  8008e4:	669d                	lui	a3,0x7
  8008e6:	6705                	lui	a4,0x1
  8008e8:	8ff5                	and	a5,a5,a3
  8008ea:	00000617          	auipc	a2,0x0
  8008ee:	5f660613          	addi	a2,a2,1526 # 800ee0 <error_string+0x2d8>
  8008f2:	02e78e63          	beq	a5,a4,80092e <ls+0x60>
  8008f6:	6709                	lui	a4,0x2
  8008f8:	00000617          	auipc	a2,0x0
  8008fc:	60860613          	addi	a2,a2,1544 # 800f00 <error_string+0x2f8>
  800900:	02e78763          	beq	a5,a4,80092e <ls+0x60>
  800904:	670d                	lui	a4,0x3
  800906:	00000617          	auipc	a2,0x0
  80090a:	5ea60613          	addi	a2,a2,1514 # 800ef0 <error_string+0x2e8>
  80090e:	02e78063          	beq	a5,a4,80092e <ls+0x60>
  800912:	6711                	lui	a4,0x4
  800914:	00000617          	auipc	a2,0x0
  800918:	5fc60613          	addi	a2,a2,1532 # 800f10 <error_string+0x308>
  80091c:	00e78963          	beq	a5,a4,80092e <ls+0x60>
  800920:	6715                	lui	a4,0x5
  800922:	00000617          	auipc	a2,0x0
  800926:	5be60613          	addi	a2,a2,1470 # 800ee0 <error_string+0x2d8>
  80092a:	06e78363          	beq	a5,a4,800990 <ls+0xc2>
  80092e:	00000597          	auipc	a1,0x0
  800932:	60258593          	addi	a1,a1,1538 # 800f30 <error_string+0x328>
  800936:	4505                	li	a0,1
  800938:	867ff0ef          	jal	ra,80019e <fprintf>
  80093c:	6622                	ld	a2,8(sp)
  80093e:	00000597          	auipc	a1,0x0
  800942:	60258593          	addi	a1,a1,1538 # 800f40 <error_string+0x338>
  800946:	4505                	li	a0,1
  800948:	857ff0ef          	jal	ra,80019e <fprintf>
  80094c:	6642                	ld	a2,16(sp)
  80094e:	00000597          	auipc	a1,0x0
  800952:	60258593          	addi	a1,a1,1538 # 800f50 <error_string+0x348>
  800956:	4505                	li	a0,1
  800958:	847ff0ef          	jal	ra,80019e <fprintf>
  80095c:	6662                	ld	a2,24(sp)
  80095e:	86a6                	mv	a3,s1
  800960:	00000597          	auipc	a1,0x0
  800964:	60058593          	addi	a1,a1,1536 # 800f60 <error_string+0x358>
  800968:	4505                	li	a0,1
  80096a:	835ff0ef          	jal	ra,80019e <fprintf>
  80096e:	4782                	lw	a5,0(sp)
  800970:	669d                	lui	a3,0x7
  800972:	6709                	lui	a4,0x2
  800974:	8ff5                	and	a5,a5,a3
  800976:	00e78863          	beq	a5,a4,800986 <ls+0xb8>
  80097a:	8522                	mv	a0,s0
  80097c:	70e2                	ld	ra,56(sp)
  80097e:	7442                	ld	s0,48(sp)
  800980:	74a2                	ld	s1,40(sp)
  800982:	6121                	addi	sp,sp,64
  800984:	8082                	ret
  800986:	8526                	mv	a0,s1
  800988:	ecdff0ef          	jal	ra,800854 <lsdir>
  80098c:	842a                	mv	s0,a0
  80098e:	b7f5                	j	80097a <ls+0xac>
  800990:	00000617          	auipc	a2,0x0
  800994:	59060613          	addi	a2,a2,1424 # 800f20 <error_string+0x318>
  800998:	bf59                	j	80092e <ls+0x60>

000000000080099a <main>:
  80099a:	4785                	li	a5,1
  80099c:	04f50063          	beq	a0,a5,8009dc <main+0x42>
  8009a0:	04a7d463          	ble	a0,a5,8009e8 <main+0x4e>
  8009a4:	1101                	addi	sp,sp,-32
  8009a6:	e426                	sd	s1,8(sp)
  8009a8:	ffe5049b          	addiw	s1,a0,-2
  8009ac:	1482                	slli	s1,s1,0x20
  8009ae:	80f5                	srli	s1,s1,0x1d
  8009b0:	01058793          	addi	a5,a1,16
  8009b4:	e822                	sd	s0,16(sp)
  8009b6:	ec06                	sd	ra,24(sp)
  8009b8:	00858413          	addi	s0,a1,8
  8009bc:	94be                	add	s1,s1,a5
  8009be:	a019                	j	8009c4 <main+0x2a>
  8009c0:	00940c63          	beq	s0,s1,8009d8 <main+0x3e>
  8009c4:	6008                	ld	a0,0(s0)
  8009c6:	0421                	addi	s0,s0,8
  8009c8:	f07ff0ef          	jal	ra,8008ce <ls>
  8009cc:	d975                	beqz	a0,8009c0 <main+0x26>
  8009ce:	60e2                	ld	ra,24(sp)
  8009d0:	6442                	ld	s0,16(sp)
  8009d2:	64a2                	ld	s1,8(sp)
  8009d4:	6105                	addi	sp,sp,32
  8009d6:	8082                	ret
  8009d8:	4501                	li	a0,0
  8009da:	bfd5                	j	8009ce <main+0x34>
  8009dc:	00000517          	auipc	a0,0x0
  8009e0:	59c50513          	addi	a0,a0,1436 # 800f78 <error_string+0x370>
  8009e4:	eebff06f          	j	8008ce <ls>
  8009e8:	4501                	li	a0,0
  8009ea:	8082                	ret
