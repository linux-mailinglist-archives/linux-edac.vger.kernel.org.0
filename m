Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993281A0759
	for <lists+linux-edac@lfdr.de>; Tue,  7 Apr 2020 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgDGGd5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Apr 2020 02:33:57 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34753 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgDGGd5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Apr 2020 02:33:57 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6917a9d6;
        Tue, 7 Apr 2020 06:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=BzxdK8qX7RPMFKrWffaobEdiW
        Aw=; b=fXiQ1qW3kilIqRdGH9MIIuHs+vzTNW4T/NuK8lAzfJzSjQbhm/qNou8NZ
        OV3ylqBANDqhURB9qTb8wE89Sq7RpWLpE2s+EMf+8OH8QTRXEiCaEkjn0468f6yl
        YwWkVcDkIZUvkE6wpNamzA/ZktpKbCTuEjvUMQOlTvAWzTWt83mLb8ZfTrix+THW
        nlxw36s5r/2lABHK67dP5GTrFkTh2v0J2aSkBHvmyatVSLWEssWGMhWZJb1XaySu
        rXy8Zn6BSax1+wsV8QP1iiAq2d8dUQwm5OAS4RmIZZkEKB22g4oUX/AkLMep7sEf
        GAef5h9L8TjainUlvq0EwLhdRAkww==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 715c3be1 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 7 Apr 2020 06:25:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, arnd@arndb.de, srinivas.pandruvada@linux.intel.com,
        bberg@redhat.com, bp@suse.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 2/3] x86/mce/therm_throt: allow disabling verbose logging
Date:   Tue,  7 Apr 2020 00:33:44 -0600
Message-Id: <20200407063345.4484-2-Jason@zx2c4.com>
In-Reply-To: <20200407063345.4484-1-Jason@zx2c4.com>
References: <20200407063345.4484-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There is an enormous amount of fiddly book keeping and an auxiliary
workqueue just for the purpose of ratelimiting and reliably printing
messages regarding thermal events and throttling, which uses CPU in a
rather common interrupt. Add an option to disable this verbose
reporting.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/Kconfig                      | 9 +++++++++
 arch/x86/kernel/cpu/mce/therm_throt.c | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..39e7444353af 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1159,6 +1159,15 @@ config X86_THERMAL_VECTOR
 	def_bool y
 	depends on X86_MCE_INTEL
 
+config X86_MCE_THERMAL_VERBOSE
+	bool "Verbose logging for thermal events"
+	depends on X86_THERMAL_VECTOR
+	---help---
+	  Display messages in the kernel log when thermal events are triggered,
+	  such as overheating and throttling. This mostly only uses extra CPU
+	  for ratelimiting and book keeping, so unless you need these logs, it
+	  is safe to say N.
+
 source "arch/x86/events/Kconfig"
 
 config X86_LEGACY_VM86
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index f904e85eb68f..6d726190a40a 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -313,6 +313,9 @@ static void therm_throt_process(bool new_event, int event, int level)
 	u64 now;
 	struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
 
+	if (!IS_ENABLED(CONFIG_X86_MCE_THERMAL_VERBOSE))
+		return;
+
 	now = get_jiffies_64();
 	if (level == CORE_LEVEL) {
 		if (event == THERMAL_THROTTLING_EVENT)
-- 
2.26.0

