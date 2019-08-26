Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792259C911
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2019 08:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfHZGRD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Aug 2019 02:17:03 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:49806 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfHZGRD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Aug 2019 02:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=hc63cxkTZpzkFww549
        eswCcb8sHDad4ko+ngdlX/DXU=; b=gFOhk4kpkWtmEIy15tFo9yi5rkGgrOiySh
        veoTH5vttZmBN3i+6dN6K321ihoeg6e/CkUdwqbtdpV/aPB5x+55iRluOBW1asnP
        hw2FVa6oQgMM2ypSqVt5zy2JquH2+vcs+GcnwnnG5LAOMIgx8VK0XrUEHJO6qit1
        H9YeBN4SY=
Received: from localhost.localdomain.localdomain (unknown [111.205.43.245])
        by smtp3 (Coremail) with SMTP id G9xpCgA3zYUneWNd3Yd6Aw--.75S2;
        Mon, 26 Aug 2019 14:16:07 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     tony.luck@intel.com, bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH] x86/mce: show the status of cmci_disabled to user
Date:   Mon, 26 Aug 2019 14:16:04 +0800
Message-Id: <1566800164-6428-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: G9xpCgA3zYUneWNd3Yd6Aw--.75S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4UAF4rKw4UWr4UXw17trb_yoWfWrg_Ww
        1Igr4DCr4fZr9Ivrn7XF4FqryUZw1S9Fs0yw1IyrWYyryjqan8uayFyFZxJrnxW3yFqFW3
        Ar98JF4Y9w4UZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnbJ57UUUUU==
X-Originating-IP: [111.205.43.245]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/xtbBZwcdQFetv8-HMwAAsD
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

When enabled Firmware First mode in UEFI, we need to
set the cmci_disabled and ignore_ce in mca cfg
that users can check correct status from
"/sys/devices/system/machinecheck/machinecheckXXX/cmci_disabled"

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 arch/x86/kernel/cpu/mce/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370e..932c701 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1909,6 +1909,8 @@ static void __mce_disable_bank(void *arg)
 	int bank = *((int *)arg);
 	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
 	cmci_disable_bank(bank);
+	mca_cfg.cmci_disabled = true;
+	mca_cfg.ignore_ce = true;
 }
 
 void mce_disable_bank(int bank)
-- 
1.8.3.1

