Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2495E7B6151
	for <lists+linux-edac@lfdr.de>; Tue,  3 Oct 2023 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbjJCGzC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Oct 2023 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbjJCGyy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Oct 2023 02:54:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBBB115;
        Mon,  2 Oct 2023 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316087; x=1727852087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbR2wCTkousO/IPIjdDUqT7zLHmXpw3IGG9LN/Z2MXU=;
  b=AT4vIlyTKisB+dhSHYdibnuOBRutW7Sel+S7aORQl8GzfTUxN9MJC7Y6
   AuLKJ/1vh4kTMfPiubh/Xhyn0yHGzQKaq47bRVHbqS+Zkix54bwXxoo2m
   80Y20UqaJW7lpBztTa1l+molWhwG77Aih9qZveCPVDFl6dqBeJMCuG4bU
   zN2+wi572338gPnISYW75dmp4bbZPj7Q18NFgboUTzeVN/fbj18E3WSYs
   Ao7BjB87UVxn9ZG5oygijfE3TDDz96JuPN6Rs/o2HKRskGW8v8unMDzDQ
   Z3hELrsPDYUoIXDc93FbHkukAySmeoKEIzbsO79H2nMysDk5pKg0yCw2c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367858099"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367858099"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081900946"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081900946"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 23:54:43 -0700
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
Subject: [PATCH v12 17/37] x86/fred: Add a new header file for FRED definitions
Date:   Mon,  2 Oct 2023 23:24:38 -0700
Message-Id: <20231003062458.23552-18-xin3.li@intel.com>
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

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add a header file for FRED prototypes and definitions.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v6:
* Replace pt_regs csx flags prefix FRED_CSL_ with FRED_CSX_.
---
 arch/x86/include/asm/fred.h | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 arch/x86/include/asm/fred.h

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
new file mode 100644
index 000000000000..f514fdb5a39f
--- /dev/null
+++ b/arch/x86/include/asm/fred.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros for Flexible Return and Event Delivery (FRED)
+ */
+
+#ifndef ASM_X86_FRED_H
+#define ASM_X86_FRED_H
+
+#include <linux/const.h>
+
+#include <asm/asm.h>
+
+/*
+ * FRED event return instruction opcodes for ERET{S,U}; supported in
+ * binutils >= 2.41.
+ */
+#define ERETS			_ASM_BYTES(0xf2,0x0f,0x01,0xca)
+#define ERETU			_ASM_BYTES(0xf3,0x0f,0x01,0xca)
+
+/*
+ * RSP is aligned to a 64-byte boundary before used to push a new stack frame
+ */
+#define FRED_STACK_FRAME_RSP_MASK	_AT(unsigned long, (~0x3f))
+
+/*
+ * Used for the return address for call emulation during code patching,
+ * and measured in 64-byte cache lines.
+ */
+#define FRED_CONFIG_REDZONE_AMOUNT	1
+#define FRED_CONFIG_REDZONE		(_AT(unsigned long, FRED_CONFIG_REDZONE_AMOUNT) << 6)
+#define FRED_CONFIG_INT_STKLVL(l)	(_AT(unsigned long, l) << 9)
+#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_FRED
+#include <linux/kernel.h>
+
+#include <asm/ptrace.h>
+
+struct fred_info {
+	/* Event data: CR2, DR6, ... */
+	unsigned long edata;
+	unsigned long resv;
+};
+
+/* Full format of the FRED stack frame */
+struct fred_frame {
+	struct pt_regs   regs;
+	struct fred_info info;
+};
+
+static __always_inline struct fred_info *fred_info(struct pt_regs *regs)
+{
+	return &container_of(regs, struct fred_frame, regs)->info;
+}
+
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
+{
+	return fred_info(regs)->edata;
+}
+
+#else /* CONFIG_X86_FRED */
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
+#endif /* CONFIG_X86_FRED */
+#endif /* !__ASSEMBLY__ */
+
+#endif /* ASM_X86_FRED_H */
-- 
2.34.1

