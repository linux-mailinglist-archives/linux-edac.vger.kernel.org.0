Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D280919DB5C
	for <lists+linux-edac@lfdr.de>; Fri,  3 Apr 2020 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404254AbgDCQTw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Apr 2020 12:19:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgDCQTv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Apr 2020 12:19:51 -0400
Received: from zn.tnic (p200300EC2F0D8900BDBBB37D18611998.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:bdbb:b37d:1861:1998])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26E3D1EC0C7C;
        Fri,  3 Apr 2020 18:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585930790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUF2/4+YdR+AR0RODWlZtZWmkrpKQlyisHOZnlua1CY=;
        b=WeJDFwCUkZGpiQ3A/XnZ1JicrAUoJ/ouuhA1Cb22a4larXuvdPbx2t0Ieylui5JLJu1jAP
        j3qpVZTxOXKIDRbF+HQPqvmbEBbb+MHWFYkLml/pF31HA6Vs37sBvuZRxnkUxtK1FHg6wK
        An/likGtTM+nb9ko+ufxugLViKV2/xQ=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] x86/mce/amd: Do proper cleanup on error paths
Date:   Fri,  3 Apr 2020 18:19:37 +0200
Message-Id: <20200403161943.1458-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200403161943.1458-1-bp@alien8.de>
References: <20200403161943.1458-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Drop kobject reference counts properly on error in the banks and blocks
allocation functions.

 [ bp: Write commit message. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/amd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 52de616a8065..477cf773cf1c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1267,13 +1267,12 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	if (b)
 		kobject_uevent(&b->kobj, KOBJ_ADD);
 
-	return err;
+	return 0;
 
 out_free:
 	if (b) {
-		kobject_put(&b->kobj);
 		list_del(&b->miscj);
-		kfree(b);
+		kobject_put(&b->kobj);
 	}
 	return err;
 }
@@ -1339,6 +1338,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		goto out;
 	}
 
+	/* Associate the bank with the per-CPU MCE device */
 	b->kobj = kobject_create_and_add(name, &dev->kobj);
 	if (!b->kobj) {
 		err = -EINVAL;
@@ -1357,16 +1357,17 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 
 	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
 	if (err)
-		goto out_free;
+		goto out_kobj;
 
 	per_cpu(threshold_banks, cpu)[bank] = b;
 
 	return 0;
 
- out_free:
+out_kobj:
+	kobject_put(b->kobj);
+out_free:
 	kfree(b);
-
- out:
+out:
 	return err;
 }
 
-- 
2.21.0

