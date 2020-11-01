
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp
   b:	8b 45 08             	mov    0x8(%ebp),%eax
   e:	8b 55 0c             	mov    0xc(%ebp),%edx
  int i;

  for(i = 1; i < argc; i++)
  11:	83 f8 01             	cmp    $0x1,%eax
  14:	7e 68                	jle    7e <main+0x7e>
  16:	8d 5a 04             	lea    0x4(%edx),%ebx
  19:	8d 34 82             	lea    (%edx,%eax,4),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1c:	83 c3 04             	add    $0x4,%ebx
  1f:	8b 43 fc             	mov    -0x4(%ebx),%eax
  22:	39 f3                	cmp    %esi,%ebx
  24:	74 36                	je     5c <main+0x5c>
  26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2d:	8d 76 00             	lea    0x0(%esi),%esi
  30:	89 44 24 08          	mov    %eax,0x8(%esp)
  34:	ba e8 07 00 00       	mov    $0x7e8,%edx
  39:	b9 ea 07 00 00       	mov    $0x7ea,%ecx
  3e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  42:	83 c3 04             	add    $0x4,%ebx
  45:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  50:	e8 2b 04 00 00       	call   480 <printf>
  55:	39 f3                	cmp    %esi,%ebx
  57:	8b 43 fc             	mov    -0x4(%ebx),%eax
  5a:	75 d4                	jne    30 <main+0x30>
  5c:	89 44 24 08          	mov    %eax,0x8(%esp)
  60:	ba ef 07 00 00       	mov    $0x7ef,%edx
  65:	b9 ea 07 00 00       	mov    $0x7ea,%ecx
  6a:	89 54 24 0c          	mov    %edx,0xc(%esp)
  6e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  72:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  79:	e8 02 04 00 00       	call   480 <printf>
  exit();
  7e:	e8 70 02 00 00       	call   2f3 <exit>
  83:	66 90                	xchg   %ax,%ax
  85:	66 90                	xchg   %ax,%ax
  87:	66 90                	xchg   %ax,%ax
  89:	66 90                	xchg   %ax,%ax
  8b:	66 90                	xchg   %ax,%ax
  8d:	66 90                	xchg   %ax,%ax
  8f:	90                   	nop

00000090 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  90:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  91:	31 c0                	xor    %eax,%eax
{
  93:	89 e5                	mov    %esp,%ebp
  95:	53                   	push   %ebx
  96:	8b 4d 08             	mov    0x8(%ebp),%ecx
  99:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  a7:	40                   	inc    %eax
  a8:	84 d2                	test   %dl,%dl
  aa:	75 f4                	jne    a0 <strcpy+0x10>
    ;
  return os;
}
  ac:	5b                   	pop    %ebx
  ad:	89 c8                	mov    %ecx,%eax
  af:	5d                   	pop    %ebp
  b0:	c3                   	ret    
  b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bf:	90                   	nop

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	53                   	push   %ebx
  c4:	8b 5d 08             	mov    0x8(%ebp),%ebx
  c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ca:	0f b6 03             	movzbl (%ebx),%eax
  cd:	0f b6 0a             	movzbl (%edx),%ecx
  d0:	84 c0                	test   %al,%al
  d2:	75 19                	jne    ed <strcmp+0x2d>
  d4:	eb 2a                	jmp    100 <strcmp+0x40>
  d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
  e4:	43                   	inc    %ebx
  e5:	42                   	inc    %edx
  while(*p && *p == *q)
  e6:	0f b6 0a             	movzbl (%edx),%ecx
  e9:	84 c0                	test   %al,%al
  eb:	74 13                	je     100 <strcmp+0x40>
  ed:	38 c8                	cmp    %cl,%al
  ef:	74 ef                	je     e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
  f1:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
  f2:	29 c8                	sub    %ecx,%eax
}
  f4:	5d                   	pop    %ebp
  f5:	c3                   	ret    
  f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	5b                   	pop    %ebx
 101:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 103:	29 c8                	sub    %ecx,%eax
}
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10e:	66 90                	xchg   %ax,%ax

00000110 <strlen>:

uint
strlen(const char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 3a 00             	cmpb   $0x0,(%edx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 c0                	xor    %eax,%eax
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	40                   	inc    %eax
 121:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 125:	89 c1                	mov    %eax,%ecx
 127:	75 f7                	jne    120 <strlen+0x10>
    ;
  return n;
}
 129:	5d                   	pop    %ebp
 12a:	89 c8                	mov    %ecx,%eax
 12c:	c3                   	ret    
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 131:	31 c9                	xor    %ecx,%ecx
}
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret    
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 55 08             	mov    0x8(%ebp),%edx
 146:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld    
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	5f                   	pop    %edi
 153:	89 d0                	mov    %edx,%eax
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15e:	66 90                	xchg   %ax,%ax

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 18                	jne    189 <strchr+0x29>
 171:	eb 1d                	jmp    190 <strchr+0x30>
 173:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 184:	40                   	inc    %eax
 185:	84 d2                	test   %dl,%dl
 187:	74 07                	je     190 <strchr+0x30>
    if(*s == c)
 189:	38 d1                	cmp    %dl,%cl
 18b:	75 f3                	jne    180 <strchr+0x20>
      return (char*)s;
  return 0;
}
 18d:	5d                   	pop    %ebp
 18e:	c3                   	ret    
 18f:	90                   	nop
 190:	5d                   	pop    %ebp
  return 0;
 191:	31 c0                	xor    %eax,%eax
}
 193:	c3                   	ret    
 194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
 1a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 1a8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1ab:	83 ec 3c             	sub    $0x3c,%esp
 1ae:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 1b1:	eb 3a                	jmp    1ed <gets+0x4d>
 1b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1c0:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1c4:	ba 01 00 00 00       	mov    $0x1,%edx
 1c9:	89 54 24 08          	mov    %edx,0x8(%esp)
 1cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1d4:	e8 32 01 00 00       	call   30b <read>
    if(cc < 1)
 1d9:	85 c0                	test   %eax,%eax
 1db:	7e 19                	jle    1f6 <gets+0x56>
      break;
    buf[i++] = c;
 1dd:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1e1:	46                   	inc    %esi
 1e2:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 1e5:	3c 0a                	cmp    $0xa,%al
 1e7:	74 27                	je     210 <gets+0x70>
 1e9:	3c 0d                	cmp    $0xd,%al
 1eb:	74 23                	je     210 <gets+0x70>
  for(i=0; i+1 < max; ){
 1ed:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 1f0:	43                   	inc    %ebx
 1f1:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1f4:	7c ca                	jl     1c0 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 1f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1f9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	83 c4 3c             	add    $0x3c,%esp
 202:	5b                   	pop    %ebx
 203:	5e                   	pop    %esi
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	01 c3                	add    %eax,%ebx
 215:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 218:	eb dc                	jmp    1f6 <gets+0x56>
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000220 <stat>:

int
stat(const char *n, struct stat *st)
{
 220:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 221:	31 c0                	xor    %eax,%eax
{
 223:	89 e5                	mov    %esp,%ebp
 225:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 228:	89 44 24 04          	mov    %eax,0x4(%esp)
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 22f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 232:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 235:	89 04 24             	mov    %eax,(%esp)
 238:	e8 f6 00 00 00       	call   333 <open>
  if(fd < 0)
 23d:	85 c0                	test   %eax,%eax
 23f:	78 2f                	js     270 <stat+0x50>
 241:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 243:	8b 45 0c             	mov    0xc(%ebp),%eax
 246:	89 1c 24             	mov    %ebx,(%esp)
 249:	89 44 24 04          	mov    %eax,0x4(%esp)
 24d:	e8 f9 00 00 00       	call   34b <fstat>
  close(fd);
 252:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 255:	89 c6                	mov    %eax,%esi
  close(fd);
 257:	e8 bf 00 00 00       	call   31b <close>
  return r;
}
 25c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 25f:	89 f0                	mov    %esi,%eax
 261:	8b 75 fc             	mov    -0x4(%ebp),%esi
 264:	89 ec                	mov    %ebp,%esp
 266:	5d                   	pop    %ebp
 267:	c3                   	ret    
 268:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26f:	90                   	nop
    return -1;
 270:	be ff ff ff ff       	mov    $0xffffffff,%esi
 275:	eb e5                	jmp    25c <stat+0x3c>
 277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27e:	66 90                	xchg   %ax,%ax

00000280 <atoi>:

int
atoi(const char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	53                   	push   %ebx
 284:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 287:	0f be 02             	movsbl (%edx),%eax
 28a:	88 c1                	mov    %al,%cl
 28c:	80 e9 30             	sub    $0x30,%cl
 28f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 292:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 297:	77 1c                	ja     2b5 <atoi+0x35>
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 2a0:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2a3:	42                   	inc    %edx
 2a4:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2a8:	0f be 02             	movsbl (%edx),%eax
 2ab:	88 c3                	mov    %al,%bl
 2ad:	80 eb 30             	sub    $0x30,%bl
 2b0:	80 fb 09             	cmp    $0x9,%bl
 2b3:	76 eb                	jbe    2a0 <atoi+0x20>
  return n;
}
 2b5:	5b                   	pop    %ebx
 2b6:	89 c8                	mov    %ecx,%eax
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	57                   	push   %edi
 2c4:	8b 45 10             	mov    0x10(%ebp),%eax
 2c7:	56                   	push   %esi
 2c8:	8b 55 08             	mov    0x8(%ebp),%edx
 2cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ce:	85 c0                	test   %eax,%eax
 2d0:	7e 13                	jle    2e5 <memmove+0x25>
 2d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2d4:	89 d7                	mov    %edx,%edi
 2d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2e1:	39 f8                	cmp    %edi,%eax
 2e3:	75 fb                	jne    2e0 <memmove+0x20>
  return vdst;
}
 2e5:	5e                   	pop    %esi
 2e6:	89 d0                	mov    %edx,%eax
 2e8:	5f                   	pop    %edi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret    

000002eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2eb:	b8 01 00 00 00       	mov    $0x1,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <exit>:
SYSCALL(exit)
 2f3:	b8 02 00 00 00       	mov    $0x2,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <wait>:
SYSCALL(wait)
 2fb:	b8 03 00 00 00       	mov    $0x3,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <pipe>:
SYSCALL(pipe)
 303:	b8 04 00 00 00       	mov    $0x4,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <read>:
SYSCALL(read)
 30b:	b8 05 00 00 00       	mov    $0x5,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <write>:
SYSCALL(write)
 313:	b8 10 00 00 00       	mov    $0x10,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <close>:
SYSCALL(close)
 31b:	b8 15 00 00 00       	mov    $0x15,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <kill>:
SYSCALL(kill)
 323:	b8 06 00 00 00       	mov    $0x6,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <exec>:
SYSCALL(exec)
 32b:	b8 07 00 00 00       	mov    $0x7,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <open>:
SYSCALL(open)
 333:	b8 0f 00 00 00       	mov    $0xf,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <mknod>:
SYSCALL(mknod)
 33b:	b8 11 00 00 00       	mov    $0x11,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <unlink>:
SYSCALL(unlink)
 343:	b8 12 00 00 00       	mov    $0x12,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <fstat>:
SYSCALL(fstat)
 34b:	b8 08 00 00 00       	mov    $0x8,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <link>:
SYSCALL(link)
 353:	b8 13 00 00 00       	mov    $0x13,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <mkdir>:
SYSCALL(mkdir)
 35b:	b8 14 00 00 00       	mov    $0x14,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <chdir>:
SYSCALL(chdir)
 363:	b8 09 00 00 00       	mov    $0x9,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <dup>:
SYSCALL(dup)
 36b:	b8 0a 00 00 00       	mov    $0xa,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <getpid>:
SYSCALL(getpid)
 373:	b8 0b 00 00 00       	mov    $0xb,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <sbrk>:
SYSCALL(sbrk)
 37b:	b8 0c 00 00 00       	mov    $0xc,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <sleep>:
SYSCALL(sleep)
 383:	b8 0d 00 00 00       	mov    $0xd,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <uptime>:
SYSCALL(uptime)
 38b:	b8 0e 00 00 00       	mov    $0xe,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <waitx>:
SYSCALL(waitx)
 393:	b8 16 00 00 00       	mov    $0x16,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <set_priority>:
SYSCALL(set_priority)
 39b:	b8 17 00 00 00       	mov    $0x17,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <pls>:
SYSCALL(pls)
 3a3:	b8 18 00 00 00       	mov    $0x18,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    
 3ab:	66 90                	xchg   %ax,%ax
 3ad:	66 90                	xchg   %ax,%ax
 3af:	90                   	nop

000003b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	89 cf                	mov    %ecx,%edi
 3b6:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3b7:	89 d1                	mov    %edx,%ecx
{
 3b9:	53                   	push   %ebx
 3ba:	83 ec 4c             	sub    $0x4c,%esp
 3bd:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3c0:	89 d0                	mov    %edx,%eax
 3c2:	c1 e8 1f             	shr    $0x1f,%eax
 3c5:	84 c0                	test   %al,%al
 3c7:	0f 84 a3 00 00 00    	je     470 <printint+0xc0>
 3cd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3d1:	0f 84 99 00 00 00    	je     470 <printint+0xc0>
    neg = 1;
 3d7:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3de:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 3e0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 3e7:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3ea:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3f0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3f3:	31 d2                	xor    %edx,%edx
 3f5:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 3f8:	f7 f7                	div    %edi
 3fa:	8d 4b 01             	lea    0x1(%ebx),%ecx
 3fd:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 400:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 403:	39 cf                	cmp    %ecx,%edi
 405:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 408:	0f b6 92 f8 07 00 00 	movzbl 0x7f8(%edx),%edx
 40f:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 413:	76 db                	jbe    3f0 <printint+0x40>
  if(neg)
 415:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 418:	85 c9                	test   %ecx,%ecx
 41a:	74 0c                	je     428 <printint+0x78>
    buf[i++] = '-';
 41c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 41f:	b2 2d                	mov    $0x2d,%dl
 421:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 426:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 428:	8b 7d b8             	mov    -0x48(%ebp),%edi
 42b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 42f:	eb 13                	jmp    444 <printint+0x94>
 431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop
 440:	0f b6 13             	movzbl (%ebx),%edx
 443:	4b                   	dec    %ebx
  write(fd, &c, 1);
 444:	89 74 24 04          	mov    %esi,0x4(%esp)
 448:	b8 01 00 00 00       	mov    $0x1,%eax
 44d:	89 44 24 08          	mov    %eax,0x8(%esp)
 451:	89 3c 24             	mov    %edi,(%esp)
 454:	88 55 d7             	mov    %dl,-0x29(%ebp)
 457:	e8 b7 fe ff ff       	call   313 <write>
  while(--i >= 0)
 45c:	39 de                	cmp    %ebx,%esi
 45e:	75 e0                	jne    440 <printint+0x90>
    putc(fd, buf[i]);
}
 460:	83 c4 4c             	add    $0x4c,%esp
 463:	5b                   	pop    %ebx
 464:	5e                   	pop    %esi
 465:	5f                   	pop    %edi
 466:	5d                   	pop    %ebp
 467:	c3                   	ret    
 468:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 46f:	90                   	nop
  neg = 0;
 470:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 477:	e9 64 ff ff ff       	jmp    3e0 <printint+0x30>
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 489:	8b 75 0c             	mov    0xc(%ebp),%esi
 48c:	0f b6 1e             	movzbl (%esi),%ebx
 48f:	84 db                	test   %bl,%bl
 491:	0f 84 c8 00 00 00    	je     55f <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 497:	8d 45 10             	lea    0x10(%ebp),%eax
 49a:	46                   	inc    %esi
 49b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 49e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4a1:	31 d2                	xor    %edx,%edx
 4a3:	eb 3e                	jmp    4e3 <printf+0x63>
 4a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4b3:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 4b6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4bb:	74 1e                	je     4db <printf+0x5b>
  write(fd, &c, 1);
 4bd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4c1:	b8 01 00 00 00       	mov    $0x1,%eax
 4c6:	89 44 24 08          	mov    %eax,0x8(%esp)
 4ca:	8b 45 08             	mov    0x8(%ebp),%eax
 4cd:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4d0:	89 04 24             	mov    %eax,(%esp)
 4d3:	e8 3b fe ff ff       	call   313 <write>
 4d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 4db:	0f b6 1e             	movzbl (%esi),%ebx
 4de:	46                   	inc    %esi
 4df:	84 db                	test   %bl,%bl
 4e1:	74 7c                	je     55f <printf+0xdf>
    if(state == 0){
 4e3:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 4e5:	0f be cb             	movsbl %bl,%ecx
 4e8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4eb:	74 c3                	je     4b0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4ed:	83 fa 25             	cmp    $0x25,%edx
 4f0:	75 e9                	jne    4db <printf+0x5b>
      if(c == 'd'){
 4f2:	83 f8 64             	cmp    $0x64,%eax
 4f5:	0f 84 a5 00 00 00    	je     5a0 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4fb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 501:	83 f9 70             	cmp    $0x70,%ecx
 504:	74 6a                	je     570 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 506:	83 f8 73             	cmp    $0x73,%eax
 509:	0f 84 e1 00 00 00    	je     5f0 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 50f:	83 f8 63             	cmp    $0x63,%eax
 512:	0f 84 98 00 00 00    	je     5b0 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 518:	83 f8 25             	cmp    $0x25,%eax
 51b:	74 1c                	je     539 <printf+0xb9>
  write(fd, &c, 1);
 51d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 521:	8b 45 08             	mov    0x8(%ebp),%eax
 524:	ba 01 00 00 00       	mov    $0x1,%edx
 529:	89 54 24 08          	mov    %edx,0x8(%esp)
 52d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 531:	89 04 24             	mov    %eax,(%esp)
 534:	e8 da fd ff ff       	call   313 <write>
 539:	89 7c 24 04          	mov    %edi,0x4(%esp)
 53d:	b8 01 00 00 00       	mov    $0x1,%eax
 542:	46                   	inc    %esi
 543:	89 44 24 08          	mov    %eax,0x8(%esp)
 547:	8b 45 08             	mov    0x8(%ebp),%eax
 54a:	88 5d e7             	mov    %bl,-0x19(%ebp)
 54d:	89 04 24             	mov    %eax,(%esp)
 550:	e8 be fd ff ff       	call   313 <write>
  for(i = 0; fmt[i]; i++){
 555:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 559:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 55b:	84 db                	test   %bl,%bl
 55d:	75 84                	jne    4e3 <printf+0x63>
    }
  }
}
 55f:	83 c4 3c             	add    $0x3c,%esp
 562:	5b                   	pop    %ebx
 563:	5e                   	pop    %esi
 564:	5f                   	pop    %edi
 565:	5d                   	pop    %ebp
 566:	c3                   	ret    
 567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 570:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 577:	b9 10 00 00 00       	mov    $0x10,%ecx
 57c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 57f:	8b 45 08             	mov    0x8(%ebp),%eax
 582:	8b 13                	mov    (%ebx),%edx
 584:	e8 27 fe ff ff       	call   3b0 <printint>
        ap++;
 589:	89 d8                	mov    %ebx,%eax
      state = 0;
 58b:	31 d2                	xor    %edx,%edx
        ap++;
 58d:	83 c0 04             	add    $0x4,%eax
 590:	89 45 d0             	mov    %eax,-0x30(%ebp)
 593:	e9 43 ff ff ff       	jmp    4db <printf+0x5b>
 598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59f:	90                   	nop
        printint(fd, *ap, 10, 1);
 5a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5a7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5ac:	eb ce                	jmp    57c <printf+0xfc>
 5ae:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 5b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5b3:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 5b8:	8b 03                	mov    (%ebx),%eax
        ap++;
 5ba:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5bd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 5c1:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 5c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5c8:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 5cc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5cf:	8b 45 08             	mov    0x8(%ebp),%eax
 5d2:	89 04 24             	mov    %eax,(%esp)
 5d5:	e8 39 fd ff ff       	call   313 <write>
      state = 0;
 5da:	31 d2                	xor    %edx,%edx
        ap++;
 5dc:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5df:	e9 f7 fe ff ff       	jmp    4db <printf+0x5b>
 5e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
        s = (char*)*ap;
 5f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5f3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5f5:	83 c0 04             	add    $0x4,%eax
 5f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5fb:	85 db                	test   %ebx,%ebx
 5fd:	74 11                	je     610 <printf+0x190>
        while(*s != 0){
 5ff:	0f b6 03             	movzbl (%ebx),%eax
 602:	84 c0                	test   %al,%al
 604:	74 44                	je     64a <printf+0x1ca>
 606:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 609:	89 de                	mov    %ebx,%esi
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 60e:	eb 10                	jmp    620 <printf+0x1a0>
 610:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 613:	bb f1 07 00 00       	mov    $0x7f1,%ebx
        while(*s != 0){
 618:	b0 28                	mov    $0x28,%al
 61a:	89 de                	mov    %ebx,%esi
 61c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 61f:	90                   	nop
          putc(fd, *s);
 620:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 623:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 628:	46                   	inc    %esi
  write(fd, &c, 1);
 629:	89 44 24 08          	mov    %eax,0x8(%esp)
 62d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 631:	89 1c 24             	mov    %ebx,(%esp)
 634:	e8 da fc ff ff       	call   313 <write>
        while(*s != 0){
 639:	0f b6 06             	movzbl (%esi),%eax
 63c:	84 c0                	test   %al,%al
 63e:	75 e0                	jne    620 <printf+0x1a0>
 640:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 643:	31 d2                	xor    %edx,%edx
 645:	e9 91 fe ff ff       	jmp    4db <printf+0x5b>
 64a:	31 d2                	xor    %edx,%edx
 64c:	e9 8a fe ff ff       	jmp    4db <printf+0x5b>
 651:	66 90                	xchg   %ax,%ax
 653:	66 90                	xchg   %ax,%ax
 655:	66 90                	xchg   %ax,%ax
 657:	66 90                	xchg   %ax,%ax
 659:	66 90                	xchg   %ax,%ax
 65b:	66 90                	xchg   %ax,%ax
 65d:	66 90                	xchg   %ax,%ax
 65f:	90                   	nop

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 90 0a 00 00       	mov    0xa90,%eax
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 66e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 670:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 673:	39 c8                	cmp    %ecx,%eax
 675:	73 19                	jae    690 <free+0x30>
 677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67e:	66 90                	xchg   %ax,%ax
 680:	39 d1                	cmp    %edx,%ecx
 682:	72 14                	jb     698 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 684:	39 d0                	cmp    %edx,%eax
 686:	73 10                	jae    698 <free+0x38>
{
 688:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68a:	39 c8                	cmp    %ecx,%eax
 68c:	8b 10                	mov    (%eax),%edx
 68e:	72 f0                	jb     680 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 690:	39 d0                	cmp    %edx,%eax
 692:	72 f4                	jb     688 <free+0x28>
 694:	39 d1                	cmp    %edx,%ecx
 696:	73 f0                	jae    688 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 698:	8b 73 fc             	mov    -0x4(%ebx),%esi
 69b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 69e:	39 fa                	cmp    %edi,%edx
 6a0:	74 1e                	je     6c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6a2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6a5:	8b 50 04             	mov    0x4(%eax),%edx
 6a8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6ab:	39 f1                	cmp    %esi,%ecx
 6ad:	74 2a                	je     6d9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6af:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 6b1:	5b                   	pop    %ebx
  freep = p;
 6b2:	a3 90 0a 00 00       	mov    %eax,0xa90
}
 6b7:	5e                   	pop    %esi
 6b8:	5f                   	pop    %edi
 6b9:	5d                   	pop    %ebp
 6ba:	c3                   	ret    
 6bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6c0:	8b 7a 04             	mov    0x4(%edx),%edi
 6c3:	01 fe                	add    %edi,%esi
 6c5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c8:	8b 10                	mov    (%eax),%edx
 6ca:	8b 12                	mov    (%edx),%edx
 6cc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6cf:	8b 50 04             	mov    0x4(%eax),%edx
 6d2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6d5:	39 f1                	cmp    %esi,%ecx
 6d7:	75 d6                	jne    6af <free+0x4f>
  freep = p;
 6d9:	a3 90 0a 00 00       	mov    %eax,0xa90
    p->s.size += bp->s.size;
 6de:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 6e1:	01 ca                	add    %ecx,%edx
 6e3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6e6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6e9:	89 10                	mov    %edx,(%eax)
}
 6eb:	5b                   	pop    %ebx
 6ec:	5e                   	pop    %esi
 6ed:	5f                   	pop    %edi
 6ee:	5d                   	pop    %ebp
 6ef:	c3                   	ret    

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 3d 90 0a 00 00    	mov    0xa90,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	8d 70 07             	lea    0x7(%eax),%esi
 705:	c1 ee 03             	shr    $0x3,%esi
 708:	46                   	inc    %esi
  if((prevp = freep) == 0){
 709:	85 ff                	test   %edi,%edi
 70b:	0f 84 9f 00 00 00    	je     7b0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 711:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 713:	8b 48 04             	mov    0x4(%eax),%ecx
 716:	39 f1                	cmp    %esi,%ecx
 718:	73 6c                	jae    786 <malloc+0x96>
 71a:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 720:	bb 00 10 00 00       	mov    $0x1000,%ebx
 725:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 728:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 72f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 732:	eb 1d                	jmp    751 <malloc+0x61>
 734:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 73f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 742:	8b 4a 04             	mov    0x4(%edx),%ecx
 745:	39 f1                	cmp    %esi,%ecx
 747:	73 47                	jae    790 <malloc+0xa0>
 749:	8b 3d 90 0a 00 00    	mov    0xa90,%edi
 74f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 751:	39 c7                	cmp    %eax,%edi
 753:	75 eb                	jne    740 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 755:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 758:	89 04 24             	mov    %eax,(%esp)
 75b:	e8 1b fc ff ff       	call   37b <sbrk>
  if(p == (char*)-1)
 760:	83 f8 ff             	cmp    $0xffffffff,%eax
 763:	74 17                	je     77c <malloc+0x8c>
  hp->s.size = nu;
 765:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 768:	83 c0 08             	add    $0x8,%eax
 76b:	89 04 24             	mov    %eax,(%esp)
 76e:	e8 ed fe ff ff       	call   660 <free>
  return freep;
 773:	a1 90 0a 00 00       	mov    0xa90,%eax
      if((p = morecore(nunits)) == 0)
 778:	85 c0                	test   %eax,%eax
 77a:	75 c4                	jne    740 <malloc+0x50>
        return 0;
  }
}
 77c:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 77f:	31 c0                	xor    %eax,%eax
}
 781:	5b                   	pop    %ebx
 782:	5e                   	pop    %esi
 783:	5f                   	pop    %edi
 784:	5d                   	pop    %ebp
 785:	c3                   	ret    
    if(p->s.size >= nunits){
 786:	89 c2                	mov    %eax,%edx
 788:	89 f8                	mov    %edi,%eax
 78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 790:	39 ce                	cmp    %ecx,%esi
 792:	74 4c                	je     7e0 <malloc+0xf0>
        p->s.size -= nunits;
 794:	29 f1                	sub    %esi,%ecx
 796:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 799:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 79c:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 79f:	a3 90 0a 00 00       	mov    %eax,0xa90
      return (void*)(p + 1);
 7a4:	8d 42 08             	lea    0x8(%edx),%eax
}
 7a7:	83 c4 2c             	add    $0x2c,%esp
 7aa:	5b                   	pop    %ebx
 7ab:	5e                   	pop    %esi
 7ac:	5f                   	pop    %edi
 7ad:	5d                   	pop    %ebp
 7ae:	c3                   	ret    
 7af:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 7b0:	b8 94 0a 00 00       	mov    $0xa94,%eax
 7b5:	ba 94 0a 00 00       	mov    $0xa94,%edx
 7ba:	a3 90 0a 00 00       	mov    %eax,0xa90
    base.s.size = 0;
 7bf:	31 c9                	xor    %ecx,%ecx
 7c1:	bf 94 0a 00 00       	mov    $0xa94,%edi
    base.s.ptr = freep = prevp = &base;
 7c6:	89 15 94 0a 00 00    	mov    %edx,0xa94
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7cc:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 7ce:	89 0d 98 0a 00 00    	mov    %ecx,0xa98
    if(p->s.size >= nunits){
 7d4:	e9 41 ff ff ff       	jmp    71a <malloc+0x2a>
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 0a                	mov    (%edx),%ecx
 7e2:	89 08                	mov    %ecx,(%eax)
 7e4:	eb b9                	jmp    79f <malloc+0xaf>
