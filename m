Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD84EDA74
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 15:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiCaN0b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiCaN0a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 09:26:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD771F6856;
        Thu, 31 Mar 2022 06:24:43 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A89BA1EC04C1;
        Thu, 31 Mar 2022 15:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648733077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4UNTCP4E6u/c+TqhEnjUuSPSJD4oKFcEuXmrS1RGbf0=;
        b=OMRr8n4oC0Ego10M8thwPdE/z+EvjZU86JIUR8frheC+VZEpjQnTzrpYaTPieL5n8OAVgu
        FtIxo0jr3F/cK0LbwepuOWrMYborpo5astg7yJd5YiCGM1b5HYC2fE+kM8DMUCZ44nbGQH
        rlVYKBKMGVNYlDMEH8pcE7G6mso0zyI=
Date:   Thu, 31 Mar 2022 15:24:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 2/3] x86/mce: Define function to extract ErrorAddr
 from MCA_ADDR
Message-ID: <YkWrlTIK/ZxsQekX@zn.tnic>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 25, 2022 at 01:33:41PM -0600, Smita Koralahalli wrote:
> Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
> will be further refactored to support extended ErrorAddr bits in MCA_ADDR
> in newer AMD processors such as AMD 'Milan'.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20220211223442.254489-2-Smita.KoralahalliChannabasappa@amd.com
> 
> v2:
> 	No change.
> v3:
> 	Rebased on the latest tip tree. No functional changes.
> v4:
> 	Commit description change to be void of the patch linearity.
> ---
>  arch/x86/include/asm/mce.h     |  2 ++
>  arch/x86/kernel/cpu/mce/amd.c  | 14 +++++++++-----
>  arch/x86/kernel/cpu/mce/core.c |  7 ++-----
>  3 files changed, 13 insertions(+), 10 deletions(-)

So if you're going to extract functionality, make sure you extract it
all and keep it all encapsulated in a single function, see below.

Now take this one pls and do your patch 3 ontop by extending the comment
over smca_extract_err_addr() with the new functionality.

Thx.

---
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Date: Fri, 25 Feb 2022 13:33:41 -0600
Subject: [PATCH] x86/mce: Define a function to extract ErrorAddr from MCA_ADDR

Move MCA_ADDR[ErrorAddr] extraction into a separate helper function. This
will be further refactored to support extended ErrorAddr bits in MCA_ADDR
in newer AMD CPUs.

  [ bp: Massage. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 23 ++++++++++++++---------
 arch/x86/kernel/cpu/mce/core.c | 11 +----------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..a1da72941f4e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -337,12 +337,14 @@ extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
+void smca_extract_err_addr(struct mce *m);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
+static inline void smca_extract_err_addr(struct mce *m)			{ }
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1940d305db1c..a1a4a5dc53e8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -722,6 +722,19 @@ bool amd_mce_is_memory_error(struct mce *m)
 	return m->bank == 4 && xec == 0x8;
 }
 
+/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
+void smca_extract_err_addr(struct mce *m)
+{
+	u8 lsb;
+
+	if (!mce_flags.smca)
+		return;
+
+	lsb = (m->addr >> 56) & 0x3f;
+
+	m->addr &= GENMASK_ULL(55, lsb);
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
@@ -736,15 +749,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (m.status & MCI_STATUS_ADDRV) {
 		m.addr = addr;
 
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m.addr >> 56) & 0x3f;
-
-			m.addr &= GENMASK_ULL(55, lsb);
-		}
+		smca_extract_err_addr(&m);
 	}
 
 	if (mce_flags.smca) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d775fcd74e98..5ba2df911d19 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -632,16 +632,7 @@ static noinstr void mce_read_aux(struct mce *m, int i)
 			m->addr >>= shift;
 			m->addr <<= shift;
 		}
-
-		/*
-		 * Extract [55:<lsb>] where lsb is the least significant
-		 * *valid* bit of the address bits.
-		 */
-		if (mce_flags.smca) {
-			u8 lsb = (m->addr >> 56) & 0x3f;
-
-			m->addr &= GENMASK_ULL(55, lsb);
-		}
+		smca_extract_err_addr(m);
 	}
 
 	if (mce_flags.smca) {
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
