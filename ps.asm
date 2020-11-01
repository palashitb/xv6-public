
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
    pls();
   6:	e8 18 03 00 00       	call   323 <pls>
    exit();
   b:	e8 63 02 00 00       	call   273 <exit>

00000010 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  10:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  11:	31 c0                	xor    %eax,%eax
{
  13:	89 e5                	mov    %esp,%ebp
  15:	53                   	push   %ebx
  16:	8b 4d 08             	mov    0x8(%ebp),%ecx
  19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  27:	40                   	inc    %eax
  28:	84 d2                	test   %dl,%dl
  2a:	75 f4                	jne    20 <strcpy+0x10>
    ;
  return os;
}
  2c:	5b                   	pop    %ebx
  2d:	89 c8                	mov    %ecx,%eax
  2f:	5d                   	pop    %ebp
  30:	c3                   	ret    
  31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  3f:	90                   	nop

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  44:	8b 5d 08             	mov    0x8(%ebp),%ebx
  47:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  4a:	0f b6 03             	movzbl (%ebx),%eax
  4d:	0f b6 0a             	movzbl (%edx),%ecx
  50:	84 c0                	test   %al,%al
  52:	75 19                	jne    6d <strcmp+0x2d>
  54:	eb 2a                	jmp    80 <strcmp+0x40>
  56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5d:	8d 76 00             	lea    0x0(%esi),%esi
  60:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
  64:	43                   	inc    %ebx
  65:	42                   	inc    %edx
  while(*p && *p == *q)
  66:	0f b6 0a             	movzbl (%edx),%ecx
  69:	84 c0                	test   %al,%al
  6b:	74 13                	je     80 <strcmp+0x40>
  6d:	38 c8                	cmp    %cl,%al
  6f:	74 ef                	je     60 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  71:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  72:	29 c8                	sub    %ecx,%eax
}
  74:	5d                   	pop    %ebp
  75:	c3                   	ret    
  76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  7d:	8d 76 00             	lea    0x0(%esi),%esi
  80:	5b                   	pop    %ebx
  81:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  83:	29 c8                	sub    %ecx,%eax
}
  85:	5d                   	pop    %ebp
  86:	c3                   	ret    
  87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8e:	66 90                	xchg   %ax,%ax

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  96:	80 3a 00             	cmpb   $0x0,(%edx)
  99:	74 15                	je     b0 <strlen+0x20>
  9b:	31 c0                	xor    %eax,%eax
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	40                   	inc    %eax
  a1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  a5:	89 c1                	mov    %eax,%ecx
  a7:	75 f7                	jne    a0 <strlen+0x10>
    ;
  return n;
}
  a9:	5d                   	pop    %ebp
  aa:	89 c8                	mov    %ecx,%eax
  ac:	c3                   	ret    
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
  b1:	31 c9                	xor    %ecx,%ecx
}
  b3:	89 c8                	mov    %ecx,%eax
  b5:	c3                   	ret    
  b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bd:	8d 76 00             	lea    0x0(%esi),%esi

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	89 d7                	mov    %edx,%edi
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	5f                   	pop    %edi
  d3:	89 d0                	mov    %edx,%eax
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  de:	66 90                	xchg   %ax,%ax

000000e0 <strchr>:

char*
strchr(const char *s, char c)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  ea:	0f b6 10             	movzbl (%eax),%edx
  ed:	84 d2                	test   %dl,%dl
  ef:	75 18                	jne    109 <strchr+0x29>
  f1:	eb 1d                	jmp    110 <strchr+0x30>
  f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 100:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 104:	40                   	inc    %eax
 105:	84 d2                	test   %dl,%dl
 107:	74 07                	je     110 <strchr+0x30>
    if(*s == c)
 109:	38 d1                	cmp    %dl,%cl
 10b:	75 f3                	jne    100 <strchr+0x20>
      return (char*)s;
  return 0;
}
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    
 10f:	90                   	nop
 110:	5d                   	pop    %ebp
  return 0;
 111:	31 c0                	xor    %eax,%eax
}
 113:	c3                   	ret    
 114:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 11f:	90                   	nop

00000120 <gets>:

char*
gets(char *buf, int max)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
 125:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 126:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 128:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 12b:	83 ec 3c             	sub    $0x3c,%esp
 12e:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 131:	eb 3a                	jmp    16d <gets+0x4d>
 133:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 140:	89 7c 24 04          	mov    %edi,0x4(%esp)
 144:	ba 01 00 00 00       	mov    $0x1,%edx
 149:	89 54 24 08          	mov    %edx,0x8(%esp)
 14d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 154:	e8 32 01 00 00       	call   28b <read>
    if(cc < 1)
 159:	85 c0                	test   %eax,%eax
 15b:	7e 19                	jle    176 <gets+0x56>
      break;
    buf[i++] = c;
 15d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 161:	46                   	inc    %esi
 162:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 165:	3c 0a                	cmp    $0xa,%al
 167:	74 27                	je     190 <gets+0x70>
 169:	3c 0d                	cmp    $0xd,%al
 16b:	74 23                	je     190 <gets+0x70>
  for(i=0; i+1 < max; ){
 16d:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 170:	43                   	inc    %ebx
 171:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 174:	7c ca                	jl     140 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 176:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 179:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	83 c4 3c             	add    $0x3c,%esp
 182:	5b                   	pop    %ebx
 183:	5e                   	pop    %esi
 184:	5f                   	pop    %edi
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18e:	66 90                	xchg   %ax,%ax
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	01 c3                	add    %eax,%ebx
 195:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 198:	eb dc                	jmp    176 <gets+0x56>
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a1:	31 c0                	xor    %eax,%eax
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 1a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
{
 1af:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1b2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1b5:	89 04 24             	mov    %eax,(%esp)
 1b8:	e8 f6 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1bd:	85 c0                	test   %eax,%eax
 1bf:	78 2f                	js     1f0 <stat+0x50>
 1c1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c6:	89 1c 24             	mov    %ebx,(%esp)
 1c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cd:	e8 f9 00 00 00       	call   2cb <fstat>
  close(fd);
 1d2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1d5:	89 c6                	mov    %eax,%esi
  close(fd);
 1d7:	e8 bf 00 00 00       	call   29b <close>
  return r;
}
 1dc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1df:	89 f0                	mov    %esi,%eax
 1e1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1e4:	89 ec                	mov    %ebp,%esp
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret    
 1e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb e5                	jmp    1dc <stat+0x3c>
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 02             	movsbl (%edx),%eax
 20a:	88 c1                	mov    %al,%cl
 20c:	80 e9 30             	sub    $0x30,%cl
 20f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 212:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 217:	77 1c                	ja     235 <atoi+0x35>
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 220:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 223:	42                   	inc    %edx
 224:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 228:	0f be 02             	movsbl (%edx),%eax
 22b:	88 c3                	mov    %al,%bl
 22d:	80 eb 30             	sub    $0x30,%bl
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	5b                   	pop    %ebx
 236:	89 c8                	mov    %ecx,%eax
 238:	5d                   	pop    %ebp
 239:	c3                   	ret    
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 45 10             	mov    0x10(%ebp),%eax
 247:	56                   	push   %esi
 248:	8b 55 08             	mov    0x8(%ebp),%edx
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 c0                	test   %eax,%eax
 250:	7e 13                	jle    265 <memmove+0x25>
 252:	01 d0                	add    %edx,%eax
  dst = vdst;
 254:	89 d7                	mov    %edx,%edi
 256:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <uptime>:
SYSCALL(uptime)
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <waitx>:
SYSCALL(waitx)
 313:	b8 16 00 00 00       	mov    $0x16,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <set_priority>:
SYSCALL(set_priority)
 31b:	b8 17 00 00 00       	mov    $0x17,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <pls>:
SYSCALL(pls)
 323:	b8 18 00 00 00       	mov    $0x18,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    
 32b:	66 90                	xchg   %ax,%ax
 32d:	66 90                	xchg   %ax,%ax
 32f:	90                   	nop

00000330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	89 cf                	mov    %ecx,%edi
 336:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 337:	89 d1                	mov    %edx,%ecx
{
 339:	53                   	push   %ebx
 33a:	83 ec 4c             	sub    $0x4c,%esp
 33d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 340:	89 d0                	mov    %edx,%eax
 342:	c1 e8 1f             	shr    $0x1f,%eax
 345:	84 c0                	test   %al,%al
 347:	0f 84 a3 00 00 00    	je     3f0 <printint+0xc0>
 34d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 351:	0f 84 99 00 00 00    	je     3f0 <printint+0xc0>
    neg = 1;
 357:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 35e:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 360:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 367:	8d 75 d7             	lea    -0x29(%ebp),%esi
 36a:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 36d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 370:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 373:	31 d2                	xor    %edx,%edx
 375:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 378:	f7 f7                	div    %edi
 37a:	8d 4b 01             	lea    0x1(%ebx),%ecx
 37d:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 380:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 383:	39 cf                	cmp    %ecx,%edi
 385:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 388:	0f b6 92 70 07 00 00 	movzbl 0x770(%edx),%edx
 38f:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 393:	76 db                	jbe    370 <printint+0x40>
  if(neg)
 395:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 398:	85 c9                	test   %ecx,%ecx
 39a:	74 0c                	je     3a8 <printint+0x78>
    buf[i++] = '-';
 39c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 39f:	b2 2d                	mov    $0x2d,%dl
 3a1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 3a6:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 3a8:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3ab:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 3af:	eb 13                	jmp    3c4 <printint+0x94>
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3bf:	90                   	nop
 3c0:	0f b6 13             	movzbl (%ebx),%edx
 3c3:	4b                   	dec    %ebx
  write(fd, &c, 1);
 3c4:	89 74 24 04          	mov    %esi,0x4(%esp)
 3c8:	b8 01 00 00 00       	mov    $0x1,%eax
 3cd:	89 44 24 08          	mov    %eax,0x8(%esp)
 3d1:	89 3c 24             	mov    %edi,(%esp)
 3d4:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3d7:	e8 b7 fe ff ff       	call   293 <write>
  while(--i >= 0)
 3dc:	39 de                	cmp    %ebx,%esi
 3de:	75 e0                	jne    3c0 <printint+0x90>
    putc(fd, buf[i]);
}
 3e0:	83 c4 4c             	add    $0x4c,%esp
 3e3:	5b                   	pop    %ebx
 3e4:	5e                   	pop    %esi
 3e5:	5f                   	pop    %edi
 3e6:	5d                   	pop    %ebp
 3e7:	c3                   	ret    
 3e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ef:	90                   	nop
  neg = 0;
 3f0:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 3f7:	e9 64 ff ff ff       	jmp    360 <printint+0x30>
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000400 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 409:	8b 75 0c             	mov    0xc(%ebp),%esi
 40c:	0f b6 1e             	movzbl (%esi),%ebx
 40f:	84 db                	test   %bl,%bl
 411:	0f 84 c8 00 00 00    	je     4df <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 417:	8d 45 10             	lea    0x10(%ebp),%eax
 41a:	46                   	inc    %esi
 41b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 41e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 421:	31 d2                	xor    %edx,%edx
 423:	eb 3e                	jmp    463 <printf+0x63>
 425:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 430:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 433:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 436:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 43b:	74 1e                	je     45b <printf+0x5b>
  write(fd, &c, 1);
 43d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 441:	b8 01 00 00 00       	mov    $0x1,%eax
 446:	89 44 24 08          	mov    %eax,0x8(%esp)
 44a:	8b 45 08             	mov    0x8(%ebp),%eax
 44d:	88 5d e7             	mov    %bl,-0x19(%ebp)
 450:	89 04 24             	mov    %eax,(%esp)
 453:	e8 3b fe ff ff       	call   293 <write>
 458:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 45b:	0f b6 1e             	movzbl (%esi),%ebx
 45e:	46                   	inc    %esi
 45f:	84 db                	test   %bl,%bl
 461:	74 7c                	je     4df <printf+0xdf>
    if(state == 0){
 463:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 465:	0f be cb             	movsbl %bl,%ecx
 468:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 46b:	74 c3                	je     430 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 46d:	83 fa 25             	cmp    $0x25,%edx
 470:	75 e9                	jne    45b <printf+0x5b>
      if(c == 'd'){
 472:	83 f8 64             	cmp    $0x64,%eax
 475:	0f 84 a5 00 00 00    	je     520 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 47b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 481:	83 f9 70             	cmp    $0x70,%ecx
 484:	74 6a                	je     4f0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 486:	83 f8 73             	cmp    $0x73,%eax
 489:	0f 84 e1 00 00 00    	je     570 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48f:	83 f8 63             	cmp    $0x63,%eax
 492:	0f 84 98 00 00 00    	je     530 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 498:	83 f8 25             	cmp    $0x25,%eax
 49b:	74 1c                	je     4b9 <printf+0xb9>
  write(fd, &c, 1);
 49d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4a1:	8b 45 08             	mov    0x8(%ebp),%eax
 4a4:	ba 01 00 00 00       	mov    $0x1,%edx
 4a9:	89 54 24 08          	mov    %edx,0x8(%esp)
 4ad:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4b1:	89 04 24             	mov    %eax,(%esp)
 4b4:	e8 da fd ff ff       	call   293 <write>
 4b9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4bd:	b8 01 00 00 00       	mov    $0x1,%eax
 4c2:	46                   	inc    %esi
 4c3:	89 44 24 08          	mov    %eax,0x8(%esp)
 4c7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ca:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4cd:	89 04 24             	mov    %eax,(%esp)
 4d0:	e8 be fd ff ff       	call   293 <write>
  for(i = 0; fmt[i]; i++){
 4d5:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4db:	84 db                	test   %bl,%bl
 4dd:	75 84                	jne    463 <printf+0x63>
    }
  }
}
 4df:	83 c4 3c             	add    $0x3c,%esp
 4e2:	5b                   	pop    %ebx
 4e3:	5e                   	pop    %esi
 4e4:	5f                   	pop    %edi
 4e5:	5d                   	pop    %ebp
 4e6:	c3                   	ret    
 4e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ee:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4f7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4fc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4ff:	8b 45 08             	mov    0x8(%ebp),%eax
 502:	8b 13                	mov    (%ebx),%edx
 504:	e8 27 fe ff ff       	call   330 <printint>
        ap++;
 509:	89 d8                	mov    %ebx,%eax
      state = 0;
 50b:	31 d2                	xor    %edx,%edx
        ap++;
 50d:	83 c0 04             	add    $0x4,%eax
 510:	89 45 d0             	mov    %eax,-0x30(%ebp)
 513:	e9 43 ff ff ff       	jmp    45b <printf+0x5b>
 518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop
        printint(fd, *ap, 10, 1);
 520:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 527:	b9 0a 00 00 00       	mov    $0xa,%ecx
 52c:	eb ce                	jmp    4fc <printf+0xfc>
 52e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 530:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 533:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 538:	8b 03                	mov    (%ebx),%eax
        ap++;
 53a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 53d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 541:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 545:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 548:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 54c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 54f:	8b 45 08             	mov    0x8(%ebp),%eax
 552:	89 04 24             	mov    %eax,(%esp)
 555:	e8 39 fd ff ff       	call   293 <write>
      state = 0;
 55a:	31 d2                	xor    %edx,%edx
        ap++;
 55c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 55f:	e9 f7 fe ff ff       	jmp    45b <printf+0x5b>
 564:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 56f:	90                   	nop
        s = (char*)*ap;
 570:	8b 45 d0             	mov    -0x30(%ebp),%eax
 573:	8b 18                	mov    (%eax),%ebx
        ap++;
 575:	83 c0 04             	add    $0x4,%eax
 578:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 57b:	85 db                	test   %ebx,%ebx
 57d:	74 11                	je     590 <printf+0x190>
        while(*s != 0){
 57f:	0f b6 03             	movzbl (%ebx),%eax
 582:	84 c0                	test   %al,%al
 584:	74 44                	je     5ca <printf+0x1ca>
 586:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 589:	89 de                	mov    %ebx,%esi
 58b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 58e:	eb 10                	jmp    5a0 <printf+0x1a0>
 590:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 593:	bb 68 07 00 00       	mov    $0x768,%ebx
        while(*s != 0){
 598:	b0 28                	mov    $0x28,%al
 59a:	89 de                	mov    %ebx,%esi
 59c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 59f:	90                   	nop
          putc(fd, *s);
 5a0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 5a8:	46                   	inc    %esi
  write(fd, &c, 1);
 5a9:	89 44 24 08          	mov    %eax,0x8(%esp)
 5ad:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5b1:	89 1c 24             	mov    %ebx,(%esp)
 5b4:	e8 da fc ff ff       	call   293 <write>
        while(*s != 0){
 5b9:	0f b6 06             	movzbl (%esi),%eax
 5bc:	84 c0                	test   %al,%al
 5be:	75 e0                	jne    5a0 <printf+0x1a0>
 5c0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 5c3:	31 d2                	xor    %edx,%edx
 5c5:	e9 91 fe ff ff       	jmp    45b <printf+0x5b>
 5ca:	31 d2                	xor    %edx,%edx
 5cc:	e9 8a fe ff ff       	jmp    45b <printf+0x5b>
 5d1:	66 90                	xchg   %ax,%ax
 5d3:	66 90                	xchg   %ax,%ax
 5d5:	66 90                	xchg   %ax,%ax
 5d7:	66 90                	xchg   %ax,%ax
 5d9:	66 90                	xchg   %ax,%ax
 5db:	66 90                	xchg   %ax,%ax
 5dd:	66 90                	xchg   %ax,%ax
 5df:	90                   	nop

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 04 0a 00 00       	mov    0xa04,%eax
{
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ee:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 5f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f3:	39 c8                	cmp    %ecx,%eax
 5f5:	73 19                	jae    610 <free+0x30>
 5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fe:	66 90                	xchg   %ax,%ax
 600:	39 d1                	cmp    %edx,%ecx
 602:	72 14                	jb     618 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 604:	39 d0                	cmp    %edx,%eax
 606:	73 10                	jae    618 <free+0x38>
{
 608:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60a:	39 c8                	cmp    %ecx,%eax
 60c:	8b 10                	mov    (%eax),%edx
 60e:	72 f0                	jb     600 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 610:	39 d0                	cmp    %edx,%eax
 612:	72 f4                	jb     608 <free+0x28>
 614:	39 d1                	cmp    %edx,%ecx
 616:	73 f0                	jae    608 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 618:	8b 73 fc             	mov    -0x4(%ebx),%esi
 61b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 61e:	39 fa                	cmp    %edi,%edx
 620:	74 1e                	je     640 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 622:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 625:	8b 50 04             	mov    0x4(%eax),%edx
 628:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 62b:	39 f1                	cmp    %esi,%ecx
 62d:	74 2a                	je     659 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 62f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 631:	5b                   	pop    %ebx
  freep = p;
 632:	a3 04 0a 00 00       	mov    %eax,0xa04
}
 637:	5e                   	pop    %esi
 638:	5f                   	pop    %edi
 639:	5d                   	pop    %ebp
 63a:	c3                   	ret    
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 640:	8b 7a 04             	mov    0x4(%edx),%edi
 643:	01 fe                	add    %edi,%esi
 645:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 648:	8b 10                	mov    (%eax),%edx
 64a:	8b 12                	mov    (%edx),%edx
 64c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 64f:	8b 50 04             	mov    0x4(%eax),%edx
 652:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 655:	39 f1                	cmp    %esi,%ecx
 657:	75 d6                	jne    62f <free+0x4f>
  freep = p;
 659:	a3 04 0a 00 00       	mov    %eax,0xa04
    p->s.size += bp->s.size;
 65e:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 661:	01 ca                	add    %ecx,%edx
 663:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 666:	8b 53 f8             	mov    -0x8(%ebx),%edx
 669:	89 10                	mov    %edx,(%eax)
}
 66b:	5b                   	pop    %ebx
 66c:	5e                   	pop    %esi
 66d:	5f                   	pop    %edi
 66e:	5d                   	pop    %ebp
 66f:	c3                   	ret    

00000670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 67c:	8b 3d 04 0a 00 00    	mov    0xa04,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 682:	8d 70 07             	lea    0x7(%eax),%esi
 685:	c1 ee 03             	shr    $0x3,%esi
 688:	46                   	inc    %esi
  if((prevp = freep) == 0){
 689:	85 ff                	test   %edi,%edi
 68b:	0f 84 9f 00 00 00    	je     730 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 691:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 693:	8b 48 04             	mov    0x4(%eax),%ecx
 696:	39 f1                	cmp    %esi,%ecx
 698:	73 6c                	jae    706 <malloc+0x96>
 69a:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6a0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6a5:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6a8:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6af:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6b2:	eb 1d                	jmp    6d1 <malloc+0x61>
 6b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6c2:	8b 4a 04             	mov    0x4(%edx),%ecx
 6c5:	39 f1                	cmp    %esi,%ecx
 6c7:	73 47                	jae    710 <malloc+0xa0>
 6c9:	8b 3d 04 0a 00 00    	mov    0xa04,%edi
 6cf:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6d1:	39 c7                	cmp    %eax,%edi
 6d3:	75 eb                	jne    6c0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 6d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d8:	89 04 24             	mov    %eax,(%esp)
 6db:	e8 1b fc ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 6e0:	83 f8 ff             	cmp    $0xffffffff,%eax
 6e3:	74 17                	je     6fc <malloc+0x8c>
  hp->s.size = nu;
 6e5:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6e8:	83 c0 08             	add    $0x8,%eax
 6eb:	89 04 24             	mov    %eax,(%esp)
 6ee:	e8 ed fe ff ff       	call   5e0 <free>
  return freep;
 6f3:	a1 04 0a 00 00       	mov    0xa04,%eax
      if((p = morecore(nunits)) == 0)
 6f8:	85 c0                	test   %eax,%eax
 6fa:	75 c4                	jne    6c0 <malloc+0x50>
        return 0;
  }
}
 6fc:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 6ff:	31 c0                	xor    %eax,%eax
}
 701:	5b                   	pop    %ebx
 702:	5e                   	pop    %esi
 703:	5f                   	pop    %edi
 704:	5d                   	pop    %ebp
 705:	c3                   	ret    
    if(p->s.size >= nunits){
 706:	89 c2                	mov    %eax,%edx
 708:	89 f8                	mov    %edi,%eax
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 710:	39 ce                	cmp    %ecx,%esi
 712:	74 4c                	je     760 <malloc+0xf0>
        p->s.size -= nunits;
 714:	29 f1                	sub    %esi,%ecx
 716:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 719:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 71c:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 71f:	a3 04 0a 00 00       	mov    %eax,0xa04
      return (void*)(p + 1);
 724:	8d 42 08             	lea    0x8(%edx),%eax
}
 727:	83 c4 2c             	add    $0x2c,%esp
 72a:	5b                   	pop    %ebx
 72b:	5e                   	pop    %esi
 72c:	5f                   	pop    %edi
 72d:	5d                   	pop    %ebp
 72e:	c3                   	ret    
 72f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 730:	b8 08 0a 00 00       	mov    $0xa08,%eax
 735:	ba 08 0a 00 00       	mov    $0xa08,%edx
 73a:	a3 04 0a 00 00       	mov    %eax,0xa04
    base.s.size = 0;
 73f:	31 c9                	xor    %ecx,%ecx
 741:	bf 08 0a 00 00       	mov    $0xa08,%edi
    base.s.ptr = freep = prevp = &base;
 746:	89 15 08 0a 00 00    	mov    %edx,0xa08
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 74c:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 74e:	89 0d 0c 0a 00 00    	mov    %ecx,0xa0c
    if(p->s.size >= nunits){
 754:	e9 41 ff ff ff       	jmp    69a <malloc+0x2a>
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 760:	8b 0a                	mov    (%edx),%ecx
 762:	89 08                	mov    %ecx,(%eax)
 764:	eb b9                	jmp    71f <malloc+0xaf>
