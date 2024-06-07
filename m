Return-Path: <linux-edac+bounces-1242-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E031900C70
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36AA28A210
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D317B149DED;
	Fri,  7 Jun 2024 19:25:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F56D2E5
	for <linux-edac@vger.kernel.org>; Fri,  7 Jun 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788331; cv=none; b=dQKopZPPwqByrVwVv+uIwq+yQBZdtj5RwI34cYn526EXYBuMHDnCGu93flRJ1RJozyVcrHYIwPW15Jmu/1GIBT8Pd40w3BINroo+rYsFJIpti6EDHNTPSMAHXhsVcqvw6LYLHNQczB4/Mfr+/SHhL6HMBMKZA6gyyKK1mBJDTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788331; c=relaxed/simple;
	bh=JcqUtDMTWu4f0+xBe9a1rj/XsKuaBPPWqnkZwkEnamw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yv/eIA9YOvC18a1rOdJW1yerDBCCnaFxqsEb6mJjDud0zWvyA4hIkOSz0RgtlQt+D75O1wxjDIdzMn7f9RlD4cK1pf+h3R0BWdufPHz3h2FhSK68vr0Xt7Nv4AdRHJ1dY3L/52Gj5X31mUOJX3p+Hz0RLe7khKm74P+I9T7Ii40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3737b3ae019so24078395ab.2
        for <linux-edac@vger.kernel.org>; Fri, 07 Jun 2024 12:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717788327; x=1718393127;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4t0BdDvJPJYJIDR16teo3CX4GdGZC4Uded//NCZsnDc=;
        b=vHIpHF6+WY8lw17Zw4/nQqLuMWzKUpHvwdjzQLO22EXxy54VCsEwRD2qbqVfY9d3rB
         xI/X3wrKm2JkmcJ4PYEgBa1Su/Jdzj2JFo0nmSQfZ90Um+dFoU+MZybyu9bpslSA+Vf6
         6Z8i4j9+D3KWQi13ASpbvFQtXGSzBdRfnCVSfhMZ8gYfHftAOb88vJWm2rCpyrFtvbO8
         TUCVstAxkB59qA93cBw2ehdFvd/6LEkWHo9YeOFszJ0/U5GsFs+YvdkQeEHHbhzP6Wt8
         jBV+SoHLlEAScg5vhLuHhNaaGqIbUKXwd95rL8bS1bCZx4hheuInveQo4B3IBvsnm/xs
         okXw==
X-Forwarded-Encrypted: i=1; AJvYcCW4d06w8vd5g2DE3auG1Pt8N3dE89tI265fNaXBmKYqF3RWLnS/43e9aIydNQg2VgNuHtMr38bBFePjJ581S0sBG2goeV4d0yD3rw==
X-Gm-Message-State: AOJu0YyuO8XGceT1m6DvkUtpu2HfjUONGiUFSKqz2oSHWjU2C/KGLXOZ
	mksvZ1egUQ0QwtpUow1Q82E9vUOZzefcI0tePXVzdSiUdZcG9Y0rvi6OBCC/xr6RtJ9cVKvNIhA
	4q2tn2TTb9LmXpGrjPiZLnTKVFbCjhSWE4cVuvr0BBILcBIy1Gxnb4pA=
X-Google-Smtp-Source: AGHT+IGwNIkUc6YSFAEVPevvX026oxPzlcRSNytsqjmnVPlNsHfpGSh7enTMCVw5tLiQ8bnKASnCg9UTIOKOwiACP1xaDpGOxgsF
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219b:b0:374:a021:f1b2 with SMTP id
 e9e14a558f8ab-375803c1bcbmr1831045ab.5.1717788327313; Fri, 07 Jun 2024
 12:25:27 -0700 (PDT)
Date: Fri, 07 Jun 2024 12:25:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c9938061a51c3d2@google.com>
Subject: [syzbot] [edac?] [usb?] INFO: rcu detected stall in mce_timer_fn (2)
From: syzbot <syzbot+90e0111ce65a7a596238@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f38fa61af7 Linux 6.10-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17907c1c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a1d4156cdd1d8e2
dashboard link: https://syzkaller.appspot.com/bug?extid=90e0111ce65a7a596238
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1169d7aa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1593cdf2980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e5e037cd51c6/disk-c3f38fa6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4362ecb7059/vmlinux-c3f38fa6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c226f717d18/bzImage-c3f38fa6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90e0111ce65a7a596238@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-....: (8703 ticks this GP) idle=267c/1/0x4000000000000000 softirq=12477/21044 fqs=4125
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:       41       4173            0
rcu: 	cputime:    19042         37        33447   ==> 52540(ms)
rcu: 	(detected by 0, t=10508 jiffies, g=9957, q=3204 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
yealink 5-1:36.0: unexpected response 0
NMI backtrace for cpu 1
CPU: 1 PID: 5122 Comm: kworker/1:0 Not tainted 6.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:hlock_class+0x56/0x130 kernel/locking/lockdep.c:228
Code: 20 66 81 e3 ff 1f 0f b7 db be 08 00 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 c0 b2 26 94 e8 d2 d9 7e 00 48 0f a3 1d 6a cd bb 12 <73> 13 48 69 c3 c8 00 00 00 5b 48 05 e0 b6 26 94 c3 cc cc cc cc 48
RSP: 0018:ffffc90000a17ed0 EFLAGS: 00000047
RAX: 0000000000000001 RBX: 0000000000000006 RCX: ffffffff816ae54e
RDX: fffffbfff284d659 RSI: 0000000000000008 RDI: ffffffff9426b2c0
RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff284d658
R10: ffffffff9426b2c7 R11: 0000000000000008 R12: ffffed10080da8db
R13: ffff8880406d46e0 R14: 0000000000000007 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc57e63820 CR3: 000000000d97a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 check_wait_context kernel/locking/lockdep.c:4798 [inline]
 __lock_acquire+0x5e0/0x3b30 kernel/locking/lockdep.c:5087
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
 serial8250_console_write+0xaa6/0x1090 drivers/tty/serial/8250/8250_port.c:3352
 console_emit_next_record kernel/printk/printk.c:2928 [inline]
 console_flush_all+0x53c/0xd70 kernel/printk/printk.c:2994
 console_unlock+0xae/0x290 kernel/printk/printk.c:3063
 vprintk_emit kernel/printk/printk.c:2345 [inline]
 vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2300
 dev_vprintk_emit drivers/base/core.c:4951 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4962
 __dev_printk+0xf5/0x270 drivers/base/core.c:4974
 _dev_err+0xe5/0x120 drivers/base/core.c:5017
 urb_irq_callback+0x12c/0x700 drivers/input/misc/yealink.c:433
 __usb_hcd_giveback_urb+0x364/0x5c0 drivers/usb/core/hcd.c:1648
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1732
 dummy_timer+0x17f6/0x3900 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__start_timer+0x1b7/0x250 arch/x86/kernel/cpu/mce/core.c:1675
Code: 78 32 e8 2c a6 57 00 e8 67 f7 5e 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 45 a1 57 00 48 85 db 75 2b e8 0b a6 57 00 fb 5b <5d> 41 5c 41 5d e9 ff a5 57 00 e8 fa a5 57 00 4c 89 e7 e8 62 2c 44
RSP: 0018:ffffc90000a18c20 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000007575 RCX: ffffffff81363edb
RDX: ffff8880406d3c00 RSI: ffffffff81363ee5 RDI: 0000000000000007
RBP: 0000000000000200 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8b2f28a0 R12: 000000010000fd85
R13: 2c1008001f8bfb01 R14: 0000000000000001 R15: 000000000003d94c
 mce_timer_fn+0x1a6/0x270 arch/x86/kernel/cpu/mce/core.c:1709
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers+0x74b/0xaf0 kernel/time/timer.c:2417
 __run_timer_base kernel/time/timer.c:2428 [inline]
 __run_timer_base kernel/time/timer.c:2421 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2437
 run_timer_softirq+0x10/0x40 kernel/time/timer.c:2445
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0xa19/0xd70 kernel/printk/printk.c:3000
Code: e8 5c 81 26 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 3a 2b 1f 00 48 85 db 0f 85 8b 01 00 00 e8 fc 2f 1f 00 fb 48 8b 04 24 <4c> 89 fa 83 e2 07 0f b6 00 38 d0 7f 08 84 c0 0f 85 a9 02 00 00 41
RSP: 0018:ffffc9000318ed80 EFLAGS: 00000293
RAX: fffff52000631dd7 RBX: 0000000000000000 RCX: ffffffff816eb4e6
RDX: ffff8880406d3c00 RSI: ffffffff816eb4f4 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000008 R12: 0000000000000200
R13: ffffffff8e7c0e78 R14: ffffffff8e7c0e20 R15: ffffc9000318eeb8
 console_unlock+0xae/0x290 kernel/printk/printk.c:3063
 vprintk_emit kernel/printk/printk.c:2345 [inline]
 vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2300
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2370
 input_register_device+0xa15/0x1140 drivers/input/input.c:2458
 usb_probe+0x1075/0x17b0 drivers/input/misc/yealink.c:964
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3721
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3721
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2db0/0x4e20 drivers/usb/core/hub.c:5903
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 6.217 msecs
rcu: rcu_preempt kthread starved for 1806 jiffies! g9957 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
yealink 5-1:36.0: urb_irq_callback - urb status -71
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
yealink 5-1:36.0: unexpected response 0
  running task     stack:28752 pid:17    tgid:17    ppid:2      flags:0x00004000
yealink 5-1:36.0: urb_ctl_callback - urb status -71
Call Trace:
 <TASK>
yealink 5-1:36.0: urb_irq_callback - urb status -71
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
yealink 5-1:36.0: urb_irq_callback - urb status -71
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2581
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2000
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2202
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
yealink 5-1:36.0: unexpected response 0
 </TASK>
yealink 5-1:36.0: urb_ctl_callback - urb status -71
rcu: Stack dump where RCU GP kthread last ran:
yealink 5-1:36.0: urb_irq_callback - urb status -71
CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.10.0-rc2-syzkaller #0
yealink 5-1:36.0: unexpected response 0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
yealink 5-1:36.0: urb_ctl_callback - urb status -71
Workqueue: events_unbound toggle_allocation_gate
yealink 5-1:36.0: urb_irq_callback - urb status -71

RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x4e7/0x1420 kernel/smp.c:855
yealink 5-1:36.0: unexpected response 0
Code: 0c 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 bb 37 0c 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 f7 0c 00 00 8b 43 08 31
yealink 5-1:36.0: urb_ctl_callback - urb status -71
RSP: 0018:ffffc90000bc7908 EFLAGS: 00000293
yealink 5-1:36.0: urb_irq_callback - urb status -71

RAX: 0000000000000000 RBX: ffff8880b9344980 RCX: ffffffff8181ad5b
yealink 5-1:36.0: unexpected response 0
RDX: ffff88801c29bc00 RSI: ffffffff8181ad35 RDI: 0000000000000005
yealink 5-1:36.0: urb_ctl_callback - urb status -71
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
yealink 5-1:36.0: urb_irq_callback - urb status -71
R10: 0000000000000001 R11: 0000000000000006 R12: ffffed1017268931
yealink 5-1:36.0: unexpected response 0
R13: 0000000000000001 R14: ffff8880b9344988 R15: ffff8880b923fdc0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
yealink 5-1:36.0: urb_irq_callback - urb status -71
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
yealink 5-1:36.0: unexpected response 0
CR2: 00007f5affdc9490 CR3: 000000000d97a000 CR4: 00000000003506f0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
yealink 5-1:36.0: urb_irq_callback - urb status -71
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
yealink 5-1:36.0: unexpected response 0
Call Trace:
 <IRQ>
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
 </IRQ>
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 <TASK>
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
yealink 5-1:36.0: unexpected response 0
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2069 [inline]
 text_poke_bp_batch+0x561/0x760 arch/x86/kernel/alternative.c:2362
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
 text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2467 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2477
yealink 5-1:36.0: unexpected response 0
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:882
yealink 5-1:36.0: urb_irq_callback - urb status -71
 static_key_disable_cpuslocked+0x154/0x1c0 kernel/jump_label.c:235
yealink 5-1:36.0: unexpected response 0
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 toggle_allocation_gate mm/kfence/core.c:831 [inline]
 toggle_allocation_gate+0x143/0x250 mm/kfence/core.c:818
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
yealink 5-1:36.0: urb_ctl_callback - urb status -71
 </TASK>
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 5-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - usb_submit_urb failed -19
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl_callback - urb status -71
yealink 4-1:36.0: urb_irq_callback - urb status -71
yealink 4-1:36.0: unexpected response 0
yealink 4-1:36.0: urb_ctl

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

