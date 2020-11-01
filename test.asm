
_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

int number_of_processes = 10;

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 20             	sub    $0x20,%esp
  int j;
  for (j = 0; j < number_of_processes; j++)
   a:	8b 0d f0 0a 00 00    	mov    0xaf0,%ecx
  10:	85 c9                	test   %ecx,%ecx
  12:	7e 3e                	jle    52 <main+0x52>
  14:	31 db                	xor    %ebx,%ebx
  16:	eb 13                	jmp    2b <main+0x2b>
  18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1f:	90                   	nop
    if (pid < 0)
    {
      printf(1, "Fork failed\n");
      continue;
    }
    if (pid == 0)
  20:	74 55                	je     77 <main+0x77>
  for (j = 0; j < number_of_processes; j++)
  22:	43                   	inc    %ebx
  23:	39 1d f0 0a 00 00    	cmp    %ebx,0xaf0
  29:	7e 27                	jle    52 <main+0x52>
    int pid = fork();
  2b:	e8 1b 03 00 00       	call   34b <fork>
    if (pid < 0)
  30:	85 c0                	test   %eax,%eax
  32:	79 ec                	jns    20 <main+0x20>
      printf(1, "Fork failed\n");
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	ba 48 08 00 00       	mov    $0x848,%edx
  for (j = 0; j < number_of_processes; j++)
  40:	43                   	inc    %ebx
      printf(1, "Fork failed\n");
  41:	89 54 24 04          	mov    %edx,0x4(%esp)
  45:	e8 96 04 00 00       	call   4e0 <printf>
  for (j = 0; j < number_of_processes; j++)
  4a:	39 1d f0 0a 00 00    	cmp    %ebx,0xaf0
  50:	7f d9                	jg     2b <main+0x2b>
    else{
        ;
    //   set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
    }
  }
  for (j = 0; j < number_of_processes+5; j++)
  52:	83 3d f0 0a 00 00 fc 	cmpl   $0xfffffffc,0xaf0
  59:	7c 17                	jl     72 <main+0x72>
  5b:	31 db                	xor    %ebx,%ebx
  5d:	8d 76 00             	lea    0x0(%esi),%esi
  {
    wait();
  60:	e8 f6 02 00 00       	call   35b <wait>
  for (j = 0; j < number_of_processes+5; j++)
  65:	a1 f0 0a 00 00       	mov    0xaf0,%eax
  6a:	43                   	inc    %ebx
  6b:	83 c0 04             	add    $0x4,%eax
  6e:	39 d8                	cmp    %ebx,%eax
  70:	7d ee                	jge    60 <main+0x60>
      exit();
  72:	e8 dc 02 00 00       	call   353 <exit>
      for (volatile int k = 0; k < number_of_processes; k++)
  77:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  7e:	00 
  7f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  83:	3b 05 f0 0a 00 00    	cmp    0xaf0,%eax
  89:	7c 26                	jl     b1 <main+0xb1>
  8b:	eb e5                	jmp    72 <main+0x72>
  8d:	8d 76 00             	lea    0x0(%esi),%esi
          sleep(200); //io time
  90:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
  97:	e8 47 03 00 00       	call   3e3 <sleep>
      for (volatile int k = 0; k < number_of_processes; k++)
  9c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  a0:	40                   	inc    %eax
  a1:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  a5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  a9:	3b 05 f0 0a 00 00    	cmp    0xaf0,%eax
  af:	7d c1                	jge    72 <main+0x72>
        if (k <= j)
  b1:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  b5:	39 d8                	cmp    %ebx,%eax
  b7:	7e d7                	jle    90 <main+0x90>
          for (i = 0; i < 100000000; i++)
  b9:	31 c0                	xor    %eax,%eax
  bb:	89 44 24 18          	mov    %eax,0x18(%esp)
  bf:	8b 44 24 18          	mov    0x18(%esp),%eax
  c3:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
  c8:	7f d2                	jg     9c <main+0x9c>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d0:	8b 44 24 18          	mov    0x18(%esp),%eax
  d4:	40                   	inc    %eax
  d5:	89 44 24 18          	mov    %eax,0x18(%esp)
  d9:	8b 44 24 18          	mov    0x18(%esp),%eax
  dd:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
  e2:	7e ec                	jle    d0 <main+0xd0>
  e4:	eb b6                	jmp    9c <main+0x9c>
  e6:	66 90                	xchg   %ax,%ax
  e8:	66 90                	xchg   %ax,%ax
  ea:	66 90                	xchg   %ax,%ax
  ec:	66 90                	xchg   %ax,%ax
  ee:	66 90                	xchg   %ax,%ax

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  f1:	31 c0                	xor    %eax,%eax
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	53                   	push   %ebx
  f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 100:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 104:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 107:	40                   	inc    %eax
 108:	84 d2                	test   %dl,%dl
 10a:	75 f4                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 10c:	5b                   	pop    %ebx
 10d:	89 c8                	mov    %ecx,%eax
 10f:	5d                   	pop    %ebp
 110:	c3                   	ret    
 111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11f:	90                   	nop

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 5d 08             	mov    0x8(%ebp),%ebx
 127:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 12a:	0f b6 03             	movzbl (%ebx),%eax
 12d:	0f b6 0a             	movzbl (%edx),%ecx
 130:	84 c0                	test   %al,%al
 132:	75 19                	jne    14d <strcmp+0x2d>
 134:	eb 2a                	jmp    160 <strcmp+0x40>
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
 144:	43                   	inc    %ebx
 145:	42                   	inc    %edx
  while(*p && *p == *q)
 146:	0f b6 0a             	movzbl (%edx),%ecx
 149:	84 c0                	test   %al,%al
 14b:	74 13                	je     160 <strcmp+0x40>
 14d:	38 c8                	cmp    %cl,%al
 14f:	74 ef                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 151:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 152:	29 c8                	sub    %ecx,%eax
}
 154:	5d                   	pop    %ebp
 155:	c3                   	ret    
 156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15d:	8d 76 00             	lea    0x0(%esi),%esi
 160:	5b                   	pop    %ebx
 161:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 163:	29 c8                	sub    %ecx,%eax
}
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16e:	66 90                	xchg   %ax,%ax

00000170 <strlen>:

uint
strlen(const char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 3a 00             	cmpb   $0x0,(%edx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 c0                	xor    %eax,%eax
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	40                   	inc    %eax
 181:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 185:	89 c1                	mov    %eax,%ecx
 187:	75 f7                	jne    180 <strlen+0x10>
    ;
  return n;
}
 189:	5d                   	pop    %ebp
 18a:	89 c8                	mov    %ecx,%eax
 18c:	c3                   	ret    
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 191:	31 c9                	xor    %ecx,%ecx
}
 193:	89 c8                	mov    %ecx,%eax
 195:	c3                   	ret    
 196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19d:	8d 76 00             	lea    0x0(%esi),%esi

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
 1a6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	5f                   	pop    %edi
 1b3:	89 d0                	mov    %edx,%eax
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1be:	66 90                	xchg   %ax,%ax

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	75 18                	jne    1e9 <strchr+0x29>
 1d1:	eb 1d                	jmp    1f0 <strchr+0x30>
 1d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1e4:	40                   	inc    %eax
 1e5:	84 d2                	test   %dl,%dl
 1e7:	74 07                	je     1f0 <strchr+0x30>
    if(*s == c)
 1e9:	38 d1                	cmp    %dl,%cl
 1eb:	75 f3                	jne    1e0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1ed:	5d                   	pop    %ebp
 1ee:	c3                   	ret    
 1ef:	90                   	nop
 1f0:	5d                   	pop    %ebp
  return 0;
 1f1:	31 c0                	xor    %eax,%eax
}
 1f3:	c3                   	ret    
 1f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ff:	90                   	nop

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 206:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 208:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 20b:	83 ec 3c             	sub    $0x3c,%esp
 20e:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 211:	eb 3a                	jmp    24d <gets+0x4d>
 213:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 220:	89 7c 24 04          	mov    %edi,0x4(%esp)
 224:	ba 01 00 00 00       	mov    $0x1,%edx
 229:	89 54 24 08          	mov    %edx,0x8(%esp)
 22d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 234:	e8 32 01 00 00       	call   36b <read>
    if(cc < 1)
 239:	85 c0                	test   %eax,%eax
 23b:	7e 19                	jle    256 <gets+0x56>
      break;
    buf[i++] = c;
 23d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 241:	46                   	inc    %esi
 242:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 245:	3c 0a                	cmp    $0xa,%al
 247:	74 27                	je     270 <gets+0x70>
 249:	3c 0d                	cmp    $0xd,%al
 24b:	74 23                	je     270 <gets+0x70>
  for(i=0; i+1 < max; ){
 24d:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 250:	43                   	inc    %ebx
 251:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 254:	7c ca                	jl     220 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 256:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 259:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
 25f:	83 c4 3c             	add    $0x3c,%esp
 262:	5b                   	pop    %ebx
 263:	5e                   	pop    %esi
 264:	5f                   	pop    %edi
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax
 270:	8b 45 08             	mov    0x8(%ebp),%eax
 273:	01 c3                	add    %eax,%ebx
 275:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 278:	eb dc                	jmp    256 <gets+0x56>
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 281:	31 c0                	xor    %eax,%eax
{
 283:	89 e5                	mov    %esp,%ebp
 285:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 288:	89 44 24 04          	mov    %eax,0x4(%esp)
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 28f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 292:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 295:	89 04 24             	mov    %eax,(%esp)
 298:	e8 f6 00 00 00       	call   393 <open>
  if(fd < 0)
 29d:	85 c0                	test   %eax,%eax
 29f:	78 2f                	js     2d0 <stat+0x50>
 2a1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a6:	89 1c 24             	mov    %ebx,(%esp)
 2a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ad:	e8 f9 00 00 00       	call   3ab <fstat>
  close(fd);
 2b2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2b5:	89 c6                	mov    %eax,%esi
  close(fd);
 2b7:	e8 bf 00 00 00       	call   37b <close>
  return r;
}
 2bc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2bf:	89 f0                	mov    %esi,%eax
 2c1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2c4:	89 ec                	mov    %ebp,%esp
 2c6:	5d                   	pop    %ebp
 2c7:	c3                   	ret    
 2c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cf:	90                   	nop
    return -1;
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb e5                	jmp    2bc <stat+0x3c>
 2d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2de:	66 90                	xchg   %ax,%ax

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 02             	movsbl (%edx),%eax
 2ea:	88 c1                	mov    %al,%cl
 2ec:	80 e9 30             	sub    $0x30,%cl
 2ef:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f2:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f7:	77 1c                	ja     315 <atoi+0x35>
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 300:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 303:	42                   	inc    %edx
 304:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 308:	0f be 02             	movsbl (%edx),%eax
 30b:	88 c3                	mov    %al,%bl
 30d:	80 eb 30             	sub    $0x30,%bl
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	5b                   	pop    %ebx
 316:	89 c8                	mov    %ecx,%eax
 318:	5d                   	pop    %ebp
 319:	c3                   	ret    
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 45 10             	mov    0x10(%ebp),%eax
 327:	56                   	push   %esi
 328:	8b 55 08             	mov    0x8(%ebp),%edx
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 c0                	test   %eax,%eax
 330:	7e 13                	jle    345 <memmove+0x25>
 332:	01 d0                	add    %edx,%eax
  dst = vdst;
 334:	89 d7                	mov    %edx,%edi
 336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <waitx>:
SYSCALL(waitx)
 3f3:	b8 16 00 00 00       	mov    $0x16,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <set_priority>:
SYSCALL(set_priority)
 3fb:	b8 17 00 00 00       	mov    $0x17,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <pls>:
SYSCALL(pls)
 403:	b8 18 00 00 00       	mov    $0x18,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    
 40b:	66 90                	xchg   %ax,%ax
 40d:	66 90                	xchg   %ax,%ax
 40f:	90                   	nop

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	89 cf                	mov    %ecx,%edi
 416:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 417:	89 d1                	mov    %edx,%ecx
{
 419:	53                   	push   %ebx
 41a:	83 ec 4c             	sub    $0x4c,%esp
 41d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 420:	89 d0                	mov    %edx,%eax
 422:	c1 e8 1f             	shr    $0x1f,%eax
 425:	84 c0                	test   %al,%al
 427:	0f 84 a3 00 00 00    	je     4d0 <printint+0xc0>
 42d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 431:	0f 84 99 00 00 00    	je     4d0 <printint+0xc0>
    neg = 1;
 437:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 43e:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 440:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 447:	8d 75 d7             	lea    -0x29(%ebp),%esi
 44a:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 44d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 450:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 453:	31 d2                	xor    %edx,%edx
 455:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 458:	f7 f7                	div    %edi
 45a:	8d 4b 01             	lea    0x1(%ebx),%ecx
 45d:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 460:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 463:	39 cf                	cmp    %ecx,%edi
 465:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 468:	0f b6 92 5c 08 00 00 	movzbl 0x85c(%edx),%edx
 46f:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 473:	76 db                	jbe    450 <printint+0x40>
  if(neg)
 475:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 478:	85 c9                	test   %ecx,%ecx
 47a:	74 0c                	je     488 <printint+0x78>
    buf[i++] = '-';
 47c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 47f:	b2 2d                	mov    $0x2d,%dl
 481:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 486:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 488:	8b 7d b8             	mov    -0x48(%ebp),%edi
 48b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 48f:	eb 13                	jmp    4a4 <printint+0x94>
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49f:	90                   	nop
 4a0:	0f b6 13             	movzbl (%ebx),%edx
 4a3:	4b                   	dec    %ebx
  write(fd, &c, 1);
 4a4:	89 74 24 04          	mov    %esi,0x4(%esp)
 4a8:	b8 01 00 00 00       	mov    $0x1,%eax
 4ad:	89 44 24 08          	mov    %eax,0x8(%esp)
 4b1:	89 3c 24             	mov    %edi,(%esp)
 4b4:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4b7:	e8 b7 fe ff ff       	call   373 <write>
  while(--i >= 0)
 4bc:	39 de                	cmp    %ebx,%esi
 4be:	75 e0                	jne    4a0 <printint+0x90>
    putc(fd, buf[i]);
}
 4c0:	83 c4 4c             	add    $0x4c,%esp
 4c3:	5b                   	pop    %ebx
 4c4:	5e                   	pop    %esi
 4c5:	5f                   	pop    %edi
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
 4c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop
  neg = 0;
 4d0:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4d7:	e9 64 ff ff ff       	jmp    440 <printint+0x30>
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	53                   	push   %ebx
 4e6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4ec:	0f b6 1e             	movzbl (%esi),%ebx
 4ef:	84 db                	test   %bl,%bl
 4f1:	0f 84 c8 00 00 00    	je     5bf <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 4f7:	8d 45 10             	lea    0x10(%ebp),%eax
 4fa:	46                   	inc    %esi
 4fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 4fe:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 501:	31 d2                	xor    %edx,%edx
 503:	eb 3e                	jmp    543 <printf+0x63>
 505:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 510:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 513:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 516:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 51b:	74 1e                	je     53b <printf+0x5b>
  write(fd, &c, 1);
 51d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 521:	b8 01 00 00 00       	mov    $0x1,%eax
 526:	89 44 24 08          	mov    %eax,0x8(%esp)
 52a:	8b 45 08             	mov    0x8(%ebp),%eax
 52d:	88 5d e7             	mov    %bl,-0x19(%ebp)
 530:	89 04 24             	mov    %eax,(%esp)
 533:	e8 3b fe ff ff       	call   373 <write>
 538:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 53b:	0f b6 1e             	movzbl (%esi),%ebx
 53e:	46                   	inc    %esi
 53f:	84 db                	test   %bl,%bl
 541:	74 7c                	je     5bf <printf+0xdf>
    if(state == 0){
 543:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 545:	0f be cb             	movsbl %bl,%ecx
 548:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 54b:	74 c3                	je     510 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 54d:	83 fa 25             	cmp    $0x25,%edx
 550:	75 e9                	jne    53b <printf+0x5b>
      if(c == 'd'){
 552:	83 f8 64             	cmp    $0x64,%eax
 555:	0f 84 a5 00 00 00    	je     600 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 55b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 561:	83 f9 70             	cmp    $0x70,%ecx
 564:	74 6a                	je     5d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 566:	83 f8 73             	cmp    $0x73,%eax
 569:	0f 84 e1 00 00 00    	je     650 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56f:	83 f8 63             	cmp    $0x63,%eax
 572:	0f 84 98 00 00 00    	je     610 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 578:	83 f8 25             	cmp    $0x25,%eax
 57b:	74 1c                	je     599 <printf+0xb9>
  write(fd, &c, 1);
 57d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 581:	8b 45 08             	mov    0x8(%ebp),%eax
 584:	ba 01 00 00 00       	mov    $0x1,%edx
 589:	89 54 24 08          	mov    %edx,0x8(%esp)
 58d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 591:	89 04 24             	mov    %eax,(%esp)
 594:	e8 da fd ff ff       	call   373 <write>
 599:	89 7c 24 04          	mov    %edi,0x4(%esp)
 59d:	b8 01 00 00 00       	mov    $0x1,%eax
 5a2:	46                   	inc    %esi
 5a3:	89 44 24 08          	mov    %eax,0x8(%esp)
 5a7:	8b 45 08             	mov    0x8(%ebp),%eax
 5aa:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5ad:	89 04 24             	mov    %eax,(%esp)
 5b0:	e8 be fd ff ff       	call   373 <write>
  for(i = 0; fmt[i]; i++){
 5b5:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5bb:	84 db                	test   %bl,%bl
 5bd:	75 84                	jne    543 <printf+0x63>
    }
  }
}
 5bf:	83 c4 3c             	add    $0x3c,%esp
 5c2:	5b                   	pop    %ebx
 5c3:	5e                   	pop    %esi
 5c4:	5f                   	pop    %edi
 5c5:	5d                   	pop    %ebp
 5c6:	c3                   	ret    
 5c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5d7:	b9 10 00 00 00       	mov    $0x10,%ecx
 5dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5df:	8b 45 08             	mov    0x8(%ebp),%eax
 5e2:	8b 13                	mov    (%ebx),%edx
 5e4:	e8 27 fe ff ff       	call   410 <printint>
        ap++;
 5e9:	89 d8                	mov    %ebx,%eax
      state = 0;
 5eb:	31 d2                	xor    %edx,%edx
        ap++;
 5ed:	83 c0 04             	add    $0x4,%eax
 5f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5f3:	e9 43 ff ff ff       	jmp    53b <printf+0x5b>
 5f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop
        printint(fd, *ap, 10, 1);
 600:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 607:	b9 0a 00 00 00       	mov    $0xa,%ecx
 60c:	eb ce                	jmp    5dc <printf+0xfc>
 60e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 610:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 613:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 618:	8b 03                	mov    (%ebx),%eax
        ap++;
 61a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 61d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 621:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 625:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 628:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 62c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	89 04 24             	mov    %eax,(%esp)
 635:	e8 39 fd ff ff       	call   373 <write>
      state = 0;
 63a:	31 d2                	xor    %edx,%edx
        ap++;
 63c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 63f:	e9 f7 fe ff ff       	jmp    53b <printf+0x5b>
 644:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
        s = (char*)*ap;
 650:	8b 45 d0             	mov    -0x30(%ebp),%eax
 653:	8b 18                	mov    (%eax),%ebx
        ap++;
 655:	83 c0 04             	add    $0x4,%eax
 658:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 65b:	85 db                	test   %ebx,%ebx
 65d:	74 11                	je     670 <printf+0x190>
        while(*s != 0){
 65f:	0f b6 03             	movzbl (%ebx),%eax
 662:	84 c0                	test   %al,%al
 664:	74 44                	je     6aa <printf+0x1ca>
 666:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 669:	89 de                	mov    %ebx,%esi
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 66e:	eb 10                	jmp    680 <printf+0x1a0>
 670:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 673:	bb 55 08 00 00       	mov    $0x855,%ebx
        while(*s != 0){
 678:	b0 28                	mov    $0x28,%al
 67a:	89 de                	mov    %ebx,%esi
 67c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 67f:	90                   	nop
          putc(fd, *s);
 680:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 683:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 688:	46                   	inc    %esi
  write(fd, &c, 1);
 689:	89 44 24 08          	mov    %eax,0x8(%esp)
 68d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 691:	89 1c 24             	mov    %ebx,(%esp)
 694:	e8 da fc ff ff       	call   373 <write>
        while(*s != 0){
 699:	0f b6 06             	movzbl (%esi),%eax
 69c:	84 c0                	test   %al,%al
 69e:	75 e0                	jne    680 <printf+0x1a0>
 6a0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6a3:	31 d2                	xor    %edx,%edx
 6a5:	e9 91 fe ff ff       	jmp    53b <printf+0x5b>
 6aa:	31 d2                	xor    %edx,%edx
 6ac:	e9 8a fe ff ff       	jmp    53b <printf+0x5b>
 6b1:	66 90                	xchg   %ax,%ax
 6b3:	66 90                	xchg   %ax,%ax
 6b5:	66 90                	xchg   %ax,%ax
 6b7:	66 90                	xchg   %ax,%ax
 6b9:	66 90                	xchg   %ax,%ax
 6bb:	66 90                	xchg   %ax,%ax
 6bd:	66 90                	xchg   %ax,%ax
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 f4 0a 00 00       	mov    0xaf4,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ce:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d3:	39 c8                	cmp    %ecx,%eax
 6d5:	73 19                	jae    6f0 <free+0x30>
 6d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6de:	66 90                	xchg   %ax,%ax
 6e0:	39 d1                	cmp    %edx,%ecx
 6e2:	72 14                	jb     6f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e4:	39 d0                	cmp    %edx,%eax
 6e6:	73 10                	jae    6f8 <free+0x38>
{
 6e8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ea:	39 c8                	cmp    %ecx,%eax
 6ec:	8b 10                	mov    (%eax),%edx
 6ee:	72 f0                	jb     6e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	39 d0                	cmp    %edx,%eax
 6f2:	72 f4                	jb     6e8 <free+0x28>
 6f4:	39 d1                	cmp    %edx,%ecx
 6f6:	73 f0                	jae    6e8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fe:	39 fa                	cmp    %edi,%edx
 700:	74 1e                	je     720 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 702:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 70b:	39 f1                	cmp    %esi,%ecx
 70d:	74 2a                	je     739 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 70f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 711:	5b                   	pop    %ebx
  freep = p;
 712:	a3 f4 0a 00 00       	mov    %eax,0xaf4
}
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
 71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 720:	8b 7a 04             	mov    0x4(%edx),%edi
 723:	01 fe                	add    %edi,%esi
 725:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 728:	8b 10                	mov    (%eax),%edx
 72a:	8b 12                	mov    (%edx),%edx
 72c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 72f:	8b 50 04             	mov    0x4(%eax),%edx
 732:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 735:	39 f1                	cmp    %esi,%ecx
 737:	75 d6                	jne    70f <free+0x4f>
  freep = p;
 739:	a3 f4 0a 00 00       	mov    %eax,0xaf4
    p->s.size += bp->s.size;
 73e:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 741:	01 ca                	add    %ecx,%edx
 743:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 746:	8b 53 f8             	mov    -0x8(%ebx),%edx
 749:	89 10                	mov    %edx,(%eax)
}
 74b:	5b                   	pop    %ebx
 74c:	5e                   	pop    %esi
 74d:	5f                   	pop    %edi
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret    

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 75c:	8b 3d f4 0a 00 00    	mov    0xaf4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	8d 70 07             	lea    0x7(%eax),%esi
 765:	c1 ee 03             	shr    $0x3,%esi
 768:	46                   	inc    %esi
  if((prevp = freep) == 0){
 769:	85 ff                	test   %edi,%edi
 76b:	0f 84 9f 00 00 00    	je     810 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 771:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 773:	8b 48 04             	mov    0x4(%eax),%ecx
 776:	39 f1                	cmp    %esi,%ecx
 778:	73 6c                	jae    7e6 <malloc+0x96>
 77a:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 780:	bb 00 10 00 00       	mov    $0x1000,%ebx
 785:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 788:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 78f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 792:	eb 1d                	jmp    7b1 <malloc+0x61>
 794:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 79f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7a2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7a5:	39 f1                	cmp    %esi,%ecx
 7a7:	73 47                	jae    7f0 <malloc+0xa0>
 7a9:	8b 3d f4 0a 00 00    	mov    0xaf4,%edi
 7af:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b1:	39 c7                	cmp    %eax,%edi
 7b3:	75 eb                	jne    7a0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b8:	89 04 24             	mov    %eax,(%esp)
 7bb:	e8 1b fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 7c0:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c3:	74 17                	je     7dc <malloc+0x8c>
  hp->s.size = nu;
 7c5:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7c8:	83 c0 08             	add    $0x8,%eax
 7cb:	89 04 24             	mov    %eax,(%esp)
 7ce:	e8 ed fe ff ff       	call   6c0 <free>
  return freep;
 7d3:	a1 f4 0a 00 00       	mov    0xaf4,%eax
      if((p = morecore(nunits)) == 0)
 7d8:	85 c0                	test   %eax,%eax
 7da:	75 c4                	jne    7a0 <malloc+0x50>
        return 0;
  }
}
 7dc:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 7df:	31 c0                	xor    %eax,%eax
}
 7e1:	5b                   	pop    %ebx
 7e2:	5e                   	pop    %esi
 7e3:	5f                   	pop    %edi
 7e4:	5d                   	pop    %ebp
 7e5:	c3                   	ret    
    if(p->s.size >= nunits){
 7e6:	89 c2                	mov    %eax,%edx
 7e8:	89 f8                	mov    %edi,%eax
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7f0:	39 ce                	cmp    %ecx,%esi
 7f2:	74 4c                	je     840 <malloc+0xf0>
        p->s.size -= nunits;
 7f4:	29 f1                	sub    %esi,%ecx
 7f6:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7f9:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7fc:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7ff:	a3 f4 0a 00 00       	mov    %eax,0xaf4
      return (void*)(p + 1);
 804:	8d 42 08             	lea    0x8(%edx),%eax
}
 807:	83 c4 2c             	add    $0x2c,%esp
 80a:	5b                   	pop    %ebx
 80b:	5e                   	pop    %esi
 80c:	5f                   	pop    %edi
 80d:	5d                   	pop    %ebp
 80e:	c3                   	ret    
 80f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 810:	b8 f8 0a 00 00       	mov    $0xaf8,%eax
 815:	ba f8 0a 00 00       	mov    $0xaf8,%edx
 81a:	a3 f4 0a 00 00       	mov    %eax,0xaf4
    base.s.size = 0;
 81f:	31 c9                	xor    %ecx,%ecx
 821:	bf f8 0a 00 00       	mov    $0xaf8,%edi
    base.s.ptr = freep = prevp = &base;
 826:	89 15 f8 0a 00 00    	mov    %edx,0xaf8
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82c:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 82e:	89 0d fc 0a 00 00    	mov    %ecx,0xafc
    if(p->s.size >= nunits){
 834:	e9 41 ff ff ff       	jmp    77a <malloc+0x2a>
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 840:	8b 0a                	mov    (%edx),%ecx
 842:	89 08                	mov    %ecx,(%eax)
 844:	eb b9                	jmp    7ff <malloc+0xaf>
