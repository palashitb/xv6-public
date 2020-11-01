
_benchmark:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"

int number_of_processes = 1;

int main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 20             	sub    $0x20,%esp
  int j;
  for (j = 0; j < number_of_processes; j++)
   c:	8b 1d 2c 0b 00 00    	mov    0xb2c,%ebx
  12:	85 db                	test   %ebx,%ebx
  14:	7e 67                	jle    7d <main+0x7d>
  16:	31 db                	xor    %ebx,%ebx
    //   printf(1, "Process: %d Finished\n", j);
      exit();
    }
    else{
      printf(1, "haha\n");
      set_priority(pid, 100-(20+j)); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
  18:	bf 50 00 00 00       	mov    $0x50,%edi
  1d:	eb 35                	jmp    54 <main+0x54>
  1f:	90                   	nop
    if (pid == 0)
  20:	0f 84 81 00 00 00    	je     a7 <main+0xa7>
      printf(1, "haha\n");
  26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  2d:	b8 85 08 00 00       	mov    $0x885,%eax
  32:	89 44 24 04          	mov    %eax,0x4(%esp)
  36:	e8 d5 04 00 00       	call   510 <printf>
      set_priority(pid, 100-(20+j)); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
  3b:	89 f8                	mov    %edi,%eax
  3d:	89 34 24             	mov    %esi,(%esp)
  40:	29 d8                	sub    %ebx,%eax
  for (j = 0; j < number_of_processes; j++)
  42:	43                   	inc    %ebx
      set_priority(pid, 100-(20+j)); // will only matter for PBS, comment it out if not implemented yet (better priorty for more IO intensive jobs)
  43:	89 44 24 04          	mov    %eax,0x4(%esp)
  47:	e8 df 03 00 00       	call   42b <set_priority>
  for (j = 0; j < number_of_processes; j++)
  4c:	39 1d 2c 0b 00 00    	cmp    %ebx,0xb2c
  52:	7e 29                	jle    7d <main+0x7d>
    int pid = fork();
  54:	e8 22 03 00 00       	call   37b <fork>
    if (pid < 0)
  59:	85 c0                	test   %eax,%eax
    int pid = fork();
  5b:	89 c6                	mov    %eax,%esi
    if (pid < 0)
  5d:	79 c1                	jns    20 <main+0x20>
      printf(1, "Fork failed\n");
  5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  66:	b9 78 08 00 00       	mov    $0x878,%ecx
  for (j = 0; j < number_of_processes; j++)
  6b:	43                   	inc    %ebx
      printf(1, "Fork failed\n");
  6c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  70:	e8 9b 04 00 00       	call   510 <printf>
  for (j = 0; j < number_of_processes; j++)
  75:	39 1d 2c 0b 00 00    	cmp    %ebx,0xb2c
  7b:	7f d7                	jg     54 <main+0x54>
    }
  }
  for (j = 0; j < number_of_processes+5; j++)
  7d:	83 3d 2c 0b 00 00 fc 	cmpl   $0xfffffffc,0xb2c
  84:	7c 1c                	jl     a2 <main+0xa2>
  86:	31 db                	xor    %ebx,%ebx
  88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8f:	90                   	nop
  {
    wait();
  90:	e8 f6 02 00 00       	call   38b <wait>
  for (j = 0; j < number_of_processes+5; j++)
  95:	a1 2c 0b 00 00       	mov    0xb2c,%eax
  9a:	43                   	inc    %ebx
  9b:	83 c0 04             	add    $0x4,%eax
  9e:	39 d8                	cmp    %ebx,%eax
  a0:	7d ee                	jge    90 <main+0x90>
      exit();
  a2:	e8 dc 02 00 00       	call   383 <exit>
      for (volatile int k = 0; k < number_of_processes; k++)
  a7:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  ae:	00 
  af:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  b3:	3b 05 2c 0b 00 00    	cmp    0xb2c,%eax
  b9:	7c 26                	jl     e1 <main+0xe1>
  bb:	eb e5                	jmp    a2 <main+0xa2>
  bd:	8d 76 00             	lea    0x0(%esi),%esi
          sleep(200); //io time
  c0:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
  c7:	e8 47 03 00 00       	call   413 <sleep>
      for (volatile int k = 0; k < number_of_processes; k++)
  cc:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  d0:	40                   	inc    %eax
  d1:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  d5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  d9:	3b 05 2c 0b 00 00    	cmp    0xb2c,%eax
  df:	7d c1                	jge    a2 <main+0xa2>
        if (k <= j)
  e1:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  e5:	39 d8                	cmp    %ebx,%eax
  e7:	7e d7                	jle    c0 <main+0xc0>
          for (i = 0; i < 100000000; i++)
  e9:	31 d2                	xor    %edx,%edx
  eb:	89 54 24 18          	mov    %edx,0x18(%esp)
  ef:	8b 44 24 18          	mov    0x18(%esp),%eax
  f3:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
  f8:	7f d2                	jg     cc <main+0xcc>
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 100:	8b 44 24 18          	mov    0x18(%esp),%eax
 104:	40                   	inc    %eax
 105:	89 44 24 18          	mov    %eax,0x18(%esp)
 109:	8b 44 24 18          	mov    0x18(%esp),%eax
 10d:	3d ff e0 f5 05       	cmp    $0x5f5e0ff,%eax
 112:	7e ec                	jle    100 <main+0x100>
 114:	eb b6                	jmp    cc <main+0xcc>
 116:	66 90                	xchg   %ax,%ax
 118:	66 90                	xchg   %ax,%ax
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	40                   	inc    %eax
 138:	84 d2                	test   %dl,%dl
 13a:	75 f4                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13c:	5b                   	pop    %ebx
 13d:	89 c8                	mov    %ecx,%eax
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 148:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14f:	90                   	nop

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 5d 08             	mov    0x8(%ebp),%ebx
 157:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 15a:	0f b6 03             	movzbl (%ebx),%eax
 15d:	0f b6 0a             	movzbl (%edx),%ecx
 160:	84 c0                	test   %al,%al
 162:	75 19                	jne    17d <strcmp+0x2d>
 164:	eb 2a                	jmp    190 <strcmp+0x40>
 166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
 174:	43                   	inc    %ebx
 175:	42                   	inc    %edx
  while(*p && *p == *q)
 176:	0f b6 0a             	movzbl (%edx),%ecx
 179:	84 c0                	test   %al,%al
 17b:	74 13                	je     190 <strcmp+0x40>
 17d:	38 c8                	cmp    %cl,%al
 17f:	74 ef                	je     170 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 181:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 182:	29 c8                	sub    %ecx,%eax
}
 184:	5d                   	pop    %ebp
 185:	c3                   	ret    
 186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	5b                   	pop    %ebx
 191:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 193:	29 c8                	sub    %ecx,%eax
}
 195:	5d                   	pop    %ebp
 196:	c3                   	ret    
 197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19e:	66 90                	xchg   %ax,%ax

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	40                   	inc    %eax
 1b1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b5:	89 c1                	mov    %eax,%ecx
 1b7:	75 f7                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1b9:	5d                   	pop    %ebp
 1ba:	89 c8                	mov    %ecx,%eax
 1bc:	c3                   	ret    
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 1c1:	31 c9                	xor    %ecx,%ecx
}
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret    
 1c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
 1d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	5f                   	pop    %edi
 1e3:	89 d0                	mov    %edx,%eax
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 18                	jne    219 <strchr+0x29>
 201:	eb 1d                	jmp    220 <strchr+0x30>
 203:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 210:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 214:	40                   	inc    %eax
 215:	84 d2                	test   %dl,%dl
 217:	74 07                	je     220 <strchr+0x30>
    if(*s == c)
 219:	38 d1                	cmp    %dl,%cl
 21b:	75 f3                	jne    210 <strchr+0x20>
      return (char*)s;
  return 0;
}
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret    
 21f:	90                   	nop
 220:	5d                   	pop    %ebp
  return 0;
 221:	31 c0                	xor    %eax,%eax
}
 223:	c3                   	ret    
 224:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
 235:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 236:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 238:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 23b:	83 ec 3c             	sub    $0x3c,%esp
 23e:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 241:	eb 3a                	jmp    27d <gets+0x4d>
 243:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 250:	89 7c 24 04          	mov    %edi,0x4(%esp)
 254:	ba 01 00 00 00       	mov    $0x1,%edx
 259:	89 54 24 08          	mov    %edx,0x8(%esp)
 25d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 264:	e8 32 01 00 00       	call   39b <read>
    if(cc < 1)
 269:	85 c0                	test   %eax,%eax
 26b:	7e 19                	jle    286 <gets+0x56>
      break;
    buf[i++] = c;
 26d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 271:	46                   	inc    %esi
 272:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 275:	3c 0a                	cmp    $0xa,%al
 277:	74 27                	je     2a0 <gets+0x70>
 279:	3c 0d                	cmp    $0xd,%al
 27b:	74 23                	je     2a0 <gets+0x70>
  for(i=0; i+1 < max; ){
 27d:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 280:	43                   	inc    %ebx
 281:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 284:	7c ca                	jl     250 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 286:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 289:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	83 c4 3c             	add    $0x3c,%esp
 292:	5b                   	pop    %ebx
 293:	5e                   	pop    %esi
 294:	5f                   	pop    %edi
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29e:	66 90                	xchg   %ax,%ax
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
 2a3:	01 c3                	add    %eax,%ebx
 2a5:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 2a8:	eb dc                	jmp    286 <gets+0x56>
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b1:	31 c0                	xor    %eax,%eax
{
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 2b8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
{
 2bf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2c2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2c5:	89 04 24             	mov    %eax,(%esp)
 2c8:	e8 f6 00 00 00       	call   3c3 <open>
  if(fd < 0)
 2cd:	85 c0                	test   %eax,%eax
 2cf:	78 2f                	js     300 <stat+0x50>
 2d1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2d3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d6:	89 1c 24             	mov    %ebx,(%esp)
 2d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2dd:	e8 f9 00 00 00       	call   3db <fstat>
  close(fd);
 2e2:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2e5:	89 c6                	mov    %eax,%esi
  close(fd);
 2e7:	e8 bf 00 00 00       	call   3ab <close>
  return r;
}
 2ec:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2ef:	89 f0                	mov    %esi,%eax
 2f1:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2f4:	89 ec                	mov    %ebp,%esp
 2f6:	5d                   	pop    %ebp
 2f7:	c3                   	ret    
 2f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ff:	90                   	nop
    return -1;
 300:	be ff ff ff ff       	mov    $0xffffffff,%esi
 305:	eb e5                	jmp    2ec <stat+0x3c>
 307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30e:	66 90                	xchg   %ax,%ax

00000310 <atoi>:

int
atoi(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	53                   	push   %ebx
 314:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 317:	0f be 02             	movsbl (%edx),%eax
 31a:	88 c1                	mov    %al,%cl
 31c:	80 e9 30             	sub    $0x30,%cl
 31f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 322:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 327:	77 1c                	ja     345 <atoi+0x35>
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 330:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 333:	42                   	inc    %edx
 334:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 338:	0f be 02             	movsbl (%edx),%eax
 33b:	88 c3                	mov    %al,%bl
 33d:	80 eb 30             	sub    $0x30,%bl
 340:	80 fb 09             	cmp    $0x9,%bl
 343:	76 eb                	jbe    330 <atoi+0x20>
  return n;
}
 345:	5b                   	pop    %ebx
 346:	89 c8                	mov    %ecx,%eax
 348:	5d                   	pop    %ebp
 349:	c3                   	ret    
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000350 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	8b 45 10             	mov    0x10(%ebp),%eax
 357:	56                   	push   %esi
 358:	8b 55 08             	mov    0x8(%ebp),%edx
 35b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35e:	85 c0                	test   %eax,%eax
 360:	7e 13                	jle    375 <memmove+0x25>
 362:	01 d0                	add    %edx,%eax
  dst = vdst;
 364:	89 d7                	mov    %edx,%edi
 366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 370:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 371:	39 f8                	cmp    %edi,%eax
 373:	75 fb                	jne    370 <memmove+0x20>
  return vdst;
}
 375:	5e                   	pop    %esi
 376:	89 d0                	mov    %edx,%eax
 378:	5f                   	pop    %edi
 379:	5d                   	pop    %ebp
 37a:	c3                   	ret    

0000037b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 37b:	b8 01 00 00 00       	mov    $0x1,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <exit>:
SYSCALL(exit)
 383:	b8 02 00 00 00       	mov    $0x2,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <wait>:
SYSCALL(wait)
 38b:	b8 03 00 00 00       	mov    $0x3,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <pipe>:
SYSCALL(pipe)
 393:	b8 04 00 00 00       	mov    $0x4,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <read>:
SYSCALL(read)
 39b:	b8 05 00 00 00       	mov    $0x5,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <write>:
SYSCALL(write)
 3a3:	b8 10 00 00 00       	mov    $0x10,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <close>:
SYSCALL(close)
 3ab:	b8 15 00 00 00       	mov    $0x15,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <kill>:
SYSCALL(kill)
 3b3:	b8 06 00 00 00       	mov    $0x6,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <exec>:
SYSCALL(exec)
 3bb:	b8 07 00 00 00       	mov    $0x7,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <open>:
SYSCALL(open)
 3c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <mknod>:
SYSCALL(mknod)
 3cb:	b8 11 00 00 00       	mov    $0x11,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <unlink>:
SYSCALL(unlink)
 3d3:	b8 12 00 00 00       	mov    $0x12,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <fstat>:
SYSCALL(fstat)
 3db:	b8 08 00 00 00       	mov    $0x8,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <link>:
SYSCALL(link)
 3e3:	b8 13 00 00 00       	mov    $0x13,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <mkdir>:
SYSCALL(mkdir)
 3eb:	b8 14 00 00 00       	mov    $0x14,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <chdir>:
SYSCALL(chdir)
 3f3:	b8 09 00 00 00       	mov    $0x9,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <dup>:
SYSCALL(dup)
 3fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <getpid>:
SYSCALL(getpid)
 403:	b8 0b 00 00 00       	mov    $0xb,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <sbrk>:
SYSCALL(sbrk)
 40b:	b8 0c 00 00 00       	mov    $0xc,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <sleep>:
SYSCALL(sleep)
 413:	b8 0d 00 00 00       	mov    $0xd,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <uptime>:
SYSCALL(uptime)
 41b:	b8 0e 00 00 00       	mov    $0xe,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <waitx>:
SYSCALL(waitx)
 423:	b8 16 00 00 00       	mov    $0x16,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <set_priority>:
SYSCALL(set_priority)
 42b:	b8 17 00 00 00       	mov    $0x17,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <pls>:
SYSCALL(pls)
 433:	b8 18 00 00 00       	mov    $0x18,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    
 43b:	66 90                	xchg   %ax,%ax
 43d:	66 90                	xchg   %ax,%ax
 43f:	90                   	nop

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	89 cf                	mov    %ecx,%edi
 446:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 447:	89 d1                	mov    %edx,%ecx
{
 449:	53                   	push   %ebx
 44a:	83 ec 4c             	sub    $0x4c,%esp
 44d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 450:	89 d0                	mov    %edx,%eax
 452:	c1 e8 1f             	shr    $0x1f,%eax
 455:	84 c0                	test   %al,%al
 457:	0f 84 a3 00 00 00    	je     500 <printint+0xc0>
 45d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 461:	0f 84 99 00 00 00    	je     500 <printint+0xc0>
    neg = 1;
 467:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 46e:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 470:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 477:	8d 75 d7             	lea    -0x29(%ebp),%esi
 47a:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 47d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 480:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 483:	31 d2                	xor    %edx,%edx
 485:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 488:	f7 f7                	div    %edi
 48a:	8d 4b 01             	lea    0x1(%ebx),%ecx
 48d:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 490:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 493:	39 cf                	cmp    %ecx,%edi
 495:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 498:	0f b6 92 94 08 00 00 	movzbl 0x894(%edx),%edx
 49f:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 4a3:	76 db                	jbe    480 <printint+0x40>
  if(neg)
 4a5:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4a8:	85 c9                	test   %ecx,%ecx
 4aa:	74 0c                	je     4b8 <printint+0x78>
    buf[i++] = '-';
 4ac:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4af:	b2 2d                	mov    $0x2d,%dl
 4b1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 4b6:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 4b8:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4bb:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 4bf:	eb 13                	jmp    4d4 <printint+0x94>
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop
 4d0:	0f b6 13             	movzbl (%ebx),%edx
 4d3:	4b                   	dec    %ebx
  write(fd, &c, 1);
 4d4:	89 74 24 04          	mov    %esi,0x4(%esp)
 4d8:	b8 01 00 00 00       	mov    $0x1,%eax
 4dd:	89 44 24 08          	mov    %eax,0x8(%esp)
 4e1:	89 3c 24             	mov    %edi,(%esp)
 4e4:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4e7:	e8 b7 fe ff ff       	call   3a3 <write>
  while(--i >= 0)
 4ec:	39 de                	cmp    %ebx,%esi
 4ee:	75 e0                	jne    4d0 <printint+0x90>
    putc(fd, buf[i]);
}
 4f0:	83 c4 4c             	add    $0x4c,%esp
 4f3:	5b                   	pop    %ebx
 4f4:	5e                   	pop    %esi
 4f5:	5f                   	pop    %edi
 4f6:	5d                   	pop    %ebp
 4f7:	c3                   	ret    
 4f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ff:	90                   	nop
  neg = 0;
 500:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 507:	e9 64 ff ff ff       	jmp    470 <printint+0x30>
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000510 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 519:	8b 75 0c             	mov    0xc(%ebp),%esi
 51c:	0f b6 1e             	movzbl (%esi),%ebx
 51f:	84 db                	test   %bl,%bl
 521:	0f 84 c8 00 00 00    	je     5ef <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 527:	8d 45 10             	lea    0x10(%ebp),%eax
 52a:	46                   	inc    %esi
 52b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 52e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 531:	31 d2                	xor    %edx,%edx
 533:	eb 3e                	jmp    573 <printf+0x63>
 535:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 540:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 543:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 546:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 54b:	74 1e                	je     56b <printf+0x5b>
  write(fd, &c, 1);
 54d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 551:	b8 01 00 00 00       	mov    $0x1,%eax
 556:	89 44 24 08          	mov    %eax,0x8(%esp)
 55a:	8b 45 08             	mov    0x8(%ebp),%eax
 55d:	88 5d e7             	mov    %bl,-0x19(%ebp)
 560:	89 04 24             	mov    %eax,(%esp)
 563:	e8 3b fe ff ff       	call   3a3 <write>
 568:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 56b:	0f b6 1e             	movzbl (%esi),%ebx
 56e:	46                   	inc    %esi
 56f:	84 db                	test   %bl,%bl
 571:	74 7c                	je     5ef <printf+0xdf>
    if(state == 0){
 573:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 575:	0f be cb             	movsbl %bl,%ecx
 578:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 57b:	74 c3                	je     540 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 57d:	83 fa 25             	cmp    $0x25,%edx
 580:	75 e9                	jne    56b <printf+0x5b>
      if(c == 'd'){
 582:	83 f8 64             	cmp    $0x64,%eax
 585:	0f 84 a5 00 00 00    	je     630 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 58b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 591:	83 f9 70             	cmp    $0x70,%ecx
 594:	74 6a                	je     600 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 596:	83 f8 73             	cmp    $0x73,%eax
 599:	0f 84 e1 00 00 00    	je     680 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 59f:	83 f8 63             	cmp    $0x63,%eax
 5a2:	0f 84 98 00 00 00    	je     640 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5a8:	83 f8 25             	cmp    $0x25,%eax
 5ab:	74 1c                	je     5c9 <printf+0xb9>
  write(fd, &c, 1);
 5ad:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5b1:	8b 45 08             	mov    0x8(%ebp),%eax
 5b4:	ba 01 00 00 00       	mov    $0x1,%edx
 5b9:	89 54 24 08          	mov    %edx,0x8(%esp)
 5bd:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5c1:	89 04 24             	mov    %eax,(%esp)
 5c4:	e8 da fd ff ff       	call   3a3 <write>
 5c9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5cd:	b8 01 00 00 00       	mov    $0x1,%eax
 5d2:	46                   	inc    %esi
 5d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 5d7:	8b 45 08             	mov    0x8(%ebp),%eax
 5da:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5dd:	89 04 24             	mov    %eax,(%esp)
 5e0:	e8 be fd ff ff       	call   3a3 <write>
  for(i = 0; fmt[i]; i++){
 5e5:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5eb:	84 db                	test   %bl,%bl
 5ed:	75 84                	jne    573 <printf+0x63>
    }
  }
}
 5ef:	83 c4 3c             	add    $0x3c,%esp
 5f2:	5b                   	pop    %ebx
 5f3:	5e                   	pop    %esi
 5f4:	5f                   	pop    %edi
 5f5:	5d                   	pop    %ebp
 5f6:	c3                   	ret    
 5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 600:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 607:	b9 10 00 00 00       	mov    $0x10,%ecx
 60c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 60f:	8b 45 08             	mov    0x8(%ebp),%eax
 612:	8b 13                	mov    (%ebx),%edx
 614:	e8 27 fe ff ff       	call   440 <printint>
        ap++;
 619:	89 d8                	mov    %ebx,%eax
      state = 0;
 61b:	31 d2                	xor    %edx,%edx
        ap++;
 61d:	83 c0 04             	add    $0x4,%eax
 620:	89 45 d0             	mov    %eax,-0x30(%ebp)
 623:	e9 43 ff ff ff       	jmp    56b <printf+0x5b>
 628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop
        printint(fd, *ap, 10, 1);
 630:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 637:	b9 0a 00 00 00       	mov    $0xa,%ecx
 63c:	eb ce                	jmp    60c <printf+0xfc>
 63e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 640:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 643:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 648:	8b 03                	mov    (%ebx),%eax
        ap++;
 64a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 64d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 651:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 655:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 658:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 65c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 65f:	8b 45 08             	mov    0x8(%ebp),%eax
 662:	89 04 24             	mov    %eax,(%esp)
 665:	e8 39 fd ff ff       	call   3a3 <write>
      state = 0;
 66a:	31 d2                	xor    %edx,%edx
        ap++;
 66c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 66f:	e9 f7 fe ff ff       	jmp    56b <printf+0x5b>
 674:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
        s = (char*)*ap;
 680:	8b 45 d0             	mov    -0x30(%ebp),%eax
 683:	8b 18                	mov    (%eax),%ebx
        ap++;
 685:	83 c0 04             	add    $0x4,%eax
 688:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 68b:	85 db                	test   %ebx,%ebx
 68d:	74 11                	je     6a0 <printf+0x190>
        while(*s != 0){
 68f:	0f b6 03             	movzbl (%ebx),%eax
 692:	84 c0                	test   %al,%al
 694:	74 44                	je     6da <printf+0x1ca>
 696:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 699:	89 de                	mov    %ebx,%esi
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 69e:	eb 10                	jmp    6b0 <printf+0x1a0>
 6a0:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 6a3:	bb 8b 08 00 00       	mov    $0x88b,%ebx
        while(*s != 0){
 6a8:	b0 28                	mov    $0x28,%al
 6aa:	89 de                	mov    %ebx,%esi
 6ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6af:	90                   	nop
          putc(fd, *s);
 6b0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6b3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 6b8:	46                   	inc    %esi
  write(fd, &c, 1);
 6b9:	89 44 24 08          	mov    %eax,0x8(%esp)
 6bd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6c1:	89 1c 24             	mov    %ebx,(%esp)
 6c4:	e8 da fc ff ff       	call   3a3 <write>
        while(*s != 0){
 6c9:	0f b6 06             	movzbl (%esi),%eax
 6cc:	84 c0                	test   %al,%al
 6ce:	75 e0                	jne    6b0 <printf+0x1a0>
 6d0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6d3:	31 d2                	xor    %edx,%edx
 6d5:	e9 91 fe ff ff       	jmp    56b <printf+0x5b>
 6da:	31 d2                	xor    %edx,%edx
 6dc:	e9 8a fe ff ff       	jmp    56b <printf+0x5b>
 6e1:	66 90                	xchg   %ax,%ax
 6e3:	66 90                	xchg   %ax,%ax
 6e5:	66 90                	xchg   %ax,%ax
 6e7:	66 90                	xchg   %ax,%ax
 6e9:	66 90                	xchg   %ax,%ax
 6eb:	66 90                	xchg   %ax,%ax
 6ed:	66 90                	xchg   %ax,%ax
 6ef:	90                   	nop

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	a1 30 0b 00 00       	mov    0xb30,%eax
{
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	57                   	push   %edi
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6fe:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 700:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 703:	39 c8                	cmp    %ecx,%eax
 705:	73 19                	jae    720 <free+0x30>
 707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70e:	66 90                	xchg   %ax,%ax
 710:	39 d1                	cmp    %edx,%ecx
 712:	72 14                	jb     728 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	39 d0                	cmp    %edx,%eax
 716:	73 10                	jae    728 <free+0x38>
{
 718:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71a:	39 c8                	cmp    %ecx,%eax
 71c:	8b 10                	mov    (%eax),%edx
 71e:	72 f0                	jb     710 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	39 d0                	cmp    %edx,%eax
 722:	72 f4                	jb     718 <free+0x28>
 724:	39 d1                	cmp    %edx,%ecx
 726:	73 f0                	jae    718 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 728:	8b 73 fc             	mov    -0x4(%ebx),%esi
 72b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 72e:	39 fa                	cmp    %edi,%edx
 730:	74 1e                	je     750 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 732:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 735:	8b 50 04             	mov    0x4(%eax),%edx
 738:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 73b:	39 f1                	cmp    %esi,%ecx
 73d:	74 2a                	je     769 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 73f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 741:	5b                   	pop    %ebx
  freep = p;
 742:	a3 30 0b 00 00       	mov    %eax,0xb30
}
 747:	5e                   	pop    %esi
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 750:	8b 7a 04             	mov    0x4(%edx),%edi
 753:	01 fe                	add    %edi,%esi
 755:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 758:	8b 10                	mov    (%eax),%edx
 75a:	8b 12                	mov    (%edx),%edx
 75c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 75f:	8b 50 04             	mov    0x4(%eax),%edx
 762:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 765:	39 f1                	cmp    %esi,%ecx
 767:	75 d6                	jne    73f <free+0x4f>
  freep = p;
 769:	a3 30 0b 00 00       	mov    %eax,0xb30
    p->s.size += bp->s.size;
 76e:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 771:	01 ca                	add    %ecx,%edx
 773:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 776:	8b 53 f8             	mov    -0x8(%ebx),%edx
 779:	89 10                	mov    %edx,(%eax)
}
 77b:	5b                   	pop    %ebx
 77c:	5e                   	pop    %esi
 77d:	5f                   	pop    %edi
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 3d 30 0b 00 00    	mov    0xb30,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	8d 70 07             	lea    0x7(%eax),%esi
 795:	c1 ee 03             	shr    $0x3,%esi
 798:	46                   	inc    %esi
  if((prevp = freep) == 0){
 799:	85 ff                	test   %edi,%edi
 79b:	0f 84 9f 00 00 00    	je     840 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a1:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7a3:	8b 48 04             	mov    0x4(%eax),%ecx
 7a6:	39 f1                	cmp    %esi,%ecx
 7a8:	73 6c                	jae    816 <malloc+0x96>
 7aa:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7b0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7b5:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7b8:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7bf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7c2:	eb 1d                	jmp    7e1 <malloc+0x61>
 7c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7cf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7d2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7d5:	39 f1                	cmp    %esi,%ecx
 7d7:	73 47                	jae    820 <malloc+0xa0>
 7d9:	8b 3d 30 0b 00 00    	mov    0xb30,%edi
 7df:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7e1:	39 c7                	cmp    %eax,%edi
 7e3:	75 eb                	jne    7d0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e8:	89 04 24             	mov    %eax,(%esp)
 7eb:	e8 1b fc ff ff       	call   40b <sbrk>
  if(p == (char*)-1)
 7f0:	83 f8 ff             	cmp    $0xffffffff,%eax
 7f3:	74 17                	je     80c <malloc+0x8c>
  hp->s.size = nu;
 7f5:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7f8:	83 c0 08             	add    $0x8,%eax
 7fb:	89 04 24             	mov    %eax,(%esp)
 7fe:	e8 ed fe ff ff       	call   6f0 <free>
  return freep;
 803:	a1 30 0b 00 00       	mov    0xb30,%eax
      if((p = morecore(nunits)) == 0)
 808:	85 c0                	test   %eax,%eax
 80a:	75 c4                	jne    7d0 <malloc+0x50>
        return 0;
  }
}
 80c:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 80f:	31 c0                	xor    %eax,%eax
}
 811:	5b                   	pop    %ebx
 812:	5e                   	pop    %esi
 813:	5f                   	pop    %edi
 814:	5d                   	pop    %ebp
 815:	c3                   	ret    
    if(p->s.size >= nunits){
 816:	89 c2                	mov    %eax,%edx
 818:	89 f8                	mov    %edi,%eax
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 820:	39 ce                	cmp    %ecx,%esi
 822:	74 4c                	je     870 <malloc+0xf0>
        p->s.size -= nunits;
 824:	29 f1                	sub    %esi,%ecx
 826:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 829:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 82c:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 82f:	a3 30 0b 00 00       	mov    %eax,0xb30
      return (void*)(p + 1);
 834:	8d 42 08             	lea    0x8(%edx),%eax
}
 837:	83 c4 2c             	add    $0x2c,%esp
 83a:	5b                   	pop    %ebx
 83b:	5e                   	pop    %esi
 83c:	5f                   	pop    %edi
 83d:	5d                   	pop    %ebp
 83e:	c3                   	ret    
 83f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 840:	b8 34 0b 00 00       	mov    $0xb34,%eax
 845:	ba 34 0b 00 00       	mov    $0xb34,%edx
 84a:	a3 30 0b 00 00       	mov    %eax,0xb30
    base.s.size = 0;
 84f:	31 c9                	xor    %ecx,%ecx
 851:	bf 34 0b 00 00       	mov    $0xb34,%edi
    base.s.ptr = freep = prevp = &base;
 856:	89 15 34 0b 00 00    	mov    %edx,0xb34
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85c:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 85e:	89 0d 38 0b 00 00    	mov    %ecx,0xb38
    if(p->s.size >= nunits){
 864:	e9 41 ff ff ff       	jmp    7aa <malloc+0x2a>
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 870:	8b 0a                	mov    (%edx),%ecx
 872:	89 08                	mov    %ecx,(%eax)
 874:	eb b9                	jmp    82f <malloc+0xaf>
