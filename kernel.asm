
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 e0 30 10 80       	mov    $0x801030e0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100041:	ba 60 73 10 80       	mov    $0x80107360,%edx
{
80100046:	89 e5                	mov    %esp,%ebp
80100048:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100049:	bb bc fc 10 80       	mov    $0x8010fcbc,%ebx
{
8010004e:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
80100051:	89 54 24 04          	mov    %edx,0x4(%esp)
80100055:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010005c:	e8 6f 45 00 00       	call   801045d0 <initlock>
  bcache.head.prev = &bcache.head;
80100061:	b9 bc fc 10 80       	mov    $0x8010fcbc,%ecx
  bcache.head.next = &bcache.head;
80100066:	b8 bc fc 10 80       	mov    $0x8010fcbc,%eax
8010006b:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  bcache.head.prev = &bcache.head;
80100076:	89 0d 0c fd 10 80    	mov    %ecx,0x8010fd0c
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007c:	eb 04                	jmp    80100082 <binit+0x42>
8010007e:	66 90                	xchg   %ax,%ax
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	b8 67 73 10 80       	mov    $0x80107367,%eax
    b->prev = &bcache.head;
8010008a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 44 24 04          	mov    %eax,0x4(%esp)
80100095:	8d 43 0c             	lea    0xc(%ebx),%eax
80100098:	89 04 24             	mov    %eax,(%esp)
8010009b:	e8 f0 43 00 00       	call   80104490 <initsleeplock>
    bcache.head.next->prev = b;
801000a0:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a5:	81 fb 60 fa 10 80    	cmp    $0x8010fa60,%ebx
801000ab:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
    bcache.head.next->prev = b;
801000b1:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000b4:	89 d8                	mov    %ebx,%eax
801000b6:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	83 c4 14             	add    $0x14,%esp
801000c1:	5b                   	pop    %ebx
801000c2:	5d                   	pop    %ebp
801000c3:	c3                   	ret    
801000c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801000cf:	90                   	nop

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&bcache.lock);
801000d9:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
{
801000e0:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e3:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000e6:	e8 55 46 00 00       	call   80104740 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000f1:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801000ff:	90                   	nop
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	ff 43 4c             	incl   0x4c(%ebx)
      release(&bcache.lock);
80100118:	eb 40                	jmp    8010015a <bread+0x8a>
8010011a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100161:	e8 8a 46 00 00       	call   801047f0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 5f 43 00 00       	call   801044d0 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	74 0a                	je     80100180 <bread+0xb0>
    iderw(b);
  }
  return b;
}
80100176:	83 c4 1c             	add    $0x1c,%esp
80100179:	89 d8                	mov    %ebx,%eax
8010017b:	5b                   	pop    %ebx
8010017c:	5e                   	pop    %esi
8010017d:	5f                   	pop    %edi
8010017e:	5d                   	pop    %ebp
8010017f:	c3                   	ret    
    iderw(b);
80100180:	89 1c 24             	mov    %ebx,(%esp)
80100183:	e8 18 22 00 00       	call   801023a0 <iderw>
}
80100188:	83 c4 1c             	add    $0x1c,%esp
8010018b:	89 d8                	mov    %ebx,%eax
8010018d:	5b                   	pop    %ebx
8010018e:	5e                   	pop    %esi
8010018f:	5f                   	pop    %edi
80100190:	5d                   	pop    %ebp
80100191:	c3                   	ret    
80100192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  panic("bget: no buffers");
801001a0:	c7 04 24 6e 73 10 80 	movl   $0x8010736e,(%esp)
801001a7:	e8 b4 01 00 00       	call   80100360 <panic>
801001ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 14             	sub    $0x14,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	89 04 24             	mov    %eax,(%esp)
801001c0:	e8 ab 43 00 00       	call   80104570 <holdingsleep>
801001c5:	85 c0                	test   %eax,%eax
801001c7:	74 10                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001c9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001cf:	83 c4 14             	add    $0x14,%esp
801001d2:	5b                   	pop    %ebx
801001d3:	5d                   	pop    %ebp
  iderw(b);
801001d4:	e9 c7 21 00 00       	jmp    801023a0 <iderw>
    panic("bwrite");
801001d9:	c7 04 24 7f 73 10 80 	movl   $0x8010737f,(%esp)
801001e0:	e8 7b 01 00 00       	call   80100360 <panic>
801001e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	83 ec 10             	sub    $0x10,%esp
801001f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fe:	89 34 24             	mov    %esi,(%esp)
80100201:	e8 6a 43 00 00       	call   80104570 <holdingsleep>
80100206:	85 c0                	test   %eax,%eax
80100208:	74 5a                	je     80100264 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
8010020a:	89 34 24             	mov    %esi,(%esp)
8010020d:	e8 1e 43 00 00       	call   80104530 <releasesleep>

  acquire(&bcache.lock);
80100212:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100219:	e8 22 45 00 00       	call   80104740 <acquire>
  b->refcnt--;
8010021e:	ff 4b 4c             	decl   0x4c(%ebx)
  if (b->refcnt == 0) {
80100221:	75 2f                	jne    80100252 <brelse+0x62>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100223:	8b 43 54             	mov    0x54(%ebx),%eax
80100226:	8b 53 50             	mov    0x50(%ebx),%edx
80100229:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010022c:	8b 43 50             	mov    0x50(%ebx),%eax
8010022f:	8b 53 54             	mov    0x54(%ebx),%edx
80100232:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100235:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
8010023a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
80100241:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100244:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100249:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010024c:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
80100252:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100259:	83 c4 10             	add    $0x10,%esp
8010025c:	5b                   	pop    %ebx
8010025d:	5e                   	pop    %esi
8010025e:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025f:	e9 8c 45 00 00       	jmp    801047f0 <release>
    panic("brelse");
80100264:	c7 04 24 86 73 10 80 	movl   $0x80107386,(%esp)
8010026b:	e8 f0 00 00 00       	call   80100360 <panic>

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 2c             	sub    $0x2c,%esp
80100279:	8b 75 08             	mov    0x8(%ebp),%esi
8010027c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
8010027f:	89 34 24             	mov    %esi,(%esp)
80100282:	e8 59 16 00 00       	call   801018e0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
  target = n;
8010028e:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
80100291:	e8 aa 44 00 00       	call   80104740 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100296:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100299:	01 df                	add    %ebx,%edi
  while(n > 0){
8010029b:	85 db                	test   %ebx,%ebx
8010029d:	7f 32                	jg     801002d1 <consoleread+0x61>
8010029f:	eb 64                	jmp    80100305 <consoleread+0x95>
801002a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801002a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801002af:	90                   	nop
      if(myproc()->killed){
801002b0:	e8 6b 37 00 00       	call   80103a20 <myproc>
801002b5:	8b 50 24             	mov    0x24(%eax),%edx
801002b8:	85 d2                	test   %edx,%edx
801002ba:	75 74                	jne    80100330 <consoleread+0xc0>
      sleep(&input.r, &cons.lock);
801002bc:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801002c3:	b8 20 a5 10 80       	mov    $0x8010a520,%eax
801002c8:	89 44 24 04          	mov    %eax,0x4(%esp)
801002cc:	e8 ff 3c 00 00       	call   80103fd0 <sleep>
    while(input.r == input.w){
801002d1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002d6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
    c = input.buf[input.r++ % INPUT_BUF];
801002de:	8d 50 01             	lea    0x1(%eax),%edx
801002e1:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
801002e7:	89 c2                	mov    %eax,%edx
801002e9:	83 e2 7f             	and    $0x7f,%edx
801002ec:	0f be 8a 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%ecx
    if(c == C('D')){  // EOF
801002f3:	80 f9 04             	cmp    $0x4,%cl
801002f6:	74 59                	je     80100351 <consoleread+0xe1>
    *dst++ = c;
801002f8:	89 d8                	mov    %ebx,%eax
    --n;
801002fa:	4b                   	dec    %ebx
    *dst++ = c;
801002fb:	f7 d8                	neg    %eax
    if(c == '\n')
801002fd:	83 f9 0a             	cmp    $0xa,%ecx
    *dst++ = c;
80100300:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100303:	75 96                	jne    8010029b <consoleread+0x2b>
      break;
  }
  release(&cons.lock);
80100305:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010030c:	e8 df 44 00 00       	call   801047f0 <release>
  ilock(ip);
80100311:	89 34 24             	mov    %esi,(%esp)
80100314:	e8 e7 14 00 00       	call   80101800 <ilock>

  return target - n;
80100319:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010031c:	83 c4 2c             	add    $0x2c,%esp
  return target - n;
8010031f:	29 d8                	sub    %ebx,%eax
}
80100321:	5b                   	pop    %ebx
80100322:	5e                   	pop    %esi
80100323:	5f                   	pop    %edi
80100324:	5d                   	pop    %ebp
80100325:	c3                   	ret    
80100326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010032d:	8d 76 00             	lea    0x0(%esi),%esi
        release(&cons.lock);
80100330:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100337:	e8 b4 44 00 00       	call   801047f0 <release>
        ilock(ip);
8010033c:	89 34 24             	mov    %esi,(%esp)
8010033f:	e8 bc 14 00 00       	call   80101800 <ilock>
}
80100344:	83 c4 2c             	add    $0x2c,%esp
        return -1;
80100347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010034c:	5b                   	pop    %ebx
8010034d:	5e                   	pop    %esi
8010034e:	5f                   	pop    %edi
8010034f:	5d                   	pop    %ebp
80100350:	c3                   	ret    
      if(n < target){
80100351:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80100354:	73 af                	jae    80100305 <consoleread+0x95>
        input.r--;
80100356:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
8010035b:	eb a8                	jmp    80100305 <consoleread+0x95>
8010035d:	8d 76 00             	lea    0x0(%esi),%esi

80100360 <panic>:
{
80100360:	55                   	push   %ebp
80100361:	89 e5                	mov    %esp,%ebp
80100363:	56                   	push   %esi
80100364:	53                   	push   %ebx
80100365:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100368:	fa                   	cli    
  getcallerpcs(&s, pcs);
80100369:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cons.locking = 0;
8010036c:	31 d2                	xor    %edx,%edx
8010036e:	89 15 54 a5 10 80    	mov    %edx,0x8010a554
  cprintf("lapicid %d: panic: ", lapicid());
80100374:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100377:	e8 44 26 00 00       	call   801029c0 <lapicid>
8010037c:	c7 04 24 8d 73 10 80 	movl   $0x8010738d,(%esp)
80100383:	89 44 24 04          	mov    %eax,0x4(%esp)
80100387:	e8 f4 02 00 00       	call   80100680 <cprintf>
  cprintf(s);
8010038c:	8b 45 08             	mov    0x8(%ebp),%eax
8010038f:	89 04 24             	mov    %eax,(%esp)
80100392:	e8 e9 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
80100397:	c7 04 24 bb 7c 10 80 	movl   $0x80107cbb,(%esp)
8010039e:	e8 dd 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
801003a3:	8d 45 08             	lea    0x8(%ebp),%eax
801003a6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003aa:	89 04 24             	mov    %eax,(%esp)
801003ad:	e8 3e 42 00 00       	call   801045f0 <getcallerpcs>
    cprintf(" %p", pcs[i]);
801003b2:	8b 03                	mov    (%ebx),%eax
801003b4:	83 c3 04             	add    $0x4,%ebx
801003b7:	c7 04 24 a1 73 10 80 	movl   $0x801073a1,(%esp)
801003be:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c2:	e8 b9 02 00 00       	call   80100680 <cprintf>
  for(i=0; i<10; i++)
801003c7:	39 f3                	cmp    %esi,%ebx
801003c9:	75 e7                	jne    801003b2 <panic+0x52>
  panicked = 1; // freeze other CPU
801003cb:	b8 01 00 00 00       	mov    $0x1,%eax
801003d0:	a3 58 a5 10 80       	mov    %eax,0x8010a558
  for(;;)
801003d5:	eb fe                	jmp    801003d5 <panic+0x75>
801003d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003de:	66 90                	xchg   %ax,%ax

801003e0 <consputc.part.0>:
consputc(int c)
801003e0:	55                   	push   %ebp
801003e1:	89 e5                	mov    %esp,%ebp
801003e3:	57                   	push   %edi
801003e4:	56                   	push   %esi
801003e5:	53                   	push   %ebx
801003e6:	89 c3                	mov    %eax,%ebx
801003e8:	83 ec 2c             	sub    $0x2c,%esp
  if(c == BACKSPACE){
801003eb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003f0:	0f 84 ea 00 00 00    	je     801004e0 <consputc.part.0+0x100>
    uartputc(c);
801003f6:	89 04 24             	mov    %eax,(%esp)
801003f9:	e8 12 5b 00 00       	call   80105f10 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003fe:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100403:	b0 0e                	mov    $0xe,%al
80100405:	89 fa                	mov    %edi,%edx
80100407:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100408:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010040d:	89 ca                	mov    %ecx,%edx
8010040f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100410:	0f b6 f0             	movzbl %al,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100413:	89 fa                	mov    %edi,%edx
80100415:	c1 e6 08             	shl    $0x8,%esi
80100418:	b0 0f                	mov    $0xf,%al
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	89 ca                	mov    %ecx,%edx
8010041d:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010041e:	0f b6 c8             	movzbl %al,%ecx
80100421:	09 f1                	or     %esi,%ecx
  if(c == '\n')
80100423:	83 fb 0a             	cmp    $0xa,%ebx
80100426:	0f 84 94 00 00 00    	je     801004c0 <consputc.part.0+0xe0>
  else if(c == BACKSPACE){
8010042c:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100432:	74 6c                	je     801004a0 <consputc.part.0+0xc0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100434:	8d 51 01             	lea    0x1(%ecx),%edx
80100437:	0f b6 db             	movzbl %bl,%ebx
8010043a:	81 cb 00 07 00 00    	or     $0x700,%ebx
80100440:	66 89 9c 09 00 80 0b 	mov    %bx,-0x7ff48000(%ecx,%ecx,1)
80100447:	80 
  if(pos < 0 || pos > 25*80)
80100448:	81 fa d0 07 00 00    	cmp    $0x7d0,%edx
8010044e:	0f 8f 0f 01 00 00    	jg     80100563 <consputc.part.0+0x183>
  if((pos/80) >= 24){  // Scroll up.
80100454:	81 fa 7f 07 00 00    	cmp    $0x77f,%edx
8010045a:	0f 8f b0 00 00 00    	jg     80100510 <consputc.part.0+0x130>
80100460:	88 55 e4             	mov    %dl,-0x1c(%ebp)
80100463:	8d bc 12 00 80 0b 80 	lea    -0x7ff48000(%edx,%edx,1),%edi
8010046a:	0f b6 ce             	movzbl %dh,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010046d:	be d4 03 00 00       	mov    $0x3d4,%esi
80100472:	b0 0e                	mov    $0xe,%al
80100474:	89 f2                	mov    %esi,%edx
80100476:	ee                   	out    %al,(%dx)
80100477:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010047c:	88 c8                	mov    %cl,%al
8010047e:	89 da                	mov    %ebx,%edx
80100480:	ee                   	out    %al,(%dx)
80100481:	b0 0f                	mov    $0xf,%al
80100483:	89 f2                	mov    %esi,%edx
80100485:	ee                   	out    %al,(%dx)
80100486:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
8010048a:	89 da                	mov    %ebx,%edx
8010048c:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
8010048d:	66 c7 07 20 07       	movw   $0x720,(%edi)
}
80100492:	83 c4 2c             	add    $0x2c,%esp
80100495:	5b                   	pop    %ebx
80100496:	5e                   	pop    %esi
80100497:	5f                   	pop    %edi
80100498:	5d                   	pop    %ebp
80100499:	c3                   	ret    
8010049a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pos > 0) --pos;
801004a0:	8d 51 ff             	lea    -0x1(%ecx),%edx
801004a3:	85 c9                	test   %ecx,%ecx
801004a5:	75 a1                	jne    80100448 <consputc.part.0+0x68>
801004a7:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004ab:	bf 00 80 0b 80       	mov    $0x800b8000,%edi
801004b0:	31 c9                	xor    %ecx,%ecx
801004b2:	eb b9                	jmp    8010046d <consputc.part.0+0x8d>
801004b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801004bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004bf:	90                   	nop
    pos += 80 - pos%80;
801004c0:	89 c8                	mov    %ecx,%eax
801004c2:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004c7:	f7 e2                	mul    %edx
801004c9:	c1 ea 06             	shr    $0x6,%edx
801004cc:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004cf:	c1 e0 04             	shl    $0x4,%eax
801004d2:	8d 50 50             	lea    0x50(%eax),%edx
801004d5:	e9 6e ff ff ff       	jmp    80100448 <consputc.part.0+0x68>
801004da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e7:	e8 24 5a 00 00       	call   80105f10 <uartputc>
801004ec:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f3:	e8 18 5a 00 00       	call   80105f10 <uartputc>
801004f8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004ff:	e8 0c 5a 00 00       	call   80105f10 <uartputc>
80100504:	e9 f5 fe ff ff       	jmp    801003fe <consputc.part.0+0x1e>
80100509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100510:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100513:	b8 60 0e 00 00       	mov    $0xe60,%eax
80100518:	ba a0 80 0b 80       	mov    $0x800b80a0,%edx
8010051d:	89 54 24 04          	mov    %edx,0x4(%esp)
80100521:	89 44 24 08          	mov    %eax,0x8(%esp)
80100525:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
8010052c:	e8 cf 43 00 00       	call   80104900 <memmove>
    pos -= 80;
80100531:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100534:	b8 80 07 00 00       	mov    $0x780,%eax
80100539:	31 c9                	xor    %ecx,%ecx
8010053b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    pos -= 80;
8010053f:	8d 5a b0             	lea    -0x50(%edx),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100542:	8d bc 12 60 7f 0b 80 	lea    -0x7ff480a0(%edx,%edx,1),%edi
80100549:	29 d8                	sub    %ebx,%eax
8010054b:	89 3c 24             	mov    %edi,(%esp)
8010054e:	01 c0                	add    %eax,%eax
80100550:	89 44 24 08          	mov    %eax,0x8(%esp)
80100554:	e8 e7 42 00 00       	call   80104840 <memset>
80100559:	b1 07                	mov    $0x7,%cl
8010055b:	88 5d e4             	mov    %bl,-0x1c(%ebp)
8010055e:	e9 0a ff ff ff       	jmp    8010046d <consputc.part.0+0x8d>
    panic("pos under/overflow");
80100563:	c7 04 24 a5 73 10 80 	movl   $0x801073a5,(%esp)
8010056a:	e8 f1 fd ff ff       	call   80100360 <panic>
8010056f:	90                   	nop

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	53                   	push   %ebx
80100576:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
80100579:	85 c9                	test   %ecx,%ecx
{
8010057b:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
8010057e:	74 04                	je     80100584 <printint+0x14>
80100580:	85 c0                	test   %eax,%eax
80100582:	78 6e                	js     801005f2 <printint+0x82>
    x = xx;
80100584:	89 c1                	mov    %eax,%ecx
80100586:	31 ff                	xor    %edi,%edi
  i = 0;
80100588:	89 7d cc             	mov    %edi,-0x34(%ebp)
8010058b:	8d 75 d7             	lea    -0x29(%ebp),%esi
8010058e:	31 db                	xor    %ebx,%ebx
    buf[i++] = digits[x % base];
80100590:	89 c8                	mov    %ecx,%eax
80100592:	31 d2                	xor    %edx,%edx
80100594:	f7 75 d4             	divl   -0x2c(%ebp)
80100597:	89 cf                	mov    %ecx,%edi
80100599:	89 45 d0             	mov    %eax,-0x30(%ebp)
8010059c:	0f b6 92 d0 73 10 80 	movzbl -0x7fef8c30(%edx),%edx
801005a3:	89 d8                	mov    %ebx,%eax
  }while((x /= base) != 0);
801005a5:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    buf[i++] = digits[x % base];
801005a8:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
801005ab:	89 7d d0             	mov    %edi,-0x30(%ebp)
801005ae:	8b 7d d4             	mov    -0x2c(%ebp),%edi
801005b1:	39 7d d0             	cmp    %edi,-0x30(%ebp)
    buf[i++] = digits[x % base];
801005b4:	88 54 06 01          	mov    %dl,0x1(%esi,%eax,1)
  }while((x /= base) != 0);
801005b8:	73 d6                	jae    80100590 <printint+0x20>
801005ba:	8b 7d cc             	mov    -0x34(%ebp),%edi
  if(sign)
801005bd:	85 ff                	test   %edi,%edi
801005bf:	74 09                	je     801005ca <printint+0x5a>
    buf[i++] = '-';
801005c1:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801005c6:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
801005c8:	b2 2d                	mov    $0x2d,%dl
  while(--i >= 0)
801005ca:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
  if(panicked){
801005ce:	a1 58 a5 10 80       	mov    0x8010a558,%eax
801005d3:	85 c0                	test   %eax,%eax
801005d5:	74 09                	je     801005e0 <printint+0x70>
  asm volatile("cli");
801005d7:	fa                   	cli    
    for(;;)
801005d8:	eb fe                	jmp    801005d8 <printint+0x68>
801005da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005e0:	0f be c2             	movsbl %dl,%eax
801005e3:	e8 f8 fd ff ff       	call   801003e0 <consputc.part.0>
  while(--i >= 0)
801005e8:	39 f3                	cmp    %esi,%ebx
801005ea:	74 0e                	je     801005fa <printint+0x8a>
801005ec:	0f b6 13             	movzbl (%ebx),%edx
801005ef:	4b                   	dec    %ebx
801005f0:	eb dc                	jmp    801005ce <printint+0x5e>
    x = -xx;
801005f2:	f7 d8                	neg    %eax
801005f4:	89 cf                	mov    %ecx,%edi
801005f6:	89 c1                	mov    %eax,%ecx
801005f8:	eb 8e                	jmp    80100588 <printint+0x18>
}
801005fa:	83 c4 2c             	add    $0x2c,%esp
801005fd:	5b                   	pop    %ebx
801005fe:	5e                   	pop    %esi
801005ff:	5f                   	pop    %edi
80100600:	5d                   	pop    %ebp
80100601:	c3                   	ret    
80100602:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100610 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100610:	55                   	push   %ebp
80100611:	89 e5                	mov    %esp,%ebp
80100613:	57                   	push   %edi
80100614:	56                   	push   %esi
80100615:	53                   	push   %ebx
80100616:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
80100619:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010061c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
8010061f:	89 04 24             	mov    %eax,(%esp)
80100622:	e8 b9 12 00 00       	call   801018e0 <iunlock>
  acquire(&cons.lock);
80100627:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010062e:	e8 0d 41 00 00       	call   80104740 <acquire>
  for(i = 0; i < n; i++)
80100633:	85 db                	test   %ebx,%ebx
80100635:	7e 26                	jle    8010065d <consolewrite+0x4d>
80100637:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010063a:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
8010063d:	a1 58 a5 10 80       	mov    0x8010a558,%eax
80100642:	85 c0                	test   %eax,%eax
80100644:	74 0a                	je     80100650 <consolewrite+0x40>
80100646:	fa                   	cli    
    for(;;)
80100647:	eb fe                	jmp    80100647 <consolewrite+0x37>
80100649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i] & 0xff);
80100650:	0f b6 07             	movzbl (%edi),%eax
80100653:	47                   	inc    %edi
80100654:	e8 87 fd ff ff       	call   801003e0 <consputc.part.0>
  for(i = 0; i < n; i++)
80100659:	39 fe                	cmp    %edi,%esi
8010065b:	75 e0                	jne    8010063d <consolewrite+0x2d>
  release(&cons.lock);
8010065d:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100664:	e8 87 41 00 00       	call   801047f0 <release>
  ilock(ip);
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	89 04 24             	mov    %eax,(%esp)
8010066f:	e8 8c 11 00 00       	call   80101800 <ilock>

  return n;
}
80100674:	83 c4 1c             	add    $0x1c,%esp
80100677:	89 d8                	mov    %ebx,%eax
80100679:	5b                   	pop    %ebx
8010067a:	5e                   	pop    %esi
8010067b:	5f                   	pop    %edi
8010067c:	5d                   	pop    %ebp
8010067d:	c3                   	ret    
8010067e:	66 90                	xchg   %ax,%ax

80100680 <cprintf>:
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 2c             	sub    $0x2c,%esp
  locking = cons.locking;
80100689:	a1 54 a5 10 80       	mov    0x8010a554,%eax
8010068e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100691:	85 c0                	test   %eax,%eax
80100693:	0f 85 f4 00 00 00    	jne    8010078d <cprintf+0x10d>
  if (fmt == 0)
80100699:	8b 75 08             	mov    0x8(%ebp),%esi
8010069c:	85 f6                	test   %esi,%esi
8010069e:	0f 84 6d 01 00 00    	je     80100811 <cprintf+0x191>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006a4:	0f b6 06             	movzbl (%esi),%eax
801006a7:	85 c0                	test   %eax,%eax
801006a9:	74 3d                	je     801006e8 <cprintf+0x68>
801006ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  argp = (uint*)(void*)(&fmt + 1);
801006b2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
    if(c != '%'){
801006b5:	83 f8 25             	cmp    $0x25,%eax
801006b8:	74 46                	je     80100700 <cprintf+0x80>
  if(panicked){
801006ba:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801006c0:	85 c9                	test   %ecx,%ecx
801006c2:	74 11                	je     801006d5 <cprintf+0x55>
801006c4:	fa                   	cli    
    for(;;)
801006c5:	eb fe                	jmp    801006c5 <cprintf+0x45>
801006c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006ce:	66 90                	xchg   %ax,%ax
801006d0:	b8 25 00 00 00       	mov    $0x25,%eax
801006d5:	e8 06 fd ff ff       	call   801003e0 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006da:	ff 45 e4             	incl   -0x1c(%ebp)
801006dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006e0:	0f b6 04 06          	movzbl (%esi,%eax,1),%eax
801006e4:	85 c0                	test   %eax,%eax
801006e6:	75 cd                	jne    801006b5 <cprintf+0x35>
  if(locking)
801006e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006eb:	85 c0                	test   %eax,%eax
801006ed:	0f 85 0d 01 00 00    	jne    80100800 <cprintf+0x180>
}
801006f3:	83 c4 2c             	add    $0x2c,%esp
801006f6:	5b                   	pop    %ebx
801006f7:	5e                   	pop    %esi
801006f8:	5f                   	pop    %edi
801006f9:	5d                   	pop    %ebp
801006fa:	c3                   	ret    
801006fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801006ff:	90                   	nop
    c = fmt[++i] & 0xff;
80100700:	ff 45 e4             	incl   -0x1c(%ebp)
80100703:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100706:	0f b6 3c 06          	movzbl (%esi,%eax,1),%edi
    if(c == 0)
8010070a:	85 ff                	test   %edi,%edi
8010070c:	74 da                	je     801006e8 <cprintf+0x68>
    switch(c){
8010070e:	83 ff 70             	cmp    $0x70,%edi
80100711:	74 62                	je     80100775 <cprintf+0xf5>
80100713:	7f 2a                	jg     8010073f <cprintf+0xbf>
80100715:	83 ff 25             	cmp    $0x25,%edi
80100718:	0f 84 94 00 00 00    	je     801007b2 <cprintf+0x132>
8010071e:	83 ff 64             	cmp    $0x64,%edi
80100721:	0f 85 a9 00 00 00    	jne    801007d0 <cprintf+0x150>
      printint(*argp++, 10, 1);
80100727:	8b 03                	mov    (%ebx),%eax
80100729:	8d 7b 04             	lea    0x4(%ebx),%edi
8010072c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100731:	ba 0a 00 00 00       	mov    $0xa,%edx
80100736:	89 fb                	mov    %edi,%ebx
80100738:	e8 33 fe ff ff       	call   80100570 <printint>
      break;
8010073d:	eb 9b                	jmp    801006da <cprintf+0x5a>
    switch(c){
8010073f:	83 ff 73             	cmp    $0x73,%edi
80100742:	75 2c                	jne    80100770 <cprintf+0xf0>
      if((s = (char*)*argp++) == 0)
80100744:	8d 7b 04             	lea    0x4(%ebx),%edi
80100747:	8b 1b                	mov    (%ebx),%ebx
80100749:	85 db                	test   %ebx,%ebx
8010074b:	75 57                	jne    801007a4 <cprintf+0x124>
        s = "(null)";
8010074d:	bb b8 73 10 80       	mov    $0x801073b8,%ebx
      for(; *s; s++)
80100752:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
80100757:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
8010075d:	85 d2                	test   %edx,%edx
8010075f:	74 3d                	je     8010079e <cprintf+0x11e>
80100761:	fa                   	cli    
    for(;;)
80100762:	eb fe                	jmp    80100762 <cprintf+0xe2>
80100764:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010076b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010076f:	90                   	nop
    switch(c){
80100770:	83 ff 78             	cmp    $0x78,%edi
80100773:	75 5b                	jne    801007d0 <cprintf+0x150>
      printint(*argp++, 16, 0);
80100775:	8b 03                	mov    (%ebx),%eax
80100777:	8d 7b 04             	lea    0x4(%ebx),%edi
8010077a:	31 c9                	xor    %ecx,%ecx
8010077c:	ba 10 00 00 00       	mov    $0x10,%edx
80100781:	89 fb                	mov    %edi,%ebx
80100783:	e8 e8 fd ff ff       	call   80100570 <printint>
      break;
80100788:	e9 4d ff ff ff       	jmp    801006da <cprintf+0x5a>
    acquire(&cons.lock);
8010078d:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100794:	e8 a7 3f 00 00       	call   80104740 <acquire>
80100799:	e9 fb fe ff ff       	jmp    80100699 <cprintf+0x19>
8010079e:	e8 3d fc ff ff       	call   801003e0 <consputc.part.0>
      for(; *s; s++)
801007a3:	43                   	inc    %ebx
801007a4:	0f be 03             	movsbl (%ebx),%eax
801007a7:	84 c0                	test   %al,%al
801007a9:	75 ac                	jne    80100757 <cprintf+0xd7>
      if((s = (char*)*argp++) == 0)
801007ab:	89 fb                	mov    %edi,%ebx
801007ad:	e9 28 ff ff ff       	jmp    801006da <cprintf+0x5a>
  if(panicked){
801007b2:	8b 3d 58 a5 10 80    	mov    0x8010a558,%edi
801007b8:	85 ff                	test   %edi,%edi
801007ba:	0f 84 10 ff ff ff    	je     801006d0 <cprintf+0x50>
801007c0:	fa                   	cli    
    for(;;)
801007c1:	eb fe                	jmp    801007c1 <cprintf+0x141>
801007c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(panicked){
801007d0:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
801007d6:	85 c9                	test   %ecx,%ecx
801007d8:	74 06                	je     801007e0 <cprintf+0x160>
801007da:	fa                   	cli    
    for(;;)
801007db:	eb fe                	jmp    801007db <cprintf+0x15b>
801007dd:	8d 76 00             	lea    0x0(%esi),%esi
801007e0:	b8 25 00 00 00       	mov    $0x25,%eax
801007e5:	e8 f6 fb ff ff       	call   801003e0 <consputc.part.0>
  if(panicked){
801007ea:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801007f0:	85 d2                	test   %edx,%edx
801007f2:	74 2c                	je     80100820 <cprintf+0x1a0>
801007f4:	fa                   	cli    
    for(;;)
801007f5:	eb fe                	jmp    801007f5 <cprintf+0x175>
801007f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007fe:	66 90                	xchg   %ax,%ax
    release(&cons.lock);
80100800:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100807:	e8 e4 3f 00 00       	call   801047f0 <release>
}
8010080c:	e9 e2 fe ff ff       	jmp    801006f3 <cprintf+0x73>
    panic("null fmt");
80100811:	c7 04 24 bf 73 10 80 	movl   $0x801073bf,(%esp)
80100818:	e8 43 fb ff ff       	call   80100360 <panic>
8010081d:	8d 76 00             	lea    0x0(%esi),%esi
80100820:	89 f8                	mov    %edi,%eax
80100822:	e8 b9 fb ff ff       	call   801003e0 <consputc.part.0>
80100827:	e9 ae fe ff ff       	jmp    801006da <cprintf+0x5a>
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100830 <consoleintr>:
{
80100830:	55                   	push   %ebp
80100831:	89 e5                	mov    %esp,%ebp
80100833:	57                   	push   %edi
80100834:	56                   	push   %esi
  int c, doprocdump = 0;
80100835:	31 f6                	xor    %esi,%esi
{
80100837:	53                   	push   %ebx
80100838:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&cons.lock);
8010083b:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
{
80100842:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
80100845:	e8 f6 3e 00 00       	call   80104740 <acquire>
  while((c = getc()) >= 0){
8010084a:	eb 17                	jmp    80100863 <consoleintr+0x33>
    switch(c){
8010084c:	83 fb 08             	cmp    $0x8,%ebx
8010084f:	0f 84 fb 00 00 00    	je     80100950 <consoleintr+0x120>
80100855:	83 fb 10             	cmp    $0x10,%ebx
80100858:	0f 85 22 01 00 00    	jne    80100980 <consoleintr+0x150>
8010085e:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
80100863:	ff d7                	call   *%edi
80100865:	85 c0                	test   %eax,%eax
80100867:	89 c3                	mov    %eax,%ebx
80100869:	0f 88 40 01 00 00    	js     801009af <consoleintr+0x17f>
    switch(c){
8010086f:	83 fb 15             	cmp    $0x15,%ebx
80100872:	74 7c                	je     801008f0 <consoleintr+0xc0>
80100874:	7e d6                	jle    8010084c <consoleintr+0x1c>
80100876:	83 fb 7f             	cmp    $0x7f,%ebx
80100879:	0f 84 d1 00 00 00    	je     80100950 <consoleintr+0x120>
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010087f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100884:	8b 0d a0 ff 10 80    	mov    0x8010ffa0,%ecx
8010088a:	89 c2                	mov    %eax,%edx
8010088c:	29 ca                	sub    %ecx,%edx
8010088e:	83 fa 7f             	cmp    $0x7f,%edx
80100891:	77 d0                	ja     80100863 <consoleintr+0x33>
        c = (c == '\r') ? '\n' : c;
80100893:	8d 48 01             	lea    0x1(%eax),%ecx
80100896:	83 e0 7f             	and    $0x7f,%eax
80100899:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	89 0d a8 ff 10 80    	mov    %ecx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008a5:	83 fb 0d             	cmp    $0xd,%ebx
801008a8:	0f 84 19 01 00 00    	je     801009c7 <consoleintr+0x197>
        input.buf[input.e++ % INPUT_BUF] = c;
801008ae:	88 98 20 ff 10 80    	mov    %bl,-0x7fef00e0(%eax)
  if(panicked){
801008b4:	85 d2                	test   %edx,%edx
801008b6:	0f 85 16 01 00 00    	jne    801009d2 <consoleintr+0x1a2>
801008bc:	89 d8                	mov    %ebx,%eax
801008be:	e8 1d fb ff ff       	call   801003e0 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 fb 0a             	cmp    $0xa,%ebx
801008c6:	0f 84 2a 01 00 00    	je     801009f6 <consoleintr+0x1c6>
801008cc:	83 fb 04             	cmp    $0x4,%ebx
801008cf:	0f 84 21 01 00 00    	je     801009f6 <consoleintr+0x1c6>
801008d5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801008e3:	0f 85 7a ff ff ff    	jne    80100863 <consoleintr+0x33>
801008e9:	e9 0d 01 00 00       	jmp    801009fb <consoleintr+0x1cb>
801008ee:	66 90                	xchg   %ax,%ax
      while(input.e != input.w &&
801008f0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008f5:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
801008fb:	0f 84 62 ff ff ff    	je     80100863 <consoleintr+0x33>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100901:	48                   	dec    %eax
80100902:	89 c2                	mov    %eax,%edx
80100904:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100907:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010090e:	0f 84 4f ff ff ff    	je     80100863 <consoleintr+0x33>
        input.e--;
80100914:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
80100919:	a1 58 a5 10 80       	mov    0x8010a558,%eax
8010091e:	85 c0                	test   %eax,%eax
80100920:	74 0e                	je     80100930 <consoleintr+0x100>
80100922:	fa                   	cli    
    for(;;)
80100923:	eb fe                	jmp    80100923 <consoleintr+0xf3>
80100925:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010092c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100930:	b8 00 01 00 00       	mov    $0x100,%eax
80100935:	e8 a6 fa ff ff       	call   801003e0 <consputc.part.0>
      while(input.e != input.w &&
8010093a:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010093f:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100945:	75 ba                	jne    80100901 <consoleintr+0xd1>
80100947:	e9 17 ff ff ff       	jmp    80100863 <consoleintr+0x33>
8010094c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
80100950:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100955:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010095b:	0f 84 02 ff ff ff    	je     80100863 <consoleintr+0x33>
  if(panicked){
80100961:	8b 1d 58 a5 10 80    	mov    0x8010a558,%ebx
        input.e--;
80100967:	48                   	dec    %eax
80100968:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
  if(panicked){
8010096d:	85 db                	test   %ebx,%ebx
8010096f:	74 2f                	je     801009a0 <consoleintr+0x170>
80100971:	fa                   	cli    
    for(;;)
80100972:	eb fe                	jmp    80100972 <consoleintr+0x142>
80100974:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100980:	85 db                	test   %ebx,%ebx
80100982:	0f 84 db fe ff ff    	je     80100863 <consoleintr+0x33>
80100988:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010098f:	90                   	nop
80100990:	e9 ea fe ff ff       	jmp    8010087f <consoleintr+0x4f>
80100995:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009a0:	b8 00 01 00 00       	mov    $0x100,%eax
801009a5:	e8 36 fa ff ff       	call   801003e0 <consputc.part.0>
801009aa:	e9 b4 fe ff ff       	jmp    80100863 <consoleintr+0x33>
  release(&cons.lock);
801009af:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801009b6:	e8 35 3e 00 00       	call   801047f0 <release>
  if(doprocdump) {
801009bb:	85 f6                	test   %esi,%esi
801009bd:	75 21                	jne    801009e0 <consoleintr+0x1b0>
}
801009bf:	83 c4 1c             	add    $0x1c,%esp
801009c2:	5b                   	pop    %ebx
801009c3:	5e                   	pop    %esi
801009c4:	5f                   	pop    %edi
801009c5:	5d                   	pop    %ebp
801009c6:	c3                   	ret    
        input.buf[input.e++ % INPUT_BUF] = c;
801009c7:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
  if(panicked){
801009ce:	85 d2                	test   %edx,%edx
801009d0:	74 1a                	je     801009ec <consoleintr+0x1bc>
801009d2:	fa                   	cli    
    for(;;)
801009d3:	eb fe                	jmp    801009d3 <consoleintr+0x1a3>
801009d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
801009e0:	83 c4 1c             	add    $0x1c,%esp
801009e3:	5b                   	pop    %ebx
801009e4:	5e                   	pop    %esi
801009e5:	5f                   	pop    %edi
801009e6:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801009e7:	e9 c4 39 00 00       	jmp    801043b0 <procdump>
801009ec:	b8 0a 00 00 00       	mov    $0xa,%eax
801009f1:	e8 ea f9 ff ff       	call   801003e0 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009f6:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
          wakeup(&input.r);
801009fb:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
          input.w = input.e;
80100a02:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100a07:	e8 c4 38 00 00       	call   801042d0 <wakeup>
80100a0c:	e9 52 fe ff ff       	jmp    80100863 <consoleintr+0x33>
80100a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a1f:	90                   	nop

80100a20 <consoleinit>:

void
consoleinit(void)
{
80100a20:	55                   	push   %ebp
  initlock(&cons.lock, "console");
80100a21:	b8 c8 73 10 80       	mov    $0x801073c8,%eax
{
80100a26:	89 e5                	mov    %esp,%ebp
80100a28:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a2b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a2f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100a36:	e8 95 3b 00 00       	call   801045d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;
80100a3b:	b8 01 00 00 00       	mov    $0x1,%eax
  devsw[CONSOLE].write = consolewrite;
80100a40:	ba 10 06 10 80       	mov    $0x80100610,%edx
  cons.locking = 1;
80100a45:	a3 54 a5 10 80       	mov    %eax,0x8010a554

  ioapicenable(IRQ_KBD, 0);
80100a4a:	31 c0                	xor    %eax,%eax
  devsw[CONSOLE].read = consoleread;
80100a4c:	b9 70 02 10 80       	mov    $0x80100270,%ecx
  ioapicenable(IRQ_KBD, 0);
80100a51:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100a5c:	89 15 6c 09 11 80    	mov    %edx,0x8011096c
  devsw[CONSOLE].read = consoleread;
80100a62:	89 0d 68 09 11 80    	mov    %ecx,0x80110968
  ioapicenable(IRQ_KBD, 0);
80100a68:	e8 d3 1a 00 00       	call   80102540 <ioapicenable>
}
80100a6d:	c9                   	leave  
80100a6e:	c3                   	ret    
80100a6f:	90                   	nop

80100a70 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a70:	55                   	push   %ebp
80100a71:	89 e5                	mov    %esp,%ebp
80100a73:	57                   	push   %edi
80100a74:	56                   	push   %esi
80100a75:	53                   	push   %ebx
80100a76:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a7c:	e8 9f 2f 00 00       	call   80103a20 <myproc>
80100a81:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100a87:	e8 84 23 00 00       	call   80102e10 <begin_op>

  if((ip = namei(path)) == 0){
80100a8c:	8b 45 08             	mov    0x8(%ebp),%eax
80100a8f:	89 04 24             	mov    %eax,(%esp)
80100a92:	e8 d9 16 00 00       	call   80102170 <namei>
80100a97:	85 c0                	test   %eax,%eax
80100a99:	0f 84 39 03 00 00    	je     80100dd8 <exec+0x368>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a9f:	89 04 24             	mov    %eax,(%esp)
80100aa2:	89 c3                	mov    %eax,%ebx
80100aa4:	e8 57 0d 00 00       	call   80101800 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aa9:	b8 34 00 00 00       	mov    $0x34,%eax
80100aae:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100ab2:	31 c0                	xor    %eax,%eax
80100ab4:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ab8:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100abe:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ac2:	89 1c 24             	mov    %ebx,(%esp)
80100ac5:	e8 26 10 00 00       	call   80101af0 <readi>
80100aca:	83 f8 34             	cmp    $0x34,%eax
80100acd:	74 21                	je     80100af0 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100acf:	89 1c 24             	mov    %ebx,(%esp)
80100ad2:	e8 c9 0f 00 00       	call   80101aa0 <iunlockput>
    end_op();
80100ad7:	e8 a4 23 00 00       	call   80102e80 <end_op>
  }
  return -1;
80100adc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ae1:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100ae7:	5b                   	pop    %ebx
80100ae8:	5e                   	pop    %esi
80100ae9:	5f                   	pop    %edi
80100aea:	5d                   	pop    %ebp
80100aeb:	c3                   	ret    
80100aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100af0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100af7:	45 4c 46 
80100afa:	75 d3                	jne    80100acf <exec+0x5f>
  if((pgdir = setupkvm()) == 0)
80100afc:	e8 8f 65 00 00       	call   80107090 <setupkvm>
80100b01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b07:	85 c0                	test   %eax,%eax
80100b09:	74 c4                	je     80100acf <exec+0x5f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b0b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b12:	00 
80100b13:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b19:	0f 84 d4 02 00 00    	je     80100df3 <exec+0x383>
  sz = 0;
80100b1f:	31 c0                	xor    %eax,%eax
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b21:	31 ff                	xor    %edi,%edi
  sz = 0;
80100b23:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b29:	e9 99 00 00 00       	jmp    80100bc7 <exec+0x157>
80100b2e:	66 90                	xchg   %ax,%ax
    if(ph.type != ELF_PROG_LOAD)
80100b30:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b37:	75 7f                	jne    80100bb8 <exec+0x148>
    if(ph.memsz < ph.filesz)
80100b39:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b3f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b45:	0f 82 a4 00 00 00    	jb     80100bef <exec+0x17f>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b4b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b51:	0f 82 98 00 00 00    	jb     80100bef <exec+0x17f>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b57:	89 44 24 08          	mov    %eax,0x8(%esp)
80100b5b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b61:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b65:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100b6b:	89 04 24             	mov    %eax,(%esp)
80100b6e:	e8 2d 63 00 00       	call   80106ea0 <allocuvm>
80100b73:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b79:	85 c0                	test   %eax,%eax
80100b7b:	74 72                	je     80100bef <exec+0x17f>
    if(ph.vaddr % PGSIZE != 0)
80100b7d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b83:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b88:	75 65                	jne    80100bef <exec+0x17f>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b8e:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100b94:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b98:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100b9e:	89 54 24 10          	mov    %edx,0x10(%esp)
80100ba2:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100ba8:	89 04 24             	mov    %eax,(%esp)
80100bab:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100baf:	e8 1c 62 00 00       	call   80106dd0 <loaduvm>
80100bb4:	85 c0                	test   %eax,%eax
80100bb6:	78 37                	js     80100bef <exec+0x17f>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bb8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bbf:	47                   	inc    %edi
80100bc0:	83 c6 20             	add    $0x20,%esi
80100bc3:	39 f8                	cmp    %edi,%eax
80100bc5:	7e 49                	jle    80100c10 <exec+0x1a0>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bc7:	89 74 24 08          	mov    %esi,0x8(%esp)
80100bcb:	b8 20 00 00 00       	mov    $0x20,%eax
80100bd0:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100bd4:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bda:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bde:	89 1c 24             	mov    %ebx,(%esp)
80100be1:	e8 0a 0f 00 00       	call   80101af0 <readi>
80100be6:	83 f8 20             	cmp    $0x20,%eax
80100be9:	0f 84 41 ff ff ff    	je     80100b30 <exec+0xc0>
    freevm(pgdir);
80100bef:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100bf5:	89 04 24             	mov    %eax,(%esp)
80100bf8:	e8 13 64 00 00       	call   80107010 <freevm>
  if(ip){
80100bfd:	e9 cd fe ff ff       	jmp    80100acf <exec+0x5f>
80100c02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c10:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c16:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c1c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c22:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c28:	89 1c 24             	mov    %ebx,(%esp)
80100c2b:	e8 70 0e 00 00       	call   80101aa0 <iunlockput>
  end_op();
80100c30:	e8 4b 22 00 00       	call   80102e80 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c35:	89 7c 24 04          	mov    %edi,0x4(%esp)
80100c39:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c3f:	89 74 24 08          	mov    %esi,0x8(%esp)
80100c43:	89 3c 24             	mov    %edi,(%esp)
80100c46:	e8 55 62 00 00       	call   80106ea0 <allocuvm>
80100c4b:	85 c0                	test   %eax,%eax
80100c4d:	89 c6                	mov    %eax,%esi
80100c4f:	0f 84 9b 00 00 00    	je     80100cf0 <exec+0x280>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c55:	89 3c 24             	mov    %edi,(%esp)
80100c58:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c5e:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c60:	89 44 24 04          	mov    %eax,0x4(%esp)
  for(argc = 0; argv[argc]; argc++) {
80100c64:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c66:	e8 d5 64 00 00       	call   80107140 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c74:	8b 00                	mov    (%eax),%eax
80100c76:	85 c0                	test   %eax,%eax
80100c78:	0f 84 90 00 00 00    	je     80100d0e <exec+0x29e>
80100c7e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c84:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c8a:	eb 21                	jmp    80100cad <exec+0x23d>
80100c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ustack[3+argc] = sp;
80100c90:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c97:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c9a:	47                   	inc    %edi
    ustack[3+argc] = sp;
80100c9b:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100ca1:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100ca4:	85 c0                	test   %eax,%eax
80100ca6:	74 60                	je     80100d08 <exec+0x298>
    if(argc >= MAXARG)
80100ca8:	83 ff 20             	cmp    $0x20,%edi
80100cab:	74 43                	je     80100cf0 <exec+0x280>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cad:	89 04 24             	mov    %eax,(%esp)
80100cb0:	e8 ab 3d 00 00       	call   80104a60 <strlen>
80100cb5:	f7 d0                	not    %eax
80100cb7:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb9:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cbc:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cbf:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cc2:	89 04 24             	mov    %eax,(%esp)
80100cc5:	e8 96 3d 00 00       	call   80104a60 <strlen>
80100cca:	40                   	inc    %eax
80100ccb:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cd2:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cd5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100cd9:	89 34 24             	mov    %esi,(%esp)
80100cdc:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ce0:	e8 cb 65 00 00       	call   801072b0 <copyout>
80100ce5:	85 c0                	test   %eax,%eax
80100ce7:	79 a7                	jns    80100c90 <exec+0x220>
80100ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100cf0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100cf6:	89 04 24             	mov    %eax,(%esp)
80100cf9:	e8 12 63 00 00       	call   80107010 <freevm>
  return -1;
80100cfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d03:	e9 d9 fd ff ff       	jmp    80100ae1 <exec+0x71>
80100d08:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d0e:	89 54 24 08          	mov    %edx,0x8(%esp)
  ustack[3+argc] = 0;
80100d12:	31 c9                	xor    %ecx,%ecx
  ustack[0] = 0xffffffff;  // fake return PC
80100d14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ustack[3+argc] = 0;
80100d19:	89 8c bd 64 ff ff ff 	mov    %ecx,-0x9c(%ebp,%edi,4)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d20:	89 d9                	mov    %ebx,%ecx
  ustack[0] = 0xffffffff;  // fake return PC
80100d22:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d28:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
  ustack[1] = argc;
80100d2f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d35:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d37:	83 c0 0c             	add    $0xc,%eax
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d3a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  sp -= (3+argc+1) * 4;
80100d3e:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d40:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d46:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4a:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d50:	89 04 24             	mov    %eax,(%esp)
80100d53:	e8 58 65 00 00       	call   801072b0 <copyout>
80100d58:	85 c0                	test   %eax,%eax
80100d5a:	78 94                	js     80100cf0 <exec+0x280>
  for(last=s=path; *s; s++)
80100d5c:	8b 45 08             	mov    0x8(%ebp),%eax
80100d5f:	8b 55 08             	mov    0x8(%ebp),%edx
80100d62:	0f b6 00             	movzbl (%eax),%eax
80100d65:	84 c0                	test   %al,%al
80100d67:	74 14                	je     80100d7d <exec+0x30d>
80100d69:	89 d1                	mov    %edx,%ecx
80100d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100d6f:	90                   	nop
    if(*s == '/')
80100d70:	41                   	inc    %ecx
80100d71:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d73:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80100d76:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d79:	84 c0                	test   %al,%al
80100d7b:	75 f3                	jne    80100d70 <exec+0x300>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d7d:	89 54 24 04          	mov    %edx,0x4(%esp)
80100d81:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d87:	b8 10 00 00 00       	mov    $0x10,%eax
80100d8c:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d90:	89 f8                	mov    %edi,%eax
80100d92:	83 c0 6c             	add    $0x6c,%eax
80100d95:	89 04 24             	mov    %eax,(%esp)
80100d98:	e8 83 3c 00 00       	call   80104a20 <safestrcpy>
  curproc->pgdir = pgdir;
80100d9d:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100da3:	89 f8                	mov    %edi,%eax
80100da5:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100da8:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100daa:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100dad:	89 c1                	mov    %eax,%ecx
80100daf:	8b 40 18             	mov    0x18(%eax),%eax
80100db2:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100db8:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dbb:	8b 41 18             	mov    0x18(%ecx),%eax
80100dbe:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100dc1:	89 0c 24             	mov    %ecx,(%esp)
80100dc4:	e8 77 5e 00 00       	call   80106c40 <switchuvm>
  freevm(oldpgdir);
80100dc9:	89 3c 24             	mov    %edi,(%esp)
80100dcc:	e8 3f 62 00 00       	call   80107010 <freevm>
  return 0;
80100dd1:	31 c0                	xor    %eax,%eax
80100dd3:	e9 09 fd ff ff       	jmp    80100ae1 <exec+0x71>
    end_op();
80100dd8:	e8 a3 20 00 00       	call   80102e80 <end_op>
    cprintf("exec: fail\n");
80100ddd:	c7 04 24 e1 73 10 80 	movl   $0x801073e1,(%esp)
80100de4:	e8 97 f8 ff ff       	call   80100680 <cprintf>
    return -1;
80100de9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dee:	e9 ee fc ff ff       	jmp    80100ae1 <exec+0x71>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100df3:	31 ff                	xor    %edi,%edi
80100df5:	be 00 20 00 00       	mov    $0x2000,%esi
80100dfa:	e9 29 fe ff ff       	jmp    80100c28 <exec+0x1b8>
80100dff:	90                   	nop

80100e00 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e00:	55                   	push   %ebp
  initlock(&ftable.lock, "ftable");
80100e01:	b8 ed 73 10 80       	mov    $0x801073ed,%eax
{
80100e06:	89 e5                	mov    %esp,%ebp
80100e08:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100e0b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e0f:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e16:	e8 b5 37 00 00       	call   801045d0 <initlock>
}
80100e1b:	c9                   	leave  
80100e1c:	c3                   	ret    
80100e1d:	8d 76 00             	lea    0x0(%esi),%esi

80100e20 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e24:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100e29:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100e2c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e33:	e8 08 39 00 00       	call   80104740 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e38:	eb 11                	jmp    80100e4b <filealloc+0x2b>
80100e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e40:	83 c3 18             	add    $0x18,%ebx
80100e43:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100e49:	74 25                	je     80100e70 <filealloc+0x50>
    if(f->ref == 0){
80100e4b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e4e:	85 c0                	test   %eax,%eax
80100e50:	75 ee                	jne    80100e40 <filealloc+0x20>
      f->ref = 1;
80100e52:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e59:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e60:	e8 8b 39 00 00       	call   801047f0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e65:	83 c4 14             	add    $0x14,%esp
80100e68:	89 d8                	mov    %ebx,%eax
80100e6a:	5b                   	pop    %ebx
80100e6b:	5d                   	pop    %ebp
80100e6c:	c3                   	ret    
80100e6d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100e70:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
  return 0;
80100e77:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e79:	e8 72 39 00 00       	call   801047f0 <release>
}
80100e7e:	83 c4 14             	add    $0x14,%esp
80100e81:	89 d8                	mov    %ebx,%eax
80100e83:	5b                   	pop    %ebx
80100e84:	5d                   	pop    %ebp
80100e85:	c3                   	ret    
80100e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e8d:	8d 76 00             	lea    0x0(%esi),%esi

80100e90 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e90:	55                   	push   %ebp
80100e91:	89 e5                	mov    %esp,%ebp
80100e93:	53                   	push   %ebx
80100e94:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100e97:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
{
80100e9e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100ea1:	e8 9a 38 00 00       	call   80104740 <acquire>
  if(f->ref < 1)
80100ea6:	8b 43 04             	mov    0x4(%ebx),%eax
80100ea9:	85 c0                	test   %eax,%eax
80100eab:	7e 18                	jle    80100ec5 <filedup+0x35>
    panic("filedup");
  f->ref++;
80100ead:	40                   	inc    %eax
80100eae:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100eb1:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100eb8:	e8 33 39 00 00       	call   801047f0 <release>
  return f;
}
80100ebd:	83 c4 14             	add    $0x14,%esp
80100ec0:	89 d8                	mov    %ebx,%eax
80100ec2:	5b                   	pop    %ebx
80100ec3:	5d                   	pop    %ebp
80100ec4:	c3                   	ret    
    panic("filedup");
80100ec5:	c7 04 24 f4 73 10 80 	movl   $0x801073f4,(%esp)
80100ecc:	e8 8f f4 ff ff       	call   80100360 <panic>
80100ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ed8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100edf:	90                   	nop

80100ee0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	83 ec 38             	sub    $0x38,%esp
80100ee6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100ee9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100eec:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
{
80100ef3:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100ef6:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquire(&ftable.lock);
80100ef9:	e8 42 38 00 00       	call   80104740 <acquire>
  if(f->ref < 1)
80100efe:	8b 53 04             	mov    0x4(%ebx),%edx
80100f01:	85 d2                	test   %edx,%edx
80100f03:	0f 8e b4 00 00 00    	jle    80100fbd <fileclose+0xdd>
    panic("fileclose");
  if(--f->ref > 0){
80100f09:	4a                   	dec    %edx
80100f0a:	89 53 04             	mov    %edx,0x4(%ebx)
80100f0d:	75 41                	jne    80100f50 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f0f:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f13:	8b 3b                	mov    (%ebx),%edi
  f->ref = 0;
  f->type = FD_NONE;
80100f15:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f1b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f1e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f21:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f24:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
  ff = *f;
80100f2b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f2e:	e8 bd 38 00 00       	call   801047f0 <release>

  if(ff.type == FD_PIPE)
80100f33:	83 ff 01             	cmp    $0x1,%edi
80100f36:	74 68                	je     80100fa0 <fileclose+0xc0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f38:	83 ff 02             	cmp    $0x2,%edi
80100f3b:	74 33                	je     80100f70 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f3d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100f40:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f43:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f46:	89 ec                	mov    %ebp,%esp
80100f48:	5d                   	pop    %ebp
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f50:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    release(&ftable.lock);
80100f53:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
}
80100f5a:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f5d:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f60:	89 ec                	mov    %ebp,%esp
80100f62:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f63:	e9 88 38 00 00       	jmp    801047f0 <release>
80100f68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f6f:	90                   	nop
    begin_op();
80100f70:	e8 9b 1e 00 00       	call   80102e10 <begin_op>
    iput(ff.ip);
80100f75:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100f78:	89 04 24             	mov    %eax,(%esp)
80100f7b:	e8 b0 09 00 00       	call   80101930 <iput>
}
80100f80:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100f83:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f86:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f89:	89 ec                	mov    %ebp,%esp
80100f8b:	5d                   	pop    %ebp
    end_op();
80100f8c:	e9 ef 1e 00 00       	jmp    80102e80 <end_op>
80100f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80100fa0:	89 34 24             	mov    %esi,(%esp)
80100fa3:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fa7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100fab:	e8 e0 25 00 00       	call   80103590 <pipeclose>
}
80100fb0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fb3:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fb6:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fb9:	89 ec                	mov    %ebp,%esp
80100fbb:	5d                   	pop    %ebp
80100fbc:	c3                   	ret    
    panic("fileclose");
80100fbd:	c7 04 24 fc 73 10 80 	movl   $0x801073fc,(%esp)
80100fc4:	e8 97 f3 ff ff       	call   80100360 <panic>
80100fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 14             	sub    $0x14,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
    ilock(f->ip);
80100fdf:	8b 43 10             	mov    0x10(%ebx),%eax
80100fe2:	89 04 24             	mov    %eax,(%esp)
80100fe5:	e8 16 08 00 00       	call   80101800 <ilock>
    stati(f->ip, st);
80100fea:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fed:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ff1:	8b 43 10             	mov    0x10(%ebx),%eax
80100ff4:	89 04 24             	mov    %eax,(%esp)
80100ff7:	e8 c4 0a 00 00       	call   80101ac0 <stati>
    iunlock(f->ip);
80100ffc:	8b 43 10             	mov    0x10(%ebx),%eax
80100fff:	89 04 24             	mov    %eax,(%esp)
80101002:	e8 d9 08 00 00       	call   801018e0 <iunlock>
    return 0;
  }
  return -1;
}
80101007:	83 c4 14             	add    $0x14,%esp
    return 0;
8010100a:	31 c0                	xor    %eax,%eax
}
8010100c:	5b                   	pop    %ebx
8010100d:	5d                   	pop    %ebp
8010100e:	c3                   	ret    
8010100f:	90                   	nop
80101010:	83 c4 14             	add    $0x14,%esp
  return -1;
80101013:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101018:	5b                   	pop    %ebx
80101019:	5d                   	pop    %ebp
8010101a:	c3                   	ret    
8010101b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010101f:	90                   	nop

80101020 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	83 ec 38             	sub    $0x38,%esp
80101026:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010102f:	8b 75 0c             	mov    0xc(%ebp),%esi
80101032:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101035:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101038:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
8010103c:	0f 84 7e 00 00 00    	je     801010c0 <fileread+0xa0>
    return -1;
  if(f->type == FD_PIPE)
80101042:	8b 03                	mov    (%ebx),%eax
80101044:	83 f8 01             	cmp    $0x1,%eax
80101047:	74 57                	je     801010a0 <fileread+0x80>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101049:	83 f8 02             	cmp    $0x2,%eax
8010104c:	75 79                	jne    801010c7 <fileread+0xa7>
    ilock(f->ip);
8010104e:	8b 43 10             	mov    0x10(%ebx),%eax
80101051:	89 04 24             	mov    %eax,(%esp)
80101054:	e8 a7 07 00 00       	call   80101800 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101059:	89 7c 24 0c          	mov    %edi,0xc(%esp)
8010105d:	8b 43 14             	mov    0x14(%ebx),%eax
80101060:	89 74 24 04          	mov    %esi,0x4(%esp)
80101064:	89 44 24 08          	mov    %eax,0x8(%esp)
80101068:	8b 43 10             	mov    0x10(%ebx),%eax
8010106b:	89 04 24             	mov    %eax,(%esp)
8010106e:	e8 7d 0a 00 00       	call   80101af0 <readi>
80101073:	85 c0                	test   %eax,%eax
80101075:	7e 03                	jle    8010107a <fileread+0x5a>
      f->off += r;
80101077:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
8010107a:	8b 53 10             	mov    0x10(%ebx),%edx
8010107d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101080:	89 14 24             	mov    %edx,(%esp)
80101083:	e8 58 08 00 00       	call   801018e0 <iunlock>
    return r;
80101088:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
8010108b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010108e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101091:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101094:	89 ec                	mov    %ebp,%esp
80101096:	5d                   	pop    %ebp
80101097:	c3                   	ret    
80101098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010109f:	90                   	nop
    return piperead(f->pipe, addr, n);
801010a0:	8b 43 0c             	mov    0xc(%ebx),%eax
}
801010a3:	8b 75 f8             	mov    -0x8(%ebp),%esi
801010a6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801010a9:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return piperead(f->pipe, addr, n);
801010ac:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010af:	89 ec                	mov    %ebp,%esp
801010b1:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801010b2:	e9 89 26 00 00       	jmp    80103740 <piperead>
801010b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010be:	66 90                	xchg   %ax,%ax
    return -1;
801010c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010c5:	eb c4                	jmp    8010108b <fileread+0x6b>
  panic("fileread");
801010c7:	c7 04 24 06 74 10 80 	movl   $0x80107406,(%esp)
801010ce:	e8 8d f2 ff ff       	call   80100360 <panic>
801010d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010e0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	57                   	push   %edi
801010e4:	56                   	push   %esi
801010e5:	53                   	push   %ebx
801010e6:	83 ec 2c             	sub    $0x2c,%esp
801010e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010ec:	8b 7d 08             	mov    0x8(%ebp),%edi
801010ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010f2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010f5:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
801010f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010fc:	0f 84 c5 00 00 00    	je     801011c7 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
80101102:	8b 07                	mov    (%edi),%eax
80101104:	83 f8 01             	cmp    $0x1,%eax
80101107:	0f 84 c7 00 00 00    	je     801011d4 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010110d:	83 f8 02             	cmp    $0x2,%eax
80101110:	0f 85 d0 00 00 00    	jne    801011e6 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101116:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101119:	31 f6                	xor    %esi,%esi
    while(i < n){
8010111b:	85 c0                	test   %eax,%eax
8010111d:	7f 35                	jg     80101154 <filewrite+0x74>
8010111f:	e9 9c 00 00 00       	jmp    801011c0 <filewrite+0xe0>
80101124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010112b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010112f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101130:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101133:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
80101136:	01 47 14             	add    %eax,0x14(%edi)
      iunlock(f->ip);
80101139:	89 0c 24             	mov    %ecx,(%esp)
8010113c:	e8 9f 07 00 00       	call   801018e0 <iunlock>
      end_op();
80101141:	e8 3a 1d 00 00       	call   80102e80 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101146:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101149:	39 c3                	cmp    %eax,%ebx
8010114b:	75 67                	jne    801011b4 <filewrite+0xd4>
        panic("short filewrite");
      i += r;
8010114d:	01 de                	add    %ebx,%esi
    while(i < n){
8010114f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101152:	7e 6c                	jle    801011c0 <filewrite+0xe0>
      int n1 = n - i;
80101154:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101157:	b8 00 06 00 00       	mov    $0x600,%eax
8010115c:	29 f3                	sub    %esi,%ebx
      if(n1 > max)
8010115e:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101164:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101167:	e8 a4 1c 00 00       	call   80102e10 <begin_op>
      ilock(f->ip);
8010116c:	8b 47 10             	mov    0x10(%edi),%eax
8010116f:	89 04 24             	mov    %eax,(%esp)
80101172:	e8 89 06 00 00       	call   80101800 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101177:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010117b:	8b 47 14             	mov    0x14(%edi),%eax
8010117e:	89 44 24 08          	mov    %eax,0x8(%esp)
80101182:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101185:	01 f0                	add    %esi,%eax
80101187:	89 44 24 04          	mov    %eax,0x4(%esp)
8010118b:	8b 47 10             	mov    0x10(%edi),%eax
8010118e:	89 04 24             	mov    %eax,(%esp)
80101191:	e8 8a 0a 00 00       	call   80101c20 <writei>
80101196:	85 c0                	test   %eax,%eax
80101198:	7f 96                	jg     80101130 <filewrite+0x50>
8010119a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      iunlock(f->ip);
8010119d:	8b 57 10             	mov    0x10(%edi),%edx
801011a0:	89 14 24             	mov    %edx,(%esp)
801011a3:	e8 38 07 00 00       	call   801018e0 <iunlock>
      end_op();
801011a8:	e8 d3 1c 00 00       	call   80102e80 <end_op>
      if(r < 0)
801011ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011b0:	85 c0                	test   %eax,%eax
801011b2:	75 13                	jne    801011c7 <filewrite+0xe7>
        panic("short filewrite");
801011b4:	c7 04 24 0f 74 10 80 	movl   $0x8010740f,(%esp)
801011bb:	e8 a0 f1 ff ff       	call   80100360 <panic>
    }
    return i == n ? n : -1;
801011c0:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
801011c3:	89 f0                	mov    %esi,%eax
801011c5:	74 05                	je     801011cc <filewrite+0xec>
801011c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801011cc:	83 c4 2c             	add    $0x2c,%esp
801011cf:	5b                   	pop    %ebx
801011d0:	5e                   	pop    %esi
801011d1:	5f                   	pop    %edi
801011d2:	5d                   	pop    %ebp
801011d3:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801011d4:	8b 47 0c             	mov    0xc(%edi),%eax
801011d7:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011da:	83 c4 2c             	add    $0x2c,%esp
801011dd:	5b                   	pop    %ebx
801011de:	5e                   	pop    %esi
801011df:	5f                   	pop    %edi
801011e0:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011e1:	e9 4a 24 00 00       	jmp    80103630 <pipewrite>
  panic("filewrite");
801011e6:	c7 04 24 15 74 10 80 	movl   $0x80107415,(%esp)
801011ed:	e8 6e f1 ff ff       	call   80100360 <panic>
801011f2:	66 90                	xchg   %ax,%ax
801011f4:	66 90                	xchg   %ax,%ax
801011f6:	66 90                	xchg   %ax,%ax
801011f8:	66 90                	xchg   %ax,%ax
801011fa:	66 90                	xchg   %ax,%ax
801011fc:	66 90                	xchg   %ax,%ax
801011fe:	66 90                	xchg   %ax,%ax

80101200 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101200:	55                   	push   %ebp
80101201:	89 c1                	mov    %eax,%ecx
80101203:	89 e5                	mov    %esp,%ebp
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101205:	89 d0                	mov    %edx,%eax
{
80101207:	56                   	push   %esi
80101208:	53                   	push   %ebx
80101209:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
8010120b:	c1 e8 0c             	shr    $0xc,%eax
{
8010120e:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101211:	89 0c 24             	mov    %ecx,(%esp)
80101214:	8b 15 d8 09 11 80    	mov    0x801109d8,%edx
8010121a:	01 d0                	add    %edx,%eax
8010121c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101220:	e8 ab ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101225:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101227:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010122a:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010122d:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101233:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101235:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
8010123a:	0f b6 54 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%edx
  m = 1 << (bi % 8);
8010123f:	d3 e0                	shl    %cl,%eax
80101241:	89 c1                	mov    %eax,%ecx
  if((bp->data[bi/8] & m) == 0)
80101243:	85 c2                	test   %eax,%edx
80101245:	74 1f                	je     80101266 <bfree+0x66>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101247:	f6 d1                	not    %cl
80101249:	20 d1                	and    %dl,%cl
8010124b:	88 4c 1e 5c          	mov    %cl,0x5c(%esi,%ebx,1)
  log_write(bp);
8010124f:	89 34 24             	mov    %esi,(%esp)
80101252:	e8 59 1d 00 00       	call   80102fb0 <log_write>
  brelse(bp);
80101257:	89 34 24             	mov    %esi,(%esp)
8010125a:	e8 91 ef ff ff       	call   801001f0 <brelse>
}
8010125f:	83 c4 10             	add    $0x10,%esp
80101262:	5b                   	pop    %ebx
80101263:	5e                   	pop    %esi
80101264:	5d                   	pop    %ebp
80101265:	c3                   	ret    
    panic("freeing free block");
80101266:	c7 04 24 1f 74 10 80 	movl   $0x8010741f,(%esp)
8010126d:	e8 ee f0 ff ff       	call   80100360 <panic>
80101272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101280 <balloc>:
{
80101280:	55                   	push   %ebp
80101281:	89 e5                	mov    %esp,%ebp
80101283:	57                   	push   %edi
80101284:	56                   	push   %esi
80101285:	53                   	push   %ebx
80101286:	83 ec 2c             	sub    $0x2c,%esp
80101289:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010128c:	8b 35 c0 09 11 80    	mov    0x801109c0,%esi
80101292:	85 f6                	test   %esi,%esi
80101294:	0f 84 7e 00 00 00    	je     80101318 <balloc+0x98>
8010129a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801012a1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801012a4:	8b 1d d8 09 11 80    	mov    0x801109d8,%ebx
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	c1 f8 0c             	sar    $0xc,%eax
801012af:	01 d8                	add    %ebx,%eax
801012b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801012b5:	8b 45 d8             	mov    -0x28(%ebp),%eax
801012b8:	89 04 24             	mov    %eax,(%esp)
801012bb:	e8 10 ee ff ff       	call   801000d0 <bread>
801012c0:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012c2:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801012c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012ca:	31 c0                	xor    %eax,%eax
801012cc:	eb 2b                	jmp    801012f9 <balloc+0x79>
801012ce:	66 90                	xchg   %ax,%ax
      m = 1 << (bi % 8);
801012d0:	89 c1                	mov    %eax,%ecx
801012d2:	bf 01 00 00 00       	mov    $0x1,%edi
801012d7:	83 e1 07             	and    $0x7,%ecx
801012da:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012dc:	89 c1                	mov    %eax,%ecx
      m = 1 << (bi % 8);
801012de:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012e1:	c1 f9 03             	sar    $0x3,%ecx
801012e4:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
801012e9:	85 7d e4             	test   %edi,-0x1c(%ebp)
801012ec:	89 fa                	mov    %edi,%edx
801012ee:	74 40                	je     80101330 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012f0:	40                   	inc    %eax
801012f1:	46                   	inc    %esi
801012f2:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012f7:	74 05                	je     801012fe <balloc+0x7e>
801012f9:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012fc:	77 d2                	ja     801012d0 <balloc+0x50>
    brelse(bp);
801012fe:	89 1c 24             	mov    %ebx,(%esp)
80101301:	e8 ea ee ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101306:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
8010130d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101310:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
80101316:	77 89                	ja     801012a1 <balloc+0x21>
  panic("balloc: out of blocks");
80101318:	c7 04 24 32 74 10 80 	movl   $0x80107432,(%esp)
8010131f:	e8 3c f0 ff ff       	call   80100360 <panic>
80101324:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010132b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010132f:	90                   	nop
        bp->data[bi/8] |= m;  // Mark block in use.
80101330:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80101334:	08 c2                	or     %al,%dl
80101336:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp);
8010133a:	89 1c 24             	mov    %ebx,(%esp)
8010133d:	e8 6e 1c 00 00       	call   80102fb0 <log_write>
        brelse(bp);
80101342:	89 1c 24             	mov    %ebx,(%esp)
80101345:	e8 a6 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010134a:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010134d:	89 74 24 04          	mov    %esi,0x4(%esp)
80101351:	89 04 24             	mov    %eax,(%esp)
80101354:	e8 77 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101359:	ba 00 02 00 00       	mov    $0x200,%edx
8010135e:	31 c9                	xor    %ecx,%ecx
80101360:	89 54 24 08          	mov    %edx,0x8(%esp)
80101364:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  bp = bread(dev, bno);
80101368:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010136a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010136d:	89 04 24             	mov    %eax,(%esp)
80101370:	e8 cb 34 00 00       	call   80104840 <memset>
  log_write(bp);
80101375:	89 1c 24             	mov    %ebx,(%esp)
80101378:	e8 33 1c 00 00       	call   80102fb0 <log_write>
  brelse(bp);
8010137d:	89 1c 24             	mov    %ebx,(%esp)
80101380:	e8 6b ee ff ff       	call   801001f0 <brelse>
}
80101385:	83 c4 2c             	add    $0x2c,%esp
80101388:	89 f0                	mov    %esi,%eax
8010138a:	5b                   	pop    %ebx
8010138b:	5e                   	pop    %esi
8010138c:	5f                   	pop    %edi
8010138d:	5d                   	pop    %ebp
8010138e:	c3                   	ret    
8010138f:	90                   	nop

80101390 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	89 d7                	mov    %edx,%edi
80101396:	56                   	push   %esi
80101397:	89 c6                	mov    %eax,%esi
80101399:	53                   	push   %ebx

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010139a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010139f:	83 ec 2c             	sub    $0x2c,%esp
  acquire(&icache.lock);
801013a2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801013a9:	e8 92 33 00 00       	call   80104740 <acquire>
  empty = 0;
801013ae:	31 c0                	xor    %eax,%eax
801013b0:	eb 20                	jmp    801013d2 <iget+0x42>
801013b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013c0:	39 33                	cmp    %esi,(%ebx)
801013c2:	74 7c                	je     80101440 <iget+0xb0>
801013c4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ca:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801013d0:	73 2e                	jae    80101400 <iget+0x70>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013d2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801013d5:	85 c9                	test   %ecx,%ecx
801013d7:	7f e7                	jg     801013c0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013d9:	85 c0                	test   %eax,%eax
801013db:	75 e7                	jne    801013c4 <iget+0x34>
801013dd:	89 da                	mov    %ebx,%edx
801013df:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013e5:	85 c9                	test   %ecx,%ecx
801013e7:	75 7a                	jne    80101463 <iget+0xd3>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013e9:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801013ef:	89 d0                	mov    %edx,%eax
801013f1:	72 df                	jb     801013d2 <iget+0x42>
801013f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101400:	85 c0                	test   %eax,%eax
80101402:	74 77                	je     8010147b <iget+0xeb>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101404:	89 30                	mov    %esi,(%eax)
  ip->inum = inum;
80101406:	89 78 04             	mov    %edi,0x4(%eax)
  ip->ref = 1;
80101409:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
80101410:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
80101417:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
  ip->valid = 0;
8010141e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  release(&icache.lock);
80101421:	e8 ca 33 00 00       	call   801047f0 <release>
80101426:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return ip;
}
80101429:	83 c4 2c             	add    $0x2c,%esp
8010142c:	5b                   	pop    %ebx
8010142d:	5e                   	pop    %esi
8010142e:	5f                   	pop    %edi
8010142f:	5d                   	pop    %ebp
80101430:	c3                   	ret    
80101431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010143f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101440:	39 7b 04             	cmp    %edi,0x4(%ebx)
80101443:	0f 85 7b ff ff ff    	jne    801013c4 <iget+0x34>
      release(&icache.lock);
80101449:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
      ip->ref++;
80101450:	41                   	inc    %ecx
80101451:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101454:	e8 97 33 00 00       	call   801047f0 <release>
}
80101459:	83 c4 2c             	add    $0x2c,%esp
      return ip;
8010145c:	89 d8                	mov    %ebx,%eax
}
8010145e:	5b                   	pop    %ebx
8010145f:	5e                   	pop    %esi
80101460:	5f                   	pop    %edi
80101461:	5d                   	pop    %ebp
80101462:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101463:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101469:	73 10                	jae    8010147b <iget+0xeb>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010146b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010146e:	85 c9                	test   %ecx,%ecx
80101470:	0f 8f 4a ff ff ff    	jg     801013c0 <iget+0x30>
80101476:	e9 62 ff ff ff       	jmp    801013dd <iget+0x4d>
    panic("iget: no inodes");
8010147b:	c7 04 24 48 74 10 80 	movl   $0x80107448,(%esp)
80101482:	e8 d9 ee ff ff       	call   80100360 <panic>
80101487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010148e:	66 90                	xchg   %ax,%ax

80101490 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	83 ec 38             	sub    $0x38,%esp
80101496:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101499:	83 fa 0b             	cmp    $0xb,%edx
{
8010149c:	89 c6                	mov    %eax,%esi
8010149e:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801014a1:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(bn < NDIRECT){
801014a4:	0f 86 96 00 00 00    	jbe    80101540 <bmap+0xb0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801014aa:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801014ad:	83 fb 7f             	cmp    $0x7f,%ebx
801014b0:	0f 87 ab 00 00 00    	ja     80101561 <bmap+0xd1>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801014b6:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801014bc:	8b 16                	mov    (%esi),%edx
801014be:	85 c0                	test   %eax,%eax
801014c0:	74 5e                	je     80101520 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801014c6:	89 14 24             	mov    %edx,(%esp)
801014c9:	e8 02 ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801014ce:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801014d2:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801014d4:	8b 03                	mov    (%ebx),%eax
801014d6:	85 c0                	test   %eax,%eax
801014d8:	74 26                	je     80101500 <bmap+0x70>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801014da:	89 3c 24             	mov    %edi,(%esp)
801014dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801014e0:	e8 0b ed ff ff       	call   801001f0 <brelse>
    return addr;
801014e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }

  panic("bmap: out of range");
}
801014e8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801014eb:	8b 75 f8             	mov    -0x8(%ebp),%esi
801014ee:	8b 7d fc             	mov    -0x4(%ebp),%edi
801014f1:	89 ec                	mov    %ebp,%esp
801014f3:	5d                   	pop    %ebp
801014f4:	c3                   	ret    
801014f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      a[bn] = addr = balloc(ip->dev);
80101500:	8b 06                	mov    (%esi),%eax
80101502:	e8 79 fd ff ff       	call   80101280 <balloc>
80101507:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101509:	89 3c 24             	mov    %edi,(%esp)
      a[bn] = addr = balloc(ip->dev);
8010150c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      log_write(bp);
8010150f:	e8 9c 1a 00 00       	call   80102fb0 <log_write>
80101514:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101517:	eb c1                	jmp    801014da <bmap+0x4a>
80101519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101520:	89 d0                	mov    %edx,%eax
80101522:	e8 59 fd ff ff       	call   80101280 <balloc>
80101527:	8b 16                	mov    (%esi),%edx
80101529:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010152f:	eb 91                	jmp    801014c2 <bmap+0x32>
80101531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010153f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101540:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80101543:	8b 47 5c             	mov    0x5c(%edi),%eax
80101546:	85 c0                	test   %eax,%eax
80101548:	75 9e                	jne    801014e8 <bmap+0x58>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010154a:	8b 06                	mov    (%esi),%eax
8010154c:	e8 2f fd ff ff       	call   80101280 <balloc>
80101551:	89 47 5c             	mov    %eax,0x5c(%edi)
}
80101554:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101557:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010155a:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010155d:	89 ec                	mov    %ebp,%esp
8010155f:	5d                   	pop    %ebp
80101560:	c3                   	ret    
  panic("bmap: out of range");
80101561:	c7 04 24 58 74 10 80 	movl   $0x80107458,(%esp)
80101568:	e8 f3 ed ff ff       	call   80100360 <panic>
8010156d:	8d 76 00             	lea    0x0(%esi),%esi

80101570 <readsb>:
{
80101570:	55                   	push   %ebp
  bp = bread(dev, 1);
80101571:	b8 01 00 00 00       	mov    $0x1,%eax
{
80101576:	89 e5                	mov    %esp,%ebp
80101578:	83 ec 18             	sub    $0x18,%esp
  bp = bread(dev, 1);
8010157b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010157f:	8b 45 08             	mov    0x8(%ebp),%eax
{
80101582:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80101585:	89 75 fc             	mov    %esi,-0x4(%ebp)
80101588:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
8010158b:	89 04 24             	mov    %eax,(%esp)
8010158e:	e8 3d eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101593:	ba 1c 00 00 00       	mov    $0x1c,%edx
80101598:	89 34 24             	mov    %esi,(%esp)
8010159b:	89 54 24 08          	mov    %edx,0x8(%esp)
  bp = bread(dev, 1);
8010159f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015a1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801015a8:	e8 53 33 00 00       	call   80104900 <memmove>
}
801015ad:	8b 75 fc             	mov    -0x4(%ebp),%esi
  brelse(bp);
801015b0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801015b3:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801015b6:	89 ec                	mov    %ebp,%esp
801015b8:	5d                   	pop    %ebp
  brelse(bp);
801015b9:	e9 32 ec ff ff       	jmp    801001f0 <brelse>
801015be:	66 90                	xchg   %ax,%ax

801015c0 <iinit>:
{
801015c0:	55                   	push   %ebp
  initlock(&icache.lock, "icache");
801015c1:	b9 6b 74 10 80       	mov    $0x8010746b,%ecx
{
801015c6:	89 e5                	mov    %esp,%ebp
801015c8:	53                   	push   %ebx
801015c9:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
801015ce:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801015d1:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801015d5:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801015dc:	e8 ef 2f 00 00       	call   801045d0 <initlock>
  for(i = 0; i < NINODE; i++) {
801015e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ef:	90                   	nop
    initsleeplock(&icache.inode[i].lock, "inode");
801015f0:	89 1c 24             	mov    %ebx,(%esp)
801015f3:	ba 72 74 10 80       	mov    $0x80107472,%edx
801015f8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015fe:	89 54 24 04          	mov    %edx,0x4(%esp)
80101602:	e8 89 2e 00 00       	call   80104490 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101607:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010160d:	75 e1                	jne    801015f0 <iinit+0x30>
  readsb(dev, &sb);
8010160f:	b8 c0 09 11 80       	mov    $0x801109c0,%eax
80101614:	89 44 24 04          	mov    %eax,0x4(%esp)
80101618:	8b 45 08             	mov    0x8(%ebp),%eax
8010161b:	89 04 24             	mov    %eax,(%esp)
8010161e:	e8 4d ff ff ff       	call   80101570 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101623:	a1 d8 09 11 80       	mov    0x801109d8,%eax
80101628:	c7 04 24 d8 74 10 80 	movl   $0x801074d8,(%esp)
8010162f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101633:	a1 d4 09 11 80       	mov    0x801109d4,%eax
80101638:	89 44 24 18          	mov    %eax,0x18(%esp)
8010163c:	a1 d0 09 11 80       	mov    0x801109d0,%eax
80101641:	89 44 24 14          	mov    %eax,0x14(%esp)
80101645:	a1 cc 09 11 80       	mov    0x801109cc,%eax
8010164a:	89 44 24 10          	mov    %eax,0x10(%esp)
8010164e:	a1 c8 09 11 80       	mov    0x801109c8,%eax
80101653:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101657:	a1 c4 09 11 80       	mov    0x801109c4,%eax
8010165c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101660:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101665:	89 44 24 04          	mov    %eax,0x4(%esp)
80101669:	e8 12 f0 ff ff       	call   80100680 <cprintf>
}
8010166e:	83 c4 24             	add    $0x24,%esp
80101671:	5b                   	pop    %ebx
80101672:	5d                   	pop    %ebp
80101673:	c3                   	ret    
80101674:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010167f:	90                   	nop

80101680 <ialloc>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	57                   	push   %edi
80101684:	56                   	push   %esi
80101685:	53                   	push   %ebx
80101686:	83 ec 2c             	sub    $0x2c,%esp
80101689:	0f bf 45 0c          	movswl 0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010168d:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101694:	8b 75 08             	mov    0x8(%ebp),%esi
80101697:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010169a:	0f 86 91 00 00 00    	jbe    80101731 <ialloc+0xb1>
801016a0:	bf 01 00 00 00       	mov    $0x1,%edi
801016a5:	eb 1a                	jmp    801016c1 <ialloc+0x41>
801016a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ae:	66 90                	xchg   %ax,%ax
    brelse(bp);
801016b0:	89 1c 24             	mov    %ebx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
801016b3:	47                   	inc    %edi
    brelse(bp);
801016b4:	e8 37 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016b9:	3b 3d c8 09 11 80    	cmp    0x801109c8,%edi
801016bf:	73 70                	jae    80101731 <ialloc+0xb1>
    bp = bread(dev, IBLOCK(inum, sb));
801016c1:	89 34 24             	mov    %esi,(%esp)
801016c4:	8b 0d d4 09 11 80    	mov    0x801109d4,%ecx
801016ca:	89 f8                	mov    %edi,%eax
801016cc:	c1 e8 03             	shr    $0x3,%eax
801016cf:	01 c8                	add    %ecx,%eax
801016d1:	89 44 24 04          	mov    %eax,0x4(%esp)
801016d5:	e8 f6 e9 ff ff       	call   801000d0 <bread>
801016da:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801016dc:	89 f8                	mov    %edi,%eax
801016de:	83 e0 07             	and    $0x7,%eax
801016e1:	c1 e0 06             	shl    $0x6,%eax
801016e4:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016e8:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016ec:	75 c2                	jne    801016b0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016ee:	89 0c 24             	mov    %ecx,(%esp)
801016f1:	31 d2                	xor    %edx,%edx
801016f3:	b8 40 00 00 00       	mov    $0x40,%eax
801016f8:	89 54 24 04          	mov    %edx,0x4(%esp)
801016fc:	89 44 24 08          	mov    %eax,0x8(%esp)
80101700:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101703:	e8 38 31 00 00       	call   80104840 <memset>
      dip->type = type;
80101708:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010170b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010170e:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101711:	89 1c 24             	mov    %ebx,(%esp)
80101714:	e8 97 18 00 00       	call   80102fb0 <log_write>
      brelse(bp);
80101719:	89 1c 24             	mov    %ebx,(%esp)
8010171c:	e8 cf ea ff ff       	call   801001f0 <brelse>
}
80101721:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
80101724:	89 f0                	mov    %esi,%eax
}
80101726:	5b                   	pop    %ebx
      return iget(dev, inum);
80101727:	89 fa                	mov    %edi,%edx
}
80101729:	5e                   	pop    %esi
8010172a:	5f                   	pop    %edi
8010172b:	5d                   	pop    %ebp
      return iget(dev, inum);
8010172c:	e9 5f fc ff ff       	jmp    80101390 <iget>
  panic("ialloc: no inodes");
80101731:	c7 04 24 78 74 10 80 	movl   $0x80107478,(%esp)
80101738:	e8 23 ec ff ff       	call   80100360 <panic>
8010173d:	8d 76 00             	lea    0x0(%esi),%esi

80101740 <iupdate>:
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	83 ec 10             	sub    $0x10,%esp
80101748:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010174b:	8b 15 d4 09 11 80    	mov    0x801109d4,%edx
80101751:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101754:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101757:	c1 e8 03             	shr    $0x3,%eax
8010175a:	01 d0                	add    %edx,%eax
8010175c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101760:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101763:	89 04 24             	mov    %eax,(%esp)
80101766:	e8 65 e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
8010176b:	0f bf 53 f4          	movswl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010176f:	b9 34 00 00 00       	mov    $0x34,%ecx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101774:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101776:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101779:	83 e0 07             	and    $0x7,%eax
8010177c:	c1 e0 06             	shl    $0x6,%eax
8010177f:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101783:	66 89 10             	mov    %dx,(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101786:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101789:	0f bf 53 f6          	movswl -0xa(%ebx),%edx
8010178d:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101791:	0f bf 53 f8          	movswl -0x8(%ebx),%edx
80101795:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101799:	0f bf 53 fa          	movswl -0x6(%ebx),%edx
8010179d:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801017a1:	8b 53 fc             	mov    -0x4(%ebx),%edx
801017a4:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017a7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801017ab:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801017af:	89 04 24             	mov    %eax,(%esp)
801017b2:	e8 49 31 00 00       	call   80104900 <memmove>
  log_write(bp);
801017b7:	89 34 24             	mov    %esi,(%esp)
801017ba:	e8 f1 17 00 00       	call   80102fb0 <log_write>
  brelse(bp);
801017bf:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017c2:	83 c4 10             	add    $0x10,%esp
801017c5:	5b                   	pop    %ebx
801017c6:	5e                   	pop    %esi
801017c7:	5d                   	pop    %ebp
  brelse(bp);
801017c8:	e9 23 ea ff ff       	jmp    801001f0 <brelse>
801017cd:	8d 76 00             	lea    0x0(%esi),%esi

801017d0 <idup>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	53                   	push   %ebx
801017d4:	83 ec 14             	sub    $0x14,%esp
  acquire(&icache.lock);
801017d7:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
{
801017de:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017e1:	e8 5a 2f 00 00       	call   80104740 <acquire>
  ip->ref++;
801017e6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801017e9:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801017f0:	e8 fb 2f 00 00       	call   801047f0 <release>
}
801017f5:	83 c4 14             	add    $0x14,%esp
801017f8:	89 d8                	mov    %ebx,%eax
801017fa:	5b                   	pop    %ebx
801017fb:	5d                   	pop    %ebp
801017fc:	c3                   	ret    
801017fd:	8d 76 00             	lea    0x0(%esi),%esi

80101800 <ilock>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	56                   	push   %esi
80101804:	53                   	push   %ebx
80101805:	83 ec 10             	sub    $0x10,%esp
80101808:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010180b:	85 db                	test   %ebx,%ebx
8010180d:	0f 84 be 00 00 00    	je     801018d1 <ilock+0xd1>
80101813:	8b 43 08             	mov    0x8(%ebx),%eax
80101816:	85 c0                	test   %eax,%eax
80101818:	0f 8e b3 00 00 00    	jle    801018d1 <ilock+0xd1>
  acquiresleep(&ip->lock);
8010181e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101821:	89 04 24             	mov    %eax,(%esp)
80101824:	e8 a7 2c 00 00       	call   801044d0 <acquiresleep>
  if(ip->valid == 0){
80101829:	8b 73 4c             	mov    0x4c(%ebx),%esi
8010182c:	85 f6                	test   %esi,%esi
8010182e:	74 10                	je     80101840 <ilock+0x40>
}
80101830:	83 c4 10             	add    $0x10,%esp
80101833:	5b                   	pop    %ebx
80101834:	5e                   	pop    %esi
80101835:	5d                   	pop    %ebp
80101836:	c3                   	ret    
80101837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010183e:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101840:	8b 43 04             	mov    0x4(%ebx),%eax
80101843:	8b 15 d4 09 11 80    	mov    0x801109d4,%edx
80101849:	c1 e8 03             	shr    $0x3,%eax
8010184c:	01 d0                	add    %edx,%eax
8010184e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101852:	8b 03                	mov    (%ebx),%eax
80101854:	89 04 24             	mov    %eax,(%esp)
80101857:	e8 74 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010185c:	b9 34 00 00 00       	mov    $0x34,%ecx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101861:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101863:	8b 43 04             	mov    0x4(%ebx),%eax
80101866:	83 e0 07             	and    $0x7,%eax
80101869:	c1 e0 06             	shl    $0x6,%eax
8010186c:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101870:	0f bf 10             	movswl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101873:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101876:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
8010187a:	0f bf 50 f6          	movswl -0xa(%eax),%edx
8010187e:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101882:	0f bf 50 f8          	movswl -0x8(%eax),%edx
80101886:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
8010188a:	0f bf 50 fa          	movswl -0x6(%eax),%edx
8010188e:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101892:	8b 50 fc             	mov    -0x4(%eax),%edx
80101895:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101898:	89 44 24 04          	mov    %eax,0x4(%esp)
8010189c:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010189f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801018a3:	89 04 24             	mov    %eax,(%esp)
801018a6:	e8 55 30 00 00       	call   80104900 <memmove>
    brelse(bp);
801018ab:	89 34 24             	mov    %esi,(%esp)
801018ae:	e8 3d e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801018b3:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801018b8:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018bf:	0f 85 6b ff ff ff    	jne    80101830 <ilock+0x30>
      panic("ilock: no type");
801018c5:	c7 04 24 90 74 10 80 	movl   $0x80107490,(%esp)
801018cc:	e8 8f ea ff ff       	call   80100360 <panic>
    panic("ilock");
801018d1:	c7 04 24 8a 74 10 80 	movl   $0x8010748a,(%esp)
801018d8:	e8 83 ea ff ff       	call   80100360 <panic>
801018dd:	8d 76 00             	lea    0x0(%esi),%esi

801018e0 <iunlock>:
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	83 ec 18             	sub    $0x18,%esp
801018e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801018e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801018ec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018ef:	85 db                	test   %ebx,%ebx
801018f1:	74 27                	je     8010191a <iunlock+0x3a>
801018f3:	8d 73 0c             	lea    0xc(%ebx),%esi
801018f6:	89 34 24             	mov    %esi,(%esp)
801018f9:	e8 72 2c 00 00       	call   80104570 <holdingsleep>
801018fe:	85 c0                	test   %eax,%eax
80101900:	74 18                	je     8010191a <iunlock+0x3a>
80101902:	8b 43 08             	mov    0x8(%ebx),%eax
80101905:	85 c0                	test   %eax,%eax
80101907:	7e 11                	jle    8010191a <iunlock+0x3a>
  releasesleep(&ip->lock);
80101909:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010190c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010190f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80101912:	89 ec                	mov    %ebp,%esp
80101914:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101915:	e9 16 2c 00 00       	jmp    80104530 <releasesleep>
    panic("iunlock");
8010191a:	c7 04 24 9f 74 10 80 	movl   $0x8010749f,(%esp)
80101921:	e8 3a ea ff ff       	call   80100360 <panic>
80101926:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010192d:	8d 76 00             	lea    0x0(%esi),%esi

80101930 <iput>:
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	83 ec 38             	sub    $0x38,%esp
80101936:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101939:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010193c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010193f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquiresleep(&ip->lock);
80101942:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101945:	89 3c 24             	mov    %edi,(%esp)
80101948:	e8 83 2b 00 00       	call   801044d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010194d:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101950:	85 d2                	test   %edx,%edx
80101952:	74 07                	je     8010195b <iput+0x2b>
80101954:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101959:	74 35                	je     80101990 <iput+0x60>
  releasesleep(&ip->lock);
8010195b:	89 3c 24             	mov    %edi,(%esp)
8010195e:	e8 cd 2b 00 00       	call   80104530 <releasesleep>
  acquire(&icache.lock);
80101963:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010196a:	e8 d1 2d 00 00       	call   80104740 <acquire>
  ip->ref--;
8010196f:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101972:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101979:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010197c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010197f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101982:	89 ec                	mov    %ebp,%esp
80101984:	5d                   	pop    %ebp
  release(&icache.lock);
80101985:	e9 66 2e 00 00       	jmp    801047f0 <release>
8010198a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101990:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101997:	e8 a4 2d 00 00       	call   80104740 <acquire>
    int r = ip->ref;
8010199c:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010199f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801019a6:	e8 45 2e 00 00       	call   801047f0 <release>
    if(r == 1){
801019ab:	4e                   	dec    %esi
801019ac:	75 ad                	jne    8010195b <iput+0x2b>
801019ae:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019b1:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801019b7:	8d 73 5c             	lea    0x5c(%ebx),%esi
801019ba:	89 cf                	mov    %ecx,%edi
801019bc:	eb 09                	jmp    801019c7 <iput+0x97>
801019be:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019c0:	83 c6 04             	add    $0x4,%esi
801019c3:	39 fe                	cmp    %edi,%esi
801019c5:	74 19                	je     801019e0 <iput+0xb0>
    if(ip->addrs[i]){
801019c7:	8b 16                	mov    (%esi),%edx
801019c9:	85 d2                	test   %edx,%edx
801019cb:	74 f3                	je     801019c0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019cd:	8b 03                	mov    (%ebx),%eax
801019cf:	e8 2c f8 ff ff       	call   80101200 <bfree>
      ip->addrs[i] = 0;
801019d4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019da:	eb e4                	jmp    801019c0 <iput+0x90>
801019dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019e0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019e6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019e9:	85 c0                	test   %eax,%eax
801019eb:	75 33                	jne    80101a20 <iput+0xf0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801019ed:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019f4:	89 1c 24             	mov    %ebx,(%esp)
801019f7:	e8 44 fd ff ff       	call   80101740 <iupdate>
      ip->type = 0;
801019fc:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
80101a02:	89 1c 24             	mov    %ebx,(%esp)
80101a05:	e8 36 fd ff ff       	call   80101740 <iupdate>
      ip->valid = 0;
80101a0a:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a11:	e9 45 ff ff ff       	jmp    8010195b <iput+0x2b>
80101a16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a1d:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a20:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a24:	8b 03                	mov    (%ebx),%eax
80101a26:	89 04 24             	mov    %eax,(%esp)
80101a29:	e8 a2 e6 ff ff       	call   801000d0 <bread>
80101a2e:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a31:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101a34:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a3a:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a3d:	89 cf                	mov    %ecx,%edi
80101a3f:	eb 16                	jmp    80101a57 <iput+0x127>
80101a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a4f:	90                   	nop
80101a50:	83 c6 04             	add    $0x4,%esi
80101a53:	39 f7                	cmp    %esi,%edi
80101a55:	74 19                	je     80101a70 <iput+0x140>
      if(a[j])
80101a57:	8b 16                	mov    (%esi),%edx
80101a59:	85 d2                	test   %edx,%edx
80101a5b:	74 f3                	je     80101a50 <iput+0x120>
        bfree(ip->dev, a[j]);
80101a5d:	8b 03                	mov    (%ebx),%eax
80101a5f:	e8 9c f7 ff ff       	call   80101200 <bfree>
80101a64:	eb ea                	jmp    80101a50 <iput+0x120>
80101a66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a6d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101a70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a73:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a76:	89 04 24             	mov    %eax,(%esp)
80101a79:	e8 72 e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a7e:	8b 03                	mov    (%ebx),%eax
80101a80:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a86:	e8 75 f7 ff ff       	call   80101200 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a8b:	31 c0                	xor    %eax,%eax
80101a8d:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101a93:	e9 55 ff ff ff       	jmp    801019ed <iput+0xbd>
80101a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a9f:	90                   	nop

80101aa0 <iunlockput>:
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	53                   	push   %ebx
80101aa4:	83 ec 14             	sub    $0x14,%esp
80101aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101aaa:	89 1c 24             	mov    %ebx,(%esp)
80101aad:	e8 2e fe ff ff       	call   801018e0 <iunlock>
  iput(ip);
80101ab2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101ab5:	83 c4 14             	add    $0x14,%esp
80101ab8:	5b                   	pop    %ebx
80101ab9:	5d                   	pop    %ebp
  iput(ip);
80101aba:	e9 71 fe ff ff       	jmp    80101930 <iput>
80101abf:	90                   	nop

80101ac0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ac0:	55                   	push   %ebp
80101ac1:	89 e5                	mov    %esp,%ebp
80101ac3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ac9:	8b 0a                	mov    (%edx),%ecx
80101acb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101ace:	8b 4a 04             	mov    0x4(%edx),%ecx
80101ad1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101ad4:	0f bf 4a 50          	movswl 0x50(%edx),%ecx
80101ad8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101adb:	0f bf 4a 56          	movswl 0x56(%edx),%ecx
80101adf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ae3:	8b 52 58             	mov    0x58(%edx),%edx
80101ae6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ae9:	5d                   	pop    %ebp
80101aea:	c3                   	ret    
80101aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aef:	90                   	nop

80101af0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	57                   	push   %edi
80101af4:	56                   	push   %esi
80101af5:	53                   	push   %ebx
80101af6:	83 ec 2c             	sub    $0x2c,%esp
80101af9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101afc:	8b 7d 08             	mov    0x8(%ebp),%edi
80101aff:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101b02:	8b 45 10             	mov    0x10(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b05:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101b0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b0d:	8b 45 14             	mov    0x14(%ebp),%eax
80101b10:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b13:	0f 84 c7 00 00 00    	je     80101be0 <readi+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b19:	8b 47 58             	mov    0x58(%edi),%eax
80101b1c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101b1f:	39 c1                	cmp    %eax,%ecx
80101b21:	0f 87 dd 00 00 00    	ja     80101c04 <readi+0x114>
80101b27:	89 ca                	mov    %ecx,%edx
80101b29:	31 f6                	xor    %esi,%esi
80101b2b:	03 55 e0             	add    -0x20(%ebp),%edx
80101b2e:	0f 82 d7 00 00 00    	jb     80101c0b <readi+0x11b>
80101b34:	85 f6                	test   %esi,%esi
80101b36:	0f 85 c8 00 00 00    	jne    80101c04 <readi+0x114>
    return -1;
  if(off + n > ip->size)
80101b3c:	39 d0                	cmp    %edx,%eax
80101b3e:	0f 82 8c 00 00 00    	jb     80101bd0 <readi+0xe0>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b44:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b47:	85 c0                	test   %eax,%eax
80101b49:	74 71                	je     80101bbc <readi+0xcc>
80101b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b4f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b50:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b53:	89 f8                	mov    %edi,%eax
80101b55:	89 da                	mov    %ebx,%edx
80101b57:	c1 ea 09             	shr    $0x9,%edx
80101b5a:	e8 31 f9 ff ff       	call   80101490 <bmap>
80101b5f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b63:	8b 07                	mov    (%edi),%eax
80101b65:	89 04 24             	mov    %eax,(%esp)
80101b68:	e8 63 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b6d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b72:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b75:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b77:	89 d8                	mov    %ebx,%eax
80101b79:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b7c:	89 55 d8             	mov    %edx,-0x28(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7f:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b84:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b86:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b8e:	29 f3                	sub    %esi,%ebx
80101b90:	39 d9                	cmp    %ebx,%ecx
80101b92:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b95:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101b98:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b9c:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b9e:	89 0c 24             	mov    %ecx,(%esp)
80101ba1:	e8 5a 2d 00 00       	call   80104900 <memmove>
    brelse(bp);
80101ba6:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101ba9:	89 14 24             	mov    %edx,(%esp)
80101bac:	e8 3f e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bb1:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bb4:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bb7:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101bba:	77 94                	ja     80101b50 <readi+0x60>
  }
  return n;
80101bbc:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101bbf:	83 c4 2c             	add    $0x2c,%esp
80101bc2:	5b                   	pop    %ebx
80101bc3:	5e                   	pop    %esi
80101bc4:	5f                   	pop    %edi
80101bc5:	5d                   	pop    %ebp
80101bc6:	c3                   	ret    
80101bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bce:	66 90                	xchg   %ax,%ax
    n = ip->size - off;
80101bd0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101bd3:	29 d0                	sub    %edx,%eax
80101bd5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101bd8:	e9 67 ff ff ff       	jmp    80101b44 <readi+0x54>
80101bdd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101be0:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101be4:	66 83 f8 09          	cmp    $0x9,%ax
80101be8:	77 1a                	ja     80101c04 <readi+0x114>
80101bea:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101bf1:	85 c0                	test   %eax,%eax
80101bf3:	74 0f                	je     80101c04 <readi+0x114>
    return devsw[ip->major].read(ip, dst, n);
80101bf5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bf8:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101bfb:	83 c4 2c             	add    $0x2c,%esp
80101bfe:	5b                   	pop    %ebx
80101bff:	5e                   	pop    %esi
80101c00:	5f                   	pop    %edi
80101c01:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c02:	ff e0                	jmp    *%eax
      return -1;
80101c04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c09:	eb b4                	jmp    80101bbf <readi+0xcf>
80101c0b:	be 01 00 00 00       	mov    $0x1,%esi
80101c10:	e9 1f ff ff ff       	jmp    80101b34 <readi+0x44>
80101c15:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c20 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	53                   	push   %ebx
80101c26:	83 ec 2c             	sub    $0x2c,%esp
80101c29:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c2c:	8b 7d 08             	mov    0x8(%ebp),%edi
80101c2f:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c32:	8b 45 10             	mov    0x10(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c35:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
80101c3a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c3d:	8b 45 14             	mov    0x14(%ebp),%eax
80101c40:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(ip->type == T_DEV){
80101c43:	0f 84 d7 00 00 00    	je     80101d20 <writei+0x100>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c49:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101c4c:	39 77 58             	cmp    %esi,0x58(%edi)
80101c4f:	0f 82 0b 01 00 00    	jb     80101d60 <writei+0x140>
80101c55:	31 c0                	xor    %eax,%eax
80101c57:	03 75 dc             	add    -0x24(%ebp),%esi
80101c5a:	89 f2                	mov    %esi,%edx
80101c5c:	0f 82 05 01 00 00    	jb     80101d67 <writei+0x147>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c62:	85 c0                	test   %eax,%eax
80101c64:	0f 85 f6 00 00 00    	jne    80101d60 <writei+0x140>
80101c6a:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101c70:	0f 87 ea 00 00 00    	ja     80101d60 <writei+0x140>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c76:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c7d:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101c80:	85 c9                	test   %ecx,%ecx
80101c82:	0f 84 85 00 00 00    	je     80101d0d <writei+0xed>
80101c88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c8f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c90:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c93:	89 f8                	mov    %edi,%eax
80101c95:	89 da                	mov    %ebx,%edx
80101c97:	c1 ea 09             	shr    $0x9,%edx
80101c9a:	e8 f1 f7 ff ff       	call   80101490 <bmap>
80101c9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ca3:	8b 07                	mov    (%edi),%eax
80101ca5:	89 04 24             	mov    %eax,(%esp)
80101ca8:	e8 23 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101cad:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101cb0:	b9 00 02 00 00       	mov    $0x200,%ecx
80101cb5:	89 5d e0             	mov    %ebx,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cb8:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101cba:	89 d8                	mov    %ebx,%eax
80101cbc:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101cbf:	25 ff 01 00 00       	and    $0x1ff,%eax
80101cc4:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101cc6:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101cca:	89 04 24             	mov    %eax,(%esp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ccd:	29 d3                	sub    %edx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ccf:	8b 55 d8             	mov    -0x28(%ebp),%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101cd2:	39 d9                	cmp    %ebx,%ecx
80101cd4:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101cd7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101cdb:	89 54 24 04          	mov    %edx,0x4(%esp)
80101cdf:	e8 1c 2c 00 00       	call   80104900 <memmove>
    log_write(bp);
80101ce4:	89 34 24             	mov    %esi,(%esp)
80101ce7:	e8 c4 12 00 00       	call   80102fb0 <log_write>
    brelse(bp);
80101cec:	89 34 24             	mov    %esi,(%esp)
80101cef:	e8 fc e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cf4:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101cf7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101cfa:	01 5d d8             	add    %ebx,-0x28(%ebp)
80101cfd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d00:	39 4d dc             	cmp    %ecx,-0x24(%ebp)
80101d03:	77 8b                	ja     80101c90 <writei+0x70>
  }

  if(n > 0 && off > ip->size){
80101d05:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d08:	3b 47 58             	cmp    0x58(%edi),%eax
80101d0b:	77 43                	ja     80101d50 <writei+0x130>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d0d:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101d10:	83 c4 2c             	add    $0x2c,%esp
80101d13:	5b                   	pop    %ebx
80101d14:	5e                   	pop    %esi
80101d15:	5f                   	pop    %edi
80101d16:	5d                   	pop    %ebp
80101d17:	c3                   	ret    
80101d18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d1f:	90                   	nop
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d20:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101d24:	66 83 f8 09          	cmp    $0x9,%ax
80101d28:	77 36                	ja     80101d60 <writei+0x140>
80101d2a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101d31:	85 c0                	test   %eax,%eax
80101d33:	74 2b                	je     80101d60 <writei+0x140>
    return devsw[ip->major].write(ip, src, n);
80101d35:	8b 7d dc             	mov    -0x24(%ebp),%edi
80101d38:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101d3b:	83 c4 2c             	add    $0x2c,%esp
80101d3e:	5b                   	pop    %ebx
80101d3f:	5e                   	pop    %esi
80101d40:	5f                   	pop    %edi
80101d41:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d42:	ff e0                	jmp    *%eax
80101d44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d4f:	90                   	nop
    ip->size = off;
80101d50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d53:	89 47 58             	mov    %eax,0x58(%edi)
    iupdate(ip);
80101d56:	89 3c 24             	mov    %edi,(%esp)
80101d59:	e8 e2 f9 ff ff       	call   80101740 <iupdate>
80101d5e:	eb ad                	jmp    80101d0d <writei+0xed>
      return -1;
80101d60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d65:	eb a9                	jmp    80101d10 <writei+0xf0>
80101d67:	b8 01 00 00 00       	mov    $0x1,%eax
80101d6c:	e9 f1 fe ff ff       	jmp    80101c62 <writei+0x42>
80101d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d7f:	90                   	nop

80101d80 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d80:	55                   	push   %ebp
  return strncmp(s, t, DIRSIZ);
80101d81:	b8 0e 00 00 00       	mov    $0xe,%eax
{
80101d86:	89 e5                	mov    %esp,%ebp
80101d88:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101d8b:	89 44 24 08          	mov    %eax,0x8(%esp)
80101d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d92:	89 44 24 04          	mov    %eax,0x4(%esp)
80101d96:	8b 45 08             	mov    0x8(%ebp),%eax
80101d99:	89 04 24             	mov    %eax,(%esp)
80101d9c:	e8 cf 2b 00 00       	call   80104970 <strncmp>
}
80101da1:	c9                   	leave  
80101da2:	c3                   	ret    
80101da3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101db0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	83 ec 2c             	sub    $0x2c,%esp
80101db9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101dbc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101dc1:	0f 85 a4 00 00 00    	jne    80101e6b <dirlookup+0xbb>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101dc7:	8b 43 58             	mov    0x58(%ebx),%eax
80101dca:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dcd:	31 ff                	xor    %edi,%edi
80101dcf:	85 c0                	test   %eax,%eax
80101dd1:	74 59                	je     80101e2c <dirlookup+0x7c>
80101dd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101de0:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101de4:	b9 10 00 00 00       	mov    $0x10,%ecx
80101de9:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101ded:	89 74 24 04          	mov    %esi,0x4(%esp)
80101df1:	89 1c 24             	mov    %ebx,(%esp)
80101df4:	e8 f7 fc ff ff       	call   80101af0 <readi>
80101df9:	83 f8 10             	cmp    $0x10,%eax
80101dfc:	75 61                	jne    80101e5f <dirlookup+0xaf>
      panic("dirlookup read");
    if(de.inum == 0)
80101dfe:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e03:	74 1f                	je     80101e24 <dirlookup+0x74>
  return strncmp(s, t, DIRSIZ);
80101e05:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e08:	ba 0e 00 00 00       	mov    $0xe,%edx
80101e0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e11:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e14:	89 54 24 08          	mov    %edx,0x8(%esp)
80101e18:	89 04 24             	mov    %eax,(%esp)
80101e1b:	e8 50 2b 00 00       	call   80104970 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e20:	85 c0                	test   %eax,%eax
80101e22:	74 1c                	je     80101e40 <dirlookup+0x90>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e24:	83 c7 10             	add    $0x10,%edi
80101e27:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e2a:	72 b4                	jb     80101de0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e2c:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101e2f:	31 c0                	xor    %eax,%eax
}
80101e31:	5b                   	pop    %ebx
80101e32:	5e                   	pop    %esi
80101e33:	5f                   	pop    %edi
80101e34:	5d                   	pop    %ebp
80101e35:	c3                   	ret    
80101e36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e3d:	8d 76 00             	lea    0x0(%esi),%esi
      if(poff)
80101e40:	8b 45 10             	mov    0x10(%ebp),%eax
80101e43:	85 c0                	test   %eax,%eax
80101e45:	74 05                	je     80101e4c <dirlookup+0x9c>
        *poff = off;
80101e47:	8b 45 10             	mov    0x10(%ebp),%eax
80101e4a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e4c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e50:	8b 03                	mov    (%ebx),%eax
80101e52:	e8 39 f5 ff ff       	call   80101390 <iget>
}
80101e57:	83 c4 2c             	add    $0x2c,%esp
80101e5a:	5b                   	pop    %ebx
80101e5b:	5e                   	pop    %esi
80101e5c:	5f                   	pop    %edi
80101e5d:	5d                   	pop    %ebp
80101e5e:	c3                   	ret    
      panic("dirlookup read");
80101e5f:	c7 04 24 b9 74 10 80 	movl   $0x801074b9,(%esp)
80101e66:	e8 f5 e4 ff ff       	call   80100360 <panic>
    panic("dirlookup not DIR");
80101e6b:	c7 04 24 a7 74 10 80 	movl   $0x801074a7,(%esp)
80101e72:	e8 e9 e4 ff ff       	call   80100360 <panic>
80101e77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e7e:	66 90                	xchg   %ax,%ax

80101e80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e80:	55                   	push   %ebp
80101e81:	89 e5                	mov    %esp,%ebp
80101e83:	57                   	push   %edi
80101e84:	56                   	push   %esi
80101e85:	53                   	push   %ebx
80101e86:	89 c3                	mov    %eax,%ebx
80101e88:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e8b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e8e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101e91:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101e94:	0f 84 66 01 00 00    	je     80102000 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e9a:	e8 81 1b 00 00       	call   80103a20 <myproc>
80101e9f:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ea2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101ea9:	e8 92 28 00 00       	call   80104740 <acquire>
  ip->ref++;
80101eae:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101eb1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101eb8:	e8 33 29 00 00       	call   801047f0 <release>
  return ip;
80101ebd:	89 df                	mov    %ebx,%edi
80101ebf:	eb 10                	jmp    80101ed1 <namex+0x51>
80101ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ec8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ecf:	90                   	nop
    path++;
80101ed0:	47                   	inc    %edi
  while(*path == '/')
80101ed1:	0f b6 07             	movzbl (%edi),%eax
80101ed4:	3c 2f                	cmp    $0x2f,%al
80101ed6:	74 f8                	je     80101ed0 <namex+0x50>
  if(*path == 0)
80101ed8:	84 c0                	test   %al,%al
80101eda:	0f 84 f0 00 00 00    	je     80101fd0 <namex+0x150>
  while(*path != '/' && *path != 0)
80101ee0:	0f b6 07             	movzbl (%edi),%eax
80101ee3:	84 c0                	test   %al,%al
80101ee5:	0f 84 05 01 00 00    	je     80101ff0 <namex+0x170>
80101eeb:	3c 2f                	cmp    $0x2f,%al
80101eed:	89 fb                	mov    %edi,%ebx
80101eef:	0f 84 fb 00 00 00    	je     80101ff0 <namex+0x170>
80101ef5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f00:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80101f04:	43                   	inc    %ebx
  while(*path != '/' && *path != 0)
80101f05:	3c 2f                	cmp    $0x2f,%al
80101f07:	74 04                	je     80101f0d <namex+0x8d>
80101f09:	84 c0                	test   %al,%al
80101f0b:	75 f3                	jne    80101f00 <namex+0x80>
  len = path - s;
80101f0d:	89 d8                	mov    %ebx,%eax
80101f0f:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80101f11:	83 f8 0d             	cmp    $0xd,%eax
80101f14:	0f 8e 86 00 00 00    	jle    80101fa0 <namex+0x120>
    memmove(name, s, DIRSIZ);
80101f1a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101f1e:	b8 0e 00 00 00       	mov    $0xe,%eax
    path++;
80101f23:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80101f25:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f29:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f2c:	89 04 24             	mov    %eax,(%esp)
80101f2f:	e8 cc 29 00 00       	call   80104900 <memmove>
  while(*path == '/')
80101f34:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f37:	75 0d                	jne    80101f46 <namex+0xc6>
80101f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f40:	47                   	inc    %edi
  while(*path == '/')
80101f41:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f44:	74 fa                	je     80101f40 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f46:	89 34 24             	mov    %esi,(%esp)
80101f49:	e8 b2 f8 ff ff       	call   80101800 <ilock>
    if(ip->type != T_DIR){
80101f4e:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f53:	0f 85 c7 00 00 00    	jne    80102020 <namex+0x1a0>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f59:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101f5c:	85 db                	test   %ebx,%ebx
80101f5e:	74 09                	je     80101f69 <namex+0xe9>
80101f60:	80 3f 00             	cmpb   $0x0,(%edi)
80101f63:	0f 84 f7 00 00 00    	je     80102060 <namex+0x1e0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f69:	89 34 24             	mov    %esi,(%esp)
80101f6c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f6f:	31 c9                	xor    %ecx,%ecx
80101f71:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101f75:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f79:	e8 32 fe ff ff       	call   80101db0 <dirlookup>
  iunlock(ip);
80101f7e:	89 34 24             	mov    %esi,(%esp)
    if((next = dirlookup(ip, name, 0)) == 0){
80101f81:	85 c0                	test   %eax,%eax
80101f83:	89 c3                	mov    %eax,%ebx
80101f85:	0f 84 b5 00 00 00    	je     80102040 <namex+0x1c0>
  iunlock(ip);
80101f8b:	e8 50 f9 ff ff       	call   801018e0 <iunlock>
  iput(ip);
80101f90:	89 34 24             	mov    %esi,(%esp)
80101f93:	89 de                	mov    %ebx,%esi
80101f95:	e8 96 f9 ff ff       	call   80101930 <iput>
  while(*path == '/')
80101f9a:	e9 32 ff ff ff       	jmp    80101ed1 <namex+0x51>
80101f9f:	90                   	nop
80101fa0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101fa3:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101fa6:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80101fa9:	89 44 24 08          	mov    %eax,0x8(%esp)
80101fad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101fb0:	89 7c 24 04          	mov    %edi,0x4(%esp)
    name[len] = 0;
80101fb4:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80101fb6:	89 04 24             	mov    %eax,(%esp)
80101fb9:	e8 42 29 00 00       	call   80104900 <memmove>
    name[len] = 0;
80101fbe:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101fc1:	c6 00 00             	movb   $0x0,(%eax)
80101fc4:	e9 6b ff ff ff       	jmp    80101f34 <namex+0xb4>
80101fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101fd0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101fd3:	85 d2                	test   %edx,%edx
80101fd5:	0f 85 a5 00 00 00    	jne    80102080 <namex+0x200>
    iput(ip);
    return 0;
  }
  return ip;
}
80101fdb:	83 c4 2c             	add    $0x2c,%esp
80101fde:	89 f0                	mov    %esi,%eax
80101fe0:	5b                   	pop    %ebx
80101fe1:	5e                   	pop    %esi
80101fe2:	5f                   	pop    %edi
80101fe3:	5d                   	pop    %ebp
80101fe4:	c3                   	ret    
80101fe5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101ff0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ff3:	89 fb                	mov    %edi,%ebx
80101ff5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101ff8:	31 c0                	xor    %eax,%eax
80101ffa:	eb ad                	jmp    80101fa9 <namex+0x129>
80101ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = iget(ROOTDEV, ROOTINO);
80102000:	ba 01 00 00 00       	mov    $0x1,%edx
80102005:	b8 01 00 00 00       	mov    $0x1,%eax
8010200a:	e8 81 f3 ff ff       	call   80101390 <iget>
8010200f:	89 c6                	mov    %eax,%esi
80102011:	e9 a7 fe ff ff       	jmp    80101ebd <namex+0x3d>
80102016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010201d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlock(ip);
80102020:	89 34 24             	mov    %esi,(%esp)
80102023:	e8 b8 f8 ff ff       	call   801018e0 <iunlock>
  iput(ip);
80102028:	89 34 24             	mov    %esi,(%esp)
      return 0;
8010202b:	31 f6                	xor    %esi,%esi
  iput(ip);
8010202d:	e8 fe f8 ff ff       	call   80101930 <iput>
}
80102032:	83 c4 2c             	add    $0x2c,%esp
80102035:	89 f0                	mov    %esi,%eax
80102037:	5b                   	pop    %ebx
80102038:	5e                   	pop    %esi
80102039:	5f                   	pop    %edi
8010203a:	5d                   	pop    %ebp
8010203b:	c3                   	ret    
8010203c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102040:	e8 9b f8 ff ff       	call   801018e0 <iunlock>
  iput(ip);
80102045:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102048:	31 f6                	xor    %esi,%esi
  iput(ip);
8010204a:	e8 e1 f8 ff ff       	call   80101930 <iput>
}
8010204f:	83 c4 2c             	add    $0x2c,%esp
80102052:	89 f0                	mov    %esi,%eax
80102054:	5b                   	pop    %ebx
80102055:	5e                   	pop    %esi
80102056:	5f                   	pop    %edi
80102057:	5d                   	pop    %ebp
80102058:	c3                   	ret    
80102059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      iunlock(ip);
80102060:	89 34 24             	mov    %esi,(%esp)
80102063:	e8 78 f8 ff ff       	call   801018e0 <iunlock>
}
80102068:	83 c4 2c             	add    $0x2c,%esp
8010206b:	89 f0                	mov    %esi,%eax
8010206d:	5b                   	pop    %ebx
8010206e:	5e                   	pop    %esi
8010206f:	5f                   	pop    %edi
80102070:	5d                   	pop    %ebp
80102071:	c3                   	ret    
80102072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iput(ip);
80102080:	89 34 24             	mov    %esi,(%esp)
    return 0;
80102083:	31 f6                	xor    %esi,%esi
    iput(ip);
80102085:	e8 a6 f8 ff ff       	call   80101930 <iput>
    return 0;
8010208a:	e9 4c ff ff ff       	jmp    80101fdb <namex+0x15b>
8010208f:	90                   	nop

80102090 <dirlink>:
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102096:	31 db                	xor    %ebx,%ebx
{
80102098:	83 ec 2c             	sub    $0x2c,%esp
  if((ip = dirlookup(dp, name, 0)) != 0){
8010209b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
{
8010209f:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((ip = dirlookup(dp, name, 0)) != 0){
801020a2:	8b 45 0c             	mov    0xc(%ebp),%eax
801020a5:	89 3c 24             	mov    %edi,(%esp)
801020a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801020ac:	e8 ff fc ff ff       	call   80101db0 <dirlookup>
801020b1:	85 c0                	test   %eax,%eax
801020b3:	0f 85 8e 00 00 00    	jne    80102147 <dirlink+0xb7>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020b9:	8b 5f 58             	mov    0x58(%edi),%ebx
801020bc:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020bf:	85 db                	test   %ebx,%ebx
801020c1:	74 3a                	je     801020fd <dirlink+0x6d>
801020c3:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020c6:	31 db                	xor    %ebx,%ebx
801020c8:	eb 0e                	jmp    801020d8 <dirlink+0x48>
801020ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020d0:	83 c3 10             	add    $0x10,%ebx
801020d3:	3b 5f 58             	cmp    0x58(%edi),%ebx
801020d6:	73 25                	jae    801020fd <dirlink+0x6d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020d8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801020dc:	b9 10 00 00 00       	mov    $0x10,%ecx
801020e1:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801020e5:	89 74 24 04          	mov    %esi,0x4(%esp)
801020e9:	89 3c 24             	mov    %edi,(%esp)
801020ec:	e8 ff f9 ff ff       	call   80101af0 <readi>
801020f1:	83 f8 10             	cmp    $0x10,%eax
801020f4:	75 60                	jne    80102156 <dirlink+0xc6>
    if(de.inum == 0)
801020f6:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020fb:	75 d3                	jne    801020d0 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
801020fd:	b8 0e 00 00 00       	mov    $0xe,%eax
80102102:	89 44 24 08          	mov    %eax,0x8(%esp)
80102106:	8b 45 0c             	mov    0xc(%ebp),%eax
80102109:	89 44 24 04          	mov    %eax,0x4(%esp)
8010210d:	8d 45 da             	lea    -0x26(%ebp),%eax
80102110:	89 04 24             	mov    %eax,(%esp)
80102113:	e8 a8 28 00 00       	call   801049c0 <strncpy>
  de.inum = inum;
80102118:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010211b:	ba 10 00 00 00       	mov    $0x10,%edx
80102120:	89 54 24 0c          	mov    %edx,0xc(%esp)
80102124:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102128:	89 74 24 04          	mov    %esi,0x4(%esp)
8010212c:	89 3c 24             	mov    %edi,(%esp)
  de.inum = inum;
8010212f:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102133:	e8 e8 fa ff ff       	call   80101c20 <writei>
80102138:	83 f8 10             	cmp    $0x10,%eax
8010213b:	75 25                	jne    80102162 <dirlink+0xd2>
  return 0;
8010213d:	31 c0                	xor    %eax,%eax
}
8010213f:	83 c4 2c             	add    $0x2c,%esp
80102142:	5b                   	pop    %ebx
80102143:	5e                   	pop    %esi
80102144:	5f                   	pop    %edi
80102145:	5d                   	pop    %ebp
80102146:	c3                   	ret    
    iput(ip);
80102147:	89 04 24             	mov    %eax,(%esp)
8010214a:	e8 e1 f7 ff ff       	call   80101930 <iput>
    return -1;
8010214f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102154:	eb e9                	jmp    8010213f <dirlink+0xaf>
      panic("dirlink read");
80102156:	c7 04 24 c8 74 10 80 	movl   $0x801074c8,(%esp)
8010215d:	e8 fe e1 ff ff       	call   80100360 <panic>
    panic("dirlink");
80102162:	c7 04 24 a2 7a 10 80 	movl   $0x80107aa2,(%esp)
80102169:	e8 f2 e1 ff ff       	call   80100360 <panic>
8010216e:	66 90                	xchg   %ax,%ax

80102170 <namei>:

struct inode*
namei(char *path)
{
80102170:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102171:	31 d2                	xor    %edx,%edx
{
80102173:	89 e5                	mov    %esp,%ebp
80102175:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102178:	8b 45 08             	mov    0x8(%ebp),%eax
8010217b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010217e:	e8 fd fc ff ff       	call   80101e80 <namex>
}
80102183:	c9                   	leave  
80102184:	c3                   	ret    
80102185:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010218c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102190 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102190:	55                   	push   %ebp
  return namex(path, 1, name);
80102191:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102196:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102198:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010219b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010219e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010219f:	e9 dc fc ff ff       	jmp    80101e80 <namex>
801021a4:	66 90                	xchg   %ax,%ax
801021a6:	66 90                	xchg   %ax,%ax
801021a8:	66 90                	xchg   %ax,%ax
801021aa:	66 90                	xchg   %ax,%ax
801021ac:	66 90                	xchg   %ax,%ax
801021ae:	66 90                	xchg   %ax,%ax

801021b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801021b0:	55                   	push   %ebp
801021b1:	89 e5                	mov    %esp,%ebp
801021b3:	56                   	push   %esi
801021b4:	53                   	push   %ebx
801021b5:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
801021b8:	85 c0                	test   %eax,%eax
801021ba:	0f 84 a8 00 00 00    	je     80102268 <idestart+0xb8>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801021c0:	8b 48 08             	mov    0x8(%eax),%ecx
801021c3:	89 c6                	mov    %eax,%esi
801021c5:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
801021cb:	0f 87 8b 00 00 00    	ja     8010225c <idestart+0xac>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021d1:	bb f7 01 00 00       	mov    $0x1f7,%ebx
801021d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021dd:	8d 76 00             	lea    0x0(%esi),%esi
801021e0:	89 da                	mov    %ebx,%edx
801021e2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021e3:	24 c0                	and    $0xc0,%al
801021e5:	3c 40                	cmp    $0x40,%al
801021e7:	75 f7                	jne    801021e0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021e9:	ba f6 03 00 00       	mov    $0x3f6,%edx
801021ee:	31 c0                	xor    %eax,%eax
801021f0:	ee                   	out    %al,(%dx)
801021f1:	b0 01                	mov    $0x1,%al
801021f3:	ba f2 01 00 00       	mov    $0x1f2,%edx
801021f8:	ee                   	out    %al,(%dx)
801021f9:	ba f3 01 00 00       	mov    $0x1f3,%edx
801021fe:	88 c8                	mov    %cl,%al
80102200:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102201:	c1 f9 08             	sar    $0x8,%ecx
80102204:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102209:	89 c8                	mov    %ecx,%eax
8010220b:	ee                   	out    %al,(%dx)
8010220c:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102211:	31 c0                	xor    %eax,%eax
80102213:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102214:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80102218:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010221d:	c0 e0 04             	shl    $0x4,%al
80102220:	24 10                	and    $0x10,%al
80102222:	0c e0                	or     $0xe0,%al
80102224:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102225:	f6 06 04             	testb  $0x4,(%esi)
80102228:	75 16                	jne    80102240 <idestart+0x90>
8010222a:	b0 20                	mov    $0x20,%al
8010222c:	89 da                	mov    %ebx,%edx
8010222e:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010222f:	83 c4 10             	add    $0x10,%esp
80102232:	5b                   	pop    %ebx
80102233:	5e                   	pop    %esi
80102234:	5d                   	pop    %ebp
80102235:	c3                   	ret    
80102236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010223d:	8d 76 00             	lea    0x0(%esi),%esi
80102240:	b0 30                	mov    $0x30,%al
80102242:	89 da                	mov    %ebx,%edx
80102244:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102245:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
8010224a:	83 c6 5c             	add    $0x5c,%esi
8010224d:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102252:	fc                   	cld    
80102253:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102255:	83 c4 10             	add    $0x10,%esp
80102258:	5b                   	pop    %ebx
80102259:	5e                   	pop    %esi
8010225a:	5d                   	pop    %ebp
8010225b:	c3                   	ret    
    panic("incorrect blockno");
8010225c:	c7 04 24 34 75 10 80 	movl   $0x80107534,(%esp)
80102263:	e8 f8 e0 ff ff       	call   80100360 <panic>
    panic("idestart");
80102268:	c7 04 24 2b 75 10 80 	movl   $0x8010752b,(%esp)
8010226f:	e8 ec e0 ff ff       	call   80100360 <panic>
80102274:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010227f:	90                   	nop

80102280 <ideinit>:
{
80102280:	55                   	push   %ebp
  initlock(&idelock, "ide");
80102281:	ba 46 75 10 80       	mov    $0x80107546,%edx
{
80102286:	89 e5                	mov    %esp,%ebp
80102288:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
8010228b:	89 54 24 04          	mov    %edx,0x4(%esp)
8010228f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102296:	e8 35 23 00 00       	call   801045d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010229b:	a1 00 2d 11 80       	mov    0x80112d00,%eax
801022a0:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801022a7:	48                   	dec    %eax
801022a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801022ac:	e8 8f 02 00 00       	call   80102540 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022b1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022bd:	8d 76 00             	lea    0x0(%esi),%esi
801022c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022c1:	24 c0                	and    $0xc0,%al
801022c3:	3c 40                	cmp    $0x40,%al
801022c5:	75 f9                	jne    801022c0 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022c7:	b0 f0                	mov    $0xf0,%al
801022c9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022ce:	ee                   	out    %al,(%dx)
801022cf:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022d4:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022d9:	eb 08                	jmp    801022e3 <ideinit+0x63>
801022db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022df:	90                   	nop
  for(i=0; i<1000; i++){
801022e0:	49                   	dec    %ecx
801022e1:	74 0f                	je     801022f2 <ideinit+0x72>
801022e3:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801022e4:	84 c0                	test   %al,%al
801022e6:	74 f8                	je     801022e0 <ideinit+0x60>
      havedisk1 = 1;
801022e8:	b8 01 00 00 00       	mov    $0x1,%eax
801022ed:	a3 60 a5 10 80       	mov    %eax,0x8010a560
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022f2:	b0 e0                	mov    $0xe0,%al
801022f4:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022f9:	ee                   	out    %al,(%dx)
}
801022fa:	c9                   	leave  
801022fb:	c3                   	ret    
801022fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102300 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	57                   	push   %edi
80102304:	56                   	push   %esi
80102305:	53                   	push   %ebx
80102306:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102309:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102310:	e8 2b 24 00 00       	call   80104740 <acquire>

  if((b = idequeue) == 0){
80102315:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
8010231b:	85 db                	test   %ebx,%ebx
8010231d:	74 60                	je     8010237f <ideintr+0x7f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010231f:	8b 43 58             	mov    0x58(%ebx),%eax
80102322:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102327:	8b 33                	mov    (%ebx),%esi
80102329:	f7 c6 04 00 00 00    	test   $0x4,%esi
8010232f:	75 30                	jne    80102361 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102331:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010233d:	8d 76 00             	lea    0x0(%esi),%esi
80102340:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102341:	88 c1                	mov    %al,%cl
80102343:	80 e1 c0             	and    $0xc0,%cl
80102346:	80 f9 40             	cmp    $0x40,%cl
80102349:	75 f5                	jne    80102340 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010234b:	a8 21                	test   $0x21,%al
8010234d:	75 12                	jne    80102361 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010234f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102352:	b9 80 00 00 00       	mov    $0x80,%ecx
80102357:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010235c:	fc                   	cld    
8010235d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010235f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102361:	83 e6 fb             	and    $0xfffffffb,%esi
80102364:	83 ce 02             	or     $0x2,%esi
80102367:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102369:	89 1c 24             	mov    %ebx,(%esp)
8010236c:	e8 5f 1f 00 00       	call   801042d0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102371:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102376:	85 c0                	test   %eax,%eax
80102378:	74 05                	je     8010237f <ideintr+0x7f>
    idestart(idequeue);
8010237a:	e8 31 fe ff ff       	call   801021b0 <idestart>
    release(&idelock);
8010237f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102386:	e8 65 24 00 00       	call   801047f0 <release>

  release(&idelock);
}
8010238b:	83 c4 1c             	add    $0x1c,%esp
8010238e:	5b                   	pop    %ebx
8010238f:	5e                   	pop    %esi
80102390:	5f                   	pop    %edi
80102391:	5d                   	pop    %ebp
80102392:	c3                   	ret    
80102393:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010239a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023a0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	53                   	push   %ebx
801023a4:	83 ec 14             	sub    $0x14,%esp
801023a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801023aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801023ad:	89 04 24             	mov    %eax,(%esp)
801023b0:	e8 bb 21 00 00       	call   80104570 <holdingsleep>
801023b5:	85 c0                	test   %eax,%eax
801023b7:	0f 84 c2 00 00 00    	je     8010247f <iderw+0xdf>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801023bd:	8b 03                	mov    (%ebx),%eax
801023bf:	83 e0 06             	and    $0x6,%eax
801023c2:	83 f8 02             	cmp    $0x2,%eax
801023c5:	0f 84 a8 00 00 00    	je     80102473 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801023cb:	8b 4b 04             	mov    0x4(%ebx),%ecx
801023ce:	85 c9                	test   %ecx,%ecx
801023d0:	74 0e                	je     801023e0 <iderw+0x40>
801023d2:	8b 15 60 a5 10 80    	mov    0x8010a560,%edx
801023d8:	85 d2                	test   %edx,%edx
801023da:	0f 84 87 00 00 00    	je     80102467 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801023e0:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801023e7:	e8 54 23 00 00       	call   80104740 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023ec:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
801023f1:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023f8:	85 c0                	test   %eax,%eax
801023fa:	74 64                	je     80102460 <iderw+0xc0>
801023fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102400:	89 c2                	mov    %eax,%edx
80102402:	8b 40 58             	mov    0x58(%eax),%eax
80102405:	85 c0                	test   %eax,%eax
80102407:	75 f7                	jne    80102400 <iderw+0x60>
80102409:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010240c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010240e:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
80102414:	75 1b                	jne    80102431 <iderw+0x91>
80102416:	eb 38                	jmp    80102450 <iderw+0xb0>
80102418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010241f:	90                   	nop
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
80102420:	89 1c 24             	mov    %ebx,(%esp)
80102423:	b8 80 a5 10 80       	mov    $0x8010a580,%eax
80102428:	89 44 24 04          	mov    %eax,0x4(%esp)
8010242c:	e8 9f 1b 00 00       	call   80103fd0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102431:	8b 03                	mov    (%ebx),%eax
80102433:	83 e0 06             	and    $0x6,%eax
80102436:	83 f8 02             	cmp    $0x2,%eax
80102439:	75 e5                	jne    80102420 <iderw+0x80>
  }


  release(&idelock);
8010243b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102442:	83 c4 14             	add    $0x14,%esp
80102445:	5b                   	pop    %ebx
80102446:	5d                   	pop    %ebp
  release(&idelock);
80102447:	e9 a4 23 00 00       	jmp    801047f0 <release>
8010244c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102450:	89 d8                	mov    %ebx,%eax
80102452:	e8 59 fd ff ff       	call   801021b0 <idestart>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102457:	eb d8                	jmp    80102431 <iderw+0x91>
80102459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102460:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102465:	eb a5                	jmp    8010240c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102467:	c7 04 24 75 75 10 80 	movl   $0x80107575,(%esp)
8010246e:	e8 ed de ff ff       	call   80100360 <panic>
    panic("iderw: nothing to do");
80102473:	c7 04 24 60 75 10 80 	movl   $0x80107560,(%esp)
8010247a:	e8 e1 de ff ff       	call   80100360 <panic>
    panic("iderw: buf not locked");
8010247f:	c7 04 24 4a 75 10 80 	movl   $0x8010754a,(%esp)
80102486:	e8 d5 de ff ff       	call   80100360 <panic>
8010248b:	66 90                	xchg   %ax,%ax
8010248d:	66 90                	xchg   %ax,%ax
8010248f:	90                   	nop

80102490 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102490:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102491:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
{
80102496:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102498:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010249d:	56                   	push   %esi
8010249e:	53                   	push   %ebx
8010249f:	83 ec 10             	sub    $0x10,%esp
  ioapic = (volatile struct ioapic*)IOAPIC;
801024a2:	a3 34 26 11 80       	mov    %eax,0x80112634
  ioapic->reg = reg;
801024a7:	89 15 00 00 c0 fe    	mov    %edx,0xfec00000
  return ioapic->data;
801024ad:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801024b3:	8b 42 10             	mov    0x10(%edx),%eax
  ioapic->reg = reg;
801024b6:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801024bc:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801024c2:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801024c9:	c1 e8 10             	shr    $0x10,%eax
801024cc:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801024cf:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801024d2:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801024d5:	39 c2                	cmp    %eax,%edx
801024d7:	74 12                	je     801024eb <ioapicinit+0x5b>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801024d9:	c7 04 24 94 75 10 80 	movl   $0x80107594,(%esp)
801024e0:	e8 9b e1 ff ff       	call   80100680 <cprintf>
801024e5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801024eb:	83 c6 21             	add    $0x21,%esi
{
801024ee:	ba 10 00 00 00       	mov    $0x10,%edx
801024f3:	b8 20 00 00 00       	mov    $0x20,%eax
801024f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024ff:	90                   	nop
  ioapic->reg = reg;
80102500:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102502:	89 c3                	mov    %eax,%ebx
80102504:	40                   	inc    %eax
  ioapic->data = data;
80102505:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010250b:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102511:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102514:	8d 5a 01             	lea    0x1(%edx),%ebx
80102517:	83 c2 02             	add    $0x2,%edx
8010251a:	89 19                	mov    %ebx,(%ecx)
  for(i = 0; i <= maxintr; i++){
8010251c:	39 f0                	cmp    %esi,%eax
  ioapic->data = data;
8010251e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102524:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010252b:	75 d3                	jne    80102500 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	5b                   	pop    %ebx
80102531:	5e                   	pop    %esi
80102532:	5d                   	pop    %ebp
80102533:	c3                   	ret    
80102534:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010253b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010253f:	90                   	nop

80102540 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102540:	55                   	push   %ebp
  ioapic->reg = reg;
80102541:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102547:	89 e5                	mov    %esp,%ebp
80102549:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010254c:	8d 50 20             	lea    0x20(%eax),%edx
8010254f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102553:	89 01                	mov    %eax,(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102555:	40                   	inc    %eax
  ioapic->data = data;
80102556:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010255c:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010255f:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102562:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102564:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102569:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010256c:	89 50 10             	mov    %edx,0x10(%eax)
}
8010256f:	5d                   	pop    %ebp
80102570:	c3                   	ret    
80102571:	66 90                	xchg   %ax,%ax
80102573:	66 90                	xchg   %ax,%ax
80102575:	66 90                	xchg   %ax,%ax
80102577:	66 90                	xchg   %ax,%ax
80102579:	66 90                	xchg   %ax,%ax
8010257b:	66 90                	xchg   %ax,%ax
8010257d:	66 90                	xchg   %ax,%ax
8010257f:	90                   	nop

80102580 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	53                   	push   %ebx
80102584:	83 ec 14             	sub    $0x14,%esp
80102587:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010258a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102590:	75 7f                	jne    80102611 <kfree+0x91>
80102592:	81 fb a8 58 11 80    	cmp    $0x801158a8,%ebx
80102598:	72 77                	jb     80102611 <kfree+0x91>
8010259a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801025a0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801025a5:	77 6a                	ja     80102611 <kfree+0x91>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801025a7:	89 1c 24             	mov    %ebx,(%esp)
801025aa:	ba 00 10 00 00       	mov    $0x1000,%edx
801025af:	b9 01 00 00 00       	mov    $0x1,%ecx
801025b4:	89 54 24 08          	mov    %edx,0x8(%esp)
801025b8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801025bc:	e8 7f 22 00 00       	call   80104840 <memset>

  if(kmem.use_lock)
801025c1:	a1 74 26 11 80       	mov    0x80112674,%eax
801025c6:	85 c0                	test   %eax,%eax
801025c8:	75 26                	jne    801025f0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801025ca:	a1 78 26 11 80       	mov    0x80112678,%eax
801025cf:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
801025d1:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
801025d7:	a1 74 26 11 80       	mov    0x80112674,%eax
801025dc:	85 c0                	test   %eax,%eax
801025de:	75 20                	jne    80102600 <kfree+0x80>
    release(&kmem.lock);
}
801025e0:	83 c4 14             	add    $0x14,%esp
801025e3:	5b                   	pop    %ebx
801025e4:	5d                   	pop    %ebp
801025e5:	c3                   	ret    
801025e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025ed:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801025f0:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801025f7:	e8 44 21 00 00       	call   80104740 <acquire>
801025fc:	eb cc                	jmp    801025ca <kfree+0x4a>
801025fe:	66 90                	xchg   %ax,%ax
    release(&kmem.lock);
80102600:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102607:	83 c4 14             	add    $0x14,%esp
8010260a:	5b                   	pop    %ebx
8010260b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010260c:	e9 df 21 00 00       	jmp    801047f0 <release>
    panic("kfree");
80102611:	c7 04 24 c6 75 10 80 	movl   $0x801075c6,(%esp)
80102618:	e8 43 dd ff ff       	call   80100360 <panic>
8010261d:	8d 76 00             	lea    0x0(%esi),%esi

80102620 <freerange>:
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	56                   	push   %esi
80102624:	53                   	push   %ebx
80102625:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102628:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010262b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010262e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102634:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010263a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102640:	39 de                	cmp    %ebx,%esi
80102642:	72 24                	jb     80102668 <freerange+0x48>
80102644:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010264b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010264f:	90                   	nop
    kfree(p);
80102650:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102656:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010265c:	89 04 24             	mov    %eax,(%esp)
8010265f:	e8 1c ff ff ff       	call   80102580 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102664:	39 f3                	cmp    %esi,%ebx
80102666:	76 e8                	jbe    80102650 <freerange+0x30>
}
80102668:	83 c4 10             	add    $0x10,%esp
8010266b:	5b                   	pop    %ebx
8010266c:	5e                   	pop    %esi
8010266d:	5d                   	pop    %ebp
8010266e:	c3                   	ret    
8010266f:	90                   	nop

80102670 <kinit1>:
{
80102670:	55                   	push   %ebp
  initlock(&kmem.lock, "kmem");
80102671:	b8 cc 75 10 80       	mov    $0x801075cc,%eax
{
80102676:	89 e5                	mov    %esp,%ebp
80102678:	56                   	push   %esi
80102679:	53                   	push   %ebx
8010267a:	83 ec 10             	sub    $0x10,%esp
  initlock(&kmem.lock, "kmem");
8010267d:	89 44 24 04          	mov    %eax,0x4(%esp)
{
80102681:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102684:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010268b:	e8 40 1f 00 00       	call   801045d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102690:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102693:	31 d2                	xor    %edx,%edx
80102695:	89 15 74 26 11 80    	mov    %edx,0x80112674
  p = (char*)PGROUNDUP((uint)vstart);
8010269b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026ad:	39 de                	cmp    %ebx,%esi
801026af:	72 27                	jb     801026d8 <kinit1+0x68>
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026bf:	90                   	nop
    kfree(p);
801026c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026c6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026cc:	89 04 24             	mov    %eax,(%esp)
801026cf:	e8 ac fe ff ff       	call   80102580 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026d4:	39 de                	cmp    %ebx,%esi
801026d6:	73 e8                	jae    801026c0 <kinit1+0x50>
}
801026d8:	83 c4 10             	add    $0x10,%esp
801026db:	5b                   	pop    %ebx
801026dc:	5e                   	pop    %esi
801026dd:	5d                   	pop    %ebp
801026de:	c3                   	ret    
801026df:	90                   	nop

801026e0 <kinit2>:
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	56                   	push   %esi
801026e4:	53                   	push   %ebx
801026e5:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
801026e8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801026ee:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026f4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026fa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102700:	39 de                	cmp    %ebx,%esi
80102702:	72 24                	jb     80102728 <kinit2+0x48>
80102704:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010270b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010270f:	90                   	nop
    kfree(p);
80102710:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102716:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010271c:	89 04 24             	mov    %eax,(%esp)
8010271f:	e8 5c fe ff ff       	call   80102580 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102724:	39 de                	cmp    %ebx,%esi
80102726:	73 e8                	jae    80102710 <kinit2+0x30>
  kmem.use_lock = 1;
80102728:	b8 01 00 00 00       	mov    $0x1,%eax
8010272d:	a3 74 26 11 80       	mov    %eax,0x80112674
}
80102732:	83 c4 10             	add    $0x10,%esp
80102735:	5b                   	pop    %ebx
80102736:	5e                   	pop    %esi
80102737:	5d                   	pop    %ebp
80102738:	c3                   	ret    
80102739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102740 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102740:	a1 74 26 11 80       	mov    0x80112674,%eax
80102745:	85 c0                	test   %eax,%eax
80102747:	75 27                	jne    80102770 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102749:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010274e:	85 c0                	test   %eax,%eax
80102750:	74 0e                	je     80102760 <kalloc+0x20>
    kmem.freelist = r->next;
80102752:	8b 10                	mov    (%eax),%edx
80102754:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
8010275a:	c3                   	ret    
8010275b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010275f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102760:	c3                   	ret    
80102761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276f:	90                   	nop
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
80102773:	83 ec 28             	sub    $0x28,%esp
    acquire(&kmem.lock);
80102776:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
8010277d:	e8 be 1f 00 00       	call   80104740 <acquire>
  r = kmem.freelist;
80102782:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
80102787:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010278d:	85 c0                	test   %eax,%eax
8010278f:	74 08                	je     80102799 <kalloc+0x59>
    kmem.freelist = r->next;
80102791:	8b 08                	mov    (%eax),%ecx
80102793:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102799:	85 d2                	test   %edx,%edx
8010279b:	74 12                	je     801027af <kalloc+0x6f>
    release(&kmem.lock);
8010279d:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801027a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027a7:	e8 44 20 00 00       	call   801047f0 <release>
  return (char*)r;
801027ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801027af:	c9                   	leave  
801027b0:	c3                   	ret    
801027b1:	66 90                	xchg   %ax,%ax
801027b3:	66 90                	xchg   %ax,%ax
801027b5:	66 90                	xchg   %ax,%ax
801027b7:	66 90                	xchg   %ax,%ax
801027b9:	66 90                	xchg   %ax,%ax
801027bb:	66 90                	xchg   %ax,%ax
801027bd:	66 90                	xchg   %ax,%ax
801027bf:	90                   	nop

801027c0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027c0:	ba 64 00 00 00       	mov    $0x64,%edx
801027c5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801027c6:	24 01                	and    $0x1,%al
801027c8:	0f 84 c2 00 00 00    	je     80102890 <kbdgetc+0xd0>
{
801027ce:	55                   	push   %ebp
801027cf:	ba 60 00 00 00       	mov    $0x60,%edx
801027d4:	89 e5                	mov    %esp,%ebp
801027d6:	53                   	push   %ebx
801027d7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
801027d8:	3c e0                	cmp    $0xe0,%al
801027da:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
  data = inb(KBDATAP);
801027e0:	0f b6 d0             	movzbl %al,%edx
  if(data == 0xE0){
801027e3:	74 5b                	je     80102840 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801027e5:	89 d9                	mov    %ebx,%ecx
801027e7:	83 e1 40             	and    $0x40,%ecx
801027ea:	84 c0                	test   %al,%al
801027ec:	78 62                	js     80102850 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801027ee:	85 c9                	test   %ecx,%ecx
801027f0:	74 08                	je     801027fa <kbdgetc+0x3a>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801027f2:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
801027f4:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801027f7:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801027fa:	0f b6 8a 00 77 10 80 	movzbl -0x7fef8900(%edx),%ecx
  shift ^= togglecode[data];
80102801:	0f b6 82 00 76 10 80 	movzbl -0x7fef8a00(%edx),%eax
  shift |= shiftcode[data];
80102808:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010280a:	31 c1                	xor    %eax,%ecx
8010280c:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102812:	89 c8                	mov    %ecx,%eax
80102814:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102817:	f6 c1 08             	test   $0x8,%cl
  c = charcode[shift & (CTL | SHIFT)][data];
8010281a:	8b 04 85 e0 75 10 80 	mov    -0x7fef8a20(,%eax,4),%eax
80102821:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102825:	74 13                	je     8010283a <kbdgetc+0x7a>
    if('a' <= c && c <= 'z')
80102827:	8d 50 9f             	lea    -0x61(%eax),%edx
8010282a:	83 fa 19             	cmp    $0x19,%edx
8010282d:	76 51                	jbe    80102880 <kbdgetc+0xc0>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
8010282f:	8d 50 bf             	lea    -0x41(%eax),%edx
80102832:	83 fa 19             	cmp    $0x19,%edx
80102835:	77 03                	ja     8010283a <kbdgetc+0x7a>
      c += 'a' - 'A';
80102837:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
8010283a:	5b                   	pop    %ebx
8010283b:	5d                   	pop    %ebp
8010283c:	c3                   	ret    
8010283d:	8d 76 00             	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102840:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102843:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102845:	89 1d b4 a5 10 80    	mov    %ebx,0x8010a5b4
}
8010284b:	5b                   	pop    %ebx
8010284c:	5d                   	pop    %ebp
8010284d:	c3                   	ret    
8010284e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102850:	85 c9                	test   %ecx,%ecx
80102852:	75 05                	jne    80102859 <kbdgetc+0x99>
80102854:	24 7f                	and    $0x7f,%al
80102856:	0f b6 d0             	movzbl %al,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102859:	0f b6 82 00 77 10 80 	movzbl -0x7fef8900(%edx),%eax
80102860:	0c 40                	or     $0x40,%al
80102862:	0f b6 c8             	movzbl %al,%ecx
    return 0;
80102865:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102867:	f7 d1                	not    %ecx
80102869:	21 d9                	and    %ebx,%ecx
}
8010286b:	5b                   	pop    %ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010286c:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
80102872:	5d                   	pop    %ebp
80102873:	c3                   	ret    
80102874:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010287b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010287f:	90                   	nop
80102880:	5b                   	pop    %ebx
      c += 'A' - 'a';
80102881:	83 e8 20             	sub    $0x20,%eax
}
80102884:	5d                   	pop    %ebp
80102885:	c3                   	ret    
80102886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010288d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80102890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102895:	c3                   	ret    
80102896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010289d:	8d 76 00             	lea    0x0(%esi),%esi

801028a0 <kbdintr>:

void
kbdintr(void)
{
801028a0:	55                   	push   %ebp
801028a1:	89 e5                	mov    %esp,%ebp
801028a3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801028a6:	c7 04 24 c0 27 10 80 	movl   $0x801027c0,(%esp)
801028ad:	e8 7e df ff ff       	call   80100830 <consoleintr>
}
801028b2:	c9                   	leave  
801028b3:	c3                   	ret    
801028b4:	66 90                	xchg   %ax,%ax
801028b6:	66 90                	xchg   %ax,%ax
801028b8:	66 90                	xchg   %ax,%ax
801028ba:	66 90                	xchg   %ax,%ax
801028bc:	66 90                	xchg   %ax,%ax
801028be:	66 90                	xchg   %ax,%ax

801028c0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801028c0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801028c5:	85 c0                	test   %eax,%eax
801028c7:	0f 84 c9 00 00 00    	je     80102996 <lapicinit+0xd6>
  lapic[index] = value;
801028cd:	ba 3f 01 00 00       	mov    $0x13f,%edx
801028d2:	b9 0b 00 00 00       	mov    $0xb,%ecx
801028d7:	89 90 f0 00 00 00    	mov    %edx,0xf0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028dd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e0:	89 88 e0 03 00 00    	mov    %ecx,0x3e0(%eax)
801028e6:	b9 80 96 98 00       	mov    $0x989680,%ecx
  lapic[ID];  // wait for write to finish, by reading
801028eb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ee:	ba 20 00 02 00       	mov    $0x20020,%edx
801028f3:	89 90 20 03 00 00    	mov    %edx,0x320(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f9:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028fc:	89 88 80 03 00 00    	mov    %ecx,0x380(%eax)
80102902:	b9 00 00 01 00       	mov    $0x10000,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102907:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010290a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010290f:	89 90 50 03 00 00    	mov    %edx,0x350(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102915:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102918:	89 88 60 03 00 00    	mov    %ecx,0x360(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010291e:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102921:	8b 50 30             	mov    0x30(%eax),%edx
80102924:	c1 ea 10             	shr    $0x10,%edx
80102927:	f6 c2 fc             	test   $0xfc,%dl
8010292a:	75 74                	jne    801029a0 <lapicinit+0xe0>
  lapic[index] = value;
8010292c:	b9 33 00 00 00       	mov    $0x33,%ecx
80102931:	89 88 70 03 00 00    	mov    %ecx,0x370(%eax)
80102937:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
80102939:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010293c:	31 d2                	xor    %edx,%edx
8010293e:	89 90 80 02 00 00    	mov    %edx,0x280(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102944:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102947:	89 88 80 02 00 00    	mov    %ecx,0x280(%eax)
8010294d:	31 c9                	xor    %ecx,%ecx
  lapic[ID];  // wait for write to finish, by reading
8010294f:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102952:	31 d2                	xor    %edx,%edx
80102954:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010295a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010295d:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102963:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102966:	ba 00 85 08 00       	mov    $0x88500,%edx
8010296b:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102971:	8b 50 20             	mov    0x20(%eax),%edx
80102974:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010297b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010297f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102980:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102986:	f6 c6 10             	test   $0x10,%dh
80102989:	75 f5                	jne    80102980 <lapicinit+0xc0>
  lapic[index] = value;
8010298b:	31 d2                	xor    %edx,%edx
8010298d:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102993:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102996:	c3                   	ret    
80102997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010299e:	66 90                	xchg   %ax,%ax
  lapic[index] = value;
801029a0:	b9 00 00 01 00       	mov    $0x10000,%ecx
801029a5:	89 88 40 03 00 00    	mov    %ecx,0x340(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ab:	8b 50 20             	mov    0x20(%eax),%edx
}
801029ae:	e9 79 ff ff ff       	jmp    8010292c <lapicinit+0x6c>
801029b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029c0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801029c0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801029c5:	85 c0                	test   %eax,%eax
801029c7:	74 07                	je     801029d0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801029c9:	8b 40 20             	mov    0x20(%eax),%eax
801029cc:	c1 e8 18             	shr    $0x18,%eax
801029cf:	c3                   	ret    
    return 0;
801029d0:	31 c0                	xor    %eax,%eax
}
801029d2:	c3                   	ret    
801029d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029e0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801029e0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801029e5:	85 c0                	test   %eax,%eax
801029e7:	74 0b                	je     801029f4 <lapiceoi+0x14>
  lapic[index] = value;
801029e9:	31 d2                	xor    %edx,%edx
801029eb:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029f1:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801029f4:	c3                   	ret    
801029f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a00 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102a00:	c3                   	ret    
80102a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a0f:	90                   	nop

80102a10 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102a10:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a11:	b0 0f                	mov    $0xf,%al
80102a13:	89 e5                	mov    %esp,%ebp
80102a15:	ba 70 00 00 00       	mov    $0x70,%edx
80102a1a:	53                   	push   %ebx
80102a1b:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
80102a1f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102a22:	ee                   	out    %al,(%dx)
80102a23:	b0 0a                	mov    $0xa,%al
80102a25:	ba 71 00 00 00       	mov    $0x71,%edx
80102a2a:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102a2b:	c1 e1 18             	shl    $0x18,%ecx
  wrv[0] = 0;
80102a2e:	31 c0                	xor    %eax,%eax
80102a30:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a36:	89 d8                	mov    %ebx,%eax
80102a38:	c1 e8 04             	shr    $0x4,%eax
80102a3b:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a41:	c1 eb 0c             	shr    $0xc,%ebx
  lapic[index] = value;
80102a44:	a1 7c 26 11 80       	mov    0x8011267c,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a49:	81 cb 00 06 00 00    	or     $0x600,%ebx
  lapic[index] = value;
80102a4f:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a55:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a58:	ba 00 c5 00 00       	mov    $0xc500,%edx
80102a5d:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a63:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a66:	ba 00 85 00 00       	mov    $0x8500,%edx
80102a6b:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a71:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a74:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a7a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a7d:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a83:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a86:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a8c:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a8f:	89 98 00 03 00 00    	mov    %ebx,0x300(%eax)
    microdelay(200);
  }
}
80102a95:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102a96:	8b 40 20             	mov    0x20(%eax),%eax
}
80102a99:	5d                   	pop    %ebp
80102a9a:	c3                   	ret    
80102a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a9f:	90                   	nop

80102aa0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102aa0:	55                   	push   %ebp
80102aa1:	b0 0b                	mov    $0xb,%al
80102aa3:	89 e5                	mov    %esp,%ebp
80102aa5:	ba 70 00 00 00       	mov    $0x70,%edx
80102aaa:	57                   	push   %edi
80102aab:	56                   	push   %esi
80102aac:	53                   	push   %ebx
80102aad:	83 ec 5c             	sub    $0x5c,%esp
80102ab0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ab1:	ba 71 00 00 00       	mov    $0x71,%edx
80102ab6:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102ab7:	24 04                	and    $0x4,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab9:	be 70 00 00 00       	mov    $0x70,%esi
80102abe:	88 45 b2             	mov    %al,-0x4e(%ebp)
80102ac1:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102ac4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102acf:	90                   	nop
80102ad0:	31 c0                	xor    %eax,%eax
80102ad2:	89 f2                	mov    %esi,%edx
80102ad4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad5:	bb 71 00 00 00       	mov    $0x71,%ebx
80102ada:	89 da                	mov    %ebx,%edx
80102adc:	ec                   	in     (%dx),%al
80102add:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae0:	89 f2                	mov    %esi,%edx
80102ae2:	b0 02                	mov    $0x2,%al
80102ae4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae5:	89 da                	mov    %ebx,%edx
80102ae7:	ec                   	in     (%dx),%al
80102ae8:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aeb:	89 f2                	mov    %esi,%edx
80102aed:	b0 04                	mov    $0x4,%al
80102aef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102af0:	89 da                	mov    %ebx,%edx
80102af2:	ec                   	in     (%dx),%al
80102af3:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102af6:	89 f2                	mov    %esi,%edx
80102af8:	b0 07                	mov    $0x7,%al
80102afa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102afb:	89 da                	mov    %ebx,%edx
80102afd:	ec                   	in     (%dx),%al
80102afe:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b01:	89 f2                	mov    %esi,%edx
80102b03:	b0 08                	mov    $0x8,%al
80102b05:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b06:	89 da                	mov    %ebx,%edx
80102b08:	ec                   	in     (%dx),%al
80102b09:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b0c:	89 f2                	mov    %esi,%edx
80102b0e:	b0 09                	mov    $0x9,%al
80102b10:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b11:	89 da                	mov    %ebx,%edx
80102b13:	ec                   	in     (%dx),%al
80102b14:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b17:	89 f2                	mov    %esi,%edx
80102b19:	b0 0a                	mov    $0xa,%al
80102b1b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b1c:	89 da                	mov    %ebx,%edx
80102b1e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102b1f:	84 c0                	test   %al,%al
80102b21:	78 ad                	js     80102ad0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102b23:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80102b26:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b2a:	89 f2                	mov    %esi,%edx
80102b2c:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b2f:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102b33:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b36:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102b3a:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b3d:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102b41:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b44:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
80102b48:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102b4b:	31 c0                	xor    %eax,%eax
80102b4d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b4e:	89 da                	mov    %ebx,%edx
80102b50:	ec                   	in     (%dx),%al
80102b51:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b54:	89 f2                	mov    %esi,%edx
80102b56:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102b59:	b0 02                	mov    $0x2,%al
80102b5b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b5c:	89 da                	mov    %ebx,%edx
80102b5e:	ec                   	in     (%dx),%al
80102b5f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b62:	89 f2                	mov    %esi,%edx
80102b64:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102b67:	b0 04                	mov    $0x4,%al
80102b69:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b6a:	89 da                	mov    %ebx,%edx
80102b6c:	ec                   	in     (%dx),%al
80102b6d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b70:	89 f2                	mov    %esi,%edx
80102b72:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102b75:	b0 07                	mov    $0x7,%al
80102b77:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b78:	89 da                	mov    %ebx,%edx
80102b7a:	ec                   	in     (%dx),%al
80102b7b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b7e:	89 f2                	mov    %esi,%edx
80102b80:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102b83:	b0 08                	mov    $0x8,%al
80102b85:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b86:	89 da                	mov    %ebx,%edx
80102b88:	ec                   	in     (%dx),%al
80102b89:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b8c:	89 f2                	mov    %esi,%edx
80102b8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102b91:	b0 09                	mov    $0x9,%al
80102b93:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b94:	89 da                	mov    %ebx,%edx
80102b96:	ec                   	in     (%dx),%al
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b97:	89 7c 24 04          	mov    %edi,0x4(%esp)
  return inb(CMOS_RETURN);
80102b9b:	0f b6 c0             	movzbl %al,%eax
80102b9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ba1:	b8 18 00 00 00       	mov    $0x18,%eax
80102ba6:	89 44 24 08          	mov    %eax,0x8(%esp)
80102baa:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102bad:	89 04 24             	mov    %eax,(%esp)
80102bb0:	e8 fb 1c 00 00       	call   801048b0 <memcmp>
80102bb5:	85 c0                	test   %eax,%eax
80102bb7:	0f 85 13 ff ff ff    	jne    80102ad0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102bbd:	80 7d b2 00          	cmpb   $0x0,-0x4e(%ebp)
80102bc1:	75 78                	jne    80102c3b <cmostime+0x19b>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102bc3:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102bc6:	89 c2                	mov    %eax,%edx
80102bc8:	83 e0 0f             	and    $0xf,%eax
80102bcb:	c1 ea 04             	shr    $0x4,%edx
80102bce:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bd1:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bd4:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102bd7:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102bda:	89 c2                	mov    %eax,%edx
80102bdc:	83 e0 0f             	and    $0xf,%eax
80102bdf:	c1 ea 04             	shr    $0x4,%edx
80102be2:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102be5:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102be8:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102beb:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102bee:	89 c2                	mov    %eax,%edx
80102bf0:	83 e0 0f             	and    $0xf,%eax
80102bf3:	c1 ea 04             	shr    $0x4,%edx
80102bf6:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bf9:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bfc:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102bff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c02:	89 c2                	mov    %eax,%edx
80102c04:	83 e0 0f             	and    $0xf,%eax
80102c07:	c1 ea 04             	shr    $0x4,%edx
80102c0a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c0d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c10:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c13:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c16:	89 c2                	mov    %eax,%edx
80102c18:	83 e0 0f             	and    $0xf,%eax
80102c1b:	c1 ea 04             	shr    $0x4,%edx
80102c1e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c21:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c24:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c27:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c2a:	89 c2                	mov    %eax,%edx
80102c2c:	83 e0 0f             	and    $0xf,%eax
80102c2f:	c1 ea 04             	shr    $0x4,%edx
80102c32:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c35:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c38:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102c3b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102c3e:	31 c0                	xor    %eax,%eax
80102c40:	8b 54 05 b8          	mov    -0x48(%ebp,%eax,1),%edx
80102c44:	89 14 01             	mov    %edx,(%ecx,%eax,1)
80102c47:	83 c0 04             	add    $0x4,%eax
80102c4a:	83 f8 18             	cmp    $0x18,%eax
80102c4d:	72 f1                	jb     80102c40 <cmostime+0x1a0>
  r->year += 2000;
80102c4f:	8b 45 08             	mov    0x8(%ebp),%eax
80102c52:	81 40 14 d0 07 00 00 	addl   $0x7d0,0x14(%eax)
}
80102c59:	83 c4 5c             	add    $0x5c,%esp
80102c5c:	5b                   	pop    %ebx
80102c5d:	5e                   	pop    %esi
80102c5e:	5f                   	pop    %edi
80102c5f:	5d                   	pop    %ebp
80102c60:	c3                   	ret    
80102c61:	66 90                	xchg   %ax,%ax
80102c63:	66 90                	xchg   %ax,%ax
80102c65:	66 90                	xchg   %ax,%ax
80102c67:	66 90                	xchg   %ax,%ax
80102c69:	66 90                	xchg   %ax,%ax
80102c6b:	66 90                	xchg   %ax,%ax
80102c6d:	66 90                	xchg   %ax,%ax
80102c6f:	90                   	nop

80102c70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c70:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102c76:	85 d2                	test   %edx,%edx
80102c78:	0f 8e 92 00 00 00    	jle    80102d10 <install_trans+0xa0>
{
80102c7e:	55                   	push   %ebp
80102c7f:	89 e5                	mov    %esp,%ebp
80102c81:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102c82:	31 ff                	xor    %edi,%edi
{
80102c84:	56                   	push   %esi
80102c85:	53                   	push   %ebx
80102c86:	83 ec 1c             	sub    $0x1c,%esp
80102c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102c90:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c95:	01 f8                	add    %edi,%eax
80102c97:	40                   	inc    %eax
80102c98:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c9c:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102ca1:	89 04 24             	mov    %eax,(%esp)
80102ca4:	e8 27 d4 ff ff       	call   801000d0 <bread>
80102ca9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cab:	8b 04 bd cc 26 11 80 	mov    -0x7feed934(,%edi,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102cb2:	47                   	inc    %edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cb3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cb7:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102cbc:	89 04 24             	mov    %eax,(%esp)
80102cbf:	e8 0c d4 ff ff       	call   801000d0 <bread>
80102cc4:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cc6:	b8 00 02 00 00       	mov    $0x200,%eax
80102ccb:	89 44 24 08          	mov    %eax,0x8(%esp)
80102ccf:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cd2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102cd6:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102cd9:	89 04 24             	mov    %eax,(%esp)
80102cdc:	e8 1f 1c 00 00       	call   80104900 <memmove>
    bwrite(dbuf);  // write dst to disk
80102ce1:	89 1c 24             	mov    %ebx,(%esp)
80102ce4:	e8 c7 d4 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102ce9:	89 34 24             	mov    %esi,(%esp)
80102cec:	e8 ff d4 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102cf1:	89 1c 24             	mov    %ebx,(%esp)
80102cf4:	e8 f7 d4 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cf9:	39 3d c8 26 11 80    	cmp    %edi,0x801126c8
80102cff:	7f 8f                	jg     80102c90 <install_trans+0x20>
  }
}
80102d01:	83 c4 1c             	add    $0x1c,%esp
80102d04:	5b                   	pop    %ebx
80102d05:	5e                   	pop    %esi
80102d06:	5f                   	pop    %edi
80102d07:	5d                   	pop    %ebp
80102d08:	c3                   	ret    
80102d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d10:	c3                   	ret    
80102d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1f:	90                   	nop

80102d20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	53                   	push   %ebx
80102d24:	83 ec 14             	sub    $0x14,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d27:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d2c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d30:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102d35:	89 04 24             	mov    %eax,(%esp)
80102d38:	e8 93 d3 ff ff       	call   801000d0 <bread>
80102d3d:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102d3f:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102d44:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102d47:	85 c0                	test   %eax,%eax
80102d49:	7e 15                	jle    80102d60 <write_head+0x40>
80102d4b:	31 d2                	xor    %edx,%edx
80102d4d:	8d 76 00             	lea    0x0(%esi),%esi
    hb->block[i] = log.lh.block[i];
80102d50:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102d57:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d5b:	42                   	inc    %edx
80102d5c:	39 d0                	cmp    %edx,%eax
80102d5e:	75 f0                	jne    80102d50 <write_head+0x30>
  }
  bwrite(buf);
80102d60:	89 1c 24             	mov    %ebx,(%esp)
80102d63:	e8 48 d4 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102d68:	89 1c 24             	mov    %ebx,(%esp)
80102d6b:	e8 80 d4 ff ff       	call   801001f0 <brelse>
}
80102d70:	83 c4 14             	add    $0x14,%esp
80102d73:	5b                   	pop    %ebx
80102d74:	5d                   	pop    %ebp
80102d75:	c3                   	ret    
80102d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d7d:	8d 76 00             	lea    0x0(%esi),%esi

80102d80 <initlog>:
{
80102d80:	55                   	push   %ebp
  initlock(&log.lock, "log");
80102d81:	ba 00 78 10 80       	mov    $0x80107800,%edx
{
80102d86:	89 e5                	mov    %esp,%ebp
80102d88:	53                   	push   %ebx
80102d89:	83 ec 34             	sub    $0x34,%esp
  initlock(&log.lock, "log");
80102d8c:	89 54 24 04          	mov    %edx,0x4(%esp)
{
80102d90:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102d93:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d9a:	e8 31 18 00 00       	call   801045d0 <initlock>
  readsb(dev, &sb);
80102d9f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102da2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102da6:	89 1c 24             	mov    %ebx,(%esp)
80102da9:	e8 c2 e7 ff ff       	call   80101570 <readsb>
  log.start = sb.logstart;
80102dae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102db1:	89 1c 24             	mov    %ebx,(%esp)
  log.size = sb.nlog;
80102db4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.dev = dev;
80102db7:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  struct buf *buf = bread(log.dev, log.start);
80102dbd:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.start = sb.logstart;
80102dc1:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  log.size = sb.nlog;
80102dc6:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  struct buf *buf = bread(log.dev, log.start);
80102dcc:	e8 ff d2 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102dd1:	8b 48 5c             	mov    0x5c(%eax),%ecx
80102dd4:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102dda:	85 c9                	test   %ecx,%ecx
80102ddc:	7e 12                	jle    80102df0 <initlog+0x70>
80102dde:	31 d2                	xor    %edx,%edx
    log.lh.block[i] = lh->block[i];
80102de0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80102de4:	89 1c 95 cc 26 11 80 	mov    %ebx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102deb:	42                   	inc    %edx
80102dec:	39 d1                	cmp    %edx,%ecx
80102dee:	75 f0                	jne    80102de0 <initlog+0x60>
  brelse(buf);
80102df0:	89 04 24             	mov    %eax,(%esp)
80102df3:	e8 f8 d3 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102df8:	e8 73 fe ff ff       	call   80102c70 <install_trans>
  log.lh.n = 0;
80102dfd:	31 c0                	xor    %eax,%eax
80102dff:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  write_head(); // clear the log
80102e04:	e8 17 ff ff ff       	call   80102d20 <write_head>
}
80102e09:	83 c4 34             	add    $0x34,%esp
80102e0c:	5b                   	pop    %ebx
80102e0d:	5d                   	pop    %ebp
80102e0e:	c3                   	ret    
80102e0f:	90                   	nop

80102e10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102e16:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e1d:	e8 1e 19 00 00       	call   80104740 <acquire>
80102e22:	eb 21                	jmp    80102e45 <begin_op+0x35>
80102e24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e2f:	90                   	nop
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e30:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e37:	b8 80 26 11 80       	mov    $0x80112680,%eax
80102e3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e40:	e8 8b 11 00 00       	call   80103fd0 <sleep>
    if(log.committing){
80102e45:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
80102e4b:	85 d2                	test   %edx,%edx
80102e4d:	75 e1                	jne    80102e30 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102e4f:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102e54:	8d 54 80 05          	lea    0x5(%eax,%eax,4),%edx
80102e58:	8d 48 01             	lea    0x1(%eax),%ecx
80102e5b:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102e60:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e63:	83 f8 1e             	cmp    $0x1e,%eax
80102e66:	7f c8                	jg     80102e30 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102e68:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
      log.outstanding += 1;
80102e6f:	89 0d bc 26 11 80    	mov    %ecx,0x801126bc
      release(&log.lock);
80102e75:	e8 76 19 00 00       	call   801047f0 <release>
      break;
    }
  }
}
80102e7a:	c9                   	leave  
80102e7b:	c3                   	ret    
80102e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	57                   	push   %edi
80102e84:	56                   	push   %esi
80102e85:	53                   	push   %ebx
80102e86:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102e89:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e90:	e8 ab 18 00 00       	call   80104740 <acquire>
  log.outstanding -= 1;
80102e95:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102e9a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102e9d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
  log.outstanding -= 1;
80102ea2:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102ea8:	85 c0                	test   %eax,%eax
80102eaa:	0f 85 ed 00 00 00    	jne    80102f9d <end_op+0x11d>
    panic("log.committing");
  if(log.outstanding == 0){
80102eb0:	85 db                	test   %ebx,%ebx
80102eb2:	75 34                	jne    80102ee8 <end_op+0x68>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102eb4:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 1;
80102ebb:	be 01 00 00 00       	mov    $0x1,%esi
80102ec0:	89 35 c0 26 11 80    	mov    %esi,0x801126c0
  release(&log.lock);
80102ec6:	e8 25 19 00 00       	call   801047f0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ecb:	8b 3d c8 26 11 80    	mov    0x801126c8,%edi
80102ed1:	85 ff                	test   %edi,%edi
80102ed3:	7f 3b                	jg     80102f10 <end_op+0x90>
    acquire(&log.lock);
80102ed5:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102edc:	e8 5f 18 00 00       	call   80104740 <acquire>
    log.committing = 0;
80102ee1:	31 c0                	xor    %eax,%eax
80102ee3:	a3 c0 26 11 80       	mov    %eax,0x801126c0
    wakeup(&log);
80102ee8:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102eef:	e8 dc 13 00 00       	call   801042d0 <wakeup>
    release(&log.lock);
80102ef4:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102efb:	e8 f0 18 00 00       	call   801047f0 <release>
}
80102f00:	83 c4 1c             	add    $0x1c,%esp
80102f03:	5b                   	pop    %ebx
80102f04:	5e                   	pop    %esi
80102f05:	5f                   	pop    %edi
80102f06:	5d                   	pop    %ebp
80102f07:	c3                   	ret    
80102f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f0f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f10:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102f15:	01 d8                	add    %ebx,%eax
80102f17:	40                   	inc    %eax
80102f18:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f1c:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102f21:	89 04 24             	mov    %eax,(%esp)
80102f24:	e8 a7 d1 ff ff       	call   801000d0 <bread>
80102f29:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f2b:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102f32:	43                   	inc    %ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f33:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f37:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102f3c:	89 04 24             	mov    %eax,(%esp)
80102f3f:	e8 8c d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102f44:	b9 00 02 00 00       	mov    $0x200,%ecx
80102f49:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f4d:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102f4f:	8d 40 5c             	lea    0x5c(%eax),%eax
80102f52:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f56:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f59:	89 04 24             	mov    %eax,(%esp)
80102f5c:	e8 9f 19 00 00       	call   80104900 <memmove>
    bwrite(to);  // write the log
80102f61:	89 34 24             	mov    %esi,(%esp)
80102f64:	e8 47 d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102f69:	89 3c 24             	mov    %edi,(%esp)
80102f6c:	e8 7f d2 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102f71:	89 34 24             	mov    %esi,(%esp)
80102f74:	e8 77 d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102f79:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102f7f:	7c 8f                	jl     80102f10 <end_op+0x90>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102f81:	e8 9a fd ff ff       	call   80102d20 <write_head>
    install_trans(); // Now install writes to home locations
80102f86:	e8 e5 fc ff ff       	call   80102c70 <install_trans>
    log.lh.n = 0;
80102f8b:	31 d2                	xor    %edx,%edx
80102f8d:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
    write_head();    // Erase the transaction from the log
80102f93:	e8 88 fd ff ff       	call   80102d20 <write_head>
80102f98:	e9 38 ff ff ff       	jmp    80102ed5 <end_op+0x55>
    panic("log.committing");
80102f9d:	c7 04 24 04 78 10 80 	movl   $0x80107804,(%esp)
80102fa4:	e8 b7 d3 ff ff       	call   80100360 <panic>
80102fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102fb0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	53                   	push   %ebx
80102fb4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102fb7:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102fbd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102fc0:	83 fa 1d             	cmp    $0x1d,%edx
80102fc3:	0f 8f 83 00 00 00    	jg     8010304c <log_write+0x9c>
80102fc9:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102fce:	48                   	dec    %eax
80102fcf:	39 c2                	cmp    %eax,%edx
80102fd1:	7d 79                	jge    8010304c <log_write+0x9c>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102fd3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102fd8:	85 c0                	test   %eax,%eax
80102fda:	7e 7c                	jle    80103058 <log_write+0xa8>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102fdc:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102fe3:	e8 58 17 00 00       	call   80104740 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102fe8:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102fee:	85 d2                	test   %edx,%edx
80102ff0:	7e 4e                	jle    80103040 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102ff2:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ff5:	31 c0                	xor    %eax,%eax
80102ff7:	eb 0c                	jmp    80103005 <log_write+0x55>
80102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103000:	40                   	inc    %eax
80103001:	39 c2                	cmp    %eax,%edx
80103003:	74 2b                	je     80103030 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103005:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
8010300c:	75 f2                	jne    80103000 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
8010300e:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103015:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103018:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
8010301f:	83 c4 14             	add    $0x14,%esp
80103022:	5b                   	pop    %ebx
80103023:	5d                   	pop    %ebp
  release(&log.lock);
80103024:	e9 c7 17 00 00       	jmp    801047f0 <release>
80103029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  log.lh.block[i] = b->blockno;
80103030:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
    log.lh.n++;
80103037:	42                   	inc    %edx
80103038:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
8010303e:	eb d5                	jmp    80103015 <log_write+0x65>
  log.lh.block[i] = b->blockno;
80103040:	8b 43 08             	mov    0x8(%ebx),%eax
80103043:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80103048:	75 cb                	jne    80103015 <log_write+0x65>
8010304a:	eb eb                	jmp    80103037 <log_write+0x87>
    panic("too big a transaction");
8010304c:	c7 04 24 13 78 10 80 	movl   $0x80107813,(%esp)
80103053:	e8 08 d3 ff ff       	call   80100360 <panic>
    panic("log_write outside of trans");
80103058:	c7 04 24 29 78 10 80 	movl   $0x80107829,(%esp)
8010305f:	e8 fc d2 ff ff       	call   80100360 <panic>
80103064:	66 90                	xchg   %ax,%ax
80103066:	66 90                	xchg   %ax,%ax
80103068:	66 90                	xchg   %ax,%ax
8010306a:	66 90                	xchg   %ax,%ax
8010306c:	66 90                	xchg   %ax,%ax
8010306e:	66 90                	xchg   %ax,%ax

80103070 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	53                   	push   %ebx
80103074:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103077:	e8 84 09 00 00       	call   80103a00 <cpuid>
8010307c:	89 c3                	mov    %eax,%ebx
8010307e:	e8 7d 09 00 00       	call   80103a00 <cpuid>
80103083:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103087:	c7 04 24 44 78 10 80 	movl   $0x80107844,(%esp)
8010308e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103092:	e8 e9 d5 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register
80103097:	e8 24 2a 00 00       	call   80105ac0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
8010309c:	e8 ef 08 00 00       	call   80103990 <mycpu>
801030a1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801030a3:	b8 01 00 00 00       	mov    $0x1,%eax
801030a8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801030af:	e8 3c 0c 00 00       	call   80103cf0 <scheduler>
801030b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030bf:	90                   	nop

801030c0 <mpenter>:
{
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801030c6:	e8 65 3b 00 00       	call   80106c30 <switchkvm>
  seginit();
801030cb:	e8 d0 3a 00 00       	call   80106ba0 <seginit>
  lapicinit();
801030d0:	e8 eb f7 ff ff       	call   801028c0 <lapicinit>
  mpmain();
801030d5:	e8 96 ff ff ff       	call   80103070 <mpmain>
801030da:	66 90                	xchg   %ax,%ax
801030dc:	66 90                	xchg   %ax,%ax
801030de:	66 90                	xchg   %ax,%ax

801030e0 <main>:
{
801030e0:	55                   	push   %ebp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801030e1:	b8 00 00 40 80       	mov    $0x80400000,%eax
{
801030e6:	89 e5                	mov    %esp,%ebp
801030e8:	53                   	push   %ebx
801030e9:	83 e4 f0             	and    $0xfffffff0,%esp
801030ec:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801030ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801030f3:	c7 04 24 a8 58 11 80 	movl   $0x801158a8,(%esp)
801030fa:	e8 71 f5 ff ff       	call   80102670 <kinit1>
  kvmalloc();      // kernel page table
801030ff:	e8 1c 40 00 00       	call   80107120 <kvmalloc>
  mpinit();        // detect other processors
80103104:	e8 97 01 00 00       	call   801032a0 <mpinit>
  lapicinit();     // interrupt controller
80103109:	e8 b2 f7 ff ff       	call   801028c0 <lapicinit>
  seginit();       // segment descriptors
8010310e:	66 90                	xchg   %ax,%ax
80103110:	e8 8b 3a 00 00       	call   80106ba0 <seginit>
  picinit();       // disable pic
80103115:	e8 56 03 00 00       	call   80103470 <picinit>
  ioapicinit();    // another interrupt controller
8010311a:	e8 71 f3 ff ff       	call   80102490 <ioapicinit>
  consoleinit();   // console hardware
8010311f:	90                   	nop
80103120:	e8 fb d8 ff ff       	call   80100a20 <consoleinit>
  uartinit();      // serial port
80103125:	e8 26 2d 00 00       	call   80105e50 <uartinit>
  pinit();         // process table
8010312a:	e8 41 08 00 00       	call   80103970 <pinit>
  tvinit();        // trap vectors
8010312f:	90                   	nop
80103130:	e8 0b 29 00 00       	call   80105a40 <tvinit>
  binit();         // buffer cache
80103135:	e8 06 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010313a:	e8 c1 dc ff ff       	call   80100e00 <fileinit>
  ideinit();       // disk 
8010313f:	90                   	nop
80103140:	e8 3b f1 ff ff       	call   80102280 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103145:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010314a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010314e:	b8 8c a4 10 80       	mov    $0x8010a48c,%eax
80103153:	89 44 24 04          	mov    %eax,0x4(%esp)
80103157:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
8010315e:	e8 9d 17 00 00       	call   80104900 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103163:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80103168:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010316b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010316e:	c1 e0 04             	shl    $0x4,%eax
80103171:	05 80 27 11 80       	add    $0x80112780,%eax
80103176:	3d 80 27 11 80       	cmp    $0x80112780,%eax
8010317b:	0f 86 7f 00 00 00    	jbe    80103200 <main+0x120>
80103181:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80103186:	eb 25                	jmp    801031ad <main+0xcd>
80103188:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010318f:	90                   	nop
80103190:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80103195:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010319b:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010319e:	8d 04 50             	lea    (%eax,%edx,2),%eax
801031a1:	c1 e0 04             	shl    $0x4,%eax
801031a4:	05 80 27 11 80       	add    $0x80112780,%eax
801031a9:	39 c3                	cmp    %eax,%ebx
801031ab:	73 53                	jae    80103200 <main+0x120>
    if(c == mycpu())  // We've started already.
801031ad:	e8 de 07 00 00       	call   80103990 <mycpu>
801031b2:	39 c3                	cmp    %eax,%ebx
801031b4:	74 da                	je     80103190 <main+0xb0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801031b6:	e8 85 f5 ff ff       	call   80102740 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
801031bb:	ba c0 30 10 80       	mov    $0x801030c0,%edx
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801031c0:	b9 00 90 10 00       	mov    $0x109000,%ecx
    *(void(**)(void))(code-8) = mpenter;
801031c5:	89 15 f8 6f 00 80    	mov    %edx,0x80006ff8
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801031cb:	89 0d f4 6f 00 80    	mov    %ecx,0x80006ff4
    *(void**)(code-4) = stack + KSTACKSIZE;
801031d1:	05 00 10 00 00       	add    $0x1000,%eax
801031d6:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801031db:	b8 00 70 00 00       	mov    $0x7000,%eax
801031e0:	89 44 24 04          	mov    %eax,0x4(%esp)
801031e4:	0f b6 03             	movzbl (%ebx),%eax
801031e7:	89 04 24             	mov    %eax,(%esp)
801031ea:	e8 21 f8 ff ff       	call   80102a10 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801031ef:	90                   	nop
801031f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801031f6:	85 c0                	test   %eax,%eax
801031f8:	74 f6                	je     801031f0 <main+0x110>
801031fa:	eb 94                	jmp    80103190 <main+0xb0>
801031fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103200:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103207:	b8 00 00 00 8e       	mov    $0x8e000000,%eax
8010320c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103210:	e8 cb f4 ff ff       	call   801026e0 <kinit2>
  userinit();      // first user process
80103215:	e8 36 08 00 00       	call   80103a50 <userinit>
  mpmain();        // finish this processor's setup
8010321a:	e8 51 fe ff ff       	call   80103070 <mpmain>
8010321f:	90                   	nop

80103220 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103220:	55                   	push   %ebp
80103221:	89 e5                	mov    %esp,%ebp
80103223:	57                   	push   %edi
80103224:	56                   	push   %esi
80103225:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
80103226:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010322c:	83 ec 1c             	sub    $0x1c,%esp
  e = addr+len;
8010322f:	8d 9c 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80103236:	39 de                	cmp    %ebx,%esi
80103238:	72 0c                	jb     80103246 <mpsearch1+0x26>
8010323a:	eb 54                	jmp    80103290 <mpsearch1+0x70>
8010323c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103240:	39 cb                	cmp    %ecx,%ebx
80103242:	89 ce                	mov    %ecx,%esi
80103244:	76 4a                	jbe    80103290 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103246:	89 34 24             	mov    %esi,(%esp)
80103249:	b8 04 00 00 00       	mov    $0x4,%eax
8010324e:	ba 58 78 10 80       	mov    $0x80107858,%edx
80103253:	89 44 24 08          	mov    %eax,0x8(%esp)
80103257:	89 54 24 04          	mov    %edx,0x4(%esp)
8010325b:	e8 50 16 00 00       	call   801048b0 <memcmp>
80103260:	8d 4e 10             	lea    0x10(%esi),%ecx
80103263:	85 c0                	test   %eax,%eax
80103265:	75 d9                	jne    80103240 <mpsearch1+0x20>
80103267:	89 f2                	mov    %esi,%edx
80103269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103270:	0f b6 3a             	movzbl (%edx),%edi
80103273:	42                   	inc    %edx
80103274:	01 f8                	add    %edi,%eax
  for(i=0; i<len; i++)
80103276:	39 ca                	cmp    %ecx,%edx
80103278:	75 f6                	jne    80103270 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010327a:	84 c0                	test   %al,%al
8010327c:	75 c2                	jne    80103240 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
8010327e:	83 c4 1c             	add    $0x1c,%esp
80103281:	89 f0                	mov    %esi,%eax
80103283:	5b                   	pop    %ebx
80103284:	5e                   	pop    %esi
80103285:	5f                   	pop    %edi
80103286:	5d                   	pop    %ebp
80103287:	c3                   	ret    
80103288:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010328f:	90                   	nop
80103290:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80103293:	31 f6                	xor    %esi,%esi
}
80103295:	5b                   	pop    %ebx
80103296:	89 f0                	mov    %esi,%eax
80103298:	5e                   	pop    %esi
80103299:	5f                   	pop    %edi
8010329a:	5d                   	pop    %ebp
8010329b:	c3                   	ret    
8010329c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032a0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	57                   	push   %edi
801032a4:	56                   	push   %esi
801032a5:	53                   	push   %ebx
801032a6:	83 ec 2c             	sub    $0x2c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801032a9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801032b0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801032b7:	c1 e0 08             	shl    $0x8,%eax
801032ba:	09 d0                	or     %edx,%eax
801032bc:	c1 e0 04             	shl    $0x4,%eax
801032bf:	75 1b                	jne    801032dc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801032c1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801032c8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801032cf:	c1 e0 08             	shl    $0x8,%eax
801032d2:	09 d0                	or     %edx,%eax
801032d4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801032d7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801032dc:	ba 00 04 00 00       	mov    $0x400,%edx
801032e1:	e8 3a ff ff ff       	call   80103220 <mpsearch1>
801032e6:	85 c0                	test   %eax,%eax
801032e8:	89 c6                	mov    %eax,%esi
801032ea:	0f 84 40 01 00 00    	je     80103430 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032f0:	8b 5e 04             	mov    0x4(%esi),%ebx
801032f3:	85 db                	test   %ebx,%ebx
801032f5:	0f 84 55 01 00 00    	je     80103450 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801032fb:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103301:	ba 04 00 00 00       	mov    $0x4,%edx
80103306:	89 54 24 08          	mov    %edx,0x8(%esp)
8010330a:	b9 5d 78 10 80       	mov    $0x8010785d,%ecx
8010330f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103313:	89 04 24             	mov    %eax,(%esp)
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103316:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103319:	e8 92 15 00 00       	call   801048b0 <memcmp>
8010331e:	85 c0                	test   %eax,%eax
80103320:	0f 85 2a 01 00 00    	jne    80103450 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103326:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010332d:	3c 01                	cmp    $0x1,%al
8010332f:	74 08                	je     80103339 <mpinit+0x99>
80103331:	3c 04                	cmp    $0x4,%al
80103333:	0f 85 17 01 00 00    	jne    80103450 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
80103339:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103340:	85 ff                	test   %edi,%edi
80103342:	74 22                	je     80103366 <mpinit+0xc6>
80103344:	89 d8                	mov    %ebx,%eax
80103346:	01 df                	add    %ebx,%edi
  sum = 0;
80103348:	31 d2                	xor    %edx,%edx
8010334a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103350:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103357:	40                   	inc    %eax
80103358:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010335a:	39 f8                	cmp    %edi,%eax
8010335c:	75 f2                	jne    80103350 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
8010335e:	84 d2                	test   %dl,%dl
80103360:	0f 85 ea 00 00 00    	jne    80103450 <mpinit+0x1b0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103366:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010336c:	8d 93 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%edx
  lapic = (uint*)conf->lapicaddr;
80103372:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103377:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010337a:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
  ismp = 1;
80103381:	bb 01 00 00 00       	mov    $0x1,%ebx
80103386:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103389:	01 c1                	add    %eax,%ecx
8010338b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010338f:	90                   	nop
80103390:	39 d1                	cmp    %edx,%ecx
80103392:	76 15                	jbe    801033a9 <mpinit+0x109>
    switch(*p){
80103394:	0f b6 02             	movzbl (%edx),%eax
80103397:	3c 02                	cmp    $0x2,%al
80103399:	74 55                	je     801033f0 <mpinit+0x150>
8010339b:	77 43                	ja     801033e0 <mpinit+0x140>
8010339d:	84 c0                	test   %al,%al
8010339f:	90                   	nop
801033a0:	74 5e                	je     80103400 <mpinit+0x160>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801033a2:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033a5:	39 d1                	cmp    %edx,%ecx
801033a7:	77 eb                	ja     80103394 <mpinit+0xf4>
801033a9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801033ac:	85 db                	test   %ebx,%ebx
801033ae:	0f 84 a8 00 00 00    	je     8010345c <mpinit+0x1bc>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801033b4:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801033b8:	74 11                	je     801033cb <mpinit+0x12b>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033ba:	b0 70                	mov    $0x70,%al
801033bc:	ba 22 00 00 00       	mov    $0x22,%edx
801033c1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801033c2:	ba 23 00 00 00       	mov    $0x23,%edx
801033c7:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801033c8:	0c 01                	or     $0x1,%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033ca:	ee                   	out    %al,(%dx)
  }
}
801033cb:	83 c4 2c             	add    $0x2c,%esp
801033ce:	5b                   	pop    %ebx
801033cf:	5e                   	pop    %esi
801033d0:	5f                   	pop    %edi
801033d1:	5d                   	pop    %ebp
801033d2:	c3                   	ret    
801033d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(*p){
801033e0:	2c 03                	sub    $0x3,%al
801033e2:	3c 01                	cmp    $0x1,%al
801033e4:	76 bc                	jbe    801033a2 <mpinit+0x102>
801033e6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801033ed:	eb a1                	jmp    80103390 <mpinit+0xf0>
801033ef:	90                   	nop
      ioapicid = ioapic->apicno;
801033f0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
801033f4:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
801033f7:	a2 60 27 11 80       	mov    %al,0x80112760
      continue;
801033fc:	eb 92                	jmp    80103390 <mpinit+0xf0>
801033fe:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103400:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80103405:	83 f8 07             	cmp    $0x7,%eax
80103408:	7f 19                	jg     80103423 <mpinit+0x183>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010340a:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
8010340e:	8d 3c 80             	lea    (%eax,%eax,4),%edi
80103411:	8d 3c 78             	lea    (%eax,%edi,2),%edi
        ncpu++;
80103414:	40                   	inc    %eax
80103415:	a3 00 2d 11 80       	mov    %eax,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010341a:	c1 e7 04             	shl    $0x4,%edi
8010341d:	88 9f 80 27 11 80    	mov    %bl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
80103423:	83 c2 14             	add    $0x14,%edx
      continue;
80103426:	e9 65 ff ff ff       	jmp    80103390 <mpinit+0xf0>
8010342b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010342f:	90                   	nop
  return mpsearch1(0xF0000, 0x10000);
80103430:	ba 00 00 01 00       	mov    $0x10000,%edx
80103435:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010343a:	e8 e1 fd ff ff       	call   80103220 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010343f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103441:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103443:	0f 85 a7 fe ff ff    	jne    801032f0 <mpinit+0x50>
80103449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103450:	c7 04 24 62 78 10 80 	movl   $0x80107862,(%esp)
80103457:	e8 04 cf ff ff       	call   80100360 <panic>
    panic("Didn't find a suitable machine");
8010345c:	c7 04 24 7c 78 10 80 	movl   $0x8010787c,(%esp)
80103463:	e8 f8 ce ff ff       	call   80100360 <panic>
80103468:	66 90                	xchg   %ax,%ax
8010346a:	66 90                	xchg   %ax,%ax
8010346c:	66 90                	xchg   %ax,%ax
8010346e:	66 90                	xchg   %ax,%ax

80103470 <picinit>:
80103470:	b0 ff                	mov    $0xff,%al
80103472:	ba 21 00 00 00       	mov    $0x21,%edx
80103477:	ee                   	out    %al,(%dx)
80103478:	ba a1 00 00 00       	mov    $0xa1,%edx
8010347d:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
8010347e:	c3                   	ret    
8010347f:	90                   	nop

80103480 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	83 ec 28             	sub    $0x28,%esp
80103486:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103489:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010348c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010348f:	8b 75 0c             	mov    0xc(%ebp),%esi
80103492:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103495:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010349b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801034a1:	e8 7a d9 ff ff       	call   80100e20 <filealloc>
801034a6:	89 03                	mov    %eax,(%ebx)
801034a8:	85 c0                	test   %eax,%eax
801034aa:	0f 84 ae 00 00 00    	je     8010355e <pipealloc+0xde>
801034b0:	e8 6b d9 ff ff       	call   80100e20 <filealloc>
801034b5:	89 06                	mov    %eax,(%esi)
801034b7:	85 c0                	test   %eax,%eax
801034b9:	0f 84 91 00 00 00    	je     80103550 <pipealloc+0xd0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801034bf:	e8 7c f2 ff ff       	call   80102740 <kalloc>
801034c4:	85 c0                	test   %eax,%eax
801034c6:	89 c7                	mov    %eax,%edi
801034c8:	0f 84 b2 00 00 00    	je     80103580 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
801034ce:	b8 01 00 00 00       	mov    $0x1,%eax
  p->writeopen = 1;
801034d3:	ba 01 00 00 00       	mov    $0x1,%edx
  p->readopen = 1;
801034d8:	89 87 3c 02 00 00    	mov    %eax,0x23c(%edi)
  p->nwrite = 0;
  p->nread = 0;
801034de:	31 c0                	xor    %eax,%eax
  p->nwrite = 0;
801034e0:	31 c9                	xor    %ecx,%ecx
  p->nread = 0;
801034e2:	89 87 34 02 00 00    	mov    %eax,0x234(%edi)
  initlock(&p->lock, "pipe");
801034e8:	b8 9b 78 10 80       	mov    $0x8010789b,%eax
  p->writeopen = 1;
801034ed:	89 97 40 02 00 00    	mov    %edx,0x240(%edi)
  p->nwrite = 0;
801034f3:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
  initlock(&p->lock, "pipe");
801034f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801034fd:	89 3c 24             	mov    %edi,(%esp)
80103500:	e8 cb 10 00 00       	call   801045d0 <initlock>
  (*f0)->type = FD_PIPE;
80103505:	8b 03                	mov    (%ebx),%eax
80103507:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010350d:	8b 03                	mov    (%ebx),%eax
8010350f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103513:	8b 03                	mov    (%ebx),%eax
80103515:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103519:	8b 03                	mov    (%ebx),%eax
8010351b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010351e:	8b 06                	mov    (%esi),%eax
80103520:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103526:	8b 06                	mov    (%esi),%eax
80103528:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010352c:	8b 06                	mov    (%esi),%eax
8010352e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103532:	8b 06                	mov    (%esi),%eax
80103534:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
80103537:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103539:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010353c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010353f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103542:	89 ec                	mov    %ebp,%esp
80103544:	5d                   	pop    %ebp
80103545:	c3                   	ret    
80103546:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010354d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103550:	8b 03                	mov    (%ebx),%eax
80103552:	85 c0                	test   %eax,%eax
80103554:	74 16                	je     8010356c <pipealloc+0xec>
    fileclose(*f0);
80103556:	89 04 24             	mov    %eax,(%esp)
80103559:	e8 82 d9 ff ff       	call   80100ee0 <fileclose>
  if(*f1)
8010355e:	8b 06                	mov    (%esi),%eax
80103560:	85 c0                	test   %eax,%eax
80103562:	74 08                	je     8010356c <pipealloc+0xec>
    fileclose(*f1);
80103564:	89 04 24             	mov    %eax,(%esp)
80103567:	e8 74 d9 ff ff       	call   80100ee0 <fileclose>
}
8010356c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  return -1;
8010356f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103574:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103577:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010357a:	89 ec                	mov    %ebp,%esp
8010357c:	5d                   	pop    %ebp
8010357d:	c3                   	ret    
8010357e:	66 90                	xchg   %ax,%ax
  if(*f0)
80103580:	8b 03                	mov    (%ebx),%eax
80103582:	85 c0                	test   %eax,%eax
80103584:	75 d0                	jne    80103556 <pipealloc+0xd6>
80103586:	eb d6                	jmp    8010355e <pipealloc+0xde>
80103588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010358f:	90                   	nop

80103590 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103590:	55                   	push   %ebp
80103591:	89 e5                	mov    %esp,%ebp
80103593:	83 ec 18             	sub    $0x18,%esp
80103596:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103599:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010359c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010359f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801035a2:	89 1c 24             	mov    %ebx,(%esp)
801035a5:	e8 96 11 00 00       	call   80104740 <acquire>
  if(writable){
801035aa:	85 f6                	test   %esi,%esi
801035ac:	74 42                	je     801035f0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801035ae:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801035b4:	31 f6                	xor    %esi,%esi
801035b6:	89 b3 40 02 00 00    	mov    %esi,0x240(%ebx)
    wakeup(&p->nread);
801035bc:	89 04 24             	mov    %eax,(%esp)
801035bf:	e8 0c 0d 00 00       	call   801042d0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801035c4:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801035ca:	85 d2                	test   %edx,%edx
801035cc:	75 0a                	jne    801035d8 <pipeclose+0x48>
801035ce:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801035d4:	85 c0                	test   %eax,%eax
801035d6:	74 38                	je     80103610 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801035db:	8b 75 fc             	mov    -0x4(%ebp),%esi
801035de:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801035e1:	89 ec                	mov    %ebp,%esp
801035e3:	5d                   	pop    %ebp
    release(&p->lock);
801035e4:	e9 07 12 00 00       	jmp    801047f0 <release>
801035e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801035f0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035f6:	31 c9                	xor    %ecx,%ecx
801035f8:	89 8b 3c 02 00 00    	mov    %ecx,0x23c(%ebx)
    wakeup(&p->nwrite);
801035fe:	89 04 24             	mov    %eax,(%esp)
80103601:	e8 ca 0c 00 00       	call   801042d0 <wakeup>
80103606:	eb bc                	jmp    801035c4 <pipeclose+0x34>
80103608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010360f:	90                   	nop
    release(&p->lock);
80103610:	89 1c 24             	mov    %ebx,(%esp)
80103613:	e8 d8 11 00 00       	call   801047f0 <release>
}
80103618:	8b 75 fc             	mov    -0x4(%ebp),%esi
    kfree((char*)p);
8010361b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010361e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103621:	89 ec                	mov    %ebp,%esp
80103623:	5d                   	pop    %ebp
    kfree((char*)p);
80103624:	e9 57 ef ff ff       	jmp    80102580 <kfree>
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103630 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	57                   	push   %edi
80103634:	56                   	push   %esi
80103635:	53                   	push   %ebx
80103636:	83 ec 2c             	sub    $0x2c,%esp
80103639:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010363c:	89 3c 24             	mov    %edi,(%esp)
8010363f:	e8 fc 10 00 00       	call   80104740 <acquire>
  for(i = 0; i < n; i++){
80103644:	8b 75 10             	mov    0x10(%ebp),%esi
80103647:	85 f6                	test   %esi,%esi
80103649:	0f 8e c7 00 00 00    	jle    80103716 <pipewrite+0xe6>
8010364f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103652:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
80103658:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010365b:	8b 87 38 02 00 00    	mov    0x238(%edi),%eax
80103661:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103664:	01 d9                	add    %ebx,%ecx
80103666:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103669:	8b 8f 34 02 00 00    	mov    0x234(%edi),%ecx
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010366f:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103675:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010367b:	39 d0                	cmp    %edx,%eax
8010367d:	74 46                	je     801036c5 <pipewrite+0x95>
8010367f:	eb 63                	jmp    801036e4 <pipewrite+0xb4>
80103681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010368f:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103690:	e8 8b 03 00 00       	call   80103a20 <myproc>
80103695:	8b 40 24             	mov    0x24(%eax),%eax
80103698:	85 c0                	test   %eax,%eax
8010369a:	75 33                	jne    801036cf <pipewrite+0x9f>
      wakeup(&p->nread);
8010369c:	89 34 24             	mov    %esi,(%esp)
8010369f:	e8 2c 0c 00 00       	call   801042d0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036a4:	89 7c 24 04          	mov    %edi,0x4(%esp)
801036a8:	89 1c 24             	mov    %ebx,(%esp)
801036ab:	e8 20 09 00 00       	call   80103fd0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036b0:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801036b6:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
801036bc:	05 00 02 00 00       	add    $0x200,%eax
801036c1:	39 c2                	cmp    %eax,%edx
801036c3:	75 2b                	jne    801036f0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801036c5:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
801036cb:	85 d2                	test   %edx,%edx
801036cd:	75 c1                	jne    80103690 <pipewrite+0x60>
        release(&p->lock);
801036cf:	89 3c 24             	mov    %edi,(%esp)
801036d2:	e8 19 11 00 00       	call   801047f0 <release>
        return -1;
801036d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801036dc:	83 c4 2c             	add    $0x2c,%esp
801036df:	5b                   	pop    %ebx
801036e0:	5e                   	pop    %esi
801036e1:	5f                   	pop    %edi
801036e2:	5d                   	pop    %ebp
801036e3:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036e4:	89 c2                	mov    %eax,%edx
801036e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036ed:	8d 76 00             	lea    0x0(%esi),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036f0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801036f3:	8d 42 01             	lea    0x1(%edx),%eax
801036f6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801036fc:	89 87 38 02 00 00    	mov    %eax,0x238(%edi)
80103702:	0f b6 0b             	movzbl (%ebx),%ecx
80103705:	43                   	inc    %ebx
  for(i = 0; i < n; i++){
80103706:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80103709:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010370c:	88 4c 17 34          	mov    %cl,0x34(%edi,%edx,1)
  for(i = 0; i < n; i++){
80103710:	0f 85 53 ff ff ff    	jne    80103669 <pipewrite+0x39>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103716:	8d 87 34 02 00 00    	lea    0x234(%edi),%eax
8010371c:	89 04 24             	mov    %eax,(%esp)
8010371f:	e8 ac 0b 00 00       	call   801042d0 <wakeup>
  release(&p->lock);
80103724:	89 3c 24             	mov    %edi,(%esp)
80103727:	e8 c4 10 00 00       	call   801047f0 <release>
  return n;
8010372c:	8b 45 10             	mov    0x10(%ebp),%eax
8010372f:	eb ab                	jmp    801036dc <pipewrite+0xac>
80103731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010373f:	90                   	nop

80103740 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	57                   	push   %edi
80103744:	56                   	push   %esi
80103745:	53                   	push   %ebx
80103746:	83 ec 1c             	sub    $0x1c,%esp
80103749:	8b 75 08             	mov    0x8(%ebp),%esi
8010374c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010374f:	89 34 24             	mov    %esi,(%esp)
80103752:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103758:	e8 e3 0f 00 00       	call   80104740 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010375d:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103763:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103769:	74 2f                	je     8010379a <piperead+0x5a>
8010376b:	eb 37                	jmp    801037a4 <piperead+0x64>
8010376d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103770:	e8 ab 02 00 00       	call   80103a20 <myproc>
80103775:	8b 48 24             	mov    0x24(%eax),%ecx
80103778:	85 c9                	test   %ecx,%ecx
8010377a:	0f 85 80 00 00 00    	jne    80103800 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103780:	89 74 24 04          	mov    %esi,0x4(%esp)
80103784:	89 1c 24             	mov    %ebx,(%esp)
80103787:	e8 44 08 00 00       	call   80103fd0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010378c:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103792:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103798:	75 0a                	jne    801037a4 <piperead+0x64>
8010379a:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
801037a0:	85 c0                	test   %eax,%eax
801037a2:	75 cc                	jne    80103770 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037a4:	8b 55 10             	mov    0x10(%ebp),%edx
801037a7:	31 db                	xor    %ebx,%ebx
801037a9:	85 d2                	test   %edx,%edx
801037ab:	7f 1f                	jg     801037cc <piperead+0x8c>
801037ad:	eb 2b                	jmp    801037da <piperead+0x9a>
801037af:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801037b0:	8d 48 01             	lea    0x1(%eax),%ecx
801037b3:	25 ff 01 00 00       	and    $0x1ff,%eax
801037b8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801037be:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801037c3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037c6:	43                   	inc    %ebx
801037c7:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801037ca:	74 0e                	je     801037da <piperead+0x9a>
    if(p->nread == p->nwrite)
801037cc:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801037d2:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037d8:	75 d6                	jne    801037b0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801037da:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801037e0:	89 04 24             	mov    %eax,(%esp)
801037e3:	e8 e8 0a 00 00       	call   801042d0 <wakeup>
  release(&p->lock);
801037e8:	89 34 24             	mov    %esi,(%esp)
801037eb:	e8 00 10 00 00       	call   801047f0 <release>
  return i;
}
801037f0:	83 c4 1c             	add    $0x1c,%esp
801037f3:	89 d8                	mov    %ebx,%eax
801037f5:	5b                   	pop    %ebx
801037f6:	5e                   	pop    %esi
801037f7:	5f                   	pop    %edi
801037f8:	5d                   	pop    %ebp
801037f9:	c3                   	ret    
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
80103800:	89 34 24             	mov    %esi,(%esp)
      return -1;
80103803:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103808:	e8 e3 0f 00 00       	call   801047f0 <release>
}
8010380d:	83 c4 1c             	add    $0x1c,%esp
80103810:	89 d8                	mov    %ebx,%eax
80103812:	5b                   	pop    %ebx
80103813:	5e                   	pop    %esi
80103814:	5f                   	pop    %edi
80103815:	5d                   	pop    %ebp
80103816:	c3                   	ret    
80103817:	66 90                	xchg   %ax,%ax
80103819:	66 90                	xchg   %ax,%ax
8010381b:	66 90                	xchg   %ax,%ax
8010381d:	66 90                	xchg   %ax,%ax
8010381f:	90                   	nop

80103820 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103824:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
80103829:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
8010382c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103833:	e8 08 0f 00 00       	call   80104740 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103838:	eb 18                	jmp    80103852 <allocproc+0x32>
8010383a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103840:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103846:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
8010384c:	0f 84 9e 00 00 00    	je     801038f0 <allocproc+0xd0>
    if(p->state == UNUSED)
80103852:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80103855:	85 c9                	test   %ecx,%ecx
80103857:	75 e7                	jne    80103840 <allocproc+0x20>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80103859:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103860:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103865:	89 43 10             	mov    %eax,0x10(%ebx)
80103868:	8d 50 01             	lea    0x1(%eax),%edx

  //***tweakinit***
  acquire(&tickslock);
8010386b:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
  p->pid = nextpid++;
80103872:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  acquire(&tickslock);
80103878:	e8 c3 0e 00 00       	call   80104740 <acquire>
  p->ctime = ticks;
8010387d:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80103882:	89 43 7c             	mov    %eax,0x7c(%ebx)
  release(&tickslock);
80103885:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
8010388c:	e8 5f 0f 00 00       	call   801047f0 <release>
  //***tweatend***

  release(&ptable.lock);
80103891:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103898:	e8 53 0f 00 00       	call   801047f0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010389d:	e8 9e ee ff ff       	call   80102740 <kalloc>
801038a2:	89 43 08             	mov    %eax,0x8(%ebx)
801038a5:	85 c0                	test   %eax,%eax
801038a7:	74 5d                	je     80103906 <allocproc+0xe6>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801038a9:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801038af:	b9 14 00 00 00       	mov    $0x14,%ecx
  sp -= sizeof *p->tf;
801038b4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801038b7:	ba 35 5a 10 80       	mov    $0x80105a35,%edx
  sp -= sizeof *p->context;
801038bc:	05 9c 0f 00 00       	add    $0xf9c,%eax
  *(uint*)sp = (uint)trapret;
801038c1:	89 50 14             	mov    %edx,0x14(%eax)
  memset(p->context, 0, sizeof *p->context);
801038c4:	31 d2                	xor    %edx,%edx
  p->context = (struct context*)sp;
801038c6:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801038c9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801038cd:	89 54 24 04          	mov    %edx,0x4(%esp)
801038d1:	89 04 24             	mov    %eax,(%esp)
801038d4:	e8 67 0f 00 00       	call   80104840 <memset>
  p->context->eip = (uint)forkret;
801038d9:	8b 43 1c             	mov    0x1c(%ebx),%eax
801038dc:	c7 40 10 20 39 10 80 	movl   $0x80103920,0x10(%eax)

  return p;
}
801038e3:	83 c4 14             	add    $0x14,%esp
801038e6:	89 d8                	mov    %ebx,%eax
801038e8:	5b                   	pop    %ebx
801038e9:	5d                   	pop    %ebp
801038ea:	c3                   	ret    
801038eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038ef:	90                   	nop
  release(&ptable.lock);
801038f0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  return 0;
801038f7:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801038f9:	e8 f2 0e 00 00       	call   801047f0 <release>
}
801038fe:	83 c4 14             	add    $0x14,%esp
80103901:	89 d8                	mov    %ebx,%eax
80103903:	5b                   	pop    %ebx
80103904:	5d                   	pop    %ebp
80103905:	c3                   	ret    
    p->state = UNUSED;
80103906:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010390d:	31 db                	xor    %ebx,%ebx
}
8010390f:	83 c4 14             	add    $0x14,%esp
80103912:	89 d8                	mov    %ebx,%eax
80103914:	5b                   	pop    %ebx
80103915:	5d                   	pop    %ebp
80103916:	c3                   	ret    
80103917:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010391e:	66 90                	xchg   %ax,%ax

80103920 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103926:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010392d:	e8 be 0e 00 00       	call   801047f0 <release>

  if (first) {
80103932:	8b 15 00 a0 10 80    	mov    0x8010a000,%edx
80103938:	85 d2                	test   %edx,%edx
8010393a:	75 04                	jne    80103940 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010393c:	c9                   	leave  
8010393d:	c3                   	ret    
8010393e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103940:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
80103947:	31 c0                	xor    %eax,%eax
80103949:	a3 00 a0 10 80       	mov    %eax,0x8010a000
    iinit(ROOTDEV);
8010394e:	e8 6d dc ff ff       	call   801015c0 <iinit>
    initlog(ROOTDEV);
80103953:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010395a:	e8 21 f4 ff ff       	call   80102d80 <initlog>
}
8010395f:	c9                   	leave  
80103960:	c3                   	ret    
80103961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103968:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010396f:	90                   	nop

80103970 <pinit>:
{
80103970:	55                   	push   %ebp
  initlock(&ptable.lock, "ptable");
80103971:	b8 a0 78 10 80       	mov    $0x801078a0,%eax
{
80103976:	89 e5                	mov    %esp,%ebp
80103978:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
8010397b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010397f:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103986:	e8 45 0c 00 00       	call   801045d0 <initlock>
}
8010398b:	c9                   	leave  
8010398c:	c3                   	ret    
8010398d:	8d 76 00             	lea    0x0(%esi),%esi

80103990 <mycpu>:
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	56                   	push   %esi
80103994:	53                   	push   %ebx
80103995:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103998:	9c                   	pushf  
80103999:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010399a:	f6 c4 02             	test   $0x2,%ah
8010399d:	75 52                	jne    801039f1 <mycpu+0x61>
  apicid = lapicid();
8010399f:	e8 1c f0 ff ff       	call   801029c0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801039a4:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801039aa:	85 f6                	test   %esi,%esi
  apicid = lapicid();
801039ac:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
801039ae:	7e 35                	jle    801039e5 <mycpu+0x55>
801039b0:	31 d2                	xor    %edx,%edx
801039b2:	eb 11                	jmp    801039c5 <mycpu+0x35>
801039b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039bf:	90                   	nop
801039c0:	42                   	inc    %edx
801039c1:	39 f2                	cmp    %esi,%edx
801039c3:	74 20                	je     801039e5 <mycpu+0x55>
    if (cpus[i].apicid == apicid)
801039c5:	8d 04 92             	lea    (%edx,%edx,4),%eax
801039c8:	8d 04 42             	lea    (%edx,%eax,2),%eax
801039cb:	c1 e0 04             	shl    $0x4,%eax
801039ce:	0f b6 88 80 27 11 80 	movzbl -0x7feed880(%eax),%ecx
801039d5:	39 d9                	cmp    %ebx,%ecx
801039d7:	75 e7                	jne    801039c0 <mycpu+0x30>
}
801039d9:	83 c4 10             	add    $0x10,%esp
      return &cpus[i];
801039dc:	05 80 27 11 80       	add    $0x80112780,%eax
}
801039e1:	5b                   	pop    %ebx
801039e2:	5e                   	pop    %esi
801039e3:	5d                   	pop    %ebp
801039e4:	c3                   	ret    
  panic("unknown apicid\n");
801039e5:	c7 04 24 a7 78 10 80 	movl   $0x801078a7,(%esp)
801039ec:	e8 6f c9 ff ff       	call   80100360 <panic>
    panic("mycpu called with interrupts enabled\n");
801039f1:	c7 04 24 84 79 10 80 	movl   $0x80107984,(%esp)
801039f8:	e8 63 c9 ff ff       	call   80100360 <panic>
801039fd:	8d 76 00             	lea    0x0(%esi),%esi

80103a00 <cpuid>:
cpuid() {
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a06:	e8 85 ff ff ff       	call   80103990 <mycpu>
}
80103a0b:	c9                   	leave  
  return mycpu()-cpus;
80103a0c:	2d 80 27 11 80       	sub    $0x80112780,%eax
80103a11:	c1 f8 04             	sar    $0x4,%eax
80103a14:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103a1a:	c3                   	ret    
80103a1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a1f:	90                   	nop

80103a20 <myproc>:
myproc(void) {
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	53                   	push   %ebx
80103a24:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103a27:	e8 14 0c 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103a2c:	e8 5f ff ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103a31:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a37:	e8 54 0c 00 00       	call   80104690 <popcli>
}
80103a3c:	5a                   	pop    %edx
80103a3d:	89 d8                	mov    %ebx,%eax
80103a3f:	5b                   	pop    %ebx
80103a40:	5d                   	pop    %ebp
80103a41:	c3                   	ret    
80103a42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a50 <userinit>:
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	53                   	push   %ebx
80103a54:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
80103a57:	e8 c4 fd ff ff       	call   80103820 <allocproc>
  initproc = p;
80103a5c:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  p = allocproc();
80103a61:	89 c3                	mov    %eax,%ebx
  if((p->pgdir = setupkvm()) == 0)
80103a63:	e8 28 36 00 00       	call   80107090 <setupkvm>
80103a68:	89 43 04             	mov    %eax,0x4(%ebx)
80103a6b:	85 c0                	test   %eax,%eax
80103a6d:	0f 84 cf 00 00 00    	je     80103b42 <userinit+0xf2>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a73:	89 04 24             	mov    %eax,(%esp)
80103a76:	b9 60 a4 10 80       	mov    $0x8010a460,%ecx
80103a7b:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103a80:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103a84:	89 54 24 08          	mov    %edx,0x8(%esp)
80103a88:	e8 b3 32 00 00       	call   80106d40 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a8d:	b8 4c 00 00 00       	mov    $0x4c,%eax
  p->sz = PGSIZE;
80103a92:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a98:	89 44 24 08          	mov    %eax,0x8(%esp)
80103a9c:	31 c0                	xor    %eax,%eax
80103a9e:	89 44 24 04          	mov    %eax,0x4(%esp)
80103aa2:	8b 43 18             	mov    0x18(%ebx),%eax
80103aa5:	89 04 24             	mov    %eax,(%esp)
80103aa8:	e8 93 0d 00 00       	call   80104840 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103aad:	8b 43 18             	mov    0x18(%ebx),%eax
80103ab0:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ab6:	8b 43 18             	mov    0x18(%ebx),%eax
80103ab9:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103abf:	8b 43 18             	mov    0x18(%ebx),%eax
80103ac2:	8b 50 2c             	mov    0x2c(%eax),%edx
80103ac5:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103ac9:	8b 43 18             	mov    0x18(%ebx),%eax
80103acc:	8b 50 2c             	mov    0x2c(%eax),%edx
80103acf:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103ad3:	8b 43 18             	mov    0x18(%ebx),%eax
80103ad6:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103add:	8b 43 18             	mov    0x18(%ebx),%eax
80103ae0:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103ae7:	8b 43 18             	mov    0x18(%ebx),%eax
80103aea:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103af1:	b8 10 00 00 00       	mov    $0x10,%eax
80103af6:	89 44 24 08          	mov    %eax,0x8(%esp)
80103afa:	b8 d0 78 10 80       	mov    $0x801078d0,%eax
80103aff:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b03:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b06:	89 04 24             	mov    %eax,(%esp)
80103b09:	e8 12 0f 00 00       	call   80104a20 <safestrcpy>
  p->cwd = namei("/");
80103b0e:	c7 04 24 d9 78 10 80 	movl   $0x801078d9,(%esp)
80103b15:	e8 56 e6 ff ff       	call   80102170 <namei>
80103b1a:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103b1d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b24:	e8 17 0c 00 00       	call   80104740 <acquire>
  p->state = RUNNABLE;
80103b29:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b30:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b37:	e8 b4 0c 00 00       	call   801047f0 <release>
}
80103b3c:	83 c4 14             	add    $0x14,%esp
80103b3f:	5b                   	pop    %ebx
80103b40:	5d                   	pop    %ebp
80103b41:	c3                   	ret    
    panic("userinit: out of memory?");
80103b42:	c7 04 24 b7 78 10 80 	movl   $0x801078b7,(%esp)
80103b49:	e8 12 c8 ff ff       	call   80100360 <panic>
80103b4e:	66 90                	xchg   %ax,%ax

80103b50 <growproc>:
{
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	56                   	push   %esi
80103b54:	53                   	push   %ebx
80103b55:	83 ec 10             	sub    $0x10,%esp
80103b58:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103b5b:	e8 e0 0a 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103b60:	e8 2b fe ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103b65:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b6b:	e8 20 0b 00 00       	call   80104690 <popcli>
  if(n > 0){
80103b70:	85 f6                	test   %esi,%esi
  sz = curproc->sz;
80103b72:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b74:	7f 1a                	jg     80103b90 <growproc+0x40>
  } else if(n < 0){
80103b76:	75 38                	jne    80103bb0 <growproc+0x60>
  curproc->sz = sz;
80103b78:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b7a:	89 1c 24             	mov    %ebx,(%esp)
80103b7d:	e8 be 30 00 00       	call   80106c40 <switchuvm>
  return 0;
80103b82:	31 c0                	xor    %eax,%eax
}
80103b84:	83 c4 10             	add    $0x10,%esp
80103b87:	5b                   	pop    %ebx
80103b88:	5e                   	pop    %esi
80103b89:	5d                   	pop    %ebp
80103b8a:	c3                   	ret    
80103b8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b8f:	90                   	nop
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b90:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b94:	01 c6                	add    %eax,%esi
80103b96:	89 74 24 08          	mov    %esi,0x8(%esp)
80103b9a:	8b 43 04             	mov    0x4(%ebx),%eax
80103b9d:	89 04 24             	mov    %eax,(%esp)
80103ba0:	e8 fb 32 00 00       	call   80106ea0 <allocuvm>
80103ba5:	85 c0                	test   %eax,%eax
80103ba7:	75 cf                	jne    80103b78 <growproc+0x28>
      return -1;
80103ba9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bae:	eb d4                	jmp    80103b84 <growproc+0x34>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103bb0:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bb4:	01 c6                	add    %eax,%esi
80103bb6:	89 74 24 08          	mov    %esi,0x8(%esp)
80103bba:	8b 43 04             	mov    0x4(%ebx),%eax
80103bbd:	89 04 24             	mov    %eax,(%esp)
80103bc0:	e8 1b 34 00 00       	call   80106fe0 <deallocuvm>
80103bc5:	85 c0                	test   %eax,%eax
80103bc7:	75 af                	jne    80103b78 <growproc+0x28>
80103bc9:	eb de                	jmp    80103ba9 <growproc+0x59>
80103bcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103bcf:	90                   	nop

80103bd0 <fork>:
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	57                   	push   %edi
80103bd4:	56                   	push   %esi
80103bd5:	53                   	push   %ebx
80103bd6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103bd9:	e8 62 0a 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103bde:	e8 ad fd ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103be3:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80103be9:	e8 a2 0a 00 00       	call   80104690 <popcli>
  if((np = allocproc()) == 0){
80103bee:	e8 2d fc ff ff       	call   80103820 <allocproc>
80103bf3:	85 c0                	test   %eax,%eax
80103bf5:	0f 84 c4 00 00 00    	je     80103cbf <fork+0xef>
80103bfb:	89 c6                	mov    %eax,%esi
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bfd:	8b 07                	mov    (%edi),%eax
80103bff:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c03:	8b 47 04             	mov    0x4(%edi),%eax
80103c06:	89 04 24             	mov    %eax,(%esp)
80103c09:	e8 62 35 00 00       	call   80107170 <copyuvm>
80103c0e:	89 46 04             	mov    %eax,0x4(%esi)
80103c11:	85 c0                	test   %eax,%eax
80103c13:	0f 84 ad 00 00 00    	je     80103cc6 <fork+0xf6>
  np->sz = curproc->sz;
80103c19:	8b 07                	mov    (%edi),%eax
  np->parent = curproc;
80103c1b:	89 7e 14             	mov    %edi,0x14(%esi)
  *np->tf = *curproc->tf;
80103c1e:	8b 4e 18             	mov    0x18(%esi),%ecx
  np->sz = curproc->sz;
80103c21:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103c23:	31 c0                	xor    %eax,%eax
80103c25:	8b 5f 18             	mov    0x18(%edi),%ebx
80103c28:	8b 14 03             	mov    (%ebx,%eax,1),%edx
80103c2b:	89 14 01             	mov    %edx,(%ecx,%eax,1)
80103c2e:	83 c0 04             	add    $0x4,%eax
80103c31:	83 f8 4c             	cmp    $0x4c,%eax
80103c34:	72 f2                	jb     80103c28 <fork+0x58>
  np->tf->eax = 0;
80103c36:	8b 46 18             	mov    0x18(%esi),%eax
  for(i = 0; i < NOFILE; i++)
80103c39:	31 db                	xor    %ebx,%ebx
  np->tf->eax = 0;
80103c3b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103c42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103c50:	8b 44 9f 28          	mov    0x28(%edi,%ebx,4),%eax
80103c54:	85 c0                	test   %eax,%eax
80103c56:	74 0c                	je     80103c64 <fork+0x94>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c58:	89 04 24             	mov    %eax,(%esp)
80103c5b:	e8 30 d2 ff ff       	call   80100e90 <filedup>
80103c60:	89 44 9e 28          	mov    %eax,0x28(%esi,%ebx,4)
  for(i = 0; i < NOFILE; i++)
80103c64:	43                   	inc    %ebx
80103c65:	83 fb 10             	cmp    $0x10,%ebx
80103c68:	75 e6                	jne    80103c50 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103c6a:	8b 47 68             	mov    0x68(%edi),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c6d:	83 c7 6c             	add    $0x6c,%edi
  np->cwd = idup(curproc->cwd);
80103c70:	89 04 24             	mov    %eax,(%esp)
80103c73:	e8 58 db ff ff       	call   801017d0 <idup>
80103c78:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c7b:	b8 10 00 00 00       	mov    $0x10,%eax
80103c80:	89 44 24 08          	mov    %eax,0x8(%esp)
80103c84:	8d 46 6c             	lea    0x6c(%esi),%eax
80103c87:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103c8b:	89 04 24             	mov    %eax,(%esp)
80103c8e:	e8 8d 0d 00 00       	call   80104a20 <safestrcpy>
  pid = np->pid;
80103c93:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103c96:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c9d:	e8 9e 0a 00 00       	call   80104740 <acquire>
  np->state = RUNNABLE;
80103ca2:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  release(&ptable.lock);
80103ca9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103cb0:	e8 3b 0b 00 00       	call   801047f0 <release>
}
80103cb5:	83 c4 1c             	add    $0x1c,%esp
80103cb8:	89 d8                	mov    %ebx,%eax
80103cba:	5b                   	pop    %ebx
80103cbb:	5e                   	pop    %esi
80103cbc:	5f                   	pop    %edi
80103cbd:	5d                   	pop    %ebp
80103cbe:	c3                   	ret    
    return -1;
80103cbf:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103cc4:	eb ef                	jmp    80103cb5 <fork+0xe5>
    kfree(np->kstack);
80103cc6:	8b 46 08             	mov    0x8(%esi),%eax
    return -1;
80103cc9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    kfree(np->kstack);
80103cce:	89 04 24             	mov    %eax,(%esp)
80103cd1:	e8 aa e8 ff ff       	call   80102580 <kfree>
    np->kstack = 0;
80103cd6:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    np->state = UNUSED;
80103cdd:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103ce4:	eb cf                	jmp    80103cb5 <fork+0xe5>
80103ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ced:	8d 76 00             	lea    0x0(%esi),%esi

80103cf0 <scheduler>:
{
80103cf0:	55                   	push   %ebp
80103cf1:	89 e5                	mov    %esp,%ebp
80103cf3:	57                   	push   %edi
80103cf4:	56                   	push   %esi
80103cf5:	53                   	push   %ebx
80103cf6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103cf9:	e8 92 fc ff ff       	call   80103990 <mycpu>
  c->proc = 0;
80103cfe:	31 d2                	xor    %edx,%edx
80103d00:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80103d06:	8d 78 04             	lea    0x4(%eax),%edi
  struct cpu *c = mycpu();
80103d09:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103d0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d0f:	90                   	nop
  asm volatile("sti");
80103d10:	fb                   	sti    
    acquire(&ptable.lock);
80103d11:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d18:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103d1d:	e8 1e 0a 00 00       	call   80104740 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->state != RUNNABLE)
80103d30:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d34:	75 31                	jne    80103d67 <scheduler+0x77>
      c->proc = p;
80103d36:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d3c:	89 1c 24             	mov    %ebx,(%esp)
80103d3f:	e8 fc 2e 00 00       	call   80106c40 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d44:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103d47:	89 3c 24             	mov    %edi,(%esp)
      p->state = RUNNING;
80103d4a:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103d51:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d55:	e8 1f 0d 00 00       	call   80104a79 <swtch>
      switchkvm();
80103d5a:	e8 d1 2e 00 00       	call   80106c30 <switchkvm>
      c->proc = 0;
80103d5f:	31 c0                	xor    %eax,%eax
80103d61:	89 86 ac 00 00 00    	mov    %eax,0xac(%esi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d67:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103d6d:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103d73:	75 bb                	jne    80103d30 <scheduler+0x40>
    release(&ptable.lock);
80103d75:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d7c:	e8 6f 0a 00 00       	call   801047f0 <release>
    sti();
80103d81:	eb 8d                	jmp    80103d10 <scheduler+0x20>
80103d83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103d90 <sched>:
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	56                   	push   %esi
80103d94:	53                   	push   %ebx
80103d95:	83 ec 10             	sub    $0x10,%esp
  pushcli();
80103d98:	e8 a3 08 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103d9d:	e8 ee fb ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103da2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103da8:	e8 e3 08 00 00       	call   80104690 <popcli>
  if(!holding(&ptable.lock))
80103dad:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103db4:	e8 37 09 00 00       	call   801046f0 <holding>
80103db9:	85 c0                	test   %eax,%eax
80103dbb:	74 4f                	je     80103e0c <sched+0x7c>
  if(mycpu()->ncli != 1)
80103dbd:	e8 ce fb ff ff       	call   80103990 <mycpu>
80103dc2:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dc9:	75 65                	jne    80103e30 <sched+0xa0>
  if(p->state == RUNNING)
80103dcb:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103dcf:	74 53                	je     80103e24 <sched+0x94>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103dd1:	9c                   	pushf  
80103dd2:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103dd3:	f6 c4 02             	test   $0x2,%ah
80103dd6:	75 40                	jne    80103e18 <sched+0x88>
  intena = mycpu()->intena;
80103dd8:	e8 b3 fb ff ff       	call   80103990 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103ddd:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103de0:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103de6:	e8 a5 fb ff ff       	call   80103990 <mycpu>
80103deb:	8b 40 04             	mov    0x4(%eax),%eax
80103dee:	89 1c 24             	mov    %ebx,(%esp)
80103df1:	89 44 24 04          	mov    %eax,0x4(%esp)
80103df5:	e8 7f 0c 00 00       	call   80104a79 <swtch>
  mycpu()->intena = intena;
80103dfa:	e8 91 fb ff ff       	call   80103990 <mycpu>
80103dff:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e05:	83 c4 10             	add    $0x10,%esp
80103e08:	5b                   	pop    %ebx
80103e09:	5e                   	pop    %esi
80103e0a:	5d                   	pop    %ebp
80103e0b:	c3                   	ret    
    panic("sched ptable.lock");
80103e0c:	c7 04 24 db 78 10 80 	movl   $0x801078db,(%esp)
80103e13:	e8 48 c5 ff ff       	call   80100360 <panic>
    panic("sched interruptible");
80103e18:	c7 04 24 07 79 10 80 	movl   $0x80107907,(%esp)
80103e1f:	e8 3c c5 ff ff       	call   80100360 <panic>
    panic("sched running");
80103e24:	c7 04 24 f9 78 10 80 	movl   $0x801078f9,(%esp)
80103e2b:	e8 30 c5 ff ff       	call   80100360 <panic>
    panic("sched locks");
80103e30:	c7 04 24 ed 78 10 80 	movl   $0x801078ed,(%esp)
80103e37:	e8 24 c5 ff ff       	call   80100360 <panic>
80103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e40 <exit>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103e49:	e8 f2 07 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103e4e:	e8 3d fb ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103e53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e59:	e8 32 08 00 00       	call   80104690 <popcli>
  if(curproc == initproc)
80103e5e:	39 1d b8 a5 10 80    	cmp    %ebx,0x8010a5b8
80103e64:	0f 84 09 01 00 00    	je     80103f73 <exit+0x133>
80103e6a:	8d 73 28             	lea    0x28(%ebx),%esi
80103e6d:	8d 7b 68             	lea    0x68(%ebx),%edi
    if(curproc->ofile[fd]){
80103e70:	8b 06                	mov    (%esi),%eax
80103e72:	85 c0                	test   %eax,%eax
80103e74:	74 0e                	je     80103e84 <exit+0x44>
      fileclose(curproc->ofile[fd]);
80103e76:	89 04 24             	mov    %eax,(%esp)
80103e79:	e8 62 d0 ff ff       	call   80100ee0 <fileclose>
      curproc->ofile[fd] = 0;
80103e7e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(fd = 0; fd < NOFILE; fd++){
80103e84:	83 c6 04             	add    $0x4,%esi
80103e87:	39 f7                	cmp    %esi,%edi
80103e89:	75 e5                	jne    80103e70 <exit+0x30>
  begin_op();
80103e8b:	e8 80 ef ff ff       	call   80102e10 <begin_op>
  iput(curproc->cwd);
80103e90:	8b 43 68             	mov    0x68(%ebx),%eax
80103e93:	89 04 24             	mov    %eax,(%esp)
80103e96:	e8 95 da ff ff       	call   80101930 <iput>
  end_op();
80103e9b:	e8 e0 ef ff ff       	call   80102e80 <end_op>
  curproc->cwd = 0;
80103ea0:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103ea7:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eae:	e8 8d 08 00 00       	call   80104740 <acquire>
  wakeup1(curproc->parent);
80103eb3:	8b 53 14             	mov    0x14(%ebx),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eb6:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103ebb:	eb 0f                	jmp    80103ecc <exit+0x8c>
80103ebd:	8d 76 00             	lea    0x0(%esi),%esi
80103ec0:	05 8c 00 00 00       	add    $0x8c,%eax
80103ec5:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103eca:	74 1e                	je     80103eea <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
80103ecc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ed0:	75 ee                	jne    80103ec0 <exit+0x80>
80103ed2:	3b 50 20             	cmp    0x20(%eax),%edx
80103ed5:	75 e9                	jne    80103ec0 <exit+0x80>
      p->state = RUNNABLE;
80103ed7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ede:	05 8c 00 00 00       	add    $0x8c,%eax
80103ee3:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103ee8:	75 e2                	jne    80103ecc <exit+0x8c>
      p->parent = initproc;
80103eea:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ef0:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103ef5:	eb 17                	jmp    80103f0e <exit+0xce>
80103ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103efe:	66 90                	xchg   %ax,%ax
80103f00:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103f06:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103f0c:	74 42                	je     80103f50 <exit+0x110>
    if(p->parent == curproc){
80103f0e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103f11:	75 ed                	jne    80103f00 <exit+0xc0>
      if(p->state == ZOMBIE)
80103f13:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f17:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f1a:	75 e4                	jne    80103f00 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f1c:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f21:	eb 19                	jmp    80103f3c <exit+0xfc>
80103f23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f30:	05 8c 00 00 00       	add    $0x8c,%eax
80103f35:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103f3a:	74 c4                	je     80103f00 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103f3c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f40:	75 ee                	jne    80103f30 <exit+0xf0>
80103f42:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f45:	75 e9                	jne    80103f30 <exit+0xf0>
      p->state = RUNNABLE;
80103f47:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f4e:	eb e0                	jmp    80103f30 <exit+0xf0>
  curproc->state = ZOMBIE;
80103f50:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  curproc -> etime = ticks;
80103f57:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80103f5c:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  sched();
80103f62:	e8 29 fe ff ff       	call   80103d90 <sched>
  panic("zombie exit");
80103f67:	c7 04 24 28 79 10 80 	movl   $0x80107928,(%esp)
80103f6e:	e8 ed c3 ff ff       	call   80100360 <panic>
    panic("init exiting");
80103f73:	c7 04 24 1b 79 10 80 	movl   $0x8010791b,(%esp)
80103f7a:	e8 e1 c3 ff ff       	call   80100360 <panic>
80103f7f:	90                   	nop

80103f80 <yield>:
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	53                   	push   %ebx
80103f84:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f87:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f8e:	e8 ad 07 00 00       	call   80104740 <acquire>
  pushcli();
80103f93:	e8 a8 06 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103f98:	e8 f3 f9 ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103f9d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fa3:	e8 e8 06 00 00       	call   80104690 <popcli>
  myproc()->state = RUNNABLE;
80103fa8:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103faf:	e8 dc fd ff ff       	call   80103d90 <sched>
  release(&ptable.lock);
80103fb4:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fbb:	e8 30 08 00 00       	call   801047f0 <release>
}
80103fc0:	83 c4 14             	add    $0x14,%esp
80103fc3:	5b                   	pop    %ebx
80103fc4:	5d                   	pop    %ebp
80103fc5:	c3                   	ret    
80103fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fcd:	8d 76 00             	lea    0x0(%esi),%esi

80103fd0 <sleep>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	83 ec 28             	sub    $0x28,%esp
80103fd6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103fd9:	89 75 f8             	mov    %esi,-0x8(%ebp)
80103fdc:	8b 75 0c             	mov    0xc(%ebp),%esi
80103fdf:	89 7d fc             	mov    %edi,-0x4(%ebp)
80103fe2:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80103fe5:	e8 56 06 00 00       	call   80104640 <pushcli>
  c = mycpu();
80103fea:	e8 a1 f9 ff ff       	call   80103990 <mycpu>
  p = c->proc;
80103fef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ff5:	e8 96 06 00 00       	call   80104690 <popcli>
  if(p == 0)
80103ffa:	85 db                	test   %ebx,%ebx
80103ffc:	0f 84 8d 00 00 00    	je     8010408f <sleep+0xbf>
  if(lk == 0)
80104002:	85 f6                	test   %esi,%esi
80104004:	74 7d                	je     80104083 <sleep+0xb3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104006:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
8010400c:	74 52                	je     80104060 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010400e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104015:	e8 26 07 00 00       	call   80104740 <acquire>
    release(lk);
8010401a:	89 34 24             	mov    %esi,(%esp)
8010401d:	e8 ce 07 00 00       	call   801047f0 <release>
  p->chan = chan;
80104022:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104025:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010402c:	e8 5f fd ff ff       	call   80103d90 <sched>
  p->chan = 0;
80104031:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104038:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010403f:	e8 ac 07 00 00       	call   801047f0 <release>
}
80104044:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    acquire(lk);
80104047:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010404a:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010404d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104050:	89 ec                	mov    %ebp,%esp
80104052:	5d                   	pop    %ebp
    acquire(lk);
80104053:	e9 e8 06 00 00       	jmp    80104740 <acquire>
80104058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010405f:	90                   	nop
  p->chan = chan;
80104060:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104063:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010406a:	e8 21 fd ff ff       	call   80103d90 <sched>
  p->chan = 0;
8010406f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104076:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104079:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010407c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010407f:	89 ec                	mov    %ebp,%esp
80104081:	5d                   	pop    %ebp
80104082:	c3                   	ret    
    panic("sleep without lk");
80104083:	c7 04 24 3a 79 10 80 	movl   $0x8010793a,(%esp)
8010408a:	e8 d1 c2 ff ff       	call   80100360 <panic>
    panic("sleep");
8010408f:	c7 04 24 34 79 10 80 	movl   $0x80107934,(%esp)
80104096:	e8 c5 c2 ff ff       	call   80100360 <panic>
8010409b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010409f:	90                   	nop

801040a0 <wait>:
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	56                   	push   %esi
801040a4:	53                   	push   %ebx
801040a5:	83 ec 10             	sub    $0x10,%esp
  pushcli();
801040a8:	e8 93 05 00 00       	call   80104640 <pushcli>
  c = mycpu();
801040ad:	e8 de f8 ff ff       	call   80103990 <mycpu>
  p = c->proc;
801040b2:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801040b8:	e8 d3 05 00 00       	call   80104690 <popcli>
  acquire(&ptable.lock);
801040bd:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040c4:	e8 77 06 00 00       	call   80104740 <acquire>
    havekids = 0;
801040c9:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040cb:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801040d0:	eb 1c                	jmp    801040ee <wait+0x4e>
801040d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040e0:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801040e6:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
801040ec:	74 1e                	je     8010410c <wait+0x6c>
      if(p->parent != curproc)
801040ee:	39 73 14             	cmp    %esi,0x14(%ebx)
801040f1:	75 ed                	jne    801040e0 <wait+0x40>
      if(p->state == ZOMBIE){
801040f3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801040f7:	74 37                	je     80104130 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f9:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
801040ff:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104104:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
8010410a:	75 e2                	jne    801040ee <wait+0x4e>
    if(!havekids || curproc->killed){
8010410c:	85 c0                	test   %eax,%eax
8010410e:	74 75                	je     80104185 <wait+0xe5>
80104110:	8b 56 24             	mov    0x24(%esi),%edx
80104113:	85 d2                	test   %edx,%edx
80104115:	75 6e                	jne    80104185 <wait+0xe5>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104117:	89 34 24             	mov    %esi,(%esp)
8010411a:	b8 20 2d 11 80       	mov    $0x80112d20,%eax
8010411f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104123:	e8 a8 fe ff ff       	call   80103fd0 <sleep>
    havekids = 0;
80104128:	eb 9f                	jmp    801040c9 <wait+0x29>
8010412a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104130:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80104133:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104136:	89 04 24             	mov    %eax,(%esp)
80104139:	e8 42 e4 ff ff       	call   80102580 <kfree>
        freevm(p->pgdir);
8010413e:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80104141:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104148:	89 04 24             	mov    %eax,(%esp)
8010414b:	e8 c0 2e 00 00       	call   80107010 <freevm>
        release(&ptable.lock);
80104150:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80104157:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010415e:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104165:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104169:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104170:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104177:	e8 74 06 00 00       	call   801047f0 <release>
}
8010417c:	83 c4 10             	add    $0x10,%esp
8010417f:	89 f0                	mov    %esi,%eax
80104181:	5b                   	pop    %ebx
80104182:	5e                   	pop    %esi
80104183:	5d                   	pop    %ebp
80104184:	c3                   	ret    
      release(&ptable.lock);
80104185:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
      return -1;
8010418c:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104191:	e8 5a 06 00 00       	call   801047f0 <release>
      return -1;
80104196:	eb e4                	jmp    8010417c <wait+0xdc>
80104198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010419f:	90                   	nop

801041a0 <waitx>:
int waitx(int* wtime, int* rtime){
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	56                   	push   %esi
801041a4:	53                   	push   %ebx
801041a5:	83 ec 10             	sub    $0x10,%esp
  pushcli();
801041a8:	e8 93 04 00 00       	call   80104640 <pushcli>
  c = mycpu();
801041ad:	e8 de f7 ff ff       	call   80103990 <mycpu>
  p = c->proc;
801041b2:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041b8:	e8 d3 04 00 00       	call   80104690 <popcli>
  acquire(&ptable.lock);
801041bd:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801041c4:	e8 77 05 00 00       	call   80104740 <acquire>
    havekids = 0;
801041c9:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC] ; p++){
801041cb:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801041d0:	eb 1c                	jmp    801041ee <waitx+0x4e>
801041d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041e0:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801041e6:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
801041ec:	74 1e                	je     8010420c <waitx+0x6c>
      if( p -> parent != curproc )
801041ee:	39 73 14             	cmp    %esi,0x14(%ebx)
801041f1:	75 ed                	jne    801041e0 <waitx+0x40>
      if( p -> state == ZOMBIE ){
801041f3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801041f7:	74 47                	je     80104240 <waitx+0xa0>
    for(p = ptable.proc; p < &ptable.proc[NPROC] ; p++){
801041f9:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
801041ff:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC] ; p++){
80104204:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
8010420a:	75 e2                	jne    801041ee <waitx+0x4e>
    if( !havekids || curproc -> killed ){
8010420c:	85 c0                	test   %eax,%eax
8010420e:	0f 84 a4 00 00 00    	je     801042b8 <waitx+0x118>
80104214:	8b 56 24             	mov    0x24(%esi),%edx
80104217:	85 d2                	test   %edx,%edx
80104219:	0f 85 99 00 00 00    	jne    801042b8 <waitx+0x118>
    sleep(curproc, &ptable.lock);     //DOC: wait-sleep
8010421f:	89 34 24             	mov    %esi,(%esp)
80104222:	b8 20 2d 11 80       	mov    $0x80112d20,%eax
80104227:	89 44 24 04          	mov    %eax,0x4(%esp)
8010422b:	e8 a0 fd ff ff       	call   80103fd0 <sleep>
    havekids = 0;
80104230:	eb 97                	jmp    801041c9 <waitx+0x29>
80104232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        *rtime = p -> rtime;
80104240:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
80104246:	8b 45 0c             	mov    0xc(%ebp),%eax
80104249:	89 10                	mov    %edx,(%eax)
        *wtime = p -> etime - p -> ctime - p -> rtime;
8010424b:	8b 55 08             	mov    0x8(%ebp),%edx
8010424e:	8b 4b 7c             	mov    0x7c(%ebx),%ecx
80104251:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80104257:	8b b3 88 00 00 00    	mov    0x88(%ebx),%esi
8010425d:	29 c8                	sub    %ecx,%eax
8010425f:	29 f0                	sub    %esi,%eax
80104261:	89 02                	mov    %eax,(%edx)
        kfree(p -> kstack);
80104263:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p -> pid;
80104266:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p -> kstack);
80104269:	89 04 24             	mov    %eax,(%esp)
8010426c:	e8 0f e3 ff ff       	call   80102580 <kfree>
        freevm(p -> pgdir);
80104271:	8b 43 04             	mov    0x4(%ebx),%eax
        p -> kstack = 0;
80104274:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p -> pgdir);
8010427b:	89 04 24             	mov    %eax,(%esp)
8010427e:	e8 8d 2d 00 00       	call   80107010 <freevm>
        release(&ptable.lock);
80104283:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p -> pid = 0;
8010428a:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p -> parent = 0;
80104291:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p -> name[0] = 0;
80104298:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p -> killed = 0;
8010429c:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p -> state = UNUSED;
801042a3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801042aa:	e8 41 05 00 00       	call   801047f0 <release>
}
801042af:	83 c4 10             	add    $0x10,%esp
801042b2:	89 f0                	mov    %esi,%eax
801042b4:	5b                   	pop    %ebx
801042b5:	5e                   	pop    %esi
801042b6:	5d                   	pop    %ebp
801042b7:	c3                   	ret    
      release(&ptable.lock);
801042b8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
      return -1;
801042bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801042c4:	e8 27 05 00 00       	call   801047f0 <release>
      return -1;
801042c9:	eb e4                	jmp    801042af <waitx+0x10f>
801042cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042cf:	90                   	nop

801042d0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx
801042d4:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
801042d7:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
{
801042de:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801042e1:	e8 5a 04 00 00       	call   80104740 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042e6:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801042eb:	eb 0f                	jmp    801042fc <wakeup+0x2c>
801042ed:	8d 76 00             	lea    0x0(%esi),%esi
801042f0:	05 8c 00 00 00       	add    $0x8c,%eax
801042f5:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801042fa:	74 1e                	je     8010431a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801042fc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104300:	75 ee                	jne    801042f0 <wakeup+0x20>
80104302:	3b 58 20             	cmp    0x20(%eax),%ebx
80104305:	75 e9                	jne    801042f0 <wakeup+0x20>
      p->state = RUNNABLE;
80104307:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010430e:	05 8c 00 00 00       	add    $0x8c,%eax
80104313:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104318:	75 e2                	jne    801042fc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010431a:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104321:	83 c4 14             	add    $0x14,%esp
80104324:	5b                   	pop    %ebx
80104325:	5d                   	pop    %ebp
  release(&ptable.lock);
80104326:	e9 c5 04 00 00       	jmp    801047f0 <release>
8010432b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010432f:	90                   	nop

80104330 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104337:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
{
8010433e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104341:	e8 fa 03 00 00       	call   80104740 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104346:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010434b:	eb 0f                	jmp    8010435c <kill+0x2c>
8010434d:	8d 76 00             	lea    0x0(%esi),%esi
80104350:	05 8c 00 00 00       	add    $0x8c,%eax
80104355:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010435a:	74 34                	je     80104390 <kill+0x60>
    if(p->pid == pid){
8010435c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010435f:	75 ef                	jne    80104350 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104361:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104365:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010436c:	75 07                	jne    80104375 <kill+0x45>
        p->state = RUNNABLE;
8010436e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104375:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010437c:	e8 6f 04 00 00       	call   801047f0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104381:	83 c4 14             	add    $0x14,%esp
      return 0;
80104384:	31 c0                	xor    %eax,%eax
}
80104386:	5b                   	pop    %ebx
80104387:	5d                   	pop    %ebp
80104388:	c3                   	ret    
80104389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104390:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104397:	e8 54 04 00 00       	call   801047f0 <release>
}
8010439c:	83 c4 14             	add    $0x14,%esp
  return -1;
8010439f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801043a4:	5b                   	pop    %ebx
801043a5:	5d                   	pop    %ebp
801043a6:	c3                   	ret    
801043a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043ae:	66 90                	xchg   %ax,%ax

801043b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	57                   	push   %edi
801043b4:	56                   	push   %esi
801043b5:	53                   	push   %ebx
801043b6:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801043bb:	8d 75 e8             	lea    -0x18(%ebp),%esi
801043be:	83 ec 4c             	sub    $0x4c,%esp
801043c1:	eb 2b                	jmp    801043ee <procdump+0x3e>
801043c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801043d0:	c7 04 24 bb 7c 10 80 	movl   $0x80107cbb,(%esp)
801043d7:	e8 a4 c2 ff ff       	call   80100680 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043dc:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801043e2:	81 fb c0 50 11 80    	cmp    $0x801150c0,%ebx
801043e8:	0f 84 92 00 00 00    	je     80104480 <procdump+0xd0>
    if(p->state == UNUSED)
801043ee:	8b 43 a0             	mov    -0x60(%ebx),%eax
801043f1:	85 c0                	test   %eax,%eax
801043f3:	74 e7                	je     801043dc <procdump+0x2c>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043f5:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801043f8:	ba 4b 79 10 80       	mov    $0x8010794b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043fd:	77 11                	ja     80104410 <procdump+0x60>
801043ff:	8b 14 85 ac 79 10 80 	mov    -0x7fef8654(,%eax,4),%edx
      state = "???";
80104406:	b8 4b 79 10 80       	mov    $0x8010794b,%eax
8010440b:	85 d2                	test   %edx,%edx
8010440d:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104410:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80104414:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80104417:	89 54 24 08          	mov    %edx,0x8(%esp)
8010441b:	c7 04 24 4f 79 10 80 	movl   $0x8010794f,(%esp)
80104422:	89 44 24 04          	mov    %eax,0x4(%esp)
80104426:	e8 55 c2 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
8010442b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010442f:	75 9f                	jne    801043d0 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104431:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104434:	89 44 24 04          	mov    %eax,0x4(%esp)
80104438:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010443b:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010443e:	8b 40 0c             	mov    0xc(%eax),%eax
80104441:	83 c0 08             	add    $0x8,%eax
80104444:	89 04 24             	mov    %eax,(%esp)
80104447:	e8 a4 01 00 00       	call   801045f0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010444c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104450:	8b 17                	mov    (%edi),%edx
80104452:	85 d2                	test   %edx,%edx
80104454:	0f 84 76 ff ff ff    	je     801043d0 <procdump+0x20>
        cprintf(" %p", pc[i]);
8010445a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010445e:	83 c7 04             	add    $0x4,%edi
80104461:	c7 04 24 a1 73 10 80 	movl   $0x801073a1,(%esp)
80104468:	e8 13 c2 ff ff       	call   80100680 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010446d:	39 fe                	cmp    %edi,%esi
8010446f:	75 df                	jne    80104450 <procdump+0xa0>
80104471:	e9 5a ff ff ff       	jmp    801043d0 <procdump+0x20>
80104476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010447d:	8d 76 00             	lea    0x0(%esi),%esi
  }
}
80104480:	83 c4 4c             	add    $0x4c,%esp
80104483:	5b                   	pop    %ebx
80104484:	5e                   	pop    %esi
80104485:	5f                   	pop    %edi
80104486:	5d                   	pop    %ebp
80104487:	c3                   	ret    
80104488:	66 90                	xchg   %ax,%ax
8010448a:	66 90                	xchg   %ax,%ax
8010448c:	66 90                	xchg   %ax,%ax
8010448e:	66 90                	xchg   %ax,%ax

80104490 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104490:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80104491:	b8 c4 79 10 80       	mov    $0x801079c4,%eax
{
80104496:	89 e5                	mov    %esp,%ebp
80104498:	53                   	push   %ebx
80104499:	83 ec 14             	sub    $0x14,%esp
  initlock(&lk->lk, "sleep lock");
8010449c:	89 44 24 04          	mov    %eax,0x4(%esp)
{
801044a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801044a3:	8d 43 04             	lea    0x4(%ebx),%eax
801044a6:	89 04 24             	mov    %eax,(%esp)
801044a9:	e8 22 01 00 00       	call   801045d0 <initlock>
  lk->name = name;
801044ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801044b1:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801044b7:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801044be:	89 43 38             	mov    %eax,0x38(%ebx)
}
801044c1:	83 c4 14             	add    $0x14,%esp
801044c4:	5b                   	pop    %ebx
801044c5:	5d                   	pop    %ebp
801044c6:	c3                   	ret    
801044c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044ce:	66 90                	xchg   %ax,%ax

801044d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	56                   	push   %esi
801044d4:	53                   	push   %ebx
801044d5:	83 ec 10             	sub    $0x10,%esp
801044d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044db:	8d 73 04             	lea    0x4(%ebx),%esi
801044de:	89 34 24             	mov    %esi,(%esp)
801044e1:	e8 5a 02 00 00       	call   80104740 <acquire>
  while (lk->locked) {
801044e6:	8b 13                	mov    (%ebx),%edx
801044e8:	85 d2                	test   %edx,%edx
801044ea:	74 16                	je     80104502 <acquiresleep+0x32>
801044ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801044f0:	89 74 24 04          	mov    %esi,0x4(%esp)
801044f4:	89 1c 24             	mov    %ebx,(%esp)
801044f7:	e8 d4 fa ff ff       	call   80103fd0 <sleep>
  while (lk->locked) {
801044fc:	8b 03                	mov    (%ebx),%eax
801044fe:	85 c0                	test   %eax,%eax
80104500:	75 ee                	jne    801044f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104502:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104508:	e8 13 f5 ff ff       	call   80103a20 <myproc>
8010450d:	8b 40 10             	mov    0x10(%eax),%eax
80104510:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104513:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104516:	83 c4 10             	add    $0x10,%esp
80104519:	5b                   	pop    %ebx
8010451a:	5e                   	pop    %esi
8010451b:	5d                   	pop    %ebp
  release(&lk->lk);
8010451c:	e9 cf 02 00 00       	jmp    801047f0 <release>
80104521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010452f:	90                   	nop

80104530 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	83 ec 18             	sub    $0x18,%esp
80104536:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104539:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010453c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010453f:	8d 73 04             	lea    0x4(%ebx),%esi
80104542:	89 34 24             	mov    %esi,(%esp)
80104545:	e8 f6 01 00 00       	call   80104740 <acquire>
  lk->locked = 0;
8010454a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104550:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104557:	89 1c 24             	mov    %ebx,(%esp)
8010455a:	e8 71 fd ff ff       	call   801042d0 <wakeup>
  release(&lk->lk);
}
8010455f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  release(&lk->lk);
80104562:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104565:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104568:	89 ec                	mov    %ebp,%esp
8010456a:	5d                   	pop    %ebp
  release(&lk->lk);
8010456b:	e9 80 02 00 00       	jmp    801047f0 <release>

80104570 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	83 ec 28             	sub    $0x28,%esp
80104576:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104579:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010457c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010457f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104582:	31 ff                	xor    %edi,%edi
  int r;
  
  acquire(&lk->lk);
80104584:	8d 73 04             	lea    0x4(%ebx),%esi
80104587:	89 34 24             	mov    %esi,(%esp)
8010458a:	e8 b1 01 00 00       	call   80104740 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010458f:	8b 03                	mov    (%ebx),%eax
80104591:	85 c0                	test   %eax,%eax
80104593:	75 1b                	jne    801045b0 <holdingsleep+0x40>
  release(&lk->lk);
80104595:	89 34 24             	mov    %esi,(%esp)
80104598:	e8 53 02 00 00       	call   801047f0 <release>
  return r;
}
8010459d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801045a0:	89 f8                	mov    %edi,%eax
801045a2:	8b 75 f8             	mov    -0x8(%ebp),%esi
801045a5:	8b 7d fc             	mov    -0x4(%ebp),%edi
801045a8:	89 ec                	mov    %ebp,%esp
801045aa:	5d                   	pop    %ebp
801045ab:	c3                   	ret    
801045ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
801045b0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801045b3:	e8 68 f4 ff ff       	call   80103a20 <myproc>
801045b8:	39 58 10             	cmp    %ebx,0x10(%eax)
801045bb:	0f 94 c0             	sete   %al
801045be:	0f b6 f8             	movzbl %al,%edi
801045c1:	eb d2                	jmp    80104595 <holdingsleep+0x25>
801045c3:	66 90                	xchg   %ax,%ax
801045c5:	66 90                	xchg   %ax,%ax
801045c7:	66 90                	xchg   %ax,%ax
801045c9:	66 90                	xchg   %ax,%ax
801045cb:	66 90                	xchg   %ax,%ax
801045cd:	66 90                	xchg   %ax,%ax
801045cf:	90                   	nop

801045d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801045d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801045d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801045df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801045e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801045e9:	5d                   	pop    %ebp
801045ea:	c3                   	ret    
801045eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045ef:	90                   	nop

801045f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801045f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801045f1:	31 d2                	xor    %edx,%edx
{
801045f3:	89 e5                	mov    %esp,%ebp
801045f5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801045f6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801045f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801045fc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801045ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104600:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104606:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010460c:	77 12                	ja     80104620 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010460e:	8b 58 04             	mov    0x4(%eax),%ebx
80104611:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104614:	42                   	inc    %edx
80104615:	83 fa 0a             	cmp    $0xa,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104618:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010461a:	75 e4                	jne    80104600 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010461c:	5b                   	pop    %ebx
8010461d:	5d                   	pop    %ebp
8010461e:	c3                   	ret    
8010461f:	90                   	nop
  for(; i < 10; i++)
80104620:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104623:	8d 51 28             	lea    0x28(%ecx),%edx
80104626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010462d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104630:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104636:	83 c0 04             	add    $0x4,%eax
80104639:	39 d0                	cmp    %edx,%eax
8010463b:	75 f3                	jne    80104630 <getcallerpcs+0x40>
}
8010463d:	5b                   	pop    %ebx
8010463e:	5d                   	pop    %ebp
8010463f:	c3                   	ret    

80104640 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	53                   	push   %ebx
80104644:	83 ec 04             	sub    $0x4,%esp
80104647:	9c                   	pushf  
80104648:	5b                   	pop    %ebx
  asm volatile("cli");
80104649:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010464a:	e8 41 f3 ff ff       	call   80103990 <mycpu>
8010464f:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104655:	85 d2                	test   %edx,%edx
80104657:	74 17                	je     80104670 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104659:	e8 32 f3 ff ff       	call   80103990 <mycpu>
8010465e:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80104664:	58                   	pop    %eax
80104665:	5b                   	pop    %ebx
80104666:	5d                   	pop    %ebp
80104667:	c3                   	ret    
80104668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010466f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104670:	e8 1b f3 ff ff       	call   80103990 <mycpu>
80104675:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010467b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104681:	e8 0a f3 ff ff       	call   80103990 <mycpu>
80104686:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
8010468c:	58                   	pop    %eax
8010468d:	5b                   	pop    %ebx
8010468e:	5d                   	pop    %ebp
8010468f:	c3                   	ret    

80104690 <popcli>:

void
popcli(void)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104696:	9c                   	pushf  
80104697:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104698:	f6 c4 02             	test   $0x2,%ah
8010469b:	75 35                	jne    801046d2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010469d:	e8 ee f2 ff ff       	call   80103990 <mycpu>
801046a2:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
801046a8:	78 34                	js     801046de <popcli+0x4e>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046aa:	e8 e1 f2 ff ff       	call   80103990 <mycpu>
801046af:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801046b5:	85 d2                	test   %edx,%edx
801046b7:	74 07                	je     801046c0 <popcli+0x30>
    sti();
}
801046b9:	c9                   	leave  
801046ba:	c3                   	ret    
801046bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046bf:	90                   	nop
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046c0:	e8 cb f2 ff ff       	call   80103990 <mycpu>
801046c5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801046cb:	85 c0                	test   %eax,%eax
801046cd:	74 ea                	je     801046b9 <popcli+0x29>
  asm volatile("sti");
801046cf:	fb                   	sti    
}
801046d0:	c9                   	leave  
801046d1:	c3                   	ret    
    panic("popcli - interruptible");
801046d2:	c7 04 24 cf 79 10 80 	movl   $0x801079cf,(%esp)
801046d9:	e8 82 bc ff ff       	call   80100360 <panic>
    panic("popcli");
801046de:	c7 04 24 e6 79 10 80 	movl   $0x801079e6,(%esp)
801046e5:	e8 76 bc ff ff       	call   80100360 <panic>
801046ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046f0 <holding>:
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	83 ec 08             	sub    $0x8,%esp
801046f6:	89 75 fc             	mov    %esi,-0x4(%ebp)
801046f9:	8b 75 08             	mov    0x8(%ebp),%esi
801046fc:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801046ff:	31 db                	xor    %ebx,%ebx
  pushcli();
80104701:	e8 3a ff ff ff       	call   80104640 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104706:	8b 06                	mov    (%esi),%eax
80104708:	85 c0                	test   %eax,%eax
8010470a:	75 14                	jne    80104720 <holding+0x30>
  popcli();
8010470c:	e8 7f ff ff ff       	call   80104690 <popcli>
}
80104711:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104714:	89 d8                	mov    %ebx,%eax
80104716:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104719:	89 ec                	mov    %ebp,%esp
8010471b:	5d                   	pop    %ebp
8010471c:	c3                   	ret    
8010471d:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104720:	8b 5e 08             	mov    0x8(%esi),%ebx
80104723:	e8 68 f2 ff ff       	call   80103990 <mycpu>
80104728:	39 c3                	cmp    %eax,%ebx
8010472a:	0f 94 c3             	sete   %bl
8010472d:	0f b6 db             	movzbl %bl,%ebx
80104730:	eb da                	jmp    8010470c <holding+0x1c>
80104732:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104740 <acquire>:
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104748:	e8 f3 fe ff ff       	call   80104640 <pushcli>
  if(holding(lk))
8010474d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104750:	89 1c 24             	mov    %ebx,(%esp)
80104753:	e8 98 ff ff ff       	call   801046f0 <holding>
80104758:	85 c0                	test   %eax,%eax
8010475a:	0f 85 84 00 00 00    	jne    801047e4 <acquire+0xa4>
80104760:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104762:	ba 01 00 00 00       	mov    $0x1,%edx
80104767:	eb 0a                	jmp    80104773 <acquire+0x33>
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104770:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104773:	89 d0                	mov    %edx,%eax
80104775:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104778:	85 c0                	test   %eax,%eax
8010477a:	75 f4                	jne    80104770 <acquire+0x30>
  __sync_synchronize();
8010477c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104781:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104784:	e8 07 f2 ff ff       	call   80103990 <mycpu>
80104789:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010478c:	89 e8                	mov    %ebp,%eax
8010478e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104790:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104796:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
8010479c:	77 22                	ja     801047c0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
8010479e:	8b 50 04             	mov    0x4(%eax),%edx
801047a1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
801047a5:	46                   	inc    %esi
801047a6:	83 fe 0a             	cmp    $0xa,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801047a9:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801047ab:	75 e3                	jne    80104790 <acquire+0x50>
}
801047ad:	83 c4 10             	add    $0x10,%esp
801047b0:	5b                   	pop    %ebx
801047b1:	5e                   	pop    %esi
801047b2:	5d                   	pop    %ebp
801047b3:	c3                   	ret    
801047b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047bf:	90                   	nop
  for(; i < 10; i++)
801047c0:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
801047c4:	83 c3 34             	add    $0x34,%ebx
801047c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047ce:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801047d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801047d6:	83 c0 04             	add    $0x4,%eax
801047d9:	39 d8                	cmp    %ebx,%eax
801047db:	75 f3                	jne    801047d0 <acquire+0x90>
}
801047dd:	83 c4 10             	add    $0x10,%esp
801047e0:	5b                   	pop    %ebx
801047e1:	5e                   	pop    %esi
801047e2:	5d                   	pop    %ebp
801047e3:	c3                   	ret    
    panic("acquire");
801047e4:	c7 04 24 ed 79 10 80 	movl   $0x801079ed,(%esp)
801047eb:	e8 70 bb ff ff       	call   80100360 <panic>

801047f0 <release>:
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	53                   	push   %ebx
801047f4:	83 ec 14             	sub    $0x14,%esp
801047f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801047fa:	89 1c 24             	mov    %ebx,(%esp)
801047fd:	e8 ee fe ff ff       	call   801046f0 <holding>
80104802:	85 c0                	test   %eax,%eax
80104804:	74 23                	je     80104829 <release+0x39>
  lk->pcs[0] = 0;
80104806:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010480d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104814:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104819:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010481f:	83 c4 14             	add    $0x14,%esp
80104822:	5b                   	pop    %ebx
80104823:	5d                   	pop    %ebp
  popcli();
80104824:	e9 67 fe ff ff       	jmp    80104690 <popcli>
    panic("release");
80104829:	c7 04 24 f5 79 10 80 	movl   $0x801079f5,(%esp)
80104830:	e8 2b bb ff ff       	call   80100360 <panic>
80104835:	66 90                	xchg   %ax,%ax
80104837:	66 90                	xchg   %ax,%ax
80104839:	66 90                	xchg   %ax,%ax
8010483b:	66 90                	xchg   %ax,%ax
8010483d:	66 90                	xchg   %ax,%ax
8010483f:	90                   	nop

80104840 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	83 ec 08             	sub    $0x8,%esp
80104846:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104849:	8b 55 08             	mov    0x8(%ebp),%edx
8010484c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010484f:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104852:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104855:	89 d7                	mov    %edx,%edi
80104857:	09 cf                	or     %ecx,%edi
80104859:	83 e7 03             	and    $0x3,%edi
8010485c:	75 32                	jne    80104890 <memset+0x50>
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010485e:	c1 e9 02             	shr    $0x2,%ecx
    c &= 0xFF;
80104861:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104864:	c1 e0 18             	shl    $0x18,%eax
80104867:	89 fb                	mov    %edi,%ebx
80104869:	c1 e3 10             	shl    $0x10,%ebx
8010486c:	09 d8                	or     %ebx,%eax
8010486e:	09 f8                	or     %edi,%eax
80104870:	c1 e7 08             	shl    $0x8,%edi
80104873:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104875:	89 d7                	mov    %edx,%edi
80104877:	fc                   	cld    
80104878:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
8010487a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010487d:	89 d0                	mov    %edx,%eax
8010487f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104882:	89 ec                	mov    %ebp,%esp
80104884:	5d                   	pop    %ebp
80104885:	c3                   	ret    
80104886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010488d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80104890:	89 d7                	mov    %edx,%edi
80104892:	fc                   	cld    
80104893:	f3 aa                	rep stos %al,%es:(%edi)
80104895:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104898:	89 d0                	mov    %edx,%eax
8010489a:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010489d:	89 ec                	mov    %ebp,%esp
8010489f:	5d                   	pop    %ebp
801048a0:	c3                   	ret    
801048a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048af:	90                   	nop

801048b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	56                   	push   %esi
801048b4:	8b 75 10             	mov    0x10(%ebp),%esi
801048b7:	53                   	push   %ebx
801048b8:	8b 55 08             	mov    0x8(%ebp),%edx
801048bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801048be:	85 f6                	test   %esi,%esi
801048c0:	74 2e                	je     801048f0 <memcmp+0x40>
801048c2:	01 c6                	add    %eax,%esi
801048c4:	eb 10                	jmp    801048d6 <memcmp+0x26>
801048c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801048d0:	40                   	inc    %eax
801048d1:	42                   	inc    %edx
  while(n-- > 0){
801048d2:	39 f0                	cmp    %esi,%eax
801048d4:	74 1a                	je     801048f0 <memcmp+0x40>
    if(*s1 != *s2)
801048d6:	0f b6 0a             	movzbl (%edx),%ecx
801048d9:	0f b6 18             	movzbl (%eax),%ebx
801048dc:	38 d9                	cmp    %bl,%cl
801048de:	74 f0                	je     801048d0 <memcmp+0x20>
      return *s1 - *s2;
801048e0:	0f b6 c1             	movzbl %cl,%eax
801048e3:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801048e5:	5b                   	pop    %ebx
801048e6:	5e                   	pop    %esi
801048e7:	5d                   	pop    %ebp
801048e8:	c3                   	ret    
801048e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048f0:	5b                   	pop    %ebx
  return 0;
801048f1:	31 c0                	xor    %eax,%eax
}
801048f3:	5e                   	pop    %esi
801048f4:	5d                   	pop    %ebp
801048f5:	c3                   	ret    
801048f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048fd:	8d 76 00             	lea    0x0(%esi),%esi

80104900 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	57                   	push   %edi
80104904:	8b 55 08             	mov    0x8(%ebp),%edx
80104907:	56                   	push   %esi
80104908:	8b 75 0c             	mov    0xc(%ebp),%esi
8010490b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010490e:	39 d6                	cmp    %edx,%esi
80104910:	73 2e                	jae    80104940 <memmove+0x40>
80104912:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104915:	39 fa                	cmp    %edi,%edx
80104917:	73 27                	jae    80104940 <memmove+0x40>
80104919:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
8010491c:	85 c9                	test   %ecx,%ecx
8010491e:	74 0d                	je     8010492d <memmove+0x2d>
      *--d = *--s;
80104920:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104924:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104927:	48                   	dec    %eax
80104928:	83 f8 ff             	cmp    $0xffffffff,%eax
8010492b:	75 f3                	jne    80104920 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010492d:	5e                   	pop    %esi
8010492e:	89 d0                	mov    %edx,%eax
80104930:	5f                   	pop    %edi
80104931:	5d                   	pop    %ebp
80104932:	c3                   	ret    
80104933:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010493a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104940:	85 c9                	test   %ecx,%ecx
80104942:	89 d7                	mov    %edx,%edi
80104944:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104947:	74 e4                	je     8010492d <memmove+0x2d>
80104949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104950:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104951:	39 f0                	cmp    %esi,%eax
80104953:	75 fb                	jne    80104950 <memmove+0x50>
}
80104955:	5e                   	pop    %esi
80104956:	89 d0                	mov    %edx,%eax
80104958:	5f                   	pop    %edi
80104959:	5d                   	pop    %ebp
8010495a:	c3                   	ret    
8010495b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010495f:	90                   	nop

80104960 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104960:	eb 9e                	jmp    80104900 <memmove>
80104962:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104970 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	8b 75 10             	mov    0x10(%ebp),%esi
80104977:	53                   	push   %ebx
80104978:	8b 45 0c             	mov    0xc(%ebp),%eax
8010497b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010497e:	85 f6                	test   %esi,%esi
80104980:	74 2e                	je     801049b0 <strncmp+0x40>
80104982:	01 c6                	add    %eax,%esi
80104984:	eb 14                	jmp    8010499a <strncmp+0x2a>
80104986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010498d:	8d 76 00             	lea    0x0(%esi),%esi
80104990:	38 ca                	cmp    %cl,%dl
80104992:	75 10                	jne    801049a4 <strncmp+0x34>
    n--, p++, q++;
80104994:	40                   	inc    %eax
80104995:	43                   	inc    %ebx
  while(n > 0 && *p && *p == *q)
80104996:	39 f0                	cmp    %esi,%eax
80104998:	74 16                	je     801049b0 <strncmp+0x40>
8010499a:	0f b6 13             	movzbl (%ebx),%edx
8010499d:	0f b6 08             	movzbl (%eax),%ecx
801049a0:	84 d2                	test   %dl,%dl
801049a2:	75 ec                	jne    80104990 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801049a4:	5b                   	pop    %ebx
  return (uchar)*p - (uchar)*q;
801049a5:	0f b6 c2             	movzbl %dl,%eax
801049a8:	29 c8                	sub    %ecx,%eax
}
801049aa:	5e                   	pop    %esi
801049ab:	5d                   	pop    %ebp
801049ac:	c3                   	ret    
801049ad:	8d 76 00             	lea    0x0(%esi),%esi
801049b0:	5b                   	pop    %ebx
    return 0;
801049b1:	31 c0                	xor    %eax,%eax
}
801049b3:	5e                   	pop    %esi
801049b4:	5d                   	pop    %ebp
801049b5:	c3                   	ret    
801049b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049bd:	8d 76 00             	lea    0x0(%esi),%esi

801049c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	57                   	push   %edi
801049c4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801049c7:	56                   	push   %esi
801049c8:	8b 75 08             	mov    0x8(%ebp),%esi
801049cb:	53                   	push   %ebx
801049cc:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801049cf:	89 f2                	mov    %esi,%edx
801049d1:	eb 19                	jmp    801049ec <strncpy+0x2c>
801049d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049e0:	0f b6 01             	movzbl (%ecx),%eax
801049e3:	41                   	inc    %ecx
801049e4:	42                   	inc    %edx
801049e5:	88 42 ff             	mov    %al,-0x1(%edx)
801049e8:	84 c0                	test   %al,%al
801049ea:	74 07                	je     801049f3 <strncpy+0x33>
801049ec:	89 fb                	mov    %edi,%ebx
801049ee:	4f                   	dec    %edi
801049ef:	85 db                	test   %ebx,%ebx
801049f1:	7f ed                	jg     801049e0 <strncpy+0x20>
    ;
  while(n-- > 0)
801049f3:	85 ff                	test   %edi,%edi
801049f5:	89 d1                	mov    %edx,%ecx
801049f7:	7e 17                	jle    80104a10 <strncpy+0x50>
801049f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104a00:	c6 01 00             	movb   $0x0,(%ecx)
80104a03:	41                   	inc    %ecx
  while(n-- > 0)
80104a04:	89 c8                	mov    %ecx,%eax
80104a06:	f7 d0                	not    %eax
80104a08:	01 d0                	add    %edx,%eax
80104a0a:	01 d8                	add    %ebx,%eax
80104a0c:	85 c0                	test   %eax,%eax
80104a0e:	7f f0                	jg     80104a00 <strncpy+0x40>
  return os;
}
80104a10:	5b                   	pop    %ebx
80104a11:	89 f0                	mov    %esi,%eax
80104a13:	5e                   	pop    %esi
80104a14:	5f                   	pop    %edi
80104a15:	5d                   	pop    %ebp
80104a16:	c3                   	ret    
80104a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	56                   	push   %esi
80104a24:	8b 55 10             	mov    0x10(%ebp),%edx
80104a27:	53                   	push   %ebx
80104a28:	8b 75 08             	mov    0x8(%ebp),%esi
80104a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104a2e:	85 d2                	test   %edx,%edx
80104a30:	7e 21                	jle    80104a53 <safestrcpy+0x33>
80104a32:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104a36:	89 f2                	mov    %esi,%edx
80104a38:	eb 12                	jmp    80104a4c <safestrcpy+0x2c>
80104a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104a40:	0f b6 08             	movzbl (%eax),%ecx
80104a43:	40                   	inc    %eax
80104a44:	42                   	inc    %edx
80104a45:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a48:	84 c9                	test   %cl,%cl
80104a4a:	74 04                	je     80104a50 <safestrcpy+0x30>
80104a4c:	39 d8                	cmp    %ebx,%eax
80104a4e:	75 f0                	jne    80104a40 <safestrcpy+0x20>
    ;
  *s = 0;
80104a50:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104a53:	5b                   	pop    %ebx
80104a54:	89 f0                	mov    %esi,%eax
80104a56:	5e                   	pop    %esi
80104a57:	5d                   	pop    %ebp
80104a58:	c3                   	ret    
80104a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a60 <strlen>:

int
strlen(const char *s)
{
80104a60:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104a61:	31 c0                	xor    %eax,%eax
{
80104a63:	89 e5                	mov    %esp,%ebp
80104a65:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104a68:	80 3a 00             	cmpb   $0x0,(%edx)
80104a6b:	74 0a                	je     80104a77 <strlen+0x17>
80104a6d:	8d 76 00             	lea    0x0(%esi),%esi
80104a70:	40                   	inc    %eax
80104a71:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a75:	75 f9                	jne    80104a70 <strlen+0x10>
    ;
  return n;
}
80104a77:	5d                   	pop    %ebp
80104a78:	c3                   	ret    

80104a79 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104a79:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104a7d:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104a81:	55                   	push   %ebp
  pushl %ebx
80104a82:	53                   	push   %ebx
  pushl %esi
80104a83:	56                   	push   %esi
  pushl %edi
80104a84:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104a85:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104a87:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104a89:	5f                   	pop    %edi
  popl %esi
80104a8a:	5e                   	pop    %esi
  popl %ebx
80104a8b:	5b                   	pop    %ebx
  popl %ebp
80104a8c:	5d                   	pop    %ebp
  ret
80104a8d:	c3                   	ret    
80104a8e:	66 90                	xchg   %ax,%ax

80104a90 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	53                   	push   %ebx
80104a94:	83 ec 04             	sub    $0x4,%esp
80104a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104a9a:	e8 81 ef ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a9f:	8b 00                	mov    (%eax),%eax
80104aa1:	39 d8                	cmp    %ebx,%eax
80104aa3:	76 1b                	jbe    80104ac0 <fetchint+0x30>
80104aa5:	8d 53 04             	lea    0x4(%ebx),%edx
80104aa8:	39 d0                	cmp    %edx,%eax
80104aaa:	72 14                	jb     80104ac0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104aac:	8b 45 0c             	mov    0xc(%ebp),%eax
80104aaf:	8b 13                	mov    (%ebx),%edx
80104ab1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ab3:	31 c0                	xor    %eax,%eax
}
80104ab5:	5a                   	pop    %edx
80104ab6:	5b                   	pop    %ebx
80104ab7:	5d                   	pop    %ebp
80104ab8:	c3                   	ret    
80104ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ac5:	eb ee                	jmp    80104ab5 <fetchint+0x25>
80104ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	83 ec 04             	sub    $0x4,%esp
80104ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104ada:	e8 41 ef ff ff       	call   80103a20 <myproc>

  if(addr >= curproc->sz)
80104adf:	39 18                	cmp    %ebx,(%eax)
80104ae1:	76 2d                	jbe    80104b10 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104ae3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ae6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104ae8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104aea:	39 d3                	cmp    %edx,%ebx
80104aec:	73 22                	jae    80104b10 <fetchstr+0x40>
80104aee:	89 d8                	mov    %ebx,%eax
80104af0:	eb 13                	jmp    80104b05 <fetchstr+0x35>
80104af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b00:	40                   	inc    %eax
80104b01:	39 c2                	cmp    %eax,%edx
80104b03:	76 0b                	jbe    80104b10 <fetchstr+0x40>
    if(*s == 0)
80104b05:	80 38 00             	cmpb   $0x0,(%eax)
80104b08:	75 f6                	jne    80104b00 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
80104b0a:	5a                   	pop    %edx
      return s - *pp;
80104b0b:	29 d8                	sub    %ebx,%eax
}
80104b0d:	5b                   	pop    %ebx
80104b0e:	5d                   	pop    %ebp
80104b0f:	c3                   	ret    
80104b10:	5a                   	pop    %edx
    return -1;
80104b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b16:	5b                   	pop    %ebx
80104b17:	5d                   	pop    %ebp
80104b18:	c3                   	ret    
80104b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	56                   	push   %esi
80104b24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b25:	e8 f6 ee ff ff       	call   80103a20 <myproc>
80104b2a:	8b 55 08             	mov    0x8(%ebp),%edx
80104b2d:	8b 40 18             	mov    0x18(%eax),%eax
80104b30:	8b 40 44             	mov    0x44(%eax),%eax
80104b33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b36:	e8 e5 ee ff ff       	call   80103a20 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b3b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b3e:	8b 00                	mov    (%eax),%eax
80104b40:	39 c6                	cmp    %eax,%esi
80104b42:	73 1c                	jae    80104b60 <argint+0x40>
80104b44:	8d 53 08             	lea    0x8(%ebx),%edx
80104b47:	39 d0                	cmp    %edx,%eax
80104b49:	72 15                	jb     80104b60 <argint+0x40>
  *ip = *(int*)(addr);
80104b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b4e:	8b 53 04             	mov    0x4(%ebx),%edx
80104b51:	89 10                	mov    %edx,(%eax)
  return 0;
80104b53:	31 c0                	xor    %eax,%eax
}
80104b55:	5b                   	pop    %ebx
80104b56:	5e                   	pop    %esi
80104b57:	5d                   	pop    %ebp
80104b58:	c3                   	ret    
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b65:	eb ee                	jmp    80104b55 <argint+0x35>
80104b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b6e:	66 90                	xchg   %ax,%ax

80104b70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	56                   	push   %esi
80104b74:	53                   	push   %ebx
80104b75:	83 ec 20             	sub    $0x20,%esp
80104b78:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104b7b:	e8 a0 ee ff ff       	call   80103a20 <myproc>
80104b80:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104b82:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b85:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b89:	8b 45 08             	mov    0x8(%ebp),%eax
80104b8c:	89 04 24             	mov    %eax,(%esp)
80104b8f:	e8 8c ff ff ff       	call   80104b20 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104b94:	c1 e8 1f             	shr    $0x1f,%eax
80104b97:	84 c0                	test   %al,%al
80104b99:	75 35                	jne    80104bd0 <argptr+0x60>
80104b9b:	89 d8                	mov    %ebx,%eax
80104b9d:	c1 e8 1f             	shr    $0x1f,%eax
80104ba0:	84 c0                	test   %al,%al
80104ba2:	75 2c                	jne    80104bd0 <argptr+0x60>
80104ba4:	8b 16                	mov    (%esi),%edx
80104ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba9:	39 c2                	cmp    %eax,%edx
80104bab:	76 23                	jbe    80104bd0 <argptr+0x60>
80104bad:	01 c3                	add    %eax,%ebx
80104baf:	39 da                	cmp    %ebx,%edx
80104bb1:	72 1d                	jb     80104bd0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104bb3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104bb6:	89 02                	mov    %eax,(%edx)
  return 0;
80104bb8:	31 c0                	xor    %eax,%eax
}
80104bba:	83 c4 20             	add    $0x20,%esp
80104bbd:	5b                   	pop    %ebx
80104bbe:	5e                   	pop    %esi
80104bbf:	5d                   	pop    %ebp
80104bc0:	c3                   	ret    
80104bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bcf:	90                   	nop
    return -1;
80104bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bd5:	eb e3                	jmp    80104bba <argptr+0x4a>
80104bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bde:	66 90                	xchg   %ax,%ax

80104be0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104be6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104be9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bed:	8b 45 08             	mov    0x8(%ebp),%eax
80104bf0:	89 04 24             	mov    %eax,(%esp)
80104bf3:	e8 28 ff ff ff       	call   80104b20 <argint>
80104bf8:	85 c0                	test   %eax,%eax
80104bfa:	78 14                	js     80104c10 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bff:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c06:	89 04 24             	mov    %eax,(%esp)
80104c09:	e8 c2 fe ff ff       	call   80104ad0 <fetchstr>
}
80104c0e:	c9                   	leave  
80104c0f:	c3                   	ret    
80104c10:	c9                   	leave  
    return -1;
80104c11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c16:	c3                   	ret    
80104c17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c1e:	66 90                	xchg   %ax,%ax

80104c20 <syscall>:
[SYS_waitx]   sys_waitx,
};

void
syscall(void)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	53                   	push   %ebx
80104c24:	83 ec 14             	sub    $0x14,%esp
  int num;
  struct proc *curproc = myproc();
80104c27:	e8 f4 ed ff ff       	call   80103a20 <myproc>
80104c2c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104c2e:	8b 40 18             	mov    0x18(%eax),%eax
80104c31:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c34:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c37:	83 fa 15             	cmp    $0x15,%edx
80104c3a:	77 24                	ja     80104c60 <syscall+0x40>
80104c3c:	8b 14 85 20 7a 10 80 	mov    -0x7fef85e0(,%eax,4),%edx
80104c43:	85 d2                	test   %edx,%edx
80104c45:	74 19                	je     80104c60 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104c47:	ff d2                	call   *%edx
80104c49:	89 c2                	mov    %eax,%edx
80104c4b:	8b 43 18             	mov    0x18(%ebx),%eax
80104c4e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104c51:	83 c4 14             	add    $0x14,%esp
80104c54:	5b                   	pop    %ebx
80104c55:	5d                   	pop    %ebp
80104c56:	c3                   	ret    
80104c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c5e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104c60:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80104c64:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104c67:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104c6b:	8b 43 10             	mov    0x10(%ebx),%eax
80104c6e:	c7 04 24 fd 79 10 80 	movl   $0x801079fd,(%esp)
80104c75:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c79:	e8 02 ba ff ff       	call   80100680 <cprintf>
    curproc->tf->eax = -1;
80104c7e:	8b 43 18             	mov    0x18(%ebx),%eax
80104c81:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104c88:	83 c4 14             	add    $0x14,%esp
80104c8b:	5b                   	pop    %ebx
80104c8c:	5d                   	pop    %ebp
80104c8d:	c3                   	ret    
80104c8e:	66 90                	xchg   %ax,%ax

80104c90 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104c90:	55                   	push   %ebp
80104c91:	0f bf d2             	movswl %dx,%edx
80104c94:	89 e5                	mov    %esp,%ebp
80104c96:	0f bf c9             	movswl %cx,%ecx
80104c99:	57                   	push   %edi
80104c9a:	56                   	push   %esi
80104c9b:	53                   	push   %ebx
80104c9c:	83 ec 3c             	sub    $0x3c,%esp
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104c9f:	89 04 24             	mov    %eax,(%esp)
{
80104ca2:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80104ca6:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104ca9:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104cac:	89 7d cc             	mov    %edi,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104caf:	8d 7d da             	lea    -0x26(%ebp),%edi
80104cb2:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104cb6:	e8 d5 d4 ff ff       	call   80102190 <nameiparent>
80104cbb:	85 c0                	test   %eax,%eax
80104cbd:	0f 84 2d 01 00 00    	je     80104df0 <create+0x160>
    return 0;
  ilock(dp);
80104cc3:	89 04 24             	mov    %eax,(%esp)
80104cc6:	89 c3                	mov    %eax,%ebx
80104cc8:	e8 33 cb ff ff       	call   80101800 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104ccd:	31 c9                	xor    %ecx,%ecx
80104ccf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80104cd3:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104cd7:	89 1c 24             	mov    %ebx,(%esp)
80104cda:	e8 d1 d0 ff ff       	call   80101db0 <dirlookup>
80104cdf:	85 c0                	test   %eax,%eax
80104ce1:	89 c6                	mov    %eax,%esi
80104ce3:	74 4b                	je     80104d30 <create+0xa0>
    iunlockput(dp);
80104ce5:	89 1c 24             	mov    %ebx,(%esp)
80104ce8:	e8 b3 cd ff ff       	call   80101aa0 <iunlockput>
    ilock(ip);
80104ced:	89 34 24             	mov    %esi,(%esp)
80104cf0:	e8 0b cb ff ff       	call   80101800 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104cf5:	83 7d d4 02          	cmpl   $0x2,-0x2c(%ebp)
80104cf9:	75 15                	jne    80104d10 <create+0x80>
80104cfb:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104d00:	75 0e                	jne    80104d10 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d02:	83 c4 3c             	add    $0x3c,%esp
80104d05:	89 f0                	mov    %esi,%eax
80104d07:	5b                   	pop    %ebx
80104d08:	5e                   	pop    %esi
80104d09:	5f                   	pop    %edi
80104d0a:	5d                   	pop    %ebp
80104d0b:	c3                   	ret    
80104d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104d10:	89 34 24             	mov    %esi,(%esp)
    return 0;
80104d13:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104d15:	e8 86 cd ff ff       	call   80101aa0 <iunlockput>
}
80104d1a:	83 c4 3c             	add    $0x3c,%esp
80104d1d:	89 f0                	mov    %esi,%eax
80104d1f:	5b                   	pop    %ebx
80104d20:	5e                   	pop    %esi
80104d21:	5f                   	pop    %edi
80104d22:	5d                   	pop    %ebp
80104d23:	c3                   	ret    
80104d24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d2f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104d30:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104d33:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d37:	8b 03                	mov    (%ebx),%eax
80104d39:	89 04 24             	mov    %eax,(%esp)
80104d3c:	e8 3f c9 ff ff       	call   80101680 <ialloc>
80104d41:	85 c0                	test   %eax,%eax
80104d43:	89 c6                	mov    %eax,%esi
80104d45:	0f 84 bd 00 00 00    	je     80104e08 <create+0x178>
  ilock(ip);
80104d4b:	89 04 24             	mov    %eax,(%esp)
80104d4e:	e8 ad ca ff ff       	call   80101800 <ilock>
  ip->major = major;
80104d53:	8b 45 d0             	mov    -0x30(%ebp),%eax
  ip->nlink = 1;
80104d56:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  ip->major = major;
80104d5c:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104d60:	8b 45 cc             	mov    -0x34(%ebp),%eax
80104d63:	66 89 46 54          	mov    %ax,0x54(%esi)
  iupdate(ip);
80104d67:	89 34 24             	mov    %esi,(%esp)
80104d6a:	e8 d1 c9 ff ff       	call   80101740 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104d6f:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
80104d73:	74 2b                	je     80104da0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104d75:	8b 46 04             	mov    0x4(%esi),%eax
80104d78:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104d7c:	89 1c 24             	mov    %ebx,(%esp)
80104d7f:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d83:	e8 08 d3 ff ff       	call   80102090 <dirlink>
80104d88:	85 c0                	test   %eax,%eax
80104d8a:	78 70                	js     80104dfc <create+0x16c>
  iunlockput(dp);
80104d8c:	89 1c 24             	mov    %ebx,(%esp)
80104d8f:	e8 0c cd ff ff       	call   80101aa0 <iunlockput>
}
80104d94:	83 c4 3c             	add    $0x3c,%esp
80104d97:	89 f0                	mov    %esi,%eax
80104d99:	5b                   	pop    %ebx
80104d9a:	5e                   	pop    %esi
80104d9b:	5f                   	pop    %edi
80104d9c:	5d                   	pop    %ebp
80104d9d:	c3                   	ret    
80104d9e:	66 90                	xchg   %ax,%ax
    dp->nlink++;  // for ".."
80104da0:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80104da4:	89 1c 24             	mov    %ebx,(%esp)
80104da7:	e8 94 c9 ff ff       	call   80101740 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104dac:	8b 46 04             	mov    0x4(%esi),%eax
80104daf:	ba 98 7a 10 80       	mov    $0x80107a98,%edx
80104db4:	89 54 24 04          	mov    %edx,0x4(%esp)
80104db8:	89 34 24             	mov    %esi,(%esp)
80104dbb:	89 44 24 08          	mov    %eax,0x8(%esp)
80104dbf:	e8 cc d2 ff ff       	call   80102090 <dirlink>
80104dc4:	85 c0                	test   %eax,%eax
80104dc6:	78 1c                	js     80104de4 <create+0x154>
80104dc8:	8b 43 04             	mov    0x4(%ebx),%eax
80104dcb:	89 34 24             	mov    %esi,(%esp)
80104dce:	89 44 24 08          	mov    %eax,0x8(%esp)
80104dd2:	b8 97 7a 10 80       	mov    $0x80107a97,%eax
80104dd7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ddb:	e8 b0 d2 ff ff       	call   80102090 <dirlink>
80104de0:	85 c0                	test   %eax,%eax
80104de2:	79 91                	jns    80104d75 <create+0xe5>
      panic("create dots");
80104de4:	c7 04 24 8b 7a 10 80 	movl   $0x80107a8b,(%esp)
80104deb:	e8 70 b5 ff ff       	call   80100360 <panic>
}
80104df0:	83 c4 3c             	add    $0x3c,%esp
    return 0;
80104df3:	31 f6                	xor    %esi,%esi
}
80104df5:	5b                   	pop    %ebx
80104df6:	89 f0                	mov    %esi,%eax
80104df8:	5e                   	pop    %esi
80104df9:	5f                   	pop    %edi
80104dfa:	5d                   	pop    %ebp
80104dfb:	c3                   	ret    
    panic("create: dirlink");
80104dfc:	c7 04 24 9a 7a 10 80 	movl   $0x80107a9a,(%esp)
80104e03:	e8 58 b5 ff ff       	call   80100360 <panic>
    panic("create: ialloc");
80104e08:	c7 04 24 7c 7a 10 80 	movl   $0x80107a7c,(%esp)
80104e0f:	e8 4c b5 ff ff       	call   80100360 <panic>
80104e14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e1f:	90                   	nop

80104e20 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	56                   	push   %esi
80104e24:	89 d6                	mov    %edx,%esi
80104e26:	53                   	push   %ebx
80104e27:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104e29:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104e2c:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
80104e2f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e3a:	e8 e1 fc ff ff       	call   80104b20 <argint>
80104e3f:	85 c0                	test   %eax,%eax
80104e41:	78 2d                	js     80104e70 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e43:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e47:	77 27                	ja     80104e70 <argfd.constprop.0+0x50>
80104e49:	e8 d2 eb ff ff       	call   80103a20 <myproc>
80104e4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e51:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104e55:	85 c0                	test   %eax,%eax
80104e57:	74 17                	je     80104e70 <argfd.constprop.0+0x50>
  if(pfd)
80104e59:	85 db                	test   %ebx,%ebx
80104e5b:	74 02                	je     80104e5f <argfd.constprop.0+0x3f>
    *pfd = fd;
80104e5d:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104e5f:	89 06                	mov    %eax,(%esi)
  return 0;
80104e61:	31 c0                	xor    %eax,%eax
}
80104e63:	83 c4 20             	add    $0x20,%esp
80104e66:	5b                   	pop    %ebx
80104e67:	5e                   	pop    %esi
80104e68:	5d                   	pop    %ebp
80104e69:	c3                   	ret    
80104e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104e70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e75:	eb ec                	jmp    80104e63 <argfd.constprop.0+0x43>
80104e77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e7e:	66 90                	xchg   %ax,%ax

80104e80 <sys_dup>:
{
80104e80:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104e81:	31 c0                	xor    %eax,%eax
{
80104e83:	89 e5                	mov    %esp,%ebp
80104e85:	56                   	push   %esi
80104e86:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104e87:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104e8a:	83 ec 20             	sub    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
80104e8d:	e8 8e ff ff ff       	call   80104e20 <argfd.constprop.0>
80104e92:	85 c0                	test   %eax,%eax
80104e94:	78 18                	js     80104eae <sys_dup+0x2e>
  if((fd=fdalloc(f)) < 0)
80104e96:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104e99:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104e9b:	e8 80 eb ff ff       	call   80103a20 <myproc>
    if(curproc->ofile[fd] == 0){
80104ea0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ea4:	85 d2                	test   %edx,%edx
80104ea6:	74 18                	je     80104ec0 <sys_dup+0x40>
  for(fd = 0; fd < NOFILE; fd++){
80104ea8:	43                   	inc    %ebx
80104ea9:	83 fb 10             	cmp    $0x10,%ebx
80104eac:	75 f2                	jne    80104ea0 <sys_dup+0x20>
}
80104eae:	83 c4 20             	add    $0x20,%esp
    return -1;
80104eb1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104eb6:	89 d8                	mov    %ebx,%eax
80104eb8:	5b                   	pop    %ebx
80104eb9:	5e                   	pop    %esi
80104eba:	5d                   	pop    %ebp
80104ebb:	c3                   	ret    
80104ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80104ec0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104ec4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ec7:	89 04 24             	mov    %eax,(%esp)
80104eca:	e8 c1 bf ff ff       	call   80100e90 <filedup>
}
80104ecf:	83 c4 20             	add    $0x20,%esp
80104ed2:	89 d8                	mov    %ebx,%eax
80104ed4:	5b                   	pop    %ebx
80104ed5:	5e                   	pop    %esi
80104ed6:	5d                   	pop    %ebp
80104ed7:	c3                   	ret    
80104ed8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104edf:	90                   	nop

80104ee0 <sys_read>:
{
80104ee0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ee1:	31 c0                	xor    %eax,%eax
{
80104ee3:	89 e5                	mov    %esp,%ebp
80104ee5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ee8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104eeb:	e8 30 ff ff ff       	call   80104e20 <argfd.constprop.0>
80104ef0:	85 c0                	test   %eax,%eax
80104ef2:	78 5c                	js     80104f50 <sys_read+0x70>
80104ef4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104efb:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104efe:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f02:	e8 19 fc ff ff       	call   80104b20 <argint>
80104f07:	85 c0                	test   %eax,%eax
80104f09:	78 45                	js     80104f50 <sys_read+0x70>
80104f0b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f12:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f15:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f20:	e8 4b fc ff ff       	call   80104b70 <argptr>
80104f25:	85 c0                	test   %eax,%eax
80104f27:	78 27                	js     80104f50 <sys_read+0x70>
  return fileread(f, p, n);
80104f29:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f2c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f33:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f37:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104f3a:	89 04 24             	mov    %eax,(%esp)
80104f3d:	e8 de c0 ff ff       	call   80101020 <fileread>
}
80104f42:	c9                   	leave  
80104f43:	c3                   	ret    
80104f44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f4f:	90                   	nop
80104f50:	c9                   	leave  
    return -1;
80104f51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f56:	c3                   	ret    
80104f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <sys_write>:
{
80104f60:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f61:	31 c0                	xor    %eax,%eax
{
80104f63:	89 e5                	mov    %esp,%ebp
80104f65:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f6b:	e8 b0 fe ff ff       	call   80104e20 <argfd.constprop.0>
80104f70:	85 c0                	test   %eax,%eax
80104f72:	78 5c                	js     80104fd0 <sys_write+0x70>
80104f74:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104f7b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f7e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f82:	e8 99 fb ff ff       	call   80104b20 <argint>
80104f87:	85 c0                	test   %eax,%eax
80104f89:	78 45                	js     80104fd0 <sys_write+0x70>
80104f8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f92:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f95:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fa0:	e8 cb fb ff ff       	call   80104b70 <argptr>
80104fa5:	85 c0                	test   %eax,%eax
80104fa7:	78 27                	js     80104fd0 <sys_write+0x70>
  return filewrite(f, p, n);
80104fa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104fac:	89 44 24 08          	mov    %eax,0x8(%esp)
80104fb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fb3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fb7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104fba:	89 04 24             	mov    %eax,(%esp)
80104fbd:	e8 1e c1 ff ff       	call   801010e0 <filewrite>
}
80104fc2:	c9                   	leave  
80104fc3:	c3                   	ret    
80104fc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fcf:	90                   	nop
80104fd0:	c9                   	leave  
    return -1;
80104fd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fd6:	c3                   	ret    
80104fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fde:	66 90                	xchg   %ax,%ax

80104fe0 <sys_close>:
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80104fe6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104fe9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fec:	e8 2f fe ff ff       	call   80104e20 <argfd.constprop.0>
80104ff1:	85 c0                	test   %eax,%eax
80104ff3:	78 2b                	js     80105020 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104ff5:	e8 26 ea ff ff       	call   80103a20 <myproc>
80104ffa:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104ffd:	31 c9                	xor    %ecx,%ecx
80104fff:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80105003:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105006:	89 04 24             	mov    %eax,(%esp)
80105009:	e8 d2 be ff ff       	call   80100ee0 <fileclose>
  return 0;
8010500e:	31 c0                	xor    %eax,%eax
}
80105010:	c9                   	leave  
80105011:	c3                   	ret    
80105012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105020:	c9                   	leave  
    return -1;
80105021:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105026:	c3                   	ret    
80105027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010502e:	66 90                	xchg   %ax,%ax

80105030 <sys_fstat>:
{
80105030:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105031:	31 c0                	xor    %eax,%eax
{
80105033:	89 e5                	mov    %esp,%ebp
80105035:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105038:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010503b:	e8 e0 fd ff ff       	call   80104e20 <argfd.constprop.0>
80105040:	85 c0                	test   %eax,%eax
80105042:	78 3c                	js     80105080 <sys_fstat+0x50>
80105044:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010504b:	b8 14 00 00 00       	mov    $0x14,%eax
80105050:	89 44 24 08          	mov    %eax,0x8(%esp)
80105054:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105057:	89 44 24 04          	mov    %eax,0x4(%esp)
8010505b:	e8 10 fb ff ff       	call   80104b70 <argptr>
80105060:	85 c0                	test   %eax,%eax
80105062:	78 1c                	js     80105080 <sys_fstat+0x50>
  return filestat(f, st);
80105064:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105067:	89 44 24 04          	mov    %eax,0x4(%esp)
8010506b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010506e:	89 04 24             	mov    %eax,(%esp)
80105071:	e8 5a bf ff ff       	call   80100fd0 <filestat>
}
80105076:	c9                   	leave  
80105077:	c3                   	ret    
80105078:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010507f:	90                   	nop
80105080:	c9                   	leave  
    return -1;
80105081:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105086:	c3                   	ret    
80105087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010508e:	66 90                	xchg   %ax,%ax

80105090 <sys_link>:
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	57                   	push   %edi
80105094:	56                   	push   %esi
80105095:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105096:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105099:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010509c:	89 44 24 04          	mov    %eax,0x4(%esp)
801050a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801050a7:	e8 34 fb ff ff       	call   80104be0 <argstr>
801050ac:	85 c0                	test   %eax,%eax
801050ae:	0f 88 e5 00 00 00    	js     80105199 <sys_link+0x109>
801050b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050bb:	8d 45 d0             	lea    -0x30(%ebp),%eax
801050be:	89 44 24 04          	mov    %eax,0x4(%esp)
801050c2:	e8 19 fb ff ff       	call   80104be0 <argstr>
801050c7:	85 c0                	test   %eax,%eax
801050c9:	0f 88 ca 00 00 00    	js     80105199 <sys_link+0x109>
  begin_op();
801050cf:	e8 3c dd ff ff       	call   80102e10 <begin_op>
  if((ip = namei(old)) == 0){
801050d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801050d7:	89 04 24             	mov    %eax,(%esp)
801050da:	e8 91 d0 ff ff       	call   80102170 <namei>
801050df:	85 c0                	test   %eax,%eax
801050e1:	89 c3                	mov    %eax,%ebx
801050e3:	0f 84 ab 00 00 00    	je     80105194 <sys_link+0x104>
  ilock(ip);
801050e9:	89 04 24             	mov    %eax,(%esp)
801050ec:	e8 0f c7 ff ff       	call   80101800 <ilock>
  if(ip->type == T_DIR){
801050f1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050f6:	0f 84 90 00 00 00    	je     8010518c <sys_link+0xfc>
  ip->nlink++;
801050fc:	66 ff 43 56          	incw   0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105100:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105103:	89 1c 24             	mov    %ebx,(%esp)
80105106:	e8 35 c6 ff ff       	call   80101740 <iupdate>
  iunlock(ip);
8010510b:	89 1c 24             	mov    %ebx,(%esp)
8010510e:	e8 cd c7 ff ff       	call   801018e0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105113:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105116:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010511a:	89 04 24             	mov    %eax,(%esp)
8010511d:	e8 6e d0 ff ff       	call   80102190 <nameiparent>
80105122:	85 c0                	test   %eax,%eax
80105124:	89 c6                	mov    %eax,%esi
80105126:	74 50                	je     80105178 <sys_link+0xe8>
  ilock(dp);
80105128:	89 04 24             	mov    %eax,(%esp)
8010512b:	e8 d0 c6 ff ff       	call   80101800 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105130:	8b 03                	mov    (%ebx),%eax
80105132:	39 06                	cmp    %eax,(%esi)
80105134:	75 3a                	jne    80105170 <sys_link+0xe0>
80105136:	8b 43 04             	mov    0x4(%ebx),%eax
80105139:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010513d:	89 34 24             	mov    %esi,(%esp)
80105140:	89 44 24 08          	mov    %eax,0x8(%esp)
80105144:	e8 47 cf ff ff       	call   80102090 <dirlink>
80105149:	85 c0                	test   %eax,%eax
8010514b:	78 23                	js     80105170 <sys_link+0xe0>
  iunlockput(dp);
8010514d:	89 34 24             	mov    %esi,(%esp)
80105150:	e8 4b c9 ff ff       	call   80101aa0 <iunlockput>
  iput(ip);
80105155:	89 1c 24             	mov    %ebx,(%esp)
80105158:	e8 d3 c7 ff ff       	call   80101930 <iput>
  end_op();
8010515d:	e8 1e dd ff ff       	call   80102e80 <end_op>
  return 0;
80105162:	31 c0                	xor    %eax,%eax
}
80105164:	83 c4 3c             	add    $0x3c,%esp
80105167:	5b                   	pop    %ebx
80105168:	5e                   	pop    %esi
80105169:	5f                   	pop    %edi
8010516a:	5d                   	pop    %ebp
8010516b:	c3                   	ret    
8010516c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80105170:	89 34 24             	mov    %esi,(%esp)
80105173:	e8 28 c9 ff ff       	call   80101aa0 <iunlockput>
  ilock(ip);
80105178:	89 1c 24             	mov    %ebx,(%esp)
8010517b:	e8 80 c6 ff ff       	call   80101800 <ilock>
  ip->nlink--;
80105180:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80105184:	89 1c 24             	mov    %ebx,(%esp)
80105187:	e8 b4 c5 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
8010518c:	89 1c 24             	mov    %ebx,(%esp)
8010518f:	e8 0c c9 ff ff       	call   80101aa0 <iunlockput>
  end_op();
80105194:	e8 e7 dc ff ff       	call   80102e80 <end_op>
  return -1;
80105199:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010519e:	eb c4                	jmp    80105164 <sys_link+0xd4>

801051a0 <sys_unlink>:
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	57                   	push   %edi
801051a4:	56                   	push   %esi
801051a5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
801051a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801051a9:	83 ec 4c             	sub    $0x4c,%esp
  if(argstr(0, &path) < 0)
801051ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801051b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051b7:	e8 24 fa ff ff       	call   80104be0 <argstr>
801051bc:	85 c0                	test   %eax,%eax
801051be:	0f 88 69 01 00 00    	js     8010532d <sys_unlink+0x18d>
  begin_op();
801051c4:	e8 47 dc ff ff       	call   80102e10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801051c9:	8b 45 c0             	mov    -0x40(%ebp),%eax
801051cc:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801051cf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801051d3:	89 04 24             	mov    %eax,(%esp)
801051d6:	e8 b5 cf ff ff       	call   80102190 <nameiparent>
801051db:	85 c0                	test   %eax,%eax
801051dd:	89 c6                	mov    %eax,%esi
801051df:	0f 84 43 01 00 00    	je     80105328 <sys_unlink+0x188>
  ilock(dp);
801051e5:	89 04 24             	mov    %eax,(%esp)
801051e8:	e8 13 c6 ff ff       	call   80101800 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801051ed:	b8 98 7a 10 80       	mov    $0x80107a98,%eax
801051f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801051f6:	89 1c 24             	mov    %ebx,(%esp)
801051f9:	e8 82 cb ff ff       	call   80101d80 <namecmp>
801051fe:	85 c0                	test   %eax,%eax
80105200:	0f 84 1a 01 00 00    	je     80105320 <sys_unlink+0x180>
80105206:	89 1c 24             	mov    %ebx,(%esp)
80105209:	b8 97 7a 10 80       	mov    $0x80107a97,%eax
8010520e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105212:	e8 69 cb ff ff       	call   80101d80 <namecmp>
80105217:	85 c0                	test   %eax,%eax
80105219:	0f 84 01 01 00 00    	je     80105320 <sys_unlink+0x180>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010521f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105223:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105226:	89 44 24 08          	mov    %eax,0x8(%esp)
8010522a:	89 34 24             	mov    %esi,(%esp)
8010522d:	e8 7e cb ff ff       	call   80101db0 <dirlookup>
80105232:	85 c0                	test   %eax,%eax
80105234:	89 c3                	mov    %eax,%ebx
80105236:	0f 84 e4 00 00 00    	je     80105320 <sys_unlink+0x180>
  ilock(ip);
8010523c:	89 04 24             	mov    %eax,(%esp)
8010523f:	e8 bc c5 ff ff       	call   80101800 <ilock>
  if(ip->nlink < 1)
80105244:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105249:	0f 8e 1a 01 00 00    	jle    80105369 <sys_unlink+0x1c9>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010524f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105254:	8d 55 d8             	lea    -0x28(%ebp),%edx
80105257:	74 77                	je     801052d0 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
80105259:	89 14 24             	mov    %edx,(%esp)
8010525c:	31 c9                	xor    %ecx,%ecx
8010525e:	b8 10 00 00 00       	mov    $0x10,%eax
80105263:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105267:	bf 10 00 00 00       	mov    $0x10,%edi
  memset(&de, 0, sizeof(de));
8010526c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105270:	e8 cb f5 ff ff       	call   80104840 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105275:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105278:	8d 55 d8             	lea    -0x28(%ebp),%edx
8010527b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
8010527f:	89 54 24 04          	mov    %edx,0x4(%esp)
80105283:	89 34 24             	mov    %esi,(%esp)
80105286:	89 44 24 08          	mov    %eax,0x8(%esp)
8010528a:	e8 91 c9 ff ff       	call   80101c20 <writei>
8010528f:	83 f8 10             	cmp    $0x10,%eax
80105292:	0f 85 c5 00 00 00    	jne    8010535d <sys_unlink+0x1bd>
  if(ip->type == T_DIR){
80105298:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010529d:	0f 84 9d 00 00 00    	je     80105340 <sys_unlink+0x1a0>
  iunlockput(dp);
801052a3:	89 34 24             	mov    %esi,(%esp)
801052a6:	e8 f5 c7 ff ff       	call   80101aa0 <iunlockput>
  ip->nlink--;
801052ab:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801052af:	89 1c 24             	mov    %ebx,(%esp)
801052b2:	e8 89 c4 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
801052b7:	89 1c 24             	mov    %ebx,(%esp)
801052ba:	e8 e1 c7 ff ff       	call   80101aa0 <iunlockput>
  end_op();
801052bf:	e8 bc db ff ff       	call   80102e80 <end_op>
  return 0;
801052c4:	31 c0                	xor    %eax,%eax
}
801052c6:	83 c4 4c             	add    $0x4c,%esp
801052c9:	5b                   	pop    %ebx
801052ca:	5e                   	pop    %esi
801052cb:	5f                   	pop    %edi
801052cc:	5d                   	pop    %ebp
801052cd:	c3                   	ret    
801052ce:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801052d0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801052d4:	76 83                	jbe    80105259 <sys_unlink+0xb9>
801052d6:	bf 20 00 00 00       	mov    $0x20,%edi
801052db:	eb 0f                	jmp    801052ec <sys_unlink+0x14c>
801052dd:	8d 76 00             	lea    0x0(%esi),%esi
801052e0:	83 c7 10             	add    $0x10,%edi
801052e3:	39 7b 58             	cmp    %edi,0x58(%ebx)
801052e6:	0f 86 6d ff ff ff    	jbe    80105259 <sys_unlink+0xb9>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052ec:	89 54 24 04          	mov    %edx,0x4(%esp)
801052f0:	b8 10 00 00 00       	mov    $0x10,%eax
801052f5:	89 44 24 0c          	mov    %eax,0xc(%esp)
801052f9:	89 7c 24 08          	mov    %edi,0x8(%esp)
801052fd:	89 1c 24             	mov    %ebx,(%esp)
80105300:	e8 eb c7 ff ff       	call   80101af0 <readi>
80105305:	8d 55 d8             	lea    -0x28(%ebp),%edx
80105308:	83 f8 10             	cmp    $0x10,%eax
8010530b:	75 44                	jne    80105351 <sys_unlink+0x1b1>
    if(de.inum != 0)
8010530d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105312:	74 cc                	je     801052e0 <sys_unlink+0x140>
    iunlockput(ip);
80105314:	89 1c 24             	mov    %ebx,(%esp)
80105317:	e8 84 c7 ff ff       	call   80101aa0 <iunlockput>
    goto bad;
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105320:	89 34 24             	mov    %esi,(%esp)
80105323:	e8 78 c7 ff ff       	call   80101aa0 <iunlockput>
  end_op();
80105328:	e8 53 db ff ff       	call   80102e80 <end_op>
  return -1;
8010532d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105332:	eb 92                	jmp    801052c6 <sys_unlink+0x126>
80105334:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010533b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010533f:	90                   	nop
    dp->nlink--;
80105340:	66 ff 4e 56          	decw   0x56(%esi)
    iupdate(dp);
80105344:	89 34 24             	mov    %esi,(%esp)
80105347:	e8 f4 c3 ff ff       	call   80101740 <iupdate>
8010534c:	e9 52 ff ff ff       	jmp    801052a3 <sys_unlink+0x103>
      panic("isdirempty: readi");
80105351:	c7 04 24 bc 7a 10 80 	movl   $0x80107abc,(%esp)
80105358:	e8 03 b0 ff ff       	call   80100360 <panic>
    panic("unlink: writei");
8010535d:	c7 04 24 ce 7a 10 80 	movl   $0x80107ace,(%esp)
80105364:	e8 f7 af ff ff       	call   80100360 <panic>
    panic("unlink: nlink < 1");
80105369:	c7 04 24 aa 7a 10 80 	movl   $0x80107aaa,(%esp)
80105370:	e8 eb af ff ff       	call   80100360 <panic>
80105375:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_open>:

int
sys_open(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	57                   	push   %edi
80105384:	56                   	push   %esi
80105385:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105386:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105389:	83 ec 2c             	sub    $0x2c,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010538c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105390:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105397:	e8 44 f8 ff ff       	call   80104be0 <argstr>
8010539c:	85 c0                	test   %eax,%eax
8010539e:	0f 88 7f 00 00 00    	js     80105423 <sys_open+0xa3>
801053a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801053ab:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801053ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801053b2:	e8 69 f7 ff ff       	call   80104b20 <argint>
801053b7:	85 c0                	test   %eax,%eax
801053b9:	78 68                	js     80105423 <sys_open+0xa3>
    return -1;

  begin_op();
801053bb:	e8 50 da ff ff       	call   80102e10 <begin_op>

  if(omode & O_CREATE){
801053c0:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801053c4:	75 6a                	jne    80105430 <sys_open+0xb0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801053c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801053c9:	89 04 24             	mov    %eax,(%esp)
801053cc:	e8 9f cd ff ff       	call   80102170 <namei>
801053d1:	85 c0                	test   %eax,%eax
801053d3:	89 c6                	mov    %eax,%esi
801053d5:	74 47                	je     8010541e <sys_open+0x9e>
      end_op();
      return -1;
    }
    ilock(ip);
801053d7:	89 04 24             	mov    %eax,(%esp)
801053da:	e8 21 c4 ff ff       	call   80101800 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801053df:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801053e4:	0f 84 a6 00 00 00    	je     80105490 <sys_open+0x110>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801053ea:	e8 31 ba ff ff       	call   80100e20 <filealloc>
801053ef:	85 c0                	test   %eax,%eax
801053f1:	89 c7                	mov    %eax,%edi
801053f3:	74 21                	je     80105416 <sys_open+0x96>
  struct proc *curproc = myproc();
801053f5:	e8 26 e6 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801053fa:	31 db                	xor    %ebx,%ebx
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105400:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105404:	85 d2                	test   %edx,%edx
80105406:	74 48                	je     80105450 <sys_open+0xd0>
  for(fd = 0; fd < NOFILE; fd++){
80105408:	43                   	inc    %ebx
80105409:	83 fb 10             	cmp    $0x10,%ebx
8010540c:	75 f2                	jne    80105400 <sys_open+0x80>
    if(f)
      fileclose(f);
8010540e:	89 3c 24             	mov    %edi,(%esp)
80105411:	e8 ca ba ff ff       	call   80100ee0 <fileclose>
    iunlockput(ip);
80105416:	89 34 24             	mov    %esi,(%esp)
80105419:	e8 82 c6 ff ff       	call   80101aa0 <iunlockput>
    end_op();
8010541e:	e8 5d da ff ff       	call   80102e80 <end_op>
    return -1;
80105423:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105428:	eb 5b                	jmp    80105485 <sys_open+0x105>
8010542a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip = create(path, T_FILE, 0, 0);
80105430:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105433:	31 c9                	xor    %ecx,%ecx
80105435:	ba 02 00 00 00       	mov    $0x2,%edx
8010543a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105441:	e8 4a f8 ff ff       	call   80104c90 <create>
    if(ip == 0){
80105446:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105448:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010544a:	75 9e                	jne    801053ea <sys_open+0x6a>
8010544c:	eb d0                	jmp    8010541e <sys_open+0x9e>
8010544e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105450:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  }
  iunlock(ip);
80105454:	89 34 24             	mov    %esi,(%esp)
80105457:	e8 84 c4 ff ff       	call   801018e0 <iunlock>
  end_op();
8010545c:	e8 1f da ff ff       	call   80102e80 <end_op>

  f->type = FD_INODE;
80105461:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
80105467:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010546a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->off = 0;
8010546d:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105474:	89 d0                	mov    %edx,%eax
80105476:	f7 d0                	not    %eax
80105478:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010547b:	f6 c2 03             	test   $0x3,%dl
  f->readable = !(omode & O_WRONLY);
8010547e:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105481:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105485:	83 c4 2c             	add    $0x2c,%esp
80105488:	89 d8                	mov    %ebx,%eax
8010548a:	5b                   	pop    %ebx
8010548b:	5e                   	pop    %esi
8010548c:	5f                   	pop    %edi
8010548d:	5d                   	pop    %ebp
8010548e:	c3                   	ret    
8010548f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105490:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105493:	85 c9                	test   %ecx,%ecx
80105495:	0f 84 4f ff ff ff    	je     801053ea <sys_open+0x6a>
8010549b:	e9 76 ff ff ff       	jmp    80105416 <sys_open+0x96>

801054a0 <sys_mkdir>:

int
sys_mkdir(void)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054a6:	e8 65 d9 ff ff       	call   80102e10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801054ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801054b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054b9:	e8 22 f7 ff ff       	call   80104be0 <argstr>
801054be:	85 c0                	test   %eax,%eax
801054c0:	78 2e                	js     801054f0 <sys_mkdir+0x50>
801054c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054c5:	31 c9                	xor    %ecx,%ecx
801054c7:	ba 01 00 00 00       	mov    $0x1,%edx
801054cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054d3:	e8 b8 f7 ff ff       	call   80104c90 <create>
801054d8:	85 c0                	test   %eax,%eax
801054da:	74 14                	je     801054f0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801054dc:	89 04 24             	mov    %eax,(%esp)
801054df:	e8 bc c5 ff ff       	call   80101aa0 <iunlockput>
  end_op();
801054e4:	e8 97 d9 ff ff       	call   80102e80 <end_op>
  return 0;
801054e9:	31 c0                	xor    %eax,%eax
}
801054eb:	c9                   	leave  
801054ec:	c3                   	ret    
801054ed:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801054f0:	e8 8b d9 ff ff       	call   80102e80 <end_op>
    return -1;
801054f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054fa:	c9                   	leave  
801054fb:	c3                   	ret    
801054fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105500 <sys_mknod>:

int
sys_mknod(void)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105506:	e8 05 d9 ff ff       	call   80102e10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010550b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010550e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105512:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105519:	e8 c2 f6 ff ff       	call   80104be0 <argstr>
8010551e:	85 c0                	test   %eax,%eax
80105520:	78 5e                	js     80105580 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105522:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105529:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010552c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105530:	e8 eb f5 ff ff       	call   80104b20 <argint>
  if((argstr(0, &path)) < 0 ||
80105535:	85 c0                	test   %eax,%eax
80105537:	78 47                	js     80105580 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105539:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105540:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105543:	89 44 24 04          	mov    %eax,0x4(%esp)
80105547:	e8 d4 f5 ff ff       	call   80104b20 <argint>
     argint(1, &major) < 0 ||
8010554c:	85 c0                	test   %eax,%eax
8010554e:	78 30                	js     80105580 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105550:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105554:	ba 03 00 00 00       	mov    $0x3,%edx
80105559:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010555d:	89 04 24             	mov    %eax,(%esp)
80105560:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105563:	e8 28 f7 ff ff       	call   80104c90 <create>
     argint(2, &minor) < 0 ||
80105568:	85 c0                	test   %eax,%eax
8010556a:	74 14                	je     80105580 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010556c:	89 04 24             	mov    %eax,(%esp)
8010556f:	e8 2c c5 ff ff       	call   80101aa0 <iunlockput>
  end_op();
80105574:	e8 07 d9 ff ff       	call   80102e80 <end_op>
  return 0;
80105579:	31 c0                	xor    %eax,%eax
}
8010557b:	c9                   	leave  
8010557c:	c3                   	ret    
8010557d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105580:	e8 fb d8 ff ff       	call   80102e80 <end_op>
    return -1;
80105585:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010558a:	c9                   	leave  
8010558b:	c3                   	ret    
8010558c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105590 <sys_chdir>:

int
sys_chdir(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	56                   	push   %esi
80105594:	53                   	push   %ebx
80105595:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105598:	e8 83 e4 ff ff       	call   80103a20 <myproc>
8010559d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010559f:	e8 6c d8 ff ff       	call   80102e10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801055a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801055ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801055b2:	e8 29 f6 ff ff       	call   80104be0 <argstr>
801055b7:	85 c0                	test   %eax,%eax
801055b9:	78 4a                	js     80105605 <sys_chdir+0x75>
801055bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055be:	89 04 24             	mov    %eax,(%esp)
801055c1:	e8 aa cb ff ff       	call   80102170 <namei>
801055c6:	85 c0                	test   %eax,%eax
801055c8:	89 c3                	mov    %eax,%ebx
801055ca:	74 39                	je     80105605 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
801055cc:	89 04 24             	mov    %eax,(%esp)
801055cf:	e8 2c c2 ff ff       	call   80101800 <ilock>
  if(ip->type != T_DIR){
801055d4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
801055d9:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
801055dc:	75 22                	jne    80105600 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
801055de:	e8 fd c2 ff ff       	call   801018e0 <iunlock>
  iput(curproc->cwd);
801055e3:	8b 46 68             	mov    0x68(%esi),%eax
801055e6:	89 04 24             	mov    %eax,(%esp)
801055e9:	e8 42 c3 ff ff       	call   80101930 <iput>
  end_op();
801055ee:	e8 8d d8 ff ff       	call   80102e80 <end_op>
  curproc->cwd = ip;
  return 0;
801055f3:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
801055f5:	89 5e 68             	mov    %ebx,0x68(%esi)
}
801055f8:	83 c4 20             	add    $0x20,%esp
801055fb:	5b                   	pop    %ebx
801055fc:	5e                   	pop    %esi
801055fd:	5d                   	pop    %ebp
801055fe:	c3                   	ret    
801055ff:	90                   	nop
    iunlockput(ip);
80105600:	e8 9b c4 ff ff       	call   80101aa0 <iunlockput>
    end_op();
80105605:	e8 76 d8 ff ff       	call   80102e80 <end_op>
    return -1;
8010560a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010560f:	eb e7                	jmp    801055f8 <sys_chdir+0x68>
80105611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010561f:	90                   	nop

80105620 <sys_exec>:

int
sys_exec(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	57                   	push   %edi
80105624:	56                   	push   %esi
80105625:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105626:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010562c:	81 ec ac 00 00 00    	sub    $0xac,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105632:	89 44 24 04          	mov    %eax,0x4(%esp)
80105636:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010563d:	e8 9e f5 ff ff       	call   80104be0 <argstr>
80105642:	85 c0                	test   %eax,%eax
80105644:	0f 88 8e 00 00 00    	js     801056d8 <sys_exec+0xb8>
8010564a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105651:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105657:	89 44 24 04          	mov    %eax,0x4(%esp)
8010565b:	e8 c0 f4 ff ff       	call   80104b20 <argint>
80105660:	85 c0                	test   %eax,%eax
80105662:	78 74                	js     801056d8 <sys_exec+0xb8>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105664:	ba 80 00 00 00       	mov    $0x80,%edx
80105669:	31 c9                	xor    %ecx,%ecx
8010566b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010566f:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105675:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105677:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010567b:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105681:	89 04 24             	mov    %eax,(%esp)
80105684:	e8 b7 f1 ff ff       	call   80104840 <memset>
    if(i >= NELEM(argv))
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105690:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105694:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010569a:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801056a1:	01 f0                	add    %esi,%eax
801056a3:	89 04 24             	mov    %eax,(%esp)
801056a6:	e8 e5 f3 ff ff       	call   80104a90 <fetchint>
801056ab:	85 c0                	test   %eax,%eax
801056ad:	78 29                	js     801056d8 <sys_exec+0xb8>
      return -1;
    if(uarg == 0){
801056af:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801056b5:	85 c0                	test   %eax,%eax
801056b7:	74 37                	je     801056f0 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801056b9:	89 04 24             	mov    %eax,(%esp)
801056bc:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801056c2:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801056c5:	89 54 24 04          	mov    %edx,0x4(%esp)
801056c9:	e8 02 f4 ff ff       	call   80104ad0 <fetchstr>
801056ce:	85 c0                	test   %eax,%eax
801056d0:	78 06                	js     801056d8 <sys_exec+0xb8>
  for(i=0;; i++){
801056d2:	43                   	inc    %ebx
    if(i >= NELEM(argv))
801056d3:	83 fb 20             	cmp    $0x20,%ebx
801056d6:	75 b8                	jne    80105690 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
801056d8:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
801056de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056e3:	5b                   	pop    %ebx
801056e4:	5e                   	pop    %esi
801056e5:	5f                   	pop    %edi
801056e6:	5d                   	pop    %ebp
801056e7:	c3                   	ret    
801056e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ef:	90                   	nop
      argv[i] = 0;
801056f0:	31 c0                	xor    %eax,%eax
801056f2:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
  return exec(path, argv);
801056f9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801056ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80105703:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80105709:	89 04 24             	mov    %eax,(%esp)
8010570c:	e8 5f b3 ff ff       	call   80100a70 <exec>
}
80105711:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105717:	5b                   	pop    %ebx
80105718:	5e                   	pop    %esi
80105719:	5f                   	pop    %edi
8010571a:	5d                   	pop    %ebp
8010571b:	c3                   	ret    
8010571c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105720 <sys_pipe>:

int
sys_pipe(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105724:	bf 08 00 00 00       	mov    $0x8,%edi
{
80105729:	56                   	push   %esi
8010572a:	53                   	push   %ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010572b:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
8010572e:	83 ec 2c             	sub    $0x2c,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105731:	89 7c 24 08          	mov    %edi,0x8(%esp)
80105735:	89 44 24 04          	mov    %eax,0x4(%esp)
80105739:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105740:	e8 2b f4 ff ff       	call   80104b70 <argptr>
80105745:	85 c0                	test   %eax,%eax
80105747:	78 4b                	js     80105794 <sys_pipe+0x74>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105749:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010574c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105750:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105753:	89 04 24             	mov    %eax,(%esp)
80105756:	e8 25 dd ff ff       	call   80103480 <pipealloc>
8010575b:	85 c0                	test   %eax,%eax
8010575d:	78 35                	js     80105794 <sys_pipe+0x74>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010575f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105762:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105764:	e8 b7 e2 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105770:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105774:	85 f6                	test   %esi,%esi
80105776:	74 28                	je     801057a0 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80105778:	43                   	inc    %ebx
80105779:	83 fb 10             	cmp    $0x10,%ebx
8010577c:	75 f2                	jne    80105770 <sys_pipe+0x50>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
8010577e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105781:	89 04 24             	mov    %eax,(%esp)
80105784:	e8 57 b7 ff ff       	call   80100ee0 <fileclose>
    fileclose(wf);
80105789:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010578c:	89 04 24             	mov    %eax,(%esp)
8010578f:	e8 4c b7 ff ff       	call   80100ee0 <fileclose>
    return -1;
80105794:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105799:	eb 56                	jmp    801057f1 <sys_pipe+0xd1>
8010579b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010579f:	90                   	nop
      curproc->ofile[fd] = f;
801057a0:	8d 73 08             	lea    0x8(%ebx),%esi
801057a3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801057aa:	e8 71 e2 ff ff       	call   80103a20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057af:	31 d2                	xor    %edx,%edx
801057b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057bf:	90                   	nop
    if(curproc->ofile[fd] == 0){
801057c0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801057c4:	85 c9                	test   %ecx,%ecx
801057c6:	74 18                	je     801057e0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
801057c8:	42                   	inc    %edx
801057c9:	83 fa 10             	cmp    $0x10,%edx
801057cc:	75 f2                	jne    801057c0 <sys_pipe+0xa0>
      myproc()->ofile[fd0] = 0;
801057ce:	e8 4d e2 ff ff       	call   80103a20 <myproc>
801057d3:	31 d2                	xor    %edx,%edx
801057d5:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
801057d9:	eb a3                	jmp    8010577e <sys_pipe+0x5e>
801057db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057df:	90                   	nop
      curproc->ofile[fd] = f;
801057e0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801057e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801057e7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801057e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801057ec:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801057ef:	31 c0                	xor    %eax,%eax
}
801057f1:	83 c4 2c             	add    $0x2c,%esp
801057f4:	5b                   	pop    %ebx
801057f5:	5e                   	pop    %esi
801057f6:	5f                   	pop    %edi
801057f7:	5d                   	pop    %ebp
801057f8:	c3                   	ret    
801057f9:	66 90                	xchg   %ax,%ax
801057fb:	66 90                	xchg   %ax,%ax
801057fd:	66 90                	xchg   %ax,%ax
801057ff:	90                   	nop

80105800 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105800:	e9 cb e3 ff ff       	jmp    80103bd0 <fork>
80105805:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010580c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105810 <sys_exit>:
}

int
sys_exit(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	83 ec 08             	sub    $0x8,%esp
  exit();
80105816:	e8 25 e6 ff ff       	call   80103e40 <exit>
  return 0;  // not reached
}
8010581b:	31 c0                	xor    %eax,%eax
8010581d:	c9                   	leave  
8010581e:	c3                   	ret    
8010581f:	90                   	nop

80105820 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105820:	e9 7b e8 ff ff       	jmp    801040a0 <wait>
80105825:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105830 <sys_waitx>:
}

int sys_waitx(void){
80105830:	55                   	push   %ebp
  int *rtime, *wtime;

  if (argptr(0, (char **)&wtime, sizeof(int)) < 0)
80105831:	ba 04 00 00 00       	mov    $0x4,%edx
int sys_waitx(void){
80105836:	89 e5                	mov    %esp,%ebp
80105838:	83 ec 28             	sub    $0x28,%esp
  if (argptr(0, (char **)&wtime, sizeof(int)) < 0)
8010583b:	89 54 24 08          	mov    %edx,0x8(%esp)
8010583f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105842:	89 44 24 04          	mov    %eax,0x4(%esp)
80105846:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010584d:	e8 1e f3 ff ff       	call   80104b70 <argptr>
80105852:	85 c0                	test   %eax,%eax
80105854:	78 3a                	js     80105890 <sys_waitx+0x60>
    return -1;

  if (argptr(1, (char **)&rtime, sizeof(int)) < 0)
80105856:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010585d:	b8 04 00 00 00       	mov    $0x4,%eax
80105862:	89 44 24 08          	mov    %eax,0x8(%esp)
80105866:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105869:	89 44 24 04          	mov    %eax,0x4(%esp)
8010586d:	e8 fe f2 ff ff       	call   80104b70 <argptr>
80105872:	85 c0                	test   %eax,%eax
80105874:	78 1a                	js     80105890 <sys_waitx+0x60>
    return -1;
  
  return waitx(wtime, rtime);
80105876:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105879:	89 44 24 04          	mov    %eax,0x4(%esp)
8010587d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105880:	89 04 24             	mov    %eax,(%esp)
80105883:	e8 18 e9 ff ff       	call   801041a0 <waitx>
}
80105888:	c9                   	leave  
80105889:	c3                   	ret    
8010588a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105890:	c9                   	leave  
    return -1;
80105891:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105896:	c3                   	ret    
80105897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010589e:	66 90                	xchg   %ax,%ax

801058a0 <sys_kill>:

int
sys_kill(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801058a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058ad:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801058b4:	e8 67 f2 ff ff       	call   80104b20 <argint>
801058b9:	85 c0                	test   %eax,%eax
801058bb:	78 13                	js     801058d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801058bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058c0:	89 04 24             	mov    %eax,(%esp)
801058c3:	e8 68 ea ff ff       	call   80104330 <kill>
}
801058c8:	c9                   	leave  
801058c9:	c3                   	ret    
801058ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058d0:	c9                   	leave  
    return -1;
801058d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058d6:	c3                   	ret    
801058d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058de:	66 90                	xchg   %ax,%ax

801058e0 <sys_getpid>:

int
sys_getpid(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801058e6:	e8 35 e1 ff ff       	call   80103a20 <myproc>
801058eb:	8b 40 10             	mov    0x10(%eax),%eax
}
801058ee:	c9                   	leave  
801058ef:	c3                   	ret    

801058f0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058f7:	83 ec 24             	sub    $0x24,%esp
  if(argint(0, &n) < 0)
801058fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801058fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105905:	e8 16 f2 ff ff       	call   80104b20 <argint>
8010590a:	85 c0                	test   %eax,%eax
8010590c:	78 22                	js     80105930 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010590e:	e8 0d e1 ff ff       	call   80103a20 <myproc>
80105913:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105915:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105918:	89 04 24             	mov    %eax,(%esp)
8010591b:	e8 30 e2 ff ff       	call   80103b50 <growproc>
80105920:	85 c0                	test   %eax,%eax
80105922:	78 0c                	js     80105930 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105924:	83 c4 24             	add    $0x24,%esp
80105927:	89 d8                	mov    %ebx,%eax
80105929:	5b                   	pop    %ebx
8010592a:	5d                   	pop    %ebp
8010592b:	c3                   	ret    
8010592c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105930:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105935:	eb ed                	jmp    80105924 <sys_sbrk+0x34>
80105937:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010593e:	66 90                	xchg   %ax,%ax

80105940 <sys_sleep>:

int
sys_sleep(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105944:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105947:	83 ec 24             	sub    $0x24,%esp
  if(argint(0, &n) < 0)
8010594a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010594e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105955:	e8 c6 f1 ff ff       	call   80104b20 <argint>
8010595a:	85 c0                	test   %eax,%eax
8010595c:	0f 88 82 00 00 00    	js     801059e4 <sys_sleep+0xa4>
    return -1;
  acquire(&tickslock);
80105962:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105969:	e8 d2 ed ff ff       	call   80104740 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010596e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  ticks0 = ticks;
80105971:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  while(ticks - ticks0 < n){
80105977:	85 c9                	test   %ecx,%ecx
80105979:	75 26                	jne    801059a1 <sys_sleep+0x61>
8010597b:	eb 53                	jmp    801059d0 <sys_sleep+0x90>
8010597d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105980:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
80105987:	b8 60 50 11 80       	mov    $0x80115060,%eax
8010598c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105990:	e8 3b e6 ff ff       	call   80103fd0 <sleep>
  while(ticks - ticks0 < n){
80105995:	a1 a0 58 11 80       	mov    0x801158a0,%eax
8010599a:	29 d8                	sub    %ebx,%eax
8010599c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010599f:	73 2f                	jae    801059d0 <sys_sleep+0x90>
    if(myproc()->killed){
801059a1:	e8 7a e0 ff ff       	call   80103a20 <myproc>
801059a6:	8b 50 24             	mov    0x24(%eax),%edx
801059a9:	85 d2                	test   %edx,%edx
801059ab:	74 d3                	je     80105980 <sys_sleep+0x40>
      release(&tickslock);
801059ad:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
801059b4:	e8 37 ee ff ff       	call   801047f0 <release>
  }
  release(&tickslock);
  return 0;
}
801059b9:	83 c4 24             	add    $0x24,%esp
      return -1;
801059bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059c1:	5b                   	pop    %ebx
801059c2:	5d                   	pop    %ebp
801059c3:	c3                   	ret    
801059c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059cf:	90                   	nop
  release(&tickslock);
801059d0:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
801059d7:	e8 14 ee ff ff       	call   801047f0 <release>
  return 0;
801059dc:	31 c0                	xor    %eax,%eax
}
801059de:	83 c4 24             	add    $0x24,%esp
801059e1:	5b                   	pop    %ebx
801059e2:	5d                   	pop    %ebp
801059e3:	c3                   	ret    
    return -1;
801059e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059e9:	eb f3                	jmp    801059de <sys_sleep+0x9e>
801059eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059ef:	90                   	nop

801059f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	53                   	push   %ebx
801059f4:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

 acquire(&tickslock);
801059f7:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
801059fe:	e8 3d ed ff ff       	call   80104740 <acquire>
  xticks = ticks;
80105a03:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
  release(&tickslock); 
80105a09:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105a10:	e8 db ed ff ff       	call   801047f0 <release>
  return xticks;
}
80105a15:	83 c4 14             	add    $0x14,%esp
80105a18:	89 d8                	mov    %ebx,%eax
80105a1a:	5b                   	pop    %ebx
80105a1b:	5d                   	pop    %ebp
80105a1c:	c3                   	ret    

80105a1d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105a1d:	1e                   	push   %ds
  pushl %es
80105a1e:	06                   	push   %es
  pushl %fs
80105a1f:	0f a0                	push   %fs
  pushl %gs
80105a21:	0f a8                	push   %gs
  pushal
80105a23:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105a24:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105a28:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105a2a:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105a2c:	54                   	push   %esp
  call trap
80105a2d:	e8 be 00 00 00       	call   80105af0 <trap>
  addl $4, %esp
80105a32:	83 c4 04             	add    $0x4,%esp

80105a35 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105a35:	61                   	popa   
  popl %gs
80105a36:	0f a9                	pop    %gs
  popl %fs
80105a38:	0f a1                	pop    %fs
  popl %es
80105a3a:	07                   	pop    %es
  popl %ds
80105a3b:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105a3c:	83 c4 08             	add    $0x8,%esp
  iret
80105a3f:	cf                   	iret   

80105a40 <tvinit>:
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void tvinit(void)
{
80105a40:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105a41:	31 c0                	xor    %eax,%eax
{
80105a43:	89 e5                	mov    %esp,%ebp
80105a45:	83 ec 18             	sub    $0x18,%esp
80105a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a4f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a50:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105a57:	b9 08 00 00 8e       	mov    $0x8e000008,%ecx
80105a5c:	89 0c c5 a2 50 11 80 	mov    %ecx,-0x7feeaf5e(,%eax,8)
80105a63:	66 89 14 c5 a0 50 11 	mov    %dx,-0x7feeaf60(,%eax,8)
80105a6a:	80 
80105a6b:	c1 ea 10             	shr    $0x10,%edx
80105a6e:	66 89 14 c5 a6 50 11 	mov    %dx,-0x7feeaf5a(,%eax,8)
80105a75:	80 
  for(i = 0; i < 256; i++)
80105a76:	40                   	inc    %eax
80105a77:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a7c:	75 d2                	jne    80105a50 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a7e:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105a83:	b9 dd 7a 10 80       	mov    $0x80107add,%ecx
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a88:	ba 08 00 00 ef       	mov    $0xef000008,%edx
  initlock(&tickslock, "time");
80105a8d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80105a91:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a98:	89 15 a2 52 11 80    	mov    %edx,0x801152a2
80105a9e:	66 a3 a0 52 11 80    	mov    %ax,0x801152a0
80105aa4:	c1 e8 10             	shr    $0x10,%eax
80105aa7:	66 a3 a6 52 11 80    	mov    %ax,0x801152a6
  initlock(&tickslock, "time");
80105aad:	e8 1e eb ff ff       	call   801045d0 <initlock>
}
80105ab2:	c9                   	leave  
80105ab3:	c3                   	ret    
80105ab4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105abf:	90                   	nop

80105ac0 <idtinit>:

void idtinit(void)
{
80105ac0:	55                   	push   %ebp
  pd[1] = (uint)p;
80105ac1:	b8 a0 50 11 80       	mov    $0x801150a0,%eax
80105ac6:	89 e5                	mov    %esp,%ebp
80105ac8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80105acb:	c1 e8 10             	shr    $0x10,%eax
80105ace:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80105ad1:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105ad7:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105adb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105adf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ae2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ae5:	c9                   	leave  
80105ae6:	c3                   	ret    
80105ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aee:	66 90                	xchg   %ax,%ax

80105af0 <trap>:

//PAGEBREAK: 41
void trap(struct trapframe *tf)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	57                   	push   %edi
80105af4:	56                   	push   %esi
80105af5:	53                   	push   %ebx
80105af6:	83 ec 3c             	sub    $0x3c,%esp
80105af9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105afc:	8b 43 30             	mov    0x30(%ebx),%eax
80105aff:	83 f8 40             	cmp    $0x40,%eax
80105b02:	0f 84 28 02 00 00    	je     80105d30 <trap+0x240>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105b08:	83 e8 20             	sub    $0x20,%eax
80105b0b:	83 f8 1f             	cmp    $0x1f,%eax
80105b0e:	77 07                	ja     80105b17 <trap+0x27>
80105b10:	ff 24 85 84 7b 10 80 	jmp    *-0x7fef847c(,%eax,4)
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105b17:	e8 04 df ff ff       	call   80103a20 <myproc>
80105b1c:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b1f:	85 c0                	test   %eax,%eax
80105b21:	0f 84 70 02 00 00    	je     80105d97 <trap+0x2a7>
80105b27:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105b2b:	0f 84 66 02 00 00    	je     80105d97 <trap+0x2a7>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105b31:	0f 20 d1             	mov    %cr2,%ecx
80105b34:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b37:	e8 c4 de ff ff       	call   80103a00 <cpuid>
80105b3c:	8b 73 30             	mov    0x30(%ebx),%esi
80105b3f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105b42:	8b 43 34             	mov    0x34(%ebx),%eax
80105b45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105b48:	e8 d3 de ff ff       	call   80103a20 <myproc>
80105b4d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b50:	e8 cb de ff ff       	call   80103a20 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b55:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b58:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105b5c:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b5f:	89 7c 24 18          	mov    %edi,0x18(%esp)
80105b63:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b66:	89 54 24 14          	mov    %edx,0x14(%esp)
80105b6a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80105b6d:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b70:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105b74:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b78:	89 54 24 10          	mov    %edx,0x10(%esp)
80105b7c:	8b 40 10             	mov    0x10(%eax),%eax
80105b7f:	c7 04 24 40 7b 10 80 	movl   $0x80107b40,(%esp)
80105b86:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b8a:	e8 f1 aa ff ff       	call   80100680 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105b8f:	e8 8c de ff ff       	call   80103a20 <myproc>
80105b94:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b9b:	e8 80 de ff ff       	call   80103a20 <myproc>
80105ba0:	85 c0                	test   %eax,%eax
80105ba2:	74 1b                	je     80105bbf <trap+0xcf>
80105ba4:	e8 77 de ff ff       	call   80103a20 <myproc>
80105ba9:	8b 50 24             	mov    0x24(%eax),%edx
80105bac:	85 d2                	test   %edx,%edx
80105bae:	74 0f                	je     80105bbf <trap+0xcf>
80105bb0:	8b 43 3c             	mov    0x3c(%ebx),%eax
80105bb3:	83 e0 03             	and    $0x3,%eax
80105bb6:	83 f8 03             	cmp    $0x3,%eax
80105bb9:	0f 84 b1 01 00 00    	je     80105d70 <trap+0x280>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105bbf:	e8 5c de ff ff       	call   80103a20 <myproc>
80105bc4:	85 c0                	test   %eax,%eax
80105bc6:	74 0f                	je     80105bd7 <trap+0xe7>
80105bc8:	e8 53 de ff ff       	call   80103a20 <myproc>
80105bcd:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105bd1:	0f 84 39 01 00 00    	je     80105d10 <trap+0x220>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bd7:	e8 44 de ff ff       	call   80103a20 <myproc>
80105bdc:	85 c0                	test   %eax,%eax
80105bde:	66 90                	xchg   %ax,%ax
80105be0:	74 1b                	je     80105bfd <trap+0x10d>
80105be2:	e8 39 de ff ff       	call   80103a20 <myproc>
80105be7:	8b 40 24             	mov    0x24(%eax),%eax
80105bea:	85 c0                	test   %eax,%eax
80105bec:	74 0f                	je     80105bfd <trap+0x10d>
80105bee:	8b 43 3c             	mov    0x3c(%ebx),%eax
80105bf1:	83 e0 03             	and    $0x3,%eax
80105bf4:	83 f8 03             	cmp    $0x3,%eax
80105bf7:	0f 84 5c 01 00 00    	je     80105d59 <trap+0x269>
    exit();
}
80105bfd:	83 c4 3c             	add    $0x3c,%esp
80105c00:	5b                   	pop    %ebx
80105c01:	5e                   	pop    %esi
80105c02:	5f                   	pop    %edi
80105c03:	5d                   	pop    %ebp
80105c04:	c3                   	ret    
    ideintr();
80105c05:	e8 f6 c6 ff ff       	call   80102300 <ideintr>
    lapiceoi();
80105c0a:	e8 d1 cd ff ff       	call   801029e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c0f:	90                   	nop
80105c10:	e8 0b de ff ff       	call   80103a20 <myproc>
80105c15:	85 c0                	test   %eax,%eax
80105c17:	75 8b                	jne    80105ba4 <trap+0xb4>
80105c19:	eb a4                	jmp    80105bbf <trap+0xcf>
    if(cpuid() == 0){
80105c1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c1f:	90                   	nop
80105c20:	e8 db dd ff ff       	call   80103a00 <cpuid>
80105c25:	85 c0                	test   %eax,%eax
80105c27:	75 e1                	jne    80105c0a <trap+0x11a>
      acquire(&tickslock);
80105c29:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105c30:	e8 0b eb ff ff       	call   80104740 <acquire>
      wakeup(&ticks);
80105c35:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
      ticks++;
80105c3c:	ff 05 a0 58 11 80    	incl   0x801158a0
      wakeup(&ticks);
80105c42:	e8 89 e6 ff ff       	call   801042d0 <wakeup>
      release(&tickslock);
80105c47:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105c4e:	e8 9d eb ff ff       	call   801047f0 <release>
      if( myproc() ){
80105c53:	e8 c8 dd ff ff       	call   80103a20 <myproc>
80105c58:	85 c0                	test   %eax,%eax
80105c5a:	74 ae                	je     80105c0a <trap+0x11a>
        if( myproc() -> state == RUNNING )
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c60:	e8 bb dd ff ff       	call   80103a20 <myproc>
80105c65:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105c69:	0f 84 18 01 00 00    	je     80105d87 <trap+0x297>
        else if( myproc() -> state == SLEEPING )
80105c6f:	e8 ac dd ff ff       	call   80103a20 <myproc>
80105c74:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80105c78:	75 90                	jne    80105c0a <trap+0x11a>
          myproc() -> iotime += 1;
80105c7a:	e8 a1 dd ff ff       	call   80103a20 <myproc>
80105c7f:	ff 80 84 00 00 00    	incl   0x84(%eax)
    lapiceoi();
80105c85:	eb 83                	jmp    80105c0a <trap+0x11a>
    kbdintr();
80105c87:	e8 14 cc ff ff       	call   801028a0 <kbdintr>
    lapiceoi();
80105c8c:	e8 4f cd ff ff       	call   801029e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c91:	e8 8a dd ff ff       	call   80103a20 <myproc>
80105c96:	85 c0                	test   %eax,%eax
80105c98:	0f 85 06 ff ff ff    	jne    80105ba4 <trap+0xb4>
80105c9e:	66 90                	xchg   %ax,%ax
80105ca0:	e9 1a ff ff ff       	jmp    80105bbf <trap+0xcf>
    uartintr();
80105ca5:	e8 96 02 00 00       	call   80105f40 <uartintr>
    lapiceoi();
80105caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cb0:	e8 2b cd ff ff       	call   801029e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105cb5:	e8 66 dd ff ff       	call   80103a20 <myproc>
80105cba:	85 c0                	test   %eax,%eax
80105cbc:	0f 85 e2 fe ff ff    	jne    80105ba4 <trap+0xb4>
80105cc2:	e9 f8 fe ff ff       	jmp    80105bbf <trap+0xcf>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105cc7:	8b 7b 38             	mov    0x38(%ebx),%edi
80105cca:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105cce:	e8 2d dd ff ff       	call   80103a00 <cpuid>
80105cd3:	c7 04 24 e8 7a 10 80 	movl   $0x80107ae8,(%esp)
80105cda:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105cde:	89 74 24 08          	mov    %esi,0x8(%esp)
80105ce2:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ce6:	e8 95 a9 ff ff       	call   80100680 <cprintf>
    lapiceoi();
80105ceb:	e8 f0 cc ff ff       	call   801029e0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105cf0:	e8 2b dd ff ff       	call   80103a20 <myproc>
80105cf5:	85 c0                	test   %eax,%eax
80105cf7:	0f 85 a7 fe ff ff    	jne    80105ba4 <trap+0xb4>
80105cfd:	8d 76 00             	lea    0x0(%esi),%esi
80105d00:	e9 ba fe ff ff       	jmp    80105bbf <trap+0xcf>
80105d05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105d10:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105d14:	0f 85 bd fe ff ff    	jne    80105bd7 <trap+0xe7>
    yield();
80105d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d20:	e8 5b e2 ff ff       	call   80103f80 <yield>
80105d25:	e9 ad fe ff ff       	jmp    80105bd7 <trap+0xe7>
80105d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
80105d30:	e8 eb dc ff ff       	call   80103a20 <myproc>
80105d35:	8b 70 24             	mov    0x24(%eax),%esi
80105d38:	85 f6                	test   %esi,%esi
80105d3a:	75 44                	jne    80105d80 <trap+0x290>
    myproc()->tf = tf;
80105d3c:	e8 df dc ff ff       	call   80103a20 <myproc>
80105d41:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105d44:	e8 d7 ee ff ff       	call   80104c20 <syscall>
    if(myproc()->killed)
80105d49:	e8 d2 dc ff ff       	call   80103a20 <myproc>
80105d4e:	8b 48 24             	mov    0x24(%eax),%ecx
80105d51:	85 c9                	test   %ecx,%ecx
80105d53:	0f 84 a4 fe ff ff    	je     80105bfd <trap+0x10d>
}
80105d59:	83 c4 3c             	add    $0x3c,%esp
80105d5c:	5b                   	pop    %ebx
80105d5d:	5e                   	pop    %esi
80105d5e:	5f                   	pop    %edi
80105d5f:	5d                   	pop    %ebp
      exit();
80105d60:	e9 db e0 ff ff       	jmp    80103e40 <exit>
80105d65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105d70:	e8 cb e0 ff ff       	call   80103e40 <exit>
80105d75:	e9 45 fe ff ff       	jmp    80105bbf <trap+0xcf>
80105d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105d80:	e8 bb e0 ff ff       	call   80103e40 <exit>
80105d85:	eb b5                	jmp    80105d3c <trap+0x24c>
          myproc() -> rtime += 1;
80105d87:	e8 94 dc ff ff       	call   80103a20 <myproc>
80105d8c:	ff 80 88 00 00 00    	incl   0x88(%eax)
80105d92:	e9 73 fe ff ff       	jmp    80105c0a <trap+0x11a>
80105d97:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d9a:	e8 61 dc ff ff       	call   80103a00 <cpuid>
80105d9f:	89 74 24 10          	mov    %esi,0x10(%esp)
80105da3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105da7:	89 44 24 08          	mov    %eax,0x8(%esp)
80105dab:	8b 43 30             	mov    0x30(%ebx),%eax
80105dae:	c7 04 24 0c 7b 10 80 	movl   $0x80107b0c,(%esp)
80105db5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105db9:	e8 c2 a8 ff ff       	call   80100680 <cprintf>
      panic("trap");
80105dbe:	c7 04 24 e2 7a 10 80 	movl   $0x80107ae2,(%esp)
80105dc5:	e8 96 a5 ff ff       	call   80100360 <panic>
80105dca:	66 90                	xchg   %ax,%ax
80105dcc:	66 90                	xchg   %ax,%ax
80105dce:	66 90                	xchg   %ax,%ax

80105dd0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105dd0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105dd5:	85 c0                	test   %eax,%eax
80105dd7:	74 17                	je     80105df0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105dd9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105dde:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105ddf:	24 01                	and    $0x1,%al
80105de1:	74 0d                	je     80105df0 <uartgetc+0x20>
80105de3:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105de8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105de9:	0f b6 c0             	movzbl %al,%eax
80105dec:	c3                   	ret    
80105ded:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105df5:	c3                   	ret    
80105df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dfd:	8d 76 00             	lea    0x0(%esi),%esi

80105e00 <uartputc.part.0>:
uartputc(int c)
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	56                   	push   %esi
80105e04:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e09:	53                   	push   %ebx
80105e0a:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e0f:	83 ec 20             	sub    $0x20,%esp
80105e12:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e15:	eb 18                	jmp    80105e2f <uartputc.part.0+0x2f>
80105e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e1e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105e20:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105e27:	e8 d4 cb ff ff       	call   80102a00 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e2c:	4b                   	dec    %ebx
80105e2d:	74 07                	je     80105e36 <uartputc.part.0+0x36>
80105e2f:	89 f2                	mov    %esi,%edx
80105e31:	ec                   	in     (%dx),%al
80105e32:	24 20                	and    $0x20,%al
80105e34:	74 ea                	je     80105e20 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e36:	0f b6 45 f4          	movzbl -0xc(%ebp),%eax
80105e3a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e3f:	ee                   	out    %al,(%dx)
}
80105e40:	83 c4 20             	add    $0x20,%esp
80105e43:	5b                   	pop    %ebx
80105e44:	5e                   	pop    %esi
80105e45:	5d                   	pop    %ebp
80105e46:	c3                   	ret    
80105e47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e4e:	66 90                	xchg   %ax,%ax

80105e50 <uartinit>:
{
80105e50:	55                   	push   %ebp
80105e51:	31 c9                	xor    %ecx,%ecx
80105e53:	89 e5                	mov    %esp,%ebp
80105e55:	88 c8                	mov    %cl,%al
80105e57:	57                   	push   %edi
80105e58:	56                   	push   %esi
80105e59:	53                   	push   %ebx
80105e5a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105e5f:	83 ec 2c             	sub    $0x2c,%esp
80105e62:	89 da                	mov    %ebx,%edx
80105e64:	ee                   	out    %al,(%dx)
80105e65:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105e6a:	b0 80                	mov    $0x80,%al
80105e6c:	89 fa                	mov    %edi,%edx
80105e6e:	ee                   	out    %al,(%dx)
80105e6f:	b0 0c                	mov    $0xc,%al
80105e71:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e76:	ee                   	out    %al,(%dx)
80105e77:	be f9 03 00 00       	mov    $0x3f9,%esi
80105e7c:	88 c8                	mov    %cl,%al
80105e7e:	89 f2                	mov    %esi,%edx
80105e80:	ee                   	out    %al,(%dx)
80105e81:	b0 03                	mov    $0x3,%al
80105e83:	89 fa                	mov    %edi,%edx
80105e85:	ee                   	out    %al,(%dx)
80105e86:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e8b:	88 c8                	mov    %cl,%al
80105e8d:	ee                   	out    %al,(%dx)
80105e8e:	b0 01                	mov    $0x1,%al
80105e90:	89 f2                	mov    %esi,%edx
80105e92:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e93:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e98:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105e99:	fe c0                	inc    %al
80105e9b:	74 65                	je     80105f02 <uartinit+0xb2>
  uart = 1;
80105e9d:	be 01 00 00 00       	mov    $0x1,%esi
80105ea2:	89 da                	mov    %ebx,%edx
80105ea4:	89 35 bc a5 10 80    	mov    %esi,0x8010a5bc
80105eaa:	ec                   	in     (%dx),%al
80105eab:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105eb0:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105eb1:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105eb8:	31 ff                	xor    %edi,%edi
  for(p="xv6...\n"; *p; p++)
80105eba:	bb 04 7c 10 80       	mov    $0x80107c04,%ebx
  ioapicenable(IRQ_COM1, 0);
80105ebf:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105ec3:	e8 78 c6 ff ff       	call   80102540 <ioapicenable>
80105ec8:	b2 76                	mov    $0x76,%dl
  for(p="xv6...\n"; *p; p++)
80105eca:	b8 78 00 00 00       	mov    $0x78,%eax
80105ecf:	eb 16                	jmp    80105ee7 <uartinit+0x97>
80105ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ed8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105edf:	90                   	nop
80105ee0:	0f be c2             	movsbl %dl,%eax
80105ee3:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
  if(!uart)
80105ee7:	8b 0d bc a5 10 80    	mov    0x8010a5bc,%ecx
80105eed:	85 c9                	test   %ecx,%ecx
80105eef:	74 0c                	je     80105efd <uartinit+0xad>
80105ef1:	88 55 e7             	mov    %dl,-0x19(%ebp)
80105ef4:	e8 07 ff ff ff       	call   80105e00 <uartputc.part.0>
80105ef9:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
  for(p="xv6...\n"; *p; p++)
80105efd:	43                   	inc    %ebx
80105efe:	84 d2                	test   %dl,%dl
80105f00:	75 de                	jne    80105ee0 <uartinit+0x90>
}
80105f02:	83 c4 2c             	add    $0x2c,%esp
80105f05:	5b                   	pop    %ebx
80105f06:	5e                   	pop    %esi
80105f07:	5f                   	pop    %edi
80105f08:	5d                   	pop    %ebp
80105f09:	c3                   	ret    
80105f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f10 <uartputc>:
{
80105f10:	55                   	push   %ebp
  if(!uart)
80105f11:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105f17:	89 e5                	mov    %esp,%ebp
80105f19:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105f1c:	85 d2                	test   %edx,%edx
80105f1e:	74 10                	je     80105f30 <uartputc+0x20>
}
80105f20:	5d                   	pop    %ebp
80105f21:	e9 da fe ff ff       	jmp    80105e00 <uartputc.part.0>
80105f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f2d:	8d 76 00             	lea    0x0(%esi),%esi
80105f30:	5d                   	pop    %ebp
80105f31:	c3                   	ret    
80105f32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f40 <uartintr>:

void
uartintr(void)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105f46:	c7 04 24 d0 5d 10 80 	movl   $0x80105dd0,(%esp)
80105f4d:	e8 de a8 ff ff       	call   80100830 <consoleintr>
}
80105f52:	c9                   	leave  
80105f53:	c3                   	ret    

80105f54 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105f54:	6a 00                	push   $0x0
  pushl $0
80105f56:	6a 00                	push   $0x0
  jmp alltraps
80105f58:	e9 c0 fa ff ff       	jmp    80105a1d <alltraps>

80105f5d <vector1>:
.globl vector1
vector1:
  pushl $0
80105f5d:	6a 00                	push   $0x0
  pushl $1
80105f5f:	6a 01                	push   $0x1
  jmp alltraps
80105f61:	e9 b7 fa ff ff       	jmp    80105a1d <alltraps>

80105f66 <vector2>:
.globl vector2
vector2:
  pushl $0
80105f66:	6a 00                	push   $0x0
  pushl $2
80105f68:	6a 02                	push   $0x2
  jmp alltraps
80105f6a:	e9 ae fa ff ff       	jmp    80105a1d <alltraps>

80105f6f <vector3>:
.globl vector3
vector3:
  pushl $0
80105f6f:	6a 00                	push   $0x0
  pushl $3
80105f71:	6a 03                	push   $0x3
  jmp alltraps
80105f73:	e9 a5 fa ff ff       	jmp    80105a1d <alltraps>

80105f78 <vector4>:
.globl vector4
vector4:
  pushl $0
80105f78:	6a 00                	push   $0x0
  pushl $4
80105f7a:	6a 04                	push   $0x4
  jmp alltraps
80105f7c:	e9 9c fa ff ff       	jmp    80105a1d <alltraps>

80105f81 <vector5>:
.globl vector5
vector5:
  pushl $0
80105f81:	6a 00                	push   $0x0
  pushl $5
80105f83:	6a 05                	push   $0x5
  jmp alltraps
80105f85:	e9 93 fa ff ff       	jmp    80105a1d <alltraps>

80105f8a <vector6>:
.globl vector6
vector6:
  pushl $0
80105f8a:	6a 00                	push   $0x0
  pushl $6
80105f8c:	6a 06                	push   $0x6
  jmp alltraps
80105f8e:	e9 8a fa ff ff       	jmp    80105a1d <alltraps>

80105f93 <vector7>:
.globl vector7
vector7:
  pushl $0
80105f93:	6a 00                	push   $0x0
  pushl $7
80105f95:	6a 07                	push   $0x7
  jmp alltraps
80105f97:	e9 81 fa ff ff       	jmp    80105a1d <alltraps>

80105f9c <vector8>:
.globl vector8
vector8:
  pushl $8
80105f9c:	6a 08                	push   $0x8
  jmp alltraps
80105f9e:	e9 7a fa ff ff       	jmp    80105a1d <alltraps>

80105fa3 <vector9>:
.globl vector9
vector9:
  pushl $0
80105fa3:	6a 00                	push   $0x0
  pushl $9
80105fa5:	6a 09                	push   $0x9
  jmp alltraps
80105fa7:	e9 71 fa ff ff       	jmp    80105a1d <alltraps>

80105fac <vector10>:
.globl vector10
vector10:
  pushl $10
80105fac:	6a 0a                	push   $0xa
  jmp alltraps
80105fae:	e9 6a fa ff ff       	jmp    80105a1d <alltraps>

80105fb3 <vector11>:
.globl vector11
vector11:
  pushl $11
80105fb3:	6a 0b                	push   $0xb
  jmp alltraps
80105fb5:	e9 63 fa ff ff       	jmp    80105a1d <alltraps>

80105fba <vector12>:
.globl vector12
vector12:
  pushl $12
80105fba:	6a 0c                	push   $0xc
  jmp alltraps
80105fbc:	e9 5c fa ff ff       	jmp    80105a1d <alltraps>

80105fc1 <vector13>:
.globl vector13
vector13:
  pushl $13
80105fc1:	6a 0d                	push   $0xd
  jmp alltraps
80105fc3:	e9 55 fa ff ff       	jmp    80105a1d <alltraps>

80105fc8 <vector14>:
.globl vector14
vector14:
  pushl $14
80105fc8:	6a 0e                	push   $0xe
  jmp alltraps
80105fca:	e9 4e fa ff ff       	jmp    80105a1d <alltraps>

80105fcf <vector15>:
.globl vector15
vector15:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $15
80105fd1:	6a 0f                	push   $0xf
  jmp alltraps
80105fd3:	e9 45 fa ff ff       	jmp    80105a1d <alltraps>

80105fd8 <vector16>:
.globl vector16
vector16:
  pushl $0
80105fd8:	6a 00                	push   $0x0
  pushl $16
80105fda:	6a 10                	push   $0x10
  jmp alltraps
80105fdc:	e9 3c fa ff ff       	jmp    80105a1d <alltraps>

80105fe1 <vector17>:
.globl vector17
vector17:
  pushl $17
80105fe1:	6a 11                	push   $0x11
  jmp alltraps
80105fe3:	e9 35 fa ff ff       	jmp    80105a1d <alltraps>

80105fe8 <vector18>:
.globl vector18
vector18:
  pushl $0
80105fe8:	6a 00                	push   $0x0
  pushl $18
80105fea:	6a 12                	push   $0x12
  jmp alltraps
80105fec:	e9 2c fa ff ff       	jmp    80105a1d <alltraps>

80105ff1 <vector19>:
.globl vector19
vector19:
  pushl $0
80105ff1:	6a 00                	push   $0x0
  pushl $19
80105ff3:	6a 13                	push   $0x13
  jmp alltraps
80105ff5:	e9 23 fa ff ff       	jmp    80105a1d <alltraps>

80105ffa <vector20>:
.globl vector20
vector20:
  pushl $0
80105ffa:	6a 00                	push   $0x0
  pushl $20
80105ffc:	6a 14                	push   $0x14
  jmp alltraps
80105ffe:	e9 1a fa ff ff       	jmp    80105a1d <alltraps>

80106003 <vector21>:
.globl vector21
vector21:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $21
80106005:	6a 15                	push   $0x15
  jmp alltraps
80106007:	e9 11 fa ff ff       	jmp    80105a1d <alltraps>

8010600c <vector22>:
.globl vector22
vector22:
  pushl $0
8010600c:	6a 00                	push   $0x0
  pushl $22
8010600e:	6a 16                	push   $0x16
  jmp alltraps
80106010:	e9 08 fa ff ff       	jmp    80105a1d <alltraps>

80106015 <vector23>:
.globl vector23
vector23:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $23
80106017:	6a 17                	push   $0x17
  jmp alltraps
80106019:	e9 ff f9 ff ff       	jmp    80105a1d <alltraps>

8010601e <vector24>:
.globl vector24
vector24:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $24
80106020:	6a 18                	push   $0x18
  jmp alltraps
80106022:	e9 f6 f9 ff ff       	jmp    80105a1d <alltraps>

80106027 <vector25>:
.globl vector25
vector25:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $25
80106029:	6a 19                	push   $0x19
  jmp alltraps
8010602b:	e9 ed f9 ff ff       	jmp    80105a1d <alltraps>

80106030 <vector26>:
.globl vector26
vector26:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $26
80106032:	6a 1a                	push   $0x1a
  jmp alltraps
80106034:	e9 e4 f9 ff ff       	jmp    80105a1d <alltraps>

80106039 <vector27>:
.globl vector27
vector27:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $27
8010603b:	6a 1b                	push   $0x1b
  jmp alltraps
8010603d:	e9 db f9 ff ff       	jmp    80105a1d <alltraps>

80106042 <vector28>:
.globl vector28
vector28:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $28
80106044:	6a 1c                	push   $0x1c
  jmp alltraps
80106046:	e9 d2 f9 ff ff       	jmp    80105a1d <alltraps>

8010604b <vector29>:
.globl vector29
vector29:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $29
8010604d:	6a 1d                	push   $0x1d
  jmp alltraps
8010604f:	e9 c9 f9 ff ff       	jmp    80105a1d <alltraps>

80106054 <vector30>:
.globl vector30
vector30:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $30
80106056:	6a 1e                	push   $0x1e
  jmp alltraps
80106058:	e9 c0 f9 ff ff       	jmp    80105a1d <alltraps>

8010605d <vector31>:
.globl vector31
vector31:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $31
8010605f:	6a 1f                	push   $0x1f
  jmp alltraps
80106061:	e9 b7 f9 ff ff       	jmp    80105a1d <alltraps>

80106066 <vector32>:
.globl vector32
vector32:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $32
80106068:	6a 20                	push   $0x20
  jmp alltraps
8010606a:	e9 ae f9 ff ff       	jmp    80105a1d <alltraps>

8010606f <vector33>:
.globl vector33
vector33:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $33
80106071:	6a 21                	push   $0x21
  jmp alltraps
80106073:	e9 a5 f9 ff ff       	jmp    80105a1d <alltraps>

80106078 <vector34>:
.globl vector34
vector34:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $34
8010607a:	6a 22                	push   $0x22
  jmp alltraps
8010607c:	e9 9c f9 ff ff       	jmp    80105a1d <alltraps>

80106081 <vector35>:
.globl vector35
vector35:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $35
80106083:	6a 23                	push   $0x23
  jmp alltraps
80106085:	e9 93 f9 ff ff       	jmp    80105a1d <alltraps>

8010608a <vector36>:
.globl vector36
vector36:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $36
8010608c:	6a 24                	push   $0x24
  jmp alltraps
8010608e:	e9 8a f9 ff ff       	jmp    80105a1d <alltraps>

80106093 <vector37>:
.globl vector37
vector37:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $37
80106095:	6a 25                	push   $0x25
  jmp alltraps
80106097:	e9 81 f9 ff ff       	jmp    80105a1d <alltraps>

8010609c <vector38>:
.globl vector38
vector38:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $38
8010609e:	6a 26                	push   $0x26
  jmp alltraps
801060a0:	e9 78 f9 ff ff       	jmp    80105a1d <alltraps>

801060a5 <vector39>:
.globl vector39
vector39:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $39
801060a7:	6a 27                	push   $0x27
  jmp alltraps
801060a9:	e9 6f f9 ff ff       	jmp    80105a1d <alltraps>

801060ae <vector40>:
.globl vector40
vector40:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $40
801060b0:	6a 28                	push   $0x28
  jmp alltraps
801060b2:	e9 66 f9 ff ff       	jmp    80105a1d <alltraps>

801060b7 <vector41>:
.globl vector41
vector41:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $41
801060b9:	6a 29                	push   $0x29
  jmp alltraps
801060bb:	e9 5d f9 ff ff       	jmp    80105a1d <alltraps>

801060c0 <vector42>:
.globl vector42
vector42:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $42
801060c2:	6a 2a                	push   $0x2a
  jmp alltraps
801060c4:	e9 54 f9 ff ff       	jmp    80105a1d <alltraps>

801060c9 <vector43>:
.globl vector43
vector43:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $43
801060cb:	6a 2b                	push   $0x2b
  jmp alltraps
801060cd:	e9 4b f9 ff ff       	jmp    80105a1d <alltraps>

801060d2 <vector44>:
.globl vector44
vector44:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $44
801060d4:	6a 2c                	push   $0x2c
  jmp alltraps
801060d6:	e9 42 f9 ff ff       	jmp    80105a1d <alltraps>

801060db <vector45>:
.globl vector45
vector45:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $45
801060dd:	6a 2d                	push   $0x2d
  jmp alltraps
801060df:	e9 39 f9 ff ff       	jmp    80105a1d <alltraps>

801060e4 <vector46>:
.globl vector46
vector46:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $46
801060e6:	6a 2e                	push   $0x2e
  jmp alltraps
801060e8:	e9 30 f9 ff ff       	jmp    80105a1d <alltraps>

801060ed <vector47>:
.globl vector47
vector47:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $47
801060ef:	6a 2f                	push   $0x2f
  jmp alltraps
801060f1:	e9 27 f9 ff ff       	jmp    80105a1d <alltraps>

801060f6 <vector48>:
.globl vector48
vector48:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $48
801060f8:	6a 30                	push   $0x30
  jmp alltraps
801060fa:	e9 1e f9 ff ff       	jmp    80105a1d <alltraps>

801060ff <vector49>:
.globl vector49
vector49:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $49
80106101:	6a 31                	push   $0x31
  jmp alltraps
80106103:	e9 15 f9 ff ff       	jmp    80105a1d <alltraps>

80106108 <vector50>:
.globl vector50
vector50:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $50
8010610a:	6a 32                	push   $0x32
  jmp alltraps
8010610c:	e9 0c f9 ff ff       	jmp    80105a1d <alltraps>

80106111 <vector51>:
.globl vector51
vector51:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $51
80106113:	6a 33                	push   $0x33
  jmp alltraps
80106115:	e9 03 f9 ff ff       	jmp    80105a1d <alltraps>

8010611a <vector52>:
.globl vector52
vector52:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $52
8010611c:	6a 34                	push   $0x34
  jmp alltraps
8010611e:	e9 fa f8 ff ff       	jmp    80105a1d <alltraps>

80106123 <vector53>:
.globl vector53
vector53:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $53
80106125:	6a 35                	push   $0x35
  jmp alltraps
80106127:	e9 f1 f8 ff ff       	jmp    80105a1d <alltraps>

8010612c <vector54>:
.globl vector54
vector54:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $54
8010612e:	6a 36                	push   $0x36
  jmp alltraps
80106130:	e9 e8 f8 ff ff       	jmp    80105a1d <alltraps>

80106135 <vector55>:
.globl vector55
vector55:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $55
80106137:	6a 37                	push   $0x37
  jmp alltraps
80106139:	e9 df f8 ff ff       	jmp    80105a1d <alltraps>

8010613e <vector56>:
.globl vector56
vector56:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $56
80106140:	6a 38                	push   $0x38
  jmp alltraps
80106142:	e9 d6 f8 ff ff       	jmp    80105a1d <alltraps>

80106147 <vector57>:
.globl vector57
vector57:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $57
80106149:	6a 39                	push   $0x39
  jmp alltraps
8010614b:	e9 cd f8 ff ff       	jmp    80105a1d <alltraps>

80106150 <vector58>:
.globl vector58
vector58:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $58
80106152:	6a 3a                	push   $0x3a
  jmp alltraps
80106154:	e9 c4 f8 ff ff       	jmp    80105a1d <alltraps>

80106159 <vector59>:
.globl vector59
vector59:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $59
8010615b:	6a 3b                	push   $0x3b
  jmp alltraps
8010615d:	e9 bb f8 ff ff       	jmp    80105a1d <alltraps>

80106162 <vector60>:
.globl vector60
vector60:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $60
80106164:	6a 3c                	push   $0x3c
  jmp alltraps
80106166:	e9 b2 f8 ff ff       	jmp    80105a1d <alltraps>

8010616b <vector61>:
.globl vector61
vector61:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $61
8010616d:	6a 3d                	push   $0x3d
  jmp alltraps
8010616f:	e9 a9 f8 ff ff       	jmp    80105a1d <alltraps>

80106174 <vector62>:
.globl vector62
vector62:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $62
80106176:	6a 3e                	push   $0x3e
  jmp alltraps
80106178:	e9 a0 f8 ff ff       	jmp    80105a1d <alltraps>

8010617d <vector63>:
.globl vector63
vector63:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $63
8010617f:	6a 3f                	push   $0x3f
  jmp alltraps
80106181:	e9 97 f8 ff ff       	jmp    80105a1d <alltraps>

80106186 <vector64>:
.globl vector64
vector64:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $64
80106188:	6a 40                	push   $0x40
  jmp alltraps
8010618a:	e9 8e f8 ff ff       	jmp    80105a1d <alltraps>

8010618f <vector65>:
.globl vector65
vector65:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $65
80106191:	6a 41                	push   $0x41
  jmp alltraps
80106193:	e9 85 f8 ff ff       	jmp    80105a1d <alltraps>

80106198 <vector66>:
.globl vector66
vector66:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $66
8010619a:	6a 42                	push   $0x42
  jmp alltraps
8010619c:	e9 7c f8 ff ff       	jmp    80105a1d <alltraps>

801061a1 <vector67>:
.globl vector67
vector67:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $67
801061a3:	6a 43                	push   $0x43
  jmp alltraps
801061a5:	e9 73 f8 ff ff       	jmp    80105a1d <alltraps>

801061aa <vector68>:
.globl vector68
vector68:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $68
801061ac:	6a 44                	push   $0x44
  jmp alltraps
801061ae:	e9 6a f8 ff ff       	jmp    80105a1d <alltraps>

801061b3 <vector69>:
.globl vector69
vector69:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $69
801061b5:	6a 45                	push   $0x45
  jmp alltraps
801061b7:	e9 61 f8 ff ff       	jmp    80105a1d <alltraps>

801061bc <vector70>:
.globl vector70
vector70:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $70
801061be:	6a 46                	push   $0x46
  jmp alltraps
801061c0:	e9 58 f8 ff ff       	jmp    80105a1d <alltraps>

801061c5 <vector71>:
.globl vector71
vector71:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $71
801061c7:	6a 47                	push   $0x47
  jmp alltraps
801061c9:	e9 4f f8 ff ff       	jmp    80105a1d <alltraps>

801061ce <vector72>:
.globl vector72
vector72:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $72
801061d0:	6a 48                	push   $0x48
  jmp alltraps
801061d2:	e9 46 f8 ff ff       	jmp    80105a1d <alltraps>

801061d7 <vector73>:
.globl vector73
vector73:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $73
801061d9:	6a 49                	push   $0x49
  jmp alltraps
801061db:	e9 3d f8 ff ff       	jmp    80105a1d <alltraps>

801061e0 <vector74>:
.globl vector74
vector74:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $74
801061e2:	6a 4a                	push   $0x4a
  jmp alltraps
801061e4:	e9 34 f8 ff ff       	jmp    80105a1d <alltraps>

801061e9 <vector75>:
.globl vector75
vector75:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $75
801061eb:	6a 4b                	push   $0x4b
  jmp alltraps
801061ed:	e9 2b f8 ff ff       	jmp    80105a1d <alltraps>

801061f2 <vector76>:
.globl vector76
vector76:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $76
801061f4:	6a 4c                	push   $0x4c
  jmp alltraps
801061f6:	e9 22 f8 ff ff       	jmp    80105a1d <alltraps>

801061fb <vector77>:
.globl vector77
vector77:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $77
801061fd:	6a 4d                	push   $0x4d
  jmp alltraps
801061ff:	e9 19 f8 ff ff       	jmp    80105a1d <alltraps>

80106204 <vector78>:
.globl vector78
vector78:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $78
80106206:	6a 4e                	push   $0x4e
  jmp alltraps
80106208:	e9 10 f8 ff ff       	jmp    80105a1d <alltraps>

8010620d <vector79>:
.globl vector79
vector79:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $79
8010620f:	6a 4f                	push   $0x4f
  jmp alltraps
80106211:	e9 07 f8 ff ff       	jmp    80105a1d <alltraps>

80106216 <vector80>:
.globl vector80
vector80:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $80
80106218:	6a 50                	push   $0x50
  jmp alltraps
8010621a:	e9 fe f7 ff ff       	jmp    80105a1d <alltraps>

8010621f <vector81>:
.globl vector81
vector81:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $81
80106221:	6a 51                	push   $0x51
  jmp alltraps
80106223:	e9 f5 f7 ff ff       	jmp    80105a1d <alltraps>

80106228 <vector82>:
.globl vector82
vector82:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $82
8010622a:	6a 52                	push   $0x52
  jmp alltraps
8010622c:	e9 ec f7 ff ff       	jmp    80105a1d <alltraps>

80106231 <vector83>:
.globl vector83
vector83:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $83
80106233:	6a 53                	push   $0x53
  jmp alltraps
80106235:	e9 e3 f7 ff ff       	jmp    80105a1d <alltraps>

8010623a <vector84>:
.globl vector84
vector84:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $84
8010623c:	6a 54                	push   $0x54
  jmp alltraps
8010623e:	e9 da f7 ff ff       	jmp    80105a1d <alltraps>

80106243 <vector85>:
.globl vector85
vector85:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $85
80106245:	6a 55                	push   $0x55
  jmp alltraps
80106247:	e9 d1 f7 ff ff       	jmp    80105a1d <alltraps>

8010624c <vector86>:
.globl vector86
vector86:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $86
8010624e:	6a 56                	push   $0x56
  jmp alltraps
80106250:	e9 c8 f7 ff ff       	jmp    80105a1d <alltraps>

80106255 <vector87>:
.globl vector87
vector87:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $87
80106257:	6a 57                	push   $0x57
  jmp alltraps
80106259:	e9 bf f7 ff ff       	jmp    80105a1d <alltraps>

8010625e <vector88>:
.globl vector88
vector88:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $88
80106260:	6a 58                	push   $0x58
  jmp alltraps
80106262:	e9 b6 f7 ff ff       	jmp    80105a1d <alltraps>

80106267 <vector89>:
.globl vector89
vector89:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $89
80106269:	6a 59                	push   $0x59
  jmp alltraps
8010626b:	e9 ad f7 ff ff       	jmp    80105a1d <alltraps>

80106270 <vector90>:
.globl vector90
vector90:
  pushl $0
80106270:	6a 00                	push   $0x0
  pushl $90
80106272:	6a 5a                	push   $0x5a
  jmp alltraps
80106274:	e9 a4 f7 ff ff       	jmp    80105a1d <alltraps>

80106279 <vector91>:
.globl vector91
vector91:
  pushl $0
80106279:	6a 00                	push   $0x0
  pushl $91
8010627b:	6a 5b                	push   $0x5b
  jmp alltraps
8010627d:	e9 9b f7 ff ff       	jmp    80105a1d <alltraps>

80106282 <vector92>:
.globl vector92
vector92:
  pushl $0
80106282:	6a 00                	push   $0x0
  pushl $92
80106284:	6a 5c                	push   $0x5c
  jmp alltraps
80106286:	e9 92 f7 ff ff       	jmp    80105a1d <alltraps>

8010628b <vector93>:
.globl vector93
vector93:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $93
8010628d:	6a 5d                	push   $0x5d
  jmp alltraps
8010628f:	e9 89 f7 ff ff       	jmp    80105a1d <alltraps>

80106294 <vector94>:
.globl vector94
vector94:
  pushl $0
80106294:	6a 00                	push   $0x0
  pushl $94
80106296:	6a 5e                	push   $0x5e
  jmp alltraps
80106298:	e9 80 f7 ff ff       	jmp    80105a1d <alltraps>

8010629d <vector95>:
.globl vector95
vector95:
  pushl $0
8010629d:	6a 00                	push   $0x0
  pushl $95
8010629f:	6a 5f                	push   $0x5f
  jmp alltraps
801062a1:	e9 77 f7 ff ff       	jmp    80105a1d <alltraps>

801062a6 <vector96>:
.globl vector96
vector96:
  pushl $0
801062a6:	6a 00                	push   $0x0
  pushl $96
801062a8:	6a 60                	push   $0x60
  jmp alltraps
801062aa:	e9 6e f7 ff ff       	jmp    80105a1d <alltraps>

801062af <vector97>:
.globl vector97
vector97:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $97
801062b1:	6a 61                	push   $0x61
  jmp alltraps
801062b3:	e9 65 f7 ff ff       	jmp    80105a1d <alltraps>

801062b8 <vector98>:
.globl vector98
vector98:
  pushl $0
801062b8:	6a 00                	push   $0x0
  pushl $98
801062ba:	6a 62                	push   $0x62
  jmp alltraps
801062bc:	e9 5c f7 ff ff       	jmp    80105a1d <alltraps>

801062c1 <vector99>:
.globl vector99
vector99:
  pushl $0
801062c1:	6a 00                	push   $0x0
  pushl $99
801062c3:	6a 63                	push   $0x63
  jmp alltraps
801062c5:	e9 53 f7 ff ff       	jmp    80105a1d <alltraps>

801062ca <vector100>:
.globl vector100
vector100:
  pushl $0
801062ca:	6a 00                	push   $0x0
  pushl $100
801062cc:	6a 64                	push   $0x64
  jmp alltraps
801062ce:	e9 4a f7 ff ff       	jmp    80105a1d <alltraps>

801062d3 <vector101>:
.globl vector101
vector101:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $101
801062d5:	6a 65                	push   $0x65
  jmp alltraps
801062d7:	e9 41 f7 ff ff       	jmp    80105a1d <alltraps>

801062dc <vector102>:
.globl vector102
vector102:
  pushl $0
801062dc:	6a 00                	push   $0x0
  pushl $102
801062de:	6a 66                	push   $0x66
  jmp alltraps
801062e0:	e9 38 f7 ff ff       	jmp    80105a1d <alltraps>

801062e5 <vector103>:
.globl vector103
vector103:
  pushl $0
801062e5:	6a 00                	push   $0x0
  pushl $103
801062e7:	6a 67                	push   $0x67
  jmp alltraps
801062e9:	e9 2f f7 ff ff       	jmp    80105a1d <alltraps>

801062ee <vector104>:
.globl vector104
vector104:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $104
801062f0:	6a 68                	push   $0x68
  jmp alltraps
801062f2:	e9 26 f7 ff ff       	jmp    80105a1d <alltraps>

801062f7 <vector105>:
.globl vector105
vector105:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $105
801062f9:	6a 69                	push   $0x69
  jmp alltraps
801062fb:	e9 1d f7 ff ff       	jmp    80105a1d <alltraps>

80106300 <vector106>:
.globl vector106
vector106:
  pushl $0
80106300:	6a 00                	push   $0x0
  pushl $106
80106302:	6a 6a                	push   $0x6a
  jmp alltraps
80106304:	e9 14 f7 ff ff       	jmp    80105a1d <alltraps>

80106309 <vector107>:
.globl vector107
vector107:
  pushl $0
80106309:	6a 00                	push   $0x0
  pushl $107
8010630b:	6a 6b                	push   $0x6b
  jmp alltraps
8010630d:	e9 0b f7 ff ff       	jmp    80105a1d <alltraps>

80106312 <vector108>:
.globl vector108
vector108:
  pushl $0
80106312:	6a 00                	push   $0x0
  pushl $108
80106314:	6a 6c                	push   $0x6c
  jmp alltraps
80106316:	e9 02 f7 ff ff       	jmp    80105a1d <alltraps>

8010631b <vector109>:
.globl vector109
vector109:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $109
8010631d:	6a 6d                	push   $0x6d
  jmp alltraps
8010631f:	e9 f9 f6 ff ff       	jmp    80105a1d <alltraps>

80106324 <vector110>:
.globl vector110
vector110:
  pushl $0
80106324:	6a 00                	push   $0x0
  pushl $110
80106326:	6a 6e                	push   $0x6e
  jmp alltraps
80106328:	e9 f0 f6 ff ff       	jmp    80105a1d <alltraps>

8010632d <vector111>:
.globl vector111
vector111:
  pushl $0
8010632d:	6a 00                	push   $0x0
  pushl $111
8010632f:	6a 6f                	push   $0x6f
  jmp alltraps
80106331:	e9 e7 f6 ff ff       	jmp    80105a1d <alltraps>

80106336 <vector112>:
.globl vector112
vector112:
  pushl $0
80106336:	6a 00                	push   $0x0
  pushl $112
80106338:	6a 70                	push   $0x70
  jmp alltraps
8010633a:	e9 de f6 ff ff       	jmp    80105a1d <alltraps>

8010633f <vector113>:
.globl vector113
vector113:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $113
80106341:	6a 71                	push   $0x71
  jmp alltraps
80106343:	e9 d5 f6 ff ff       	jmp    80105a1d <alltraps>

80106348 <vector114>:
.globl vector114
vector114:
  pushl $0
80106348:	6a 00                	push   $0x0
  pushl $114
8010634a:	6a 72                	push   $0x72
  jmp alltraps
8010634c:	e9 cc f6 ff ff       	jmp    80105a1d <alltraps>

80106351 <vector115>:
.globl vector115
vector115:
  pushl $0
80106351:	6a 00                	push   $0x0
  pushl $115
80106353:	6a 73                	push   $0x73
  jmp alltraps
80106355:	e9 c3 f6 ff ff       	jmp    80105a1d <alltraps>

8010635a <vector116>:
.globl vector116
vector116:
  pushl $0
8010635a:	6a 00                	push   $0x0
  pushl $116
8010635c:	6a 74                	push   $0x74
  jmp alltraps
8010635e:	e9 ba f6 ff ff       	jmp    80105a1d <alltraps>

80106363 <vector117>:
.globl vector117
vector117:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $117
80106365:	6a 75                	push   $0x75
  jmp alltraps
80106367:	e9 b1 f6 ff ff       	jmp    80105a1d <alltraps>

8010636c <vector118>:
.globl vector118
vector118:
  pushl $0
8010636c:	6a 00                	push   $0x0
  pushl $118
8010636e:	6a 76                	push   $0x76
  jmp alltraps
80106370:	e9 a8 f6 ff ff       	jmp    80105a1d <alltraps>

80106375 <vector119>:
.globl vector119
vector119:
  pushl $0
80106375:	6a 00                	push   $0x0
  pushl $119
80106377:	6a 77                	push   $0x77
  jmp alltraps
80106379:	e9 9f f6 ff ff       	jmp    80105a1d <alltraps>

8010637e <vector120>:
.globl vector120
vector120:
  pushl $0
8010637e:	6a 00                	push   $0x0
  pushl $120
80106380:	6a 78                	push   $0x78
  jmp alltraps
80106382:	e9 96 f6 ff ff       	jmp    80105a1d <alltraps>

80106387 <vector121>:
.globl vector121
vector121:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $121
80106389:	6a 79                	push   $0x79
  jmp alltraps
8010638b:	e9 8d f6 ff ff       	jmp    80105a1d <alltraps>

80106390 <vector122>:
.globl vector122
vector122:
  pushl $0
80106390:	6a 00                	push   $0x0
  pushl $122
80106392:	6a 7a                	push   $0x7a
  jmp alltraps
80106394:	e9 84 f6 ff ff       	jmp    80105a1d <alltraps>

80106399 <vector123>:
.globl vector123
vector123:
  pushl $0
80106399:	6a 00                	push   $0x0
  pushl $123
8010639b:	6a 7b                	push   $0x7b
  jmp alltraps
8010639d:	e9 7b f6 ff ff       	jmp    80105a1d <alltraps>

801063a2 <vector124>:
.globl vector124
vector124:
  pushl $0
801063a2:	6a 00                	push   $0x0
  pushl $124
801063a4:	6a 7c                	push   $0x7c
  jmp alltraps
801063a6:	e9 72 f6 ff ff       	jmp    80105a1d <alltraps>

801063ab <vector125>:
.globl vector125
vector125:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $125
801063ad:	6a 7d                	push   $0x7d
  jmp alltraps
801063af:	e9 69 f6 ff ff       	jmp    80105a1d <alltraps>

801063b4 <vector126>:
.globl vector126
vector126:
  pushl $0
801063b4:	6a 00                	push   $0x0
  pushl $126
801063b6:	6a 7e                	push   $0x7e
  jmp alltraps
801063b8:	e9 60 f6 ff ff       	jmp    80105a1d <alltraps>

801063bd <vector127>:
.globl vector127
vector127:
  pushl $0
801063bd:	6a 00                	push   $0x0
  pushl $127
801063bf:	6a 7f                	push   $0x7f
  jmp alltraps
801063c1:	e9 57 f6 ff ff       	jmp    80105a1d <alltraps>

801063c6 <vector128>:
.globl vector128
vector128:
  pushl $0
801063c6:	6a 00                	push   $0x0
  pushl $128
801063c8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801063cd:	e9 4b f6 ff ff       	jmp    80105a1d <alltraps>

801063d2 <vector129>:
.globl vector129
vector129:
  pushl $0
801063d2:	6a 00                	push   $0x0
  pushl $129
801063d4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801063d9:	e9 3f f6 ff ff       	jmp    80105a1d <alltraps>

801063de <vector130>:
.globl vector130
vector130:
  pushl $0
801063de:	6a 00                	push   $0x0
  pushl $130
801063e0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801063e5:	e9 33 f6 ff ff       	jmp    80105a1d <alltraps>

801063ea <vector131>:
.globl vector131
vector131:
  pushl $0
801063ea:	6a 00                	push   $0x0
  pushl $131
801063ec:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801063f1:	e9 27 f6 ff ff       	jmp    80105a1d <alltraps>

801063f6 <vector132>:
.globl vector132
vector132:
  pushl $0
801063f6:	6a 00                	push   $0x0
  pushl $132
801063f8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801063fd:	e9 1b f6 ff ff       	jmp    80105a1d <alltraps>

80106402 <vector133>:
.globl vector133
vector133:
  pushl $0
80106402:	6a 00                	push   $0x0
  pushl $133
80106404:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106409:	e9 0f f6 ff ff       	jmp    80105a1d <alltraps>

8010640e <vector134>:
.globl vector134
vector134:
  pushl $0
8010640e:	6a 00                	push   $0x0
  pushl $134
80106410:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106415:	e9 03 f6 ff ff       	jmp    80105a1d <alltraps>

8010641a <vector135>:
.globl vector135
vector135:
  pushl $0
8010641a:	6a 00                	push   $0x0
  pushl $135
8010641c:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106421:	e9 f7 f5 ff ff       	jmp    80105a1d <alltraps>

80106426 <vector136>:
.globl vector136
vector136:
  pushl $0
80106426:	6a 00                	push   $0x0
  pushl $136
80106428:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010642d:	e9 eb f5 ff ff       	jmp    80105a1d <alltraps>

80106432 <vector137>:
.globl vector137
vector137:
  pushl $0
80106432:	6a 00                	push   $0x0
  pushl $137
80106434:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106439:	e9 df f5 ff ff       	jmp    80105a1d <alltraps>

8010643e <vector138>:
.globl vector138
vector138:
  pushl $0
8010643e:	6a 00                	push   $0x0
  pushl $138
80106440:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106445:	e9 d3 f5 ff ff       	jmp    80105a1d <alltraps>

8010644a <vector139>:
.globl vector139
vector139:
  pushl $0
8010644a:	6a 00                	push   $0x0
  pushl $139
8010644c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106451:	e9 c7 f5 ff ff       	jmp    80105a1d <alltraps>

80106456 <vector140>:
.globl vector140
vector140:
  pushl $0
80106456:	6a 00                	push   $0x0
  pushl $140
80106458:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010645d:	e9 bb f5 ff ff       	jmp    80105a1d <alltraps>

80106462 <vector141>:
.globl vector141
vector141:
  pushl $0
80106462:	6a 00                	push   $0x0
  pushl $141
80106464:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106469:	e9 af f5 ff ff       	jmp    80105a1d <alltraps>

8010646e <vector142>:
.globl vector142
vector142:
  pushl $0
8010646e:	6a 00                	push   $0x0
  pushl $142
80106470:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106475:	e9 a3 f5 ff ff       	jmp    80105a1d <alltraps>

8010647a <vector143>:
.globl vector143
vector143:
  pushl $0
8010647a:	6a 00                	push   $0x0
  pushl $143
8010647c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106481:	e9 97 f5 ff ff       	jmp    80105a1d <alltraps>

80106486 <vector144>:
.globl vector144
vector144:
  pushl $0
80106486:	6a 00                	push   $0x0
  pushl $144
80106488:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010648d:	e9 8b f5 ff ff       	jmp    80105a1d <alltraps>

80106492 <vector145>:
.globl vector145
vector145:
  pushl $0
80106492:	6a 00                	push   $0x0
  pushl $145
80106494:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106499:	e9 7f f5 ff ff       	jmp    80105a1d <alltraps>

8010649e <vector146>:
.globl vector146
vector146:
  pushl $0
8010649e:	6a 00                	push   $0x0
  pushl $146
801064a0:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801064a5:	e9 73 f5 ff ff       	jmp    80105a1d <alltraps>

801064aa <vector147>:
.globl vector147
vector147:
  pushl $0
801064aa:	6a 00                	push   $0x0
  pushl $147
801064ac:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801064b1:	e9 67 f5 ff ff       	jmp    80105a1d <alltraps>

801064b6 <vector148>:
.globl vector148
vector148:
  pushl $0
801064b6:	6a 00                	push   $0x0
  pushl $148
801064b8:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801064bd:	e9 5b f5 ff ff       	jmp    80105a1d <alltraps>

801064c2 <vector149>:
.globl vector149
vector149:
  pushl $0
801064c2:	6a 00                	push   $0x0
  pushl $149
801064c4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801064c9:	e9 4f f5 ff ff       	jmp    80105a1d <alltraps>

801064ce <vector150>:
.globl vector150
vector150:
  pushl $0
801064ce:	6a 00                	push   $0x0
  pushl $150
801064d0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801064d5:	e9 43 f5 ff ff       	jmp    80105a1d <alltraps>

801064da <vector151>:
.globl vector151
vector151:
  pushl $0
801064da:	6a 00                	push   $0x0
  pushl $151
801064dc:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801064e1:	e9 37 f5 ff ff       	jmp    80105a1d <alltraps>

801064e6 <vector152>:
.globl vector152
vector152:
  pushl $0
801064e6:	6a 00                	push   $0x0
  pushl $152
801064e8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801064ed:	e9 2b f5 ff ff       	jmp    80105a1d <alltraps>

801064f2 <vector153>:
.globl vector153
vector153:
  pushl $0
801064f2:	6a 00                	push   $0x0
  pushl $153
801064f4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801064f9:	e9 1f f5 ff ff       	jmp    80105a1d <alltraps>

801064fe <vector154>:
.globl vector154
vector154:
  pushl $0
801064fe:	6a 00                	push   $0x0
  pushl $154
80106500:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106505:	e9 13 f5 ff ff       	jmp    80105a1d <alltraps>

8010650a <vector155>:
.globl vector155
vector155:
  pushl $0
8010650a:	6a 00                	push   $0x0
  pushl $155
8010650c:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106511:	e9 07 f5 ff ff       	jmp    80105a1d <alltraps>

80106516 <vector156>:
.globl vector156
vector156:
  pushl $0
80106516:	6a 00                	push   $0x0
  pushl $156
80106518:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010651d:	e9 fb f4 ff ff       	jmp    80105a1d <alltraps>

80106522 <vector157>:
.globl vector157
vector157:
  pushl $0
80106522:	6a 00                	push   $0x0
  pushl $157
80106524:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106529:	e9 ef f4 ff ff       	jmp    80105a1d <alltraps>

8010652e <vector158>:
.globl vector158
vector158:
  pushl $0
8010652e:	6a 00                	push   $0x0
  pushl $158
80106530:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106535:	e9 e3 f4 ff ff       	jmp    80105a1d <alltraps>

8010653a <vector159>:
.globl vector159
vector159:
  pushl $0
8010653a:	6a 00                	push   $0x0
  pushl $159
8010653c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106541:	e9 d7 f4 ff ff       	jmp    80105a1d <alltraps>

80106546 <vector160>:
.globl vector160
vector160:
  pushl $0
80106546:	6a 00                	push   $0x0
  pushl $160
80106548:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010654d:	e9 cb f4 ff ff       	jmp    80105a1d <alltraps>

80106552 <vector161>:
.globl vector161
vector161:
  pushl $0
80106552:	6a 00                	push   $0x0
  pushl $161
80106554:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106559:	e9 bf f4 ff ff       	jmp    80105a1d <alltraps>

8010655e <vector162>:
.globl vector162
vector162:
  pushl $0
8010655e:	6a 00                	push   $0x0
  pushl $162
80106560:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106565:	e9 b3 f4 ff ff       	jmp    80105a1d <alltraps>

8010656a <vector163>:
.globl vector163
vector163:
  pushl $0
8010656a:	6a 00                	push   $0x0
  pushl $163
8010656c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106571:	e9 a7 f4 ff ff       	jmp    80105a1d <alltraps>

80106576 <vector164>:
.globl vector164
vector164:
  pushl $0
80106576:	6a 00                	push   $0x0
  pushl $164
80106578:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010657d:	e9 9b f4 ff ff       	jmp    80105a1d <alltraps>

80106582 <vector165>:
.globl vector165
vector165:
  pushl $0
80106582:	6a 00                	push   $0x0
  pushl $165
80106584:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106589:	e9 8f f4 ff ff       	jmp    80105a1d <alltraps>

8010658e <vector166>:
.globl vector166
vector166:
  pushl $0
8010658e:	6a 00                	push   $0x0
  pushl $166
80106590:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106595:	e9 83 f4 ff ff       	jmp    80105a1d <alltraps>

8010659a <vector167>:
.globl vector167
vector167:
  pushl $0
8010659a:	6a 00                	push   $0x0
  pushl $167
8010659c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801065a1:	e9 77 f4 ff ff       	jmp    80105a1d <alltraps>

801065a6 <vector168>:
.globl vector168
vector168:
  pushl $0
801065a6:	6a 00                	push   $0x0
  pushl $168
801065a8:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801065ad:	e9 6b f4 ff ff       	jmp    80105a1d <alltraps>

801065b2 <vector169>:
.globl vector169
vector169:
  pushl $0
801065b2:	6a 00                	push   $0x0
  pushl $169
801065b4:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801065b9:	e9 5f f4 ff ff       	jmp    80105a1d <alltraps>

801065be <vector170>:
.globl vector170
vector170:
  pushl $0
801065be:	6a 00                	push   $0x0
  pushl $170
801065c0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801065c5:	e9 53 f4 ff ff       	jmp    80105a1d <alltraps>

801065ca <vector171>:
.globl vector171
vector171:
  pushl $0
801065ca:	6a 00                	push   $0x0
  pushl $171
801065cc:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801065d1:	e9 47 f4 ff ff       	jmp    80105a1d <alltraps>

801065d6 <vector172>:
.globl vector172
vector172:
  pushl $0
801065d6:	6a 00                	push   $0x0
  pushl $172
801065d8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801065dd:	e9 3b f4 ff ff       	jmp    80105a1d <alltraps>

801065e2 <vector173>:
.globl vector173
vector173:
  pushl $0
801065e2:	6a 00                	push   $0x0
  pushl $173
801065e4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801065e9:	e9 2f f4 ff ff       	jmp    80105a1d <alltraps>

801065ee <vector174>:
.globl vector174
vector174:
  pushl $0
801065ee:	6a 00                	push   $0x0
  pushl $174
801065f0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801065f5:	e9 23 f4 ff ff       	jmp    80105a1d <alltraps>

801065fa <vector175>:
.globl vector175
vector175:
  pushl $0
801065fa:	6a 00                	push   $0x0
  pushl $175
801065fc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106601:	e9 17 f4 ff ff       	jmp    80105a1d <alltraps>

80106606 <vector176>:
.globl vector176
vector176:
  pushl $0
80106606:	6a 00                	push   $0x0
  pushl $176
80106608:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010660d:	e9 0b f4 ff ff       	jmp    80105a1d <alltraps>

80106612 <vector177>:
.globl vector177
vector177:
  pushl $0
80106612:	6a 00                	push   $0x0
  pushl $177
80106614:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106619:	e9 ff f3 ff ff       	jmp    80105a1d <alltraps>

8010661e <vector178>:
.globl vector178
vector178:
  pushl $0
8010661e:	6a 00                	push   $0x0
  pushl $178
80106620:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106625:	e9 f3 f3 ff ff       	jmp    80105a1d <alltraps>

8010662a <vector179>:
.globl vector179
vector179:
  pushl $0
8010662a:	6a 00                	push   $0x0
  pushl $179
8010662c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106631:	e9 e7 f3 ff ff       	jmp    80105a1d <alltraps>

80106636 <vector180>:
.globl vector180
vector180:
  pushl $0
80106636:	6a 00                	push   $0x0
  pushl $180
80106638:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010663d:	e9 db f3 ff ff       	jmp    80105a1d <alltraps>

80106642 <vector181>:
.globl vector181
vector181:
  pushl $0
80106642:	6a 00                	push   $0x0
  pushl $181
80106644:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106649:	e9 cf f3 ff ff       	jmp    80105a1d <alltraps>

8010664e <vector182>:
.globl vector182
vector182:
  pushl $0
8010664e:	6a 00                	push   $0x0
  pushl $182
80106650:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106655:	e9 c3 f3 ff ff       	jmp    80105a1d <alltraps>

8010665a <vector183>:
.globl vector183
vector183:
  pushl $0
8010665a:	6a 00                	push   $0x0
  pushl $183
8010665c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106661:	e9 b7 f3 ff ff       	jmp    80105a1d <alltraps>

80106666 <vector184>:
.globl vector184
vector184:
  pushl $0
80106666:	6a 00                	push   $0x0
  pushl $184
80106668:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010666d:	e9 ab f3 ff ff       	jmp    80105a1d <alltraps>

80106672 <vector185>:
.globl vector185
vector185:
  pushl $0
80106672:	6a 00                	push   $0x0
  pushl $185
80106674:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106679:	e9 9f f3 ff ff       	jmp    80105a1d <alltraps>

8010667e <vector186>:
.globl vector186
vector186:
  pushl $0
8010667e:	6a 00                	push   $0x0
  pushl $186
80106680:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106685:	e9 93 f3 ff ff       	jmp    80105a1d <alltraps>

8010668a <vector187>:
.globl vector187
vector187:
  pushl $0
8010668a:	6a 00                	push   $0x0
  pushl $187
8010668c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106691:	e9 87 f3 ff ff       	jmp    80105a1d <alltraps>

80106696 <vector188>:
.globl vector188
vector188:
  pushl $0
80106696:	6a 00                	push   $0x0
  pushl $188
80106698:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010669d:	e9 7b f3 ff ff       	jmp    80105a1d <alltraps>

801066a2 <vector189>:
.globl vector189
vector189:
  pushl $0
801066a2:	6a 00                	push   $0x0
  pushl $189
801066a4:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801066a9:	e9 6f f3 ff ff       	jmp    80105a1d <alltraps>

801066ae <vector190>:
.globl vector190
vector190:
  pushl $0
801066ae:	6a 00                	push   $0x0
  pushl $190
801066b0:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801066b5:	e9 63 f3 ff ff       	jmp    80105a1d <alltraps>

801066ba <vector191>:
.globl vector191
vector191:
  pushl $0
801066ba:	6a 00                	push   $0x0
  pushl $191
801066bc:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801066c1:	e9 57 f3 ff ff       	jmp    80105a1d <alltraps>

801066c6 <vector192>:
.globl vector192
vector192:
  pushl $0
801066c6:	6a 00                	push   $0x0
  pushl $192
801066c8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801066cd:	e9 4b f3 ff ff       	jmp    80105a1d <alltraps>

801066d2 <vector193>:
.globl vector193
vector193:
  pushl $0
801066d2:	6a 00                	push   $0x0
  pushl $193
801066d4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801066d9:	e9 3f f3 ff ff       	jmp    80105a1d <alltraps>

801066de <vector194>:
.globl vector194
vector194:
  pushl $0
801066de:	6a 00                	push   $0x0
  pushl $194
801066e0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801066e5:	e9 33 f3 ff ff       	jmp    80105a1d <alltraps>

801066ea <vector195>:
.globl vector195
vector195:
  pushl $0
801066ea:	6a 00                	push   $0x0
  pushl $195
801066ec:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801066f1:	e9 27 f3 ff ff       	jmp    80105a1d <alltraps>

801066f6 <vector196>:
.globl vector196
vector196:
  pushl $0
801066f6:	6a 00                	push   $0x0
  pushl $196
801066f8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801066fd:	e9 1b f3 ff ff       	jmp    80105a1d <alltraps>

80106702 <vector197>:
.globl vector197
vector197:
  pushl $0
80106702:	6a 00                	push   $0x0
  pushl $197
80106704:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106709:	e9 0f f3 ff ff       	jmp    80105a1d <alltraps>

8010670e <vector198>:
.globl vector198
vector198:
  pushl $0
8010670e:	6a 00                	push   $0x0
  pushl $198
80106710:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106715:	e9 03 f3 ff ff       	jmp    80105a1d <alltraps>

8010671a <vector199>:
.globl vector199
vector199:
  pushl $0
8010671a:	6a 00                	push   $0x0
  pushl $199
8010671c:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106721:	e9 f7 f2 ff ff       	jmp    80105a1d <alltraps>

80106726 <vector200>:
.globl vector200
vector200:
  pushl $0
80106726:	6a 00                	push   $0x0
  pushl $200
80106728:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010672d:	e9 eb f2 ff ff       	jmp    80105a1d <alltraps>

80106732 <vector201>:
.globl vector201
vector201:
  pushl $0
80106732:	6a 00                	push   $0x0
  pushl $201
80106734:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106739:	e9 df f2 ff ff       	jmp    80105a1d <alltraps>

8010673e <vector202>:
.globl vector202
vector202:
  pushl $0
8010673e:	6a 00                	push   $0x0
  pushl $202
80106740:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106745:	e9 d3 f2 ff ff       	jmp    80105a1d <alltraps>

8010674a <vector203>:
.globl vector203
vector203:
  pushl $0
8010674a:	6a 00                	push   $0x0
  pushl $203
8010674c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106751:	e9 c7 f2 ff ff       	jmp    80105a1d <alltraps>

80106756 <vector204>:
.globl vector204
vector204:
  pushl $0
80106756:	6a 00                	push   $0x0
  pushl $204
80106758:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010675d:	e9 bb f2 ff ff       	jmp    80105a1d <alltraps>

80106762 <vector205>:
.globl vector205
vector205:
  pushl $0
80106762:	6a 00                	push   $0x0
  pushl $205
80106764:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106769:	e9 af f2 ff ff       	jmp    80105a1d <alltraps>

8010676e <vector206>:
.globl vector206
vector206:
  pushl $0
8010676e:	6a 00                	push   $0x0
  pushl $206
80106770:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106775:	e9 a3 f2 ff ff       	jmp    80105a1d <alltraps>

8010677a <vector207>:
.globl vector207
vector207:
  pushl $0
8010677a:	6a 00                	push   $0x0
  pushl $207
8010677c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106781:	e9 97 f2 ff ff       	jmp    80105a1d <alltraps>

80106786 <vector208>:
.globl vector208
vector208:
  pushl $0
80106786:	6a 00                	push   $0x0
  pushl $208
80106788:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010678d:	e9 8b f2 ff ff       	jmp    80105a1d <alltraps>

80106792 <vector209>:
.globl vector209
vector209:
  pushl $0
80106792:	6a 00                	push   $0x0
  pushl $209
80106794:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106799:	e9 7f f2 ff ff       	jmp    80105a1d <alltraps>

8010679e <vector210>:
.globl vector210
vector210:
  pushl $0
8010679e:	6a 00                	push   $0x0
  pushl $210
801067a0:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801067a5:	e9 73 f2 ff ff       	jmp    80105a1d <alltraps>

801067aa <vector211>:
.globl vector211
vector211:
  pushl $0
801067aa:	6a 00                	push   $0x0
  pushl $211
801067ac:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801067b1:	e9 67 f2 ff ff       	jmp    80105a1d <alltraps>

801067b6 <vector212>:
.globl vector212
vector212:
  pushl $0
801067b6:	6a 00                	push   $0x0
  pushl $212
801067b8:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801067bd:	e9 5b f2 ff ff       	jmp    80105a1d <alltraps>

801067c2 <vector213>:
.globl vector213
vector213:
  pushl $0
801067c2:	6a 00                	push   $0x0
  pushl $213
801067c4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801067c9:	e9 4f f2 ff ff       	jmp    80105a1d <alltraps>

801067ce <vector214>:
.globl vector214
vector214:
  pushl $0
801067ce:	6a 00                	push   $0x0
  pushl $214
801067d0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801067d5:	e9 43 f2 ff ff       	jmp    80105a1d <alltraps>

801067da <vector215>:
.globl vector215
vector215:
  pushl $0
801067da:	6a 00                	push   $0x0
  pushl $215
801067dc:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801067e1:	e9 37 f2 ff ff       	jmp    80105a1d <alltraps>

801067e6 <vector216>:
.globl vector216
vector216:
  pushl $0
801067e6:	6a 00                	push   $0x0
  pushl $216
801067e8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801067ed:	e9 2b f2 ff ff       	jmp    80105a1d <alltraps>

801067f2 <vector217>:
.globl vector217
vector217:
  pushl $0
801067f2:	6a 00                	push   $0x0
  pushl $217
801067f4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801067f9:	e9 1f f2 ff ff       	jmp    80105a1d <alltraps>

801067fe <vector218>:
.globl vector218
vector218:
  pushl $0
801067fe:	6a 00                	push   $0x0
  pushl $218
80106800:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106805:	e9 13 f2 ff ff       	jmp    80105a1d <alltraps>

8010680a <vector219>:
.globl vector219
vector219:
  pushl $0
8010680a:	6a 00                	push   $0x0
  pushl $219
8010680c:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106811:	e9 07 f2 ff ff       	jmp    80105a1d <alltraps>

80106816 <vector220>:
.globl vector220
vector220:
  pushl $0
80106816:	6a 00                	push   $0x0
  pushl $220
80106818:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010681d:	e9 fb f1 ff ff       	jmp    80105a1d <alltraps>

80106822 <vector221>:
.globl vector221
vector221:
  pushl $0
80106822:	6a 00                	push   $0x0
  pushl $221
80106824:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106829:	e9 ef f1 ff ff       	jmp    80105a1d <alltraps>

8010682e <vector222>:
.globl vector222
vector222:
  pushl $0
8010682e:	6a 00                	push   $0x0
  pushl $222
80106830:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106835:	e9 e3 f1 ff ff       	jmp    80105a1d <alltraps>

8010683a <vector223>:
.globl vector223
vector223:
  pushl $0
8010683a:	6a 00                	push   $0x0
  pushl $223
8010683c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106841:	e9 d7 f1 ff ff       	jmp    80105a1d <alltraps>

80106846 <vector224>:
.globl vector224
vector224:
  pushl $0
80106846:	6a 00                	push   $0x0
  pushl $224
80106848:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010684d:	e9 cb f1 ff ff       	jmp    80105a1d <alltraps>

80106852 <vector225>:
.globl vector225
vector225:
  pushl $0
80106852:	6a 00                	push   $0x0
  pushl $225
80106854:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106859:	e9 bf f1 ff ff       	jmp    80105a1d <alltraps>

8010685e <vector226>:
.globl vector226
vector226:
  pushl $0
8010685e:	6a 00                	push   $0x0
  pushl $226
80106860:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106865:	e9 b3 f1 ff ff       	jmp    80105a1d <alltraps>

8010686a <vector227>:
.globl vector227
vector227:
  pushl $0
8010686a:	6a 00                	push   $0x0
  pushl $227
8010686c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106871:	e9 a7 f1 ff ff       	jmp    80105a1d <alltraps>

80106876 <vector228>:
.globl vector228
vector228:
  pushl $0
80106876:	6a 00                	push   $0x0
  pushl $228
80106878:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010687d:	e9 9b f1 ff ff       	jmp    80105a1d <alltraps>

80106882 <vector229>:
.globl vector229
vector229:
  pushl $0
80106882:	6a 00                	push   $0x0
  pushl $229
80106884:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106889:	e9 8f f1 ff ff       	jmp    80105a1d <alltraps>

8010688e <vector230>:
.globl vector230
vector230:
  pushl $0
8010688e:	6a 00                	push   $0x0
  pushl $230
80106890:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106895:	e9 83 f1 ff ff       	jmp    80105a1d <alltraps>

8010689a <vector231>:
.globl vector231
vector231:
  pushl $0
8010689a:	6a 00                	push   $0x0
  pushl $231
8010689c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801068a1:	e9 77 f1 ff ff       	jmp    80105a1d <alltraps>

801068a6 <vector232>:
.globl vector232
vector232:
  pushl $0
801068a6:	6a 00                	push   $0x0
  pushl $232
801068a8:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801068ad:	e9 6b f1 ff ff       	jmp    80105a1d <alltraps>

801068b2 <vector233>:
.globl vector233
vector233:
  pushl $0
801068b2:	6a 00                	push   $0x0
  pushl $233
801068b4:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801068b9:	e9 5f f1 ff ff       	jmp    80105a1d <alltraps>

801068be <vector234>:
.globl vector234
vector234:
  pushl $0
801068be:	6a 00                	push   $0x0
  pushl $234
801068c0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801068c5:	e9 53 f1 ff ff       	jmp    80105a1d <alltraps>

801068ca <vector235>:
.globl vector235
vector235:
  pushl $0
801068ca:	6a 00                	push   $0x0
  pushl $235
801068cc:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801068d1:	e9 47 f1 ff ff       	jmp    80105a1d <alltraps>

801068d6 <vector236>:
.globl vector236
vector236:
  pushl $0
801068d6:	6a 00                	push   $0x0
  pushl $236
801068d8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801068dd:	e9 3b f1 ff ff       	jmp    80105a1d <alltraps>

801068e2 <vector237>:
.globl vector237
vector237:
  pushl $0
801068e2:	6a 00                	push   $0x0
  pushl $237
801068e4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801068e9:	e9 2f f1 ff ff       	jmp    80105a1d <alltraps>

801068ee <vector238>:
.globl vector238
vector238:
  pushl $0
801068ee:	6a 00                	push   $0x0
  pushl $238
801068f0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801068f5:	e9 23 f1 ff ff       	jmp    80105a1d <alltraps>

801068fa <vector239>:
.globl vector239
vector239:
  pushl $0
801068fa:	6a 00                	push   $0x0
  pushl $239
801068fc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106901:	e9 17 f1 ff ff       	jmp    80105a1d <alltraps>

80106906 <vector240>:
.globl vector240
vector240:
  pushl $0
80106906:	6a 00                	push   $0x0
  pushl $240
80106908:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010690d:	e9 0b f1 ff ff       	jmp    80105a1d <alltraps>

80106912 <vector241>:
.globl vector241
vector241:
  pushl $0
80106912:	6a 00                	push   $0x0
  pushl $241
80106914:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106919:	e9 ff f0 ff ff       	jmp    80105a1d <alltraps>

8010691e <vector242>:
.globl vector242
vector242:
  pushl $0
8010691e:	6a 00                	push   $0x0
  pushl $242
80106920:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106925:	e9 f3 f0 ff ff       	jmp    80105a1d <alltraps>

8010692a <vector243>:
.globl vector243
vector243:
  pushl $0
8010692a:	6a 00                	push   $0x0
  pushl $243
8010692c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106931:	e9 e7 f0 ff ff       	jmp    80105a1d <alltraps>

80106936 <vector244>:
.globl vector244
vector244:
  pushl $0
80106936:	6a 00                	push   $0x0
  pushl $244
80106938:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010693d:	e9 db f0 ff ff       	jmp    80105a1d <alltraps>

80106942 <vector245>:
.globl vector245
vector245:
  pushl $0
80106942:	6a 00                	push   $0x0
  pushl $245
80106944:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106949:	e9 cf f0 ff ff       	jmp    80105a1d <alltraps>

8010694e <vector246>:
.globl vector246
vector246:
  pushl $0
8010694e:	6a 00                	push   $0x0
  pushl $246
80106950:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106955:	e9 c3 f0 ff ff       	jmp    80105a1d <alltraps>

8010695a <vector247>:
.globl vector247
vector247:
  pushl $0
8010695a:	6a 00                	push   $0x0
  pushl $247
8010695c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106961:	e9 b7 f0 ff ff       	jmp    80105a1d <alltraps>

80106966 <vector248>:
.globl vector248
vector248:
  pushl $0
80106966:	6a 00                	push   $0x0
  pushl $248
80106968:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010696d:	e9 ab f0 ff ff       	jmp    80105a1d <alltraps>

80106972 <vector249>:
.globl vector249
vector249:
  pushl $0
80106972:	6a 00                	push   $0x0
  pushl $249
80106974:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106979:	e9 9f f0 ff ff       	jmp    80105a1d <alltraps>

8010697e <vector250>:
.globl vector250
vector250:
  pushl $0
8010697e:	6a 00                	push   $0x0
  pushl $250
80106980:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106985:	e9 93 f0 ff ff       	jmp    80105a1d <alltraps>

8010698a <vector251>:
.globl vector251
vector251:
  pushl $0
8010698a:	6a 00                	push   $0x0
  pushl $251
8010698c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106991:	e9 87 f0 ff ff       	jmp    80105a1d <alltraps>

80106996 <vector252>:
.globl vector252
vector252:
  pushl $0
80106996:	6a 00                	push   $0x0
  pushl $252
80106998:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010699d:	e9 7b f0 ff ff       	jmp    80105a1d <alltraps>

801069a2 <vector253>:
.globl vector253
vector253:
  pushl $0
801069a2:	6a 00                	push   $0x0
  pushl $253
801069a4:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801069a9:	e9 6f f0 ff ff       	jmp    80105a1d <alltraps>

801069ae <vector254>:
.globl vector254
vector254:
  pushl $0
801069ae:	6a 00                	push   $0x0
  pushl $254
801069b0:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801069b5:	e9 63 f0 ff ff       	jmp    80105a1d <alltraps>

801069ba <vector255>:
.globl vector255
vector255:
  pushl $0
801069ba:	6a 00                	push   $0x0
  pushl $255
801069bc:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801069c1:	e9 57 f0 ff ff       	jmp    80105a1d <alltraps>
801069c6:	66 90                	xchg   %ax,%ax
801069c8:	66 90                	xchg   %ax,%ax
801069ca:	66 90                	xchg   %ax,%ax
801069cc:	66 90                	xchg   %ax,%ax
801069ce:	66 90                	xchg   %ax,%ax

801069d0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	83 ec 28             	sub    $0x28,%esp
801069d6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801069d9:	89 d6                	mov    %edx,%esi
801069db:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801069de:	c1 ea 16             	shr    $0x16,%edx
{
801069e1:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde = &pgdir[PDX(va)];
801069e4:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  if(*pde & PTE_P){
801069e7:	8b 1f                	mov    (%edi),%ebx
801069e9:	f6 c3 01             	test   $0x1,%bl
801069ec:	74 32                	je     80106a20 <walkpgdir+0x50>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801069ee:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801069f4:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801069fa:	89 f0                	mov    %esi,%eax
}
801069fc:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return &pgtab[PTX(va)];
801069ff:	c1 e8 0a             	shr    $0xa,%eax
}
80106a02:	8b 75 f8             	mov    -0x8(%ebp),%esi
  return &pgtab[PTX(va)];
80106a05:	25 fc 0f 00 00       	and    $0xffc,%eax
80106a0a:	01 d8                	add    %ebx,%eax
}
80106a0c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106a0f:	89 ec                	mov    %ebp,%esp
80106a11:	5d                   	pop    %ebp
80106a12:	c3                   	ret    
80106a13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106a20:	85 c9                	test   %ecx,%ecx
80106a22:	74 3c                	je     80106a60 <walkpgdir+0x90>
80106a24:	e8 17 bd ff ff       	call   80102740 <kalloc>
80106a29:	85 c0                	test   %eax,%eax
80106a2b:	89 c3                	mov    %eax,%ebx
80106a2d:	74 31                	je     80106a60 <walkpgdir+0x90>
    memset(pgtab, 0, PGSIZE);
80106a2f:	89 1c 24             	mov    %ebx,(%esp)
80106a32:	b8 00 10 00 00       	mov    $0x1000,%eax
80106a37:	31 d2                	xor    %edx,%edx
80106a39:	89 44 24 08          	mov    %eax,0x8(%esp)
80106a3d:	89 54 24 04          	mov    %edx,0x4(%esp)
80106a41:	e8 fa dd ff ff       	call   80104840 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a46:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a4c:	83 c8 07             	or     $0x7,%eax
80106a4f:	89 07                	mov    %eax,(%edi)
80106a51:	eb a7                	jmp    801069fa <walkpgdir+0x2a>
80106a53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80106a60:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return 0;
80106a63:	31 c0                	xor    %eax,%eax
}
80106a65:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106a68:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106a6b:	89 ec                	mov    %ebp,%esp
80106a6d:	5d                   	pop    %ebp
80106a6e:	c3                   	ret    
80106a6f:	90                   	nop

80106a70 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a70:	55                   	push   %ebp
80106a71:	89 e5                	mov    %esp,%ebp
80106a73:	57                   	push   %edi
80106a74:	89 c7                	mov    %eax,%edi
80106a76:	56                   	push   %esi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106a77:	89 d6                	mov    %edx,%esi
{
80106a79:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106a7a:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a80:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
80106a84:	83 ec 2c             	sub    $0x2c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a87:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a8c:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106a8f:	8b 45 08             	mov    0x8(%ebp),%eax
80106a92:	29 f0                	sub    %esi,%eax
80106a94:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a97:	eb 21                	jmp    80106aba <mappages+0x4a>
80106a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106aa0:	f6 00 01             	testb  $0x1,(%eax)
80106aa3:	75 45                	jne    80106aea <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106aa5:	8b 55 0c             	mov    0xc(%ebp),%edx
80106aa8:	09 d3                	or     %edx,%ebx
80106aaa:	83 cb 01             	or     $0x1,%ebx
    if(a == last)
80106aad:	3b 75 e0             	cmp    -0x20(%ebp),%esi
    *pte = pa | perm | PTE_P;
80106ab0:	89 18                	mov    %ebx,(%eax)
    if(a == last)
80106ab2:	74 2c                	je     80106ae0 <mappages+0x70>
      break;
    a += PGSIZE;
80106ab4:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80106aba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106abd:	b9 01 00 00 00       	mov    $0x1,%ecx
80106ac2:	89 f2                	mov    %esi,%edx
80106ac4:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80106ac7:	89 f8                	mov    %edi,%eax
80106ac9:	e8 02 ff ff ff       	call   801069d0 <walkpgdir>
80106ace:	85 c0                	test   %eax,%eax
80106ad0:	75 ce                	jne    80106aa0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106ad2:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80106ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ada:	5b                   	pop    %ebx
80106adb:	5e                   	pop    %esi
80106adc:	5f                   	pop    %edi
80106add:	5d                   	pop    %ebp
80106ade:	c3                   	ret    
80106adf:	90                   	nop
80106ae0:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80106ae3:	31 c0                	xor    %eax,%eax
}
80106ae5:	5b                   	pop    %ebx
80106ae6:	5e                   	pop    %esi
80106ae7:	5f                   	pop    %edi
80106ae8:	5d                   	pop    %ebp
80106ae9:	c3                   	ret    
      panic("remap");
80106aea:	c7 04 24 0c 7c 10 80 	movl   $0x80107c0c,(%esp)
80106af1:	e8 6a 98 ff ff       	call   80100360 <panic>
80106af6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106afd:	8d 76 00             	lea    0x0(%esi),%esi

80106b00 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	57                   	push   %edi
80106b04:	56                   	push   %esi
80106b05:	89 c6                	mov    %eax,%esi
80106b07:	53                   	push   %ebx
80106b08:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106b0a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b10:	83 ec 2c             	sub    $0x2c,%esp
80106b13:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  a = PGROUNDUP(newsz);
80106b16:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; a  < oldsz; a += PGSIZE){
80106b1c:	39 da                	cmp    %ebx,%edx
80106b1e:	73 5f                	jae    80106b7f <deallocuvm.part.0+0x7f>
80106b20:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106b23:	89 d7                	mov    %edx,%edi
80106b25:	eb 34                	jmp    80106b5b <deallocuvm.part.0+0x5b>
80106b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b2e:	66 90                	xchg   %ax,%ax
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106b30:	8b 00                	mov    (%eax),%eax
80106b32:	a8 01                	test   $0x1,%al
80106b34:	74 1a                	je     80106b50 <deallocuvm.part.0+0x50>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106b36:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b3b:	74 4d                	je     80106b8a <deallocuvm.part.0+0x8a>
        panic("kfree");
      char *v = P2V(pa);
80106b3d:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106b42:	89 04 24             	mov    %eax,(%esp)
80106b45:	e8 36 ba ff ff       	call   80102580 <kfree>
      *pte = 0;
80106b4a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80106b50:	81 c7 00 10 00 00    	add    $0x1000,%edi
  for(; a  < oldsz; a += PGSIZE){
80106b56:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106b59:	76 24                	jbe    80106b7f <deallocuvm.part.0+0x7f>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106b5b:	31 c9                	xor    %ecx,%ecx
80106b5d:	89 fa                	mov    %edi,%edx
80106b5f:	89 f0                	mov    %esi,%eax
80106b61:	e8 6a fe ff ff       	call   801069d0 <walkpgdir>
    if(!pte)
80106b66:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
80106b68:	89 c3                	mov    %eax,%ebx
    if(!pte)
80106b6a:	75 c4                	jne    80106b30 <deallocuvm.part.0+0x30>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106b6c:	89 fa                	mov    %edi,%edx
80106b6e:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80106b74:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
  for(; a  < oldsz; a += PGSIZE){
80106b7a:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106b7d:	77 dc                	ja     80106b5b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80106b7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b82:	83 c4 2c             	add    $0x2c,%esp
80106b85:	5b                   	pop    %ebx
80106b86:	5e                   	pop    %esi
80106b87:	5f                   	pop    %edi
80106b88:	5d                   	pop    %ebp
80106b89:	c3                   	ret    
        panic("kfree");
80106b8a:	c7 04 24 c6 75 10 80 	movl   $0x801075c6,(%esp)
80106b91:	e8 ca 97 ff ff       	call   80100360 <panic>
80106b96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b9d:	8d 76 00             	lea    0x0(%esi),%esi

80106ba0 <seginit>:
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106ba6:	e8 55 ce ff ff       	call   80103a00 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106bab:	b9 00 9a cf 00       	mov    $0xcf9a00,%ecx
  pd[0] = size-1;
80106bb0:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80106bb6:	8d 14 80             	lea    (%eax,%eax,4),%edx
80106bb9:	8d 04 50             	lea    (%eax,%edx,2),%eax
80106bbc:	ba ff ff 00 00       	mov    $0xffff,%edx
80106bc1:	c1 e0 04             	shl    $0x4,%eax
80106bc4:	89 90 f8 27 11 80    	mov    %edx,-0x7feed808(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bca:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106bcf:	89 88 fc 27 11 80    	mov    %ecx,-0x7feed804(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bd5:	b9 00 92 cf 00       	mov    $0xcf9200,%ecx
80106bda:	89 90 00 28 11 80    	mov    %edx,-0x7feed800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106be0:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106be5:	89 88 04 28 11 80    	mov    %ecx,-0x7feed7fc(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106beb:	b9 00 fa cf 00       	mov    $0xcffa00,%ecx
80106bf0:	89 90 08 28 11 80    	mov    %edx,-0x7feed7f8(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106bf6:	ba ff ff 00 00       	mov    $0xffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106bfb:	89 88 0c 28 11 80    	mov    %ecx,-0x7feed7f4(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c01:	b9 00 f2 cf 00       	mov    $0xcff200,%ecx
80106c06:	89 90 10 28 11 80    	mov    %edx,-0x7feed7f0(%eax)
80106c0c:	89 88 14 28 11 80    	mov    %ecx,-0x7feed7ec(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106c12:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
80106c17:	0f b7 d0             	movzwl %ax,%edx
80106c1a:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106c1e:	c1 e8 10             	shr    $0x10,%eax
80106c21:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106c25:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c28:	0f 01 10             	lgdtl  (%eax)
}
80106c2b:	c9                   	leave  
80106c2c:	c3                   	ret    
80106c2d:	8d 76 00             	lea    0x0(%esi),%esi

80106c30 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c30:	a1 a4 58 11 80       	mov    0x801158a4,%eax
80106c35:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c3a:	0f 22 d8             	mov    %eax,%cr3
}
80106c3d:	c3                   	ret    
80106c3e:	66 90                	xchg   %ax,%ax

80106c40 <switchuvm>:
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
80106c44:	56                   	push   %esi
80106c45:	53                   	push   %ebx
80106c46:	83 ec 2c             	sub    $0x2c,%esp
80106c49:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106c4c:	85 f6                	test   %esi,%esi
80106c4e:	0f 84 c5 00 00 00    	je     80106d19 <switchuvm+0xd9>
  if(p->kstack == 0)
80106c54:	8b 7e 08             	mov    0x8(%esi),%edi
80106c57:	85 ff                	test   %edi,%edi
80106c59:	0f 84 d2 00 00 00    	je     80106d31 <switchuvm+0xf1>
  if(p->pgdir == 0)
80106c5f:	8b 5e 04             	mov    0x4(%esi),%ebx
80106c62:	85 db                	test   %ebx,%ebx
80106c64:	0f 84 bb 00 00 00    	je     80106d25 <switchuvm+0xe5>
  pushcli();
80106c6a:	e8 d1 d9 ff ff       	call   80104640 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106c6f:	e8 1c cd ff ff       	call   80103990 <mycpu>
80106c74:	89 c3                	mov    %eax,%ebx
80106c76:	e8 15 cd ff ff       	call   80103990 <mycpu>
80106c7b:	89 c7                	mov    %eax,%edi
80106c7d:	e8 0e cd ff ff       	call   80103990 <mycpu>
80106c82:	83 c7 08             	add    $0x8,%edi
80106c85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c88:	e8 03 cd ff ff       	call   80103990 <mycpu>
80106c8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c90:	ba 67 00 00 00       	mov    $0x67,%edx
80106c95:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106c9c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106ca3:	83 c1 08             	add    $0x8,%ecx
80106ca6:	c1 e9 10             	shr    $0x10,%ecx
80106ca9:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106caf:	83 c0 08             	add    $0x8,%eax
80106cb2:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106cb7:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
80106cbe:	c1 e8 18             	shr    $0x18,%eax
80106cc1:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
80106cc7:	e8 c4 cc ff ff       	call   80103990 <mycpu>
80106ccc:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106cd3:	e8 b8 cc ff ff       	call   80103990 <mycpu>
80106cd8:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106cde:	8b 5e 08             	mov    0x8(%esi),%ebx
80106ce1:	e8 aa cc ff ff       	call   80103990 <mycpu>
80106ce6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cec:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106cef:	e8 9c cc ff ff       	call   80103990 <mycpu>
80106cf4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106cfa:	b8 28 00 00 00       	mov    $0x28,%eax
80106cff:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106d02:	8b 46 04             	mov    0x4(%esi),%eax
80106d05:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d0a:	0f 22 d8             	mov    %eax,%cr3
}
80106d0d:	83 c4 2c             	add    $0x2c,%esp
80106d10:	5b                   	pop    %ebx
80106d11:	5e                   	pop    %esi
80106d12:	5f                   	pop    %edi
80106d13:	5d                   	pop    %ebp
  popcli();
80106d14:	e9 77 d9 ff ff       	jmp    80104690 <popcli>
    panic("switchuvm: no process");
80106d19:	c7 04 24 12 7c 10 80 	movl   $0x80107c12,(%esp)
80106d20:	e8 3b 96 ff ff       	call   80100360 <panic>
    panic("switchuvm: no pgdir");
80106d25:	c7 04 24 3d 7c 10 80 	movl   $0x80107c3d,(%esp)
80106d2c:	e8 2f 96 ff ff       	call   80100360 <panic>
    panic("switchuvm: no kstack");
80106d31:	c7 04 24 28 7c 10 80 	movl   $0x80107c28,(%esp)
80106d38:	e8 23 96 ff ff       	call   80100360 <panic>
80106d3d:	8d 76 00             	lea    0x0(%esi),%esi

80106d40 <inituvm>:
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	83 ec 38             	sub    $0x38,%esp
80106d46:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106d49:	8b 75 10             	mov    0x10(%ebp),%esi
80106d4c:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d52:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106d55:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(sz >= PGSIZE)
80106d58:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106d5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106d61:	77 5b                	ja     80106dbe <inituvm+0x7e>
  mem = kalloc();
80106d63:	e8 d8 b9 ff ff       	call   80102740 <kalloc>
  memset(mem, 0, PGSIZE);
80106d68:	31 d2                	xor    %edx,%edx
80106d6a:	89 54 24 04          	mov    %edx,0x4(%esp)
  mem = kalloc();
80106d6e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d70:	b8 00 10 00 00       	mov    $0x1000,%eax
80106d75:	89 1c 24             	mov    %ebx,(%esp)
80106d78:	89 44 24 08          	mov    %eax,0x8(%esp)
80106d7c:	e8 bf da ff ff       	call   80104840 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106d81:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d87:	b9 06 00 00 00       	mov    $0x6,%ecx
80106d8c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106d90:	31 d2                	xor    %edx,%edx
80106d92:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d97:	89 04 24             	mov    %eax,(%esp)
80106d9a:	89 f8                	mov    %edi,%eax
80106d9c:	e8 cf fc ff ff       	call   80106a70 <mappages>
  memmove(mem, init, sz);
80106da1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106da4:	89 75 10             	mov    %esi,0x10(%ebp)
}
80106da7:	8b 7d fc             	mov    -0x4(%ebp),%edi
  memmove(mem, init, sz);
80106daa:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106dad:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106db0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  memmove(mem, init, sz);
80106db3:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80106db6:	89 ec                	mov    %ebp,%esp
80106db8:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106db9:	e9 42 db ff ff       	jmp    80104900 <memmove>
    panic("inituvm: more than a page");
80106dbe:	c7 04 24 51 7c 10 80 	movl   $0x80107c51,(%esp)
80106dc5:	e8 96 95 ff ff       	call   80100360 <panic>
80106dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106dd0 <loaduvm>:
{
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	57                   	push   %edi
80106dd4:	56                   	push   %esi
80106dd5:	53                   	push   %ebx
80106dd6:	83 ec 2c             	sub    $0x2c,%esp
80106dd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ddc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80106ddf:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106de4:	0f 85 9c 00 00 00    	jne    80106e86 <loaduvm+0xb6>
  for(i = 0; i < sz; i += PGSIZE){
80106dea:	01 f0                	add    %esi,%eax
80106dec:	89 f3                	mov    %esi,%ebx
80106dee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106df1:	8b 45 14             	mov    0x14(%ebp),%eax
80106df4:	01 f0                	add    %esi,%eax
  for(i = 0; i < sz; i += PGSIZE){
80106df6:	85 f6                	test   %esi,%esi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106df8:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80106dfb:	75 11                	jne    80106e0e <loaduvm+0x3e>
80106dfd:	eb 71                	jmp    80106e70 <loaduvm+0xa0>
80106dff:	90                   	nop
80106e00:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106e06:	89 f0                	mov    %esi,%eax
80106e08:	29 d8                	sub    %ebx,%eax
80106e0a:	39 c6                	cmp    %eax,%esi
80106e0c:	76 62                	jbe    80106e70 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106e0e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106e11:	31 c9                	xor    %ecx,%ecx
80106e13:	8b 45 08             	mov    0x8(%ebp),%eax
80106e16:	29 da                	sub    %ebx,%edx
80106e18:	e8 b3 fb ff ff       	call   801069d0 <walkpgdir>
80106e1d:	85 c0                	test   %eax,%eax
80106e1f:	74 59                	je     80106e7a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80106e21:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
80106e23:	bf 00 10 00 00       	mov    $0x1000,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e28:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80106e2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106e30:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106e36:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e39:	05 00 00 00 80       	add    $0x80000000,%eax
80106e3e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106e42:	8b 45 10             	mov    0x10(%ebp),%eax
80106e45:	29 d9                	sub    %ebx,%ecx
80106e47:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106e4b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106e4f:	89 04 24             	mov    %eax,(%esp)
80106e52:	e8 99 ac ff ff       	call   80101af0 <readi>
80106e57:	39 f8                	cmp    %edi,%eax
80106e59:	74 a5                	je     80106e00 <loaduvm+0x30>
}
80106e5b:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80106e5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e63:	5b                   	pop    %ebx
80106e64:	5e                   	pop    %esi
80106e65:	5f                   	pop    %edi
80106e66:	5d                   	pop    %ebp
80106e67:	c3                   	ret    
80106e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e6f:	90                   	nop
80106e70:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80106e73:	31 c0                	xor    %eax,%eax
}
80106e75:	5b                   	pop    %ebx
80106e76:	5e                   	pop    %esi
80106e77:	5f                   	pop    %edi
80106e78:	5d                   	pop    %ebp
80106e79:	c3                   	ret    
      panic("loaduvm: address should exist");
80106e7a:	c7 04 24 6b 7c 10 80 	movl   $0x80107c6b,(%esp)
80106e81:	e8 da 94 ff ff       	call   80100360 <panic>
    panic("loaduvm: addr must be page aligned");
80106e86:	c7 04 24 0c 7d 10 80 	movl   $0x80107d0c,(%esp)
80106e8d:	e8 ce 94 ff ff       	call   80100360 <panic>
80106e92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ea0 <allocuvm>:
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	57                   	push   %edi
80106ea4:	56                   	push   %esi
80106ea5:	53                   	push   %ebx
80106ea6:	83 ec 2c             	sub    $0x2c,%esp
  if(newsz >= KERNBASE)
80106ea9:	8b 45 10             	mov    0x10(%ebp),%eax
{
80106eac:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80106eaf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106eb2:	85 c0                	test   %eax,%eax
80106eb4:	0f 88 c6 00 00 00    	js     80106f80 <allocuvm+0xe0>
  if(newsz < oldsz)
80106eba:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80106ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106ec0:	0f 82 aa 00 00 00    	jb     80106f70 <allocuvm+0xd0>
  a = PGROUNDUP(oldsz);
80106ec6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80106ecc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106ed2:	39 75 10             	cmp    %esi,0x10(%ebp)
80106ed5:	77 53                	ja     80106f2a <allocuvm+0x8a>
80106ed7:	e9 97 00 00 00       	jmp    80106f73 <allocuvm+0xd3>
80106edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106ee0:	89 1c 24             	mov    %ebx,(%esp)
80106ee3:	31 d2                	xor    %edx,%edx
80106ee5:	b8 00 10 00 00       	mov    $0x1000,%eax
80106eea:	89 54 24 04          	mov    %edx,0x4(%esp)
80106eee:	89 44 24 08          	mov    %eax,0x8(%esp)
80106ef2:	e8 49 d9 ff ff       	call   80104840 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106ef7:	b9 06 00 00 00       	mov    $0x6,%ecx
80106efc:	89 f2                	mov    %esi,%edx
80106efe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106f02:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f08:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f0d:	89 04 24             	mov    %eax,(%esp)
80106f10:	89 f8                	mov    %edi,%eax
80106f12:	e8 59 fb ff ff       	call   80106a70 <mappages>
80106f17:	85 c0                	test   %eax,%eax
80106f19:	0f 88 81 00 00 00    	js     80106fa0 <allocuvm+0x100>
  for(; a < newsz; a += PGSIZE){
80106f1f:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106f25:	39 75 10             	cmp    %esi,0x10(%ebp)
80106f28:	76 49                	jbe    80106f73 <allocuvm+0xd3>
    mem = kalloc();
80106f2a:	e8 11 b8 ff ff       	call   80102740 <kalloc>
    if(mem == 0){
80106f2f:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106f31:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106f33:	75 ab                	jne    80106ee0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106f35:	c7 04 24 89 7c 10 80 	movl   $0x80107c89,(%esp)
80106f3c:	e8 3f 97 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
80106f41:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f44:	39 45 10             	cmp    %eax,0x10(%ebp)
80106f47:	74 37                	je     80106f80 <allocuvm+0xe0>
80106f49:	8b 55 10             	mov    0x10(%ebp),%edx
80106f4c:	89 c1                	mov    %eax,%ecx
80106f4e:	89 f8                	mov    %edi,%eax
80106f50:	e8 ab fb ff ff       	call   80106b00 <deallocuvm.part.0>
      return 0;
80106f55:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106f5c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f5f:	83 c4 2c             	add    $0x2c,%esp
80106f62:	5b                   	pop    %ebx
80106f63:	5e                   	pop    %esi
80106f64:	5f                   	pop    %edi
80106f65:	5d                   	pop    %ebp
80106f66:	c3                   	ret    
80106f67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f6e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106f70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80106f73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f76:	83 c4 2c             	add    $0x2c,%esp
80106f79:	5b                   	pop    %ebx
80106f7a:	5e                   	pop    %esi
80106f7b:	5f                   	pop    %edi
80106f7c:	5d                   	pop    %ebp
80106f7d:	c3                   	ret    
80106f7e:	66 90                	xchg   %ax,%ax
    return 0;
80106f80:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106f87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f8a:	83 c4 2c             	add    $0x2c,%esp
80106f8d:	5b                   	pop    %ebx
80106f8e:	5e                   	pop    %esi
80106f8f:	5f                   	pop    %edi
80106f90:	5d                   	pop    %ebp
80106f91:	c3                   	ret    
80106f92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
80106fa0:	c7 04 24 a1 7c 10 80 	movl   $0x80107ca1,(%esp)
80106fa7:	e8 d4 96 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
80106fac:	8b 45 0c             	mov    0xc(%ebp),%eax
80106faf:	39 45 10             	cmp    %eax,0x10(%ebp)
80106fb2:	74 0c                	je     80106fc0 <allocuvm+0x120>
80106fb4:	8b 55 10             	mov    0x10(%ebp),%edx
80106fb7:	89 c1                	mov    %eax,%ecx
80106fb9:	89 f8                	mov    %edi,%eax
80106fbb:	e8 40 fb ff ff       	call   80106b00 <deallocuvm.part.0>
      kfree(mem);
80106fc0:	89 1c 24             	mov    %ebx,(%esp)
80106fc3:	e8 b8 b5 ff ff       	call   80102580 <kfree>
      return 0;
80106fc8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80106fcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106fd2:	83 c4 2c             	add    $0x2c,%esp
80106fd5:	5b                   	pop    %ebx
80106fd6:	5e                   	pop    %esi
80106fd7:	5f                   	pop    %edi
80106fd8:	5d                   	pop    %ebp
80106fd9:	c3                   	ret    
80106fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106fe0 <deallocuvm>:
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106fe6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106fec:	39 d1                	cmp    %edx,%ecx
80106fee:	73 10                	jae    80107000 <deallocuvm+0x20>
}
80106ff0:	5d                   	pop    %ebp
80106ff1:	e9 0a fb ff ff       	jmp    80106b00 <deallocuvm.part.0>
80106ff6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ffd:	8d 76 00             	lea    0x0(%esi),%esi
80107000:	5d                   	pop    %ebp
80107001:	89 d0                	mov    %edx,%eax
80107003:	c3                   	ret    
80107004:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010700b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010700f:	90                   	nop

80107010 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 1c             	sub    $0x1c,%esp
80107019:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010701c:	85 f6                	test   %esi,%esi
8010701e:	74 55                	je     80107075 <freevm+0x65>
  if(newsz >= oldsz)
80107020:	31 c9                	xor    %ecx,%ecx
80107022:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107027:	89 f0                	mov    %esi,%eax
80107029:	89 f3                	mov    %esi,%ebx
8010702b:	e8 d0 fa ff ff       	call   80106b00 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107030:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107036:	eb 0f                	jmp    80107047 <freevm+0x37>
80107038:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010703f:	90                   	nop
80107040:	83 c3 04             	add    $0x4,%ebx
80107043:	39 df                	cmp    %ebx,%edi
80107045:	74 1f                	je     80107066 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80107047:	8b 03                	mov    (%ebx),%eax
80107049:	a8 01                	test   $0x1,%al
8010704b:	74 f3                	je     80107040 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010704d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107052:	83 c3 04             	add    $0x4,%ebx
80107055:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010705a:	89 04 24             	mov    %eax,(%esp)
8010705d:	e8 1e b5 ff ff       	call   80102580 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
80107062:	39 df                	cmp    %ebx,%edi
80107064:	75 e1                	jne    80107047 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107066:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107069:	83 c4 1c             	add    $0x1c,%esp
8010706c:	5b                   	pop    %ebx
8010706d:	5e                   	pop    %esi
8010706e:	5f                   	pop    %edi
8010706f:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107070:	e9 0b b5 ff ff       	jmp    80102580 <kfree>
    panic("freevm: no pgdir");
80107075:	c7 04 24 bd 7c 10 80 	movl   $0x80107cbd,(%esp)
8010707c:	e8 df 92 ff ff       	call   80100360 <panic>
80107081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107088:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010708f:	90                   	nop

80107090 <setupkvm>:
{
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	56                   	push   %esi
80107094:	53                   	push   %ebx
80107095:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80107098:	e8 a3 b6 ff ff       	call   80102740 <kalloc>
8010709d:	85 c0                	test   %eax,%eax
8010709f:	89 c6                	mov    %eax,%esi
801070a1:	74 46                	je     801070e9 <setupkvm+0x59>
  memset(pgdir, 0, PGSIZE);
801070a3:	89 34 24             	mov    %esi,(%esp)
801070a6:	b8 00 10 00 00       	mov    $0x1000,%eax
801070ab:	31 d2                	xor    %edx,%edx
801070ad:	89 44 24 08          	mov    %eax,0x8(%esp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070b1:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
801070b6:	89 54 24 04          	mov    %edx,0x4(%esp)
801070ba:	e8 81 d7 ff ff       	call   80104840 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801070bf:	8b 53 0c             	mov    0xc(%ebx),%edx
                (uint)k->phys_start, k->perm) < 0) {
801070c2:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801070c5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801070c8:	89 54 24 04          	mov    %edx,0x4(%esp)
801070cc:	8b 13                	mov    (%ebx),%edx
801070ce:	89 04 24             	mov    %eax,(%esp)
801070d1:	29 c1                	sub    %eax,%ecx
801070d3:	89 f0                	mov    %esi,%eax
801070d5:	e8 96 f9 ff ff       	call   80106a70 <mappages>
801070da:	85 c0                	test   %eax,%eax
801070dc:	78 22                	js     80107100 <setupkvm+0x70>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070de:	83 c3 10             	add    $0x10,%ebx
801070e1:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801070e7:	75 d6                	jne    801070bf <setupkvm+0x2f>
}
801070e9:	83 c4 10             	add    $0x10,%esp
801070ec:	89 f0                	mov    %esi,%eax
801070ee:	5b                   	pop    %ebx
801070ef:	5e                   	pop    %esi
801070f0:	5d                   	pop    %ebp
801070f1:	c3                   	ret    
801070f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107100:	89 34 24             	mov    %esi,(%esp)
      return 0;
80107103:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107105:	e8 06 ff ff ff       	call   80107010 <freevm>
}
8010710a:	83 c4 10             	add    $0x10,%esp
8010710d:	89 f0                	mov    %esi,%eax
8010710f:	5b                   	pop    %ebx
80107110:	5e                   	pop    %esi
80107111:	5d                   	pop    %ebp
80107112:	c3                   	ret    
80107113:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010711a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107120 <kvmalloc>:
{
80107120:	55                   	push   %ebp
80107121:	89 e5                	mov    %esp,%ebp
80107123:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107126:	e8 65 ff ff ff       	call   80107090 <setupkvm>
8010712b:	a3 a4 58 11 80       	mov    %eax,0x801158a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107130:	05 00 00 00 80       	add    $0x80000000,%eax
80107135:	0f 22 d8             	mov    %eax,%cr3
}
80107138:	c9                   	leave  
80107139:	c3                   	ret    
8010713a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107140 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107140:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107141:	31 c9                	xor    %ecx,%ecx
{
80107143:	89 e5                	mov    %esp,%ebp
80107145:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107148:	8b 55 0c             	mov    0xc(%ebp),%edx
8010714b:	8b 45 08             	mov    0x8(%ebp),%eax
8010714e:	e8 7d f8 ff ff       	call   801069d0 <walkpgdir>
  if(pte == 0)
80107153:	85 c0                	test   %eax,%eax
80107155:	74 05                	je     8010715c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107157:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010715a:	c9                   	leave  
8010715b:	c3                   	ret    
    panic("clearpteu");
8010715c:	c7 04 24 ce 7c 10 80 	movl   $0x80107cce,(%esp)
80107163:	e8 f8 91 ff ff       	call   80100360 <panic>
80107168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010716f:	90                   	nop

80107170 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	57                   	push   %edi
80107174:	56                   	push   %esi
80107175:	53                   	push   %ebx
80107176:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107179:	e8 12 ff ff ff       	call   80107090 <setupkvm>
8010717e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107181:	85 c0                	test   %eax,%eax
80107183:	0f 84 a3 00 00 00    	je     8010722c <copyuvm+0xbc>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107189:	8b 55 0c             	mov    0xc(%ebp),%edx
8010718c:	85 d2                	test   %edx,%edx
8010718e:	0f 84 98 00 00 00    	je     8010722c <copyuvm+0xbc>
80107194:	31 ff                	xor    %edi,%edi
80107196:	eb 50                	jmp    801071e8 <copyuvm+0x78>
80107198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010719f:	90                   	nop
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801071a0:	89 34 24             	mov    %esi,(%esp)
801071a3:	b8 00 10 00 00       	mov    $0x1000,%eax
801071a8:	89 44 24 08          	mov    %eax,0x8(%esp)
801071ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071af:	05 00 00 00 80       	add    $0x80000000,%eax
801071b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801071b8:	e8 43 d7 ff ff       	call   80104900 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801071bd:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801071c3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071c8:	89 04 24             	mov    %eax,(%esp)
801071cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071ce:	89 fa                	mov    %edi,%edx
801071d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801071d4:	e8 97 f8 ff ff       	call   80106a70 <mappages>
801071d9:	85 c0                	test   %eax,%eax
801071db:	78 63                	js     80107240 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
801071dd:	81 c7 00 10 00 00    	add    $0x1000,%edi
801071e3:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801071e6:	76 44                	jbe    8010722c <copyuvm+0xbc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071e8:	8b 45 08             	mov    0x8(%ebp),%eax
801071eb:	31 c9                	xor    %ecx,%ecx
801071ed:	89 fa                	mov    %edi,%edx
801071ef:	e8 dc f7 ff ff       	call   801069d0 <walkpgdir>
801071f4:	85 c0                	test   %eax,%eax
801071f6:	74 5e                	je     80107256 <copyuvm+0xe6>
    if(!(*pte & PTE_P))
801071f8:	8b 18                	mov    (%eax),%ebx
801071fa:	f6 c3 01             	test   $0x1,%bl
801071fd:	74 4b                	je     8010724a <copyuvm+0xda>
    pa = PTE_ADDR(*pte);
801071ff:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80107201:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
80107207:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010720c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010720f:	e8 2c b5 ff ff       	call   80102740 <kalloc>
80107214:	85 c0                	test   %eax,%eax
80107216:	89 c6                	mov    %eax,%esi
80107218:	75 86                	jne    801071a0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
8010721a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010721d:	89 04 24             	mov    %eax,(%esp)
80107220:	e8 eb fd ff ff       	call   80107010 <freevm>
  return 0;
80107225:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
8010722c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010722f:	83 c4 2c             	add    $0x2c,%esp
80107232:	5b                   	pop    %ebx
80107233:	5e                   	pop    %esi
80107234:	5f                   	pop    %edi
80107235:	5d                   	pop    %ebp
80107236:	c3                   	ret    
80107237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010723e:	66 90                	xchg   %ax,%ax
      kfree(mem);
80107240:	89 34 24             	mov    %esi,(%esp)
80107243:	e8 38 b3 ff ff       	call   80102580 <kfree>
      goto bad;
80107248:	eb d0                	jmp    8010721a <copyuvm+0xaa>
      panic("copyuvm: page not present");
8010724a:	c7 04 24 f2 7c 10 80 	movl   $0x80107cf2,(%esp)
80107251:	e8 0a 91 ff ff       	call   80100360 <panic>
      panic("copyuvm: pte should exist");
80107256:	c7 04 24 d8 7c 10 80 	movl   $0x80107cd8,(%esp)
8010725d:	e8 fe 90 ff ff       	call   80100360 <panic>
80107262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107270 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107270:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107271:	31 c9                	xor    %ecx,%ecx
{
80107273:	89 e5                	mov    %esp,%ebp
80107275:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107278:	8b 55 0c             	mov    0xc(%ebp),%edx
8010727b:	8b 45 08             	mov    0x8(%ebp),%eax
8010727e:	e8 4d f7 ff ff       	call   801069d0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107283:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107285:	89 c2                	mov    %eax,%edx
80107287:	83 e2 05             	and    $0x5,%edx
8010728a:	83 fa 05             	cmp    $0x5,%edx
8010728d:	75 11                	jne    801072a0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
8010728f:	c9                   	leave  
  return (char*)P2V(PTE_ADDR(*pte));
80107290:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107295:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010729a:	c3                   	ret    
8010729b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010729f:	90                   	nop
801072a0:	c9                   	leave  
    return 0;
801072a1:	31 c0                	xor    %eax,%eax
}
801072a3:	c3                   	ret    
801072a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801072af:	90                   	nop

801072b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801072b0:	55                   	push   %ebp
801072b1:	89 e5                	mov    %esp,%ebp
801072b3:	57                   	push   %edi
801072b4:	56                   	push   %esi
801072b5:	53                   	push   %ebx
801072b6:	83 ec 1c             	sub    $0x1c,%esp
801072b9:	8b 75 14             	mov    0x14(%ebp),%esi
801072bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072bf:	85 f6                	test   %esi,%esi
801072c1:	75 43                	jne    80107306 <copyout+0x56>
801072c3:	eb 7b                	jmp    80107340 <copyout+0x90>
801072c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801072d0:	8b 55 0c             	mov    0xc(%ebp),%edx
801072d3:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
    n = PGSIZE - (va - va0);
801072d8:	29 d3                	sub    %edx,%ebx
    memmove(pa0 + (va - va0), buf, n);
801072da:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    n = PGSIZE - (va - va0);
801072de:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801072e4:	39 f3                	cmp    %esi,%ebx
801072e6:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
801072e9:	29 fa                	sub    %edi,%edx
801072eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
801072ef:	01 c2                	add    %eax,%edx
801072f1:	89 14 24             	mov    %edx,(%esp)
801072f4:	e8 07 d6 ff ff       	call   80104900 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801072f9:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
    buf += n;
801072ff:	01 5d 10             	add    %ebx,0x10(%ebp)
  while(len > 0){
80107302:	29 de                	sub    %ebx,%esi
80107304:	74 3a                	je     80107340 <copyout+0x90>
    va0 = (uint)PGROUNDDOWN(va);
80107306:	89 55 0c             	mov    %edx,0xc(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80107309:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
8010730c:	89 d7                	mov    %edx,%edi
8010730e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107314:	89 7c 24 04          	mov    %edi,0x4(%esp)
80107318:	89 04 24             	mov    %eax,(%esp)
8010731b:	e8 50 ff ff ff       	call   80107270 <uva2ka>
    if(pa0 == 0)
80107320:	85 c0                	test   %eax,%eax
80107322:	75 ac                	jne    801072d0 <copyout+0x20>
  }
  return 0;
}
80107324:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80107327:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010732c:	5b                   	pop    %ebx
8010732d:	5e                   	pop    %esi
8010732e:	5f                   	pop    %edi
8010732f:	5d                   	pop    %ebp
80107330:	c3                   	ret    
80107331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010733f:	90                   	nop
80107340:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80107343:	31 c0                	xor    %eax,%eax
}
80107345:	5b                   	pop    %ebx
80107346:	5e                   	pop    %esi
80107347:	5f                   	pop    %edi
80107348:	5d                   	pop    %ebp
80107349:	c3                   	ret    
