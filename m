Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8683E5385F5
	for <lists+linux-edac@lfdr.de>; Mon, 30 May 2022 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiE3QQc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 May 2022 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiE3QQb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 May 2022 12:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2B097B9E7
        for <linux-edac@vger.kernel.org>; Mon, 30 May 2022 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653927389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=raXCefhJnjzd6mraUSou6h7qOVXvwwBKOs2CvERjEjE=;
        b=Cu1KU38aiFPe2CaBQwY5x2r77nt/29C/NltCzgLKm0+Gweb5tR+K5UQ6k281J2hmVs8xS2
        80W6sGvfMMkGP4Bp9t+Z+1vEFIdMJv/KDPeakTkPrTeaEq1EK7MHQu0zQF79ytRBTlop2D
        8p5aqCU2THEfY8m5ddAmRX/D2D7ZyEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-rUfYDHeYOfSiEqITVW8cmw-1; Mon, 30 May 2022 12:16:25 -0400
X-MC-Unique: rUfYDHeYOfSiEqITVW8cmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3F2E8041AB;
        Mon, 30 May 2022 16:16:24 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D27162166B2F;
        Mon, 30 May 2022 16:16:24 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 24UGGO5s027306;
        Mon, 30 May 2022 12:16:24 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 24UGGOZ4027297;
        Mon, 30 May 2022 12:16:24 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 30 May 2022 12:16:24 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Warnings when suspending to disk
Message-ID: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi

The commit 7f99cb5e60392fc3494c610776e733b68784280c ("x86/CPU/AMD: Use 
default_groups in kobj_type") causes the following warnings to be printed 
during suspend to disk and resume from disk. There are many of these 
warnings, 3 for each core.

The machine is two six-core Opterons 8435.

Mikulas


[   31.349584] PM: hibernation: hibernation entry
[   31.350319] Filesystems sync: 0.000 seconds
[   31.350417] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   31.351994] OOM killer disabled.
[   31.357889] PM: hibernation: Preallocating image memory
[   34.791852] PM: hibernation: Allocated 735563 pages for snapshot
[   34.792065] PM: hibernation: Allocated 2942252 kbytes in 3.43 seconds (857.79 MB/s)
[   34.792296] Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
[   34.793791] printk: Suspending console(s) (use no_console_suspend to debug)
[   34.795159] serial 00:03: disabled
[   34.795248] serial 00:02: disabled
[   34.824316] mptbase: ioc0: pci-suspend: pdev=0x00000000f4bc4e1a, slot=0000:02:06.0, Entering operating state [D3]
[   35.470390] amdgpu 0000:07:00.0: amdgpu: BACO reset
[   35.533783] Disabling non-boot CPUs ...
[   35.535798] smpboot: CPU 1 is now offline
[   35.537754] ------------[ cut here ]------------
[   35.537764] kernfs: can not remove 'threshold_limit', no directory
[   35.537789] WARNING: CPU: 2 PID: 21 at fs/kernfs/dir.c:1555 kernfs_remove_by_name_ns+0xa9/0xc0
[   35.537812] Modules linked in: ipt_REJECT nf_reject_ipv4 hid_generic nft_chain_nat xt_MASQUERADE xt_tcpudp nft_compat nf_tables libcrc32c crc32c_generic nfnetlink snd_usb_audio snd_hwdep snd_usbmidi_lib snd_rawmidi snd_pcm snd_timer usbhid snd hid soundcore cpufreq_userspace cpufreq_ondemand cpufreq_powersave cpufreq_conservative bridge stp llc ohci_pci amd64_edac edac_mce_amd kvm_amd tg3 ohci_hcd ehci_pci ptp ehci_hcd e100 pps_core kvm mii usbcore pata_serverworks k10temp irqbypass libphy i2c_piix4 usb_common pcspkr rtc_cmos floppy acpi_cpufreq processor button mousedev dmi_sysfs nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 lm85 hwmon_vid fuse configfs ip_tables x_tables ipv6 autofs4 spadfs amdgpu drm_ttm_helper ttm hwmon gpu_sched i2c_algo_bit drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm evdev fb font fbdev drm_panel_orientation_quirks backlight
[   35.537994] CPU: 2 PID: 21 Comm: cpuhp/2 Not tainted 5.17.0-rc2 #1
[   35.538003] Hardware name: empty empty/S3992-E, BIOS 'V1.06   ' 06/09/2009
[   35.538008] RIP: 0010:kernfs_remove_by_name_ns+0xa9/0xc0
[   35.538052] Code: 4c 8b 6c 24 10 4c 8b 74 24 18 48 83 c4 20 c3 4c 89 e7 e8 ba d1 de ff b8 fe ff ff ff eb d9 48 c7 c7 70 6f d6 81 e8 95 30 31 00 <0f> 0b b8 fe ff ff ff eb c4 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
[   35.538060] RSP: 0018:ffff8881036d7d80 EFLAGS: 00010282
[   35.538067] RAX: 0000000000000036 RBX: ffffffff820320c8 RCX: ffff88900fc9b3c8
[   35.538071] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88900fc9b3c0
[   35.538076] RBP: 0000000000000000 R08: ffffffff8204da60 R09: 64206f6e202c2774
[   35.538080] R10: 726964206f6e202c R11: 2774696d696c5f64 R12: ffffffff81c0d820
[   35.538084] R13: ffffffff81d3b89a R14: ffff888103e04800 R15: ffff88900fd751f0
[   35.538089] FS:  0000000000000000(0000) GS:ffff88900fc80000(0000) knlGS:0000000000000000
[   35.538095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.538099] CR2: 00007f8bc5d4f4b0 CR3: 0000000150296000 CR4: 00000000000006e0
[   35.538104] Call Trace:
[   35.538110]  <TASK>
[   35.538115]  remove_files+0x26/0x60
[   35.538124]  sysfs_remove_group+0x41/0xa0
[   35.538131]  sysfs_remove_groups+0x23/0x40
[   35.538137]  __kobject_del+0x1b/0xa0
[   35.538146]  kobject_del+0xf/0x20
[   35.538153]  mce_threshold_remove_device+0xd4/0x1c0
[   35.538164]  mce_cpu_pre_down+0x5c/0x70
[   35.538170]  ? mce_enable_ce+0x40/0x40
[   35.538176]  cpuhp_invoke_callback+0x2bd/0x460
[   35.538185]  ? __schedule+0x232/0x630
[   35.538195]  ? smpboot_register_percpu_thread+0xd0/0xd0
[   35.538204]  cpuhp_thread_fun+0x75/0x120
[   35.538212]  smpboot_thread_fn+0xc3/0x1c0
[   35.538220]  kthread+0xd1/0x100
[   35.538229]  ? kthread_complete_and_exit+0x20/0x20
[   35.538238]  ret_from_fork+0x1f/0x30
[   35.538248]  </TASK>
[   35.538250] ---[ end trace 0000000000000000 ]---
[   35.538254] ------------[ cut here ]------------
[   35.538256] kernfs: can not remove 'error_count', no directory
[   35.538271] WARNING: CPU: 2 PID: 21 at fs/kernfs/dir.c:1555 kernfs_remove_by_name_ns+0xa9/0xc0
[   35.538283] Modules linked in: ipt_REJECT nf_reject_ipv4 hid_generic nft_chain_nat xt_MASQUERADE xt_tcpudp nft_compat nf_tables libcrc32c crc32c_generic nfnetlink snd_usb_audio snd_hwdep snd_usbmidi_lib snd_rawmidi snd_pcm snd_timer usbhid snd hid soundcore cpufreq_userspace cpufreq_ondemand cpufreq_powersave cpufreq_conservative bridge stp llc ohci_pci amd64_edac edac_mce_amd kvm_amd tg3 ohci_hcd ehci_pci ptp ehci_hcd e100 pps_core kvm mii usbcore pata_serverworks k10temp irqbypass libphy i2c_piix4 usb_common pcspkr rtc_cmos floppy acpi_cpufreq processor button mousedev dmi_sysfs nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 lm85 hwmon_vid fuse configfs ip_tables x_tables ipv6 autofs4 spadfs amdgpu drm_ttm_helper ttm hwmon gpu_sched i2c_algo_bit drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm evdev fb font fbdev drm_panel_orientation_quirks backlight
[   35.538429] CPU: 2 PID: 21 Comm: cpuhp/2 Tainted: G        W         5.17.0-rc2 #1
[   35.538436] Hardware name: empty empty/S3992-E, BIOS 'V1.06   ' 06/09/2009
[   35.538438] RIP: 0010:kernfs_remove_by_name_ns+0xa9/0xc0
[   35.538447] Code: 4c 8b 6c 24 10 4c 8b 74 24 18 48 83 c4 20 c3 4c 89 e7 e8 ba d1 de ff b8 fe ff ff ff eb d9 48 c7 c7 70 6f d6 81 e8 95 30 31 00 <0f> 0b b8 fe ff ff ff eb c4 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
[   35.538453] RSP: 0018:ffff8881036d7d80 EFLAGS: 00010282
[   35.538459] RAX: 0000000000000032 RBX: ffffffff820320d0 RCX: ffff88900fc9b3c8
[   35.538463] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88900fc9b3c0
[   35.538467] RBP: 0000000000000000 R08: ffffffff8204da60 R09: 64206f6e202c2774
[   35.538471] R10: 6f74636572696420 R11: 6f6e202c27746e75 R12: ffffffff81c0d820
[   35.538475] R13: ffffffff81d3b8bb R14: ffff888103e04800 R15: ffff88900fd751f0
[   35.538479] FS:  0000000000000000(0000) GS:ffff88900fc80000(0000) knlGS:0000000000000000
[   35.538484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.538488] CR2: 00007f8bc5d4f4b0 CR3: 0000000150296000 CR4: 00000000000006e0
[   35.538493] Call Trace:
[   35.538494]  <TASK>
[   35.538497]  remove_files+0x26/0x60
[   35.538503]  sysfs_remove_group+0x41/0xa0
[   35.538509]  sysfs_remove_groups+0x23/0x40
[   35.538515]  __kobject_del+0x1b/0xa0
[   35.538521]  kobject_del+0xf/0x20
[   35.538527]  mce_threshold_remove_device+0xd4/0x1c0
[   35.538535]  mce_cpu_pre_down+0x5c/0x70
[   35.538540]  ? mce_enable_ce+0x40/0x40
[   35.538545]  cpuhp_invoke_callback+0x2bd/0x460
[   35.538553]  ? __schedule+0x232/0x630
[   35.538562]  ? smpboot_register_percpu_thread+0xd0/0xd0
[   35.538569]  cpuhp_thread_fun+0x75/0x120
[   35.538577]  smpboot_thread_fn+0xc3/0x1c0
[   35.538585]  kthread+0xd1/0x100
[   35.538592]  ? kthread_complete_and_exit+0x20/0x20
[   35.538601]  ret_from_fork+0x1f/0x30
[   35.538609]  </TASK>
[   35.538611] ---[ end trace 0000000000000000 ]---
[   35.538614] ------------[ cut here ]------------
[   35.538615] kernfs: can not remove 'interrupt_enable', no directory
[   35.538629] WARNING: CPU: 2 PID: 21 at fs/kernfs/dir.c:1555 kernfs_remove_by_name_ns+0xa9/0xc0
[   35.538641] Modules linked in: ipt_REJECT nf_reject_ipv4 hid_generic nft_chain_nat xt_MASQUERADE xt_tcpudp nft_compat nf_tables libcrc32c crc32c_generic nfnetlink snd_usb_audio snd_hwdep snd_usbmidi_lib snd_rawmidi snd_pcm snd_timer usbhid snd hid soundcore cpufreq_userspace cpufreq_ondemand cpufreq_powersave cpufreq_conservative bridge stp llc ohci_pci amd64_edac edac_mce_amd kvm_amd tg3 ohci_hcd ehci_pci ptp ehci_hcd e100 pps_core kvm mii usbcore pata_serverworks k10temp irqbypass libphy i2c_piix4 usb_common pcspkr rtc_cmos floppy acpi_cpufreq processor button mousedev dmi_sysfs nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 lm85 hwmon_vid fuse configfs ip_tables x_tables ipv6 autofs4 spadfs amdgpu drm_ttm_helper ttm hwmon gpu_sched i2c_algo_bit drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm evdev fb font fbdev drm_panel_orientation_quirks backlight
[   35.538785] CPU: 2 PID: 21 Comm: cpuhp/2 Tainted: G        W         5.17.0-rc2 #1
[   35.538791] Hardware name: empty empty/S3992-E, BIOS 'V1.06   ' 06/09/2009
[   35.538794] RIP: 0010:kernfs_remove_by_name_ns+0xa9/0xc0
[   35.538803] Code: 4c 8b 6c 24 10 4c 8b 74 24 18 48 83 c4 20 c3 4c 89 e7 e8 ba d1 de ff b8 fe ff ff ff eb d9 48 c7 c7 70 6f d6 81 e8 95 30 31 00 <0f> 0b b8 fe ff ff ff eb c4 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
[   35.538808] RSP: 0018:ffff8881036d7d80 EFLAGS: 00010282
[   35.538813] RAX: 0000000000000037 RBX: ffffffff820320d8 RCX: ffff88900fc9b3c8
[   35.538817] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff88900fc9b3c0
[   35.538821] RBP: 0000000000000000 R08: ffffffff8204da60 R09: 64206f6e202c2765
[   35.538825] R10: 6964206f6e202c27 R11: 656c62616e655f74 R12: ffffffff81c0d820
[   35.538829] R13: ffffffff81d3b8aa R14: ffff888103e04800 R15: ffff88900fd751f0
[   35.538833] FS:  0000000000000000(0000) GS:ffff88900fc80000(0000) knlGS:0000000000000000
[   35.538838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.538842] CR2: 00007f8bc5d4f4b0 CR3: 0000000150296000 CR4: 00000000000006e0
[   35.538846] Call Trace:
[   35.538848]  <TASK>
[   35.538850]  remove_files+0x26/0x60
[   35.538856]  sysfs_remove_group+0x41/0xa0
[   35.538862]  sysfs_remove_groups+0x23/0x40
[   35.538868]  __kobject_del+0x1b/0xa0
[   35.538874]  kobject_del+0xf/0x20
[   35.538880]  mce_threshold_remove_device+0xd4/0x1c0
[   35.538887]  mce_cpu_pre_down+0x5c/0x70
[   35.538893]  ? mce_enable_ce+0x40/0x40
[   35.538897]  cpuhp_invoke_callback+0x2bd/0x460
[   35.538905]  ? __schedule+0x232/0x630
[   35.538914]  ? smpboot_register_percpu_thread+0xd0/0xd0
[   35.538922]  cpuhp_thread_fun+0x75/0x120
[   35.538929]  smpboot_thread_fn+0xc3/0x1c0
[   35.538937]  kthread+0xd1/0x100
[   35.538944]  ? kthread_complete_and_exit+0x20/0x20
[   35.538953]  ret_from_fork+0x1f/0x30
[   35.538961]  </TASK>
[   35.538963] ---[ end trace 0000000000000000 ]---

