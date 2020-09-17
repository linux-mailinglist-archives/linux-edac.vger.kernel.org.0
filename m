Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD15B26DF53
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIQPNv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgIQPLN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Sep 2020 11:11:13 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3384C06174A;
        Thu, 17 Sep 2020 08:10:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z26so2802440oih.12;
        Thu, 17 Sep 2020 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B44qJMdY/7TpaOLM5r5sqsm5DAK597ktzOMayNV0bbc=;
        b=UN0XXg7XNfxhWEOSURADvL2uee7V9A9+ty+Q0+IBlExfAeFr6jd+/WJRAmIAYer0qZ
         5SFWklRNrOjh8HQdB/5ykrj0WVroBaFc1Wo/zR47MlOQ/Z7E8tAmvhJ/yCBVvaWoXHCb
         NVoA4q4WoRV0ry7afBg/hWyqF+nskwqW2Y6bA5go9m1N3L6g3TClDZCLX3g+3sWOK6rr
         aBjNNvc/h19f0+cBpu63owocZa+DcB33S3FvapdXfIzuXggQ+typNEqFLUZ0QiAkJVBo
         wUuTxGbQCciMOLDIR1BuDjrnBWoe13wxdrhV5qQfmlRFtRhKA/yTGFgWH8E9G3mwXo4H
         jkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=B44qJMdY/7TpaOLM5r5sqsm5DAK597ktzOMayNV0bbc=;
        b=l3hEMdygE3p0FoGcPVbyqZsVatxim4WL5J0KYrIdLx3rSOWjqJd7Lh+4NpcqD5IEdj
         426hk6B4jvdoGrIZ439OtRLMCscQPtjiXWxupa8w79V5ZGU8JhNp+0zLX3ygBMYHizhX
         jT6v+jUtyoOv3YE2NBWCngXe5bNNXZ0HlO/RtxQvmB2dAPZxaYG0N7B3WgkB4oPoJ7sN
         9un9o5lFxeGgjs2e4Ur2aVJl2woUixmWEdjrtw7rRiVzZDwU6GMF8rH0uddoPpwMvliR
         ARTfAYIX2HgKlNuT8VaG8d2cM5Ov7z18EsJel4aTj1tclUzWYUnUUbigm3fF5Gyez3BP
         nYgQ==
X-Gm-Message-State: AOAM530xNDN98Pa45Nj0vCFM2Zl5o+UDgVz6MopaoNUhdVf5QQnCQUkr
        +tdNT/Rs7gds7/GBoWD3hw==
X-Google-Smtp-Source: ABdhPJxoIQx7WyrR9q+Au04zendCGLfXtH6O56878TTHnejKcHrh/P/R5OE+Wz9YBJeWiVyBIld7IA==
X-Received: by 2002:a05:6808:574:: with SMTP id j20mr6849072oig.158.1600355420451;
        Thu, 17 Sep 2020 08:10:20 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id t7sm111212ooq.0.2020.09.17.08.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 08:10:19 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:594c:cfe8:2636:694a])
        by serve.minyard.net (Postfix) with ESMTPSA id 1ABDE181C2F;
        Thu, 17 Sep 2020 15:10:18 +0000 (UTC)
Date:   Thu, 17 Sep 2020 10:10:17 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Wu Bo <wubo40@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, tony.luck@intel.com,
        bp@alien8.de, tglx@linutronix.de, andi@firstfloor.org,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hidehiro.kawai.ez@hitachi.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: Re: [RFC PATCH] mce: don't not enable IRQ in wait_for_panic()
Message-ID: <20200917151016.GH3674@minyard.net>
Reply-To: minyard@acm.org
References: <1600339070-570840-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600339070-570840-1-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 17, 2020 at 06:37:50PM +0800, Wu Bo wrote:
> In my virtual machine (have 4 cpus), Use mce_inject to inject errors
> into the system. After mce-inject injects an uncorrectable error, 
> there is a probability that the virtual machine is not reset immediately, 
> but hangs for more than 3000 seconds, and appeared unable to 
> handle kernel paging request.
> 
> The analysis reasons are as follows:
> 1) MCE appears on all CPUs, Currently all CPUs are in the NMI interrupt 
>    context. cpu0 is the first to seize the opportunity to run panic 
>    routines, and panic event should stop the other processors before 
>    do ipmi flush_messages(). but cpu1, cpu2 and cpu3 has already 
>    in NMI interrupt context, So the Second NMI interrupt(IPI) 
>    will not be processed again by cpu1, cpu2 and cpu3.
>    At this time, cpu1,cpu2 and cpu3 did not stopped.
> 
> 2) cpu1, cpu2 and cpu3 are waitting for cpu0 to finish the panic process. 
>    if a timeout waiting for other CPUs happened, do wait_for_panic(), 
>    the irq is enabled in the wait_for_panic() function.
> 
> 3) ipmi IRQ occurs on the cpu3, and the cpu0 is doing the panic, 
>    they have the opportunity to call the smi_event_handler() 
>    function concurrently. the ipmi IRQ affects the panic process of cpu0.
> 
>   CPU0                                    CPU3
> 
>    |-nmi_handle do mce_panic               |-nmi_handle do_machine_check
>    |                                       |
>    |-panic()                               |-wait_for_panic()
>    |                                       |
>    |-stop other cpus ---- NMI ------> (Ignore, already in nmi interrupt)
>    |                                       |
>    |-notifier call(ipmi panic_event)       |<-ipmi IRQ occurs
>    |                                       |
>   \|/                                     \|/
> do smi_event_handler()             do smi_event_handler()
> 
> My understanding is that panic() runs with only one operational CPU 
> in the system, other CPUs should be stopped, if other CPUs does not stop, 
> at least IRQ interrupts should be disabled. The x86 architecture, 
> disable IRQ interrupt will not affect IPI when do mce panic, 
> because IPI is notified through NMI interrupt. If my analysis
> is not right, please correct me, thanks.

I'm not sure this is the right fix, but I'm not sure what the right fix
is.  I think this will prevent the other CPUs from being interrupted to
disable them in some cases.

The group at Huawei has an issue with the IPMI driver's panic handling
running while the other CPUs are sitting in "wait_for_panic()" with
interrupt on, and IPMI interrupts interfering with the panic handling,
as they describe above.

It is my understanding that in a panic all other CPUs should be in a
state where they won't do anything and won't take interrupts.  Is that
a correct assumption?  If not, I have some work to do.

-corey

> 
> Steps to reproduce (Have a certain probability):
> 1. # vim /tmp/uncorrected
> CPU 1 BANK 4
> STATUS uncorrected 0xc0
> MCGSTATUS  EIPV MCIP
> ADDR 0x1234
> RIP 0xdeadbabe
> RAISINGCPU 0
> MCGCAP SER CMCI TES 0x6
>  
> 2. # modprobe mce_inject
> 3. # cd /tmp
> 4. # mce-inject uncorrected
> 
> The logs:
> [   55.086670] core: [Hardware Error]: RIP 00:<00000000deadbabe>
> [   55.086671] core: [Hardware Error]: TSC 2e11aff65eea ADDR 1234
> [   55.086673] core: [Hardware Error]: PROCESSOR 0:50654 TIME 1598967234 SOCKET 0 APIC 1 microcode 1
> [   55.086674] core: [Hardware Error]: Run the above through 'mcelog --ascii'
> [   55.086675] core: [Hardware Error]: Machine check: In kernel and no restart IP
> [   55.086676] Kernel panic - not syncing: Fatal machine check
> [   55.086677] kernel fault(0x5) notification starting on CPU 0
> [   55.086682] kernel fault(0x5) notification finished on CPU 0
> [ 4767.947960] BUG: unable to handle kernel paging request at ffff893e40000000
> [ 4767.947962] PGD 13c001067 P4D 13c001067 PUD 0
> [ 4767.947965] Oops: 0000 [#1] SMP PTI
> [ 4767.947967] CPU: 0 PID: 0 Comm: swapper/0
> [ 4767.947968] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-20181220_000000-szxrtosci10000 04/01/2014
> [ 4767.947972] RIP: 0010:kcs_event+0x3c2/0x890 [ipmi_si]
> [ 4767.947974] Code: 74 0e 48 8b 7b 08 31 f6 48 8b 07 e8 98 4f 44 cd 83 bb 24 01
> [ 4767.947975] RSP: 0018:fffffe0000007658 EFLAGS: 00010046
> [ 4767.947976] RAX: 000000000c7c5ff0 RBX: ffff893e3383a000 RCX: 0000000000000000
> [ 4767.947976] RDX: 0000000000000ca2 RSI: 0000000000000000 RDI: ffff893e2fdf6e40
> [ 4767.947977] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000a35
> [ 4767.947978] R10: 0000000000000002 R11: 0000000000000006 R12: 0000000000000000
> [ 4767.947978] R13: fffffe0000007b28 R14: ffff893e34bd0000 R15: 0000000000000000
> [ 4767.947979] FS:  0000000000000000(0000) GS:ffff893e3ec00000(0000) knlGS:0000000000000000
> [ 4767.947980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4767.947981] CR2: ffff893e40000000 CR3: 000000013b20a002 CR4: 00000000003606f0
> [ 4767.947987] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4767.947988] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4767.947988] Call Trace:
> [ 4767.947991]  <NMI>
> [ 4767.947994]  smi_event_handler+0x62/0x660 [ipmi_si]
> [ 4767.947997]  flush_messages+0x10/0x40 [ipmi_si]
> [ 4767.948001]  ipmi_panic_request_and_wait+0xf5/0x100 [ipmi_msghandler]
> [ 4767.948005]  ? symbol_string+0x5a/0x90
> [ 4767.948007]  ? dummy_smi_done_handler+0x10/0x10 [ipmi_msghandler]
> [ 4767.948011]  ? kvm_sched_clock_read+0xd/0x20
> [ 4767.948014]  ? sched_clock+0x5/0x10
> [ 4767.948017]  ? sched_clock_cpu+0xc/0xa0
> [ 4767.948019]  ? kvm_sched_clock_read+0xd/0x20
> [ 4767.948020]  ? sched_clock+0x5/0x10
> [ 4767.948022]  ? sched_clock_cpu+0xc/0xa0
> [ 4767.948026]  ? log_store+0x278/0x2c0
> [ 4767.948027]  ? kvm_sched_clock_read+0xd/0x20
> [ 4767.948029]  ? sched_clock+0x5/0x10
> [ 4767.948030]  ? sched_clock_cpu+0xc/0xa0
> [ 4767.948032]  ? log_store+0x278/0x2c0
> [ 4767.948034]  ? vprintk_emit+0x1dd/0x470
> [ 4767.948035]  ? vprintk_emit+0x234/0x470
> [ 4767.948039]  ? secondary_startup_64+0xb7/0xc0
> [ 4767.948040]  ? vprintk_deferred+0x3a/0x40
> [ 4767.948042]  ? kvm_sched_clock_read+0xd/0x20
> [ 4767.948043]  ? sched_clock+0x5/0x10
> [ 4767.948045]  ? sched_clock_cpu+0xc/0xa0
> [ 4767.948046]  ? log_store+0x278/0x2c0
> [ 4767.948048]  ? vprintk_emit+0x1dd/0x470
> [ 4767.948049]  ? vprintk_emit+0x234/0x470
> [ 4767.948051]  ? vprintk_deferred+0x3a/0x40
> [ 4767.948053]  ? printk+0x52/0x6e
> [ 4767.948055]  ? ipmi_addr_length+0x40/0x40 [ipmi_msghandler]
> [ 4767.948057]  ? panic_event+0x1d4/0x3e0 [ipmi_msghandler]
> [ 4767.948059]  panic_event+0x1d4/0x3e0 [ipmi_msghandler]
> [ 4767.948062]  ? vprintk_deferred+0x3a/0x40
> [ 4767.948063]  ? printk+0x52/0x6e
> [ 4767.948065]  ? cpumask_next+0x17/0x20
> [ 4767.948067]  notifier_call_chain+0x47/0x70
> [ 4767.948070]  panic+0x17d/0x2c2
> [ 4767.948075]  mce_panic+0x216/0x240
> [ 4767.948077]  do_machine_check+0xccd/0xdb0
> [ 4767.948082]  ? native_safe_halt+0xe/0x10
> [ 4767.948086]  raise_exception+0x47/0xb0 [mce_inject]
> [ 4767.948089]  ? __intel_pmu_enable_all+0x47/0x80
> [ 4767.948092]  ? native_apic_msr_write+0x27/0x30
> [ 4767.948093]  ? intel_pmu_handle_irq+0x10d/0x160
> [ 4767.948095]  mce_raise_notify+0x62/0x70 [mce_inject]
> [ 4767.948097]  ? raise_local+0xc0/0xc0 [mce_inject]
> [ 4767.948100]  nmi_handle+0x63/0x110
> [ 4767.948103]  default_do_nmi+0x4e/0x100
> [ 4767.948105]  do_nmi+0x12c/0x190
> [ 4767.948107]  end_repeat_nmi+0x16/0x6a
> 
> Call Trace:
> crash> bt -a
> PID: 0      TASK: ffffffff91c12780  CPU: 0   COMMAND: "swapper/0"
>  #0 [fffffe0000007ba0] panic at ffffffff90ab2e4b
>  #1 [fffffe0000007c28] mce_panic at ffffffff90a37ec6
>  #2 [fffffe0000007c70] do_machine_check at ffffffff90a391ad
>  #3 [fffffe0000007d80] raise_exception at ffffffffc0642117 [mce_inject]
>  #4 [fffffe0000007e48] mce_raise_notify at ffffffffc0642a92 [mce_inject]
>  #5 [fffffe0000007e58] nmi_handle at ffffffff90a21c73
>  #6 [fffffe0000007eb0] default_do_nmi at ffffffff90a2213e
>  #7 [fffffe0000007ed0] do_nmi at ffffffff90a2231c
>  #8 [fffffe0000007ef0] end_repeat_nmi at ffffffff914016b4
>     [exception RIP: native_safe_halt+14]
>     RIP: ffffffff9127223e  RSP: ffffffff91c03e90  RFLAGS: 00000246
>     RAX: ffffffff91271f30  RBX: 0000000000000000  RCX: 0000000000000000
>     RDX: 0000000000000001  RSI: 0000000000000000  RDI: 0000000000000000
>     RBP: 0000000000000000   R8: 00000031237ac86a   R9: 0000000000000001
>     R10: ffff9f7c01397b88  R11: 0000000002a3fabf  R12: 0000000000000000
>     R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #9 [ffffffff91c03e90] native_safe_halt at ffffffff9127223e
>  #10 [ffffffff91c03e90] default_idle at ffffffff91271f4a
>  #11 [ffffffff91c03eb0] do_idle at ffffffff90ae959a
>  #12 [ffffffff91c03ef0] cpu_startup_entry at ffffffff90ae981f
>  #13 [ffffffff91c03f10] start_kernel at ffffffff9219b206
>  #14 [ffffffff91c03f50] secondary_startup_64 at ffffffff90a000e7
> 
> 
> PID: 0      TASK: ffff8b06c77dc740  CPU: 3   COMMAND: "swapper/3"
>      [exception RIP: port_outb+17]
>      RIP: ffffffffc035f1a1  RSP: ffff8b06fad83e90  RFLAGS: 00000002
>      RAX: 0000000000000000  RBX: ffff8b06f08bec00  RCX: 0000000000000010
>      RDX: 0000000000000ca2  RSI: 0000000000000000  RDI: ffff8b06f0bd5e40
>      RBP: 0000000000000001   R8: ffff8b06fad80080   R9: ffff8b06fad84000
>      R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000000000
>      R13: ffff8b06fad83f54  R14: 0000000000000000  R15: 0000000000000000
>      CS: 0010  SS: 0018
>   #0 [ffff8b06fad83e90] kcs_event at ffffffffc035c2c7 [ipmi_si]
>   #1 [ffff8b06fad83eb0] smi_event_handler at ffffffffc035aa3f [ipmi_si]
>   #2 [ffff8b06fad83ee8] ipmi_si_irq_handler at ffffffffc035b0cc [ipmi_si]
>   #3 [ffff8b06fad83f08] __handle_irq_event_percpu at ffffffff9571dfc0
>   #4 [ffff8b06fad83f48] handle_irq_event_percpu at ffffffff9571e140
>   #5 [ffff8b06fad83f70] handle_irq_event at ffffffff9571e1b6
>   #6 [ffff8b06fad83f90] handle_fasteoi_irq at ffffffff95721b42
>   #7 [ffff8b06fad83fb0] handle_irq at ffffffff956209e8
>   #8 [ffff8b06fad83fc0] do_IRQ at ffffffff96001ee9
> --- <IRQ stack> ---
>   #9 [fffffe0000088b98] ret_from_intr at ffffffff96000a8f
>      [exception RIP: delay_tsc+52]
>      RIP: ffffffff95e5fb64  RSP: fffffe0000088c48  RFLAGS: 00000287
>      RAX: 000023fb5edf4b14  RBX: 00000000003e0451  RCX: 000023fb5edf4798
>      RDX: 000000000000037c  RSI: 0000000000000003  RDI: 000000000000095b
>      RBP: fffffe0000088cc0   R8: 0000000000000004   R9: fffffe0000088c5c
>      R10: ffffffff96a05ae0  R11: 0000000000000000  R12: fffffe0000088cb0
>      R13: 0000000000000001  R14: fffffe0000088ef8  R15: ffffffff9666a2f0
>      ORIG_RAX: ffffffffffffffd9  CS: 0010  SS: 0018
>  #10 [fffffe0000088c48] wait_for_panic at ffffffff95637c6c
>  #11 [fffffe0000088c58] mce_timed_out at ffffffff95637f5d
>  #12 [fffffe0000088c70] do_machine_check at ffffffff95638db4
>  #13 [fffffe0000088d80] raise_exception at ffffffffc05b6117 [mce_inject]
>  #14 [fffffe0000088e48] mce_raise_notify at ffffffffc05b6a92 [mce_inject]
>  #15 [fffffe0000088e58] nmi_handle at ffffffff95621c73
>  #16 [fffffe0000088eb0] default_do_nmi at ffffffff9562213e
>  #17 [fffffe0000088ed0] do_nmi at ffffffff9562231c
>  #18 [fffffe0000088ef0] end_repeat_nmi at ffffffff960016b4
>      [exception RIP: native_safe_halt+14]
>      RIP: ffffffff95e7223e  RSP: ffffa222c06a3eb0  RFLAGS: 00000246
>      RAX: ffffffff95e71f30  RBX: 0000000000000003  RCX: 0000000000000001
>      RDX: 0000000000000001  RSI: 0000000000000083  RDI: 0000000000000000
>      RBP: 0000000000000003   R8: 00000018cf7cd9a0   R9: 0000000000000001
>      R10: 0000000000000400  R11: 00000000000003fb  R12: 0000000000000000
>      R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  --- <NMI exception stack> ---
>  #19 [ffffa222c06a3eb0] native_safe_halt at ffffffff95e7223e
>  #20 [ffffa222c06a3eb0] default_idle at ffffffff95e71f4a
>  #21 [ffffa222c06a3ed0] do_idle at ffffffff956e959a
>  #22 [ffffa222c06a3f10] cpu_startup_entry at ffffffff956e981f
>  #23 [ffffa222c06a3f30] start_secondary at ffffffff9564e697
>  #24 [ffffa222c06a3f50] secondary_startup_64 at ffffffff956000e7
> 
> 
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index f43a78b..738f582 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -281,13 +281,12 @@ static void print_mce(struct mce *m)
>  static int fake_panic;
>  static atomic_t mce_fake_panicked;
>  
> -/* Panic in progress. Enable interrupts and wait for final IPI */
> +/* Panic in progress. Wait for final IPI */
>  static void wait_for_panic(void)
>  {
>  	long timeout = PANIC_TIMEOUT*USEC_PER_SEC;
>  
>  	preempt_disable();
> -	local_irq_enable();
>  	while (timeout-- > 0)
>  		udelay(1);
>  	if (panic_timeout == 0)
> -- 
> 1.8.3.1
> 
