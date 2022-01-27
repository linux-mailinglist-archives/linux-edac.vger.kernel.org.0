Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2049DE98
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 10:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiA0J7Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 04:59:16 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:25450 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0J7P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 27 Jan 2022 04:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643277555; x=1674813555;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=RLiidatky/+Hiquq9tPj8nfmzJZf/NX+3FB9B8gor6M=;
  b=IJnsMJvyLj+FSUvVH+ZPFevfQVNo0jqFwKM6DR/c170PLw6q0SSydadD
   08rVpC8weKyKudpCNn3JRPXXBzu2coW7smRuThvZ6/9tFEZulRJHDak6/
   rbdxbQsHTSdyAfNk1Y4ywr2pS2It7w0UPDEe9Hwlf8Cfl4Iqg+a+8jlZ4
   k=;
X-IronPort-AV: E=Sophos;i="5.88,320,1635206400"; 
   d="scan'208";a="173487821"
Subject: Re: [PATCH 1/4] EDAC: Fix calculation of returned address and next offset in
 edac_align_ptr()
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-39fdda15.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 27 Jan 2022 09:59:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-39fdda15.us-west-2.amazon.com (Postfix) with ESMTPS id 8A27041AA8;
        Thu, 27 Jan 2022 09:59:03 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 27 Jan 2022 09:59:03 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Thu, 27 Jan 2022 09:59:02 +0000
Received: from [192.168.22.106] (10.1.213.23) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.28 via Frontend
 Transport; Thu, 27 Jan 2022 09:58:59 +0000
Message-ID: <9bd8f3c5-2281-8235-9eac-d2c371245a54@amazon.com>
Date:   Thu, 27 Jan 2022 11:58:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>
References: <20220113100622.12783-1-farbere@amazon.com>
 <20220113100622.12783-2-farbere@amazon.com> <YfALFy7LGGIOS2Fv@zn.tnic>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <YfALFy7LGGIOS2Fv@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/25/2022 4:37 PM, Borislav Petkov wrote:
> How exactly did this "become an issue"?
One of the fields in our private-data structure is 'struct notifier_block'
which has a next field of type 'struct notifier_block __rcu *'.
The size of our private-data structure is greater than 8, and it comes after
'struct edac_mc_layer' which has a size that is not zero modulo eight, and
also ends at an address that is not zero modulo eight.
Because of the bug in edac_align_ptr(), our private-data structure which
should have been aligned to 8 wasn't (it was aligned to 4), so
notifier_block was also not aligned to 8, and finally next wasn't aligned
to 8.

> So, please explain more verbosely, a specific example or how I could
> reproduce it, would be even better.

Our al_mc_edac driver calls atomic_notifier_chain_register() on probe, to
add the notifier_block to panic_notifier_list.
We probe the driver more than once, and each time we use the same value for
the priority field in the notifier_block (so the newer notifier_block should
come later in panic_notifier_list).
When the driver is probed for the second time, we get an unable to handle
kernel paging request panic at rcu_assign_pointer() which is called from
notifier_chain_register().
It happens when rcu_assign_pointer() tries to set the unaligned next pointer
from the first probe, to point to the new notifier_block of the second
probe.

Unable to handle kernel paging request at virtual address ffff8013e8037f4c
Mem abort info:
   ESR = 0x96000061
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
Data abort info:
   ISV = 0, ISS = 0x00000061
   CM = 0, WnR = 1
   swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
   [ffff8013e8037f4c] pgd=00000013ffff8003, pud=00680013c0000711
   Internal error: Oops: 96000061 [#1] SMP
   Modules linked in:
   Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
   CPU: 10 PID: 1 Comm: swapper/0 Not tainted 4.19.191 #1016
   Hardware name: Annapurna Labs Alpine V3 EVP (DT)
   pstate: 20000085 (nzCv daIf -PAN -UAO)
   pc : atomic_notifier_chain_register+0x80/0xb8
   lr : atomic_notifier_chain_register+0x38/0xb8
sp : ffff0000097d3b10
x29: ffff0000097d3b10 x28: ffff000009108068
x27: ffff0000095ca000 x26: ffff8013ed0a8744
x25: ffff0000096e3000 x24: ffff000009199000
x23: ffff8013ed016810 x22: ffff8013ed016800
x21: 0000000000000000 x20: ffff8013ed0a8744
x19: ffff0000095ca6d8 x18: ffffffffffffffff
x17: 0000000000000000 x16: 0000000000000000
x15: ffff0000091996c8 x14: 2820564544203a63
x13: 6d5f6c612072656c x12: 6c6f72746e6f6320
x11: 636164655f636d5f x10: ffff000009199918
x9 : ffff000009173018 x8 : ffff00000878ec80
x7 : 676e69766947203a x6 : 00000000000002b1
x5 : 000000000000003f x4 : 0000000000000000
x3 : 000000007fffffff x2 : ffff8013e8037f4c
x1 : 0000000000000096 x0 : ffff0000091bacf8
Call trace:
  atomic_notifier_chain_register+0x80/0xb8
  al_mc_edac_probe+0x224/0x468
  platform_drv_probe+0x58/0xa8
really_probe+0x2cc/0x3b8
driver_probe_device+0x12c/0x148
__driver_attach+0x148/0x150
bus_for_each_dev+0x84/0xd8
driver_attach+0x30/0x40
bus_add_driver+0x174/0x2a8
driver_register+0x64/0x110
__platform_driver_register+0x54/0x60
al_mc_edac_driver_init+0x20/0x28
do_one_initcall+0x54/0x208
kernel_init_freeable+0x294/0x354
kernel_init+0x18/0x118
ret_from_fork+0x10/0x18
Code: 91002002 f9400400 b5ffff60 f9000680 (c89ffc54)
---[ end trace dba8c8c6291afa5b ]---
Kernel panic - not syncing: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x0,20006008
Memory Limit: none
---[ end Kernel panic - not syncing: Fatal exception ]---

