Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34A036D06
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 09:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfFFHJo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 03:09:44 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49842 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfFFHJo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jun 2019 03:09:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TTYFHm0_1559804967;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TTYFHm0_1559804967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jun 2019 15:09:35 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org
Subject: [PATCH] x86/mce: Fix memleak in mce_banks
Date:   Thu,  6 Jun 2019 15:09:27 +0800
Message-Id: <1559804967-46320-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: zhangliguang <zhangliguang@linux.alibaba.com>

The mce_banks is leaked in the error out cases during
__mcheck_cpu_apply_quirks and mce_gen_pool_init. This patch fixes it.

Signed-off-by: zhangliguang <zhangliguang@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 282916f..cee6d4b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1816,11 +1816,14 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 		return;
 
 	if (__mcheck_cpu_cap_init() < 0 || __mcheck_cpu_apply_quirks(c) < 0) {
+		if (mce_banks)
+			kfree(mce_banks);
 		mca_cfg.disabled = 1;
 		return;
 	}
 
 	if (mce_gen_pool_init()) {
+		kfree(mce_banks);
 		mca_cfg.disabled = 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
 		return;
-- 
1.8.3.1

