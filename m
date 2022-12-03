Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B4641418
	for <lists+linux-edac@lfdr.de>; Sat,  3 Dec 2022 05:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLCEWQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Dec 2022 23:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLCEWP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Dec 2022 23:22:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA16FE98A0;
        Fri,  2 Dec 2022 20:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670041334; x=1701577334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nS19wZMXuogA8fQM9KRXarEBYR3zkqmlyM+y38ureo0=;
  b=UqDUClWzmh6pCaz5DLE1yRz1PqjxQbW9XFA43a4SLMK2A1RmI8j+bqAi
   6dK8frkdPSROJ9+ohpv0Vy50j4swf+dOAdUo2aIG9urkQx5m7KwoP9XJH
   YTj+W2+YMAsvvLE6OQ053RYuOUAYJFwPAZ8olTWCkCRhc5BMX/zZz89zk
   Vy8xiEQq00ndPDjhsjdctRYV3uIm/nPZLmC5wIb0Ge8L9zI//8ZRcmCx8
   e7Bal0a0Co0SEpzWksrdUfgJIsV/fb++jGPJvytxArqIooMw2+61L1KnA
   OZ7LJLx8MhZNP3S2BHpf5FIfxKn/xnPF7wFFoSavLHUIwtwfa7WlrtzdC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="343069416"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="343069416"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 20:22:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="734035842"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="734035842"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 20:22:13 -0800
Date:   Fri, 2 Dec 2022 20:22:12 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
Message-ID: <Y4rO9KYNSHDY5Y1d@agluck-desk3.sc.intel.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Dec 03, 2022 at 10:19:32AM +0800, Miaohe Lin wrote:
> So I think it's better to have at least one stack dumps. Also what the commit
> 6e6f0a1f0fa6 ("panic: don't print redundant backtraces on oops") and commit
> 026ee1f66aaa ("panic: fix stack dump print on direct call to panic()") want
> to do is avoiding nested stack-dumping to have the original oops data being
> scrolled away on a 80x50 screen but to have *at least one backtraces*. So
> this patch acts more like a BUGFIX to ensure having at least one backtraces
> in mce_panic(). What's your thought, Luck?

I tried out your patch with the ras-tools test:

# ./einj_mem_uc -f copyout

which currently causes a panic from the "recoverable" machine check.

Your patch worked fine:

[  112.457735] stack backtrace:
[  112.457736] CPU: 124 PID: 3401 Comm: einj_mem_uc Not tainted 6.1.0-rc7+ #41
[  112.457738] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0154.R04.1804231104 04/23/2018
[  112.457739] Call Trace:
[  112.457740]  <#MC>
[  112.457742]  dump_stack_lvl+0x5a/0x78
[  112.457746]  dump_stack+0x10/0x16
[  112.457748]  print_usage_bug.part.0+0x1ad/0x1c4
[  112.457755]  lock_acquire.cold+0x16/0x47
[  112.457759]  ? down_trylock+0x14/0x40
[  112.457762]  ? panic+0x180/0x2b9
[  112.457766]  _raw_spin_lock_irqsave+0x4e/0x70
[  112.457768]  ? down_trylock+0x14/0x40
[  112.457771]  down_trylock+0x14/0x40
[  112.457772]  ? panic+0x180/0x2b9
[  112.457775]  __down_trylock_console_sem+0x34/0xc0
[  112.457778]  console_unblank+0x1d/0x90
[  112.457781]  panic+0x180/0x2b9
[  112.457788]  mce_panic+0x118/0x1e0
[  112.457794]  do_machine_check+0x79a/0x890
[  112.457800]  ? copy_user_enhanced_fast_string+0xa/0x50
[  112.457810]  exc_machine_check+0x76/0xb0
[  112.457813]  asm_exc_machine_check+0x1a/0x40
[  112.457816] RIP: 0010:copy_user_enhanced_fast_string+0xa/0x50
[  112.457819] Code: d1 f3 a4 31 c0 0f 01 ca c3 cc cc cc cc 8d 0c ca 89 ca eb 2c 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 01 cb 83 fa 40 72 48 89 d1 <f3> a4 31 c0 0f 01 ca c3 cc cc cc cc 89 ca eb 06 66 0f 1f 44 00 00
[  112.457820] RSP: 0018:ffffb140f789bbd8 EFLAGS: 00050206
[  112.457822] RAX: 0000000000001000 RBX: ffffb140f789be58 RCX: 0000000000000c00
[  112.457824] RDX: 0000000000001000 RSI: ffff9133eb3f0400 RDI: 000055c1a36986c0
[  112.457825] RBP: ffffb140f789bc68 R08: 00000000f789be01 R09: 0000000000001000
[  112.457827] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000001000
[  112.457828] R13: ffff9133eb3f0000 R14: 0000000000001000 R15: 0000000000000000
[  112.457837]  </#MC>
[  112.457838]  <TASK>
[  112.457838]  ? _copy_to_iter+0xc3/0x6f0
[  112.457843]  ? filemap_get_pages+0x9b/0x670
[  112.457851]  copy_page_to_iter+0x7c/0x1f0
[  112.457854]  ? find_held_lock+0x31/0x90
[  112.457858]  filemap_read+0x1ec/0x390
[  112.457865]  ? __fsnotify_parent+0x10f/0x310
[  112.457867]  ? aa_file_perm+0x1ab/0x610
[  112.457875]  generic_file_read_iter+0xf4/0x170
[  112.457879]  ext4_file_read_iter+0x5b/0x1e0
[  112.457881]  ? security_file_permission+0x4e/0x60
[  112.457886]  vfs_read+0x208/0x2e0
[  112.457895]  ksys_read+0x6d/0xf0
[  112.457900]  __x64_sys_read+0x19/0x20
[  112.457902]  do_syscall_64+0x38/0x90
[  112.457906]  entry_SYSCALL_64_after_hwframe+0x63/0xcd


Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
