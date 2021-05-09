Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1903C377211
	for <lists+linux-edac@lfdr.de>; Sat,  8 May 2021 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhEHNWK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 8 May 2021 09:22:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17162 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhEHNWJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 8 May 2021 09:22:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FcntN5GWDzncMw
        for <linux-edac@vger.kernel.org>; Sat,  8 May 2021 21:17:48 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 8 May 2021 21:20:56 +0800
Date:   Sun, 9 May 2021 13:32:29 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <lvying6@huawei.com>,
        <fanwentao@huawei.com>
Subject: [RFC PATCH] x86/mce/inject: Fix printk deadlock causing
 mce_timed_out panic
Message-ID: <20210509053229.GA2477949@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The mce-inject SRAO broadcast error injection on 4-core CPU caused mce_timed_out
panic as following:
Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler

There are two CPUs's backtrace are the same:

Call Trace:
panic
mce_panic
mce_timed_out
do_machine_check
raise_exception
mce_raise_notify
nmi_handle
do_nmi
--- <NMI exception stack> ---

Another CPU's backtrace:

Call Trace:
panic
mce_panic
mce_timed_out
do_machine_check
raise_exception
mce_raise_notify
nmi_handle
do_nmi
--- <NMI exception stack> ---
...
console_unlock
vprintk_emit
printk

The last CPU's backtrace:

Call Trace:
crash_nmi_callback
nmi_handle
do_nmi
--- <NMI exception stack> ---
vprintk_emit
printk
raise_local
mce_inject_raise
notifier_call_chain
mce_chrdev_write

So, the last CPU does not go to mce_timed_out function causing mce_panic.
The last CPU stuck's reason is as follows:

	CPU A				CPU B
	 |				 |
	printk				 |
	 |				 |
	hold console_sem		 |
	 |				 |
	broadcast NMI		<-	send NMI IPI
	 |				 |
	 |				 |
	mce_timed_out			printk
	wait all the CPU		 |
					can not hold console_sem
					set console_waiter true
					 |
					while (console_waiter)
					  cpu_releax;

The CPU A will call console_lock_spinning_disable_and_check set console_waiter
false. However, this function will never be called as NMI handler stuck in mce_timed_out.

So, after CPU B send NMI IPI to all the other CPUs, before CPU B itself call
raise_exception to go to mce_timed_out. No printk should be called. Just remove
this pr_info, the pr_info("MCE exception done on CPU %d\n", cpu) after
raise_exception is enough to show that the CPU has handled the MCE exception.

Signed-off-by: Lv Ying <lvying6@huawei.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 4e86d97f9653..e84a5ffd08f4 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -194,7 +194,6 @@ static int raise_local(void)
 	int cpu = m->extcpu;
 
 	if (m->inject_flags & MCJ_EXCEPTION) {
-		pr_info("Triggering MCE exception on CPU %d\n", cpu);
 		switch (context) {
 		case MCJ_CTX_IRQ:
 			/*
-- 
2.23.0

