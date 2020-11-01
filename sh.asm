
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
       f:	90                   	nop
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f c5 00 00 00    	jg     de <main+0xde>
  while((fd = open("console", O_RDWR)) >= 0){
      19:	c7 04 24 39 14 00 00 	movl   $0x1439,(%esp)
      20:	ba 02 00 00 00       	mov    $0x2,%edx
      25:	89 54 24 04          	mov    %edx,0x4(%esp)
      29:	e8 b5 0e 00 00       	call   ee3 <open>
      2e:	85 c0                	test   %eax,%eax
      30:	79 de                	jns    10 <main+0x10>
      32:	eb 37                	jmp    6b <main+0x6b>
      34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      3f:	90                   	nop
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 62 1a 00 00 20 	cmpb   $0x20,0x1a62
      47:	74 54                	je     9d <main+0x9d>
      49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 46 0e 00 00       	call   e9b <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 9e 00 00 00    	je     fc <main+0xfc>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	0f 84 82 00 00 00    	je     e8 <main+0xe8>
    wait();
      66:	e8 40 0e 00 00       	call   eab <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      6b:	c7 04 24 60 1a 00 00 	movl   $0x1a60,(%esp)
      72:	b8 64 00 00 00       	mov    $0x64,%eax
      77:	89 44 24 04          	mov    %eax,0x4(%esp)
      7b:	e8 90 00 00 00       	call   110 <getcmd>
      80:	85 c0                	test   %eax,%eax
      82:	78 14                	js     98 <main+0x98>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      84:	80 3d 60 1a 00 00 63 	cmpb   $0x63,0x1a60
      8b:	75 c3                	jne    50 <main+0x50>
      8d:	80 3d 61 1a 00 00 64 	cmpb   $0x64,0x1a61
      94:	75 ba                	jne    50 <main+0x50>
      96:	eb a8                	jmp    40 <main+0x40>
  exit();
      98:	e8 06 0e 00 00       	call   ea3 <exit>
      buf[strlen(buf)-1] = 0;  // chop \n
      9d:	c7 04 24 60 1a 00 00 	movl   $0x1a60,(%esp)
      a4:	e8 17 0c 00 00       	call   cc0 <strlen>
      if(chdir(buf+3) < 0)
      a9:	c7 04 24 63 1a 00 00 	movl   $0x1a63,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      b0:	c6 80 5f 1a 00 00 00 	movb   $0x0,0x1a5f(%eax)
      if(chdir(buf+3) < 0)
      b7:	e8 57 0e 00 00       	call   f13 <chdir>
      bc:	85 c0                	test   %eax,%eax
      be:	79 ab                	jns    6b <main+0x6b>
        printf(2, "cannot cd %s\n", buf+3);
      c0:	c7 44 24 08 63 1a 00 	movl   $0x1a63,0x8(%esp)
      c7:	00 
      c8:	c7 44 24 04 41 14 00 	movl   $0x1441,0x4(%esp)
      cf:	00 
      d0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      d7:	e8 54 0f 00 00       	call   1030 <printf>
      dc:	eb 8d                	jmp    6b <main+0x6b>
      close(fd);
      de:	89 04 24             	mov    %eax,(%esp)
      e1:	e8 e5 0d 00 00       	call   ecb <close>
      break;
      e6:	eb 83                	jmp    6b <main+0x6b>
      runcmd(parsecmd(buf));
      e8:	c7 04 24 60 1a 00 00 	movl   $0x1a60,(%esp)
      ef:	e8 cc 0a 00 00       	call   bc0 <parsecmd>
      f4:	89 04 24             	mov    %eax,(%esp)
      f7:	e8 a4 00 00 00       	call   1a0 <runcmd>
    panic("fork");
      fc:	c7 04 24 c2 13 00 00 	movl   $0x13c2,(%esp)
     103:	e8 68 00 00 00       	call   170 <panic>
     108:	66 90                	xchg   %ax,%ax
     10a:	66 90                	xchg   %ax,%ax
     10c:	66 90                	xchg   %ax,%ax
     10e:	66 90                	xchg   %ax,%ax

00000110 <getcmd>:
{
     110:	55                   	push   %ebp
  printf(2, "$ ");
     111:	b8 98 13 00 00       	mov    $0x1398,%eax
{
     116:	89 e5                	mov    %esp,%ebp
     118:	83 ec 18             	sub    $0x18,%esp
     11b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     11e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     121:	89 75 fc             	mov    %esi,-0x4(%ebp)
     124:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     127:	89 44 24 04          	mov    %eax,0x4(%esp)
     12b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     132:	e8 f9 0e 00 00       	call   1030 <printf>
  memset(buf, 0, nbuf);
     137:	31 d2                	xor    %edx,%edx
     139:	89 74 24 08          	mov    %esi,0x8(%esp)
     13d:	89 54 24 04          	mov    %edx,0x4(%esp)
     141:	89 1c 24             	mov    %ebx,(%esp)
     144:	e8 a7 0b 00 00       	call   cf0 <memset>
  gets(buf, nbuf);
     149:	89 74 24 04          	mov    %esi,0x4(%esp)
     14d:	89 1c 24             	mov    %ebx,(%esp)
     150:	e8 fb 0b 00 00       	call   d50 <gets>
  if(buf[0] == 0) // EOF
     155:	31 c0                	xor    %eax,%eax
}
     157:	8b 75 fc             	mov    -0x4(%ebp),%esi
  if(buf[0] == 0) // EOF
     15a:	80 3b 00             	cmpb   $0x0,(%ebx)
}
     15d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  if(buf[0] == 0) // EOF
     160:	0f 94 c0             	sete   %al
}
     163:	89 ec                	mov    %ebp,%esp
     165:	5d                   	pop    %ebp
  if(buf[0] == 0) // EOF
     166:	f7 d8                	neg    %eax
}
     168:	c3                   	ret    
     169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <panic>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     176:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     17d:	8b 45 08             	mov    0x8(%ebp),%eax
     180:	89 44 24 08          	mov    %eax,0x8(%esp)
     184:	b8 35 14 00 00       	mov    $0x1435,%eax
     189:	89 44 24 04          	mov    %eax,0x4(%esp)
     18d:	e8 9e 0e 00 00       	call   1030 <printf>
  exit();
     192:	e8 0c 0d 00 00       	call   ea3 <exit>
     197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     19e:	66 90                	xchg   %ax,%ax

000001a0 <runcmd>:
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	53                   	push   %ebx
     1a4:	83 ec 24             	sub    $0x24,%esp
     1a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1aa:	85 db                	test   %ebx,%ebx
     1ac:	74 72                	je     220 <runcmd+0x80>
  switch(cmd->type){
     1ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     1b1:	0f 87 07 01 00 00    	ja     2be <runcmd+0x11e>
     1b7:	8b 03                	mov    (%ebx),%eax
     1b9:	ff 24 85 50 14 00 00 	jmp    *0x1450(,%eax,4)
    if(pipe(p) < 0)
     1c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
     1c3:	89 04 24             	mov    %eax,(%esp)
     1c6:	e8 e8 0c 00 00       	call   eb3 <pipe>
     1cb:	85 c0                	test   %eax,%eax
     1cd:	0f 88 17 01 00 00    	js     2ea <runcmd+0x14a>
  pid = fork();
     1d3:	e8 c3 0c 00 00       	call   e9b <fork>
  if(pid == -1)
     1d8:	83 f8 ff             	cmp    $0xffffffff,%eax
     1db:	0f 84 85 01 00 00    	je     366 <runcmd+0x1c6>
    if(fork1() == 0){
     1e1:	85 c0                	test   %eax,%eax
     1e3:	0f 84 0d 01 00 00    	je     2f6 <runcmd+0x156>
  pid = fork();
     1e9:	e8 ad 0c 00 00       	call   e9b <fork>
  if(pid == -1)
     1ee:	83 f8 ff             	cmp    $0xffffffff,%eax
     1f1:	0f 84 6f 01 00 00    	je     366 <runcmd+0x1c6>
    if(fork1() == 0){
     1f7:	85 c0                	test   %eax,%eax
     1f9:	0f 84 2f 01 00 00    	je     32e <runcmd+0x18e>
    close(p[0]);
     1ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     202:	89 04 24             	mov    %eax,(%esp)
     205:	e8 c1 0c 00 00       	call   ecb <close>
    close(p[1]);
     20a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     20d:	89 04 24             	mov    %eax,(%esp)
     210:	e8 b6 0c 00 00       	call   ecb <close>
    wait();
     215:	e8 91 0c 00 00       	call   eab <wait>
    wait();
     21a:	e8 8c 0c 00 00       	call   eab <wait>
    break;
     21f:	90                   	nop
      exit();
     220:	e8 7e 0c 00 00       	call   ea3 <exit>
  pid = fork();
     225:	e8 71 0c 00 00       	call   e9b <fork>
  if(pid == -1)
     22a:	83 f8 ff             	cmp    $0xffffffff,%eax
     22d:	0f 84 33 01 00 00    	je     366 <runcmd+0x1c6>
    if(fork1() == 0)
     233:	85 c0                	test   %eax,%eax
     235:	75 e9                	jne    220 <runcmd+0x80>
     237:	eb 7a                	jmp    2b3 <runcmd+0x113>
    if(ecmd->argv[0] == 0)
     239:	8b 43 04             	mov    0x4(%ebx),%eax
     23c:	85 c0                	test   %eax,%eax
     23e:	66 90                	xchg   %ax,%ax
     240:	74 de                	je     220 <runcmd+0x80>
    exec(ecmd->argv[0], ecmd->argv);
     242:	89 04 24             	mov    %eax,(%esp)
     245:	8d 53 04             	lea    0x4(%ebx),%edx
     248:	89 54 24 04          	mov    %edx,0x4(%esp)
     24c:	e8 8a 0c 00 00       	call   edb <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     251:	8b 43 04             	mov    0x4(%ebx),%eax
     254:	c7 44 24 04 a2 13 00 	movl   $0x13a2,0x4(%esp)
     25b:	00 
     25c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     263:	89 44 24 08          	mov    %eax,0x8(%esp)
     267:	e8 c4 0d 00 00       	call   1030 <printf>
    break;
     26c:	eb b2                	jmp    220 <runcmd+0x80>
  pid = fork();
     26e:	e8 28 0c 00 00       	call   e9b <fork>
  if(pid == -1)
     273:	83 f8 ff             	cmp    $0xffffffff,%eax
     276:	0f 84 ea 00 00 00    	je     366 <runcmd+0x1c6>
    if(fork1() == 0)
     27c:	85 c0                	test   %eax,%eax
     27e:	66 90                	xchg   %ax,%ax
     280:	74 31                	je     2b3 <runcmd+0x113>
    wait();
     282:	e8 24 0c 00 00       	call   eab <wait>
    runcmd(lcmd->right);
     287:	8b 43 08             	mov    0x8(%ebx),%eax
     28a:	89 04 24             	mov    %eax,(%esp)
     28d:	e8 0e ff ff ff       	call   1a0 <runcmd>
    close(rcmd->fd);
     292:	8b 43 14             	mov    0x14(%ebx),%eax
     295:	89 04 24             	mov    %eax,(%esp)
     298:	e8 2e 0c 00 00       	call   ecb <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     29d:	8b 43 10             	mov    0x10(%ebx),%eax
     2a0:	89 44 24 04          	mov    %eax,0x4(%esp)
     2a4:	8b 43 08             	mov    0x8(%ebx),%eax
     2a7:	89 04 24             	mov    %eax,(%esp)
     2aa:	e8 34 0c 00 00       	call   ee3 <open>
     2af:	85 c0                	test   %eax,%eax
     2b1:	78 17                	js     2ca <runcmd+0x12a>
      runcmd(bcmd->cmd);
     2b3:	8b 43 04             	mov    0x4(%ebx),%eax
     2b6:	89 04 24             	mov    %eax,(%esp)
     2b9:	e8 e2 fe ff ff       	call   1a0 <runcmd>
    panic("runcmd");
     2be:	c7 04 24 9b 13 00 00 	movl   $0x139b,(%esp)
     2c5:	e8 a6 fe ff ff       	call   170 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     2ca:	8b 43 08             	mov    0x8(%ebx),%eax
     2cd:	c7 44 24 04 b2 13 00 	movl   $0x13b2,0x4(%esp)
     2d4:	00 
     2d5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     2dc:	89 44 24 08          	mov    %eax,0x8(%esp)
     2e0:	e8 4b 0d 00 00       	call   1030 <printf>
     2e5:	e9 36 ff ff ff       	jmp    220 <runcmd+0x80>
      panic("pipe");
     2ea:	c7 04 24 c7 13 00 00 	movl   $0x13c7,(%esp)
     2f1:	e8 7a fe ff ff       	call   170 <panic>
      close(1);
     2f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2fd:	e8 c9 0b 00 00       	call   ecb <close>
      dup(p[1]);
     302:	8b 45 f4             	mov    -0xc(%ebp),%eax
     305:	89 04 24             	mov    %eax,(%esp)
     308:	e8 0e 0c 00 00       	call   f1b <dup>
      close(p[0]);
     30d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     310:	89 04 24             	mov    %eax,(%esp)
     313:	e8 b3 0b 00 00       	call   ecb <close>
      close(p[1]);
     318:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31b:	89 04 24             	mov    %eax,(%esp)
     31e:	e8 a8 0b 00 00       	call   ecb <close>
      runcmd(pcmd->left);
     323:	8b 43 04             	mov    0x4(%ebx),%eax
     326:	89 04 24             	mov    %eax,(%esp)
     329:	e8 72 fe ff ff       	call   1a0 <runcmd>
      close(0);
     32e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     335:	e8 91 0b 00 00       	call   ecb <close>
      dup(p[0]);
     33a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     33d:	89 04 24             	mov    %eax,(%esp)
     340:	e8 d6 0b 00 00       	call   f1b <dup>
      close(p[0]);
     345:	8b 45 f0             	mov    -0x10(%ebp),%eax
     348:	89 04 24             	mov    %eax,(%esp)
     34b:	e8 7b 0b 00 00       	call   ecb <close>
      close(p[1]);
     350:	8b 45 f4             	mov    -0xc(%ebp),%eax
     353:	89 04 24             	mov    %eax,(%esp)
     356:	e8 70 0b 00 00       	call   ecb <close>
      runcmd(pcmd->right);
     35b:	8b 43 08             	mov    0x8(%ebx),%eax
     35e:	89 04 24             	mov    %eax,(%esp)
     361:	e8 3a fe ff ff       	call   1a0 <runcmd>
    panic("fork");
     366:	c7 04 24 c2 13 00 00 	movl   $0x13c2,(%esp)
     36d:	e8 fe fd ff ff       	call   170 <panic>
     372:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000380 <fork1>:
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 18             	sub    $0x18,%esp
  pid = fork();
     386:	e8 10 0b 00 00       	call   e9b <fork>
  if(pid == -1)
     38b:	83 f8 ff             	cmp    $0xffffffff,%eax
     38e:	74 02                	je     392 <fork1+0x12>
  return pid;
}
     390:	c9                   	leave  
     391:	c3                   	ret    
    panic("fork");
     392:	c7 04 24 c2 13 00 00 	movl   $0x13c2,(%esp)
     399:	e8 d2 fd ff ff       	call   170 <panic>
     39e:	66 90                	xchg   %ax,%ax

000003a0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
     3a4:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3ae:	e8 ed 0e 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3b3:	31 d2                	xor    %edx,%edx
     3b5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     3b9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3bb:	b8 54 00 00 00       	mov    $0x54,%eax
     3c0:	89 1c 24             	mov    %ebx,(%esp)
     3c3:	89 44 24 08          	mov    %eax,0x8(%esp)
     3c7:	e8 24 09 00 00       	call   cf0 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     3cc:	89 d8                	mov    %ebx,%eax
  cmd->type = EXEC;
     3ce:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     3d4:	83 c4 14             	add    $0x14,%esp
     3d7:	5b                   	pop    %ebx
     3d8:	5d                   	pop    %ebp
     3d9:	c3                   	ret    
     3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003e0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	53                   	push   %ebx
     3e4:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3ee:	e8 ad 0e 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3f3:	31 d2                	xor    %edx,%edx
     3f5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     3f9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3fb:	b8 18 00 00 00       	mov    $0x18,%eax
     400:	89 1c 24             	mov    %ebx,(%esp)
     403:	89 44 24 08          	mov    %eax,0x8(%esp)
     407:	e8 e4 08 00 00       	call   cf0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     40c:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     40f:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     415:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     418:	8b 45 0c             	mov    0xc(%ebp),%eax
     41b:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     41e:	8b 45 10             	mov    0x10(%ebp),%eax
     421:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     424:	8b 45 14             	mov    0x14(%ebp),%eax
     427:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     42a:	8b 45 18             	mov    0x18(%ebp),%eax
     42d:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     430:	83 c4 14             	add    $0x14,%esp
     433:	89 d8                	mov    %ebx,%eax
     435:	5b                   	pop    %ebx
     436:	5d                   	pop    %ebp
     437:	c3                   	ret    
     438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     43f:	90                   	nop

00000440 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     447:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     44e:	e8 4d 0e 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     453:	31 d2                	xor    %edx,%edx
     455:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     459:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     45b:	b8 0c 00 00 00       	mov    $0xc,%eax
     460:	89 1c 24             	mov    %ebx,(%esp)
     463:	89 44 24 08          	mov    %eax,0x8(%esp)
     467:	e8 84 08 00 00       	call   cf0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     46c:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     46f:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     475:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     478:	8b 45 0c             	mov    0xc(%ebp),%eax
     47b:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     47e:	83 c4 14             	add    $0x14,%esp
     481:	89 d8                	mov    %ebx,%eax
     483:	5b                   	pop    %ebx
     484:	5d                   	pop    %ebp
     485:	c3                   	ret    
     486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     48d:	8d 76 00             	lea    0x0(%esi),%esi

00000490 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	53                   	push   %ebx
     494:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     497:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     49e:	e8 fd 0d 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4a3:	31 d2                	xor    %edx,%edx
     4a5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     4a9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4ab:	b8 0c 00 00 00       	mov    $0xc,%eax
     4b0:	89 1c 24             	mov    %ebx,(%esp)
     4b3:	89 44 24 08          	mov    %eax,0x8(%esp)
     4b7:	e8 34 08 00 00       	call   cf0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4bc:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4bf:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4c5:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     4cb:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4ce:	83 c4 14             	add    $0x14,%esp
     4d1:	89 d8                	mov    %ebx,%eax
     4d3:	5b                   	pop    %ebx
     4d4:	5d                   	pop    %ebp
     4d5:	c3                   	ret    
     4d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	53                   	push   %ebx
     4e4:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4e7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     4ee:	e8 ad 0d 00 00       	call   12a0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4f3:	31 d2                	xor    %edx,%edx
     4f5:	89 54 24 04          	mov    %edx,0x4(%esp)
  cmd = malloc(sizeof(*cmd));
     4f9:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4fb:	b8 08 00 00 00       	mov    $0x8,%eax
     500:	89 1c 24             	mov    %ebx,(%esp)
     503:	89 44 24 08          	mov    %eax,0x8(%esp)
     507:	e8 e4 07 00 00       	call   cf0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     50c:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     50f:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     515:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     518:	83 c4 14             	add    $0x14,%esp
     51b:	89 d8                	mov    %ebx,%eax
     51d:	5b                   	pop    %ebx
     51e:	5d                   	pop    %ebp
     51f:	c3                   	ret    

00000520 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	57                   	push   %edi
     524:	56                   	push   %esi
     525:	53                   	push   %ebx
     526:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     529:	8b 45 08             	mov    0x8(%ebp),%eax
{
     52c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     52f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     532:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     534:	39 df                	cmp    %ebx,%edi
     536:	72 0d                	jb     545 <gettoken+0x25>
     538:	eb 22                	jmp    55c <gettoken+0x3c>
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     540:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     541:	39 fb                	cmp    %edi,%ebx
     543:	74 17                	je     55c <gettoken+0x3c>
     545:	0f be 07             	movsbl (%edi),%eax
     548:	c7 04 24 54 1a 00 00 	movl   $0x1a54,(%esp)
     54f:	89 44 24 04          	mov    %eax,0x4(%esp)
     553:	e8 b8 07 00 00       	call   d10 <strchr>
     558:	85 c0                	test   %eax,%eax
     55a:	75 e4                	jne    540 <gettoken+0x20>
  if(q)
     55c:	85 f6                	test   %esi,%esi
     55e:	74 02                	je     562 <gettoken+0x42>
    *q = s;
     560:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     562:	0f be 07             	movsbl (%edi),%eax
  switch(*s){
     565:	3c 3c                	cmp    $0x3c,%al
     567:	0f 8f d3 00 00 00    	jg     640 <gettoken+0x120>
     56d:	3c 3a                	cmp    $0x3a,%al
     56f:	0f 8f b9 00 00 00    	jg     62e <gettoken+0x10e>
     575:	84 c0                	test   %al,%al
     577:	75 47                	jne    5c0 <gettoken+0xa0>
     579:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     57b:	8b 55 14             	mov    0x14(%ebp),%edx
     57e:	85 d2                	test   %edx,%edx
     580:	74 05                	je     587 <gettoken+0x67>
    *eq = s;
     582:	8b 45 14             	mov    0x14(%ebp),%eax
     585:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     587:	39 df                	cmp    %ebx,%edi
     589:	72 0a                	jb     595 <gettoken+0x75>
     58b:	eb 1f                	jmp    5ac <gettoken+0x8c>
     58d:	8d 76 00             	lea    0x0(%esi),%esi
    s++;
     590:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     591:	39 fb                	cmp    %edi,%ebx
     593:	74 17                	je     5ac <gettoken+0x8c>
     595:	0f be 07             	movsbl (%edi),%eax
     598:	c7 04 24 54 1a 00 00 	movl   $0x1a54,(%esp)
     59f:	89 44 24 04          	mov    %eax,0x4(%esp)
     5a3:	e8 68 07 00 00       	call   d10 <strchr>
     5a8:	85 c0                	test   %eax,%eax
     5aa:	75 e4                	jne    590 <gettoken+0x70>
  *ps = s;
     5ac:	8b 45 08             	mov    0x8(%ebp),%eax
     5af:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5b1:	83 c4 1c             	add    $0x1c,%esp
     5b4:	89 f0                	mov    %esi,%eax
     5b6:	5b                   	pop    %ebx
     5b7:	5e                   	pop    %esi
     5b8:	5f                   	pop    %edi
     5b9:	5d                   	pop    %ebp
     5ba:	c3                   	ret    
     5bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5bf:	90                   	nop
  switch(*s){
     5c0:	79 5e                	jns    620 <gettoken+0x100>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5c2:	39 fb                	cmp    %edi,%ebx
     5c4:	77 39                	ja     5ff <gettoken+0xdf>
  if(eq)
     5c6:	8b 45 14             	mov    0x14(%ebp),%eax
     5c9:	be 61 00 00 00       	mov    $0x61,%esi
     5ce:	85 c0                	test   %eax,%eax
     5d0:	75 b0                	jne    582 <gettoken+0x62>
     5d2:	eb d8                	jmp    5ac <gettoken+0x8c>
     5d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5df:	90                   	nop
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5e0:	0f be 07             	movsbl (%edi),%eax
     5e3:	c7 04 24 4c 1a 00 00 	movl   $0x1a4c,(%esp)
     5ea:	89 44 24 04          	mov    %eax,0x4(%esp)
     5ee:	e8 1d 07 00 00       	call   d10 <strchr>
     5f3:	85 c0                	test   %eax,%eax
     5f5:	75 1c                	jne    613 <gettoken+0xf3>
      s++;
     5f7:	47                   	inc    %edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f8:	39 fb                	cmp    %edi,%ebx
     5fa:	74 ca                	je     5c6 <gettoken+0xa6>
     5fc:	0f be 07             	movsbl (%edi),%eax
     5ff:	89 44 24 04          	mov    %eax,0x4(%esp)
     603:	c7 04 24 54 1a 00 00 	movl   $0x1a54,(%esp)
     60a:	e8 01 07 00 00       	call   d10 <strchr>
     60f:	85 c0                	test   %eax,%eax
     611:	74 cd                	je     5e0 <gettoken+0xc0>
    ret = 'a';
     613:	be 61 00 00 00       	mov    $0x61,%esi
     618:	e9 5e ff ff ff       	jmp    57b <gettoken+0x5b>
     61d:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     620:	3c 26                	cmp    $0x26,%al
     622:	74 0a                	je     62e <gettoken+0x10e>
     624:	88 c1                	mov    %al,%cl
     626:	80 e9 28             	sub    $0x28,%cl
     629:	80 f9 01             	cmp    $0x1,%cl
     62c:	77 94                	ja     5c2 <gettoken+0xa2>
  ret = *s;
     62e:	0f be f0             	movsbl %al,%esi
    s++;
     631:	47                   	inc    %edi
    break;
     632:	e9 44 ff ff ff       	jmp    57b <gettoken+0x5b>
     637:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     63e:	66 90                	xchg   %ax,%ax
  switch(*s){
     640:	3c 3e                	cmp    $0x3e,%al
     642:	75 1c                	jne    660 <gettoken+0x140>
    if(*s == '>'){
     644:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
    s++;
     648:	8d 47 01             	lea    0x1(%edi),%eax
    if(*s == '>'){
     64b:	74 1c                	je     669 <gettoken+0x149>
    s++;
     64d:	89 c7                	mov    %eax,%edi
     64f:	be 3e 00 00 00       	mov    $0x3e,%esi
     654:	e9 22 ff ff ff       	jmp    57b <gettoken+0x5b>
     659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     660:	3c 7c                	cmp    $0x7c,%al
     662:	74 ca                	je     62e <gettoken+0x10e>
     664:	e9 59 ff ff ff       	jmp    5c2 <gettoken+0xa2>
      s++;
     669:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     66c:	be 2b 00 00 00       	mov    $0x2b,%esi
     671:	e9 05 ff ff ff       	jmp    57b <gettoken+0x5b>
     676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     67d:	8d 76 00             	lea    0x0(%esi),%esi

00000680 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	57                   	push   %edi
     684:	56                   	push   %esi
     685:	53                   	push   %ebx
     686:	83 ec 1c             	sub    $0x1c,%esp
     689:	8b 7d 08             	mov    0x8(%ebp),%edi
     68c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     68f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     691:	39 f3                	cmp    %esi,%ebx
     693:	72 10                	jb     6a5 <peek+0x25>
     695:	eb 25                	jmp    6bc <peek+0x3c>
     697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     69e:	66 90                	xchg   %ax,%ax
    s++;
     6a0:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     6a1:	39 de                	cmp    %ebx,%esi
     6a3:	74 17                	je     6bc <peek+0x3c>
     6a5:	0f be 03             	movsbl (%ebx),%eax
     6a8:	c7 04 24 54 1a 00 00 	movl   $0x1a54,(%esp)
     6af:	89 44 24 04          	mov    %eax,0x4(%esp)
     6b3:	e8 58 06 00 00       	call   d10 <strchr>
     6b8:	85 c0                	test   %eax,%eax
     6ba:	75 e4                	jne    6a0 <peek+0x20>
  *ps = s;
     6bc:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6be:	31 c0                	xor    %eax,%eax
     6c0:	0f be 13             	movsbl (%ebx),%edx
     6c3:	84 d2                	test   %dl,%dl
     6c5:	75 09                	jne    6d0 <peek+0x50>
}
     6c7:	83 c4 1c             	add    $0x1c,%esp
     6ca:	5b                   	pop    %ebx
     6cb:	5e                   	pop    %esi
     6cc:	5f                   	pop    %edi
     6cd:	5d                   	pop    %ebp
     6ce:	c3                   	ret    
     6cf:	90                   	nop
  return *s && strchr(toks, *s);
     6d0:	89 54 24 04          	mov    %edx,0x4(%esp)
     6d4:	8b 45 10             	mov    0x10(%ebp),%eax
     6d7:	89 04 24             	mov    %eax,(%esp)
     6da:	e8 31 06 00 00       	call   d10 <strchr>
     6df:	85 c0                	test   %eax,%eax
     6e1:	0f 95 c0             	setne  %al
}
     6e4:	83 c4 1c             	add    $0x1c,%esp
     6e7:	5b                   	pop    %ebx
  return *s && strchr(toks, *s);
     6e8:	0f b6 c0             	movzbl %al,%eax
}
     6eb:	5e                   	pop    %esi
     6ec:	5f                   	pop    %edi
     6ed:	5d                   	pop    %ebp
     6ee:	c3                   	ret    
     6ef:	90                   	nop

000006f0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	57                   	push   %edi
     6f4:	56                   	push   %esi
     6f5:	53                   	push   %ebx
     6f6:	83 ec 3c             	sub    $0x3c,%esp
     6f9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6fc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6ff:	90                   	nop
     700:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     704:	b8 e9 13 00 00       	mov    $0x13e9,%eax
     709:	89 44 24 08          	mov    %eax,0x8(%esp)
     70d:	89 34 24             	mov    %esi,(%esp)
     710:	e8 6b ff ff ff       	call   680 <peek>
     715:	85 c0                	test   %eax,%eax
     717:	0f 84 93 00 00 00    	je     7b0 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     71d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     721:	31 c0                	xor    %eax,%eax
     723:	89 44 24 0c          	mov    %eax,0xc(%esp)
     727:	31 c0                	xor    %eax,%eax
     729:	89 44 24 08          	mov    %eax,0x8(%esp)
     72d:	89 34 24             	mov    %esi,(%esp)
     730:	e8 eb fd ff ff       	call   520 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     735:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     739:	89 34 24             	mov    %esi,(%esp)
    tok = gettoken(ps, es, 0, 0);
     73c:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     73e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     741:	89 44 24 0c          	mov    %eax,0xc(%esp)
     745:	8d 45 e0             	lea    -0x20(%ebp),%eax
     748:	89 44 24 08          	mov    %eax,0x8(%esp)
     74c:	e8 cf fd ff ff       	call   520 <gettoken>
     751:	83 f8 61             	cmp    $0x61,%eax
     754:	75 65                	jne    7bb <parseredirs+0xcb>
      panic("missing file for redirection");
    switch(tok){
     756:	83 ff 3c             	cmp    $0x3c,%edi
     759:	74 45                	je     7a0 <parseredirs+0xb0>
     75b:	83 ff 3e             	cmp    $0x3e,%edi
     75e:	66 90                	xchg   %ax,%ax
     760:	74 05                	je     767 <parseredirs+0x77>
     762:	83 ff 2b             	cmp    $0x2b,%edi
     765:	75 99                	jne    700 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     767:	ba 01 00 00 00       	mov    $0x1,%edx
     76c:	b9 01 02 00 00       	mov    $0x201,%ecx
     771:	89 54 24 10          	mov    %edx,0x10(%esp)
     775:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     779:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     77c:	89 44 24 08          	mov    %eax,0x8(%esp)
     780:	8b 45 e0             	mov    -0x20(%ebp),%eax
     783:	89 44 24 04          	mov    %eax,0x4(%esp)
     787:	8b 45 08             	mov    0x8(%ebp),%eax
     78a:	89 04 24             	mov    %eax,(%esp)
     78d:	e8 4e fc ff ff       	call   3e0 <redircmd>
     792:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     795:	e9 66 ff ff ff       	jmp    700 <parseredirs+0x10>
     79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7a0:	31 ff                	xor    %edi,%edi
     7a2:	31 c0                	xor    %eax,%eax
     7a4:	89 7c 24 10          	mov    %edi,0x10(%esp)
     7a8:	89 44 24 0c          	mov    %eax,0xc(%esp)
     7ac:	eb cb                	jmp    779 <parseredirs+0x89>
     7ae:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     7b0:	8b 45 08             	mov    0x8(%ebp),%eax
     7b3:	83 c4 3c             	add    $0x3c,%esp
     7b6:	5b                   	pop    %ebx
     7b7:	5e                   	pop    %esi
     7b8:	5f                   	pop    %edi
     7b9:	5d                   	pop    %ebp
     7ba:	c3                   	ret    
      panic("missing file for redirection");
     7bb:	c7 04 24 cc 13 00 00 	movl   $0x13cc,(%esp)
     7c2:	e8 a9 f9 ff ff       	call   170 <panic>
     7c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7ce:	66 90                	xchg   %ax,%ax

000007d0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     7d0:	55                   	push   %ebp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     7d1:	ba ec 13 00 00       	mov    $0x13ec,%edx
{
     7d6:	89 e5                	mov    %esp,%ebp
     7d8:	57                   	push   %edi
     7d9:	56                   	push   %esi
     7da:	53                   	push   %ebx
     7db:	83 ec 3c             	sub    $0x3c,%esp
  if(peek(ps, es, "("))
     7de:	89 54 24 08          	mov    %edx,0x8(%esp)
{
     7e2:	8b 75 08             	mov    0x8(%ebp),%esi
     7e5:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(peek(ps, es, "("))
     7e8:	89 34 24             	mov    %esi,(%esp)
     7eb:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7ef:	e8 8c fe ff ff       	call   680 <peek>
     7f4:	85 c0                	test   %eax,%eax
     7f6:	0f 85 a4 00 00 00    	jne    8a0 <parseexec+0xd0>
     7fc:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     7fe:	e8 9d fb ff ff       	call   3a0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     803:	89 7c 24 08          	mov    %edi,0x8(%esp)
     807:	89 74 24 04          	mov    %esi,0x4(%esp)
     80b:	89 04 24             	mov    %eax,(%esp)
  ret = execcmd();
     80e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     811:	e8 da fe ff ff       	call   6f0 <parseredirs>
     816:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     819:	eb 1b                	jmp    836 <parseexec+0x66>
     81b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     81f:	90                   	nop
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     820:	89 7c 24 08          	mov    %edi,0x8(%esp)
     824:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     827:	89 74 24 04          	mov    %esi,0x4(%esp)
     82b:	89 04 24             	mov    %eax,(%esp)
     82e:	e8 bd fe ff ff       	call   6f0 <parseredirs>
     833:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     836:	89 7c 24 04          	mov    %edi,0x4(%esp)
     83a:	b8 03 14 00 00       	mov    $0x1403,%eax
     83f:	89 44 24 08          	mov    %eax,0x8(%esp)
     843:	89 34 24             	mov    %esi,(%esp)
     846:	e8 35 fe ff ff       	call   680 <peek>
     84b:	85 c0                	test   %eax,%eax
     84d:	75 71                	jne    8c0 <parseexec+0xf0>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     84f:	89 7c 24 04          	mov    %edi,0x4(%esp)
     853:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     856:	89 44 24 0c          	mov    %eax,0xc(%esp)
     85a:	8d 45 e0             	lea    -0x20(%ebp),%eax
     85d:	89 44 24 08          	mov    %eax,0x8(%esp)
     861:	89 34 24             	mov    %esi,(%esp)
     864:	e8 b7 fc ff ff       	call   520 <gettoken>
     869:	85 c0                	test   %eax,%eax
     86b:	74 53                	je     8c0 <parseexec+0xf0>
    if(tok != 'a')
     86d:	83 f8 61             	cmp    $0x61,%eax
     870:	75 6d                	jne    8df <parseexec+0x10f>
    cmd->argv[argc] = q;
     872:	8b 45 e0             	mov    -0x20(%ebp),%eax
     875:	8b 55 d0             	mov    -0x30(%ebp),%edx
     878:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     87c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     87f:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     883:	43                   	inc    %ebx
    if(argc >= MAXARGS)
     884:	83 fb 0a             	cmp    $0xa,%ebx
     887:	75 97                	jne    820 <parseexec+0x50>
      panic("too many args");
     889:	c7 04 24 f5 13 00 00 	movl   $0x13f5,(%esp)
     890:	e8 db f8 ff ff       	call   170 <panic>
     895:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return parseblock(ps, es);
     8a0:	89 7c 24 04          	mov    %edi,0x4(%esp)
     8a4:	89 34 24             	mov    %esi,(%esp)
     8a7:	e8 94 01 00 00       	call   a40 <parseblock>
     8ac:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     8af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     8b2:	83 c4 3c             	add    $0x3c,%esp
     8b5:	5b                   	pop    %ebx
     8b6:	5e                   	pop    %esi
     8b7:	5f                   	pop    %edi
     8b8:	5d                   	pop    %ebp
     8b9:	c3                   	ret    
     8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     8c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
     8c3:	8d 04 98             	lea    (%eax,%ebx,4),%eax
     8c6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     8cd:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     8d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     8d7:	83 c4 3c             	add    $0x3c,%esp
     8da:	5b                   	pop    %ebx
     8db:	5e                   	pop    %esi
     8dc:	5f                   	pop    %edi
     8dd:	5d                   	pop    %ebp
     8de:	c3                   	ret    
      panic("syntax");
     8df:	c7 04 24 ee 13 00 00 	movl   $0x13ee,(%esp)
     8e6:	e8 85 f8 ff ff       	call   170 <panic>
     8eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8ef:	90                   	nop

000008f0 <parsepipe>:
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 28             	sub    $0x28,%esp
     8f6:	89 75 f8             	mov    %esi,-0x8(%ebp)
     8f9:	8b 75 08             	mov    0x8(%ebp),%esi
     8fc:	89 7d fc             	mov    %edi,-0x4(%ebp)
     8ff:	8b 7d 0c             	mov    0xc(%ebp),%edi
     902:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  cmd = parseexec(ps, es);
     905:	89 34 24             	mov    %esi,(%esp)
     908:	89 7c 24 04          	mov    %edi,0x4(%esp)
     90c:	e8 bf fe ff ff       	call   7d0 <parseexec>
  if(peek(ps, es, "|")){
     911:	b9 08 14 00 00       	mov    $0x1408,%ecx
     916:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     91a:	89 7c 24 04          	mov    %edi,0x4(%esp)
     91e:	89 34 24             	mov    %esi,(%esp)
  cmd = parseexec(ps, es);
     921:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     923:	e8 58 fd ff ff       	call   680 <peek>
     928:	85 c0                	test   %eax,%eax
     92a:	75 14                	jne    940 <parsepipe+0x50>
}
     92c:	8b 75 f8             	mov    -0x8(%ebp),%esi
     92f:	89 d8                	mov    %ebx,%eax
     931:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     934:	8b 7d fc             	mov    -0x4(%ebp),%edi
     937:	89 ec                	mov    %ebp,%esp
     939:	5d                   	pop    %ebp
     93a:	c3                   	ret    
     93b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     93f:	90                   	nop
    gettoken(ps, es, 0, 0);
     940:	89 7c 24 04          	mov    %edi,0x4(%esp)
     944:	31 d2                	xor    %edx,%edx
     946:	31 c0                	xor    %eax,%eax
     948:	89 54 24 08          	mov    %edx,0x8(%esp)
     94c:	89 34 24             	mov    %esi,(%esp)
     94f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     953:	e8 c8 fb ff ff       	call   520 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     958:	89 7c 24 04          	mov    %edi,0x4(%esp)
     95c:	89 34 24             	mov    %esi,(%esp)
     95f:	e8 8c ff ff ff       	call   8f0 <parsepipe>
}
     964:	8b 75 f8             	mov    -0x8(%ebp),%esi
    cmd = pipecmd(cmd, parsepipe(ps, es));
     967:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
     96a:	8b 7d fc             	mov    -0x4(%ebp),%edi
     96d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    cmd = pipecmd(cmd, parsepipe(ps, es));
     970:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     973:	89 ec                	mov    %ebp,%esp
     975:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     976:	e9 c5 fa ff ff       	jmp    440 <pipecmd>
     97b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     97f:	90                   	nop

00000980 <parseline>:
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	57                   	push   %edi
     984:	56                   	push   %esi
     985:	53                   	push   %ebx
     986:	83 ec 1c             	sub    $0x1c,%esp
     989:	8b 75 08             	mov    0x8(%ebp),%esi
     98c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     98f:	89 34 24             	mov    %esi,(%esp)
     992:	89 7c 24 04          	mov    %edi,0x4(%esp)
     996:	e8 55 ff ff ff       	call   8f0 <parsepipe>
     99b:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     99d:	eb 23                	jmp    9c2 <parseline+0x42>
     99f:	90                   	nop
    gettoken(ps, es, 0, 0);
     9a0:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9a4:	31 c0                	xor    %eax,%eax
     9a6:	89 44 24 0c          	mov    %eax,0xc(%esp)
     9aa:	31 c0                	xor    %eax,%eax
     9ac:	89 44 24 08          	mov    %eax,0x8(%esp)
     9b0:	89 34 24             	mov    %esi,(%esp)
     9b3:	e8 68 fb ff ff       	call   520 <gettoken>
    cmd = backcmd(cmd);
     9b8:	89 1c 24             	mov    %ebx,(%esp)
     9bb:	e8 20 fb ff ff       	call   4e0 <backcmd>
     9c0:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     9c2:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9c6:	b8 0a 14 00 00       	mov    $0x140a,%eax
     9cb:	89 44 24 08          	mov    %eax,0x8(%esp)
     9cf:	89 34 24             	mov    %esi,(%esp)
     9d2:	e8 a9 fc ff ff       	call   680 <peek>
     9d7:	85 c0                	test   %eax,%eax
     9d9:	75 c5                	jne    9a0 <parseline+0x20>
  if(peek(ps, es, ";")){
     9db:	89 7c 24 04          	mov    %edi,0x4(%esp)
     9df:	b9 06 14 00 00       	mov    $0x1406,%ecx
     9e4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     9e8:	89 34 24             	mov    %esi,(%esp)
     9eb:	e8 90 fc ff ff       	call   680 <peek>
     9f0:	85 c0                	test   %eax,%eax
     9f2:	75 0c                	jne    a00 <parseline+0x80>
}
     9f4:	83 c4 1c             	add    $0x1c,%esp
     9f7:	89 d8                	mov    %ebx,%eax
     9f9:	5b                   	pop    %ebx
     9fa:	5e                   	pop    %esi
     9fb:	5f                   	pop    %edi
     9fc:	5d                   	pop    %ebp
     9fd:	c3                   	ret    
     9fe:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     a00:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a04:	31 d2                	xor    %edx,%edx
     a06:	31 c0                	xor    %eax,%eax
     a08:	89 54 24 08          	mov    %edx,0x8(%esp)
     a0c:	89 34 24             	mov    %esi,(%esp)
     a0f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a13:	e8 08 fb ff ff       	call   520 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     a18:	89 7c 24 04          	mov    %edi,0x4(%esp)
     a1c:	89 34 24             	mov    %esi,(%esp)
     a1f:	e8 5c ff ff ff       	call   980 <parseline>
     a24:	89 5d 08             	mov    %ebx,0x8(%ebp)
     a27:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     a2a:	83 c4 1c             	add    $0x1c,%esp
     a2d:	5b                   	pop    %ebx
     a2e:	5e                   	pop    %esi
     a2f:	5f                   	pop    %edi
     a30:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     a31:	e9 5a fa ff ff       	jmp    490 <listcmd>
     a36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a3d:	8d 76 00             	lea    0x0(%esi),%esi

00000a40 <parseblock>:
{
     a40:	55                   	push   %ebp
  if(!peek(ps, es, "("))
     a41:	b8 ec 13 00 00       	mov    $0x13ec,%eax
{
     a46:	89 e5                	mov    %esp,%ebp
     a48:	83 ec 28             	sub    $0x28,%esp
     a4b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     a4e:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a51:	89 75 f8             	mov    %esi,-0x8(%ebp)
     a54:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     a57:	89 44 24 08          	mov    %eax,0x8(%esp)
{
     a5b:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(!peek(ps, es, "("))
     a5e:	89 1c 24             	mov    %ebx,(%esp)
     a61:	89 74 24 04          	mov    %esi,0x4(%esp)
     a65:	e8 16 fc ff ff       	call   680 <peek>
     a6a:	85 c0                	test   %eax,%eax
     a6c:	74 74                	je     ae2 <parseblock+0xa2>
  gettoken(ps, es, 0, 0);
     a6e:	89 74 24 04          	mov    %esi,0x4(%esp)
     a72:	31 c9                	xor    %ecx,%ecx
     a74:	31 ff                	xor    %edi,%edi
     a76:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
     a7a:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a7e:	89 1c 24             	mov    %ebx,(%esp)
     a81:	e8 9a fa ff ff       	call   520 <gettoken>
  cmd = parseline(ps, es);
     a86:	89 74 24 04          	mov    %esi,0x4(%esp)
     a8a:	89 1c 24             	mov    %ebx,(%esp)
     a8d:	e8 ee fe ff ff       	call   980 <parseline>
  if(!peek(ps, es, ")"))
     a92:	89 74 24 04          	mov    %esi,0x4(%esp)
     a96:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseline(ps, es);
     a99:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     a9b:	b8 28 14 00 00       	mov    $0x1428,%eax
     aa0:	89 44 24 08          	mov    %eax,0x8(%esp)
     aa4:	e8 d7 fb ff ff       	call   680 <peek>
     aa9:	85 c0                	test   %eax,%eax
     aab:	74 41                	je     aee <parseblock+0xae>
  gettoken(ps, es, 0, 0);
     aad:	89 74 24 04          	mov    %esi,0x4(%esp)
     ab1:	31 d2                	xor    %edx,%edx
     ab3:	31 c0                	xor    %eax,%eax
     ab5:	89 54 24 08          	mov    %edx,0x8(%esp)
     ab9:	89 1c 24             	mov    %ebx,(%esp)
     abc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ac0:	e8 5b fa ff ff       	call   520 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     ac5:	89 74 24 08          	mov    %esi,0x8(%esp)
     ac9:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     acd:	89 3c 24             	mov    %edi,(%esp)
     ad0:	e8 1b fc ff ff       	call   6f0 <parseredirs>
}
     ad5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     ad8:	8b 75 f8             	mov    -0x8(%ebp),%esi
     adb:	8b 7d fc             	mov    -0x4(%ebp),%edi
     ade:	89 ec                	mov    %ebp,%esp
     ae0:	5d                   	pop    %ebp
     ae1:	c3                   	ret    
    panic("parseblock");
     ae2:	c7 04 24 0c 14 00 00 	movl   $0x140c,(%esp)
     ae9:	e8 82 f6 ff ff       	call   170 <panic>
    panic("syntax - missing )");
     aee:	c7 04 24 17 14 00 00 	movl   $0x1417,(%esp)
     af5:	e8 76 f6 ff ff       	call   170 <panic>
     afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b00 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	53                   	push   %ebx
     b04:	83 ec 14             	sub    $0x14,%esp
     b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b0a:	85 db                	test   %ebx,%ebx
     b0c:	0f 84 9e 00 00 00    	je     bb0 <nulterminate+0xb0>
    return 0;

  switch(cmd->type){
     b12:	83 3b 05             	cmpl   $0x5,(%ebx)
     b15:	77 69                	ja     b80 <nulterminate+0x80>
     b17:	8b 03                	mov    (%ebx),%eax
     b19:	ff 24 85 68 14 00 00 	jmp    *0x1468(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     b20:	8b 43 04             	mov    0x4(%ebx),%eax
     b23:	89 04 24             	mov    %eax,(%esp)
     b26:	e8 d5 ff ff ff       	call   b00 <nulterminate>
    nulterminate(lcmd->right);
     b2b:	8b 43 08             	mov    0x8(%ebx),%eax
     b2e:	89 04 24             	mov    %eax,(%esp)
     b31:	e8 ca ff ff ff       	call   b00 <nulterminate>
    break;
     b36:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     b38:	83 c4 14             	add    $0x14,%esp
     b3b:	5b                   	pop    %ebx
     b3c:	5d                   	pop    %ebp
     b3d:	c3                   	ret    
     b3e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     b40:	8b 43 04             	mov    0x4(%ebx),%eax
     b43:	89 04 24             	mov    %eax,(%esp)
     b46:	e8 b5 ff ff ff       	call   b00 <nulterminate>
}
     b4b:	83 c4 14             	add    $0x14,%esp
    break;
     b4e:	89 d8                	mov    %ebx,%eax
}
     b50:	5b                   	pop    %ebx
     b51:	5d                   	pop    %ebp
     b52:	c3                   	ret    
     b53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     b60:	8b 4b 04             	mov    0x4(%ebx),%ecx
     b63:	8d 43 08             	lea    0x8(%ebx),%eax
     b66:	85 c9                	test   %ecx,%ecx
     b68:	74 16                	je     b80 <nulterminate+0x80>
     b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     b70:	8b 50 24             	mov    0x24(%eax),%edx
     b73:	83 c0 04             	add    $0x4,%eax
     b76:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     b79:	8b 50 fc             	mov    -0x4(%eax),%edx
     b7c:	85 d2                	test   %edx,%edx
     b7e:	75 f0                	jne    b70 <nulterminate+0x70>
}
     b80:	83 c4 14             	add    $0x14,%esp
  switch(cmd->type){
     b83:	89 d8                	mov    %ebx,%eax
}
     b85:	5b                   	pop    %ebx
     b86:	5d                   	pop    %ebp
     b87:	c3                   	ret    
     b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b8f:	90                   	nop
    nulterminate(rcmd->cmd);
     b90:	8b 43 04             	mov    0x4(%ebx),%eax
     b93:	89 04 24             	mov    %eax,(%esp)
     b96:	e8 65 ff ff ff       	call   b00 <nulterminate>
    *rcmd->efile = 0;
     b9b:	8b 43 0c             	mov    0xc(%ebx),%eax
     b9e:	c6 00 00             	movb   $0x0,(%eax)
}
     ba1:	83 c4 14             	add    $0x14,%esp
    break;
     ba4:	89 d8                	mov    %ebx,%eax
}
     ba6:	5b                   	pop    %ebx
     ba7:	5d                   	pop    %ebp
     ba8:	c3                   	ret    
     ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
     bb0:	31 c0                	xor    %eax,%eax
     bb2:	eb 84                	jmp    b38 <nulterminate+0x38>
     bb4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bbf:	90                   	nop

00000bc0 <parsecmd>:
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	56                   	push   %esi
     bc4:	53                   	push   %ebx
     bc5:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     bc8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     bcb:	89 1c 24             	mov    %ebx,(%esp)
     bce:	e8 ed 00 00 00       	call   cc0 <strlen>
     bd3:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     bd5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     bd9:	8d 45 08             	lea    0x8(%ebp),%eax
     bdc:	89 04 24             	mov    %eax,(%esp)
     bdf:	e8 9c fd ff ff       	call   980 <parseline>
  peek(&s, es, "");
     be4:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cmd = parseline(&s, es);
     be8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     bea:	b8 b1 13 00 00       	mov    $0x13b1,%eax
     bef:	89 44 24 08          	mov    %eax,0x8(%esp)
     bf3:	8d 45 08             	lea    0x8(%ebp),%eax
     bf6:	89 04 24             	mov    %eax,(%esp)
     bf9:	e8 82 fa ff ff       	call   680 <peek>
  if(s != es){
     bfe:	8b 45 08             	mov    0x8(%ebp),%eax
     c01:	39 d8                	cmp    %ebx,%eax
     c03:	75 11                	jne    c16 <parsecmd+0x56>
  nulterminate(cmd);
     c05:	89 34 24             	mov    %esi,(%esp)
     c08:	e8 f3 fe ff ff       	call   b00 <nulterminate>
}
     c0d:	83 c4 10             	add    $0x10,%esp
     c10:	89 f0                	mov    %esi,%eax
     c12:	5b                   	pop    %ebx
     c13:	5e                   	pop    %esi
     c14:	5d                   	pop    %ebp
     c15:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     c16:	89 44 24 08          	mov    %eax,0x8(%esp)
     c1a:	c7 44 24 04 2a 14 00 	movl   $0x142a,0x4(%esp)
     c21:	00 
     c22:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     c29:	e8 02 04 00 00       	call   1030 <printf>
    panic("syntax");
     c2e:	c7 04 24 ee 13 00 00 	movl   $0x13ee,(%esp)
     c35:	e8 36 f5 ff ff       	call   170 <panic>
     c3a:	66 90                	xchg   %ax,%ax
     c3c:	66 90                	xchg   %ax,%ax
     c3e:	66 90                	xchg   %ax,%ax

00000c40 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     c40:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c41:	31 c0                	xor    %eax,%eax
{
     c43:	89 e5                	mov    %esp,%ebp
     c45:	53                   	push   %ebx
     c46:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c49:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     c50:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     c54:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     c57:	40                   	inc    %eax
     c58:	84 d2                	test   %dl,%dl
     c5a:	75 f4                	jne    c50 <strcpy+0x10>
    ;
  return os;
}
     c5c:	5b                   	pop    %ebx
     c5d:	89 c8                	mov    %ecx,%eax
     c5f:	5d                   	pop    %ebp
     c60:	c3                   	ret    
     c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c6f:	90                   	nop

00000c70 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	53                   	push   %ebx
     c74:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c77:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
     c7a:	0f b6 03             	movzbl (%ebx),%eax
     c7d:	0f b6 0a             	movzbl (%edx),%ecx
     c80:	84 c0                	test   %al,%al
     c82:	75 19                	jne    c9d <strcmp+0x2d>
     c84:	eb 2a                	jmp    cb0 <strcmp+0x40>
     c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c8d:	8d 76 00             	lea    0x0(%esi),%esi
     c90:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    p++, q++;
     c94:	43                   	inc    %ebx
     c95:	42                   	inc    %edx
  while(*p && *p == *q)
     c96:	0f b6 0a             	movzbl (%edx),%ecx
     c99:	84 c0                	test   %al,%al
     c9b:	74 13                	je     cb0 <strcmp+0x40>
     c9d:	38 c8                	cmp    %cl,%al
     c9f:	74 ef                	je     c90 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
}
     ca1:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
     ca2:	29 c8                	sub    %ecx,%eax
}
     ca4:	5d                   	pop    %ebp
     ca5:	c3                   	ret    
     ca6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cad:	8d 76 00             	lea    0x0(%esi),%esi
     cb0:	5b                   	pop    %ebx
     cb1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     cb3:	29 c8                	sub    %ecx,%eax
}
     cb5:	5d                   	pop    %ebp
     cb6:	c3                   	ret    
     cb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cbe:	66 90                	xchg   %ax,%ax

00000cc0 <strlen>:

uint
strlen(const char *s)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     cc6:	80 3a 00             	cmpb   $0x0,(%edx)
     cc9:	74 15                	je     ce0 <strlen+0x20>
     ccb:	31 c0                	xor    %eax,%eax
     ccd:	8d 76 00             	lea    0x0(%esi),%esi
     cd0:	40                   	inc    %eax
     cd1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     cd5:	89 c1                	mov    %eax,%ecx
     cd7:	75 f7                	jne    cd0 <strlen+0x10>
    ;
  return n;
}
     cd9:	5d                   	pop    %ebp
     cda:	89 c8                	mov    %ecx,%eax
     cdc:	c3                   	ret    
     cdd:	8d 76 00             	lea    0x0(%esi),%esi
     ce0:	5d                   	pop    %ebp
  for(n = 0; s[n]; n++)
     ce1:	31 c9                	xor    %ecx,%ecx
}
     ce3:	89 c8                	mov    %ecx,%eax
     ce5:	c3                   	ret    
     ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ced:	8d 76 00             	lea    0x0(%esi),%esi

00000cf0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	8b 55 08             	mov    0x8(%ebp),%edx
     cf6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     cf7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     cfa:	8b 45 0c             	mov    0xc(%ebp),%eax
     cfd:	89 d7                	mov    %edx,%edi
     cff:	fc                   	cld    
     d00:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     d02:	5f                   	pop    %edi
     d03:	89 d0                	mov    %edx,%eax
     d05:	5d                   	pop    %ebp
     d06:	c3                   	ret    
     d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d0e:	66 90                	xchg   %ax,%ax

00000d10 <strchr>:

char*
strchr(const char *s, char c)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	8b 45 08             	mov    0x8(%ebp),%eax
     d16:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d1a:	0f b6 10             	movzbl (%eax),%edx
     d1d:	84 d2                	test   %dl,%dl
     d1f:	75 18                	jne    d39 <strchr+0x29>
     d21:	eb 1d                	jmp    d40 <strchr+0x30>
     d23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d30:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     d34:	40                   	inc    %eax
     d35:	84 d2                	test   %dl,%dl
     d37:	74 07                	je     d40 <strchr+0x30>
    if(*s == c)
     d39:	38 d1                	cmp    %dl,%cl
     d3b:	75 f3                	jne    d30 <strchr+0x20>
      return (char*)s;
  return 0;
}
     d3d:	5d                   	pop    %ebp
     d3e:	c3                   	ret    
     d3f:	90                   	nop
     d40:	5d                   	pop    %ebp
  return 0;
     d41:	31 c0                	xor    %eax,%eax
}
     d43:	c3                   	ret    
     d44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d4f:	90                   	nop

00000d50 <gets>:

char*
gets(char *buf, int max)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
     d55:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d56:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
     d58:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     d5b:	83 ec 3c             	sub    $0x3c,%esp
     d5e:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i=0; i+1 < max; ){
     d61:	eb 3a                	jmp    d9d <gets+0x4d>
     d63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     d70:	89 7c 24 04          	mov    %edi,0x4(%esp)
     d74:	ba 01 00 00 00       	mov    $0x1,%edx
     d79:	89 54 24 08          	mov    %edx,0x8(%esp)
     d7d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d84:	e8 32 01 00 00       	call   ebb <read>
    if(cc < 1)
     d89:	85 c0                	test   %eax,%eax
     d8b:	7e 19                	jle    da6 <gets+0x56>
      break;
    buf[i++] = c;
     d8d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     d91:	46                   	inc    %esi
     d92:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n' || c == '\r')
     d95:	3c 0a                	cmp    $0xa,%al
     d97:	74 27                	je     dc0 <gets+0x70>
     d99:	3c 0d                	cmp    $0xd,%al
     d9b:	74 23                	je     dc0 <gets+0x70>
  for(i=0; i+1 < max; ){
     d9d:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     da0:	43                   	inc    %ebx
     da1:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     da4:	7c ca                	jl     d70 <gets+0x20>
      break;
  }
  buf[i] = '\0';
     da6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     da9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
}
     dac:	8b 45 08             	mov    0x8(%ebp),%eax
     daf:	83 c4 3c             	add    $0x3c,%esp
     db2:	5b                   	pop    %ebx
     db3:	5e                   	pop    %esi
     db4:	5f                   	pop    %edi
     db5:	5d                   	pop    %ebp
     db6:	c3                   	ret    
     db7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dbe:	66 90                	xchg   %ax,%ax
     dc0:	8b 45 08             	mov    0x8(%ebp),%eax
     dc3:	01 c3                	add    %eax,%ebx
     dc5:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     dc8:	eb dc                	jmp    da6 <gets+0x56>
     dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000dd0 <stat>:

int
stat(const char *n, struct stat *st)
{
     dd0:	55                   	push   %ebp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dd1:	31 c0                	xor    %eax,%eax
{
     dd3:	89 e5                	mov    %esp,%ebp
     dd5:	83 ec 18             	sub    $0x18,%esp
  fd = open(n, O_RDONLY);
     dd8:	89 44 24 04          	mov    %eax,0x4(%esp)
     ddc:	8b 45 08             	mov    0x8(%ebp),%eax
{
     ddf:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     de2:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
     de5:	89 04 24             	mov    %eax,(%esp)
     de8:	e8 f6 00 00 00       	call   ee3 <open>
  if(fd < 0)
     ded:	85 c0                	test   %eax,%eax
     def:	78 2f                	js     e20 <stat+0x50>
     df1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     df3:	8b 45 0c             	mov    0xc(%ebp),%eax
     df6:	89 1c 24             	mov    %ebx,(%esp)
     df9:	89 44 24 04          	mov    %eax,0x4(%esp)
     dfd:	e8 f9 00 00 00       	call   efb <fstat>
  close(fd);
     e02:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     e05:	89 c6                	mov    %eax,%esi
  close(fd);
     e07:	e8 bf 00 00 00       	call   ecb <close>
  return r;
}
     e0c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     e0f:	89 f0                	mov    %esi,%eax
     e11:	8b 75 fc             	mov    -0x4(%ebp),%esi
     e14:	89 ec                	mov    %ebp,%esp
     e16:	5d                   	pop    %ebp
     e17:	c3                   	ret    
     e18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e1f:	90                   	nop
    return -1;
     e20:	be ff ff ff ff       	mov    $0xffffffff,%esi
     e25:	eb e5                	jmp    e0c <stat+0x3c>
     e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e2e:	66 90                	xchg   %ax,%ax

00000e30 <atoi>:

int
atoi(const char *s)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	53                   	push   %ebx
     e34:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e37:	0f be 02             	movsbl (%edx),%eax
     e3a:	88 c1                	mov    %al,%cl
     e3c:	80 e9 30             	sub    $0x30,%cl
     e3f:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     e42:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     e47:	77 1c                	ja     e65 <atoi+0x35>
     e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     e50:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     e53:	42                   	inc    %edx
     e54:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     e58:	0f be 02             	movsbl (%edx),%eax
     e5b:	88 c3                	mov    %al,%bl
     e5d:	80 eb 30             	sub    $0x30,%bl
     e60:	80 fb 09             	cmp    $0x9,%bl
     e63:	76 eb                	jbe    e50 <atoi+0x20>
  return n;
}
     e65:	5b                   	pop    %ebx
     e66:	89 c8                	mov    %ecx,%eax
     e68:	5d                   	pop    %ebp
     e69:	c3                   	ret    
     e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e70 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
     e74:	8b 45 10             	mov    0x10(%ebp),%eax
     e77:	56                   	push   %esi
     e78:	8b 55 08             	mov    0x8(%ebp),%edx
     e7b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e7e:	85 c0                	test   %eax,%eax
     e80:	7e 13                	jle    e95 <memmove+0x25>
     e82:	01 d0                	add    %edx,%eax
  dst = vdst;
     e84:	89 d7                	mov    %edx,%edi
     e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e8d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     e90:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     e91:	39 f8                	cmp    %edi,%eax
     e93:	75 fb                	jne    e90 <memmove+0x20>
  return vdst;
}
     e95:	5e                   	pop    %esi
     e96:	89 d0                	mov    %edx,%eax
     e98:	5f                   	pop    %edi
     e99:	5d                   	pop    %ebp
     e9a:	c3                   	ret    

00000e9b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e9b:	b8 01 00 00 00       	mov    $0x1,%eax
     ea0:	cd 40                	int    $0x40
     ea2:	c3                   	ret    

00000ea3 <exit>:
SYSCALL(exit)
     ea3:	b8 02 00 00 00       	mov    $0x2,%eax
     ea8:	cd 40                	int    $0x40
     eaa:	c3                   	ret    

00000eab <wait>:
SYSCALL(wait)
     eab:	b8 03 00 00 00       	mov    $0x3,%eax
     eb0:	cd 40                	int    $0x40
     eb2:	c3                   	ret    

00000eb3 <pipe>:
SYSCALL(pipe)
     eb3:	b8 04 00 00 00       	mov    $0x4,%eax
     eb8:	cd 40                	int    $0x40
     eba:	c3                   	ret    

00000ebb <read>:
SYSCALL(read)
     ebb:	b8 05 00 00 00       	mov    $0x5,%eax
     ec0:	cd 40                	int    $0x40
     ec2:	c3                   	ret    

00000ec3 <write>:
SYSCALL(write)
     ec3:	b8 10 00 00 00       	mov    $0x10,%eax
     ec8:	cd 40                	int    $0x40
     eca:	c3                   	ret    

00000ecb <close>:
SYSCALL(close)
     ecb:	b8 15 00 00 00       	mov    $0x15,%eax
     ed0:	cd 40                	int    $0x40
     ed2:	c3                   	ret    

00000ed3 <kill>:
SYSCALL(kill)
     ed3:	b8 06 00 00 00       	mov    $0x6,%eax
     ed8:	cd 40                	int    $0x40
     eda:	c3                   	ret    

00000edb <exec>:
SYSCALL(exec)
     edb:	b8 07 00 00 00       	mov    $0x7,%eax
     ee0:	cd 40                	int    $0x40
     ee2:	c3                   	ret    

00000ee3 <open>:
SYSCALL(open)
     ee3:	b8 0f 00 00 00       	mov    $0xf,%eax
     ee8:	cd 40                	int    $0x40
     eea:	c3                   	ret    

00000eeb <mknod>:
SYSCALL(mknod)
     eeb:	b8 11 00 00 00       	mov    $0x11,%eax
     ef0:	cd 40                	int    $0x40
     ef2:	c3                   	ret    

00000ef3 <unlink>:
SYSCALL(unlink)
     ef3:	b8 12 00 00 00       	mov    $0x12,%eax
     ef8:	cd 40                	int    $0x40
     efa:	c3                   	ret    

00000efb <fstat>:
SYSCALL(fstat)
     efb:	b8 08 00 00 00       	mov    $0x8,%eax
     f00:	cd 40                	int    $0x40
     f02:	c3                   	ret    

00000f03 <link>:
SYSCALL(link)
     f03:	b8 13 00 00 00       	mov    $0x13,%eax
     f08:	cd 40                	int    $0x40
     f0a:	c3                   	ret    

00000f0b <mkdir>:
SYSCALL(mkdir)
     f0b:	b8 14 00 00 00       	mov    $0x14,%eax
     f10:	cd 40                	int    $0x40
     f12:	c3                   	ret    

00000f13 <chdir>:
SYSCALL(chdir)
     f13:	b8 09 00 00 00       	mov    $0x9,%eax
     f18:	cd 40                	int    $0x40
     f1a:	c3                   	ret    

00000f1b <dup>:
SYSCALL(dup)
     f1b:	b8 0a 00 00 00       	mov    $0xa,%eax
     f20:	cd 40                	int    $0x40
     f22:	c3                   	ret    

00000f23 <getpid>:
SYSCALL(getpid)
     f23:	b8 0b 00 00 00       	mov    $0xb,%eax
     f28:	cd 40                	int    $0x40
     f2a:	c3                   	ret    

00000f2b <sbrk>:
SYSCALL(sbrk)
     f2b:	b8 0c 00 00 00       	mov    $0xc,%eax
     f30:	cd 40                	int    $0x40
     f32:	c3                   	ret    

00000f33 <sleep>:
SYSCALL(sleep)
     f33:	b8 0d 00 00 00       	mov    $0xd,%eax
     f38:	cd 40                	int    $0x40
     f3a:	c3                   	ret    

00000f3b <uptime>:
SYSCALL(uptime)
     f3b:	b8 0e 00 00 00       	mov    $0xe,%eax
     f40:	cd 40                	int    $0x40
     f42:	c3                   	ret    

00000f43 <waitx>:
SYSCALL(waitx)
     f43:	b8 16 00 00 00       	mov    $0x16,%eax
     f48:	cd 40                	int    $0x40
     f4a:	c3                   	ret    

00000f4b <set_priority>:
SYSCALL(set_priority)
     f4b:	b8 17 00 00 00       	mov    $0x17,%eax
     f50:	cd 40                	int    $0x40
     f52:	c3                   	ret    

00000f53 <pls>:
SYSCALL(pls)
     f53:	b8 18 00 00 00       	mov    $0x18,%eax
     f58:	cd 40                	int    $0x40
     f5a:	c3                   	ret    
     f5b:	66 90                	xchg   %ax,%ax
     f5d:	66 90                	xchg   %ax,%ax
     f5f:	90                   	nop

00000f60 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	57                   	push   %edi
     f64:	89 cf                	mov    %ecx,%edi
     f66:	56                   	push   %esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     f67:	89 d1                	mov    %edx,%ecx
{
     f69:	53                   	push   %ebx
     f6a:	83 ec 4c             	sub    $0x4c,%esp
     f6d:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
     f70:	89 d0                	mov    %edx,%eax
     f72:	c1 e8 1f             	shr    $0x1f,%eax
     f75:	84 c0                	test   %al,%al
     f77:	0f 84 a3 00 00 00    	je     1020 <printint+0xc0>
     f7d:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     f81:	0f 84 99 00 00 00    	je     1020 <printint+0xc0>
    neg = 1;
     f87:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
     f8e:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
     f90:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
     f97:	8d 75 d7             	lea    -0x29(%ebp),%esi
     f9a:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
     f9d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     fa0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     fa3:	31 d2                	xor    %edx,%edx
     fa5:	8b 5d c0             	mov    -0x40(%ebp),%ebx
     fa8:	f7 f7                	div    %edi
     faa:	8d 4b 01             	lea    0x1(%ebx),%ecx
     fad:	89 4d c0             	mov    %ecx,-0x40(%ebp)
     fb0:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  }while((x /= base) != 0);
     fb3:	39 cf                	cmp    %ecx,%edi
     fb5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    buf[i++] = digits[x % base];
     fb8:	0f b6 92 88 14 00 00 	movzbl 0x1488(%edx),%edx
     fbf:	88 54 1e 01          	mov    %dl,0x1(%esi,%ebx,1)
  }while((x /= base) != 0);
     fc3:	76 db                	jbe    fa0 <printint+0x40>
  if(neg)
     fc5:	8b 4d bc             	mov    -0x44(%ebp),%ecx
     fc8:	85 c9                	test   %ecx,%ecx
     fca:	74 0c                	je     fd8 <printint+0x78>
    buf[i++] = '-';
     fcc:	8b 45 c0             	mov    -0x40(%ebp),%eax
     fcf:	b2 2d                	mov    $0x2d,%dl
     fd1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
    buf[i++] = digits[x % base];
     fd6:	89 c3                	mov    %eax,%ebx

  while(--i >= 0)
     fd8:	8b 7d b8             	mov    -0x48(%ebp),%edi
     fdb:	8d 5c 1d d7          	lea    -0x29(%ebp,%ebx,1),%ebx
     fdf:	eb 13                	jmp    ff4 <printint+0x94>
     fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fef:	90                   	nop
     ff0:	0f b6 13             	movzbl (%ebx),%edx
     ff3:	4b                   	dec    %ebx
  write(fd, &c, 1);
     ff4:	89 74 24 04          	mov    %esi,0x4(%esp)
     ff8:	b8 01 00 00 00       	mov    $0x1,%eax
     ffd:	89 44 24 08          	mov    %eax,0x8(%esp)
    1001:	89 3c 24             	mov    %edi,(%esp)
    1004:	88 55 d7             	mov    %dl,-0x29(%ebp)
    1007:	e8 b7 fe ff ff       	call   ec3 <write>
  while(--i >= 0)
    100c:	39 de                	cmp    %ebx,%esi
    100e:	75 e0                	jne    ff0 <printint+0x90>
    putc(fd, buf[i]);
}
    1010:	83 c4 4c             	add    $0x4c,%esp
    1013:	5b                   	pop    %ebx
    1014:	5e                   	pop    %esi
    1015:	5f                   	pop    %edi
    1016:	5d                   	pop    %ebp
    1017:	c3                   	ret    
    1018:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    101f:	90                   	nop
  neg = 0;
    1020:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    1027:	e9 64 ff ff ff       	jmp    f90 <printint+0x30>
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001030 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	56                   	push   %esi
    1035:	53                   	push   %ebx
    1036:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1039:	8b 75 0c             	mov    0xc(%ebp),%esi
    103c:	0f b6 1e             	movzbl (%esi),%ebx
    103f:	84 db                	test   %bl,%bl
    1041:	0f 84 c8 00 00 00    	je     110f <printf+0xdf>
  ap = (uint*)(void*)&fmt + 1;
    1047:	8d 45 10             	lea    0x10(%ebp),%eax
    104a:	46                   	inc    %esi
    104b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  write(fd, &c, 1);
    104e:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    1051:	31 d2                	xor    %edx,%edx
    1053:	eb 3e                	jmp    1093 <printf+0x63>
    1055:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    105c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1060:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1063:	83 f8 25             	cmp    $0x25,%eax
        state = '%';
    1066:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    106b:	74 1e                	je     108b <printf+0x5b>
  write(fd, &c, 1);
    106d:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1071:	b8 01 00 00 00       	mov    $0x1,%eax
    1076:	89 44 24 08          	mov    %eax,0x8(%esp)
    107a:	8b 45 08             	mov    0x8(%ebp),%eax
    107d:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1080:	89 04 24             	mov    %eax,(%esp)
    1083:	e8 3b fe ff ff       	call   ec3 <write>
    1088:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  for(i = 0; fmt[i]; i++){
    108b:	0f b6 1e             	movzbl (%esi),%ebx
    108e:	46                   	inc    %esi
    108f:	84 db                	test   %bl,%bl
    1091:	74 7c                	je     110f <printf+0xdf>
    if(state == 0){
    1093:	85 d2                	test   %edx,%edx
    c = fmt[i] & 0xff;
    1095:	0f be cb             	movsbl %bl,%ecx
    1098:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    109b:	74 c3                	je     1060 <printf+0x30>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    109d:	83 fa 25             	cmp    $0x25,%edx
    10a0:	75 e9                	jne    108b <printf+0x5b>
      if(c == 'd'){
    10a2:	83 f8 64             	cmp    $0x64,%eax
    10a5:	0f 84 a5 00 00 00    	je     1150 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    10ab:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    10b1:	83 f9 70             	cmp    $0x70,%ecx
    10b4:	74 6a                	je     1120 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    10b6:	83 f8 73             	cmp    $0x73,%eax
    10b9:	0f 84 e1 00 00 00    	je     11a0 <printf+0x170>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    10bf:	83 f8 63             	cmp    $0x63,%eax
    10c2:	0f 84 98 00 00 00    	je     1160 <printf+0x130>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    10c8:	83 f8 25             	cmp    $0x25,%eax
    10cb:	74 1c                	je     10e9 <printf+0xb9>
  write(fd, &c, 1);
    10cd:	89 7c 24 04          	mov    %edi,0x4(%esp)
    10d1:	8b 45 08             	mov    0x8(%ebp),%eax
    10d4:	ba 01 00 00 00       	mov    $0x1,%edx
    10d9:	89 54 24 08          	mov    %edx,0x8(%esp)
    10dd:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    10e1:	89 04 24             	mov    %eax,(%esp)
    10e4:	e8 da fd ff ff       	call   ec3 <write>
    10e9:	89 7c 24 04          	mov    %edi,0x4(%esp)
    10ed:	b8 01 00 00 00       	mov    $0x1,%eax
    10f2:	46                   	inc    %esi
    10f3:	89 44 24 08          	mov    %eax,0x8(%esp)
    10f7:	8b 45 08             	mov    0x8(%ebp),%eax
    10fa:	88 5d e7             	mov    %bl,-0x19(%ebp)
    10fd:	89 04 24             	mov    %eax,(%esp)
    1100:	e8 be fd ff ff       	call   ec3 <write>
  for(i = 0; fmt[i]; i++){
    1105:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1109:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    110b:	84 db                	test   %bl,%bl
    110d:	75 84                	jne    1093 <printf+0x63>
    }
  }
}
    110f:	83 c4 3c             	add    $0x3c,%esp
    1112:	5b                   	pop    %ebx
    1113:	5e                   	pop    %esi
    1114:	5f                   	pop    %edi
    1115:	5d                   	pop    %ebp
    1116:	c3                   	ret    
    1117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    111e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    1120:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1127:	b9 10 00 00 00       	mov    $0x10,%ecx
    112c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    112f:	8b 45 08             	mov    0x8(%ebp),%eax
    1132:	8b 13                	mov    (%ebx),%edx
    1134:	e8 27 fe ff ff       	call   f60 <printint>
        ap++;
    1139:	89 d8                	mov    %ebx,%eax
      state = 0;
    113b:	31 d2                	xor    %edx,%edx
        ap++;
    113d:	83 c0 04             	add    $0x4,%eax
    1140:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1143:	e9 43 ff ff ff       	jmp    108b <printf+0x5b>
    1148:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    114f:	90                   	nop
        printint(fd, *ap, 10, 1);
    1150:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1157:	b9 0a 00 00 00       	mov    $0xa,%ecx
    115c:	eb ce                	jmp    112c <printf+0xfc>
    115e:	66 90                	xchg   %ax,%ax
        putc(fd, *ap);
    1160:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    1163:	b9 01 00 00 00       	mov    $0x1,%ecx
        putc(fd, *ap);
    1168:	8b 03                	mov    (%ebx),%eax
        ap++;
    116a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    116d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1171:	89 7c 24 04          	mov    %edi,0x4(%esp)
        putc(fd, *ap);
    1175:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1178:	0f b6 45 d4          	movzbl -0x2c(%ebp),%eax
    117c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    117f:	8b 45 08             	mov    0x8(%ebp),%eax
    1182:	89 04 24             	mov    %eax,(%esp)
    1185:	e8 39 fd ff ff       	call   ec3 <write>
      state = 0;
    118a:	31 d2                	xor    %edx,%edx
        ap++;
    118c:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    118f:	e9 f7 fe ff ff       	jmp    108b <printf+0x5b>
    1194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    119b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    119f:	90                   	nop
        s = (char*)*ap;
    11a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    11a3:	8b 18                	mov    (%eax),%ebx
        ap++;
    11a5:	83 c0 04             	add    $0x4,%eax
    11a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    11ab:	85 db                	test   %ebx,%ebx
    11ad:	74 11                	je     11c0 <printf+0x190>
        while(*s != 0){
    11af:	0f b6 03             	movzbl (%ebx),%eax
    11b2:	84 c0                	test   %al,%al
    11b4:	74 44                	je     11fa <printf+0x1ca>
    11b6:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    11b9:	89 de                	mov    %ebx,%esi
    11bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    11be:	eb 10                	jmp    11d0 <printf+0x1a0>
    11c0:	89 75 d4             	mov    %esi,-0x2c(%ebp)
          s = "(null)";
    11c3:	bb 80 14 00 00       	mov    $0x1480,%ebx
        while(*s != 0){
    11c8:	b0 28                	mov    $0x28,%al
    11ca:	89 de                	mov    %ebx,%esi
    11cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
    11cf:	90                   	nop
          putc(fd, *s);
    11d0:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    11d3:	b8 01 00 00 00       	mov    $0x1,%eax
          s++;
    11d8:	46                   	inc    %esi
  write(fd, &c, 1);
    11d9:	89 44 24 08          	mov    %eax,0x8(%esp)
    11dd:	89 7c 24 04          	mov    %edi,0x4(%esp)
    11e1:	89 1c 24             	mov    %ebx,(%esp)
    11e4:	e8 da fc ff ff       	call   ec3 <write>
        while(*s != 0){
    11e9:	0f b6 06             	movzbl (%esi),%eax
    11ec:	84 c0                	test   %al,%al
    11ee:	75 e0                	jne    11d0 <printf+0x1a0>
    11f0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
    11f3:	31 d2                	xor    %edx,%edx
    11f5:	e9 91 fe ff ff       	jmp    108b <printf+0x5b>
    11fa:	31 d2                	xor    %edx,%edx
    11fc:	e9 8a fe ff ff       	jmp    108b <printf+0x5b>
    1201:	66 90                	xchg   %ax,%ax
    1203:	66 90                	xchg   %ax,%ax
    1205:	66 90                	xchg   %ax,%ax
    1207:	66 90                	xchg   %ax,%ax
    1209:	66 90                	xchg   %ax,%ax
    120b:	66 90                	xchg   %ax,%ax
    120d:	66 90                	xchg   %ax,%ax
    120f:	90                   	nop

00001210 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1210:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1211:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
{
    1216:	89 e5                	mov    %esp,%ebp
    1218:	57                   	push   %edi
    1219:	56                   	push   %esi
    121a:	53                   	push   %ebx
    121b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    121e:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
    1220:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1223:	39 c8                	cmp    %ecx,%eax
    1225:	73 19                	jae    1240 <free+0x30>
    1227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    122e:	66 90                	xchg   %ax,%ax
    1230:	39 d1                	cmp    %edx,%ecx
    1232:	72 14                	jb     1248 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1234:	39 d0                	cmp    %edx,%eax
    1236:	73 10                	jae    1248 <free+0x38>
{
    1238:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    123a:	39 c8                	cmp    %ecx,%eax
    123c:	8b 10                	mov    (%eax),%edx
    123e:	72 f0                	jb     1230 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1240:	39 d0                	cmp    %edx,%eax
    1242:	72 f4                	jb     1238 <free+0x28>
    1244:	39 d1                	cmp    %edx,%ecx
    1246:	73 f0                	jae    1238 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1248:	8b 73 fc             	mov    -0x4(%ebx),%esi
    124b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    124e:	39 fa                	cmp    %edi,%edx
    1250:	74 1e                	je     1270 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1252:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1255:	8b 50 04             	mov    0x4(%eax),%edx
    1258:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    125b:	39 f1                	cmp    %esi,%ecx
    125d:	74 2a                	je     1289 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    125f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
    1261:	5b                   	pop    %ebx
  freep = p;
    1262:	a3 c4 1a 00 00       	mov    %eax,0x1ac4
}
    1267:	5e                   	pop    %esi
    1268:	5f                   	pop    %edi
    1269:	5d                   	pop    %ebp
    126a:	c3                   	ret    
    126b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    126f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
    1270:	8b 7a 04             	mov    0x4(%edx),%edi
    1273:	01 fe                	add    %edi,%esi
    1275:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1278:	8b 10                	mov    (%eax),%edx
    127a:	8b 12                	mov    (%edx),%edx
    127c:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    127f:	8b 50 04             	mov    0x4(%eax),%edx
    1282:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1285:	39 f1                	cmp    %esi,%ecx
    1287:	75 d6                	jne    125f <free+0x4f>
  freep = p;
    1289:	a3 c4 1a 00 00       	mov    %eax,0x1ac4
    p->s.size += bp->s.size;
    128e:	8b 4b fc             	mov    -0x4(%ebx),%ecx
    1291:	01 ca                	add    %ecx,%edx
    1293:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1296:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1299:	89 10                	mov    %edx,(%eax)
}
    129b:	5b                   	pop    %ebx
    129c:	5e                   	pop    %esi
    129d:	5f                   	pop    %edi
    129e:	5d                   	pop    %ebp
    129f:	c3                   	ret    

000012a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    12a0:	55                   	push   %ebp
    12a1:	89 e5                	mov    %esp,%ebp
    12a3:	57                   	push   %edi
    12a4:	56                   	push   %esi
    12a5:	53                   	push   %ebx
    12a6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    12ac:	8b 3d c4 1a 00 00    	mov    0x1ac4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12b2:	8d 70 07             	lea    0x7(%eax),%esi
    12b5:	c1 ee 03             	shr    $0x3,%esi
    12b8:	46                   	inc    %esi
  if((prevp = freep) == 0){
    12b9:	85 ff                	test   %edi,%edi
    12bb:	0f 84 9f 00 00 00    	je     1360 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12c1:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    12c3:	8b 48 04             	mov    0x4(%eax),%ecx
    12c6:	39 f1                	cmp    %esi,%ecx
    12c8:	73 6c                	jae    1336 <malloc+0x96>
    12ca:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    12d0:	bb 00 10 00 00       	mov    $0x1000,%ebx
    12d5:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    12d8:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    12df:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    12e2:	eb 1d                	jmp    1301 <malloc+0x61>
    12e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    12eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12ef:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12f0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    12f2:	8b 4a 04             	mov    0x4(%edx),%ecx
    12f5:	39 f1                	cmp    %esi,%ecx
    12f7:	73 47                	jae    1340 <malloc+0xa0>
    12f9:	8b 3d c4 1a 00 00    	mov    0x1ac4,%edi
    12ff:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1301:	39 c7                	cmp    %eax,%edi
    1303:	75 eb                	jne    12f0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    1305:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1308:	89 04 24             	mov    %eax,(%esp)
    130b:	e8 1b fc ff ff       	call   f2b <sbrk>
  if(p == (char*)-1)
    1310:	83 f8 ff             	cmp    $0xffffffff,%eax
    1313:	74 17                	je     132c <malloc+0x8c>
  hp->s.size = nu;
    1315:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1318:	83 c0 08             	add    $0x8,%eax
    131b:	89 04 24             	mov    %eax,(%esp)
    131e:	e8 ed fe ff ff       	call   1210 <free>
  return freep;
    1323:	a1 c4 1a 00 00       	mov    0x1ac4,%eax
      if((p = morecore(nunits)) == 0)
    1328:	85 c0                	test   %eax,%eax
    132a:	75 c4                	jne    12f0 <malloc+0x50>
        return 0;
  }
}
    132c:	83 c4 2c             	add    $0x2c,%esp
        return 0;
    132f:	31 c0                	xor    %eax,%eax
}
    1331:	5b                   	pop    %ebx
    1332:	5e                   	pop    %esi
    1333:	5f                   	pop    %edi
    1334:	5d                   	pop    %ebp
    1335:	c3                   	ret    
    if(p->s.size >= nunits){
    1336:	89 c2                	mov    %eax,%edx
    1338:	89 f8                	mov    %edi,%eax
    133a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1340:	39 ce                	cmp    %ecx,%esi
    1342:	74 4c                	je     1390 <malloc+0xf0>
        p->s.size -= nunits;
    1344:	29 f1                	sub    %esi,%ecx
    1346:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1349:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    134c:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    134f:	a3 c4 1a 00 00       	mov    %eax,0x1ac4
      return (void*)(p + 1);
    1354:	8d 42 08             	lea    0x8(%edx),%eax
}
    1357:	83 c4 2c             	add    $0x2c,%esp
    135a:	5b                   	pop    %ebx
    135b:	5e                   	pop    %esi
    135c:	5f                   	pop    %edi
    135d:	5d                   	pop    %ebp
    135e:	c3                   	ret    
    135f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    1360:	b8 c8 1a 00 00       	mov    $0x1ac8,%eax
    1365:	ba c8 1a 00 00       	mov    $0x1ac8,%edx
    136a:	a3 c4 1a 00 00       	mov    %eax,0x1ac4
    base.s.size = 0;
    136f:	31 c9                	xor    %ecx,%ecx
    1371:	bf c8 1a 00 00       	mov    $0x1ac8,%edi
    base.s.ptr = freep = prevp = &base;
    1376:	89 15 c8 1a 00 00    	mov    %edx,0x1ac8
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    137c:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    137e:	89 0d cc 1a 00 00    	mov    %ecx,0x1acc
    if(p->s.size >= nunits){
    1384:	e9 41 ff ff ff       	jmp    12ca <malloc+0x2a>
    1389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1390:	8b 0a                	mov    (%edx),%ecx
    1392:	89 08                	mov    %ecx,(%eax)
    1394:	eb b9                	jmp    134f <malloc+0xaf>
