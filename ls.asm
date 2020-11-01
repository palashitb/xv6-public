
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

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

  if(argc < 2){
  11:	83 f8 01             	cmp    $0x1,%eax
  14:	7e 20                	jle    36 <main+0x36>
  16:	8d 5a 04             	lea    0x4(%edx),%ebx
  19:	8d 34 82             	lea    (%edx,%eax,4),%esi
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 03                	mov    (%ebx),%eax
  22:	83 c3 04             	add    $0x4,%ebx
  25:	89 04 24             	mov    %eax,(%esp)
  28:	e8 c3 00 00 00       	call   f0 <ls>
  for(i=1; i<argc; i++)
  2d:	39 f3                	cmp    %esi,%ebx
  2f:	75 ef                	jne    20 <main+0x20>
  exit();
  31:	e8 ad 05 00 00       	call   5e3 <exit>
    ls(".");
  36:	c7 04 24 20 0b 00 00 	movl   $0xb20,(%esp)
  3d:	e8 ae 00 00 00       	call   f0 <ls>
    exit();
  42:	e8 9c 05 00 00       	call   5e3 <exit>
  47:	66 90                	xchg   %ax,%ax
  49:	66 90                	xchg   %ax,%ax
  4b:	66 90                	xchg   %ax,%ax
  4d:	66 90                	xchg   %ax,%ax
  4f:	90                   	nop

00000050 <fmtname>:
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	83 ec 10             	sub    $0x10,%esp
  58:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  5b:	89 34 24             	mov    %esi,(%esp)
  5e:	e8 9d 03 00 00       	call   400 <strlen>
  63:	01 f0                	add    %esi,%eax
  65:	89 c3                	mov    %eax,%ebx
  67:	73 10                	jae    79 <fmtname+0x29>
  69:	eb 13                	jmp    7e <fmtname+0x2e>
  6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  6f:	90                   	nop
  70:	8d 43 ff             	lea    -0x1(%ebx),%eax
  73:	39 c6                	cmp    %eax,%esi
  75:	77 08                	ja     7f <fmtname+0x2f>
  77:	89 c3                	mov    %eax,%ebx
  79:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  7c:	75 f2                	jne    70 <fmtname+0x20>
  7e:	43                   	inc    %ebx
  if(strlen(p) >= DIRSIZ)
  7f:	89 1c 24             	mov    %ebx,(%esp)
  82:	e8 79 03 00 00       	call   400 <strlen>
  87:	83 f8 0d             	cmp    $0xd,%eax
  8a:	77 54                	ja     e0 <fmtname+0x90>
  memmove(buf, p, strlen(p));
  8c:	89 1c 24             	mov    %ebx,(%esp)
  8f:	e8 6c 03 00 00       	call   400 <strlen>
  94:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  98:	c7 04 24 3c 0e 00 00 	movl   $0xe3c,(%esp)
  9f:	89 44 24 08          	mov    %eax,0x8(%esp)
  a3:	e8 08 05 00 00       	call   5b0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  a8:	89 1c 24             	mov    %ebx,(%esp)
  ab:	e8 50 03 00 00       	call   400 <strlen>
  b0:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  b3:	bb 3c 0e 00 00       	mov    $0xe3c,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 c6                	mov    %eax,%esi
  ba:	e8 41 03 00 00       	call   400 <strlen>
  bf:	ba 0e 00 00 00       	mov    $0xe,%edx
  c4:	29 f2                	sub    %esi,%edx
  c6:	89 54 24 08          	mov    %edx,0x8(%esp)
  ca:	ba 20 00 00 00       	mov    $0x20,%edx
  cf:	89 54 24 04          	mov    %edx,0x4(%esp)
  d3:	05 3c 0e 00 00       	add    $0xe3c,%eax
  d8:	89 04 24             	mov    %eax,(%esp)
  db:	e8 50 03 00 00       	call   430 <memset>
}
  e0:	83 c4 10             	add    $0x10,%esp
  e3:	89 d8                	mov    %ebx,%eax
  e5:	5b                   	pop    %ebx
  e6:	5e                   	pop    %esi
  e7:	5d                   	pop    %ebp
  e8:	c3                   	ret    
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <ls>:
{
  f0:	55                   	push   %ebp
  if((fd = open(path, 0)) < 0){
  f1:	31 c0                	xor    %eax,%eax
{
  f3:	89 e5                	mov    %esp,%ebp
  f5:	57                   	push   %edi
  f6:	56                   	push   %esi
  f7:	53                   	push   %ebx
  f8:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
  if((fd = open(path, 0)) < 0){
  fe:	89 44 24 04          	mov    %eax,0x4(%esp)
{
 102:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 105:	89 3c 24             	mov    %edi,(%esp)
 108:	e8 16 05 00 00       	call   623 <open>
 10d:	85 c0                	test   %eax,%eax
 10f:	0f 88 cb 01 00 00    	js     2e0 <ls+0x1f0>
  if(fstat(fd, &st) < 0){
 115:	89 04 24             	mov    %eax,(%esp)
 118:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 11e:	89 c3                	mov    %eax,%ebx
 120:	89 74 24 04          	mov    %esi,0x4(%esp)
 124:	e8 12 05 00 00       	call   63b <fstat>
 129:	85 c0                	test   %eax,%eax
 12b:	0f 88 ff 01 00 00    	js     330 <ls+0x240>
  switch(st.type){
 131:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 138:	83 f8 01             	cmp    $0x1,%eax
 13b:	74 73                	je     1b0 <ls+0xc0>
 13d:	83 f8 02             	cmp    $0x2,%eax
 140:	74 1e                	je     160 <ls+0x70>
  close(fd);
 142:	89 1c 24             	mov    %ebx,(%esp)
 145:	e8 c1 04 00 00       	call   60b <close>
}
 14a:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    
 155:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 160:	89 3c 24             	mov    %edi,(%esp)
 163:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 169:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 16f:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 175:	e8 d6 fe ff ff       	call   50 <fmtname>
 17a:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 180:	b9 00 0b 00 00       	mov    $0xb00,%ecx
 185:	89 74 24 10          	mov    %esi,0x10(%esp)
 189:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 18d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 194:	89 54 24 14          	mov    %edx,0x14(%esp)
 198:	ba 02 00 00 00       	mov    $0x2,%edx
 19d:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 1a5:	e8 c6 05 00 00       	call   770 <printf>
    break;
 1aa:	eb 96                	jmp    142 <ls+0x52>
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1b0:	89 3c 24             	mov    %edi,(%esp)
 1b3:	e8 48 02 00 00       	call   400 <strlen>
 1b8:	83 c0 10             	add    $0x10,%eax
 1bb:	3d 00 02 00 00       	cmp    $0x200,%eax
 1c0:	0f 87 4a 01 00 00    	ja     310 <ls+0x220>
    strcpy(buf, path);
 1c6:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ca:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1d0:	89 3c 24             	mov    %edi,(%esp)
 1d3:	e8 a8 01 00 00       	call   380 <strcpy>
    p = buf+strlen(buf);
 1d8:	89 3c 24             	mov    %edi,(%esp)
 1db:	e8 20 02 00 00       	call   400 <strlen>
 1e0:	8d 0c 07             	lea    (%edi,%eax,1),%ecx
 1e3:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    *p++ = '/';
 1e9:	8d 44 07 01          	lea    0x1(%edi,%eax,1),%eax
 1ed:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
 1f3:	c6 01 2f             	movb   $0x2f,(%ecx)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	89 1c 24             	mov    %ebx,(%esp)
 203:	b8 10 00 00 00       	mov    $0x10,%eax
 208:	89 44 24 08          	mov    %eax,0x8(%esp)
 20c:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 212:	89 44 24 04          	mov    %eax,0x4(%esp)
 216:	e8 e0 03 00 00       	call   5fb <read>
 21b:	83 f8 10             	cmp    $0x10,%eax
 21e:	0f 85 1e ff ff ff    	jne    142 <ls+0x52>
      if(de.inum == 0)
 224:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 22b:	00 
 22c:	74 d2                	je     200 <ls+0x110>
      memmove(p, de.name, DIRSIZ);
 22e:	b8 0e 00 00 00       	mov    $0xe,%eax
 233:	89 44 24 08          	mov    %eax,0x8(%esp)
 237:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 23d:	89 44 24 04          	mov    %eax,0x4(%esp)
 241:	8b 85 a4 fd ff ff    	mov    -0x25c(%ebp),%eax
 247:	89 04 24             	mov    %eax,(%esp)
 24a:	e8 61 03 00 00       	call   5b0 <memmove>
      p[DIRSIZ] = 0;
 24f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 255:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 259:	89 74 24 04          	mov    %esi,0x4(%esp)
 25d:	89 3c 24             	mov    %edi,(%esp)
 260:	e8 ab 02 00 00       	call   510 <stat>
 265:	85 c0                	test   %eax,%eax
 267:	0f 88 f3 00 00 00    	js     360 <ls+0x270>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 26d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 273:	89 3c 24             	mov    %edi,(%esp)
 276:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 27c:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 283:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 289:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 28f:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 295:	e8 b6 fd ff ff       	call   50 <fmtname>
 29a:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 2a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a7:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 2ad:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 2b1:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
 2b7:	89 54 24 10          	mov    %edx,0x10(%esp)
 2bb:	ba 00 0b 00 00       	mov    $0xb00,%edx
 2c0:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c4:	89 54 24 04          	mov    %edx,0x4(%esp)
 2c8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 2cc:	e8 9f 04 00 00       	call   770 <printf>
 2d1:	e9 2a ff ff ff       	jmp    200 <ls+0x110>
 2d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 2e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2e4:	bf d8 0a 00 00       	mov    $0xad8,%edi
 2e9:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2ed:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2f4:	e8 77 04 00 00       	call   770 <printf>
}
 2f9:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 2ff:	5b                   	pop    %ebx
 300:	5e                   	pop    %esi
 301:	5f                   	pop    %edi
 302:	5d                   	pop    %ebp
 303:	c3                   	ret    
 304:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 30f:	90                   	nop
      printf(1, "ls: path too long\n");
 310:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 317:	b8 0d 0b 00 00       	mov    $0xb0d,%eax
 31c:	89 44 24 04          	mov    %eax,0x4(%esp)
 320:	e8 4b 04 00 00       	call   770 <printf>
      break;
 325:	e9 18 fe ff ff       	jmp    142 <ls+0x52>
 32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot stat %s\n", path);
 330:	89 7c 24 08          	mov    %edi,0x8(%esp)
 334:	be ec 0a 00 00       	mov    $0xaec,%esi
 339:	89 74 24 04          	mov    %esi,0x4(%esp)
 33d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 344:	e8 27 04 00 00       	call   770 <printf>
    close(fd);
 349:	89 1c 24             	mov    %ebx,(%esp)
 34c:	e8 ba 02 00 00       	call   60b <close>
}
 351:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 357:	5b                   	pop    %ebx
 358:	5e                   	pop    %esi
 359:	5f                   	pop    %edi
 35a:	5d                   	pop    %ebp
 35b:	c3                   	ret    
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 360:	89 7c 24 08          	mov    %edi,0x8(%esp)
 364:	b9 ec 0a 00 00       	mov    $0xaec,%ecx
 369:	89 4c 24 04          	mov    %ecx,0x4(%esp)
 36d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 374:	e8 f7 03 00 00       	call   770 <printf>
        continue;
 379:	e9 82 fe ff ff       	jmp    200 <ls+0x110>
 37e:	66 90                	xchg   %ax,%ax

00000380 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 380:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 381:	31 c0                	xor    %eax,%eax
{
 383:	89 e5                	mov    %esp,%ebp
 385:	53                   	push   %ebx
 386:	8b 4d 08             	mov    0x8(%ebp),%ecx
 389:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 390:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 394:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 397:	40                   	inc    %eax
 398:	84 d2                	test   %dl,%dl
 39a:	75 f4                	jne    390 <strcpy+0x10>
    ;
  return os;
}
 39c:	5b                   	pop    %ebx
 39d:	89 c8                	mov    %ecx,%eax
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret    
 3a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3af:	90                   	nop

000003b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 3ba:	0f b6 03             	movzbl (%ebx),%eax
 3bd:	0f b6 0a             	movzbl (%edx),%ecx
 3c0:	84 c0                	test   %al,%al
 3c2:	75 19                	jne    3dd <strcmp+0x2d>
 3c4:	eb 2a                	jmp    3f0 <strcmp+0x40>
 3c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
 3d4:	43                   	inc    %ebx
 3d5:	42                   	inc    %edx
  while(*p && *p == *q)
 3d6:	0f b6 0a             	movzbl (%edx),%ecx
 3d9:	84 c0                	test   %al,%al
 3db:	74 13                	je     3f0 <strcmp+0x40>
 3dd:	38 c8                	cmp    %cl,%al
 3df:	74 ef                	je     3d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
 3e1:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
 3e2:	29 c8                	sub    %ecx,%eax
}
 3e4:	5d                   	pop    %ebp
 3e5:	c3                   	ret    
 3e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
 3f0:	5b                   	pop    %ebx
 3f1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3f3:	29 c8                	sub    %ecx,%eax
}
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3fe:	66 90                	xchg   %ax,%ax

00000400 <strlen>:

uint
strlen(const char *s)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 406:	80 3a 00             	cmpb   $0x0,(%edx)
 409:	74 15                	je     420 <strlen+0x20>
 40b:	31 c0                	xor    %eax,%eax
 40d:	8d 76 00             	lea    0x0(%esi),%esi
 410:	40                   	inc    %eax
 411:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 415:	89 c1                	mov    %eax,%ecx
 417:	75 f7                	jne    410 <strlen+0x10>
    ;
  return n;
}
 419:	5d                   	pop    %ebp
 41a:	89 c8                	mov    %ecx,%eax
 41c:	c3                   	ret    
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
 421:	31 c9                	xor    %ecx,%ecx
}
 423:	89 c8                	mov    %ecx,%eax
 425:	c3                   	ret    
 426:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 42d:	8d 76 00             	lea    0x0(%esi),%esi

00000430 <memset>:

void*
memset(void *dst, int c, uint n)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 55 08             	mov    0x8(%ebp),%edx
 436:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 437:	8b 4d 10             	mov    0x10(%ebp),%ecx
 43a:	8b 45 0c             	mov    0xc(%ebp),%eax
 43d:	89 d7                	mov    %edx,%edi
 43f:	fc                   	cld    
 440:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 442:	5f                   	pop    %edi
 443:	89 d0                	mov    %edx,%eax
 445:	5d                   	pop    %ebp
 446:	c3                   	ret    
 447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44e:	66 90                	xchg   %ax,%ax

00000450 <strchr>:

char*
strchr(const char *s, char c)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 45 08             	mov    0x8(%ebp),%eax
 456:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 45a:	0f b6 10             	movzbl (%eax),%edx
 45d:	84 d2                	test   %dl,%dl
 45f:	75 18                	jne    479 <strchr+0x29>
 461:	eb 1d                	jmp    480 <strchr+0x30>
 463:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 470:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 474:	40                   	inc    %eax
 475:	84 d2                	test   %dl,%dl
 477:	74 07                	je     480 <strchr+0x30>
    if(*s == c)
 479:	38 d1                	cmp    %dl,%cl
 47b:	75 f3                	jne    470 <strchr+0x20>
      return (char*)s;
  return 0;
}
 47d:	5d                   	pop    %ebp
 47e:	c3                   	ret    
 47f:	90                   	nop
 480:	5d                   	pop    %ebp
  return 0;
 481:	31 c0                	xor    %eax,%eax
}
 483:	c3                   	ret    
 484:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop

00000490 <gets>:

char*
gets(char *buf, int max)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 496:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 498:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 49b:	83 ec 3c             	sub    $0x3c,%esp
 49e:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
 4a1:	eb 3a                	jmp    4dd <gets+0x4d>
 4a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 4b0:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4b4:	ba 01 00 00 00       	mov    $0x1,%edx
 4b9:	89 54 24 08          	mov    %edx,0x8(%esp)
 4bd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4c4:	e8 32 01 00 00       	call   5fb <read>
    if(cc < 1)
 4c9:	85 c0                	test   %eax,%eax
 4cb:	7e 19                	jle    4e6 <gets+0x56>
      break;
    buf[i++] = c;
 4cd:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4d1:	46                   	inc    %esi
 4d2:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
 4d5:	3c 0a                	cmp    $0xa,%al
 4d7:	74 27                	je     500 <gets+0x70>
 4d9:	3c 0d                	cmp    $0xd,%al
 4db:	74 23                	je     500 <gets+0x70>
  for(i=0; i+1 < max; ){
 4dd:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4e0:	43                   	inc    %ebx
 4e1:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4e4:	7c ca                	jl     4b0 <gets+0x20>
      break;
  }
  buf[i] = '\0';
 4e6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4e9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
 4ec:	8b 45 08             	mov    0x8(%ebp),%eax
 4ef:	83 c4 3c             	add    $0x3c,%esp
 4f2:	5b                   	pop    %ebx
 4f3:	5e                   	pop    %esi
 4f4:	5f                   	pop    %edi
 4f5:	5d                   	pop    %ebp
 4f6:	c3                   	ret    
 4f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fe:	66 90                	xchg   %ax,%ax
 500:	8b 45 08             	mov    0x8(%ebp),%eax
 503:	01 c3                	add    %eax,%ebx
 505:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 508:	eb dc                	jmp    4e6 <gets+0x56>
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000510 <stat>:

int
stat(const char *n, struct stat *st)
{
 510:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 511:	31 c0                	xor    %eax,%eax
{
 513:	89 e5                	mov    %esp,%ebp
 515:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
 518:	89 44 24 04          	mov    %eax,0x4(%esp)
 51c:	8b 45 08             	mov    0x8(%ebp),%eax
{
 51f:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 522:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 525:	89 04 24             	mov    %eax,(%esp)
 528:	e8 f6 00 00 00       	call   623 <open>
  if(fd < 0)
 52d:	85 c0                	test   %eax,%eax
 52f:	78 2f                	js     560 <stat+0x50>
 531:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 533:	8b 45 0c             	mov    0xc(%ebp),%eax
 536:	89 1c 24             	mov    %ebx,(%esp)
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	e8 f9 00 00 00       	call   63b <fstat>
  close(fd);
 542:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 545:	89 c6                	mov    %eax,%esi
  close(fd);
 547:	e8 bf 00 00 00       	call   60b <close>
  return r;
}
 54c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 54f:	89 f0                	mov    %esi,%eax
 551:	8b 75 fc             	mov    -0x4(%ebp),%esi
 554:	89 ec                	mov    %ebp,%esp
 556:	5d                   	pop    %ebp
 557:	c3                   	ret    
 558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop
    return -1;
 560:	be ff ff ff ff       	mov    $0xffffffff,%esi
 565:	eb e5                	jmp    54c <stat+0x3c>
 567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56e:	66 90                	xchg   %ax,%ax

00000570 <atoi>:

int
atoi(const char *s)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	53                   	push   %ebx
 574:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 577:	0f be 02             	movsbl (%edx),%eax
 57a:	88 c1                	mov    %al,%cl
 57c:	80 e9 30             	sub    $0x30,%cl
 57f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 582:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 587:	77 1c                	ja     5a5 <atoi+0x35>
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 590:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 593:	42                   	inc    %edx
 594:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 598:	0f be 02             	movsbl (%edx),%eax
 59b:	88 c3                	mov    %al,%bl
 59d:	80 eb 30             	sub    $0x30,%bl
 5a0:	80 fb 09             	cmp    $0x9,%bl
 5a3:	76 eb                	jbe    590 <atoi+0x20>
  return n;
}
 5a5:	5b                   	pop    %ebx
 5a6:	89 c8                	mov    %ecx,%eax
 5a8:	5d                   	pop    %ebp
 5a9:	c3                   	ret    
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	8b 45 10             	mov    0x10(%ebp),%eax
 5b7:	56                   	push   %esi
 5b8:	8b 55 08             	mov    0x8(%ebp),%edx
 5bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5be:	85 c0                	test   %eax,%eax
 5c0:	7e 13                	jle    5d5 <memmove+0x25>
 5c2:	01 d0                	add    %edx,%eax
  dst = vdst;
 5c4:	89 d7                	mov    %edx,%edi
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5d1:	39 f8                	cmp    %edi,%eax
 5d3:	75 fb                	jne    5d0 <memmove+0x20>
  return vdst;
}
 5d5:	5e                   	pop    %esi
 5d6:	89 d0                	mov    %edx,%eax
 5d8:	5f                   	pop    %edi
 5d9:	5d                   	pop    %ebp
 5da:	c3                   	ret    

000005db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5db:	b8 01 00 00 00       	mov    $0x1,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <exit>:
SYSCALL(exit)
 5e3:	b8 02 00 00 00       	mov    $0x2,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <wait>:
SYSCALL(wait)
 5eb:	b8 03 00 00 00       	mov    $0x3,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <pipe>:
SYSCALL(pipe)
 5f3:	b8 04 00 00 00       	mov    $0x4,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <read>:
SYSCALL(read)
 5fb:	b8 05 00 00 00       	mov    $0x5,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <write>:
SYSCALL(write)
 603:	b8 10 00 00 00       	mov    $0x10,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <close>:
SYSCALL(close)
 60b:	b8 15 00 00 00       	mov    $0x15,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <kill>:
SYSCALL(kill)
 613:	b8 06 00 00 00       	mov    $0x6,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <exec>:
SYSCALL(exec)
 61b:	b8 07 00 00 00       	mov    $0x7,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <open>:
SYSCALL(open)
 623:	b8 0f 00 00 00       	mov    $0xf,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <mknod>:
SYSCALL(mknod)
 62b:	b8 11 00 00 00       	mov    $0x11,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <unlink>:
SYSCALL(unlink)
 633:	b8 12 00 00 00       	mov    $0x12,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <fstat>:
SYSCALL(fstat)
 63b:	b8 08 00 00 00       	mov    $0x8,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <link>:
SYSCALL(link)
 643:	b8 13 00 00 00       	mov    $0x13,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <mkdir>:
SYSCALL(mkdir)
 64b:	b8 14 00 00 00       	mov    $0x14,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <chdir>:
SYSCALL(chdir)
 653:	b8 09 00 00 00       	mov    $0x9,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <dup>:
SYSCALL(dup)
 65b:	b8 0a 00 00 00       	mov    $0xa,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <getpid>:
SYSCALL(getpid)
 663:	b8 0b 00 00 00       	mov    $0xb,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <sbrk>:
SYSCALL(sbrk)
 66b:	b8 0c 00 00 00       	mov    $0xc,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <sleep>:
SYSCALL(sleep)
 673:	b8 0d 00 00 00       	mov    $0xd,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    

0000067b <uptime>:
SYSCALL(uptime)
 67b:	b8 0e 00 00 00       	mov    $0xe,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret    

00000683 <waitx>:
SYSCALL(waitx)
 683:	b8 16 00 00 00       	mov    $0x16,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret    

0000068b <set_priority>:
SYSCALL(set_priority)
 68b:	b8 17 00 00 00       	mov    $0x17,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret    

00000693 <pls>:
SYSCALL(pls)
 693:	b8 18 00 00 00       	mov    $0x18,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret    
 69b:	66 90                	xchg   %ax,%ax
 69d:	66 90                	xchg   %ax,%ax
 69f:	90                   	nop

000006a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	89 cf                	mov    %ecx,%edi
 6a6:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6a7:	89 d1                	mov    %edx,%ecx
{
 6a9:	53                   	push   %ebx
 6aa:	83 ec 4c             	sub    $0x4c,%esp
 6ad:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 6b0:	89 d0                	mov    %edx,%eax
 6b2:	c1 e8 1f             	shr    $0x1f,%eax
 6b5:	84 c0                	test   %al,%al
 6b7:	0f 84 a3 00 00 00    	je     760 <printint+0xc0>
 6bd:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6c1:	0f 84 99 00 00 00    	je     760 <printint+0xc0>
    neg = 1;
 6c7:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 6ce:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 6d0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 6d7:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6da:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6e0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 6e3:	31 d2                	xor    %edx,%edx
 6e5:	8b 5d c0             	mov    -0x40(%ebp),%ebx
 6e8:	f7 f7                	div    %edi
 6ea:	8d 4b 01             	lea    0x1(%ebx),%ecx
 6ed:	89 4d c0             	mov    %ecx,-0x40(%ebp)
 6f0:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
 6f3:	39 cf                	cmp    %ecx,%edi
 6f5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
 6f8:	0f b6 92 2c 0b 00 00 	movzbl 0xb2c(%edx),%edx
 6ff:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
 703:	76 db                	jbe    6e0 <printint+0x40>
  if(neg)
 705:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 708:	85 c9                	test   %ecx,%ecx
 70a:	74 0c                	je     718 <printint+0x78>
    buf[i++] = '-';
 70c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 70f:	b2 2d                	mov    $0x2d,%dl
 711:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
 716:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
 718:	8b 7d b8             	mov    -0x48(%ebp),%edi
 71b:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
 71f:	eb 13                	jmp    734 <printint+0x94>
 721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop
 730:	0f b6 13             	movzbl (%ebx),%edx
 733:	4b                   	dec    %ebx
  write(fd, &c, 1);
 734:	89 74 24 04          	mov    %esi,0x4(%esp)
 738:	b8 01 00 00 00       	mov    $0x1,%eax
 73d:	89 44 24 08          	mov    %eax,0x8(%esp)
 741:	89 3c 24             	mov    %edi,(%esp)
 744:	88 55 d7             	mov    %dl,-0x29(%ebp)
 747:	e8 b7 fe ff ff       	call   603 <write>
  while(--i >= 0)
 74c:	39 de                	cmp    %ebx,%esi
 74e:	75 e0                	jne    730 <printint+0x90>
    putc(fd, buf[i]);
}
 750:	83 c4 4c             	add    $0x4c,%esp
 753:	5b                   	pop    %ebx
 754:	5e                   	pop    %esi
 755:	5f                   	pop    %edi
 756:	5d                   	pop    %ebp
 757:	c3                   	ret    
 758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop
  neg = 0;
 760:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 767:	e9 64 ff ff ff       	jmp    6d0 <printint+0x30>
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000770 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 779:	8b 75 0c             	mov    0xc(%ebp),%esi
 77c:	0f b6 1e             	movzbl (%esi),%ebx
 77f:	84 db                	test   %bl,%bl
 781:	0f 84 c8 00 00 00    	je     84f <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
 787:	8d 45 10             	lea    0x10(%ebp),%eax
 78a:	46                   	inc    %esi
 78b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
 78e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 791:	31 d2                	xor    %edx,%edx
 793:	eb 3e                	jmp    7d3 <printf+0x63>
 795:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7a0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7a3:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
 7a6:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 7ab:	74 1e                	je     7cb <printf+0x5b>
  write(fd, &c, 1);
 7ad:	89 7c 24 04          	mov    %edi,0x4(%esp)
 7b1:	b8 01 00 00 00       	mov    $0x1,%eax
 7b6:	89 44 24 08          	mov    %eax,0x8(%esp)
 7ba:	8b 45 08             	mov    0x8(%ebp),%eax
 7bd:	88 5d e7             	mov    %bl,-0x19(%ebp)
 7c0:	89 04 24             	mov    %eax,(%esp)
 7c3:	e8 3b fe ff ff       	call   603 <write>
 7c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
 7cb:	0f b6 1e             	movzbl (%esi),%ebx
 7ce:	46                   	inc    %esi
 7cf:	84 db                	test   %bl,%bl
 7d1:	74 7c                	je     84f <printf+0xdf>
    if(state == 0){
 7d3:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
 7d5:	0f be cb             	movsbl %bl,%ecx
 7d8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7db:	74 c3                	je     7a0 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7dd:	83 fa 25             	cmp    $0x25,%edx
 7e0:	75 e9                	jne    7cb <printf+0x5b>
      if(c == 'd'){
 7e2:	83 f8 64             	cmp    $0x64,%eax
 7e5:	0f 84 a5 00 00 00    	je     890 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7eb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7f1:	83 f9 70             	cmp    $0x70,%ecx
 7f4:	74 6a                	je     860 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7f6:	83 f8 73             	cmp    $0x73,%eax
 7f9:	0f 84 e1 00 00 00    	je     8e0 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ff:	83 f8 63             	cmp    $0x63,%eax
 802:	0f 84 98 00 00 00    	je     8a0 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 808:	83 f8 25             	cmp    $0x25,%eax
 80b:	74 1c                	je     829 <printf+0xb9>
  write(fd, &c, 1);
 80d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 811:	8b 45 08             	mov    0x8(%ebp),%eax
 814:	ba 01 00 00 00       	mov    $0x1,%edx
 819:	89 54 24 08          	mov    %edx,0x8(%esp)
 81d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 821:	89 04 24             	mov    %eax,(%esp)
 824:	e8 da fd ff ff       	call   603 <write>
 829:	89 7c 24 04          	mov    %edi,0x4(%esp)
 82d:	b8 01 00 00 00       	mov    $0x1,%eax
 832:	46                   	inc    %esi
 833:	89 44 24 08          	mov    %eax,0x8(%esp)
 837:	8b 45 08             	mov    0x8(%ebp),%eax
 83a:	88 5d e7             	mov    %bl,-0x19(%ebp)
 83d:	89 04 24             	mov    %eax,(%esp)
 840:	e8 be fd ff ff       	call   603 <write>
  for(i = 0; fmt[i]; i++){
 845:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 849:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 84b:	84 db                	test   %bl,%bl
 84d:	75 84                	jne    7d3 <printf+0x63>
    }
  }
}
 84f:	83 c4 3c             	add    $0x3c,%esp
 852:	5b                   	pop    %ebx
 853:	5e                   	pop    %esi
 854:	5f                   	pop    %edi
 855:	5d                   	pop    %ebp
 856:	c3                   	ret    
 857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 860:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 867:	b9 10 00 00 00       	mov    $0x10,%ecx
 86c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 86f:	8b 45 08             	mov    0x8(%ebp),%eax
 872:	8b 13                	mov    (%ebx),%edx
 874:	e8 27 fe ff ff       	call   6a0 <printint>
        ap++;
 879:	89 d8                	mov    %ebx,%eax
      state = 0;
 87b:	31 d2                	xor    %edx,%edx
        ap++;
 87d:	83 c0 04             	add    $0x4,%eax
 880:	89 45 d0             	mov    %eax,-0x30(%ebp)
 883:	e9 43 ff ff ff       	jmp    7cb <printf+0x5b>
 888:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88f:	90                   	nop
        printint(fd, *ap, 10, 1);
 890:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 897:	b9 0a 00 00 00       	mov    $0xa,%ecx
 89c:	eb ce                	jmp    86c <printf+0xfc>
 89e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
 8a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 8a3:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
 8a8:	8b 03                	mov    (%ebx),%eax
        ap++;
 8aa:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 8ad:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 8b1:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
 8b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8b8:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
 8bc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8bf:	8b 45 08             	mov    0x8(%ebp),%eax
 8c2:	89 04 24             	mov    %eax,(%esp)
 8c5:	e8 39 fd ff ff       	call   603 <write>
      state = 0;
 8ca:	31 d2                	xor    %edx,%edx
        ap++;
 8cc:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8cf:	e9 f7 fe ff ff       	jmp    7cb <printf+0x5b>
 8d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8df:	90                   	nop
        s = (char*)*ap;
 8e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8e3:	8b 18                	mov    (%eax),%ebx
        ap++;
 8e5:	83 c0 04             	add    $0x4,%eax
 8e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 8eb:	85 db                	test   %ebx,%ebx
 8ed:	74 11                	je     900 <printf+0x190>
        while(*s != 0){
 8ef:	0f b6 03             	movzbl (%ebx),%eax
 8f2:	84 c0                	test   %al,%al
 8f4:	74 44                	je     93a <printf+0x1ca>
 8f6:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8f9:	89 de                	mov    %ebx,%esi
 8fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8fe:	eb 10                	jmp    910 <printf+0x1a0>
 900:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
 903:	bb 22 0b 00 00       	mov    $0xb22,%ebx
        while(*s != 0){
 908:	b0 28                	mov    $0x28,%al
 90a:	89 de                	mov    %ebx,%esi
 90c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 90f:	90                   	nop
          putc(fd, *s);
 910:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 913:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
 918:	46                   	inc    %esi
  write(fd, &c, 1);
 919:	89 44 24 08          	mov    %eax,0x8(%esp)
 91d:	89 7c 24 04          	mov    %edi,0x4(%esp)
 921:	89 1c 24             	mov    %ebx,(%esp)
 924:	e8 da fc ff ff       	call   603 <write>
        while(*s != 0){
 929:	0f b6 06             	movzbl (%esi),%eax
 92c:	84 c0                	test   %al,%al
 92e:	75 e0                	jne    910 <printf+0x1a0>
 930:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 933:	31 d2                	xor    %edx,%edx
 935:	e9 91 fe ff ff       	jmp    7cb <printf+0x5b>
 93a:	31 d2                	xor    %edx,%edx
 93c:	e9 8a fe ff ff       	jmp    7cb <printf+0x5b>
 941:	66 90                	xchg   %ax,%ax
 943:	66 90                	xchg   %ax,%ax
 945:	66 90                	xchg   %ax,%ax
 947:	66 90                	xchg   %ax,%ax
 949:	66 90                	xchg   %ax,%ax
 94b:	66 90                	xchg   %ax,%ax
 94d:	66 90                	xchg   %ax,%ax
 94f:	90                   	nop

00000950 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 950:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 951:	a1 4c 0e 00 00       	mov    0xe4c,%eax
{
 956:	89 e5                	mov    %esp,%ebp
 958:	57                   	push   %edi
 959:	56                   	push   %esi
 95a:	53                   	push   %ebx
 95b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 95e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 960:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 963:	39 c8                	cmp    %ecx,%eax
 965:	73 19                	jae    980 <free+0x30>
 967:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 96e:	66 90                	xchg   %ax,%ax
 970:	39 d1                	cmp    %edx,%ecx
 972:	72 14                	jb     988 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 974:	39 d0                	cmp    %edx,%eax
 976:	73 10                	jae    988 <free+0x38>
{
 978:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97a:	39 c8                	cmp    %ecx,%eax
 97c:	8b 10                	mov    (%eax),%edx
 97e:	72 f0                	jb     970 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 980:	39 d0                	cmp    %edx,%eax
 982:	72 f4                	jb     978 <free+0x28>
 984:	39 d1                	cmp    %edx,%ecx
 986:	73 f0                	jae    978 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 988:	8b 73 fc             	mov    -0x4(%ebx),%esi
 98b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 98e:	39 fa                	cmp    %edi,%edx
 990:	74 1e                	je     9b0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 992:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 995:	8b 50 04             	mov    0x4(%eax),%edx
 998:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 99b:	39 f1                	cmp    %esi,%ecx
 99d:	74 2a                	je     9c9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 99f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 9a1:	5b                   	pop    %ebx
  freep = p;
 9a2:	a3 4c 0e 00 00       	mov    %eax,0xe4c
}
 9a7:	5e                   	pop    %esi
 9a8:	5f                   	pop    %edi
 9a9:	5d                   	pop    %ebp
 9aa:	c3                   	ret    
 9ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9af:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 9b0:	8b 7a 04             	mov    0x4(%edx),%edi
 9b3:	01 fe                	add    %edi,%esi
 9b5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b8:	8b 10                	mov    (%eax),%edx
 9ba:	8b 12                	mov    (%edx),%edx
 9bc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9bf:	8b 50 04             	mov    0x4(%eax),%edx
 9c2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9c5:	39 f1                	cmp    %esi,%ecx
 9c7:	75 d6                	jne    99f <free+0x4f>
  freep = p;
 9c9:	a3 4c 0e 00 00       	mov    %eax,0xe4c
    p->s.size += bp->s.size;
 9ce:	8b 4b fc             	mov    -0x4(%ebx),%ecx
 9d1:	01 ca                	add    %ecx,%edx
 9d3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9d6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9d9:	89 10                	mov    %edx,(%eax)
}
 9db:	5b                   	pop    %ebx
 9dc:	5e                   	pop    %esi
 9dd:	5f                   	pop    %edi
 9de:	5d                   	pop    %ebp
 9df:	c3                   	ret    

000009e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	57                   	push   %edi
 9e4:	56                   	push   %esi
 9e5:	53                   	push   %ebx
 9e6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9ec:	8b 3d 4c 0e 00 00    	mov    0xe4c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f2:	8d 70 07             	lea    0x7(%eax),%esi
 9f5:	c1 ee 03             	shr    $0x3,%esi
 9f8:	46                   	inc    %esi
  if((prevp = freep) == 0){
 9f9:	85 ff                	test   %edi,%edi
 9fb:	0f 84 9f 00 00 00    	je     aa0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a01:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 a03:	8b 48 04             	mov    0x4(%eax),%ecx
 a06:	39 f1                	cmp    %esi,%ecx
 a08:	73 6c                	jae    a76 <malloc+0x96>
 a0a:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 a10:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a15:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 a18:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 a1f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 a22:	eb 1d                	jmp    a41 <malloc+0x61>
 a24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a2f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a30:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 a32:	8b 4a 04             	mov    0x4(%edx),%ecx
 a35:	39 f1                	cmp    %esi,%ecx
 a37:	73 47                	jae    a80 <malloc+0xa0>
 a39:	8b 3d 4c 0e 00 00    	mov    0xe4c,%edi
 a3f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a41:	39 c7                	cmp    %eax,%edi
 a43:	75 eb                	jne    a30 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 a45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 a48:	89 04 24             	mov    %eax,(%esp)
 a4b:	e8 1b fc ff ff       	call   66b <sbrk>
  if(p == (char*)-1)
 a50:	83 f8 ff             	cmp    $0xffffffff,%eax
 a53:	74 17                	je     a6c <malloc+0x8c>
  hp->s.size = nu;
 a55:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a58:	83 c0 08             	add    $0x8,%eax
 a5b:	89 04 24             	mov    %eax,(%esp)
 a5e:	e8 ed fe ff ff       	call   950 <free>
  return freep;
 a63:	a1 4c 0e 00 00       	mov    0xe4c,%eax
      if((p = morecore(nunits)) == 0)
 a68:	85 c0                	test   %eax,%eax
 a6a:	75 c4                	jne    a30 <malloc+0x50>
        return 0;
  }
}
 a6c:	83 c4 2c             	add    $0x2c,%esp
        return 0;
 a6f:	31 c0                	xor    %eax,%eax
}
 a71:	5b                   	pop    %ebx
 a72:	5e                   	pop    %esi
 a73:	5f                   	pop    %edi
 a74:	5d                   	pop    %ebp
 a75:	c3                   	ret    
    if(p->s.size >= nunits){
 a76:	89 c2                	mov    %eax,%edx
 a78:	89 f8                	mov    %edi,%eax
 a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a80:	39 ce                	cmp    %ecx,%esi
 a82:	74 4c                	je     ad0 <malloc+0xf0>
        p->s.size -= nunits;
 a84:	29 f1                	sub    %esi,%ecx
 a86:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 a89:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 a8c:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 a8f:	a3 4c 0e 00 00       	mov    %eax,0xe4c
      return (void*)(p + 1);
 a94:	8d 42 08             	lea    0x8(%edx),%eax
}
 a97:	83 c4 2c             	add    $0x2c,%esp
 a9a:	5b                   	pop    %ebx
 a9b:	5e                   	pop    %esi
 a9c:	5f                   	pop    %edi
 a9d:	5d                   	pop    %ebp
 a9e:	c3                   	ret    
 a9f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 aa0:	b8 50 0e 00 00       	mov    $0xe50,%eax
 aa5:	ba 50 0e 00 00       	mov    $0xe50,%edx
 aaa:	a3 4c 0e 00 00       	mov    %eax,0xe4c
    base.s.size = 0;
 aaf:	31 c9                	xor    %ecx,%ecx
 ab1:	bf 50 0e 00 00       	mov    $0xe50,%edi
    base.s.ptr = freep = prevp = &base;
 ab6:	89 15 50 0e 00 00    	mov    %edx,0xe50
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 abc:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 abe:	89 0d 54 0e 00 00    	mov    %ecx,0xe54
    if(p->s.size >= nunits){
 ac4:	e9 41 ff ff ff       	jmp    a0a <malloc+0x2a>
 ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 ad0:	8b 0a                	mov    (%edx),%ecx
 ad2:	89 08                	mov    %ecx,(%eax)
 ad4:	eb b9                	jmp    a8f <malloc+0xaf>
