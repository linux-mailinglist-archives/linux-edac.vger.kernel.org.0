Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195CE1A075A
	for <lists+linux-edac@lfdr.de>; Tue,  7 Apr 2020 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgDGGeB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Apr 2020 02:34:01 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34753 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgDGGd6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Apr 2020 02:33:58 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 9ab397b9;
        Tue, 7 Apr 2020 06:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=jnfqAcB3FkJJghojQNXETQmiD
        XM=; b=3gcwL1+WjA8BQ7Cevgi80DvJ02fa2QeAaH8mhH3zDS8mraY/l/jPs30/x
        oV/1oXf5jR59xrff0vmfJsq2ruGKk149PwCwgoJcexA+CECBVs3JD23dH6DyUAqr
        lO7Lf7AgWQWbwd3xrTziEajJcRbZkuWNyeZwEVwtwJGutp96H71oh9xSEJrnltjI
        DBtFvmBj24FbF5WgFG2K9fA2O5MvZrKQ8yNMSYS+dOsgKvz7zgI8X4d749uUUFep
        bEBrd6FWjly/stvpyE5NapE8Z+MmVyxRAFCtPYPERS8zYFIlDXPK6Zsm3O5kxk8B
        hkWqeMcNp+84MMhDAFx0K3/g2oDyg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d2fa65a3 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 7 Apr 2020 06:25:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, arnd@arndb.de, srinivas.pandruvada@linux.intel.com,
        bberg@redhat.com, bp@suse.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal vector altogether
Date:   Tue,  7 Apr 2020 00:33:45 -0600
Message-Id: <20200407063345.4484-3-Jason@zx2c4.com>
In-Reply-To: <20200407063345.4484-1-Jason@zx2c4.com>
References: <20200407063345.4484-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The thermal IRQ handler uses 1.21% CPU on my system when it's hot from
compiling things. Indeed looking at /proc/interrupts reveals quite a lot
of events coming in. Beyond logging them, the existing drivers on the
system don't appear to do very much that I'm interested in. So, add a
way to disable this entirely so that I can regain precious CPU cycles.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/Kconfig                | 4 ++++
 arch/x86/kernel/cpu/mce/intel.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39e7444353af..3125a11932f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1157,7 +1157,11 @@ config X86_MCE_INJECT
 
 config X86_THERMAL_VECTOR
 	def_bool y
+	prompt "Machine check thermal vector"
 	depends on X86_MCE_INTEL
+	---help---
+	  Provide support for capturing thermal events, logging them, and
+	  passing them off to other drivers.
 
 config X86_MCE_THERMAL_VERBOSE
 	bool "Verbose logging for thermal events"
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f996ffb887bc..d14f1922fb49 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -511,7 +511,8 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
-	intel_init_thermal(c);
+	if (IS_ENABLED(CONFIG_X86_THERMAL_VECTOR))
+		intel_init_thermal(c);
 	intel_init_cmci();
 	intel_init_lmce();
 	intel_ppin_init(c);
-- 
2.26.0

