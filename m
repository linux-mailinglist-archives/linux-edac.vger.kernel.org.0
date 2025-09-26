Return-Path: <linux-edac+bounces-4936-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F00BA27A4
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 07:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B4938144E
	for <lists+linux-edac@lfdr.de>; Fri, 26 Sep 2025 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20DC279359;
	Fri, 26 Sep 2025 05:44:19 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90027380A;
	Fri, 26 Sep 2025 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758865459; cv=none; b=fp8bTe81TmECZpmj2U9jr6ehXP4iKb719R/TA/zlSDZyTel8XL+rX1RjNAJLoLrbvcSQX+2cVhsLGQ5cyuZXwoHane11O8kk/+u+GCLLMoIiuSl1x9rrJkDhhx4AjxdvyZbpFKrSalrHEPWpZUdg6kEBnbYkbQRo4dJ7PLBYzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758865459; c=relaxed/simple;
	bh=X1+azPQYosWOYI5uRjrk5HBLUXcBXxT7srvMepAj1Ho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gFDVCx9qJc8f3wE4lmNrL9fasMBQxl3JV25bP2MgWyb1NaPTFg9Nmyx+TF6Jbylxl1++0wseql+aqulS5D+teH/aHczdbZm2iG/aDpJlhWP9V84o2WdPgimpT63eWNnn/cNBNHViEWRWzOSgLRilBF0CygUSLDhHePU6EJMwML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201605.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202509261344056867;
        Fri, 26 Sep 2025 13:44:05 +0800
Received: from vbox.home.langchao.com (10.94.9.167) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.58; Fri, 26 Sep 2025 13:44:04 +0800
From: wangchuanguo <wangchuanguo@inspur.com>
To: <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, wangchuanguo <wangchuanguo@inspur.com>
Subject: [PATCH] x86/mce: deal with UCE when copy clean pagecache to user space
Date: Fri, 26 Sep 2025 13:44:02 +0800
Message-ID: <20250926054402.1571-1-wangchuanguo@inspur.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20259261344050f242243f4f6d7dd8b3666d8f9abcec7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Based on copy_from_user, extending the goal to unmap,discard,
and remap when errors occur in clean pagecache.

Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 2235a7477436..d1fc9568fa71 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -231,8 +231,22 @@ static struct severity {
 
 #define mc_recoverable(mcg) (((mcg) & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) == \
 				(MCG_STATUS_RIPV|MCG_STATUS_EIPV))
-
-static bool is_copy_from_user(struct pt_regs *regs)
+static bool is_clean_pagecache(unsigned long addr)
+{
+	if (virt_addr_valid(addr)) {
+		struct page *page;
+
+		page = virt_to_page(addr);
+		if (page) {
+			if (!PageSlab(page) && !PageAnon(page)) {
+				if (!PageDirty(page))
+					return true;
+			}
+		}
+	}
+	return false;
+}
+static bool is_copy_user(struct pt_regs *regs)
 {
 	u8 insn_buf[MAX_INSN_SIZE];
 	unsigned long addr;
@@ -264,8 +278,14 @@ static bool is_copy_from_user(struct pt_regs *regs)
 		return false;
 	}
 
-	if (fault_in_kernel_space(addr))
-		return false;
+	if (fault_in_kernel_space(addr)) {
+		if (is_clean_pagecache(addr) && !fault_in_kernel_space(regs->di)) {
+			//is copying clean pagecache to user space
+			addr = regs->di;
+		} else {
+			return false;
+		}
+	}
 
 	current->mce_vaddr = (void __user *)addr;
 
@@ -297,7 +317,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	/* Allow instrumentation around external facilities usage. */
 	instrumentation_begin();
 	fixup_type = ex_get_fixup_type(m->ip);
-	copy_user  = is_copy_from_user(regs);
+	copy_user  = is_copy_user(regs);
 	instrumentation_end();
 
 	if (copy_user) {
-- 
2.39.3


