Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5C6EE1C0
	for <lists+linux-edac@lfdr.de>; Tue, 25 Apr 2023 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjDYMSs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Apr 2023 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjDYMSq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Apr 2023 08:18:46 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BFCC27;
        Tue, 25 Apr 2023 05:18:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vh-RnH7_1682425110;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vh-RnH7_1682425110)
          by smtp.aliyun-inc.com;
          Tue, 25 Apr 2023 20:18:40 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     bp@alien8.de, tony.luck@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, baolin.wang@linux.alibaba.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce/amd: init mce severity to handle deferred memory failure
Date:   Tue, 25 Apr 2023 20:18:29 +0800
Message-Id: <20230425121829.61755-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When a deferred UE error is detected, e.g by background patrol scruber, it
will be handled in APIC interrupt handler amd_deferred_error_interrupt().
The handler will collect MCA banks, init mce struct and process it by
nofitying the registered MCE decode chain.

The uc_decode_notifier, one of MCE decode chain, will process memory
failure but only limit to MCE_AO_SEVERITY and MCE_DEFERRED_SEVERITY.
However, APIC interrupt handler does not init mce severity and the
uninitialized severity is 0 (MCE_NO_SEVERITY).

To handle the deferred memory failure case, init mce severity when logging
MCA banks.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

---
Steps to reproduce:

step 1: inject a patrol scrub error by ras-tools
#einj_mem_uc patrol

step 2: check dmesg, no memory failure log
#dmesg -c
[51295.686806] mce: [Hardware Error]: Machine check events logged
[51295.693566] mce->status: 0x942031000400011b
[51295.698248] mce->misc: 0x00000000
[51295.701952] mce->severity: 0x00000000	# Manually added printk  
[51295.726640] [Hardware Error]: Deferred error, no action required.
[51295.733448] [Hardware Error]: CPU:65 (19:11:1) MC21_STATUS[-|-|-|AddrV|-|-|SyndV|UECC|Deferred|-|Scrub]: 0x942031000400011b
[51295.733452] [Hardware Error]: Error Addr: 0x0000000006350a00
[51295.733453] [Hardware Error]: PPIN: 0x02b69e294c148024
[51295.733453] [Hardware Error]: IPID: 0x0000109600250f00, Syndrome: 0x9a4a00000b800000
[51295.733455] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0, DRAM ECC error.
[51295.733463] mce: umc_normaddr_to_sysaddr: Invalid DramBaseAddress range: 0x0.
[51295.733471] EDAC MC0: 1 UE Cannot decode normalized address on mc#0csrow#0channel#2 (csrow:0 channel:2 page:0x0 offset:0x0 grain:64)
[51295.733471] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

After this fix:

[  514.966892] mce: [Hardware Error]: Machine check events logged
[  514.966912] mce->status: 0x942031000400011b
[  514.978093] mce->misc: 0x00000000
[  514.981796] mce->severity: 0x00000001
[  514.985885] <uc_decode_notifier> pre_handler: p->addr = 0x00000000e09e69e4, ip = ffffffff8104b955, flags = 0x282
[  514.997253] <uc_decode_notifier> post_handler: p->addr = 0x00000000e09e69e4, flags = 0x282
[  515.006501] Memory failure: 0x5dc2: recovery action for free buddy page: Recovered
[  515.015188] [Hardware Error]: Deferred error, no action required.
[  515.022006] [Hardware Error]: CPU:67 (19:11:1) MC21_STATUS[-|-|-|AddrV|-|-|SyndV|UECC|Deferred|-|Scrub]: 0x942031000400011b
[  515.034440] [Hardware Error]: Error Addr: 0x0000000005dc2a00
[  515.034442] [Hardware Error]: PPIN: 0x02b69e294c148024
[  515.034443] [Hardware Error]: IPID: 0x0000109600650f00, Syndrome: 0x9a4a00000b800008
[  515.034445] [Hardware Error]: Unified Memory Controller Ext. Error Code: 0, DRAM ECC error.
[  515.034453] umc_normaddr_to_sysaddr: Invalid DramBaseAddress range: 0x0.
[  515.034458] EDAC MC1: 1 UE Cannot decode normalized address on mc#1csrow#0channel#6 (csrow:0 channel:6 page:0x0 offset:0x0 grain:64)
[  515.034461] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

Note, the memory_failure handles wrong physical address because
umc_normaddr_to_sysaddr fails. I don't figure out why it fails.
---
 arch/x86/kernel/cpu/mce/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 23c5072fbbb7..b5e1a27b0881 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -734,6 +734,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	m.misc   = misc;
 	m.bank   = bank;
 	m.tsc	 = rdtsc();
+	m.severity = mce_severity(&m, NULL, NULL, false);
 
 	if (m.status & MCI_STATUS_ADDRV) {
 		m.addr = addr;
-- 
2.20.1.12.g72788fdb

