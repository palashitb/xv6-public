
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
  int fd, i;
  char path[] = "stressfs0";
  char data[512];

  printf(1, "stressfs starting\n");
   1:	ba a8 08 00 00       	mov    $0x8a8,%edx
{
   6:	89 e5                	mov    %esp,%ebp
  char path[] = "stressfs0";
   8:	b8 73 74 72 65       	mov    $0x65727473,%eax
{
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  memset(data, 'a', sizeof(data));
  10:	bb 61 00 00 00       	mov    $0x61,%ebx
{
  15:	83 e4 f0             	and    $0xfffffff0,%esp
  18:	81 ec 30 02 00 00    	sub    $0x230,%esp
  char path[] = "stressfs0";
  1e:	89 44 24 26          	mov    %eax,0x26(%esp)
  memset(data, 'a', sizeof(data));
  22:	8d 74 24 30          	lea    0x30(%esp),%esi
  char path[] = "stressfs0";
  26:	b8 73 73 66 73       	mov    $0x73667373,%eax
  printf(1, "stressfs starting\n");
  2b:	89 54 24 04          	mov    %edx,0x4(%esp)
  2f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  char path[] = "stressfs0";
  36:	89 44 24 2a          	mov    %eax,0x2a(%esp)
  3a:	66 c7 44 24 2e 30 00 	movw   $0x30,0x2e(%esp)
  printf(1, "stressfs starting\n");
  41:	e8 fa 04 00 00       	call   540 <printf>
  memset(data, 'a', sizeof(data));
  46:	b9 00 02 00 00       	mov    $0x200,%ecx
  4b:	89 5c 24 04          	mov    %ebx,0x4(%esp)

  for(i = 0; i < 4; i++)
  4f:	31 db                	xor    %ebx,%ebx
  memset(data, 'a', sizeof(data));
  51:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  55:	89 34 24             	mov    %esi,(%esp)
  58:	e8 a3 01 00 00       	call   200 <memset>
    if(fork() > 0)
  5d:	e8 49 03 00 00       	call   3ab <fork>
  62:	85 c0                	test   %eax,%eax
  64:	0f 8f d0 00 00 00    	jg     13a <main+0x13a>
  for(i = 0; i < 4; i++)
  6a:	43                   	inc    %ebx
  6b:	83 fb 04             	cmp    $0x4,%ebx
  6e:	66 90                	xchg   %ax,%ax
  70:	75 eb                	jne    5d <main+0x5d>
  72:	b0 04                	mov    $0x4,%al
  74:	88 44 24 1f          	mov    %al,0x1f(%esp)
      break;

  printf(1, "write %d\n", i);
  78:	b8 bb 08 00 00       	mov    $0x8bb,%eax
  7d:	89 5c 24 08          	mov    %ebx,0x8(%esp)

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  81:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  86:	89 44 24 04          	mov    %eax,0x4(%esp)
  8a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  91:	e8 aa 04 00 00       	call   540 <printf>
  path[8] += i;
  96:	0f b6 44 24 1f       	movzbl 0x1f(%esp),%eax
  9b:	00 44 24 2e          	add    %al,0x2e(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  9f:	b8 02 02 00 00       	mov    $0x202,%eax
  a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  a8:	8d 44 24 26          	lea    0x26(%esp),%eax
  ac:	89 04 24             	mov    %eax,(%esp)
  af:	e8 3f 03 00 00       	call   3f3 <open>
  b4:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
  b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bd:	8d 76 00             	lea    0x0(%esi),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  c0:	89 74 24 04          	mov    %esi,0x4(%esp)
  c4:	b8 00 02 00 00       	mov    $0x200,%eax
  c9:	89 44 24 08          	mov    %eax,0x8(%esp)
  cd:	89 3c 24             	mov    %edi,(%esp)
  d0:	e8 fe 02 00 00       	call   3d3 <write>
  for(i = 0; i < 20; i++)
  d5:	4b                   	dec    %ebx
  d6:	75 e8                	jne    c0 <main+0xc0>
  close(fd);
  d8:	89 3c 24             	mov    %edi,(%esp)

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  db:	bb 14 00 00 00       	mov    $0x14,%ebx
  close(fd);
  e0:	e8 f6 02 00 00       	call   3db <close>
  printf(1, "read\n");
  e5:	ba c5 08 00 00       	mov    $0x8c5,%edx
  ea:	89 54 24 04          	mov    %edx,0x4(%esp)
  ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f5:	e8 46 04 00 00       	call   540 <printf>
  fd = open(path, O_RDONLY);
  fa:	8d 44 24 26          	lea    0x26(%esp),%eax
  fe:	31 c9                	xor    %ecx,%ecx
 100:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 104:	89 04 24             	mov    %eax,(%esp)
 107:	e8 e7 02 00 00       	call   3f3 <open>
 10c:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
 10e:	66 90                	xchg   %ax,%ax
    read(fd, data, sizeof(data));
 110:	89 74 24 04          	mov    %esi,0x4(%esp)
 114:	b8 00 02 00 00       	mov    $0x200,%eax
 119:	89 44 24 08          	mov    %eax,0x8(%esp)
 11d:	89 3c 24             	mov    %edi,(%esp)
 120:	e8 a6 02 00 00       	call   3cb <read>
  for (i = 0; i < 20; i++)
 125:	4b                   	dec    %ebx
 126:	75 e8                	jne    110 <main+0x110>
  close(fd);
 128:	89 3c 24             	mov    %edi,(%esp)
 12b:	e8 ab 02 00 00       	call   3db <close>

  wait();
 130:	e8 86 02 00 00       	call   3bb <wait>

  exit();
 135:	e8 79 02 00 00       	call   3b3 <exit>
 13a:	88 d8                	mov    %bl,%al
 13c:	e9 33 ff ff ff       	jmp    74 <main+0x74>
 141:	66 90                	xchg   %ax,%ax
 143:	66 90                	xchg   %ax,%ax
 145:	66 90                	xchg   %ax,%ax
 147:	66 90                	xchg   %ax,%ax
 149:	66 90                	xchg   %ax,%ax
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 150:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 151:	31 c0                	xor    %eax,%eax
{
 153:	89 e5                	mov    %esp,%ebp
 155:	53                   	push   %ebx
 156:	8b 4d 08             	mov    0x8(%ebp),%ecx
 159:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 160:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 164:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 167:	40                   	inc    %eax
 168:	84 d2                	test   %dl,%dl
 16a:	75 f4                	jne    160 <strcpy+0x10>
    ;
  return os;
}
 16c:	5b                   	pop    %ebx
 16d:	89 c8                	mov    %ecx,%eax
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17f:	90                   	nop

00000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 5d 08             	mov    0x8(%ebp),%ebx
 187:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 18a:	0f b6 03             	movzbl (%ebx),%eax
 18d:	0f b6 0a             	movzbl (%edx),%ecx
 190:	84 c0                	test   %al,%al
 192:	75 19                	jne    1ad <strcmp+0x2d>
 194:	eb 2a                	jmp    1c0 <strcmp+0x40>
 196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
 1a4:	43                   	inc    %ebx
 1a5:	42                   	inc    %edx
  while(*p && *p == *q)
 1a6:	0f b6 0a             	movzbl (%edx),%ecx
 1a9:	84 c0                	test   %al,%al
 1ab:	74 13                	je     1c0 <strcmp+0x40>
 1ad:	38 c8                	cmp    %cl,%al
 1af:	74 ef                	je     1a0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 1b1:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 1b2:	29 c8                	sub    %ecx,%eax
}
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    
 1b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	5b                   	pop    %ebx
 1c1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1c3:	29 c8                	sub    %ecx,%eax
}
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1d6:	80 3a 00             	cmpb   $0x0,(%edx)
 1d9:	74 15                	je     1f0 <strlen+0x20>
 1db:	31 c0                	xor    %eax,%eax
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	40                   	inc    %eax
 1e1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1e5:	89 c1                	mov    %eax,%ecx
 1e7:	75 f7                	jne    1e0 <strlen+0x10>
    ;
  return n;
}
 1e9:	5d                   	pop    %ebp
 1ea:	89 c8                	mov    %ecx,%eax
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1f1:	31 c9                	xor    %ecx,%ecx
}
 1f3:	89 c8                	mov    %ecx,%eax
 1f5:	c3                   	ret    
 1f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 55 08             	mov    0x8(%ebp),%edx
 206:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 207:	8b 4d 10             	mov    0x10(%ebp),%ecx
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	89 d7                	mov    %edx,%edi
 20f:	fc                   	cld    
 210:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 212:	5f                   	pop    %edi
 213:	89 d0                	mov    %edx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 22a:	0f b6 10             	movzbl (%eax),%edx
 22d:	84 d2                	test   %dl,%dl
 22f:	75 18                	jne    249 <strchr+0x29>
 231:	eb 1d                	jmp    250 <strchr+0x30>
 233:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 240:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 244:	40                   	inc    %eax
 245:	84 d2                	test   %dl,%dl
 247:	74 07                	je     250 <strchr+0x30>
    if(*s == c)
 249:	38 d1                	cmp    %dl,%cl
 24b:	75 f3                	jne    240 <strchr+0x20>
      return (char*)s;
  return 0;
}
 24d:	5d                   	pop    %ebp
 24e:	c3                   	ret    
 24f:	90                   	nop
 250:	5d                   	pop    %ebp
  return 0;
 251:	31 c0                	xor    %eax,%eax
}
 253:	c3                   	ret    
 254:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop

00000260 <gets>:

char*
gets(char *buf, int max)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
 265:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 266:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 268:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 26b:	83 ec 3c             	sub    $0x3c,%esp
 26e:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 271:	eb 3a                	jmp    2ad <gets+0x4d>
 273:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 280:	89 7c 24 04          	mov    %edi,0x4(%esp)
 284:	ba 01 00 00 00       	mov    $0x1,%edx
 289:	89 54 24 08          	mov    %edx,0x8(%esp)
 28d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 294:	e8 32 01 00 00       	call   3cb <read>
    if(cc < 1)
 299:	85 c0                	test   %eax,%eax
 29b:	7e 19                	jle    2b6 <gets+0x56>
      break;
    buf[i++] = c;
 29d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2a1:	46                   	inc    %esi
 2a2:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 2a5:	3c 0a                	cmp    $0xa,%al
 2a7:	74 27                	je     2d0 <gets+0x70>
 2a9:	3c 0d                	cmp    $0xd,%al
 2ab:	74 23                	je     2d0 <gets+0x70>
  for(i=0; i+1 < max; ){
 2ad:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 2b0:	43                   	inc    %ebx
 2b1:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2b4:	7c ca                	jl     280 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 2b6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 2b9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
 2bf:	83 c4 3c             	add    $0x3c,%esp
 2c2:	5b                   	pop    %ebx
 2c3:	5e                   	pop    %esi
 2c4:	5f                   	pop    %edi
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
 2c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ce:	66 90                	xchg   %ax,%ax
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	01 c3                	add    %eax,%ebx
 2d5:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 2d8:	eb dc                	jmp    2b6 <gets+0x56>
 2da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e1:	31 c0                	xor    %eax,%eax
{
 2e3:	89 e5                	mov    %esp,%ebp
 2e5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 2e8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
{
 2ef:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2f2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2f5:	89 04 24             	mov    %eax,(%esp)
 2f8:	e8 f6 00 00 00       	call   3f3 <open>
  if(fd < 0)
 2fd:	85 c0                	test   %eax,%eax
 2ff:	78 2f                	js     330 <stat+0x50>
 301:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 303:	8b 45 0c             	mov    0xc(%ebp),%eax
 306:	89 1c 24             	mov    %ebx,(%esp)
 309:	89 44 24 04          	mov    %eax,0x4(%esp)
 30d:	e8 f9 00 00 00       	call   40b <fstat>
  close(fd);
 312:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 315:	89 c6                	mov    %eax,%esi
  close(fd);
 317:	e8 bf 00 00 00       	call   3db <close>
  return r;
}
 31c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 31f:	89 f0                	mov    %esi,%eax
 321:	8b 75 fc             	mov    -0x4(%ebp),%esi
 324:	89 ec                	mov    %ebp,%esp
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 32f:	90                   	nop
    return -1;
 330:	be ff ff ff ff       	mov    $0xffffffff,%esi
 335:	eb e5                	jmp    31c <stat+0x3c>
 337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33e:	66 90                	xchg   %ax,%ax

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 02             	movsbl (%edx),%eax
 34a:	88 c1                	mov    %al,%cl
 34c:	80 e9 30             	sub    $0x30,%cl
 34f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 352:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 357:	77 1c                	ja     375 <atoi+0x35>
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 360:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 363:	42                   	inc    %edx
 364:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 368:	0f be 02             	movsbl (%edx),%eax
 36b:	88 c3                	mov    %al,%bl
 36d:	80 eb 30             	sub    $0x30,%bl
 370:	80 fb 09             	cmp    $0x9,%bl
 373:	76 eb                	jbe    360 <atoi+0x20>
  return n;
}
 375:	5b                   	pop    %ebx
 376:	89 c8                	mov    %ecx,%eax
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	8b 45 10             	mov    0x10(%ebp),%eax
 387:	56                   	push   %esi
 388:	8b 55 08             	mov    0x8(%ebp),%edx
 38b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38e:	85 c0                	test   %eax,%eax
 390:	7e 13                	jle    3a5 <memmove+0x25>
 392:	01 d0                	add    %edx,%eax
  dst = vdst;
 394:	89 d7                	mov    %edx,%edi
 396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3a1:	39 f8                	cmp    %edi,%eax
 3a3:	75 fb                	jne    3a0 <memmove+0x20>
  return vdst;
}
 3a5:	5e                   	pop    %esi
 3a6:	89 d0                	mov    %edx,%eax
 3a8:	5f                   	pop    %edi
 3a9:	5d                   	pop    %ebp
 3aa:	c3                   	ret    

000003ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ab:	b8 01 00 00 00       	mov    $0x1,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <exit>:
SYSCALL(exit)
 3b3:	b8 02 00 00 00       	mov    $0x2,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <wait>:
SYSCALL(wait)
 3bb:	b8 03 00 00 00       	mov    $0x3,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <pipe>:
SYSCALL(pipe)
 3c3:	b8 04 00 00 00       	mov    $0x4,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <read>:
SYSCALL(read)
 3cb:	b8 05 00 00 00       	mov    $0x5,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <write>:
SYSCALL(write)
 3d3:	b8 10 00 00 00       	mov    $0x10,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <close>:
SYSCALL(close)
 3db:	b8 15 00 00 00       	mov    $0x15,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <kill>:
SYSCALL(kill)
 3e3:	b8 06 00 00 00       	mov    $0x6,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <exec>:
SYSCALL(exec)
 3eb:	b8 07 00 00 00       	mov    $0x7,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <open>:
SYSCALL(open)
 3f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mknod>:
SYSCALL(mknod)
 3fb:	b8 11 00 00 00       	mov    $0x11,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <unlink>:
SYSCALL(unlink)
 403:	b8 12 00 00 00       	mov    $0x12,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <fstat>:
SYSCALL(fstat)
 40b:	b8 08 00 00 00       	mov    $0x8,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <link>:
SYSCALL(link)
 413:	b8 13 00 00 00       	mov    $0x13,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mkdir>:
SYSCALL(mkdir)
 41b:	b8 14 00 00 00       	mov    $0x14,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <chdir>:
SYSCALL(chdir)
 423:	b8 09 00 00 00       	mov    $0x9,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <dup>:
SYSCALL(dup)
 42b:	b8 0a 00 00 00       	mov    $0xa,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <getpid>:
SYSCALL(getpid)
 433:	b8 0b 00 00 00       	mov    $0xb,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <sbrk>:
SYSCALL(sbrk)
 43b:	b8 0c 00 00 00       	mov    $0xc,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <sleep>:
SYSCALL(sleep)
 443:	b8 0d 00 00 00       	mov    $0xd,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <uptime>:
SYSCALL(uptime)
 44b:	b8 0e 00 00 00       	mov    $0xe,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <waitx>:
SYSCALL(waitx)
 453:	b8 16 00 00 00       	mov    $0x16,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <set_priority>:
SYSCALL(set_priority)
 45b:	b8 17 00 00 00       	mov    $0x17,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <pls>:
SYSCALL(pls)
 463:	b8 18 00 00 00       	mov    $0x18,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    
 46b:	66 90                	xchg   %ax,%ax
 46d:	66 90                	xchg   %ax,%ax
 46f:	90                   	nop

00000470 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	89 cf                	mov    %ecx,%edi
 476:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 477:	89 d1                	mov    %edx,%ecx
{
 479:	53                   	push   %ebx
 47a:	83 ec 4c             	sub    $0x4c,%esp
 47d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 480:	89 d0                	mov    %edx,%eax
 482:	c1 e8 1f             	shr    $0x1f,%eax
 485:	84 c0                	test   %al,%al
 487:	0f 84 a3 00 00 00    	je     530 <printint+0xc0>
 48d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 491:	0f 84 99 00 00 00    	je     530 <printint+0xc0>
    neg = 1;
 497:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 49e:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4a0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 4a7:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4aa:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4b0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4b3:	31 d2                	xor    %edx,%edx
 4b5:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 4b8:	f7 f7                	div    %edi
 4ba:	8d 4b 01             	lea    0x1(%ebx),%ecx
 4bd:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 4c0:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 4c3:	39 cf                	cmp    %ecx,%edi
 4c5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 4c8:	0f b6 92 d4 08 00 00 	movzbl 0x8d4(%edx),%edx
 4cf:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 4d3:	76 db                	jbe    4b0 <printint+0x40>
  if(neg)
 4d5:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4d8:	85 c9                	test   %ecx,%ecx
 4da:	74 0c                	je     4e8 <printint+0x78>
    buf[i++] = '-';
 4dc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4df:	b2 2d                	mov    $0x2d,%dl
 4e1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 4e6:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 4e8:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4eb:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 4ef:	eb 13                	jmp    504 <printint+0x94>
 4f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ff:	90                   	nop
 500:	0f b6 13             	movzbl (%ebx),%edx
 503:	4b                   	dec    %ebx
  write(fd, &c, 1);
 504:	89 74 24 04          	mov    %esi,0x4(%esp)
 508:	b8 01 00 00 00       	mov    $0x1,%eax
 50d:	89 44 24 08          	mov    %eax,0x8(%esp)
 511:	89 3c 24             	mov    %edi,(%esp)
 514:	88 55 d7             	mov    %dl,-0x29(%ebp)
 517:	e8 b7 fe ff ff       	call   3d3 <write>
  while(--i >= 0)
 51c:	39 de                	cmp    %ebx,%esi
 51e:	75 e0                	jne    500 <printint+0x90>
    putc(fd, buf[i]);
}
 520:	83 c4 4c             	add    $0x4c,%esp
 523:	5b                   	pop    %ebx
 524:	5e                   	pop    %esi
 525:	5f                   	pop    %edi
 526:	5d                   	pop    %ebp
 527:	c3                   	ret    
 528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52f:	90                   	nop
  neg = 0;
 530:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 537:	e9 64 ff ff ff       	jmp    4a0 <printint+0x30>
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	53                   	push   %ebx
 546:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 75 0c             	mov    0xc(%ebp),%esi
 54c:	0f b6 1e             	movzbl (%esi),%ebx
 54f:	84 db                	test   %bl,%bl
 551:	0f 84 c8 00 00 00    	je     61f <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 557:	8d 45 10             	lea    0x10(%ebp),%eax
 55a:	46                   	inc    %esi
 55b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 55e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 561:	31 d2                	xor    %edx,%edx
 563:	eb 3e                	jmp    5a3 <printf+0x63>
 565:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 570:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 573:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 576:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 57b:	74 1e                	je     59b <printf+0x5b>
  write(fd, &c, 1);
 57d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 581:	b8 01 00 00 00       	mov    $0x1,%eax
 586:	89 44 24 08          	mov    %eax,0x8(%esp)
 58a:	8b 45 08             	mov    0x8(%ebp),%eax
 58d:	88 5d e7             	mov    %bl,-0x19(%ebp)
 590:	89 04 24             	mov    %eax,(%esp)
 593:	e8 3b fe ff ff       	call   3d3 <write>
 598:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 59b:	0f b6 1e             	movzbl (%esi),%ebx
 59e:	46                   	inc    %esi
 59f:	84 db                	test   %bl,%bl
 5a1:	74 7c                	je     61f <printf+0xdf>
    if(state == 0){
 5a3:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 5a5:	0f be cb             	movsbl %bl,%ecx
 5a8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5ab:	74 c3                	je     570 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ad:	83 fa 25             	cmp    $0x25,%edx
 5b0:	75 e9                	jne    59b <printf+0x5b>
      if(c == 'd'){
 5b2:	83 f8 64             	cmp    $0x64,%eax
 5b5:	0f 84 a5 00 00 00    	je     660 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5bb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5c1:	83 f9 70             	cmp    $0x70,%ecx
 5c4:	74 6a                	je     630 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5c6:	83 f8 73             	cmp    $0x73,%eax
 5c9:	0f 84 e1 00 00 00    	je     6b0 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5cf:	83 f8 63             	cmp    $0x63,%eax
 5d2:	0f 84 98 00 00 00    	je     670 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5d8:	83 f8 25             	cmp    $0x25,%eax
 5db:	74 1c                	je     5f9 <printf+0xb9>
  write(fd, &c, 1);
 5dd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5e1:	8b 45 08             	mov    0x8(%ebp),%eax
 5e4:	ba 01 00 00 00       	mov    $0x1,%edx
 5e9:	89 54 24 08          	mov    %edx,0x8(%esp)
 5ed:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5f1:	89 04 24             	mov    %eax,(%esp)
 5f4:	e8 da fd ff ff       	call   3d3 <write>
 5f9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5fd:	b8 01 00 00 00       	mov    $0x1,%eax
 602:	46                   	inc    %esi
 603:	89 44 24 08          	mov    %eax,0x8(%esp)
 607:	8b 45 08             	mov    0x8(%ebp),%eax
 60a:	88 5d e7             	mov    %bl,-0x19(%ebp)
 60d:	89 04 24             	mov    %eax,(%esp)
 610:	e8 be fd ff ff       	call   3d3 <write>
  for(i = 0; fmt[i]; i++){
 615:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 619:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 61b:	84 db                	test   %bl,%bl
 61d:	75 84                	jne    5a3 <printf+0x63>
    }
  }
}
 61f:	83 c4 3c             	add    $0x3c,%esp
 622:	5b                   	pop    %ebx
 623:	5e                   	pop    %esi
 624:	5f                   	pop    %edi
 625:	5d                   	pop    %ebp
 626:	c3                   	ret    
 627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 630:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 637:	b9 10 00 00 00       	mov    $0x10,%ecx
 63c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 63f:	8b 45 08             	mov    0x8(%ebp),%eax
 642:	8b 13                	mov    (%ebx),%edx
 644:	e8 27 fe ff ff       	call   470 <printint>
        ap++;
 649:	89 d8                	mov    %ebx,%eax
      state = 0;
 64b:	31 d2                	xor    %edx,%edx
        ap++;
 64d:	83 c0 04             	add    $0x4,%eax
 650:	89 45 d0             	mov    %eax,-0x30(%ebp)
 653:	e9 43 ff ff ff       	jmp    59b <printf+0x5b>
 658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
        printint(fd, *ap, 10, 1);
 660:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 667:	b9 0a 00 00 00       	mov    $0xa,%ecx
 66c:	eb ce                	jmp    63c <printf+0xfc>
 66e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 670:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 673:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 678:	8b 03                	mov    (%ebx),%eax
        ap++;
 67a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 67d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 681:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 685:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 688:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 68c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 68f:	8b 45 08             	mov    0x8(%ebp),%eax
 692:	89 04 24             	mov    %eax,(%esp)
 695:	e8 39 fd ff ff       	call   3d3 <write>
      state = 0;
 69a:	31 d2                	xor    %edx,%edx
        ap++;
 69c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 69f:	e9 f7 fe ff ff       	jmp    59b <printf+0x5b>
 6a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
        s = (char*)*ap;
 6b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6b5:	83 c0 04             	add    $0x4,%eax
 6b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6bb:	85 db                	test   %ebx,%ebx
 6bd:	74 11                	je     6d0 <printf+0x190>
        while(*s != 0){
 6bf:	0f b6 03             	movzbl (%ebx),%eax
 6c2:	84 c0                	test   %al,%al
 6c4:	74 44                	je     70a <printf+0x1ca>
 6c6:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6c9:	89 de                	mov    %ebx,%esi
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ce:	eb 10                	jmp    6e0 <printf+0x1a0>
 6d0:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 6d3:	bb cb 08 00 00       	mov    $0x8cb,%ebx
        while(*s != 0){
 6d8:	b0 28                	mov    $0x28,%al
 6da:	89 de                	mov    %ebx,%esi
 6dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6df:	90                   	nop
          putc(fd, *s);
 6e0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6e3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 6e8:	46                   	inc    %esi
  write(fd, &c, 1);
 6e9:	89 44 24 08          	mov    %eax,0x8(%esp)
 6ed:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6f1:	89 1c 24             	mov    %ebx,(%esp)
 6f4:	e8 da fc ff ff       	call   3d3 <write>
        while(*s != 0){
 6f9:	0f b6 06             	movzbl (%esi),%eax
 6fc:	84 c0                	test   %al,%al
 6fe:	75 e0                	jne    6e0 <printf+0x1a0>
 700:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 703:	31 d2                	xor    %edx,%edx
 705:	e9 91 fe ff ff       	jmp    59b <printf+0x5b>
 70a:	31 d2                	xor    %edx,%edx
 70c:	e9 8a fe ff ff       	jmp    59b <printf+0x5b>
 711:	66 90                	xchg   %ax,%ax
 713:	66 90                	xchg   %ax,%ax
 715:	66 90                	xchg   %ax,%ax
 717:	66 90                	xchg   %ax,%ax
 719:	66 90                	xchg   %ax,%ax
 71b:	66 90                	xchg   %ax,%ax
 71d:	66 90                	xchg   %ax,%ax
 71f:	90                   	nop

00000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	a1 6c 0b 00 00       	mov    0xb6c,%eax
{
 726:	89 e5                	mov    %esp,%ebp
 728:	57                   	push   %edi
 729:	56                   	push   %esi
 72a:	53                   	push   %ebx
 72b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 72e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 730:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 733:	39 c8                	cmp    %ecx,%eax
 735:	73 19                	jae    750 <free+0x30>
 737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73e:	66 90                	xchg   %ax,%ax
 740:	39 d1                	cmp    %edx,%ecx
 742:	72 14                	jb     758 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 744:	39 d0                	cmp    %edx,%eax
 746:	73 10                	jae    758 <free+0x38>
{
 748:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	39 c8                	cmp    %ecx,%eax
 74c:	8b 10                	mov    (%eax),%edx
 74e:	72 f0                	jb     740 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 750:	39 d0                	cmp    %edx,%eax
 752:	72 f4                	jb     748 <free+0x28>
 754:	39 d1                	cmp    %edx,%ecx
 756:	73 f0                	jae    748 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 758:	8b 73 fc             	mov    -0x4(%ebx),%esi
 75b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75e:	39 fa                	cmp    %edi,%edx
 760:	74 1e                	je     780 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 762:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 765:	8b 50 04             	mov    0x4(%eax),%edx
 768:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 76b:	39 f1                	cmp    %esi,%ecx
 76d:	74 2a                	je     799 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 76f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 771:	5b                   	pop    %ebx
  freep = p;
 772:	a3 6c 0b 00 00       	mov    %eax,0xb6c
}
 777:	5e                   	pop    %esi
 778:	5f                   	pop    %edi
 779:	5d                   	pop    %ebp
 77a:	c3                   	ret    
 77b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 780:	8b 7a 04             	mov    0x4(%edx),%edi
 783:	01 fe                	add    %edi,%esi
 785:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 788:	8b 10                	mov    (%eax),%edx
 78a:	8b 12                	mov    (%edx),%edx
 78c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 78f:	8b 50 04             	mov    0x4(%eax),%edx
 792:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 795:	39 f1                	cmp    %esi,%ecx
 797:	75 d6                	jne    76f <free+0x4f>
  freep = p;
 799:	a3 6c 0b 00 00       	mov    %eax,0xb6c
    p->s.size += bp->s.size;
 79e:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 7a1:	01 ca                	add    %ecx,%edx
 7a3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7a6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7a9:	89 10                	mov    %edx,(%eax)
}
 7ab:	5b                   	pop    %ebx
 7ac:	5e                   	pop    %esi
 7ad:	5f                   	pop    %edi
 7ae:	5d                   	pop    %ebp
 7af:	c3                   	ret    

000007b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7bc:	8b 3d 6c 0b 00 00    	mov    0xb6c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	8d 70 07             	lea    0x7(%eax),%esi
 7c5:	c1 ee 03             	shr    $0x3,%esi
 7c8:	46                   	inc    %esi
  if((prevp = freep) == 0){
 7c9:	85 ff                	test   %edi,%edi
 7cb:	0f 84 9f 00 00 00    	je     870 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d1:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7d3:	8b 48 04             	mov    0x4(%eax),%ecx
 7d6:	39 f1                	cmp    %esi,%ecx
 7d8:	73 6c                	jae    846 <malloc+0x96>
 7da:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7e0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7e5:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7e8:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7ef:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7f2:	eb 1d                	jmp    811 <malloc+0x61>
 7f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7ff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 802:	8b 4a 04             	mov    0x4(%edx),%ecx
 805:	39 f1                	cmp    %esi,%ecx
 807:	73 47                	jae    850 <malloc+0xa0>
 809:	8b 3d 6c 0b 00 00    	mov    0xb6c,%edi
 80f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 811:	39 c7                	cmp    %eax,%edi
 813:	75 eb                	jne    800 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 815:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 818:	89 04 24             	mov    %eax,(%esp)
 81b:	e8 1b fc ff ff       	call   43b <sbrk>
  if(p == (char*)-1)
 820:	83 f8 ff             	cmp    $0xffffffff,%eax
 823:	74 17                	je     83c <malloc+0x8c>
  hp->s.size = nu;
 825:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 828:	83 c0 08             	add    $0x8,%eax
 82b:	89 04 24             	mov    %eax,(%esp)
 82e:	e8 ed fe ff ff       	call   720 <free>
  return freep;
 833:	a1 6c 0b 00 00       	mov    0xb6c,%eax
      if((p = morecore(nunits)) == 0)
 838:	85 c0                	test   %eax,%eax
 83a:	75 c4                	jne    800 <malloc+0x50>
        return 0;
  }
}
 83c:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 83f:	31 c0                	xor    %eax,%eax
}
 841:	5b                   	pop    %ebx
 842:	5e                   	pop    %esi
 843:	5f                   	pop    %edi
 844:	5d                   	pop    %ebp
 845:	c3                   	ret    
    if(p->s.size >= nunits){
 846:	89 c2                	mov    %eax,%edx
 848:	89 f8                	mov    %edi,%eax
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 850:	39 ce                	cmp    %ecx,%esi
 852:	74 4c                	je     8a0 <malloc+0xf0>
        p->s.size -= nunits;
 854:	29 f1                	sub    %esi,%ecx
 856:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 859:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 85c:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 85f:	a3 6c 0b 00 00       	mov    %eax,0xb6c
      return (void*)(p + 1);
 864:	8d 42 08             	lea    0x8(%edx),%eax
}
 867:	83 c4 2c             	add    $0x2c,%esp
 86a:	5b                   	pop    %ebx
 86b:	5e                   	pop    %esi
 86c:	5f                   	pop    %edi
 86d:	5d                   	pop    %ebp
 86e:	c3                   	ret    
 86f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 870:	b8 70 0b 00 00       	mov    $0xb70,%eax
 875:	ba 70 0b 00 00       	mov    $0xb70,%edx
 87a:	a3 6c 0b 00 00       	mov    %eax,0xb6c
    base.s.size = 0;
 87f:	31 c9                	xor    %ecx,%ecx
 881:	bf 70 0b 00 00       	mov    $0xb70,%edi
    base.s.ptr = freep = prevp = &base;
 886:	89 15 70 0b 00 00    	mov    %edx,0xb70
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88c:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 88e:	89 0d 74 0b 00 00    	mov    %ecx,0xb74
    if(p->s.size >= nunits){
 894:	e9 41 ff ff ff       	jmp    7da <malloc+0x2a>
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 0a                	mov    (%edx),%ecx
 8a2:	89 08                	mov    %ecx,(%eax)
 8a4:	eb b9                	jmp    85f <malloc+0xaf>
