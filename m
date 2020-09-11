Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DAF2664F3
	for <lists+linux-edac@lfdr.de>; Fri, 11 Sep 2020 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIKQsq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Sep 2020 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIKQsf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Sep 2020 12:48:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE9C061756;
        Fri, 11 Sep 2020 09:48:25 -0700 (PDT)
Received: from zn.tnic (p200300ec2f16220019bfa9b7fca69232.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:2200:19bf:a9b7:fca6:9232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A67D1EC0521;
        Fri, 11 Sep 2020 18:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599842901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=92tB14fCfWJVkqIQFruLbk3LxUVqdaBVnBo1kgSV+Ms=;
        b=M+6tnxuEGVbFFBIGs/5kwKc+7X7OSo97MbBvaUvn4b9rqicaUi34nNzICYrdquHOLDWpJ5
        zZPRE/YAlseA6erSi+VZiZhj0KMJJ8edZfqowtM99pGiQvSm5dYiCr+2bCZScE9OS+8NhV
        8DpakZvJNHXTL4+fGJiMqPqM7JaWf14=
Date:   Fri, 11 Sep 2020 18:48:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Message-ID: <20200911164817.GA19320@zn.tnic>
References: <20200825130108.2132-1-shiju.jose@huawei.com>
 <20200826085229.GB22390@zn.tnic>
 <cd947c4ec6044521a92e2cc39eae5406@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd947c4ec6044521a92e2cc39eae5406@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 27, 2020 at 02:02:27PM +0000, Shiju Jose wrote:
> I tested with your changes and it fixes the issue.  I will send v2.

Btw, I don't know how it managed to work on your machine because even
with this patch, it isn't all fixed because num_dimms needs to be
cleared too, see here:

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 11 Sep 2020 12:55:55 +0200
Subject: [PATCH] EDAC/ghes: Clear scanned data on unload

Commit

  b972fdba8665 ("EDAC/ghes: Fix NULL pointer dereference in ghes_edac_register()")

didn't clear all the information from the scanned system and, more
specifically, left ghes_hw.num_dimms to its previous value. On a
second load (CONFIG_DEBUG_TEST_DRIVER_REMOVE=y), the driver would use
the leftover num_dimms value which is not 0 and thus the 0 check in
enumerate_dimms() will get bypassed and it would go directly to the
pointer deref:

  d = &hw->dimms[hw->num_dimms];

which is, of course, NULL:

  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: 0002 [#1] PREEMPT SMP
  CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc4+ #7
  Hardware name: GIGABYTE MZ01-CE1-00/MZ01-CE1-00, BIOS F02 08/29/2018
  RIP: 0010:enumerate_dimms.cold+0x7b/0x375

Reset the whole ghes_hw on driver unregister so that no stale values are
used on a second system scan.

Fixes: b972fdba8665 ("EDAC/ghes: Fix NULL pointer dereference in ghes_edac_register()")
Cc: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/ghes_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index a6b9c0b2a15c..eb6034a6fbbb 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -632,6 +632,7 @@ void ghes_edac_unregister(struct ghes *ghes)
 	mutex_lock(&ghes_reg_mutex);
 
 	system_scanned = false;
+	memset(&ghes_hw, 0, sizeof(struct ghes_hw_desc));
 
 	if (!refcount_dec_and_test(&ghes_refcount))
 		goto unlock;
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
