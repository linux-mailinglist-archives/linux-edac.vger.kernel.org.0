Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3A9320FDC
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 04:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBVDuz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sun, 21 Feb 2021 22:50:55 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:11898 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBVDuy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 21 Feb 2021 22:50:54 -0500
X-AuditID: 0a580155-713ff700000550c6-2e-603322f42d8d
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id AB.83.20678.4F223306; Mon, 22 Feb 2021 11:20:20 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 22 Feb
 2021 11:50:08 +0800
Date:   Mon, 22 Feb 2021 11:50:07 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <hpa@zytor.com>
CC:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210222115007.75b7de9b@alex-virtual-machine>
In-Reply-To: <20210222113124.35f2d552@alex-virtual-machine>
References: <20210222113124.35f2d552@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXCFcGooPtFyTjB4HuPlcXnDf/YLKZtFLe4
        cKqByeLyrjlsFpcOLGCy2LxpKrPFmwv3WCx+bHjM6sDh8b21j8Vj8Z6XTB6bVnWyebw7d47d
        4/2+q2wenzfJeZxo+cIawB7FZZOSmpNZllqkb5fAlXF10hH2gpecFYtvP2drYJzM0cXIySEh
        YCLx9PMGxi5GLg4hgelMEi3HV7FCOK8YJXZvucsEUsUioCrxd/5SZhCbDcjedW8WK4gtIpAm
        8fvqTLA4s0AHo8TUHxpdjBwcwgKBEjvOx4KEeQWsJJ6cvQNWwilgLTFn7T4WkBIhoPjhDTYg
        YX4BMYneK/+ZIO6xl2jbsogRolVQ4uTMJywQ03UkTqw6BrVJW2LZwtdgtpCAosThJb/YIXqV
        JI50z2CDsGMlls17xTqBUXgWklGzkIyahWTUAkbmVYwsxbnpRpsYIVESuoNxRtNHvUOMTByM
        hxglOJiVRHjZ7holCPGmJFZWpRblxxeV5qQWH2KU5mBREuctd+BLEBJITyxJzU5NLUgtgsky
        cXBKNTApBq453fHwzBG5KQqH5TRlXW7N/yuw1tbzk9OGuLgKx2UPuNw2zvVYVvmRUzyz9ZvF
        Yq9Yv96vqZsKhZNvaapP0//PoPR5RnhB8W9LnS87uOtS+Ur9N148K53HVrCz58CJ+ydPcTM4
        6jOt3bG05IXXhLbN80uL8oJSxfcZnJqrFCFZGxRzxCV1TYxg2L3aPxXnVZa1aQW8u6iy81j8
        xqe/Zx8/Gid07qxlMa/myux6rU8LLgfd8dubWS3M4Bfjs2tlgYawY+rbZfoBO4NKK38uDloq
        cGGr04ctBSlvHu5avk5bViHkyvrq3THne65H1sppth5x/L/Dda/qa/GMB1ulz83c8U80Tsel
        6lrGY0clluKMREMt5qLiRABuRwCaAQMAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From commit b2f9d678e28c ("x86/mce: Check for faults tagged in
EXTABLE_CLASS_FAULT exception table entries"), When there is a
memory MCE_AR_SEVERITY error with no return ip, Only a SIGBUS
signal is send to current. As the page is not poisoned, the SIGBUS
process's coredump step in kernel will touch the error page again,
which result to a fatal error. We need to poison the page and then
kill current in memory-failure module.

So fix it using the orinigal checking method.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e133ce1e562b..70380d7d98b3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1414,7 +1414,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		queue_task_work(&m, kill_current_task);
+		if (worst == MCE_AR_SEVERITY)
+			queue_task_work(&m, 0);
+		else if (kill_current_task)
+			queue_task_work(&m, kill_current_task);
 
 	} else {
 		/*
-- 
2.25.1

