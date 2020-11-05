Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E862A80B0
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 15:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgKEOTN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 09:19:13 -0500
Received: from m12-15.163.com ([220.181.12.15]:34621 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbgKEOTM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Nov 2020 09:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=SRGZE9QaYZjF/f6y12
        I0JDiF5vu4zgMn7WRer/RYTls=; b=SV4QX1dxSKK6lpzEorGVWMvJGe16/oTozC
        qfiMNJe3c/W7tgtDcLwD/7JRuP+u2mWCFshBwby3xG/WGHv46NJD/V5aE+l4jF3/
        BnF5TcjPdkVedjsdN4Juo2sWVlwFFbLoYmdn25rO2uSME6xrSxC+hhxsAjr8MlUB
        KfFeyvdQ8=
Received: from smtp.163.com (unknown [36.112.24.10])
        by smtp11 (Coremail) with SMTP id D8CowAAX_hJ05aNfFE8BGg--.1121S2;
        Thu, 05 Nov 2020 19:43:50 +0800 (CST)
From:   yaoaili126@163.com
To:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, james.morse@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        yangfeng1@kingsoft.com, CHENGUOMIN@kingsoft.com,
        yaoaili@kingsoft.com
Subject: [PATCH] Fix randconfig build error and code bug
Date:   Thu,  5 Nov 2020 03:43:26 -0800
Message-Id: <20201105114326.353021-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <202011041829.KUaqiCq1-lkp () intel ! com>
References: <202011041829.KUaqiCq1-lkp () intel ! com>
X-CM-TRANSID: D8CowAAX_hJ05aNfFE8BGg--.1121S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw47uw18XF4rAry7CFyxuFg_yoW8urWxpF
        WxurWYyw48XrnrK34kArykZ345Z3s5W3y3Kan8Gw15W3WrZrWIqrnYq34UKFyrCry5Gw4f
        Za90qrn2ya97tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIPfQUUUUU=
X-Originating-IP: [36.112.24.10]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbiLBbTG1spZVxGmQAAsm
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

CONFIG_ACPI_APEI is not sufficient for ghes module global function
replace it with CONFIG_ACPI_APEI_GHES.

When gen_pool_alloc fails in ghes_in_mce_cper_entry_check, we still need
to try other cper table to get it cleaned even we are likely to get another
allocation fail.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/kernel/cpu/mce/internal.h | 6 +++++-
 drivers/acpi/apei/ghes.c           | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 1c79b32fcaa9..1fdf8ac45372 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -70,7 +70,6 @@ int apei_write_mce(struct mce *m);
 ssize_t apei_read_mce(struct mce *m, u64 *record_id);
 int apei_check_mce(void);
 int apei_clear_mce(u64 record_id);
-extern int ghes_in_mce_cper_entry_check(void);
 #else
 static inline int apei_write_mce(struct mce *m)
 {
@@ -88,6 +87,11 @@ static inline int apei_clear_mce(u64 record_id)
 {
 	return -EINVAL;
 }
+#endif
+
+#ifdef CONFIG_ACPI_APEI_GHES
+extern int ghes_in_mce_cper_entry_check(void);
+#else
 static inline int ghes_in_mce_cper_entry_check(void)
 {
 	return 0;
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ba3140d74f75..8baa19c6b625 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1131,7 +1131,7 @@ int ghes_in_mce_cper_entry_check(void)
 			/* Going to panic, No need to keep the error. */
 			ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
 			ret = -ENOMEM;
-			goto done;
+			continue;
 		}
 
 		estatus_node->ghes = ghes;
@@ -1157,7 +1157,7 @@ int ghes_in_mce_cper_entry_check(void)
 		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
 		      node_len);
 	}
-done:
+
 	rcu_read_unlock();
 	atomic_dec(&ghes_in_nmi);
 	return ret;

base-commit: b11831c841cb8046a9e01300f5d91985c293e045
-- 
2.18.4


