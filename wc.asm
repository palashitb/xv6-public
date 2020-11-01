
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
  int fd, i;

  if(argc <= 1){
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  10:	7e 65                	jle    77 <main+0x77>
  12:	8b 45 0c             	mov    0xc(%ebp),%eax
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  15:	be 01 00 00 00       	mov    $0x1,%esi
  1a:	8d 78 04             	lea    0x4(%eax),%edi
  1d:	8d 76 00             	lea    0x0(%esi),%esi
    if((fd = open(argv[i], 0)) < 0){
  20:	31 c0                	xor    %eax,%eax
  22:	89 44 24 04          	mov    %eax,0x4(%esp)
  26:	8b 07                	mov    (%edi),%eax
  28:	89 04 24             	mov    %eax,(%esp)
  2b:	e8 13 04 00 00       	call   443 <open>
  30:	89 c3                	mov    %eax,%ebx
      printf(1, "wc: cannot open %s\n", argv[i]);
  32:	8b 07                	mov    (%edi),%eax
    if((fd = open(argv[i], 0)) < 0){
  34:	85 db                	test   %ebx,%ebx
  36:	78 22                	js     5a <main+0x5a>
      exit();
    }
    wc(fd, argv[i]);
  38:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(i = 1; i < argc; i++){
  3c:	46                   	inc    %esi
  3d:	83 c7 04             	add    $0x4,%edi
    wc(fd, argv[i]);
  40:	89 1c 24             	mov    %ebx,(%esp)
  43:	e8 48 00 00 00       	call   90 <wc>
    close(fd);
  48:	89 1c 24             	mov    %ebx,(%esp)
  4b:	e8 db 03 00 00       	call   42b <close>
  for(i = 1; i < argc; i++){
  50:	39 75 08             	cmp    %esi,0x8(%ebp)
  53:	75 cb                	jne    20 <main+0x20>
  }
  exit();
  55:	e8 a9 03 00 00       	call   403 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  5a:	89 44 24 08          	mov    %eax,0x8(%esp)
  5e:	c7 44 24 04 1b 09 00 	movl   $0x91b,0x4(%esp)
  65:	00 
  66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6d:	e8 1e 05 00 00       	call   590 <printf>
      exit();
  72:	e8 8c 03 00 00       	call   403 <exit>
    wc(0, "");
  77:	c7 44 24 04 0d 09 00 	movl   $0x90d,0x4(%esp)
  7e:	00 
  7f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  86:	e8 05 00 00 00       	call   90 <wc>
    exit();
  8b:	e8 73 03 00 00       	call   403 <exit>

00000090 <wc>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	56                   	push   %esi
  95:	53                   	push   %ebx
  l = w = c = 0;
  96:	31 db                	xor    %ebx,%ebx
{
  98:	83 ec 3c             	sub    $0x3c,%esp
  inword = 0;
  9b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  a2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  a9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	ba 00 02 00 00       	mov    $0x200,%edx
  b8:	b9 20 0c 00 00       	mov    $0xc20,%ecx
  bd:	89 54 24 08          	mov    %edx,0x8(%esp)
  c1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  c5:	89 04 24             	mov    %eax,(%esp)
  c8:	e8 4e 03 00 00       	call   41b <read>
  cd:	85 c0                	test   %eax,%eax
  cf:	89 c6                	mov    %eax,%esi
  d1:	7e 6d                	jle    140 <wc+0xb0>
    for(i=0; i<n; i++){
  d3:	31 ff                	xor    %edi,%edi
  d5:	eb 15                	jmp    ec <wc+0x5c>
  d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  de:	66 90                	xchg   %ax,%ax
        inword = 0;
  e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  e7:	47                   	inc    %edi
  e8:	39 fe                	cmp    %edi,%esi
  ea:	74 44                	je     130 <wc+0xa0>
      if(strchr(" \r\t\n\v", buf[i]))
  ec:	c7 04 24 f8 08 00 00 	movl   $0x8f8,(%esp)
      if(buf[i] == '\n')
  f3:	0f be 87 20 0c 00 00 	movsbl 0xc20(%edi),%eax
        l++;
  fa:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
  fc:	89 44 24 04          	mov    %eax,0x4(%esp)
        l++;
 100:	3c 0a                	cmp    $0xa,%al
 102:	0f 94 c1             	sete   %cl
 105:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 107:	e8 64 01 00 00       	call   270 <strchr>
 10c:	85 c0                	test   %eax,%eax
 10e:	75 d0                	jne    e0 <wc+0x50>
      else if(!inword){
 110:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 113:	85 c0                	test   %eax,%eax
 115:	75 d0                	jne    e7 <wc+0x57>
        w++;
 117:	ff 45 e0             	incl   -0x20(%ebp)
    for(i=0; i<n; i++){
 11a:	47                   	inc    %edi
 11b:	39 fe                	cmp    %edi,%esi
        inword = 1;
 11d:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 124:	75 c6                	jne    ec <wc+0x5c>
 126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	01 75 dc             	add    %esi,-0x24(%ebp)
 133:	e9 78 ff ff ff       	jmp    b0 <wc+0x20>
 138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop
  if(n < 0){
 140:	75 36                	jne    178 <wc+0xe8>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 142:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 150:	89 44 24 14          	mov    %eax,0x14(%esp)
 154:	8b 45 dc             	mov    -0x24(%ebp),%eax
 157:	89 44 24 10          	mov    %eax,0x10(%esp)
 15b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 15e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 162:	b8 0e 09 00 00       	mov    $0x90e,%eax
 167:	89 44 24 04          	mov    %eax,0x4(%esp)
 16b:	e8 20 04 00 00       	call   590 <printf>
}
 170:	83 c4 3c             	add    $0x3c,%esp
 173:	5b                   	pop    %ebx
 174:	5e                   	pop    %esi
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
    printf(1, "wc: read error\n");
 178:	c7 44 24 04 fe 08 00 	movl   $0x8fe,0x4(%esp)
 17f:	00 
 180:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 187:	e8 04 04 00 00       	call   590 <printf>
    exit();
 18c:	e8 72 02 00 00       	call   403 <exit>
 191:	66 90                	xchg   %ax,%ax
 193:	66 90                	xchg   %ax,%ax
 195:	66 90                	xchg   %ax,%ax
 197:	66 90                	xchg   %ax,%ax
 199:	66 90                	xchg   %ax,%ax
 19b:	66 90                	xchg   %ax,%ax
 19d:	66 90                	xchg   %ax,%ax
 19f:	90                   	nop

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a1:	31 c0                	xor    %eax,%eax
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	53                   	push   %ebx
 1a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1b7:	40                   	inc    %eax
 1b8:	84 d2                	test   %dl,%dl
 1ba:	75 f4                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1bc:	5b                   	pop    %ebx
 1bd:	89 c8                	mov    %ecx,%eax
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cf:	90                   	nop

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1da:	0f b6 03             	movzbl (%ebx),%eax
 1dd:	0f b6 0a             	movzbl (%edx),%ecx
 1e0:	84 c0                	test   %al,%al
 1e2:	75 19                	jne    1fd <strcmp+0x2d>
 1e4:	eb 2a                	jmp    210 <strcmp+0x40>
 1e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
 1f4:	43                   	inc    %ebx
 1f5:	42                   	inc    %edx
  while(*p && *p == *q)
 1f6:	0f b6 0a             	movzbl (%edx),%ecx
 1f9:	84 c0                	test   %al,%al
 1fb:	74 13                	je     210 <strcmp+0x40>
 1fd:	38 c8                	cmp    %cl,%al
 1ff:	74 ef                	je     1f0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 201:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 202:	29 c8                	sub    %ecx,%eax
}
 204:	5d                   	pop    %ebp
 205:	c3                   	ret    
 206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	5b                   	pop    %ebx
 211:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 213:	29 c8                	sub    %ecx,%eax
}
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax

00000220 <strlen>:

uint
strlen(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 226:	80 3a 00             	cmpb   $0x0,(%edx)
 229:	74 15                	je     240 <strlen+0x20>
 22b:	31 c0                	xor    %eax,%eax
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	40                   	inc    %eax
 231:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 235:	89 c1                	mov    %eax,%ecx
 237:	75 f7                	jne    230 <strlen+0x10>
    ;
  return n;
}
 239:	5d                   	pop    %ebp
 23a:	89 c8                	mov    %ecx,%eax
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi
 240:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 241:	31 c9                	xor    %ecx,%ecx
}
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret    
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 55 08             	mov    0x8(%ebp),%edx
 256:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld    
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	5f                   	pop    %edi
 263:	89 d0                	mov    %edx,%eax
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 18                	jne    299 <strchr+0x29>
 281:	eb 1d                	jmp    2a0 <strchr+0x30>
 283:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 294:	40                   	inc    %eax
 295:	84 d2                	test   %dl,%dl
 297:	74 07                	je     2a0 <strchr+0x30>
    if(*s == c)
 299:	38 d1                	cmp    %dl,%cl
 29b:	75 f3                	jne    290 <strchr+0x20>
      return (char*)s;
  return 0;
}
 29d:	5d                   	pop    %ebp
 29e:	c3                   	ret    
 29f:	90                   	nop
 2a0:	5d                   	pop    %ebp
  return 0;
 2a1:	31 c0                	xor    %eax,%eax
}
 2a3:	c3                   	ret    
 2a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2af:	90                   	nop

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
 2b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b6:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 2b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 2bb:	83 ec 3c             	sub    $0x3c,%esp
 2be:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 2c1:	eb 3a                	jmp    2fd <gets+0x4d>
 2c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2d0:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2d4:	ba 01 00 00 00       	mov    $0x1,%edx
 2d9:	89 54 24 08          	mov    %edx,0x8(%esp)
 2dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2e4:	e8 32 01 00 00       	call   41b <read>
    if(cc < 1)
 2e9:	85 c0                	test   %eax,%eax
 2eb:	7e 19                	jle    306 <gets+0x56>
      break;
    buf[i++] = c;
 2ed:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2f1:	46                   	inc    %esi
 2f2:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 2f5:	3c 0a                	cmp    $0xa,%al
 2f7:	74 27                	je     320 <gets+0x70>
 2f9:	3c 0d                	cmp    $0xd,%al
 2fb:	74 23                	je     320 <gets+0x70>
  for(i=0; i+1 < max; ){
 2fd:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 300:	43                   	inc    %ebx
 301:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 304:	7c ca                	jl     2d0 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 306:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 309:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	83 c4 3c             	add    $0x3c,%esp
 312:	5b                   	pop    %ebx
 313:	5e                   	pop    %esi
 314:	5f                   	pop    %edi
 315:	5d                   	pop    %ebp
 316:	c3                   	ret    
 317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31e:	66 90                	xchg   %ax,%ax
 320:	8b 45 08             	mov    0x8(%ebp),%eax
 323:	01 c3                	add    %eax,%ebx
 325:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 328:	eb dc                	jmp    306 <gets+0x56>
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000330 <stat>:

int
stat(const char *n, struct stat *st)
{
 330:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 331:	31 c0                	xor    %eax,%eax
{
 333:	89 e5                	mov    %esp,%ebp
 335:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 338:	89 44 24 04          	mov    %eax,0x4(%esp)
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 33f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 342:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 345:	89 04 24             	mov    %eax,(%esp)
 348:	e8 f6 00 00 00       	call   443 <open>
  if(fd < 0)
 34d:	85 c0                	test   %eax,%eax
 34f:	78 2f                	js     380 <stat+0x50>
 351:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 353:	8b 45 0c             	mov    0xc(%ebp),%eax
 356:	89 1c 24             	mov    %ebx,(%esp)
 359:	89 44 24 04          	mov    %eax,0x4(%esp)
 35d:	e8 f9 00 00 00       	call   45b <fstat>
  close(fd);
 362:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 365:	89 c6                	mov    %eax,%esi
  close(fd);
 367:	e8 bf 00 00 00       	call   42b <close>
  return r;
}
 36c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 36f:	89 f0                	mov    %esi,%eax
 371:	8b 75 fc             	mov    -0x4(%ebp),%esi
 374:	89 ec                	mov    %ebp,%esp
 376:	5d                   	pop    %ebp
 377:	c3                   	ret    
 378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37f:	90                   	nop
    return -1;
 380:	be ff ff ff ff       	mov    $0xffffffff,%esi
 385:	eb e5                	jmp    36c <stat+0x3c>
 387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38e:	66 90                	xchg   %ax,%ax

00000390 <atoi>:

int
atoi(const char *s)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	53                   	push   %ebx
 394:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 397:	0f be 02             	movsbl (%edx),%eax
 39a:	88 c1                	mov    %al,%cl
 39c:	80 e9 30             	sub    $0x30,%cl
 39f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3a2:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3a7:	77 1c                	ja     3c5 <atoi+0x35>
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 3b0:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3b3:	42                   	inc    %edx
 3b4:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3b8:	0f be 02             	movsbl (%edx),%eax
 3bb:	88 c3                	mov    %al,%bl
 3bd:	80 eb 30             	sub    $0x30,%bl
 3c0:	80 fb 09             	cmp    $0x9,%bl
 3c3:	76 eb                	jbe    3b0 <atoi+0x20>
  return n;
}
 3c5:	5b                   	pop    %ebx
 3c6:	89 c8                	mov    %ecx,%eax
 3c8:	5d                   	pop    %ebp
 3c9:	c3                   	ret    
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	8b 45 10             	mov    0x10(%ebp),%eax
 3d7:	56                   	push   %esi
 3d8:	8b 55 08             	mov    0x8(%ebp),%edx
 3db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3de:	85 c0                	test   %eax,%eax
 3e0:	7e 13                	jle    3f5 <memmove+0x25>
 3e2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3e4:	89 d7                	mov    %edx,%edi
 3e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3f1:	39 f8                	cmp    %edi,%eax
 3f3:	75 fb                	jne    3f0 <memmove+0x20>
  return vdst;
}
 3f5:	5e                   	pop    %esi
 3f6:	89 d0                	mov    %edx,%eax
 3f8:	5f                   	pop    %edi
 3f9:	5d                   	pop    %ebp
 3fa:	c3                   	ret    

000003fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3fb:	b8 01 00 00 00       	mov    $0x1,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <exit>:
SYSCALL(exit)
 403:	b8 02 00 00 00       	mov    $0x2,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <wait>:
SYSCALL(wait)
 40b:	b8 03 00 00 00       	mov    $0x3,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <pipe>:
SYSCALL(pipe)
 413:	b8 04 00 00 00       	mov    $0x4,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <read>:
SYSCALL(read)
 41b:	b8 05 00 00 00       	mov    $0x5,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <write>:
SYSCALL(write)
 423:	b8 10 00 00 00       	mov    $0x10,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <close>:
SYSCALL(close)
 42b:	b8 15 00 00 00       	mov    $0x15,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <kill>:
SYSCALL(kill)
 433:	b8 06 00 00 00       	mov    $0x6,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <exec>:
SYSCALL(exec)
 43b:	b8 07 00 00 00       	mov    $0x7,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <open>:
SYSCALL(open)
 443:	b8 0f 00 00 00       	mov    $0xf,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <mknod>:
SYSCALL(mknod)
 44b:	b8 11 00 00 00       	mov    $0x11,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <unlink>:
SYSCALL(unlink)
 453:	b8 12 00 00 00       	mov    $0x12,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <fstat>:
SYSCALL(fstat)
 45b:	b8 08 00 00 00       	mov    $0x8,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <link>:
SYSCALL(link)
 463:	b8 13 00 00 00       	mov    $0x13,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <mkdir>:
SYSCALL(mkdir)
 46b:	b8 14 00 00 00       	mov    $0x14,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <chdir>:
SYSCALL(chdir)
 473:	b8 09 00 00 00       	mov    $0x9,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <dup>:
SYSCALL(dup)
 47b:	b8 0a 00 00 00       	mov    $0xa,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <getpid>:
SYSCALL(getpid)
 483:	b8 0b 00 00 00       	mov    $0xb,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <sbrk>:
SYSCALL(sbrk)
 48b:	b8 0c 00 00 00       	mov    $0xc,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <sleep>:
SYSCALL(sleep)
 493:	b8 0d 00 00 00       	mov    $0xd,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <uptime>:
SYSCALL(uptime)
 49b:	b8 0e 00 00 00       	mov    $0xe,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <waitx>:
SYSCALL(waitx)
 4a3:	b8 16 00 00 00       	mov    $0x16,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <set_priority>:
SYSCALL(set_priority)
 4ab:	b8 17 00 00 00       	mov    $0x17,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <pls>:
SYSCALL(pls)
 4b3:	b8 18 00 00 00       	mov    $0x18,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    
 4bb:	66 90                	xchg   %ax,%ax
 4bd:	66 90                	xchg   %ax,%ax
 4bf:	90                   	nop

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	89 cf                	mov    %ecx,%edi
 4c6:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4c7:	89 d1                	mov    %edx,%ecx
{
 4c9:	53                   	push   %ebx
 4ca:	83 ec 4c             	sub    $0x4c,%esp
 4cd:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4d0:	89 d0                	mov    %edx,%eax
 4d2:	c1 e8 1f             	shr    $0x1f,%eax
 4d5:	84 c0                	test   %al,%al
 4d7:	0f 84 a3 00 00 00    	je     580 <printint+0xc0>
 4dd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4e1:	0f 84 99 00 00 00    	je     580 <printint+0xc0>
    neg = 1;
 4e7:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4ee:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4f0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 4f7:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4fa:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 500:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 503:	31 d2                	xor    %edx,%edx
 505:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 508:	f7 f7                	div    %edi
 50a:	8d 4b 01             	lea    0x1(%ebx),%ecx
 50d:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 510:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 513:	39 cf                	cmp    %ecx,%edi
 515:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 518:	0f b6 92 38 09 00 00 	movzbl 0x938(%edx),%edx
 51f:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 523:	76 db                	jbe    500 <printint+0x40>
  if(neg)
 525:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 528:	85 c9                	test   %ecx,%ecx
 52a:	74 0c                	je     538 <printint+0x78>
    buf[i++] = '-';
 52c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 52f:	b2 2d                	mov    $0x2d,%dl
 531:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 536:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 538:	8b 7d b8             	mov    -0x48(%ebp),%edi
 53b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 53f:	eb 13                	jmp    554 <printint+0x94>
 541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop
 550:	0f b6 13             	movzbl (%ebx),%edx
 553:	4b                   	dec    %ebx
  write(fd, &c, 1);
 554:	89 74 24 04          	mov    %esi,0x4(%esp)
 558:	b8 01 00 00 00       	mov    $0x1,%eax
 55d:	89 44 24 08          	mov    %eax,0x8(%esp)
 561:	89 3c 24             	mov    %edi,(%esp)
 564:	88 55 d7             	mov    %dl,-0x29(%ebp)
 567:	e8 b7 fe ff ff       	call   423 <write>
  while(--i >= 0)
 56c:	39 de                	cmp    %ebx,%esi
 56e:	75 e0                	jne    550 <printint+0x90>
    putc(fd, buf[i]);
}
 570:	83 c4 4c             	add    $0x4c,%esp
 573:	5b                   	pop    %ebx
 574:	5e                   	pop    %esi
 575:	5f                   	pop    %edi
 576:	5d                   	pop    %ebp
 577:	c3                   	ret    
 578:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57f:	90                   	nop
  neg = 0;
 580:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 587:	e9 64 ff ff ff       	jmp    4f0 <printint+0x30>
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000590 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 599:	8b 75 0c             	mov    0xc(%ebp),%esi
 59c:	0f b6 1e             	movzbl (%esi),%ebx
 59f:	84 db                	test   %bl,%bl
 5a1:	0f 84 c8 00 00 00    	je     66f <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 5a7:	8d 45 10             	lea    0x10(%ebp),%eax
 5aa:	46                   	inc    %esi
 5ab:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 5ae:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 5b1:	31 d2                	xor    %edx,%edx
 5b3:	eb 3e                	jmp    5f3 <printf+0x63>
 5b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5c0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5c3:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 5c6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5cb:	74 1e                	je     5eb <printf+0x5b>
  write(fd, &c, 1);
 5cd:	89 7c 24 04          	mov    %edi,0x4(%esp)
 5d1:	b8 01 00 00 00       	mov    $0x1,%eax
 5d6:	89 44 24 08          	mov    %eax,0x8(%esp)
 5da:	8b 45 08             	mov    0x8(%ebp),%eax
 5dd:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5e0:	89 04 24             	mov    %eax,(%esp)
 5e3:	e8 3b fe ff ff       	call   423 <write>
 5e8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 5eb:	0f b6 1e             	movzbl (%esi),%ebx
 5ee:	46                   	inc    %esi
 5ef:	84 db                	test   %bl,%bl
 5f1:	74 7c                	je     66f <printf+0xdf>
    if(state == 0){
 5f3:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 5f5:	0f be cb             	movsbl %bl,%ecx
 5f8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5fb:	74 c3                	je     5c0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5fd:	83 fa 25             	cmp    $0x25,%edx
 600:	75 e9                	jne    5eb <printf+0x5b>
      if(c == 'd'){
 602:	83 f8 64             	cmp    $0x64,%eax
 605:	0f 84 a5 00 00 00    	je     6b0 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 60b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 611:	83 f9 70             	cmp    $0x70,%ecx
 614:	74 6a                	je     680 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 616:	83 f8 73             	cmp    $0x73,%eax
 619:	0f 84 e1 00 00 00    	je     700 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 61f:	83 f8 63             	cmp    $0x63,%eax
 622:	0f 84 98 00 00 00    	je     6c0 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 628:	83 f8 25             	cmp    $0x25,%eax
 62b:	74 1c                	je     649 <printf+0xb9>
  write(fd, &c, 1);
 62d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 631:	8b 45 08             	mov    0x8(%ebp),%eax
 634:	ba 01 00 00 00       	mov    $0x1,%edx
 639:	89 54 24 08          	mov    %edx,0x8(%esp)
 63d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 641:	89 04 24             	mov    %eax,(%esp)
 644:	e8 da fd ff ff       	call   423 <write>
 649:	89 7c 24 04          	mov    %edi,0x4(%esp)
 64d:	b8 01 00 00 00       	mov    $0x1,%eax
 652:	46                   	inc    %esi
 653:	89 44 24 08          	mov    %eax,0x8(%esp)
 657:	8b 45 08             	mov    0x8(%ebp),%eax
 65a:	88 5d e7             	mov    %bl,-0x19(%ebp)
 65d:	89 04 24             	mov    %eax,(%esp)
 660:	e8 be fd ff ff       	call   423 <write>
  for(i = 0; fmt[i]; i++){
 665:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 669:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 66b:	84 db                	test   %bl,%bl
 66d:	75 84                	jne    5f3 <printf+0x63>
    }
  }
}
 66f:	83 c4 3c             	add    $0x3c,%esp
 672:	5b                   	pop    %ebx
 673:	5e                   	pop    %esi
 674:	5f                   	pop    %edi
 675:	5d                   	pop    %ebp
 676:	c3                   	ret    
 677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 680:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 687:	b9 10 00 00 00       	mov    $0x10,%ecx
 68c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 68f:	8b 45 08             	mov    0x8(%ebp),%eax
 692:	8b 13                	mov    (%ebx),%edx
 694:	e8 27 fe ff ff       	call   4c0 <printint>
        ap++;
 699:	89 d8                	mov    %ebx,%eax
      state = 0;
 69b:	31 d2                	xor    %edx,%edx
        ap++;
 69d:	83 c0 04             	add    $0x4,%eax
 6a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6a3:	e9 43 ff ff ff       	jmp    5eb <printf+0x5b>
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
        printint(fd, *ap, 10, 1);
 6b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6b7:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6bc:	eb ce                	jmp    68c <printf+0xfc>
 6be:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 6c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6c3:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 6c8:	8b 03                	mov    (%ebx),%eax
        ap++;
 6ca:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 6cd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 6d1:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 6d5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6d8:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 6dc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6df:	8b 45 08             	mov    0x8(%ebp),%eax
 6e2:	89 04 24             	mov    %eax,(%esp)
 6e5:	e8 39 fd ff ff       	call   423 <write>
      state = 0;
 6ea:	31 d2                	xor    %edx,%edx
        ap++;
 6ec:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6ef:	e9 f7 fe ff ff       	jmp    5eb <printf+0x5b>
 6f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
        s = (char*)*ap;
 700:	8b 45 d0             	mov    -0x30(%ebp),%eax
 703:	8b 18                	mov    (%eax),%ebx
        ap++;
 705:	83 c0 04             	add    $0x4,%eax
 708:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 70b:	85 db                	test   %ebx,%ebx
 70d:	74 11                	je     720 <printf+0x190>
        while(*s != 0){
 70f:	0f b6 03             	movzbl (%ebx),%eax
 712:	84 c0                	test   %al,%al
 714:	74 44                	je     75a <printf+0x1ca>
 716:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 719:	89 de                	mov    %ebx,%esi
 71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 71e:	eb 10                	jmp    730 <printf+0x1a0>
 720:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 723:	bb 2f 09 00 00       	mov    $0x92f,%ebx
        while(*s != 0){
 728:	b0 28                	mov    $0x28,%al
 72a:	89 de                	mov    %ebx,%esi
 72c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 72f:	90                   	nop
          putc(fd, *s);
 730:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 733:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 738:	46                   	inc    %esi
  write(fd, &c, 1);
 739:	89 44 24 08          	mov    %eax,0x8(%esp)
 73d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 741:	89 1c 24             	mov    %ebx,(%esp)
 744:	e8 da fc ff ff       	call   423 <write>
        while(*s != 0){
 749:	0f b6 06             	movzbl (%esi),%eax
 74c:	84 c0                	test   %al,%al
 74e:	75 e0                	jne    730 <printf+0x1a0>
 750:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 753:	31 d2                	xor    %edx,%edx
 755:	e9 91 fe ff ff       	jmp    5eb <printf+0x5b>
 75a:	31 d2                	xor    %edx,%edx
 75c:	e9 8a fe ff ff       	jmp    5eb <printf+0x5b>
 761:	66 90                	xchg   %ax,%ax
 763:	66 90                	xchg   %ax,%ax
 765:	66 90                	xchg   %ax,%ax
 767:	66 90                	xchg   %ax,%ax
 769:	66 90                	xchg   %ax,%ax
 76b:	66 90                	xchg   %ax,%ax
 76d:	66 90                	xchg   %ax,%ax
 76f:	90                   	nop

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	a1 00 0c 00 00       	mov    0xc00,%eax
{
 776:	89 e5                	mov    %esp,%ebp
 778:	57                   	push   %edi
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
 77b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 77e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 780:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 783:	39 c8                	cmp    %ecx,%eax
 785:	73 19                	jae    7a0 <free+0x30>
 787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 78e:	66 90                	xchg   %ax,%ax
 790:	39 d1                	cmp    %edx,%ecx
 792:	72 14                	jb     7a8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	39 d0                	cmp    %edx,%eax
 796:	73 10                	jae    7a8 <free+0x38>
{
 798:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79a:	39 c8                	cmp    %ecx,%eax
 79c:	8b 10                	mov    (%eax),%edx
 79e:	72 f0                	jb     790 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a0:	39 d0                	cmp    %edx,%eax
 7a2:	72 f4                	jb     798 <free+0x28>
 7a4:	39 d1                	cmp    %edx,%ecx
 7a6:	73 f0                	jae    798 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7ae:	39 fa                	cmp    %edi,%edx
 7b0:	74 1e                	je     7d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7b5:	8b 50 04             	mov    0x4(%eax),%edx
 7b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7bb:	39 f1                	cmp    %esi,%ecx
 7bd:	74 2a                	je     7e9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7bf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 7c1:	5b                   	pop    %ebx
  freep = p;
 7c2:	a3 00 0c 00 00       	mov    %eax,0xc00
}
 7c7:	5e                   	pop    %esi
 7c8:	5f                   	pop    %edi
 7c9:	5d                   	pop    %ebp
 7ca:	c3                   	ret    
 7cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7cf:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7d0:	8b 7a 04             	mov    0x4(%edx),%edi
 7d3:	01 fe                	add    %edi,%esi
 7d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	8b 10                	mov    (%eax),%edx
 7da:	8b 12                	mov    (%edx),%edx
 7dc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7df:	8b 50 04             	mov    0x4(%eax),%edx
 7e2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7e5:	39 f1                	cmp    %esi,%ecx
 7e7:	75 d6                	jne    7bf <free+0x4f>
  freep = p;
 7e9:	a3 00 0c 00 00       	mov    %eax,0xc00
    p->s.size += bp->s.size;
 7ee:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 7f1:	01 ca                	add    %ecx,%edx
 7f3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7f6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7f9:	89 10                	mov    %edx,(%eax)
}
 7fb:	5b                   	pop    %ebx
 7fc:	5e                   	pop    %esi
 7fd:	5f                   	pop    %edi
 7fe:	5d                   	pop    %ebp
 7ff:	c3                   	ret    

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 80c:	8b 3d 00 0c 00 00    	mov    0xc00,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	8d 70 07             	lea    0x7(%eax),%esi
 815:	c1 ee 03             	shr    $0x3,%esi
 818:	46                   	inc    %esi
  if((prevp = freep) == 0){
 819:	85 ff                	test   %edi,%edi
 81b:	0f 84 9f 00 00 00    	je     8c0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 821:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 823:	8b 48 04             	mov    0x4(%eax),%ecx
 826:	39 f1                	cmp    %esi,%ecx
 828:	73 6c                	jae    896 <malloc+0x96>
 82a:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 830:	bb 00 10 00 00       	mov    $0x1000,%ebx
 835:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 838:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 83f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 842:	eb 1d                	jmp    861 <malloc+0x61>
 844:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 84f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 852:	8b 4a 04             	mov    0x4(%edx),%ecx
 855:	39 f1                	cmp    %esi,%ecx
 857:	73 47                	jae    8a0 <malloc+0xa0>
 859:	8b 3d 00 0c 00 00    	mov    0xc00,%edi
 85f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 861:	39 c7                	cmp    %eax,%edi
 863:	75 eb                	jne    850 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 865:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 868:	89 04 24             	mov    %eax,(%esp)
 86b:	e8 1b fc ff ff       	call   48b <sbrk>
  if(p == (char*)-1)
 870:	83 f8 ff             	cmp    $0xffffffff,%eax
 873:	74 17                	je     88c <malloc+0x8c>
  hp->s.size = nu;
 875:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 878:	83 c0 08             	add    $0x8,%eax
 87b:	89 04 24             	mov    %eax,(%esp)
 87e:	e8 ed fe ff ff       	call   770 <free>
  return freep;
 883:	a1 00 0c 00 00       	mov    0xc00,%eax
      if((p = morecore(nunits)) == 0)
 888:	85 c0                	test   %eax,%eax
 88a:	75 c4                	jne    850 <malloc+0x50>
        return 0;
  }
}
 88c:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 88f:	31 c0                	xor    %eax,%eax
}
 891:	5b                   	pop    %ebx
 892:	5e                   	pop    %esi
 893:	5f                   	pop    %edi
 894:	5d                   	pop    %ebp
 895:	c3                   	ret    
    if(p->s.size >= nunits){
 896:	89 c2                	mov    %eax,%edx
 898:	89 f8                	mov    %edi,%eax
 89a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8a0:	39 ce                	cmp    %ecx,%esi
 8a2:	74 4c                	je     8f0 <malloc+0xf0>
        p->s.size -= nunits;
 8a4:	29 f1                	sub    %esi,%ecx
 8a6:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 8a9:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 8ac:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 8af:	a3 00 0c 00 00       	mov    %eax,0xc00
      return (void*)(p + 1);
 8b4:	8d 42 08             	lea    0x8(%edx),%eax
}
 8b7:	83 c4 2c             	add    $0x2c,%esp
 8ba:	5b                   	pop    %ebx
 8bb:	5e                   	pop    %esi
 8bc:	5f                   	pop    %edi
 8bd:	5d                   	pop    %ebp
 8be:	c3                   	ret    
 8bf:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 8c0:	b8 04 0c 00 00       	mov    $0xc04,%eax
 8c5:	ba 04 0c 00 00       	mov    $0xc04,%edx
 8ca:	a3 00 0c 00 00       	mov    %eax,0xc00
    base.s.size = 0;
 8cf:	31 c9                	xor    %ecx,%ecx
 8d1:	bf 04 0c 00 00       	mov    $0xc04,%edi
    base.s.ptr = freep = prevp = &base;
 8d6:	89 15 04 0c 00 00    	mov    %edx,0xc04
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8dc:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 8de:	89 0d 08 0c 00 00    	mov    %ecx,0xc08
    if(p->s.size >= nunits){
 8e4:	e9 41 ff ff ff       	jmp    82a <malloc+0x2a>
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 0a                	mov    (%edx),%ecx
 8f2:	89 08                	mov    %ecx,(%eax)
 8f4:	eb b9                	jmp    8af <malloc+0xaf>
