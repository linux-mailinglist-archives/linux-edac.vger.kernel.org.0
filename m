Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5887919DB56
	for <lists+linux-edac@lfdr.de>; Fri,  3 Apr 2020 18:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404390AbgDCQUA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Apr 2020 12:20:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404381AbgDCQT4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:56 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3524F1EC036E;
        Fri,  3 Apr 2020 18:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRm7hk26peOhWOB+SdnZcHkF8PzVWnhOl4oWCAUbcyo=;
        b=IV6OHVgIRfv5wrDPT9QSAfAIEOZE7WyMN4WFf13EQqiDSrti80XFykRKE0V0dqCEjnZITq
        48DjU1/N8JoG55vIzXoxD87Pa3ZJoC08nUWuUCPmTlzaHVxM7MhrPHIfbaaa/mRqu9dcEz
        ayBThW0f/tKIStWYZY+HGhqyDiVQtLE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] x86/mce/amd: Make threshold bank setting hotplug robust
Date:   Fri,  3 Apr 2020 18:19:43 +0200
Message-Id: <20200403161943.1458-8-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200403161943.1458-1-bp@alien8.de>
References: <20200403161943.1458-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Handle the cases when the CPU goes offline before the bank
setting/reading happens.

 [ bp: Write commit message. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 16e7aea86ab1..15c87b87b901 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -386,6 +386,10 @@ static void threshold_restart_bank(void *_tr)
 	struct thresh_restart *tr = _tr;
 	u32 hi, lo;
 
+	/* sysfs write might race against an offline operation */
+	if (this_cpu_read(threshold_banks))
+		return;
+
 	rdmsr(tr->b->address, lo, hi);
 
 	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
@@ -1085,7 +1089,8 @@ store_interrupt_enable(struct threshold_block *b, const char *buf, size_t size)
 	memset(&tr, 0, sizeof(tr));
 	tr.b		= b;
 
-	smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1);
+	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+		return -ENODEV;
 
 	return size;
 }
@@ -1109,7 +1114,8 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 	b->threshold_limit = new;
 	tr.b = b;
 
-	smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1);
+	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+		return -ENODEV;
 
 	return size;
 }
@@ -1118,7 +1124,9 @@ static ssize_t show_error_count(struct threshold_block *b, char *buf)
 {
 	u32 lo, hi;
 
-	rdmsr_on_cpu(b->cpu, b->address, &lo, &hi);
+	/* CPU might be offline by now */
+	if (rdmsr_on_cpu(b->cpu, b->address, &lo, &hi))
+		return -ENODEV;
 
 	return sprintf(buf, "%u\n", ((hi & THRESHOLD_MAX) -
 				     (THRESHOLD_MAX - b->threshold_limit)));
-- 
2.21.0

