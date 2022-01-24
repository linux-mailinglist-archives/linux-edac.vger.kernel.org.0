Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F76D497A6B
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jan 2022 09:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiAXIfa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jan 2022 03:35:30 -0500
Received: from eage.unicloud.com ([220.194.70.58]:37451 "EHLO
        spam.unicloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbiAXIf3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Jan 2022 03:35:29 -0500
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jan 2022 03:35:28 EST
Received: from spam.unicloud.com (localhost [127.0.0.2] (may be forged))
        by spam.unicloud.com with ESMTP id 20O8IZTI013105;
        Mon, 24 Jan 2022 16:18:35 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 20O8FmIt011955;
        Mon, 24 Jan 2022 16:15:48 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Mon, 24
 Jan 2022 16:15:47 +0800
From:   luofei <luofei@unicloud.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC:     <hpa@zytor.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, luofei <luofei@unicloud.com>
Subject: [PATCH] x86/mce: Always call kill_me_maybe() to handle memory failure in user mode
Date:   Mon, 24 Jan 2022 03:15:01 -0500
Message-ID: <20220124081501.235236-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb07.Unicloud.com (10.10.0.27) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 20O8IZTI013105
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Just killing the current process is not enough, it is necessory
to offload the faulty page.

In the virtualization scenario, qemu does not set MCG_STATUS_RIPV by
default. When injecting an SRAR error into the virtual machine, only
the current process will be killed, but the faulty page will be
released and reused, which is very likely to cause the virtual
machine to crash.

Signed-off-by: luofei <luofei@unicloud.com>
---
 arch/x86/kernel/cpu/mce/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..bc6c353b9250 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1519,10 +1519,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
 		if (kill_current_task)
-			queue_task_work(&m, msg, kill_me_now);
-		else
-			queue_task_work(&m, msg, kill_me_maybe);
-
+			force_sig(SIGBUS);
+		queue_task_work(&m, msg, kill_me_maybe);
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
-- 
2.27.0

