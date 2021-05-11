Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A013377F42
	for <lists+linux-edac@lfdr.de>; Mon, 10 May 2021 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEJJWx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 May 2021 05:22:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2608 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJJWx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 May 2021 05:22:53 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FdwTG3XDJzQlgc;
        Mon, 10 May 2021 17:18:26 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 10 May 2021 17:21:39 +0800
Date:   Tue, 11 May 2021 09:33:10 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <tony.luck@intel.com>, <fanwentao@huawei.com>,
        <xujing99@huawei.com>
Subject: Re: [RFC PATCH] x86/mce/inject: Fix printk deadlock causing
 mce_timed_out panic
Message-ID: <20210510200424.GA4056660@localhost.localdomain>
References: <20210509053229.GA2477949@localhost.localdomain>
 <YJahM9PaZ7Jefkbi@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YJahM9PaZ7Jefkbi@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, May 08, 2021 at 04:33:23PM +0200, Borislav Petkov wrote:
> On Sun, May 09, 2021 at 01:32:29PM +0800, Lv Ying wrote:
> > The mce-inject SRAO broadcast error injection on 4-core CPU caused mce_timed_out
> > panic as following:
> > Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> 
> A couple of things:
> 
> - how exactly do you do that injection, please give exact steps
>
1. use mca-recover to get error injection physical address

2. use mce-inject inject SRAO error in a for-loop, SRAO error injection file:
CPU 3 BANK 9
STATUS 0xbd000000000000c0
MISC 0x8c
ADDR 0x${test_address}
MCGSTATUS 0x5
MCGCAP 0x000000000F000C14
EXCP

3. after each time SRAO error injection, echo $test_pfn > /sys/kernel/debug/hwpoison/unpoison-pfn
to unpoison the software-unpoisoned page

> - on which kernel, dmesg, .config etc
>
The complete .config file may contain a lot of irrelevant information.
What config items need to be paid attention to?

This panic happend on 4.18 kernel

dmesg before panic:
[ 1349.358753] Memory failure: 0x121f08: already hardware poisoned              
[ 1352.416984] Begin to unregister                                              
[ 1352.416985] Unregister finished                                              
[ 1352.436498] Unpoison: Software-unpoisoned page 0x121f08                      
[ 1353.830712] Begin to register:                                               
[ 1353.830713] ==============================                                   
[ 1354.101088] Triggering MCE exception on CPU 3                                
[ 1354.101112] MCE exception done on CPU 3                                      
[ 1354.101154] mce_notify_irq: 22 callbacks suppressed                          
[ 1354.101154] core: [Hardware Error]: Machine check events logged              
[ 1354.101157] RAS: In fma_memory_offline_notify, ready to call notify chain to isolate page: 0x1252a7, notify type: FMA_MEM_OFFLINE_NOTIFY_SRAO
[ 1354.101159] notify completed true! In Event: Event Number is 2 page is  0x1252a7
..                                                                              
[ 1354.115126] MCE: Killing mca-recover:84546 due to hardware memory corruption fault at 7fb8f7e410dc
[ 1354.115127] Memory failure: 0x1252a7: recovery action for dirty LRU page: Recovered
[ 1354.117751] Triggering MCE exception on CPU 3                                
[ 1354.117771] MCE exception done on CPU 3                                      
[ 1354.117797] core: [Hardware Error]: Machine check events logged              
[ 1354.117799] RAS: In fma_memory_offline_notify, ready to call notify chain to isolate page: 0x1252a7, notify type: FMA_MEM_OFFLINE_NOTIFY_SRAO
[ 1354.117800] notify completed true! In Event: Event Number is 2 page is  0x1252a7
..                                                                              
[ 1354.117801] Memory failure: 0x1252a7: already hardware poisoned              
[ 1357.178800] Begin to unregister                                              
[ 1357.178802] Unregister finished                                              
[ 1357.202572] Unpoison: Software-unpoisoned page 0x1252a7                      
[ 1358.578175] Begin to register:                                               
[ 1358.578176] ==============================                                   
[ 1358.844078] Triggering MCE exception on CPU 3                                
[ 1358.844104] MCE exception done on CPU 3                                      
[ 1358.844141] RAS: In fma_memory_offline_notify, ready to call notify chain to isolate page: 0x12573d, notify type: FMA_MEM_OFFLINE_NOTIFY_SRAO
[ 1358.844143] notify completed true! In Event: Event Number is 2 page is  0x12573d
..                                                                              
[ 1358.856124] MCE: Killing mca-recover:84946 due to hardware memory corruption fault at 7fe11a1102ac
[ 1358.856125] Memory failure: 0x12573d: recovery action for dirty LRU page: Recovered
[ 1358.857741] Triggering MCE exception on CPU 3                                
[ 1360.755011] WARNING: stack recursion on stack type 6                         
[ 1360.755027] ------------[ cut here ]------------  
[ 1360.755028] do_IRQ(): mca-recover has overflown the kernel stack (cur:ffffbc2940a98000,sp:fffffe0000007c50,irq stk top-bottom:ffff9efafac00080-ffff9efafac04000,exception stk top-bottom:fffffe0000009080-fffffe000000b000,ip:wait_for_panic+0xd/0x60)
[ 1360.755028] WARNING: CPU: 0 PID: 84946 at arch/x86/kernel/irq_64.c:73 handle_irq+0x102/0x110[ 1360.755029] Modules linked in: notify_chain_mem(OE) mce_inject ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_filter ebtable_nat ebtable_broute bridge stp llc ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack libcrc32c ip_set nfnetlink ip6table_filter ip6_tables iptable_filter ip_tables kbox(O) sysmonitor(O) kboxdriver(O) sunrpc cirrus drm_kms_helper sb_edac syscopyarea crct10dif_pclmul crc32_pclmul sysfillrect ipmi_ssif sysimgblt ghash_clmulni_intel fb_sys_fops sg virtio_balloon ttm joydev ipmi_si i2c_piix4 ipmi_devintf pcspkr ipmi_msghandler intel_rapl_perf drm ksecurec(O)
[ 1360.755049]  ext4 mbcache jbd2 sd_mod ata_generic crc32c_intel virtio_console virtio_net net_failover failover virtio_scsi ata_piix libata dm_mirror dm_region_hash dm_log dm_mod [last unloaded: hwpoison_inject]
[ 1360.755054] CPU: 0 PID: 84946 Comm: mca-recover Kdump: loaded Tainted: G   M       OE    --------- -  - 4.18.0-147.5.1.6.h429.eulerosv2r10.x86_64 #1
[ 1360.755055] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-20181023_181404-build10b184b172b128 04/01/2014
[ 1360.755055] RIP: 0010:handle_irq+0x102/0x110                                 [ 1360.755056] Code: 00 00 50 65 4c 8b 14 25 80 5c 01 00 57 49 81 c2 e0 0a 00 00 48 c7 c7 f0 b4 a6 a3 4c 89 d6 c6 05 7f 30 3a 01 01 e8 2e 6c 09 00 <0f> 0b 48 83 c4 18 e9 77 ff ff ff 90 90 90 0f 1f 44 00 00 83 ff 02
[ 1360.755056] RSP: 0000:ffff9efafac03fa0 EFLAGS: 00010086                      
[ 1360.755057] RAX: 0000000000000000 RBX: ffff9efaf40a2400 RCX: 0000000000000000
[ 1360.755057] RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff9efafac16a28
[ 1360.755058] RBP: 0000000000000027 R08: ffff9efafac03d10 R09: ffff9efafac16b39
[ 1360.755058] R10: ffff9ef9f6785220 R11: ffff9efafac03d28 R12: fffffe0000007ba8
[ 1360.755058] R13: 0000000000000027 R14: 0000000000000000 R15: 0000000000000000
[ 1360.755059] FS:  00007fe11a103500(0000) GS:ffff9efafac00000(0000) knlGS:0000000000000000
[ 1360.755059] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                
[ 1360.755059] CR2: 00007fe11a1102ac CR3: 00000000643f8006 CR4: 00000000003606f0
[ 1360.755060] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1360.755060] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1360.755060] Call Trace:                                                      
[ 1360.755061]  <IRQ>                                                           
[ 1360.755061]  ? wait_for_panic+0xd/0x60                                       
[ 1360.755061]  do_IRQ+0x49/0xe0                                                
[ 1360.755061]  common_interrupt+0xf/0xf                                        
[ 1360.755062]  </IRQ>                                                          
[ 1360.755062]  <NMI>                                                           
[ 1360.755062] RIP: 0010:wait_for_panic+0xd/0x60                                
[ 1360.755063] Code: c7 c6 e0 a5 a3 a2 e8 92 53 10 00 48 89 df 5b eb 9c 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 53 fb 66 0f 1f 44 00 00 <bb> 40 4b 4c 00 bf c7 10 00 00 e8 b4 2a 84 00 48 83 eb 01 75 f0 e8
[ 1360.755063] RSP: 0000:fffffe0000007c50 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffd8
[ 1360.755064] RAX: 0000000000000001 RBX: ffffffffa3a70980 RCX: 0000000000000000
[ 1360.755065] RDX: 0000000000000174 RSI: ffffffffa3a70980 RDI: fffffe0000007cb8
[ 1360.755065] RBP: fffffe0000007cc0 R08: 0000033bd25f6f78 R09: 0000000000000000
[ 1360.755066] R10: ffffffffa3e099e0 R11: 0000000000000000 R12: fffffe0000007cb8
[ 1360.755066] R13: 0000000000000000 R14: fffffe0000007ef8 R15: 0000000000000004
[ 1360.755066]  mce_timed_out+0x6d/0x90                                         
[ 1360.755067]  do_machine_check+0x734/0xdb0                                    
[ 1360.755067]  ? io_serial_out+0x16/0x20                                       
[ 1360.755067]  raise_exception+0x47/0xb0 [mce_inject]                          
[ 1360.755067]  ? __intel_pmu_enable_all+0x47/0x80                              
[ 1360.755068]  ? native_apic_msr_write+0x27/0x30                               
[ 1360.755068]  ? intel_pmu_handle_irq+0x10d/0x160                              
[ 1360.755068]  mce_raise_notify+0x62/0x70 [mce_inject]                         
[ 1360.755069]  ? raise_local+0xc0/0xc0 [mce_inject]                            
[ 1360.755069]  nmi_handle+0x63/0x110                                           
[ 1360.755069]  default_do_nmi+0x4e/0x100                                       
[ 1360.755069]  do_nmi+0x12c/0x190                                              
[ 1360.755070]  end_repeat_nmi+0x16/0x6a                                        
[ 1360.755070] RIP: 0010:io_serial_out+0x16/0x20                                
[ 1360.755070] Code: 8b 57 08 d3 e6 01 f2 ec 0f b6 c0 c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 0f b6 8f a1 00 00 00 89 d0 8b 57 08 d3 e6 01 f2 ee <c3> 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 0f b6 87 a2 00 00 00
[ 1360.755071] RSP: 0000:ffffbc2940a9bd50 EFLAGS: 00000002                      
[ 1360.755071] RAX: 0000000000000020 RBX: ffffffffa446ffc2 RCX: 0000000000000000
[ 1360.755072] RDX: 00000000000003f8 RSI: 0000000000000000 RDI: ffffffffa46e8600
[ 1360.755072] RBP: ffffffffa46e8600 R08: 0000000000000000 R09: ffffffffa3c5b6a0
[ 1360.755072] R10: 0000000000000000 R11: ffffffffa446ffcd R12: ffffffffa2f4d280
[ 1360.755073] R13: ffffffffa4470017 R14: 0000000000000057 R15: 0000000000000000
[ 1360.755073]  ? wait_for_xmitr+0xa0/0xa0                                      
[ 1360.755073]  ? first_nmi+0x1e/0x1e                                           
[ 1360.755073]  ? wait_for_panic+0xd/0x60                                       
[ 1360.755074]  </NMI>                                                          
[ 1360.755074] ---[ end trace 70cfa9c1a0551b65 ]---                             
[ 1361.789936] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
[ 1361.789937] kernel fault(0x5) notification starting on CPU 1                 
[ 1361.789937] kernel fault(0x5) notification finished on CPU 1  
 
> - anything specific about the hardware you're using
>
The test runs in the Qemu virtual machine.
 
> - always Cc lkml on patches.
> 
Thanks for your suggestion, I have read notes-about-netiquette, and I will add
linux-kernel@vger.kernel.org into Cc list.

Thanks
Lv Ying
