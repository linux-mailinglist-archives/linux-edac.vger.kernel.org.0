Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4E7B613B
	for <lists+linux-edac@lfdr.de>; Tue,  3 Oct 2023 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjJCGyv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Oct 2023 02:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjJCGym (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Oct 2023 02:54:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DCDC6;
        Mon,  2 Oct 2023 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316079; x=1727852079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=peVjyb58aU5czBXdVg55hBuRdCD6fg7woOPGVcAZ2Yw=;
  b=UIULJJQxydyE0KknC/tregLv6MahhMflEfNPytigX72Ak6iTQ35hTjVv
   0sFyl5WT5YPGfAdBpJC10bsVlFNRfFH3jFx+aPtgOz8wlH76HEk5W3n8F
   kHo6b96uUmU93o3MamB2VabG8y4aAG6+2DpPfb0UV8bSqEXdp3vNsEerx
   4M9bYdpXHB+2Ziy7/tSd89yFfTu9AISBSbCc5OJ2MOPyrR4oQH2yaSN02
   Oav/SXZB+DN0FT2QQ30vHUgAvrqV6yFcqD68OC/3I1rs37+x+IoXvJbzW
   NJAtIY0X6F39FjZlv7ebeIzLNLNDFYSp/FDXobkTgpoVKdqG8oLf6mVtB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367857954"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367857954"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081900910"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081900910"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 23:54:36 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, jgross@suse.com, ravi.v.shankar@intel.com,
        mhiramat@kernel.org, andrew.cooper3@citrix.com,
        jiangshanlai@gmail.com, nik.borisov@suse.com
Subject: [PATCH v12 05/37] x86/trapnr: Add event type macros to <asm/trapnr.h>
Date:   Mon,  2 Oct 2023 23:24:26 -0700
Message-Id: <20231003062458.23552-6-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003062458.23552-1-xin3.li@intel.com>
References: <20231003062458.23552-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Intel VT-x classifies events into eight different types, which is
inherited by FRED for event identification. As such, event type
becomes a common x86 concept, and should be defined in a common x86
header.

Add event type macros to <asm/trapnr.h>, and use it in <asm/vmx.h>.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v10:
* A few comment fixes and improvements (Andrew Cooper).
---
 arch/x86/include/asm/trapnr.h | 12 ++++++++++++
 arch/x86/include/asm/vmx.h    | 17 +++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
index f5d2325aa0b7..8d1154cdf787 100644
--- a/arch/x86/include/asm/trapnr.h
+++ b/arch/x86/include/asm/trapnr.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_X86_TRAPNR_H
 #define _ASM_X86_TRAPNR_H
 
+/*
+ * Event type codes used by FRED, Intel VT-x and AMD SVM
+ */
+#define EVENT_TYPE_EXTINT	0	// External interrupt
+#define EVENT_TYPE_RESERVED	1
+#define EVENT_TYPE_NMI		2	// NMI
+#define EVENT_TYPE_HWEXC	3	// Hardware originated traps, exceptions
+#define EVENT_TYPE_SWINT	4	// INT n
+#define EVENT_TYPE_PRIV_SWEXC	5	// INT1
+#define EVENT_TYPE_SWEXC	6	// INTO, INT3
+#define EVENT_TYPE_OTHER	7	// FRED SYSCALL/SYSENTER, VT-x MTF
+
 /* Interrupts/Exceptions */
 
 #define X86_TRAP_DE		 0	/* Divide-by-zero */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 0e73616b82f3..4dba17363008 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 #include <uapi/asm/vmx.h>
+#include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
 #define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
@@ -374,14 +375,14 @@ enum vmcs_field {
 #define VECTORING_INFO_DELIVER_CODE_MASK    	INTR_INFO_DELIVER_CODE_MASK
 #define VECTORING_INFO_VALID_MASK       	INTR_INFO_VALID_MASK
 
-#define INTR_TYPE_EXT_INTR              (0 << 8) /* external interrupt */
-#define INTR_TYPE_RESERVED              (1 << 8) /* reserved */
-#define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
-#define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
-#define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
-#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumented */
-#define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
-#define INTR_TYPE_OTHER_EVENT           (7 << 8) /* other event */
+#define INTR_TYPE_EXT_INTR		(EVENT_TYPE_EXTINT << 8)	/* external interrupt */
+#define INTR_TYPE_RESERVED		(EVENT_TYPE_RESERVED << 8)	/* reserved */
+#define INTR_TYPE_NMI_INTR		(EVENT_TYPE_NMI << 8)		/* NMI */
+#define INTR_TYPE_HARD_EXCEPTION	(EVENT_TYPE_HWEXC << 8)		/* processor exception */
+#define INTR_TYPE_SOFT_INTR		(EVENT_TYPE_SWINT << 8)		/* software interrupt */
+#define INTR_TYPE_PRIV_SW_EXCEPTION	(EVENT_TYPE_PRIV_SWEXC << 8)	/* ICE breakpoint */
+#define INTR_TYPE_SOFT_EXCEPTION	(EVENT_TYPE_SWEXC << 8)		/* software exception */
+#define INTR_TYPE_OTHER_EVENT		(EVENT_TYPE_OTHER << 8)		/* other event */
 
 /* GUEST_INTERRUPTIBILITY_INFO flags. */
 #define GUEST_INTR_STATE_STI		0x00000001
-- 
2.34.1

