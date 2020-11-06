Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6EA2A9774
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 15:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgKFOMl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 09:12:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6754 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKFOMl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Nov 2020 09:12:41 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CSMlt3RxqzkfqP;
        Fri,  6 Nov 2020 22:12:26 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.230) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 22:12:27 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] x86/mce: correct the detection of invalid mce priorities
Date:   Fri, 6 Nov 2020 22:12:16 +0800
Message-ID: <20201106141216.2062-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201106141216.2062-1-thunder.leizhen@huawei.com>
References: <20201106141216.2062-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.230]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

enum mce_notifier_prios {
	MCE_PRIO_LOWEST,
	...
	MCE_PRIO_CEC
};

After commit c9c6d216ed28 ("x86/mce: Rename "first" function as "early""),
the range of invalid priorities is changed. Add a new enumeration value
MCE_PRIO_HIGHEST, so that people can add enumeration values greater than
MCE_PRIO_CEC in the future without having to modify the function
mce_register_decode_chain().

Because the type of "nb->priority" is int, so the priority less than
MCE_PRIO_LOWEST is also invalid.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/include/asm/mce.h     | 3 ++-
 arch/x86/kernel/cpu/mce/core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index a0f147893a04..fc25c88c7ff2 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -177,7 +177,8 @@ enum mce_notifier_prios {
 	MCE_PRIO_EXTLOG,
 	MCE_PRIO_UC,
 	MCE_PRIO_EARLY,
-	MCE_PRIO_CEC
+	MCE_PRIO_CEC,
+	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
 };
 
 struct notifier_block;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..0a54a2cfeeff 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -162,7 +162,8 @@ EXPORT_SYMBOL_GPL(mce_log);
 
 void mce_register_decode_chain(struct notifier_block *nb)
 {
-	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
+	if (WARN_ON((nb->priority < MCE_PRIO_LOWEST) ||
+		    (nb->priority > MCE_PRIO_HIGHEST)))
 		return;
 
 	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
-- 
2.26.0.106.g9fadedd


