
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
   a:	8b 0d e0 0a 00 00    	mov    0xae0,%ecx
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
  23:	39 1d e0 0a 00 00    	cmp    %ebx,0xae0
  29:	7e 27                	jle    52 <main+0x52>
    int pid = fork();
  2b:	e8 1b 03 00 00       	call   34b <fork>
    if (pid < 0)
  30:	85 c0                	test   %eax,%eax
  32:	79 ec                	jns    20 <main+0x20>
      printf(1, "Fork failed\n");
  34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3b:	ba 38 08 00 00       	mov    $0x838,%edx
  for (j = 0; j < number_of_processes; j++)
  40:	43                   	inc    %ebx
      printf(1, "Fork failed\n");
  41:	89 54 24 04          	mov    %edx,0x4(%esp)
  45:	e8 86 04 00 00       	call   4d0 <printf>
  for (j = 0; j < number_of_processes; j++)
  4a:	39 1d e0 0a 00 00    	cmp    %ebx,0xae0
  50:	7f d9                	jg     2b <main+0x2b>
    else{
        ;
    //   set_priority(100-(20+j),pid); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
    }
  }
  for (j = 0; j < number_of_processes+5; j++)
  52:	83 3d e0 0a 00 00 fc 	cmpl   $0xfffffffc,0xae0
  59:	7c 17                	jl     72 <main+0x72>
  5b:	31 db                	xor    %ebx,%ebx
  5d:	8d 76 00             	lea    0x0(%esi),%esi
  {
    wait();
  60:	e8 f6 02 00 00       	call   35b <wait>
  for (j = 0; j < number_of_processes+5; j++)
  65:	a1 e0 0a 00 00       	mov    0xae0,%eax
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
  83:	3b 05 e0 0a 00 00    	cmp    0xae0,%eax
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
  a9:	3b 05 e0 0a 00 00    	cmp    0xae0,%eax
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
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	89 cf                	mov    %ecx,%edi
 406:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 407:	89 d1                	mov    %edx,%ecx
{
 409:	53                   	push   %ebx
 40a:	83 ec 4c             	sub    $0x4c,%esp
 40d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 410:	89 d0                	mov    %edx,%eax
 412:	c1 e8 1f             	shr    $0x1f,%eax
 415:	84 c0                	test   %al,%al
 417:	0f 84 a3 00 00 00    	je     4c0 <printint+0xc0>
 41d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 421:	0f 84 99 00 00 00    	je     4c0 <printint+0xc0>
    neg = 1;
 427:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 42e:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 430:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 437:	8d 75 d7             	lea    -0x29(%ebp),%esi
 43a:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 440:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 443:	31 d2                	xor    %edx,%edx
 445:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 448:	f7 f7                	div    %edi
 44a:	8d 4b 01             	lea    0x1(%ebx),%ecx
 44d:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 450:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 453:	39 cf                	cmp    %ecx,%edi
 455:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 458:	0f b6 92 4c 08 00 00 	movzbl 0x84c(%edx),%edx
 45f:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 463:	76 db                	jbe    440 <printint+0x40>
  if(neg)
 465:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 468:	85 c9                	test   %ecx,%ecx
 46a:	74 0c                	je     478 <printint+0x78>
    buf[i++] = '-';
 46c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 46f:	b2 2d                	mov    $0x2d,%dl
 471:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 476:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 478:	8b 7d b8             	mov    -0x48(%ebp),%edi
 47b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 47f:	eb 13                	jmp    494 <printint+0x94>
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop
 490:	0f b6 13             	movzbl (%ebx),%edx
 493:	4b                   	dec    %ebx
  write(fd, &c, 1);
 494:	89 74 24 04          	mov    %esi,0x4(%esp)
 498:	b8 01 00 00 00       	mov    $0x1,%eax
 49d:	89 44 24 08          	mov    %eax,0x8(%esp)
 4a1:	89 3c 24             	mov    %edi,(%esp)
 4a4:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4a7:	e8 c7 fe ff ff       	call   373 <write>
  while(--i >= 0)
 4ac:	39 de                	cmp    %ebx,%esi
 4ae:	75 e0                	jne    490 <printint+0x90>
    putc(fd, buf[i]);
}
 4b0:	83 c4 4c             	add    $0x4c,%esp
 4b3:	5b                   	pop    %ebx
 4b4:	5e                   	pop    %esi
 4b5:	5f                   	pop    %edi
 4b6:	5d                   	pop    %ebp
 4b7:	c3                   	ret    
 4b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop
  neg = 0;
 4c0:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4c7:	e9 64 ff ff ff       	jmp    430 <printint+0x30>
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4dc:	0f b6 1e             	movzbl (%esi),%ebx
 4df:	84 db                	test   %bl,%bl
 4e1:	0f 84 c8 00 00 00    	je     5af <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 4e7:	8d 45 10             	lea    0x10(%ebp),%eax
 4ea:	46                   	inc    %esi
 4eb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 4ee:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4f1:	31 d2                	xor    %edx,%edx
 4f3:	eb 3e                	jmp    533 <printf+0x63>
 4f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 500:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 503:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 506:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 50b:	74 1e                	je     52b <printf+0x5b>
  write(fd, &c, 1);
 50d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 511:	b8 01 00 00 00       	mov    $0x1,%eax
 516:	89 44 24 08          	mov    %eax,0x8(%esp)
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	88 5d e7             	mov    %bl,-0x19(%ebp)
 520:	89 04 24             	mov    %eax,(%esp)
 523:	e8 4b fe ff ff       	call   373 <write>
 528:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 52b:	0f b6 1e             	movzbl (%esi),%ebx
 52e:	46                   	inc    %esi
 52f:	84 db                	test   %bl,%bl
 531:	74 7c                	je     5af <printf+0xdf>
    if(state == 0){
 533:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 535:	0f be cb             	movsbl %bl,%ecx
 538:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 53b:	74 c3                	je     500 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 53d:	83 fa 25             	cmp    $0x25,%edx
 540:	75 e9                	jne    52b <printf+0x5b>
      if(c == 'd'){
 542:	83 f8 64             	cmp    $0x64,%eax
 545:	0f 84 a5 00 00 00    	je     5f0 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 54b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 551:	83 f9 70             	cmp    $0x70,%ecx
 554:	74 6a                	je     5c0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 556:	83 f8 73             	cmp    $0x73,%eax
 559:	0f 84 e1 00 00 00    	je     640 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 55f:	83 f8 63             	cmp    $0x63,%eax
 562:	0f 84 98 00 00 00    	je     600 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 568:	83 f8 25             	cmp    $0x25,%eax
 56b:	74 1c                	je     589 <printf+0xb9>
  write(fd, &c, 1);
 56d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 571:	8b 45 08             	mov    0x8(%ebp),%eax
 574:	ba 01 00 00 00       	mov    $0x1,%edx
 579:	89 54 24 08          	mov    %edx,0x8(%esp)
 57d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 581:	89 04 24             	mov    %eax,(%esp)
 584:	e8 ea fd ff ff       	call   373 <write>
 589:	89 7c 24 04          	mov    %edi,0x4(%esp)
 58d:	b8 01 00 00 00       	mov    $0x1,%eax
 592:	46                   	inc    %esi
 593:	89 44 24 08          	mov    %eax,0x8(%esp)
 597:	8b 45 08             	mov    0x8(%ebp),%eax
 59a:	88 5d e7             	mov    %bl,-0x19(%ebp)
 59d:	89 04 24             	mov    %eax,(%esp)
 5a0:	e8 ce fd ff ff       	call   373 <write>
  for(i = 0; fmt[i]; i++){
 5a5:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5ab:	84 db                	test   %bl,%bl
 5ad:	75 84                	jne    533 <printf+0x63>
    }
  }
}
 5af:	83 c4 3c             	add    $0x3c,%esp
 5b2:	5b                   	pop    %ebx
 5b3:	5e                   	pop    %esi
 5b4:	5f                   	pop    %edi
 5b5:	5d                   	pop    %ebp
 5b6:	c3                   	ret    
 5b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5be:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5c7:	b9 10 00 00 00       	mov    $0x10,%ecx
 5cc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5cf:	8b 45 08             	mov    0x8(%ebp),%eax
 5d2:	8b 13                	mov    (%ebx),%edx
 5d4:	e8 27 fe ff ff       	call   400 <printint>
        ap++;
 5d9:	89 d8                	mov    %ebx,%eax
      state = 0;
 5db:	31 d2                	xor    %edx,%edx
        ap++;
 5dd:	83 c0 04             	add    $0x4,%eax
 5e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5e3:	e9 43 ff ff ff       	jmp    52b <printf+0x5b>
 5e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
        printint(fd, *ap, 10, 1);
 5f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5f7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5fc:	eb ce                	jmp    5cc <printf+0xfc>
 5fe:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 600:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 603:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 608:	8b 03                	mov    (%ebx),%eax
        ap++;
 60a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 60d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 611:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 615:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 618:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 61c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 61f:	8b 45 08             	mov    0x8(%ebp),%eax
 622:	89 04 24             	mov    %eax,(%esp)
 625:	e8 49 fd ff ff       	call   373 <write>
      state = 0;
 62a:	31 d2                	xor    %edx,%edx
        ap++;
 62c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 62f:	e9 f7 fe ff ff       	jmp    52b <printf+0x5b>
 634:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
        s = (char*)*ap;
 640:	8b 45 d0             	mov    -0x30(%ebp),%eax
 643:	8b 18                	mov    (%eax),%ebx
        ap++;
 645:	83 c0 04             	add    $0x4,%eax
 648:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 64b:	85 db                	test   %ebx,%ebx
 64d:	74 11                	je     660 <printf+0x190>
        while(*s != 0){
 64f:	0f b6 03             	movzbl (%ebx),%eax
 652:	84 c0                	test   %al,%al
 654:	74 44                	je     69a <printf+0x1ca>
 656:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 659:	89 de                	mov    %ebx,%esi
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 65e:	eb 10                	jmp    670 <printf+0x1a0>
 660:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 663:	bb 45 08 00 00       	mov    $0x845,%ebx
        while(*s != 0){
 668:	b0 28                	mov    $0x28,%al
 66a:	89 de                	mov    %ebx,%esi
 66c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 66f:	90                   	nop
          putc(fd, *s);
 670:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 673:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 678:	46                   	inc    %esi
  write(fd, &c, 1);
 679:	89 44 24 08          	mov    %eax,0x8(%esp)
 67d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 681:	89 1c 24             	mov    %ebx,(%esp)
 684:	e8 ea fc ff ff       	call   373 <write>
        while(*s != 0){
 689:	0f b6 06             	movzbl (%esi),%eax
 68c:	84 c0                	test   %al,%al
 68e:	75 e0                	jne    670 <printf+0x1a0>
 690:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 693:	31 d2                	xor    %edx,%edx
 695:	e9 91 fe ff ff       	jmp    52b <printf+0x5b>
 69a:	31 d2                	xor    %edx,%edx
 69c:	e9 8a fe ff ff       	jmp    52b <printf+0x5b>
 6a1:	66 90                	xchg   %ax,%ax
 6a3:	66 90                	xchg   %ax,%ax
 6a5:	66 90                	xchg   %ax,%ax
 6a7:	66 90                	xchg   %ax,%ax
 6a9:	66 90                	xchg   %ax,%ax
 6ab:	66 90                	xchg   %ax,%ax
 6ad:	66 90                	xchg   %ax,%ax
 6af:	90                   	nop

000006b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	a1 e4 0a 00 00       	mov    0xae4,%eax
{
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	57                   	push   %edi
 6b9:	56                   	push   %esi
 6ba:	53                   	push   %ebx
 6bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6be:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6c0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c3:	39 c8                	cmp    %ecx,%eax
 6c5:	73 19                	jae    6e0 <free+0x30>
 6c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ce:	66 90                	xchg   %ax,%ax
 6d0:	39 d1                	cmp    %edx,%ecx
 6d2:	72 14                	jb     6e8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d4:	39 d0                	cmp    %edx,%eax
 6d6:	73 10                	jae    6e8 <free+0x38>
{
 6d8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6da:	39 c8                	cmp    %ecx,%eax
 6dc:	8b 10                	mov    (%eax),%edx
 6de:	72 f0                	jb     6d0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e0:	39 d0                	cmp    %edx,%eax
 6e2:	72 f4                	jb     6d8 <free+0x28>
 6e4:	39 d1                	cmp    %edx,%ecx
 6e6:	73 f0                	jae    6d8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6eb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ee:	39 fa                	cmp    %edi,%edx
 6f0:	74 1e                	je     710 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6f2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6f5:	8b 50 04             	mov    0x4(%eax),%edx
 6f8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6fb:	39 f1                	cmp    %esi,%ecx
 6fd:	74 2a                	je     729 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6ff:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 701:	5b                   	pop    %ebx
  freep = p;
 702:	a3 e4 0a 00 00       	mov    %eax,0xae4
}
 707:	5e                   	pop    %esi
 708:	5f                   	pop    %edi
 709:	5d                   	pop    %ebp
 70a:	c3                   	ret    
 70b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 70f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 710:	8b 7a 04             	mov    0x4(%edx),%edi
 713:	01 fe                	add    %edi,%esi
 715:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 718:	8b 10                	mov    (%eax),%edx
 71a:	8b 12                	mov    (%edx),%edx
 71c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 71f:	8b 50 04             	mov    0x4(%eax),%edx
 722:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 725:	39 f1                	cmp    %esi,%ecx
 727:	75 d6                	jne    6ff <free+0x4f>
  freep = p;
 729:	a3 e4 0a 00 00       	mov    %eax,0xae4
    p->s.size += bp->s.size;
 72e:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 731:	01 ca                	add    %ecx,%edx
 733:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 736:	8b 53 f8             	mov    -0x8(%ebx),%edx
 739:	89 10                	mov    %edx,(%eax)
}
 73b:	5b                   	pop    %ebx
 73c:	5e                   	pop    %esi
 73d:	5f                   	pop    %edi
 73e:	5d                   	pop    %ebp
 73f:	c3                   	ret    

00000740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 749:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 74c:	8b 3d e4 0a 00 00    	mov    0xae4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 752:	8d 70 07             	lea    0x7(%eax),%esi
 755:	c1 ee 03             	shr    $0x3,%esi
 758:	46                   	inc    %esi
  if((prevp = freep) == 0){
 759:	85 ff                	test   %edi,%edi
 75b:	0f 84 9f 00 00 00    	je     800 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 761:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 763:	8b 48 04             	mov    0x4(%eax),%ecx
 766:	39 f1                	cmp    %esi,%ecx
 768:	73 6c                	jae    7d6 <malloc+0x96>
 76a:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 770:	bb 00 10 00 00       	mov    $0x1000,%ebx
 775:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 778:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 77f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 782:	eb 1d                	jmp    7a1 <malloc+0x61>
 784:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 790:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 792:	8b 4a 04             	mov    0x4(%edx),%ecx
 795:	39 f1                	cmp    %esi,%ecx
 797:	73 47                	jae    7e0 <malloc+0xa0>
 799:	8b 3d e4 0a 00 00    	mov    0xae4,%edi
 79f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a1:	39 c7                	cmp    %eax,%edi
 7a3:	75 eb                	jne    790 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7a8:	89 04 24             	mov    %eax,(%esp)
 7ab:	e8 2b fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 7b0:	83 f8 ff             	cmp    $0xffffffff,%eax
 7b3:	74 17                	je     7cc <malloc+0x8c>
  hp->s.size = nu;
 7b5:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7b8:	83 c0 08             	add    $0x8,%eax
 7bb:	89 04 24             	mov    %eax,(%esp)
 7be:	e8 ed fe ff ff       	call   6b0 <free>
  return freep;
 7c3:	a1 e4 0a 00 00       	mov    0xae4,%eax
      if((p = morecore(nunits)) == 0)
 7c8:	85 c0                	test   %eax,%eax
 7ca:	75 c4                	jne    790 <malloc+0x50>
        return 0;
  }
}
 7cc:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 7cf:	31 c0                	xor    %eax,%eax
}
 7d1:	5b                   	pop    %ebx
 7d2:	5e                   	pop    %esi
 7d3:	5f                   	pop    %edi
 7d4:	5d                   	pop    %ebp
 7d5:	c3                   	ret    
    if(p->s.size >= nunits){
 7d6:	89 c2                	mov    %eax,%edx
 7d8:	89 f8                	mov    %edi,%eax
 7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7e0:	39 ce                	cmp    %ecx,%esi
 7e2:	74 4c                	je     830 <malloc+0xf0>
        p->s.size -= nunits;
 7e4:	29 f1                	sub    %esi,%ecx
 7e6:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 7e9:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7ec:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 7ef:	a3 e4 0a 00 00       	mov    %eax,0xae4
      return (void*)(p + 1);
 7f4:	8d 42 08             	lea    0x8(%edx),%eax
}
 7f7:	83 c4 2c             	add    $0x2c,%esp
 7fa:	5b                   	pop    %ebx
 7fb:	5e                   	pop    %esi
 7fc:	5f                   	pop    %edi
 7fd:	5d                   	pop    %ebp
 7fe:	c3                   	ret    
 7ff:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 800:	b8 e8 0a 00 00       	mov    $0xae8,%eax
 805:	ba e8 0a 00 00       	mov    $0xae8,%edx
 80a:	a3 e4 0a 00 00       	mov    %eax,0xae4
    base.s.size = 0;
 80f:	31 c9                	xor    %ecx,%ecx
 811:	bf e8 0a 00 00       	mov    $0xae8,%edi
    base.s.ptr = freep = prevp = &base;
 816:	89 15 e8 0a 00 00    	mov    %edx,0xae8
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81c:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 81e:	89 0d ec 0a 00 00    	mov    %ecx,0xaec
    if(p->s.size >= nunits){
 824:	e9 41 ff ff ff       	jmp    76a <malloc+0x2a>
 829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 830:	8b 0a                	mov    (%edx),%ecx
 832:	89 08                	mov    %ecx,(%eax)
 834:	eb b9                	jmp    7ef <malloc+0xaf>
