Return-Path: <linux-edac+bounces-3015-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F50A30330
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6873A712E
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 06:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106021E9B1F;
	Tue, 11 Feb 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SWOQVs3U"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DD1E98E0;
	Tue, 11 Feb 2025 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253736; cv=none; b=J/CZD8kFk/04HgCD7UTzlFOGGFw+m9/GRSwBYTft6VPOE/E/QnEMtz+/yxjctyQ6oQdmGXaetZEwmAbAuBaLL3DMAuzHuEbIzaEPqcuvgwRdnj9q1aGsBIpsE5vAzpsvtNY5T8Fu/OwESIbp6x19zGfMT+W4DskSeNL9CqmCXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253736; c=relaxed/simple;
	bh=81q/DV3sv7VktlDJT+CNqXu1nzzdokAh44tOdxj2jyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e86C1BdT8UiuBfKNOeqHm90tgs7bxdNR74ePKX8/REtrXLzxBV6jmGAC7x8cn5KHU3Iy9fHVaejHnvfyH2tDMOkvGJ+DyNzM7xM2Avm3uSfQOXHxY3VTKa9QmvnyTXAK+ZGCs+uBW5PdmpEcAnQGVTMjTPB4uvAoLIkdlT/Ki90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SWOQVs3U; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739253725; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v4nYqPoOVXQKgJH/YSunWnnMJy+4Q4FHZPFcfZOd/Xs=;
	b=SWOQVs3UO/UVmOpGPp6I+vbXqV7/yE/iU/AU301VgZhUg7QRGPr+FD+paHllSyiaiPyLGVpV915xW44/MdH21RyBO+atRmkiXNaLZOb1cVw1Fm5B2Tiwn3kjm7vAA7Az5FHsstl8662GT/of8twB4F4gpqFqyCk5t3uauRBpUok=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPFiSHq_1739253722 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 14:02:03 +0800
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
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v1 1/4] x86/mce: Collect error message for severities below MCE_PANIC_SEVERITY
Date: Tue, 11 Feb 2025 14:01:57 +0800
Message-ID: <20250211060200.33845-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
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
index 0dc00c9894c7..2919a077cd66 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -925,11 +925,12 @@ static __always_inline void quirk_zen_ifu(int bank, struct mce *m, struct pt_reg
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
-	char *tmp = *msg;
+	char *tmp = *msg, cur_sev = MCE_NO_SEVERITY, sev;
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
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


