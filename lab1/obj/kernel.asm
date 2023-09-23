
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080200000 <kern_entry>:
#include <memlayout.h>

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    la sp, bootstacktop
    80200000:	00004117          	auipc	sp,0x4
    80200004:	00010113          	mv	sp,sp

    tail kern_init
    80200008:	0040006f          	j	8020000c <kern_init>

000000008020000c <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
    8020000c:	00004517          	auipc	a0,0x4
    80200010:	ffc50513          	addi	a0,a0,-4 # 80204008 <edata>
    80200014:	00004617          	auipc	a2,0x4
    80200018:	ff460613          	addi	a2,a2,-12 # 80204008 <edata>
int kern_init(void) {
    8020001c:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
    8020001e:	8e09                	sub	a2,a2,a0
    80200020:	4581                	li	a1,0
int kern_init(void) {
    80200022:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
    80200024:	151000ef          	jal	ra,80200974 <memset>

    cons_init();  // init the console
    80200028:	106000ef          	jal	ra,8020012e <cons_init>

    const char *message = "(THU.CST) os is loading ...\n";
    cprintf("%s\n\n", message);
    8020002c:	00001597          	auipc	a1,0x1
    80200030:	95c58593          	addi	a1,a1,-1700 # 80200988 <etext+0x2>
    80200034:	00001517          	auipc	a0,0x1
    80200038:	97450513          	addi	a0,a0,-1676 # 802009a8 <etext+0x22>
    8020003c:	02e000ef          	jal	ra,8020006a <cprintf>

    print_kerninfo();
    80200040:	05e000ef          	jal	ra,8020009e <print_kerninfo>
       
    // grade_backtrace();

    idt_init();  // init interrupt descriptor table
    80200044:	0f4000ef          	jal	ra,80200138 <idt_init>
    
    asm volatile("ebreak"); // trigger a breakpoint exception
    80200048:	9002                	ebreak
    8020004a:	ffff                	0xffff
    8020004c:	ffff                	0xffff
    //clock_init();  // init clock interrupt

    //intr_enable();  // enable irq interrupt
    
    while (1)
        ;
    8020004e:	a001                	j	8020004e <kern_init+0x42>

0000000080200050 <cputch>:

/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void cputch(int c, int *cnt) {
    80200050:	1141                	addi	sp,sp,-16
    80200052:	e022                	sd	s0,0(sp)
    80200054:	e406                	sd	ra,8(sp)
    80200056:	842e                	mv	s0,a1
    cons_putc(c);
    80200058:	0d8000ef          	jal	ra,80200130 <cons_putc>
    (*cnt)++;
    8020005c:	401c                	lw	a5,0(s0)
}
    8020005e:	60a2                	ld	ra,8(sp)
    (*cnt)++;
    80200060:	2785                	addiw	a5,a5,1
    80200062:	c01c                	sw	a5,0(s0)
}
    80200064:	6402                	ld	s0,0(sp)
    80200066:	0141                	addi	sp,sp,16
    80200068:	8082                	ret

000000008020006a <cprintf>:
 * cprintf - formats a string and writes it to stdout
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...) {
    8020006a:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
    8020006c:	02810313          	addi	t1,sp,40 # 80204028 <edata+0x20>
int cprintf(const char *fmt, ...) {
    80200070:	f42e                	sd	a1,40(sp)
    80200072:	f832                	sd	a2,48(sp)
    80200074:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
    80200076:	862a                	mv	a2,a0
    80200078:	004c                	addi	a1,sp,4
    8020007a:	00000517          	auipc	a0,0x0
    8020007e:	fd650513          	addi	a0,a0,-42 # 80200050 <cputch>
    80200082:	869a                	mv	a3,t1
int cprintf(const char *fmt, ...) {
    80200084:	ec06                	sd	ra,24(sp)
    80200086:	e0ba                	sd	a4,64(sp)
    80200088:	e4be                	sd	a5,72(sp)
    8020008a:	e8c2                	sd	a6,80(sp)
    8020008c:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
    8020008e:	e41a                	sd	t1,8(sp)
    int cnt = 0;
    80200090:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
    80200092:	514000ef          	jal	ra,802005a6 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
    80200096:	60e2                	ld	ra,24(sp)
    80200098:	4512                	lw	a0,4(sp)
    8020009a:	6125                	addi	sp,sp,96
    8020009c:	8082                	ret

000000008020009e <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
    8020009e:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
    802000a0:	00001517          	auipc	a0,0x1
    802000a4:	91050513          	addi	a0,a0,-1776 # 802009b0 <etext+0x2a>
void print_kerninfo(void) {
    802000a8:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
    802000aa:	fc1ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  entry  0x%016x (virtual)\n", kern_init);
    802000ae:	00000597          	auipc	a1,0x0
    802000b2:	f5e58593          	addi	a1,a1,-162 # 8020000c <kern_init>
    802000b6:	00001517          	auipc	a0,0x1
    802000ba:	91a50513          	addi	a0,a0,-1766 # 802009d0 <etext+0x4a>
    802000be:	fadff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  etext  0x%016x (virtual)\n", etext);
    802000c2:	00001597          	auipc	a1,0x1
    802000c6:	8c458593          	addi	a1,a1,-1852 # 80200986 <etext>
    802000ca:	00001517          	auipc	a0,0x1
    802000ce:	92650513          	addi	a0,a0,-1754 # 802009f0 <etext+0x6a>
    802000d2:	f99ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  edata  0x%016x (virtual)\n", edata);
    802000d6:	00004597          	auipc	a1,0x4
    802000da:	f3258593          	addi	a1,a1,-206 # 80204008 <edata>
    802000de:	00001517          	auipc	a0,0x1
    802000e2:	93250513          	addi	a0,a0,-1742 # 80200a10 <etext+0x8a>
    802000e6:	f85ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  end    0x%016x (virtual)\n", end);
    802000ea:	00004597          	auipc	a1,0x4
    802000ee:	f1e58593          	addi	a1,a1,-226 # 80204008 <edata>
    802000f2:	00001517          	auipc	a0,0x1
    802000f6:	93e50513          	addi	a0,a0,-1730 # 80200a30 <etext+0xaa>
    802000fa:	f71ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
    802000fe:	00004597          	auipc	a1,0x4
    80200102:	30958593          	addi	a1,a1,777 # 80204407 <edata+0x3ff>
    80200106:	00000797          	auipc	a5,0x0
    8020010a:	f0678793          	addi	a5,a5,-250 # 8020000c <kern_init>
    8020010e:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
    80200112:	43f7d593          	srai	a1,a5,0x3f
}
    80200116:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
    80200118:	3ff5f593          	andi	a1,a1,1023
    8020011c:	95be                	add	a1,a1,a5
    8020011e:	85a9                	srai	a1,a1,0xa
    80200120:	00001517          	auipc	a0,0x1
    80200124:	93050513          	addi	a0,a0,-1744 # 80200a50 <etext+0xca>
}
    80200128:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
    8020012a:	f41ff06f          	j	8020006a <cprintf>

000000008020012e <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
    8020012e:	8082                	ret

0000000080200130 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
    80200130:	0ff57513          	andi	a0,a0,255
    80200134:	7fe0006f          	j	80200932 <sbi_console_putchar>

0000000080200138 <idt_init>:
 */
void idt_init(void) {
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
    80200138:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
    8020013c:	00000797          	auipc	a5,0x0
    80200140:	34878793          	addi	a5,a5,840 # 80200484 <__alltraps>
    80200144:	10579073          	csrw	stvec,a5
}
    80200148:	8082                	ret

000000008020014a <print_regs>:
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
    8020014a:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs *gpr) {
    8020014c:	1141                	addi	sp,sp,-16
    8020014e:	e022                	sd	s0,0(sp)
    80200150:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
    80200152:	00001517          	auipc	a0,0x1
    80200156:	a8e50513          	addi	a0,a0,-1394 # 80200be0 <etext+0x25a>
void print_regs(struct pushregs *gpr) {
    8020015a:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
    8020015c:	f0fff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
    80200160:	640c                	ld	a1,8(s0)
    80200162:	00001517          	auipc	a0,0x1
    80200166:	a9650513          	addi	a0,a0,-1386 # 80200bf8 <etext+0x272>
    8020016a:	f01ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
    8020016e:	680c                	ld	a1,16(s0)
    80200170:	00001517          	auipc	a0,0x1
    80200174:	aa050513          	addi	a0,a0,-1376 # 80200c10 <etext+0x28a>
    80200178:	ef3ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
    8020017c:	6c0c                	ld	a1,24(s0)
    8020017e:	00001517          	auipc	a0,0x1
    80200182:	aaa50513          	addi	a0,a0,-1366 # 80200c28 <etext+0x2a2>
    80200186:	ee5ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
    8020018a:	700c                	ld	a1,32(s0)
    8020018c:	00001517          	auipc	a0,0x1
    80200190:	ab450513          	addi	a0,a0,-1356 # 80200c40 <etext+0x2ba>
    80200194:	ed7ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
    80200198:	740c                	ld	a1,40(s0)
    8020019a:	00001517          	auipc	a0,0x1
    8020019e:	abe50513          	addi	a0,a0,-1346 # 80200c58 <etext+0x2d2>
    802001a2:	ec9ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
    802001a6:	780c                	ld	a1,48(s0)
    802001a8:	00001517          	auipc	a0,0x1
    802001ac:	ac850513          	addi	a0,a0,-1336 # 80200c70 <etext+0x2ea>
    802001b0:	ebbff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
    802001b4:	7c0c                	ld	a1,56(s0)
    802001b6:	00001517          	auipc	a0,0x1
    802001ba:	ad250513          	addi	a0,a0,-1326 # 80200c88 <etext+0x302>
    802001be:	eadff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
    802001c2:	602c                	ld	a1,64(s0)
    802001c4:	00001517          	auipc	a0,0x1
    802001c8:	adc50513          	addi	a0,a0,-1316 # 80200ca0 <etext+0x31a>
    802001cc:	e9fff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
    802001d0:	642c                	ld	a1,72(s0)
    802001d2:	00001517          	auipc	a0,0x1
    802001d6:	ae650513          	addi	a0,a0,-1306 # 80200cb8 <etext+0x332>
    802001da:	e91ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
    802001de:	682c                	ld	a1,80(s0)
    802001e0:	00001517          	auipc	a0,0x1
    802001e4:	af050513          	addi	a0,a0,-1296 # 80200cd0 <etext+0x34a>
    802001e8:	e83ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
    802001ec:	6c2c                	ld	a1,88(s0)
    802001ee:	00001517          	auipc	a0,0x1
    802001f2:	afa50513          	addi	a0,a0,-1286 # 80200ce8 <etext+0x362>
    802001f6:	e75ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
    802001fa:	702c                	ld	a1,96(s0)
    802001fc:	00001517          	auipc	a0,0x1
    80200200:	b0450513          	addi	a0,a0,-1276 # 80200d00 <etext+0x37a>
    80200204:	e67ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
    80200208:	742c                	ld	a1,104(s0)
    8020020a:	00001517          	auipc	a0,0x1
    8020020e:	b0e50513          	addi	a0,a0,-1266 # 80200d18 <etext+0x392>
    80200212:	e59ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
    80200216:	782c                	ld	a1,112(s0)
    80200218:	00001517          	auipc	a0,0x1
    8020021c:	b1850513          	addi	a0,a0,-1256 # 80200d30 <etext+0x3aa>
    80200220:	e4bff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
    80200224:	7c2c                	ld	a1,120(s0)
    80200226:	00001517          	auipc	a0,0x1
    8020022a:	b2250513          	addi	a0,a0,-1246 # 80200d48 <etext+0x3c2>
    8020022e:	e3dff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
    80200232:	604c                	ld	a1,128(s0)
    80200234:	00001517          	auipc	a0,0x1
    80200238:	b2c50513          	addi	a0,a0,-1236 # 80200d60 <etext+0x3da>
    8020023c:	e2fff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
    80200240:	644c                	ld	a1,136(s0)
    80200242:	00001517          	auipc	a0,0x1
    80200246:	b3650513          	addi	a0,a0,-1226 # 80200d78 <etext+0x3f2>
    8020024a:	e21ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
    8020024e:	684c                	ld	a1,144(s0)
    80200250:	00001517          	auipc	a0,0x1
    80200254:	b4050513          	addi	a0,a0,-1216 # 80200d90 <etext+0x40a>
    80200258:	e13ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
    8020025c:	6c4c                	ld	a1,152(s0)
    8020025e:	00001517          	auipc	a0,0x1
    80200262:	b4a50513          	addi	a0,a0,-1206 # 80200da8 <etext+0x422>
    80200266:	e05ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
    8020026a:	704c                	ld	a1,160(s0)
    8020026c:	00001517          	auipc	a0,0x1
    80200270:	b5450513          	addi	a0,a0,-1196 # 80200dc0 <etext+0x43a>
    80200274:	df7ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
    80200278:	744c                	ld	a1,168(s0)
    8020027a:	00001517          	auipc	a0,0x1
    8020027e:	b5e50513          	addi	a0,a0,-1186 # 80200dd8 <etext+0x452>
    80200282:	de9ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
    80200286:	784c                	ld	a1,176(s0)
    80200288:	00001517          	auipc	a0,0x1
    8020028c:	b6850513          	addi	a0,a0,-1176 # 80200df0 <etext+0x46a>
    80200290:	ddbff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
    80200294:	7c4c                	ld	a1,184(s0)
    80200296:	00001517          	auipc	a0,0x1
    8020029a:	b7250513          	addi	a0,a0,-1166 # 80200e08 <etext+0x482>
    8020029e:	dcdff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
    802002a2:	606c                	ld	a1,192(s0)
    802002a4:	00001517          	auipc	a0,0x1
    802002a8:	b7c50513          	addi	a0,a0,-1156 # 80200e20 <etext+0x49a>
    802002ac:	dbfff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
    802002b0:	646c                	ld	a1,200(s0)
    802002b2:	00001517          	auipc	a0,0x1
    802002b6:	b8650513          	addi	a0,a0,-1146 # 80200e38 <etext+0x4b2>
    802002ba:	db1ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
    802002be:	686c                	ld	a1,208(s0)
    802002c0:	00001517          	auipc	a0,0x1
    802002c4:	b9050513          	addi	a0,a0,-1136 # 80200e50 <etext+0x4ca>
    802002c8:	da3ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
    802002cc:	6c6c                	ld	a1,216(s0)
    802002ce:	00001517          	auipc	a0,0x1
    802002d2:	b9a50513          	addi	a0,a0,-1126 # 80200e68 <etext+0x4e2>
    802002d6:	d95ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
    802002da:	706c                	ld	a1,224(s0)
    802002dc:	00001517          	auipc	a0,0x1
    802002e0:	ba450513          	addi	a0,a0,-1116 # 80200e80 <etext+0x4fa>
    802002e4:	d87ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
    802002e8:	746c                	ld	a1,232(s0)
    802002ea:	00001517          	auipc	a0,0x1
    802002ee:	bae50513          	addi	a0,a0,-1106 # 80200e98 <etext+0x512>
    802002f2:	d79ff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
    802002f6:	786c                	ld	a1,240(s0)
    802002f8:	00001517          	auipc	a0,0x1
    802002fc:	bb850513          	addi	a0,a0,-1096 # 80200eb0 <etext+0x52a>
    80200300:	d6bff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
    80200304:	7c6c                	ld	a1,248(s0)
}
    80200306:	6402                	ld	s0,0(sp)
    80200308:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
    8020030a:	00001517          	auipc	a0,0x1
    8020030e:	bbe50513          	addi	a0,a0,-1090 # 80200ec8 <etext+0x542>
}
    80200312:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
    80200314:	d57ff06f          	j	8020006a <cprintf>

0000000080200318 <print_trapframe>:
void print_trapframe(struct trapframe *tf) {
    80200318:	1141                	addi	sp,sp,-16
    8020031a:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
    8020031c:	85aa                	mv	a1,a0
void print_trapframe(struct trapframe *tf) {
    8020031e:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
    80200320:	00001517          	auipc	a0,0x1
    80200324:	bc050513          	addi	a0,a0,-1088 # 80200ee0 <etext+0x55a>
void print_trapframe(struct trapframe *tf) {
    80200328:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
    8020032a:	d41ff0ef          	jal	ra,8020006a <cprintf>
    print_regs(&tf->gpr);
    8020032e:	8522                	mv	a0,s0
    80200330:	e1bff0ef          	jal	ra,8020014a <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
    80200334:	10043583          	ld	a1,256(s0)
    80200338:	00001517          	auipc	a0,0x1
    8020033c:	bc050513          	addi	a0,a0,-1088 # 80200ef8 <etext+0x572>
    80200340:	d2bff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
    80200344:	10843583          	ld	a1,264(s0)
    80200348:	00001517          	auipc	a0,0x1
    8020034c:	bc850513          	addi	a0,a0,-1080 # 80200f10 <etext+0x58a>
    80200350:	d1bff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    80200354:	11043583          	ld	a1,272(s0)
    80200358:	00001517          	auipc	a0,0x1
    8020035c:	bd050513          	addi	a0,a0,-1072 # 80200f28 <etext+0x5a2>
    80200360:	d0bff0ef          	jal	ra,8020006a <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
    80200364:	11843583          	ld	a1,280(s0)
}
    80200368:	6402                	ld	s0,0(sp)
    8020036a:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
    8020036c:	00001517          	auipc	a0,0x1
    80200370:	bd450513          	addi	a0,a0,-1068 # 80200f40 <etext+0x5ba>
}
    80200374:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
    80200376:	cf5ff06f          	j	8020006a <cprintf>

000000008020037a <interrupt_handler>:

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
    8020037a:	11853783          	ld	a5,280(a0)
    8020037e:	577d                	li	a4,-1
    80200380:	8305                	srli	a4,a4,0x1
    80200382:	8ff9                	and	a5,a5,a4
    switch (cause) {
    80200384:	472d                	li	a4,11
    80200386:	04f76a63          	bltu	a4,a5,802003da <interrupt_handler+0x60>
    8020038a:	00000717          	auipc	a4,0x0
    8020038e:	6f270713          	addi	a4,a4,1778 # 80200a7c <etext+0xf6>
    80200392:	078a                	slli	a5,a5,0x2
    80200394:	97ba                	add	a5,a5,a4
    80200396:	439c                	lw	a5,0(a5)
    80200398:	97ba                	add	a5,a5,a4
    8020039a:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
    8020039c:	00001517          	auipc	a0,0x1
    802003a0:	80450513          	addi	a0,a0,-2044 # 80200ba0 <etext+0x21a>
    802003a4:	cc7ff06f          	j	8020006a <cprintf>
            cprintf("Hypervisor software interrupt\n");
    802003a8:	00000517          	auipc	a0,0x0
    802003ac:	7d850513          	addi	a0,a0,2008 # 80200b80 <etext+0x1fa>
    802003b0:	cbbff06f          	j	8020006a <cprintf>
            cprintf("User software interrupt\n");
    802003b4:	00000517          	auipc	a0,0x0
    802003b8:	78c50513          	addi	a0,a0,1932 # 80200b40 <etext+0x1ba>
    802003bc:	cafff06f          	j	8020006a <cprintf>
            cprintf("Supervisor software interrupt\n");
    802003c0:	00000517          	auipc	a0,0x0
    802003c4:	7a050513          	addi	a0,a0,1952 # 80200b60 <etext+0x1da>
    802003c8:	ca3ff06f          	j	8020006a <cprintf>
            break;
        case IRQ_U_EXT:
            cprintf("User software interrupt\n");
            break;
        case IRQ_S_EXT:
            cprintf("Supervisor external interrupt\n");
    802003cc:	00000517          	auipc	a0,0x0
    802003d0:	7f450513          	addi	a0,a0,2036 # 80200bc0 <etext+0x23a>
    802003d4:	c97ff06f          	j	8020006a <cprintf>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
    802003d8:	8082                	ret
            print_trapframe(tf);
    802003da:	f3fff06f          	j	80200318 <print_trapframe>

00000000802003de <exception_handler>:

void exception_handler(struct trapframe *tf) {
    switch (tf->cause) {
    802003de:	11853783          	ld	a5,280(a0)
    802003e2:	472d                	li	a4,11
    802003e4:	02f76863          	bltu	a4,a5,80200414 <exception_handler+0x36>
    802003e8:	4705                	li	a4,1
    802003ea:	00f71733          	sll	a4,a4,a5
    802003ee:	6785                	lui	a5,0x1
    802003f0:	17cd                	addi	a5,a5,-13
    802003f2:	8ff9                	and	a5,a5,a4
    802003f4:	ef99                	bnez	a5,80200412 <exception_handler+0x34>
void exception_handler(struct trapframe *tf) {
    802003f6:	1141                	addi	sp,sp,-16
    802003f8:	e022                	sd	s0,0(sp)
    802003fa:	e406                	sd	ra,8(sp)
    802003fc:	00877793          	andi	a5,a4,8
    80200400:	842a                	mv	s0,a0
    80200402:	e3b1                	bnez	a5,80200446 <exception_handler+0x68>
    80200404:	8b11                	andi	a4,a4,4
    80200406:	eb09                	bnez	a4,80200418 <exception_handler+0x3a>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
    80200408:	6402                	ld	s0,0(sp)
    8020040a:	60a2                	ld	ra,8(sp)
    8020040c:	0141                	addi	sp,sp,16
            print_trapframe(tf);
    8020040e:	f0bff06f          	j	80200318 <print_trapframe>
    80200412:	8082                	ret
    80200414:	f05ff06f          	j	80200318 <print_trapframe>
            cprintf("Exception type:Illegal instruction\n");
    80200418:	00000517          	auipc	a0,0x0
    8020041c:	69850513          	addi	a0,a0,1688 # 80200ab0 <etext+0x12a>
    80200420:	c4bff0ef          	jal	ra,8020006a <cprintf>
            cprintf("Illegal instruction caught at 0x%08x\n", tf->epc);
    80200424:	10843583          	ld	a1,264(s0)
    80200428:	00000517          	auipc	a0,0x0
    8020042c:	6b050513          	addi	a0,a0,1712 # 80200ad8 <etext+0x152>
    80200430:	c3bff0ef          	jal	ra,8020006a <cprintf>
            tf->epc += 4;
    80200434:	10843783          	ld	a5,264(s0)
}
    80200438:	60a2                	ld	ra,8(sp)
            tf->epc += 4;
    8020043a:	0791                	addi	a5,a5,4
    8020043c:	10f43423          	sd	a5,264(s0)
}
    80200440:	6402                	ld	s0,0(sp)
    80200442:	0141                	addi	sp,sp,16
    80200444:	8082                	ret
            cprintf("Exception type: breakpoint\n");
    80200446:	00000517          	auipc	a0,0x0
    8020044a:	6ba50513          	addi	a0,a0,1722 # 80200b00 <etext+0x17a>
    8020044e:	c1dff0ef          	jal	ra,8020006a <cprintf>
            cprintf("Breakpoint caught at 0x%08x\n", tf->epc);
    80200452:	10843583          	ld	a1,264(s0)
    80200456:	00000517          	auipc	a0,0x0
    8020045a:	6ca50513          	addi	a0,a0,1738 # 80200b20 <etext+0x19a>
    8020045e:	c0dff0ef          	jal	ra,8020006a <cprintf>
            tf->epc += 4;
    80200462:	10843783          	ld	a5,264(s0)
}
    80200466:	60a2                	ld	ra,8(sp)
            tf->epc += 4;
    80200468:	0791                	addi	a5,a5,4
    8020046a:	10f43423          	sd	a5,264(s0)
}
    8020046e:	6402                	ld	s0,0(sp)
    80200470:	0141                	addi	sp,sp,16
    80200472:	8082                	ret

0000000080200474 <trap>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static inline void trap_dispatch(struct trapframe *tf) {
    if ((intptr_t)tf->cause < 0) {
    80200474:	11853783          	ld	a5,280(a0)
    80200478:	0007c463          	bltz	a5,80200480 <trap+0xc>
        // interrupts
        interrupt_handler(tf);
    } else {
        // exceptions
        exception_handler(tf);
    8020047c:	f63ff06f          	j	802003de <exception_handler>
        interrupt_handler(tf);
    80200480:	efbff06f          	j	8020037a <interrupt_handler>

0000000080200484 <__alltraps>:
    .endm

    .globl __alltraps
.align(2)
__alltraps:
    SAVE_ALL
    80200484:	14011073          	csrw	sscratch,sp
    80200488:	712d                	addi	sp,sp,-288
    8020048a:	e002                	sd	zero,0(sp)
    8020048c:	e406                	sd	ra,8(sp)
    8020048e:	ec0e                	sd	gp,24(sp)
    80200490:	f012                	sd	tp,32(sp)
    80200492:	f416                	sd	t0,40(sp)
    80200494:	f81a                	sd	t1,48(sp)
    80200496:	fc1e                	sd	t2,56(sp)
    80200498:	e0a2                	sd	s0,64(sp)
    8020049a:	e4a6                	sd	s1,72(sp)
    8020049c:	e8aa                	sd	a0,80(sp)
    8020049e:	ecae                	sd	a1,88(sp)
    802004a0:	f0b2                	sd	a2,96(sp)
    802004a2:	f4b6                	sd	a3,104(sp)
    802004a4:	f8ba                	sd	a4,112(sp)
    802004a6:	fcbe                	sd	a5,120(sp)
    802004a8:	e142                	sd	a6,128(sp)
    802004aa:	e546                	sd	a7,136(sp)
    802004ac:	e94a                	sd	s2,144(sp)
    802004ae:	ed4e                	sd	s3,152(sp)
    802004b0:	f152                	sd	s4,160(sp)
    802004b2:	f556                	sd	s5,168(sp)
    802004b4:	f95a                	sd	s6,176(sp)
    802004b6:	fd5e                	sd	s7,184(sp)
    802004b8:	e1e2                	sd	s8,192(sp)
    802004ba:	e5e6                	sd	s9,200(sp)
    802004bc:	e9ea                	sd	s10,208(sp)
    802004be:	edee                	sd	s11,216(sp)
    802004c0:	f1f2                	sd	t3,224(sp)
    802004c2:	f5f6                	sd	t4,232(sp)
    802004c4:	f9fa                	sd	t5,240(sp)
    802004c6:	fdfe                	sd	t6,248(sp)
    802004c8:	14001473          	csrrw	s0,sscratch,zero
    802004cc:	100024f3          	csrr	s1,sstatus
    802004d0:	14102973          	csrr	s2,sepc
    802004d4:	143029f3          	csrr	s3,stval
    802004d8:	14202a73          	csrr	s4,scause
    802004dc:	e822                	sd	s0,16(sp)
    802004de:	e226                	sd	s1,256(sp)
    802004e0:	e64a                	sd	s2,264(sp)
    802004e2:	ea4e                	sd	s3,272(sp)
    802004e4:	ee52                	sd	s4,280(sp)

    move  a0, sp
    802004e6:	850a                	mv	a0,sp
    jal trap
    802004e8:	f8dff0ef          	jal	ra,80200474 <trap>

00000000802004ec <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
    802004ec:	6492                	ld	s1,256(sp)
    802004ee:	6932                	ld	s2,264(sp)
    802004f0:	10049073          	csrw	sstatus,s1
    802004f4:	14191073          	csrw	sepc,s2
    802004f8:	60a2                	ld	ra,8(sp)
    802004fa:	61e2                	ld	gp,24(sp)
    802004fc:	7202                	ld	tp,32(sp)
    802004fe:	72a2                	ld	t0,40(sp)
    80200500:	7342                	ld	t1,48(sp)
    80200502:	73e2                	ld	t2,56(sp)
    80200504:	6406                	ld	s0,64(sp)
    80200506:	64a6                	ld	s1,72(sp)
    80200508:	6546                	ld	a0,80(sp)
    8020050a:	65e6                	ld	a1,88(sp)
    8020050c:	7606                	ld	a2,96(sp)
    8020050e:	76a6                	ld	a3,104(sp)
    80200510:	7746                	ld	a4,112(sp)
    80200512:	77e6                	ld	a5,120(sp)
    80200514:	680a                	ld	a6,128(sp)
    80200516:	68aa                	ld	a7,136(sp)
    80200518:	694a                	ld	s2,144(sp)
    8020051a:	69ea                	ld	s3,152(sp)
    8020051c:	7a0a                	ld	s4,160(sp)
    8020051e:	7aaa                	ld	s5,168(sp)
    80200520:	7b4a                	ld	s6,176(sp)
    80200522:	7bea                	ld	s7,184(sp)
    80200524:	6c0e                	ld	s8,192(sp)
    80200526:	6cae                	ld	s9,200(sp)
    80200528:	6d4e                	ld	s10,208(sp)
    8020052a:	6dee                	ld	s11,216(sp)
    8020052c:	7e0e                	ld	t3,224(sp)
    8020052e:	7eae                	ld	t4,232(sp)
    80200530:	7f4e                	ld	t5,240(sp)
    80200532:	7fee                	ld	t6,248(sp)
    80200534:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
    80200536:	10200073          	sret

000000008020053a <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
    8020053a:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
    8020053e:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
    80200540:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
    80200544:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
    80200546:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
    8020054a:	f022                	sd	s0,32(sp)
    8020054c:	ec26                	sd	s1,24(sp)
    8020054e:	e84a                	sd	s2,16(sp)
    80200550:	f406                	sd	ra,40(sp)
    80200552:	e44e                	sd	s3,8(sp)
    80200554:	84aa                	mv	s1,a0
    80200556:	892e                	mv	s2,a1
    80200558:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
    8020055c:	2a01                	sext.w	s4,s4

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
    8020055e:	03067e63          	bleu	a6,a2,8020059a <printnum+0x60>
    80200562:	89be                	mv	s3,a5
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
    80200564:	00805763          	blez	s0,80200572 <printnum+0x38>
    80200568:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
    8020056a:	85ca                	mv	a1,s2
    8020056c:	854e                	mv	a0,s3
    8020056e:	9482                	jalr	s1
        while (-- width > 0)
    80200570:	fc65                	bnez	s0,80200568 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
    80200572:	1a02                	slli	s4,s4,0x20
    80200574:	020a5a13          	srli	s4,s4,0x20
    80200578:	00001797          	auipc	a5,0x1
    8020057c:	b7078793          	addi	a5,a5,-1168 # 802010e8 <error_string+0x38>
    80200580:	9a3e                	add	s4,s4,a5
}
    80200582:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
    80200584:	000a4503          	lbu	a0,0(s4)
}
    80200588:	70a2                	ld	ra,40(sp)
    8020058a:	69a2                	ld	s3,8(sp)
    8020058c:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
    8020058e:	85ca                	mv	a1,s2
    80200590:	8326                	mv	t1,s1
}
    80200592:	6942                	ld	s2,16(sp)
    80200594:	64e2                	ld	s1,24(sp)
    80200596:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
    80200598:	8302                	jr	t1
        printnum(putch, putdat, result, base, width - 1, padc);
    8020059a:	03065633          	divu	a2,a2,a6
    8020059e:	8722                	mv	a4,s0
    802005a0:	f9bff0ef          	jal	ra,8020053a <printnum>
    802005a4:	b7f9                	j	80200572 <printnum+0x38>

00000000802005a6 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
    802005a6:	7119                	addi	sp,sp,-128
    802005a8:	f4a6                	sd	s1,104(sp)
    802005aa:	f0ca                	sd	s2,96(sp)
    802005ac:	e8d2                	sd	s4,80(sp)
    802005ae:	e4d6                	sd	s5,72(sp)
    802005b0:	e0da                	sd	s6,64(sp)
    802005b2:	fc5e                	sd	s7,56(sp)
    802005b4:	f862                	sd	s8,48(sp)
    802005b6:	f06a                	sd	s10,32(sp)
    802005b8:	fc86                	sd	ra,120(sp)
    802005ba:	f8a2                	sd	s0,112(sp)
    802005bc:	ecce                	sd	s3,88(sp)
    802005be:	f466                	sd	s9,40(sp)
    802005c0:	ec6e                	sd	s11,24(sp)
    802005c2:	892a                	mv	s2,a0
    802005c4:	84ae                	mv	s1,a1
    802005c6:	8d32                	mv	s10,a2
    802005c8:	8ab6                	mv	s5,a3
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
    802005ca:	5b7d                	li	s6,-1
        lflag = altflag = 0;

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
    802005cc:	00001a17          	auipc	s4,0x1
    802005d0:	988a0a13          	addi	s4,s4,-1656 # 80200f54 <etext+0x5ce>
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
                if (altflag && (ch < ' ' || ch > '~')) {
    802005d4:	05e00b93          	li	s7,94
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
    802005d8:	00001c17          	auipc	s8,0x1
    802005dc:	ad8c0c13          	addi	s8,s8,-1320 # 802010b0 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
    802005e0:	000d4503          	lbu	a0,0(s10)
    802005e4:	02500793          	li	a5,37
    802005e8:	001d0413          	addi	s0,s10,1
    802005ec:	00f50e63          	beq	a0,a5,80200608 <vprintfmt+0x62>
            if (ch == '\0') {
    802005f0:	c521                	beqz	a0,80200638 <vprintfmt+0x92>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
    802005f2:	02500993          	li	s3,37
    802005f6:	a011                	j	802005fa <vprintfmt+0x54>
            if (ch == '\0') {
    802005f8:	c121                	beqz	a0,80200638 <vprintfmt+0x92>
            putch(ch, putdat);
    802005fa:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
    802005fc:	0405                	addi	s0,s0,1
            putch(ch, putdat);
    802005fe:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
    80200600:	fff44503          	lbu	a0,-1(s0)
    80200604:	ff351ae3          	bne	a0,s3,802005f8 <vprintfmt+0x52>
    80200608:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
    8020060c:	02000793          	li	a5,32
        lflag = altflag = 0;
    80200610:	4981                	li	s3,0
    80200612:	4801                	li	a6,0
        width = precision = -1;
    80200614:	5cfd                	li	s9,-1
    80200616:	5dfd                	li	s11,-1
        switch (ch = *(unsigned char *)fmt ++) {
    80200618:	05500593          	li	a1,85
                if (ch < '0' || ch > '9') {
    8020061c:	4525                	li	a0,9
        switch (ch = *(unsigned char *)fmt ++) {
    8020061e:	fdd6069b          	addiw	a3,a2,-35
    80200622:	0ff6f693          	andi	a3,a3,255
    80200626:	00140d13          	addi	s10,s0,1
    8020062a:	20d5e563          	bltu	a1,a3,80200834 <vprintfmt+0x28e>
    8020062e:	068a                	slli	a3,a3,0x2
    80200630:	96d2                	add	a3,a3,s4
    80200632:	4294                	lw	a3,0(a3)
    80200634:	96d2                	add	a3,a3,s4
    80200636:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
    80200638:	70e6                	ld	ra,120(sp)
    8020063a:	7446                	ld	s0,112(sp)
    8020063c:	74a6                	ld	s1,104(sp)
    8020063e:	7906                	ld	s2,96(sp)
    80200640:	69e6                	ld	s3,88(sp)
    80200642:	6a46                	ld	s4,80(sp)
    80200644:	6aa6                	ld	s5,72(sp)
    80200646:	6b06                	ld	s6,64(sp)
    80200648:	7be2                	ld	s7,56(sp)
    8020064a:	7c42                	ld	s8,48(sp)
    8020064c:	7ca2                	ld	s9,40(sp)
    8020064e:	7d02                	ld	s10,32(sp)
    80200650:	6de2                	ld	s11,24(sp)
    80200652:	6109                	addi	sp,sp,128
    80200654:	8082                	ret
    if (lflag >= 2) {
    80200656:	4705                	li	a4,1
    80200658:	008a8593          	addi	a1,s5,8
    8020065c:	01074463          	blt	a4,a6,80200664 <vprintfmt+0xbe>
    else if (lflag) {
    80200660:	26080363          	beqz	a6,802008c6 <vprintfmt+0x320>
        return va_arg(*ap, unsigned long);
    80200664:	000ab603          	ld	a2,0(s5)
    80200668:	46c1                	li	a3,16
    8020066a:	8aae                	mv	s5,a1
    8020066c:	a06d                	j	80200716 <vprintfmt+0x170>
            goto reswitch;
    8020066e:	00144603          	lbu	a2,1(s0)
            altflag = 1;
    80200672:	4985                	li	s3,1
        switch (ch = *(unsigned char *)fmt ++) {
    80200674:	846a                	mv	s0,s10
            goto reswitch;
    80200676:	b765                	j	8020061e <vprintfmt+0x78>
            putch(va_arg(ap, int), putdat);
    80200678:	000aa503          	lw	a0,0(s5)
    8020067c:	85a6                	mv	a1,s1
    8020067e:	0aa1                	addi	s5,s5,8
    80200680:	9902                	jalr	s2
            break;
    80200682:	bfb9                	j	802005e0 <vprintfmt+0x3a>
    if (lflag >= 2) {
    80200684:	4705                	li	a4,1
    80200686:	008a8993          	addi	s3,s5,8
    8020068a:	01074463          	blt	a4,a6,80200692 <vprintfmt+0xec>
    else if (lflag) {
    8020068e:	22080463          	beqz	a6,802008b6 <vprintfmt+0x310>
        return va_arg(*ap, long);
    80200692:	000ab403          	ld	s0,0(s5)
            if ((long long)num < 0) {
    80200696:	24044463          	bltz	s0,802008de <vprintfmt+0x338>
            num = getint(&ap, lflag);
    8020069a:	8622                	mv	a2,s0
    8020069c:	8ace                	mv	s5,s3
    8020069e:	46a9                	li	a3,10
    802006a0:	a89d                	j	80200716 <vprintfmt+0x170>
            err = va_arg(ap, int);
    802006a2:	000aa783          	lw	a5,0(s5)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
    802006a6:	4719                	li	a4,6
            err = va_arg(ap, int);
    802006a8:	0aa1                	addi	s5,s5,8
            if (err < 0) {
    802006aa:	41f7d69b          	sraiw	a3,a5,0x1f
    802006ae:	8fb5                	xor	a5,a5,a3
    802006b0:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
    802006b4:	1ad74363          	blt	a4,a3,8020085a <vprintfmt+0x2b4>
    802006b8:	00369793          	slli	a5,a3,0x3
    802006bc:	97e2                	add	a5,a5,s8
    802006be:	639c                	ld	a5,0(a5)
    802006c0:	18078d63          	beqz	a5,8020085a <vprintfmt+0x2b4>
                printfmt(putch, putdat, "%s", p);
    802006c4:	86be                	mv	a3,a5
    802006c6:	00001617          	auipc	a2,0x1
    802006ca:	ad260613          	addi	a2,a2,-1326 # 80201198 <error_string+0xe8>
    802006ce:	85a6                	mv	a1,s1
    802006d0:	854a                	mv	a0,s2
    802006d2:	240000ef          	jal	ra,80200912 <printfmt>
    802006d6:	b729                	j	802005e0 <vprintfmt+0x3a>
            lflag ++;
    802006d8:	00144603          	lbu	a2,1(s0)
    802006dc:	2805                	addiw	a6,a6,1
        switch (ch = *(unsigned char *)fmt ++) {
    802006de:	846a                	mv	s0,s10
            goto reswitch;
    802006e0:	bf3d                	j	8020061e <vprintfmt+0x78>
    if (lflag >= 2) {
    802006e2:	4705                	li	a4,1
    802006e4:	008a8593          	addi	a1,s5,8
    802006e8:	01074463          	blt	a4,a6,802006f0 <vprintfmt+0x14a>
    else if (lflag) {
    802006ec:	1e080263          	beqz	a6,802008d0 <vprintfmt+0x32a>
        return va_arg(*ap, unsigned long);
    802006f0:	000ab603          	ld	a2,0(s5)
    802006f4:	46a1                	li	a3,8
    802006f6:	8aae                	mv	s5,a1
    802006f8:	a839                	j	80200716 <vprintfmt+0x170>
            putch('0', putdat);
    802006fa:	03000513          	li	a0,48
    802006fe:	85a6                	mv	a1,s1
    80200700:	e03e                	sd	a5,0(sp)
    80200702:	9902                	jalr	s2
            putch('x', putdat);
    80200704:	85a6                	mv	a1,s1
    80200706:	07800513          	li	a0,120
    8020070a:	9902                	jalr	s2
            num = (unsigned long long)va_arg(ap, void *);
    8020070c:	0aa1                	addi	s5,s5,8
    8020070e:	ff8ab603          	ld	a2,-8(s5)
            goto number;
    80200712:	6782                	ld	a5,0(sp)
    80200714:	46c1                	li	a3,16
            printnum(putch, putdat, num, base, width, padc);
    80200716:	876e                	mv	a4,s11
    80200718:	85a6                	mv	a1,s1
    8020071a:	854a                	mv	a0,s2
    8020071c:	e1fff0ef          	jal	ra,8020053a <printnum>
            break;
    80200720:	b5c1                	j	802005e0 <vprintfmt+0x3a>
            if ((p = va_arg(ap, char *)) == NULL) {
    80200722:	000ab603          	ld	a2,0(s5)
    80200726:	0aa1                	addi	s5,s5,8
    80200728:	1c060663          	beqz	a2,802008f4 <vprintfmt+0x34e>
            if (width > 0 && padc != '-') {
    8020072c:	00160413          	addi	s0,a2,1
    80200730:	17b05c63          	blez	s11,802008a8 <vprintfmt+0x302>
    80200734:	02d00593          	li	a1,45
    80200738:	14b79263          	bne	a5,a1,8020087c <vprintfmt+0x2d6>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    8020073c:	00064783          	lbu	a5,0(a2)
    80200740:	0007851b          	sext.w	a0,a5
    80200744:	c905                	beqz	a0,80200774 <vprintfmt+0x1ce>
    80200746:	000cc563          	bltz	s9,80200750 <vprintfmt+0x1aa>
    8020074a:	3cfd                	addiw	s9,s9,-1
    8020074c:	036c8263          	beq	s9,s6,80200770 <vprintfmt+0x1ca>
                    putch('?', putdat);
    80200750:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
    80200752:	18098463          	beqz	s3,802008da <vprintfmt+0x334>
    80200756:	3781                	addiw	a5,a5,-32
    80200758:	18fbf163          	bleu	a5,s7,802008da <vprintfmt+0x334>
                    putch('?', putdat);
    8020075c:	03f00513          	li	a0,63
    80200760:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    80200762:	0405                	addi	s0,s0,1
    80200764:	fff44783          	lbu	a5,-1(s0)
    80200768:	3dfd                	addiw	s11,s11,-1
    8020076a:	0007851b          	sext.w	a0,a5
    8020076e:	fd61                	bnez	a0,80200746 <vprintfmt+0x1a0>
            for (; width > 0; width --) {
    80200770:	e7b058e3          	blez	s11,802005e0 <vprintfmt+0x3a>
    80200774:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
    80200776:	85a6                	mv	a1,s1
    80200778:	02000513          	li	a0,32
    8020077c:	9902                	jalr	s2
            for (; width > 0; width --) {
    8020077e:	e60d81e3          	beqz	s11,802005e0 <vprintfmt+0x3a>
    80200782:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
    80200784:	85a6                	mv	a1,s1
    80200786:	02000513          	li	a0,32
    8020078a:	9902                	jalr	s2
            for (; width > 0; width --) {
    8020078c:	fe0d94e3          	bnez	s11,80200774 <vprintfmt+0x1ce>
    80200790:	bd81                	j	802005e0 <vprintfmt+0x3a>
    if (lflag >= 2) {
    80200792:	4705                	li	a4,1
    80200794:	008a8593          	addi	a1,s5,8
    80200798:	01074463          	blt	a4,a6,802007a0 <vprintfmt+0x1fa>
    else if (lflag) {
    8020079c:	12080063          	beqz	a6,802008bc <vprintfmt+0x316>
        return va_arg(*ap, unsigned long);
    802007a0:	000ab603          	ld	a2,0(s5)
    802007a4:	46a9                	li	a3,10
    802007a6:	8aae                	mv	s5,a1
    802007a8:	b7bd                	j	80200716 <vprintfmt+0x170>
    802007aa:	00144603          	lbu	a2,1(s0)
            padc = '-';
    802007ae:	02d00793          	li	a5,45
        switch (ch = *(unsigned char *)fmt ++) {
    802007b2:	846a                	mv	s0,s10
    802007b4:	b5ad                	j	8020061e <vprintfmt+0x78>
            putch(ch, putdat);
    802007b6:	85a6                	mv	a1,s1
    802007b8:	02500513          	li	a0,37
    802007bc:	9902                	jalr	s2
            break;
    802007be:	b50d                	j	802005e0 <vprintfmt+0x3a>
            precision = va_arg(ap, int);
    802007c0:	000aac83          	lw	s9,0(s5)
            goto process_precision;
    802007c4:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
    802007c8:	0aa1                	addi	s5,s5,8
        switch (ch = *(unsigned char *)fmt ++) {
    802007ca:	846a                	mv	s0,s10
            if (width < 0)
    802007cc:	e40dd9e3          	bgez	s11,8020061e <vprintfmt+0x78>
                width = precision, precision = -1;
    802007d0:	8de6                	mv	s11,s9
    802007d2:	5cfd                	li	s9,-1
    802007d4:	b5a9                	j	8020061e <vprintfmt+0x78>
            goto reswitch;
    802007d6:	00144603          	lbu	a2,1(s0)
            padc = '0';
    802007da:	03000793          	li	a5,48
        switch (ch = *(unsigned char *)fmt ++) {
    802007de:	846a                	mv	s0,s10
            goto reswitch;
    802007e0:	bd3d                	j	8020061e <vprintfmt+0x78>
                precision = precision * 10 + ch - '0';
    802007e2:	fd060c9b          	addiw	s9,a2,-48
                ch = *fmt;
    802007e6:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
    802007ea:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
    802007ec:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
    802007f0:	0006089b          	sext.w	a7,a2
                if (ch < '0' || ch > '9') {
    802007f4:	fcd56ce3          	bltu	a0,a3,802007cc <vprintfmt+0x226>
            for (precision = 0; ; ++ fmt) {
    802007f8:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
    802007fa:	002c969b          	slliw	a3,s9,0x2
                ch = *fmt;
    802007fe:	00044603          	lbu	a2,0(s0)
                precision = precision * 10 + ch - '0';
    80200802:	0196873b          	addw	a4,a3,s9
    80200806:	0017171b          	slliw	a4,a4,0x1
    8020080a:	0117073b          	addw	a4,a4,a7
                if (ch < '0' || ch > '9') {
    8020080e:	fd06069b          	addiw	a3,a2,-48
                precision = precision * 10 + ch - '0';
    80200812:	fd070c9b          	addiw	s9,a4,-48
                ch = *fmt;
    80200816:	0006089b          	sext.w	a7,a2
                if (ch < '0' || ch > '9') {
    8020081a:	fcd57fe3          	bleu	a3,a0,802007f8 <vprintfmt+0x252>
    8020081e:	b77d                	j	802007cc <vprintfmt+0x226>
            if (width < 0)
    80200820:	fffdc693          	not	a3,s11
    80200824:	96fd                	srai	a3,a3,0x3f
    80200826:	00ddfdb3          	and	s11,s11,a3
    8020082a:	00144603          	lbu	a2,1(s0)
    8020082e:	2d81                	sext.w	s11,s11
        switch (ch = *(unsigned char *)fmt ++) {
    80200830:	846a                	mv	s0,s10
    80200832:	b3f5                	j	8020061e <vprintfmt+0x78>
            putch('%', putdat);
    80200834:	85a6                	mv	a1,s1
    80200836:	02500513          	li	a0,37
    8020083a:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
    8020083c:	fff44703          	lbu	a4,-1(s0)
    80200840:	02500793          	li	a5,37
    80200844:	8d22                	mv	s10,s0
    80200846:	d8f70de3          	beq	a4,a5,802005e0 <vprintfmt+0x3a>
    8020084a:	02500713          	li	a4,37
    8020084e:	1d7d                	addi	s10,s10,-1
    80200850:	fffd4783          	lbu	a5,-1(s10)
    80200854:	fee79de3          	bne	a5,a4,8020084e <vprintfmt+0x2a8>
    80200858:	b361                	j	802005e0 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
    8020085a:	00001617          	auipc	a2,0x1
    8020085e:	92e60613          	addi	a2,a2,-1746 # 80201188 <error_string+0xd8>
    80200862:	85a6                	mv	a1,s1
    80200864:	854a                	mv	a0,s2
    80200866:	0ac000ef          	jal	ra,80200912 <printfmt>
    8020086a:	bb9d                	j	802005e0 <vprintfmt+0x3a>
                p = "(null)";
    8020086c:	00001617          	auipc	a2,0x1
    80200870:	91460613          	addi	a2,a2,-1772 # 80201180 <error_string+0xd0>
            if (width > 0 && padc != '-') {
    80200874:	00001417          	auipc	s0,0x1
    80200878:	90d40413          	addi	s0,s0,-1779 # 80201181 <error_string+0xd1>
                for (width -= strnlen(p, precision); width > 0; width --) {
    8020087c:	8532                	mv	a0,a2
    8020087e:	85e6                	mv	a1,s9
    80200880:	e032                	sd	a2,0(sp)
    80200882:	e43e                	sd	a5,8(sp)
    80200884:	0ca000ef          	jal	ra,8020094e <strnlen>
    80200888:	40ad8dbb          	subw	s11,s11,a0
    8020088c:	6602                	ld	a2,0(sp)
    8020088e:	01b05d63          	blez	s11,802008a8 <vprintfmt+0x302>
    80200892:	67a2                	ld	a5,8(sp)
    80200894:	2781                	sext.w	a5,a5
    80200896:	e43e                	sd	a5,8(sp)
                    putch(padc, putdat);
    80200898:	6522                	ld	a0,8(sp)
    8020089a:	85a6                	mv	a1,s1
    8020089c:	e032                	sd	a2,0(sp)
                for (width -= strnlen(p, precision); width > 0; width --) {
    8020089e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
    802008a0:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
    802008a2:	6602                	ld	a2,0(sp)
    802008a4:	fe0d9ae3          	bnez	s11,80200898 <vprintfmt+0x2f2>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    802008a8:	00064783          	lbu	a5,0(a2)
    802008ac:	0007851b          	sext.w	a0,a5
    802008b0:	e8051be3          	bnez	a0,80200746 <vprintfmt+0x1a0>
    802008b4:	b335                	j	802005e0 <vprintfmt+0x3a>
        return va_arg(*ap, int);
    802008b6:	000aa403          	lw	s0,0(s5)
    802008ba:	bbf1                	j	80200696 <vprintfmt+0xf0>
        return va_arg(*ap, unsigned int);
    802008bc:	000ae603          	lwu	a2,0(s5)
    802008c0:	46a9                	li	a3,10
    802008c2:	8aae                	mv	s5,a1
    802008c4:	bd89                	j	80200716 <vprintfmt+0x170>
    802008c6:	000ae603          	lwu	a2,0(s5)
    802008ca:	46c1                	li	a3,16
    802008cc:	8aae                	mv	s5,a1
    802008ce:	b5a1                	j	80200716 <vprintfmt+0x170>
    802008d0:	000ae603          	lwu	a2,0(s5)
    802008d4:	46a1                	li	a3,8
    802008d6:	8aae                	mv	s5,a1
    802008d8:	bd3d                	j	80200716 <vprintfmt+0x170>
                    putch(ch, putdat);
    802008da:	9902                	jalr	s2
    802008dc:	b559                	j	80200762 <vprintfmt+0x1bc>
                putch('-', putdat);
    802008de:	85a6                	mv	a1,s1
    802008e0:	02d00513          	li	a0,45
    802008e4:	e03e                	sd	a5,0(sp)
    802008e6:	9902                	jalr	s2
                num = -(long long)num;
    802008e8:	8ace                	mv	s5,s3
    802008ea:	40800633          	neg	a2,s0
    802008ee:	46a9                	li	a3,10
    802008f0:	6782                	ld	a5,0(sp)
    802008f2:	b515                	j	80200716 <vprintfmt+0x170>
            if (width > 0 && padc != '-') {
    802008f4:	01b05663          	blez	s11,80200900 <vprintfmt+0x35a>
    802008f8:	02d00693          	li	a3,45
    802008fc:	f6d798e3          	bne	a5,a3,8020086c <vprintfmt+0x2c6>
    80200900:	00001417          	auipc	s0,0x1
    80200904:	88140413          	addi	s0,s0,-1919 # 80201181 <error_string+0xd1>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
    80200908:	02800513          	li	a0,40
    8020090c:	02800793          	li	a5,40
    80200910:	bd1d                	j	80200746 <vprintfmt+0x1a0>

0000000080200912 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
    80200912:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
    80200914:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
    80200918:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
    8020091a:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
    8020091c:	ec06                	sd	ra,24(sp)
    8020091e:	f83a                	sd	a4,48(sp)
    80200920:	fc3e                	sd	a5,56(sp)
    80200922:	e0c2                	sd	a6,64(sp)
    80200924:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
    80200926:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
    80200928:	c7fff0ef          	jal	ra,802005a6 <vprintfmt>
}
    8020092c:	60e2                	ld	ra,24(sp)
    8020092e:	6161                	addi	sp,sp,80
    80200930:	8082                	ret

0000000080200932 <sbi_console_putchar>:

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
    80200932:	00003797          	auipc	a5,0x3
    80200936:	6ce78793          	addi	a5,a5,1742 # 80204000 <bootstacktop>
    __asm__ volatile (
    8020093a:	6398                	ld	a4,0(a5)
    8020093c:	4781                	li	a5,0
    8020093e:	88ba                	mv	a7,a4
    80200940:	852a                	mv	a0,a0
    80200942:	85be                	mv	a1,a5
    80200944:	863e                	mv	a2,a5
    80200946:	00000073          	ecall
    8020094a:	87aa                	mv	a5,a0
}
    8020094c:	8082                	ret

000000008020094e <strnlen>:
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
    8020094e:	c185                	beqz	a1,8020096e <strnlen+0x20>
    80200950:	00054783          	lbu	a5,0(a0)
    80200954:	cf89                	beqz	a5,8020096e <strnlen+0x20>
    size_t cnt = 0;
    80200956:	4781                	li	a5,0
    80200958:	a021                	j	80200960 <strnlen+0x12>
    while (cnt < len && *s ++ != '\0') {
    8020095a:	00074703          	lbu	a4,0(a4)
    8020095e:	c711                	beqz	a4,8020096a <strnlen+0x1c>
        cnt ++;
    80200960:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
    80200962:	00f50733          	add	a4,a0,a5
    80200966:	fef59ae3          	bne	a1,a5,8020095a <strnlen+0xc>
    }
    return cnt;
}
    8020096a:	853e                	mv	a0,a5
    8020096c:	8082                	ret
    size_t cnt = 0;
    8020096e:	4781                	li	a5,0
}
    80200970:	853e                	mv	a0,a5
    80200972:	8082                	ret

0000000080200974 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
    80200974:	ca01                	beqz	a2,80200984 <memset+0x10>
    80200976:	962a                	add	a2,a2,a0
    char *p = s;
    80200978:	87aa                	mv	a5,a0
        *p ++ = c;
    8020097a:	0785                	addi	a5,a5,1
    8020097c:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
    80200980:	fec79de3          	bne	a5,a2,8020097a <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
    80200984:	8082                	ret
