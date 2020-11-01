
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 7d 02 00 00       	call   28b <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 05 03 00 00       	call   323 <sleep>
  exit();
  1e:	e8 70 02 00 00       	call   293 <exit>
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  31:	31 c0                	xor    %eax,%eax
{
  33:	89 e5                	mov    %esp,%ebp
  35:	53                   	push   %ebx
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	40                   	inc    %eax
  48:	84 d2                	test   %dl,%dl
  4a:	75 f4                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4c:	5b                   	pop    %ebx
  4d:	89 c8                	mov    %ecx,%eax
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    
  51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5f:	90                   	nop

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 5d 08             	mov    0x8(%ebp),%ebx
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  6a:	0f b6 03             	movzbl (%ebx),%eax
  6d:	0f b6 0a             	movzbl (%edx),%ecx
  70:	84 c0                	test   %al,%al
  72:	75 19                	jne    8d <strcmp+0x2d>
  74:	eb 2a                	jmp    a0 <strcmp+0x40>
  76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  7d:	8d 76 00             	lea    0x0(%esi),%esi
  80:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
  84:	43                   	inc    %ebx
  85:	42                   	inc    %edx
  while(*p && *p == *q)
  86:	0f b6 0a             	movzbl (%edx),%ecx
  89:	84 c0                	test   %al,%al
  8b:	74 13                	je     a0 <strcmp+0x40>
  8d:	38 c8                	cmp    %cl,%al
  8f:	74 ef                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  91:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  92:	29 c8                	sub    %ecx,%eax
}
  94:	5d                   	pop    %ebp
  95:	c3                   	ret    
  96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	5b                   	pop    %ebx
  a1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  a3:	29 c8                	sub    %ecx,%eax
}
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ae:	66 90                	xchg   %ax,%ax

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 3a 00             	cmpb   $0x0,(%edx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 c0                	xor    %eax,%eax
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	40                   	inc    %eax
  c1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  c5:	89 c1                	mov    %eax,%ecx
  c7:	75 f7                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  c9:	5d                   	pop    %ebp
  ca:	89 c8                	mov    %ecx,%eax
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
  d1:	31 c9                	xor    %ecx,%ecx
}
  d3:	89 c8                	mov    %ecx,%eax
  d5:	c3                   	ret    
  d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  dd:	8d 76 00             	lea    0x0(%esi),%esi

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	5f                   	pop    %edi
  f3:	89 d0                	mov    %edx,%eax
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fe:	66 90                	xchg   %ax,%ax

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	75 18                	jne    129 <strchr+0x29>
 111:	eb 1d                	jmp    130 <strchr+0x30>
 113:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 120:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 124:	40                   	inc    %eax
 125:	84 d2                	test   %dl,%dl
 127:	74 07                	je     130 <strchr+0x30>
    if(*s == c)
 129:	38 d1                	cmp    %dl,%cl
 12b:	75 f3                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
}
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret    
 12f:	90                   	nop
 130:	5d                   	pop    %ebp
  return 0;
 131:	31 c0                	xor    %eax,%eax
}
 133:	c3                   	ret    
 134:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 148:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 14b:	83 ec 3c             	sub    $0x3c,%esp
 14e:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 151:	eb 3a                	jmp    18d <gets+0x4d>
 153:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 160:	89 7c 24 04          	mov    %edi,0x4(%esp)
 164:	ba 01 00 00 00       	mov    $0x1,%edx
 169:	89 54 24 08          	mov    %edx,0x8(%esp)
 16d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 174:	e8 32 01 00 00       	call   2ab <read>
    if(cc < 1)
 179:	85 c0                	test   %eax,%eax
 17b:	7e 19                	jle    196 <gets+0x56>
      break;
    buf[i++] = c;
 17d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 181:	46                   	inc    %esi
 182:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 185:	3c 0a                	cmp    $0xa,%al
 187:	74 27                	je     1b0 <gets+0x70>
 189:	3c 0d                	cmp    $0xd,%al
 18b:	74 23                	je     1b0 <gets+0x70>
  for(i=0; i+1 < max; ){
 18d:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 190:	43                   	inc    %ebx
 191:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 194:	7c ca                	jl     160 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 196:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 199:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	83 c4 3c             	add    $0x3c,%esp
 1a2:	5b                   	pop    %ebx
 1a3:	5e                   	pop    %esi
 1a4:	5f                   	pop    %edi
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
 1a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ae:	66 90                	xchg   %ax,%ax
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	01 c3                	add    %eax,%ebx
 1b5:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 1b8:	eb dc                	jmp    196 <gets+0x56>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c1:	31 c0                	xor    %eax,%eax
{
 1c3:	89 e5                	mov    %esp,%ebp
 1c5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 1c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 1cf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1d2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1d5:	89 04 24             	mov    %eax,(%esp)
 1d8:	e8 f6 00 00 00       	call   2d3 <open>
  if(fd < 0)
 1dd:	85 c0                	test   %eax,%eax
 1df:	78 2f                	js     210 <stat+0x50>
 1e1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e6:	89 1c 24             	mov    %ebx,(%esp)
 1e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ed:	e8 f9 00 00 00       	call   2eb <fstat>
  close(fd);
 1f2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1f5:	89 c6                	mov    %eax,%esi
  close(fd);
 1f7:	e8 bf 00 00 00       	call   2bb <close>
  return r;
}
 1fc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1ff:	89 f0                	mov    %esi,%eax
 201:	8b 75 fc             	mov    -0x4(%ebp),%esi
 204:	89 ec                	mov    %ebp,%esp
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
 208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20f:	90                   	nop
    return -1;
 210:	be ff ff ff ff       	mov    $0xffffffff,%esi
 215:	eb e5                	jmp    1fc <stat+0x3c>
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	0f be 02             	movsbl (%edx),%eax
 22a:	88 c1                	mov    %al,%cl
 22c:	80 e9 30             	sub    $0x30,%cl
 22f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 232:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 237:	77 1c                	ja     255 <atoi+0x35>
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 240:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 243:	42                   	inc    %edx
 244:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 248:	0f be 02             	movsbl (%edx),%eax
 24b:	88 c3                	mov    %al,%bl
 24d:	80 eb 30             	sub    $0x30,%bl
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
  return n;
}
 255:	5b                   	pop    %ebx
 256:	89 c8                	mov    %ecx,%eax
 258:	5d                   	pop    %ebp
 259:	c3                   	ret    
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	8b 45 10             	mov    0x10(%ebp),%eax
 267:	56                   	push   %esi
 268:	8b 55 08             	mov    0x8(%ebp),%edx
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26e:	85 c0                	test   %eax,%eax
 270:	7e 13                	jle    285 <memmove+0x25>
 272:	01 d0                	add    %edx,%eax
  dst = vdst;
 274:	89 d7                	mov    %edx,%edi
 276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 281:	39 f8                	cmp    %edi,%eax
 283:	75 fb                	jne    280 <memmove+0x20>
  return vdst;
}
 285:	5e                   	pop    %esi
 286:	89 d0                	mov    %edx,%eax
 288:	5f                   	pop    %edi
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret    

0000028b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28b:	b8 01 00 00 00       	mov    $0x1,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <exit>:
SYSCALL(exit)
 293:	b8 02 00 00 00       	mov    $0x2,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <wait>:
SYSCALL(wait)
 29b:	b8 03 00 00 00       	mov    $0x3,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <pipe>:
SYSCALL(pipe)
 2a3:	b8 04 00 00 00       	mov    $0x4,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <read>:
SYSCALL(read)
 2ab:	b8 05 00 00 00       	mov    $0x5,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <write>:
SYSCALL(write)
 2b3:	b8 10 00 00 00       	mov    $0x10,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <close>:
SYSCALL(close)
 2bb:	b8 15 00 00 00       	mov    $0x15,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <kill>:
SYSCALL(kill)
 2c3:	b8 06 00 00 00       	mov    $0x6,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <exec>:
SYSCALL(exec)
 2cb:	b8 07 00 00 00       	mov    $0x7,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <open>:
SYSCALL(open)
 2d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <mknod>:
SYSCALL(mknod)
 2db:	b8 11 00 00 00       	mov    $0x11,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <unlink>:
SYSCALL(unlink)
 2e3:	b8 12 00 00 00       	mov    $0x12,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <fstat>:
SYSCALL(fstat)
 2eb:	b8 08 00 00 00       	mov    $0x8,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <link>:
SYSCALL(link)
 2f3:	b8 13 00 00 00       	mov    $0x13,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <mkdir>:
SYSCALL(mkdir)
 2fb:	b8 14 00 00 00       	mov    $0x14,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <chdir>:
SYSCALL(chdir)
 303:	b8 09 00 00 00       	mov    $0x9,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <dup>:
SYSCALL(dup)
 30b:	b8 0a 00 00 00       	mov    $0xa,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <getpid>:
SYSCALL(getpid)
 313:	b8 0b 00 00 00       	mov    $0xb,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <sbrk>:
SYSCALL(sbrk)
 31b:	b8 0c 00 00 00       	mov    $0xc,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <sleep>:
SYSCALL(sleep)
 323:	b8 0d 00 00 00       	mov    $0xd,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <uptime>:
SYSCALL(uptime)
 32b:	b8 0e 00 00 00       	mov    $0xe,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <waitx>:
SYSCALL(waitx)
 333:	b8 16 00 00 00       	mov    $0x16,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <set_priority>:
SYSCALL(set_priority)
 33b:	b8 17 00 00 00       	mov    $0x17,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <pls>:
SYSCALL(pls)
 343:	b8 18 00 00 00       	mov    $0x18,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    
 34b:	66 90                	xchg   %ax,%ax
 34d:	66 90                	xchg   %ax,%ax
 34f:	90                   	nop

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	89 cf                	mov    %ecx,%edi
 356:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 357:	89 d1                	mov    %edx,%ecx
{
 359:	53                   	push   %ebx
 35a:	83 ec 4c             	sub    $0x4c,%esp
 35d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 360:	89 d0                	mov    %edx,%eax
 362:	c1 e8 1f             	shr    $0x1f,%eax
 365:	84 c0                	test   %al,%al
 367:	0f 84 a3 00 00 00    	je     410 <printint+0xc0>
 36d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 371:	0f 84 99 00 00 00    	je     410 <printint+0xc0>
    neg = 1;
 377:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 37e:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 380:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 387:	8d 75 d7             	lea    -0x29(%ebp),%esi
 38a:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 38d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 390:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 393:	31 d2                	xor    %edx,%edx
 395:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 398:	f7 f7                	div    %edi
 39a:	8d 4b 01             	lea    0x1(%ebx),%ecx
 39d:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 3a0:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 3a3:	39 cf                	cmp    %ecx,%edi
 3a5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 3a8:	0f b6 92 90 07 00 00 	movzbl 0x790(%edx),%edx
 3af:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 3b3:	76 db                	jbe    390 <printint+0x40>
  if(neg)
 3b5:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 3b8:	85 c9                	test   %ecx,%ecx
 3ba:	74 0c                	je     3c8 <printint+0x78>
    buf[i++] = '-';
 3bc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 3bf:	b2 2d                	mov    $0x2d,%dl
 3c1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 3c6:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 3c8:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3cb:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 3cf:	eb 13                	jmp    3e4 <printint+0x94>
 3d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3df:	90                   	nop
 3e0:	0f b6 13             	movzbl (%ebx),%edx
 3e3:	4b                   	dec    %ebx
  write(fd, &c, 1);
 3e4:	89 74 24 04          	mov    %esi,0x4(%esp)
 3e8:	b8 01 00 00 00       	mov    $0x1,%eax
 3ed:	89 44 24 08          	mov    %eax,0x8(%esp)
 3f1:	89 3c 24             	mov    %edi,(%esp)
 3f4:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3f7:	e8 b7 fe ff ff       	call   2b3 <write>
  while(--i >= 0)
 3fc:	39 de                	cmp    %ebx,%esi
 3fe:	75 e0                	jne    3e0 <printint+0x90>
    putc(fd, buf[i]);
}
 400:	83 c4 4c             	add    $0x4c,%esp
 403:	5b                   	pop    %ebx
 404:	5e                   	pop    %esi
 405:	5f                   	pop    %edi
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40f:	90                   	nop
  neg = 0;
 410:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 417:	e9 64 ff ff ff       	jmp    380 <printint+0x30>
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 429:	8b 75 0c             	mov    0xc(%ebp),%esi
 42c:	0f b6 1e             	movzbl (%esi),%ebx
 42f:	84 db                	test   %bl,%bl
 431:	0f 84 c8 00 00 00    	je     4ff <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 437:	8d 45 10             	lea    0x10(%ebp),%eax
 43a:	46                   	inc    %esi
 43b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 43e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 441:	31 d2                	xor    %edx,%edx
 443:	eb 3e                	jmp    483 <printf+0x63>
 445:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 450:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 453:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 456:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 45b:	74 1e                	je     47b <printf+0x5b>
  write(fd, &c, 1);
 45d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 461:	b8 01 00 00 00       	mov    $0x1,%eax
 466:	89 44 24 08          	mov    %eax,0x8(%esp)
 46a:	8b 45 08             	mov    0x8(%ebp),%eax
 46d:	88 5d e7             	mov    %bl,-0x19(%ebp)
 470:	89 04 24             	mov    %eax,(%esp)
 473:	e8 3b fe ff ff       	call   2b3 <write>
 478:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 47b:	0f b6 1e             	movzbl (%esi),%ebx
 47e:	46                   	inc    %esi
 47f:	84 db                	test   %bl,%bl
 481:	74 7c                	je     4ff <printf+0xdf>
    if(state == 0){
 483:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 485:	0f be cb             	movsbl %bl,%ecx
 488:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 48b:	74 c3                	je     450 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 48d:	83 fa 25             	cmp    $0x25,%edx
 490:	75 e9                	jne    47b <printf+0x5b>
      if(c == 'd'){
 492:	83 f8 64             	cmp    $0x64,%eax
 495:	0f 84 a5 00 00 00    	je     540 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 49b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4a1:	83 f9 70             	cmp    $0x70,%ecx
 4a4:	74 6a                	je     510 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4a6:	83 f8 73             	cmp    $0x73,%eax
 4a9:	0f 84 e1 00 00 00    	je     590 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4af:	83 f8 63             	cmp    $0x63,%eax
 4b2:	0f 84 98 00 00 00    	je     550 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4b8:	83 f8 25             	cmp    $0x25,%eax
 4bb:	74 1c                	je     4d9 <printf+0xb9>
  write(fd, &c, 1);
 4bd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4c1:	8b 45 08             	mov    0x8(%ebp),%eax
 4c4:	ba 01 00 00 00       	mov    $0x1,%edx
 4c9:	89 54 24 08          	mov    %edx,0x8(%esp)
 4cd:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4d1:	89 04 24             	mov    %eax,(%esp)
 4d4:	e8 da fd ff ff       	call   2b3 <write>
 4d9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4dd:	b8 01 00 00 00       	mov    $0x1,%eax
 4e2:	46                   	inc    %esi
 4e3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4e7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ea:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4ed:	89 04 24             	mov    %eax,(%esp)
 4f0:	e8 be fd ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 4f5:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4fb:	84 db                	test   %bl,%bl
 4fd:	75 84                	jne    483 <printf+0x63>
    }
  }
}
 4ff:	83 c4 3c             	add    $0x3c,%esp
 502:	5b                   	pop    %ebx
 503:	5e                   	pop    %esi
 504:	5f                   	pop    %edi
 505:	5d                   	pop    %ebp
 506:	c3                   	ret    
 507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 510:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 517:	b9 10 00 00 00       	mov    $0x10,%ecx
 51c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 51f:	8b 45 08             	mov    0x8(%ebp),%eax
 522:	8b 13                	mov    (%ebx),%edx
 524:	e8 27 fe ff ff       	call   350 <printint>
        ap++;
 529:	89 d8                	mov    %ebx,%eax
      state = 0;
 52b:	31 d2                	xor    %edx,%edx
        ap++;
 52d:	83 c0 04             	add    $0x4,%eax
 530:	89 45 d0             	mov    %eax,-0x30(%ebp)
 533:	e9 43 ff ff ff       	jmp    47b <printf+0x5b>
 538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53f:	90                   	nop
        printint(fd, *ap, 10, 1);
 540:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 547:	b9 0a 00 00 00       	mov    $0xa,%ecx
 54c:	eb ce                	jmp    51c <printf+0xfc>
 54e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 550:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 553:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 558:	8b 03                	mov    (%ebx),%eax
        ap++;
 55a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 55d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 561:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 565:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 568:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 56c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 56f:	8b 45 08             	mov    0x8(%ebp),%eax
 572:	89 04 24             	mov    %eax,(%esp)
 575:	e8 39 fd ff ff       	call   2b3 <write>
      state = 0;
 57a:	31 d2                	xor    %edx,%edx
        ap++;
 57c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 57f:	e9 f7 fe ff ff       	jmp    47b <printf+0x5b>
 584:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop
        s = (char*)*ap;
 590:	8b 45 d0             	mov    -0x30(%ebp),%eax
 593:	8b 18                	mov    (%eax),%ebx
        ap++;
 595:	83 c0 04             	add    $0x4,%eax
 598:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 59b:	85 db                	test   %ebx,%ebx
 59d:	74 11                	je     5b0 <printf+0x190>
        while(*s != 0){
 59f:	0f b6 03             	movzbl (%ebx),%eax
 5a2:	84 c0                	test   %al,%al
 5a4:	74 44                	je     5ea <printf+0x1ca>
 5a6:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5a9:	89 de                	mov    %ebx,%esi
 5ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ae:	eb 10                	jmp    5c0 <printf+0x1a0>
 5b0:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 5b3:	bb 88 07 00 00       	mov    $0x788,%ebx
        while(*s != 0){
 5b8:	b0 28                	mov    $0x28,%al
 5ba:	89 de                	mov    %ebx,%esi
 5bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5bf:	90                   	nop
          putc(fd, *s);
 5c0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5c3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5c8:	46                   	inc    %esi
  write(fd, &c, 1);
 5c9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5cd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5d1:	89 1c 24             	mov    %ebx,(%esp)
 5d4:	e8 da fc ff ff       	call   2b3 <write>
        while(*s != 0){
 5d9:	0f b6 06             	movzbl (%esi),%eax
 5dc:	84 c0                	test   %al,%al
 5de:	75 e0                	jne    5c0 <printf+0x1a0>
 5e0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 5e3:	31 d2                	xor    %edx,%edx
 5e5:	e9 91 fe ff ff       	jmp    47b <printf+0x5b>
 5ea:	31 d2                	xor    %edx,%edx
 5ec:	e9 8a fe ff ff       	jmp    47b <printf+0x5b>
 5f1:	66 90                	xchg   %ax,%ax
 5f3:	66 90                	xchg   %ax,%ax
 5f5:	66 90                	xchg   %ax,%ax
 5f7:	66 90                	xchg   %ax,%ax
 5f9:	66 90                	xchg   %ax,%ax
 5fb:	66 90                	xchg   %ax,%ax
 5fd:	66 90                	xchg   %ax,%ax
 5ff:	90                   	nop

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 24 0a 00 00       	mov    0xa24,%eax
{
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 60e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 610:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 613:	39 c8                	cmp    %ecx,%eax
 615:	73 19                	jae    630 <free+0x30>
 617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61e:	66 90                	xchg   %ax,%ax
 620:	39 d1                	cmp    %edx,%ecx
 622:	72 14                	jb     638 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 624:	39 d0                	cmp    %edx,%eax
 626:	73 10                	jae    638 <free+0x38>
{
 628:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62a:	39 c8                	cmp    %ecx,%eax
 62c:	8b 10                	mov    (%eax),%edx
 62e:	72 f0                	jb     620 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 630:	39 d0                	cmp    %edx,%eax
 632:	72 f4                	jb     628 <free+0x28>
 634:	39 d1                	cmp    %edx,%ecx
 636:	73 f0                	jae    628 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 638:	8b 73 fc             	mov    -0x4(%ebx),%esi
 63b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 63e:	39 fa                	cmp    %edi,%edx
 640:	74 1e                	je     660 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 642:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 645:	8b 50 04             	mov    0x4(%eax),%edx
 648:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 64b:	39 f1                	cmp    %esi,%ecx
 64d:	74 2a                	je     679 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 64f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 651:	5b                   	pop    %ebx
  freep = p;
 652:	a3 24 0a 00 00       	mov    %eax,0xa24
}
 657:	5e                   	pop    %esi
 658:	5f                   	pop    %edi
 659:	5d                   	pop    %ebp
 65a:	c3                   	ret    
 65b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 660:	8b 7a 04             	mov    0x4(%edx),%edi
 663:	01 fe                	add    %edi,%esi
 665:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 668:	8b 10                	mov    (%eax),%edx
 66a:	8b 12                	mov    (%edx),%edx
 66c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 66f:	8b 50 04             	mov    0x4(%eax),%edx
 672:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 675:	39 f1                	cmp    %esi,%ecx
 677:	75 d6                	jne    64f <free+0x4f>
  freep = p;
 679:	a3 24 0a 00 00       	mov    %eax,0xa24
    p->s.size += bp->s.size;
 67e:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 681:	01 ca                	add    %ecx,%edx
 683:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 686:	8b 53 f8             	mov    -0x8(%ebx),%edx
 689:	89 10                	mov    %edx,(%eax)
}
 68b:	5b                   	pop    %ebx
 68c:	5e                   	pop    %esi
 68d:	5f                   	pop    %edi
 68e:	5d                   	pop    %ebp
 68f:	c3                   	ret    

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 69c:	8b 3d 24 0a 00 00    	mov    0xa24,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	8d 70 07             	lea    0x7(%eax),%esi
 6a5:	c1 ee 03             	shr    $0x3,%esi
 6a8:	46                   	inc    %esi
  if((prevp = freep) == 0){
 6a9:	85 ff                	test   %edi,%edi
 6ab:	0f 84 9f 00 00 00    	je     750 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b1:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 6b3:	8b 48 04             	mov    0x4(%eax),%ecx
 6b6:	39 f1                	cmp    %esi,%ecx
 6b8:	73 6c                	jae    726 <malloc+0x96>
 6ba:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6c0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6c5:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6c8:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6cf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6d2:	eb 1d                	jmp    6f1 <malloc+0x61>
 6d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6e2:	8b 4a 04             	mov    0x4(%edx),%ecx
 6e5:	39 f1                	cmp    %esi,%ecx
 6e7:	73 47                	jae    730 <malloc+0xa0>
 6e9:	8b 3d 24 0a 00 00    	mov    0xa24,%edi
 6ef:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f1:	39 c7                	cmp    %eax,%edi
 6f3:	75 eb                	jne    6e0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 6f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6f8:	89 04 24             	mov    %eax,(%esp)
 6fb:	e8 1b fc ff ff       	call   31b <sbrk>
  if(p == (char*)-1)
 700:	83 f8 ff             	cmp    $0xffffffff,%eax
 703:	74 17                	je     71c <malloc+0x8c>
  hp->s.size = nu;
 705:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 708:	83 c0 08             	add    $0x8,%eax
 70b:	89 04 24             	mov    %eax,(%esp)
 70e:	e8 ed fe ff ff       	call   600 <free>
  return freep;
 713:	a1 24 0a 00 00       	mov    0xa24,%eax
      if((p = morecore(nunits)) == 0)
 718:	85 c0                	test   %eax,%eax
 71a:	75 c4                	jne    6e0 <malloc+0x50>
        return 0;
  }
}
 71c:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 71f:	31 c0                	xor    %eax,%eax
}
 721:	5b                   	pop    %ebx
 722:	5e                   	pop    %esi
 723:	5f                   	pop    %edi
 724:	5d                   	pop    %ebp
 725:	c3                   	ret    
    if(p->s.size >= nunits){
 726:	89 c2                	mov    %eax,%edx
 728:	89 f8                	mov    %edi,%eax
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 730:	39 ce                	cmp    %ecx,%esi
 732:	74 4c                	je     780 <malloc+0xf0>
        p->s.size -= nunits;
 734:	29 f1                	sub    %esi,%ecx
 736:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 739:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 73c:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 73f:	a3 24 0a 00 00       	mov    %eax,0xa24
      return (void*)(p + 1);
 744:	8d 42 08             	lea    0x8(%edx),%eax
}
 747:	83 c4 2c             	add    $0x2c,%esp
 74a:	5b                   	pop    %ebx
 74b:	5e                   	pop    %esi
 74c:	5f                   	pop    %edi
 74d:	5d                   	pop    %ebp
 74e:	c3                   	ret    
 74f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 750:	b8 28 0a 00 00       	mov    $0xa28,%eax
 755:	ba 28 0a 00 00       	mov    $0xa28,%edx
 75a:	a3 24 0a 00 00       	mov    %eax,0xa24
    base.s.size = 0;
 75f:	31 c9                	xor    %ecx,%ecx
 761:	bf 28 0a 00 00       	mov    $0xa28,%edi
    base.s.ptr = freep = prevp = &base;
 766:	89 15 28 0a 00 00    	mov    %edx,0xa28
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 76c:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 76e:	89 0d 2c 0a 00 00    	mov    %ecx,0xa2c
    if(p->s.size >= nunits){
 774:	e9 41 ff ff ff       	jmp    6ba <malloc+0x2a>
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 780:	8b 0a                	mov    (%edx),%ecx
 782:	89 08                	mov    %ecx,(%eax)
 784:	eb b9                	jmp    73f <malloc+0xaf>
