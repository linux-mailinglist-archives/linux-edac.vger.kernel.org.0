Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C176522E4F7
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 06:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgG0EcJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 00:32:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:24188 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgG0EcJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 00:32:09 -0400
IronPort-SDR: EBgElcoLQ1uCt7QVtz5Yh3KX3Ppah0yDVDlhjhh5bk0dhpo9k/2VPBBgA0+qnEyUp1f8i599f/
 TSY6H1lxq1Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="131016889"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="131016889"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 21:32:08 -0700
IronPort-SDR: 44mgJUxxoytHivjDr9PwqzBFsQYsM8cXniSJ+ZMqj/mBzE0YrVXm07Vd7k/Q8XBHCYlnhUQbnC
 w26Z94A5ubxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="329550032"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2020 21:32:08 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH 1/4] x86/cpufeatures: Add enumeration for SERIALIZE instruction
Date:   Sun, 26 Jul 2020 21:31:29 -0700
Message-Id: <20200727043132.15082-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Intel architecture defines a set of Serializing Instructions (a
detailed definition can be found in Vol.3 Section 8.3 of the Intel "main"
manual, SDM). However, these instructions do more than what is required,
have side effects and/or may be rather invasive. Furthermore, some of
these instructions are only available in kernel mode or may cause VMExits.
Thus, software using these instructions only to serialize execution (as
defined in the manual) must handle the undesired side effects.

As indicated in the name, SERIALIZE is a new Intel architecture
Serializing Instruction. Crucially, it does not have any of the mentioned
side effects. Also, it does not cause VMExit and can be used in user mode.

This new instruction is currently documented in the latest "extensions"
manual (ISE). It will appear in the "main" manual in the future.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cathy Zhang <cathy.zhang@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kyung Min Park <kyung.min.park@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 03390a1ef8e7..2901d5df4366 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -367,6 +367,7 @@
 #define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* "" SRBDS mitigation MSR available */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
+#define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
-- 
2.17.1

