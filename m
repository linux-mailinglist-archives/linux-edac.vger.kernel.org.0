Return-Path: <linux-edac+bounces-3095-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAEBA37B68
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 07:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B39818873E0
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683E18FDA9;
	Mon, 17 Feb 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FlvGBTqh"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533D18DB3A;
	Mon, 17 Feb 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774026; cv=none; b=U7E0blsUJJa7W/evERex1NM880TlEEOIQq1nkAsAZjiwHB8TveYAbke7CmyRthm3B1Vb5s8U7kDo1gKKPw76dmjNTeUXjnoSGwzeaCUL5JDebc2a9ljuFmzrVsWB7xa5dBFn33BSZJF1DAM0pCcXs+uHQcuKeCdbltNUQ5/d1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774026; c=relaxed/simple;
	bh=JVi9V1ouofmF0HqLDOVRpPch6QSkFiRqXWt6uPNOFvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZCC2ATl3raqqnO9dUVCa1gsH07COmAinoHEGrGMwaVcqxpke1ytk96VYqbYTTwbzwkxPpkKaeWtgoJyJLVhv0t39CKbN/MpCEr7931cxnz6vV1at/rV6aUIPDmqRdyVYeRVAGWtcJHo8cJLEhtmDR7dvuWqctjLMTy5Dly5iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FlvGBTqh; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739774020; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=C//AWNBmkoQxyk9EmxC2ITDqwThmL3f05NW0jHto79U=;
	b=FlvGBTqh6c9aFIDwnAtQaUDwxcIzWCEpU0Ryver0NEwZDfggbH0YPUZInCtpm2MUoc33F/x83R//Rzszv0S22curvnB+dRnFaXR1l9nVS1Fs30O3eD50gdm4VbWHswdrSzpbBf8qSXw+Wi6IMXuLOBI3bfss65oreJua855kFxE=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPb1mOT_1739774017 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 14:33:38 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	nao.horiguchi@gmail.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v2 1/5] x86/mce: Collect error message for severities below MCE_PANIC_SEVERITY
Date: Mon, 17 Feb 2025 14:33:31 +0800
Message-ID: <20250217063335.22257-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, mce_no_way_out() only collects error messages when the error
severity is equal to `MCE_PANIC_SEVERITY`. To improve diagnostics,
modify the behavior to also collect error messages when the severity is
less than `MCE_PANIC_SEVERITY`.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dc00c9894c7..f2e730d4acc5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -925,12 +925,13 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
-static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, unsigned long *validp,
-					  struct pt_regs *regs)
+static __always_inline bool mce_no_way_out(struct mce_hw_err *err, char **msg,
+					   unsigned long *validp,
+					   struct pt_regs *regs)
 {
 	struct mce *m = &err->m;
 	char *tmp = *msg;
-	int i;
+	int i, cur_sev = MCE_NO_SEVERITY, sev;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
@@ -945,13 +946,17 @@ static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, un
 			quirk_zen_ifu(i, m, regs);
 
 		m->bank = i;
-		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
+		sev = mce_severity(m, regs, &tmp, true);
+		if (sev >= cur_sev) {
 			mce_read_aux(err, i);
 			*msg = tmp;
-			return 1;
+			cur_sev = sev;
 		}
+
+		if (cur_sev == MCE_PANIC_SEVERITY)
+			return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
-- 
2.39.3


