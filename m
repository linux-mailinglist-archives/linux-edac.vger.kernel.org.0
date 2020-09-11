Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C01C266507
	for <lists+linux-edac@lfdr.de>; Fri, 11 Sep 2020 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIKQuU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Sep 2020 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgIKQt4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Sep 2020 12:49:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D727AC061573;
        Fri, 11 Sep 2020 09:49:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f16220019bfa9b7fca69232.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:2200:19bf:a9b7:fca6:9232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A6901EC0521;
        Fri, 11 Sep 2020 18:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599842989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RzyY9C1JGpGHER/ytX/4pUTj+ozBvWL63vMviIEvYLc=;
        b=NuMotLL9Xr852ERf3Eq2zRu8ujv3Hygx3eI3maPBvxv9CCtwmstZn2DJBrKnM2uzYjmZwE
        8ISKCDvssVa59qEus0uW2xEyo/KI/1wJwQmcqG/OFmFvRRNf71c6kQHdQhPSCzFNRU8zNC
        AfctfR6C2Yu04o8g7zKaHCEHFRcN/BE=
Date:   Fri, 11 Sep 2020 18:49:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Robert Richter <rric@kernel.org>
Subject: [PATCH] EDAC/ghes: Check whether the driver is on the safe list
 correctly
Message-ID: <20200911164950.GB19320@zn.tnic>
References: <20200825130108.2132-1-shiju.jose@huawei.com>
 <20200826085229.GB22390@zn.tnic>
 <cd947c4ec6044521a92e2cc39eae5406@huawei.com>
 <20200911164817.GA19320@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911164817.GA19320@zn.tnic>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

And here's one more I triggered with this driver removing thing:

---
From: Borislav Petkov <bp@suse.de>

With CONFIG_DEBUG_TEST_DRIVER_REMOVE=y, a system would try to probe,
unregister and probe again a driver.

When ghes_edac is attempted to be loaded on a system which is not on
the safe platforms list, ghes_edac_register() would return early. The
unregister counterpart ghes_edac_unregister() would still attempt to
unregister and exit early at the refcount test, leading to the refcount
underflow below.

In order to not do *anything* on the unregister path too, reuse the
force_load parameter and check it on that path too, before fumbling with
the refcount.

  ghes_edac: ghes_edac_register: entry
  ghes_edac: ghes_edac_register: return -ENODEV
  ------------[ cut here ]------------
  refcount_t: underflow; use-after-free.
  WARNING: CPU: 10 PID: 1 at lib/refcount.c:28 refcount_warn_saturate+0xb9/0x100
  Modules linked in:
  CPU: 10 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc4+ #12
  Hardware name: GIGABYTE MZ01-CE1-00/MZ01-CE1-00, BIOS F02 08/29/2018
  RIP: 0010:refcount_warn_saturate+0xb9/0x100
  Code: 82 e8 fb 8f 4d 00 90 0f 0b 90 90 c3 80 3d 55 4c f5 00 00 75 88 c6 05 4c 4c f5 00 01 90 48 c7 c7 d0 8a 10 82 e8 d8 8f 4d 00 90 <0f> 0b 90 90 c3 80 3d 30 4c f5 00 00 0f 85 61 ff ff ff c6 05 23 4c
  RSP: 0018:ffffc90000037d58 EFLAGS: 00010292
  RAX: 0000000000000026 RBX: ffff88840b8da000 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: ffffffff8216b24f RDI: 00000000ffffffff
  RBP: ffff88840c662e00 R08: 0000000000000001 R09: 0000000000000001
  R10: 0000000000000001 R11: 0000000000000046 R12: 0000000000000000
  R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88840ee80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 0000800002211000 CR4: 00000000003506e0
  Call Trace:
   ghes_edac_unregister
   ghes_remove
   platform_drv_remove
   really_probe
   driver_probe_device
   device_driver_attach
   __driver_attach
   ? device_driver_attach
   ? device_driver_attach
   bus_for_each_dev
   bus_add_driver
   driver_register
   ? bert_init
   ghes_init
   do_one_initcall
   ? rcu_read_lock_sched_held
   kernel_init_freeable
   ? rest_init
   kernel_init
   ret_from_fork
   ...
  ghes_edac: ghes_edac_unregister: FALSE, refcount: -1073741824

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/ghes_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index eb6034a6fbbb..dbbefd2798c5 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -508,6 +508,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		if (!force_load && idx < 0)
 			return -ENODEV;
 	} else {
+		force_load = true;
 		idx = 0;
 	}
 
@@ -629,6 +630,9 @@ void ghes_edac_unregister(struct ghes *ghes)
 	struct mem_ctl_info *mci;
 	unsigned long flags;
 
+	if (!force_load)
+		return;
+
 	mutex_lock(&ghes_reg_mutex);
 
 	system_scanned = false;
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
