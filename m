Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62F156963
	for <lists+linux-edac@lfdr.de>; Sun,  9 Feb 2020 07:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgBIGKA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 9 Feb 2020 01:10:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:3413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgBIGKA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 9 Feb 2020 01:10:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 22:09:58 -0800
X-IronPort-AV: E=Sophos;i="5.70,420,1574150400"; 
   d="scan'208";a="225816989"
Received: from cheenkex-wtg.gar.corp.intel.com ([10.252.174.208])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 22:09:53 -0800
Message-ID: <cc2c8f19983fb5100fa2692ffec752b127233d4e.camel@linux.intel.com>
Subject: Re: [PATCH] x86, mce, therm_throt: Optimize notifications of
 thermal throttle
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>, bberg@redhat.com,
        bp@alien8.de, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        tony.luck@intel.com
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com
Date:   Sat, 08 Feb 2020 22:09:49 -0800
In-Reply-To: <158120068234.18291.7938335950259651295@skylake-alporthouse-com>
References: <20191111214312.81365-1-srinivas.pandruvada@linux.intel.com>
         <158120068234.18291.7938335950259651295@skylake-alporthouse-com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, 2020-02-08 at 22:24 +0000, Chris Wilson wrote:
> Quoting Srinivas Pandruvada (2019-11-11 21:43:12)
> > +static void throttle_active_work(struct work_struct *work)
> > +{
> > +       struct _thermal_state *state =
> > container_of(to_delayed_work(work),
> > +                                               struct
> > _thermal_state, therm_work);
> > +       unsigned int i, avg, this_cpu = smp_processor_id();
> > +       u64 now = get_jiffies_64();
> > +       bool hot;
> > +       u8 temp;
> 
> <6> [198.901895] [IGT] perf_pmu: starting subtest cpu-hotplug
> <4> [199.088851] IRQ 24: no longer affine to CPU0
> <4> [199.088871] IRQ 25: no longer affine to CPU0
> <6> [199.091679] smpboot: CPU 0 is now offline
> <6> [200.122204] smpboot: Booting Node 0 Processor 0 APIC 0x0
> <6> [200.297267] smpboot: CPU 1 is now offline
> <3> [201.218812] BUG: using smp_processor_id() in preemptible
> [00000000] code: kworker/1:0/17
> <4> [201.218974] caller is throttle_active_work+0x12/0x280
> <4> [201.218985] CPU: 0 PID: 17 Comm: kworker/1:0 Tainted:
> G     U            5.5.0-CI-CI_DRM_7867+ #1
> <4> [201.218991] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS
> V1.12 02/15/2016
> <4> [201.219001] Workqueue: events throttle_active_work
> <4> [201.219009] Call Trace:
> <4> [201.219021]  dump_stack+0x71/0x9b
> <4> [201.219035]  debug_smp_processor_id+0xad/0xb0
> <4> [201.219047]  throttle_active_work+0x12/0x280
> <4> [201.219063]  process_one_work+0x26a/0x620
> <4> [201.219087]  worker_thread+0x37/0x380
> <4> [201.219103]  ? process_one_work+0x620/0x620
> <4> [201.219110]  kthread+0x119/0x130
> <4> [201.219119]  ? kthread_park+0x80/0x80
> <4> [201.219134]  ret_from_fork+0x3a/0x50
> <6> [201.315866] x86: Booting SMP configuration:
> <6> [201.315880] smpboot: Booting Node 0 Processor 1 APIC 0x2
> <4> [201.319814] ------------[ cut here ]------------
> <3> [201.319832] ODEBUG: init active (active state 0) object type:
> timer_list hint: delayed_work_timer_fn+0x0/0x10
> <4> [201.319971] WARNING: CPU: 1 PID: 14 at lib/debugobjects.c:484
> debug_print_object+0x67/0x90
> <4> [201.319977] Modules linked in: vgem snd_hda_codec_hdmi i915
> mei_hdcp x86_pkg_temp_thermal coretemp snd_hda_codec_realtek
> crct10dif_pclmul snd_hda_codec_generic crc32_pclmul snd_hda_intel
> snd_intel_dspcfg snd_hda_codec ghash_clmulni_intel snd_hwdep
> snd_hda_core snd_pcm mei_me r8169 mei realtek lpc_ich prime_numbers
> <4> [201.320023] CPU: 1 PID: 14 Comm: cpuhp/1 Tainted:
> G     U            5.5.0-CI-CI_DRM_7867+ #1
> <4> [201.320029] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS
> V1.12 02/15/2016
> <4> [201.320038] RIP: 0010:debug_print_object+0x67/0x90
> <4> [201.320046] Code: 83 c2 01 8b 4b 14 4c 8b 45 00 89 15 17 f7 8b
> 02 8b 53 10 4c 89 e6 48 c7 c7 b0 ce 31 82 48 8b 14 d5 00 37 07 82 e8
> 89 7b b8 ff <0f> 0b 5b 83 05 33 fb 21 01 01 5d 41 5c c3 83 05 28 fb
> 21 01 01 c3
> <4> [201.320053] RSP: 0000:ffffc900000dbd40 EFLAGS: 00010286
> <4> [201.320060] RAX: 0000000000000000 RBX: ffff888408665d68 RCX:
> 0000000000000001
> <4> [201.320066] RDX: 0000000080000001 RSI: ffff88840d6e30f8 RDI:
> 00000000ffffffff
> <4> [201.320072] RBP: ffffffff826489e0 R08: ffff88840d6e30f8 R09:
> 0000000000000000
> <4> [201.320078] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffffffff822d7bd1
> <4> [201.320084] R13: ffffffff826489e0 R14: ffff88840f898300 R15:
> 0000000000000202
> <4> [201.320091] FS:  0000000000000000(0000)
> GS:ffff88840f880000(0000) knlGS:0000000000000000
> <4> [201.320098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4> [201.320104] CR2: 0000000000000000 CR3: 0000000005610001 CR4:
> 00000000001606e0
> <4> [201.320109] Call Trace:
> <4> [201.320125]  __debug_object_init+0x359/0x510
> <4> [201.320140]  ? _raw_spin_unlock_irqrestore+0x34/0x60
> <4> [201.320156]  ? queue_work_node+0x70/0x70
> <4> [201.320165]  init_timer_key+0x25/0x140
> <4> [201.320180]  ? intel_thermal_supported+0x30/0x30
> <4> [201.320191]  thermal_throttle_online+0xb4/0x260
> <4> [201.320204]  ? unexpected_thermal_interrupt+0x20/0x20
> <4> [201.320213]  cpuhp_invoke_callback+0x9b/0x9d0
> <4> [201.320235]  cpuhp_thread_fun+0x1c8/0x220
> <4> [201.320249]  ? smpboot_thread_fn+0x23/0x280
> <4> [201.320259]  ? smpboot_thread_fn+0x6b/0x280
> <4> [201.320271]  smpboot_thread_fn+0x1d3/0x280
> <4> [201.320288]  ? sort_range+0x20/0x20
> <4> [201.320295]  kthread+0x119/0x130
> <4> [201.320303]  ? kthread_park+0x80/0x80
> <4> [201.320317]  ret_from_fork+0x3a/0x50
> <4> [201.320348] irq event stamp: 4846
> <4> [201.320358] hardirqs last  enabled at (4845):
> [<ffffffff8112dcca>] console_unlock+0x4ba/0x5a0
> <4> [201.320368] hardirqs last disabled at (4846):
> [<ffffffff81001ca0>] trace_hardirqs_off_thunk+0x1a/0x1c
> <4> [201.320379] softirqs last  enabled at (4746):
> [<ffffffff81e00385>] __do_softirq+0x385/0x47f
> <4> [201.320388] softirqs last disabled at (4739):
> [<ffffffff810ba15a>] irq_exit+0xba/0xc0
> <4> [201.320394] ---[ end trace 06576bf31ad2ac2b ]---
> 
> Are we otherwise relying on current->nr_cpus_allowed == 1 here?
No.
I am checking internally, if I can use raw_smp_processor_id() instead.

Thanks,
Srinivas

> (As this section is not within a preempt_disable or local_irq_disable
> region.)
> -Chris

