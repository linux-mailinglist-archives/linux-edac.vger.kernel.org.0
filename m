Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35081FFB36
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jun 2020 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFRSkt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 18 Jun 2020 14:40:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35622 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgFRSkt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 18 Jun 2020 14:40:49 -0400
Received: from zn.tnic (p200300ec2f0dcf0005555d042158ef9e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:cf00:555:5d04:2158:ef9e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36F6F1EC037C;
        Thu, 18 Jun 2020 20:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592505648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CUWy+kjdFnuZqUSMcGwInqt415HoR6IssKs8IKSM2l8=;
        b=bK3vJCa1x0xcUnR4XQYlYXxjw7+U0OpvUqt+qJg9DmDZh+YSQ9A3Ug4zlcV6qhuj8Vd56A
        eNVyaJOI+nIFnMFDyuCufC0Z0aeMEObWFgMATWpBqFaXKjpVJWwdNyq9mymJKR6nJRizme
        ONKsV06J9LTeW/ZP+StiLhmrpQTQXnI=
Date:   Thu, 18 Jun 2020 20:40:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Anders Andersson <pipatron@gmail.com>
Cc:     linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/amd64: Read back the scrub rate PCI register on F15h
Message-ID: <20200618184041.GE27951@zn.tnic>
References: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
 <20200618175646.GD27951@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618175646.GD27951@zn.tnic>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 18, 2020 at 07:56:46PM +0200, Borislav Petkov wrote:
> Oh, you're manipulating it alright but there's a bug in reporting it.
> Wanna test a patch?

Here it is:

---
From: Borislav Petkov <bp@suse.de>

Commit:

  da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")

added support for F15h, model 0x60 CPUs but in doing so, missed to read
back SCRCTRL PCI config register on F15h CPUs which are *not* model
0x60. Add that read so that doing

  $ cat /sys/devices/system/edac/mc/mc0/sdram_scrub_rate

can show the previously set DRAM scrub rate.

Fixes: da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")
Reported-by: Anders Andersson <pipatron@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> #v4.4..
Link: https://lkml.kernel.org/r/CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com
---
 drivers/edac/amd64_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ef90070a9194..6262f6370c5d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -269,6 +269,8 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 
 		if (pvt->model == 0x60)
 			amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
+		else
+			amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
 	} else {
 		amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
 	}
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
