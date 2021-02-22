Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824A8320FC7
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 04:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhBVDcR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sun, 21 Feb 2021 22:32:17 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:44910 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229889AbhBVDcQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 21 Feb 2021 22:32:16 -0500
X-AuditID: 0a580157-f39ff7000005df43-0f-60331f5b9f21
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 22.62.57155.B5F13306; Mon, 22 Feb 2021 11:04:59 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 11:31:24 +0800
Date:   Mon, 22 Feb 2021 11:31:24 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <yangfeng1@kingsoft.com>, <yaoaili@kingsoft.com>
CC:     <tglx@linutronix.de>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: x86/mce: fix wrong no-return-ip logic in do_machine_check()
Message-ID: <20210222113124.35f2d552@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXCFcGooBstb5xg0NSlbPF5wz82i2kbxS0u
        nGpgsri8aw6bxaUDC5gsNm+aymzx5sI9FosfGx6zOnB4fG/tY/FYvOclk8emVZ1sHu/OnWP3
        eL/vKpvH501yHidavrAGsEdx2aSk5mSWpRbp2yVwZXxdNpel4ChXRX97J0sD4xWOLkZODgkB
        E4ne9ycZuxi5OIQEpjNJtC7YygThvGKUuPdoFgtIFYuAqsTrvU2MIDYbkL3r3ixWEFtEoFBi
        wYGDQA0cHMwC1RKd/8tBTGEBF4n5V1hATF4BK4l3h2NAivkFxCR6r/xnglhrL9G2ZRHYQF4B
        QYmTM5+ALWIW0JE4seoYM4StLbFs4WswW0hAUeLwkl/sEL1KEke6Z7BB2LESy+a9Yp3AKDgL
        yahZSEbNQjJqASPzKkaW4tx0w02MkJAP38E4r+mj3iFGJg7GQ4wSHMxKIrxsd40ShHhTEiur
        Uovy44tKc1KLDzFKc7AoifOKOfIlCAmkJ5akZqemFqQWwWSZODilGpgCwhg6S+VzFv7+XDnX
        eZpgjXVA7K/Te3ZMSpavqdn+a4mF24LqX1ZehUrJR/cIV8x1VvBm8D+1wD6XL/53wam1F2Vu
        HtJQuHMp4abmTrNF943eZLEmMJ79rLAz+tFHpmc/dORl4pdt3d53xjivrlaqlZ9vvfeOIBej
        tbaPnr+L9hWoXNt7KODoT7bGGWfKPk/h+n9dhUn4MD9b75l0dZmfmy1WbRZiVGJfmXr22tr8
        7zJeDnlu7AyXmAqNZcv7bB+5Onb0X95xu+B9TvXaz6dWpZ/Zf1yoPrnOK11a1WjZ+/LD9xYr
        f+b/KFfpbe3VFCjP1PHz0vNzfkwml3W7NhTPVrCWVhF++rO36ZgOvxJLcUaioRZzUXEiAP2d
        LHToAgAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From commit b2f9d678e28c ("x86/mce: Check for faults tagged in
EXTABLE_CLASS_FAULT exception table entries"), When there is a
memory MCE_AR_SEVERITY error with no return ip, Only a SIGBUS
signal is send to current. As the page is not poisoned, the SIGBUS
process coredump step in kernel will touch the error page again,
whick result to a fatal error. We need to poison the page and then
kill current in memory-failure module.

So fix it using the orinigal checking method.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/kernel/cpu/mce/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e133ce1e562b..ae09b0279422 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1413,9 +1413,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if ((m.cs & 3) == 3) {
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
-
-		queue_task_work(&m, kill_current_task);
-
+		if (worst == MCE_AR_SEVERITY)
+			queue_task_work(&m, 0);
+		else if (kill_current_task)
+			queue_task_work(&m, kill_current_task);
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
-- 
2.25.1

