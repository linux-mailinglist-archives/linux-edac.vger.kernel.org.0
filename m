Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BCEB0CE
	for <lists+linux-edac@lfdr.de>; Thu, 31 Oct 2019 14:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJaNEw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Oct 2019 09:04:52 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:43570 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbfJaNEw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 31 Oct 2019 09:04:52 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 2C9B72E1334;
        Thu, 31 Oct 2019 16:04:49 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9vpXUf9EwB-4miWoHML;
        Thu, 31 Oct 2019 16:04:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572527089; bh=6iAxRGCXq1sNutNdEIlG19f9Dse4BaappT9yMPPGsYE=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=k6aVHZ3/szB6z72xd7PSQ1+1V1nkBbDYxaiCRswy3x1D2UNxKv1CdRZUSBhecBDFx
         NTwVEK1SOGluxT4dM2mrIWiXl8Po8N3ZE5JP74c12c8cP7qrYdFGxDDCR0ALH89CoB
         r3cDjHRQ3lx833AMPxAVGk4R8X2HUw8tan+Z679U=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id DRfOBZAwWO-4mWuT29H;
        Thu, 31 Oct 2019 16:04:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] x86/MCE/AMD: fix warning about sleep-in-atomic at early boot
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     x86@kernel.org
Date:   Thu, 31 Oct 2019 16:04:48 +0300
Message-ID: <157252708836.3876.4604398213417262402.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Function smca_configure() is called only for current cpu thus
rdmsr_safe_on_cpu() could be replaced with atomic rdmsr_safe().

 BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
 in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/1
 CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.79-16 #1
 Hardware name: GIGABYTE R181-Z90-00/MZ91-FS0-00, BIOS R11 10/25/2019
 Call Trace:
  dump_stack+0x5c/0x7b
  ___might_sleep+0xec/0x110
  wait_for_completion+0x39/0x160
  ? __rdmsr_safe_on_cpu+0x45/0x60
  rdmsr_safe_on_cpu+0xae/0xf0
  ? wrmsr_on_cpus+0x20/0x20
  ? machine_check_poll+0xfd/0x1f0
  ? mce_amd_feature_init+0x190/0x2d0
  mce_amd_feature_init+0x190/0x2d0
  mcheck_cpu_init+0x11a/0x460
  identify_cpu+0x3e2/0x560
  identify_secondary_cpu+0x13/0x80
  smp_store_cpu_info+0x45/0x50
  start_secondary+0xaa/0x200
  secondary_startup_64+0xa4/0xb0

Except warning in kernel log everything works fine.

Fixes: 5896820e0aa3 ("x86/mce/AMD, EDAC/mce_amd: Define and use tables for known SMCA IP types")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 arch/x86/kernel/cpu/mce/amd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ea7fdc82f3c..c7ab0d38af79 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -269,7 +269,7 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 	if (smca_banks[bank].hwid)
 		return;
 
-	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
+	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
 	}

