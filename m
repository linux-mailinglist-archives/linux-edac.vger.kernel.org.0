Return-Path: <linux-edac+bounces-213-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26E8806434
	for <lists+linux-edac@lfdr.de>; Wed,  6 Dec 2023 02:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF33281C6E
	for <lists+linux-edac@lfdr.de>; Wed,  6 Dec 2023 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6BEC4;
	Wed,  6 Dec 2023 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHDFB5xW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C91B5;
	Tue,  5 Dec 2023 17:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701826822; x=1733362822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=84aGtB/DLStDTk9sSVHU7L8uXgDTgViYEQou2kivFBY=;
  b=dHDFB5xWYL4BuIGHCn7sYe3QNtUaFlANmiOYQ12hfleOVOZPY/FPLgcs
   7btnEl64C3rd2hl8iHPB/JX19qE6KgBWm/39xg2f4/nLlTx93Rrx2/Paj
   MeV0ipXRf/+C9WnJ3gJBBdBvrsR/CJsE8UblKPmhavV1wESgX9pvvWncL
   5yG4MZe7/ev346GmRNDrBgwrlsVEvi0BKDc6JJ7eibR2E03wp3eDK0SBA
   4bSLCBRoLCm+5U4mPmwZIaOSWyqJwrtKQMyviF66TTxTeOzXdyeU6eWaC
   RF6KdaoAdwUeI1KZGnJbL4dH3KhQI5jn1y+YdnwNO2WE0WaPBbeNBn2Sm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392853023"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="392853023"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:40:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018406103"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1018406103"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 17:40:06 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: [PATCH] x86/mce: Update references to the Intel SDM
Date: Wed,  6 Dec 2023 01:38:46 +0000
Message-Id: <20231206013846.1859347-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chapter numbers in the SDM are not expected to be stable. In case of
Machine-Check Architecture, it has moved from chapter 15 to chapter 16
with the recent SDM updates.

Instead of changing the chapter number and having to do it again later,
update the comments with 'Chapter name -> "Sub-section name"' to keep it
easy enough to find the specific reference. Note, this intentionally
skips the intermediate section names to avoid making the comments
unnecessarily wordy.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
There are other places in arch/x86 that have stale references to the SDM as
well. I am sending an MCE specific patch first to get a pulse. I can send out
more patches if this approach seems reasonable.

I am open to suggestions, is there a better way to do this? Or should we get
rid of the references all together (expect for really the obscure text that
would be hard to find otherwise)?
---
 arch/x86/include/asm/mce.h     | 2 +-
 arch/x86/kernel/cpu/mce/core.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6de6e1d95952..35fa25eb815b 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -72,7 +72,7 @@
  */
 #define MCACOD		  0xefff     /* MCA Error Code */
 
-/* Architecturally defined codes from SDM Vol. 3B Chapter 15 */
+/* Architecturally defined error codes from SDM: Machine-Check Architecture */
 #define MCACOD_SCRUB	0x00C0	/* 0xC0-0xCF Memory Scrubbing */
 #define MCACOD_SCRUBMSK	0xeff0	/* Skip bit 12 ('F' bit) */
 #define MCACOD_L3WB	0x017A	/* L3 Explicit Writeback */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b397370b4d6..d42122b1afea 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -482,7 +482,8 @@ bool mce_is_memory_error(struct mce *m)
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_ZHAOXIN:
 		/*
-		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
+		 * Intel SDM: Machine-Check Architecture -> "Compound Error
+		 * Codes"
 		 *
 		 * Bit 7 of the MCACOD field of IA32_MCi_STATUS is used for
 		 * indicating a memory error. Bit 8 is used for indicating a
@@ -698,7 +699,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			goto log_it;
 
 		/*
-		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
+		 * Log UCNA (Intel SDM: Machine-Check Architecture -> "UCR
+		 * Error Classification")
 		 * UC == 1 && PCC == 0 && S == 0
 		 */
 		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
-- 
2.34.1


