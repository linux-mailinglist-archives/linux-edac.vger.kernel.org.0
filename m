Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E761641497
	for <lists+linux-edac@lfdr.de>; Sat,  3 Dec 2022 07:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiLCGtq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 3 Dec 2022 01:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiLCGtY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 3 Dec 2022 01:49:24 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7DEDF633;
        Fri,  2 Dec 2022 22:48:36 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NPL0N3tGdzpW3f;
        Sat,  3 Dec 2022 14:45:08 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 14:48:34 +0800
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
To:     Tony Luck <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com>
 <Y4rO9KYNSHDY5Y1d@agluck-desk3.sc.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <128427de-22b6-eb18-b95a-acb3007f48e6@huawei.com>
Date:   Sat, 3 Dec 2022 14:48:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y4rO9KYNSHDY5Y1d@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022/12/3 12:22, Tony Luck wrote:
> On Sat, Dec 03, 2022 at 10:19:32AM +0800, Miaohe Lin wrote:
>> So I think it's better to have at least one stack dumps. Also what the commit
>> 6e6f0a1f0fa6 ("panic: don't print redundant backtraces on oops") and commit
>> 026ee1f66aaa ("panic: fix stack dump print on direct call to panic()") want
>> to do is avoiding nested stack-dumping to have the original oops data being
>> scrolled away on a 80x50 screen but to have *at least one backtraces*. So
>> this patch acts more like a BUGFIX to ensure having at least one backtraces
>> in mce_panic(). What's your thought, Luck?
> 
> I tried out your patch with the ras-tools test:

ras-tool is really convenient. :)

> 
> # ./einj_mem_uc -f copyout
> 
> which currently causes a panic from the "recoverable" machine check.
> 
> Your patch worked fine:
> 
> [  112.457735] stack backtrace:
> [  112.457736] CPU: 124 PID: 3401 Comm: einj_mem_uc Not tainted 6.1.0-rc7+ #41
> [  112.457738] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYDCRB1.86B.0154.R04.1804231104 04/23/2018
> [  112.457739] Call Trace:
> [  112.457740]  <#MC>
> [  112.457742]  dump_stack_lvl+0x5a/0x78
> [  112.457746]  dump_stack+0x10/0x16
> [  112.457748]  print_usage_bug.part.0+0x1ad/0x1c4
> [  112.457755]  lock_acquire.cold+0x16/0x47
> [  112.457759]  ? down_trylock+0x14/0x40
> [  112.457762]  ? panic+0x180/0x2b9
> [  112.457766]  _raw_spin_lock_irqsave+0x4e/0x70
> [  112.457768]  ? down_trylock+0x14/0x40
> [  112.457771]  down_trylock+0x14/0x40
> [  112.457772]  ? panic+0x180/0x2b9
> [  112.457775]  __down_trylock_console_sem+0x34/0xc0
> [  112.457778]  console_unblank+0x1d/0x90
> [  112.457781]  panic+0x180/0x2b9
> [  112.457788]  mce_panic+0x118/0x1e0
> [  112.457794]  do_machine_check+0x79a/0x890
> [  112.457800]  ? copy_user_enhanced_fast_string+0xa/0x50
> [  112.457810]  exc_machine_check+0x76/0xb0
> [  112.457813]  asm_exc_machine_check+0x1a/0x40
> [  112.457816] RIP: 0010:copy_user_enhanced_fast_string+0xa/0x50
> [  112.457819] Code: d1 f3 a4 31 c0 0f 01 ca c3 cc cc cc cc 8d 0c ca 89 ca eb 2c 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 01 cb 83 fa 40 72 48 89 d1 <f3> a4 31 c0 0f 01 ca c3 cc cc cc cc 89 ca eb 06 66 0f 1f 44 00 00
> [  112.457820] RSP: 0018:ffffb140f789bbd8 EFLAGS: 00050206
> [  112.457822] RAX: 0000000000001000 RBX: ffffb140f789be58 RCX: 0000000000000c00
> [  112.457824] RDX: 0000000000001000 RSI: ffff9133eb3f0400 RDI: 000055c1a36986c0
> [  112.457825] RBP: ffffb140f789bc68 R08: 00000000f789be01 R09: 0000000000001000
> [  112.457827] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000001000
> [  112.457828] R13: ffff9133eb3f0000 R14: 0000000000001000 R15: 0000000000000000
> [  112.457837]  </#MC>
> [  112.457838]  <TASK>
> [  112.457838]  ? _copy_to_iter+0xc3/0x6f0
> [  112.457843]  ? filemap_get_pages+0x9b/0x670
> [  112.457851]  copy_page_to_iter+0x7c/0x1f0
> [  112.457854]  ? find_held_lock+0x31/0x90
> [  112.457858]  filemap_read+0x1ec/0x390
> [  112.457865]  ? __fsnotify_parent+0x10f/0x310
> [  112.457867]  ? aa_file_perm+0x1ab/0x610
> [  112.457875]  generic_file_read_iter+0xf4/0x170
> [  112.457879]  ext4_file_read_iter+0x5b/0x1e0
> [  112.457881]  ? security_file_permission+0x4e/0x60
> [  112.457886]  vfs_read+0x208/0x2e0
> [  112.457895]  ksys_read+0x6d/0xf0
> [  112.457900]  __x64_sys_read+0x19/0x20
> [  112.457902]  do_syscall_64+0x38/0x90
> [  112.457906]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> 
> -Tony

Many thanks for your test, Tony!

Thanks,
Miaohe Lin

