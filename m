Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7659B30F
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2019 17:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfHWPLQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Aug 2019 11:11:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfHWPLQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Aug 2019 11:11:16 -0400
Received: from zn.tnic (p200300EC2F0BC5003C7EECCB3B09C289.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c500:3c7e:eccb:3b09:c289])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAC461EC0965;
        Fri, 23 Aug 2019 17:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566573075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b5OajGcKlUzWLv0D9hOietO7TBDXlB4QeydeInAiM1U=;
        b=En6rZKh6gnwK0ugWDw0d5WdJ4gYJH+oyeDp0Knj5UAuniBHv0myYEVjakE4wm3yIIqLDuc
        Q8VjltThviuuIT0oLjHC7w+wn7C4bbtArHCOsm9jwTy5aTf+U9AC6leYqdFAhMdeMWFgtL
        etOaAVJlys5onganwKUPjhIL5sDN6CI=
Date:   Fri, 23 Aug 2019 17:11:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Message-ID: <20190823151110.GB28379@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-8-Yazen.Ghannam@amd.com>
 <20190823112628.GA28379@zn.tnic>
 <SN6PR12MB2639B5F8445D90154BA8860AF8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639B5F8445D90154BA8860AF8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 23, 2019 at 01:27:50PM +0000, Ghannam, Yazen wrote:
> Yes, sorry I missed that.

Ok, fixed. Version below. So I'm queueing all patches up to and
including this one. I have some more comments for the remaining ones but
they can wait.

Thx.

---
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 22 Aug 2019 00:00:02 +0000
Subject: [PATCH] EDAC/amd64: Support asymmetric dual-rank DIMMs

Future AMD systems will support asymmetric dual-rank DIMMs. These are
DIMMs where the ranks are of different sizes.

The even rank will use the Primary Even Chip Select registers and the
odd rank will use the Secondary Odd Chip Select registers.

Recognize if a Secondary Odd Chip Select is being used. Use the
Secondary Odd Address Mask when calculating the chip select size.

 [ bp: move csrow_sec_enabled() to the header, fix CS_ODD define and
   tone-down the capitalized words spelling. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190821235938.118710-8-Yazen.Ghannam@amd.com
---
 drivers/edac/amd64_edac.c | 16 +++++++++++++---
 drivers/edac/amd64_edac.h |  3 ++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 23251bba8eb6..18ba9c898389 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -790,9 +790,11 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 
 #define CS_EVEN_PRIMARY		BIT(0)
 #define CS_ODD_PRIMARY		BIT(1)
+#define CS_EVEN_SECONDARY	BIT(2)
+#define CS_ODD_SECONDARY	BIT(3)
 
-#define CS_EVEN			CS_EVEN_PRIMARY
-#define CS_ODD			CS_ODD_PRIMARY
+#define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
+#define CS_ODD			(CS_ODD_PRIMARY | CS_ODD_SECONDARY)
 
 static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
@@ -804,6 +806,10 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_PRIMARY;
 
+	/* Asymmetric dual-rank DIMM support. */
+	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
+		cs_mode |= CS_ODD_SECONDARY;
+
 	return cs_mode;
 }
 
@@ -1600,7 +1606,11 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	 */
 	dimm = csrow_nr >> 1;
 
-	addr_mask_orig = pvt->csels[umc].csmasks[dimm];
+	/* Asymmetric dual-rank DIMM support. */
+	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
+		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
+	else
+		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 68f12de6e654..8addc4d95577 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -169,7 +169,8 @@
 #define DCSM0				0x60
 #define DCSM1				0x160
 
-#define csrow_enabled(i, dct, pvt)	((pvt)->csels[(dct)].csbases[(i)] & DCSB_CS_ENABLE)
+#define csrow_enabled(i, dct, pvt)	((pvt)->csels[(dct)].csbases[(i)]     & DCSB_CS_ENABLE)
+#define csrow_sec_enabled(i, dct, pvt)	((pvt)->csels[(dct)].csbases_sec[(i)] & DCSB_CS_ENABLE)
 
 #define DRAM_CONTROL			0x78
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
