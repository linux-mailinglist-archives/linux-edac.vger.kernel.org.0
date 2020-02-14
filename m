Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDD15D3EE
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2020 09:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBNIha (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Feb 2020 03:37:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60082 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgBNIha (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Feb 2020 03:37:30 -0500
Received: from zn.tnic (p200300EC2F0D5A00F0C2F03C7F1C4548.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5a00:f0c2:f03c:7f1c:4548])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59F261EC0CED;
        Fri, 14 Feb 2020 09:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581669448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bQ+pNAR45micF63heSSUE4/LAB3cGnDZZ8BPobmbcEI=;
        b=PPgSmn4xqc5wyRg8pgqbp/N6jlwCU0QE0KRPpGkzPpnJiIV+goQ3a2wR5L9McOP+HCKna5
        h3f3QPqAY2lZKsBJSuuCRvmld/bbxyZyUhSgY9cQFvoLSjR4ll+l/Ygqogq5iUIL3sOCII
        GByucSvw3ipsvmT0WDc5I6gxHDAzh50=
Date:   Fri, 14 Feb 2020 09:37:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, Saar Amar <Saar.Amar@microsoft.com>,
        "security@kernel.org" <security@kernel.org>
Subject: [PATCH] x86/mce/amd: Publish the bank pointer only after setup has
 succeeded
Message-ID: <20200214083723.GB13395@zn.tnic>
References: <20190813100752.GM1935@kadam>
 <20200128140846.phctkvx5btiexvbx@kili.mountain>
 <20200204133638.GA19863@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200204133638.GA19863@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Now as a proper, tested patch:

---
From: Borislav Petkov <bp@suse.de>

threshold_create_bank() creates a bank descriptor per MCA error
thresholding counter which can be controlled over sysfs. It publishes
the pointer to that bank in a per-CPU variable and then goes on to
create additional thresholding blocks if the bank has such.

However, that creation of additional blocks in
allocate_threshold_blocks() can fail, leading to a use-after-free
through the per-CPU pointer.

Therefore, publish that pointer only after all blocks have been setup
successfully.

Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")
Reported-by: Saar Amar <Saar.Amar@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200128140846.phctkvx5btiexvbx@kili.mountain
---
 arch/x86/kernel/cpu/mce/amd.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b3a50d962851..e7313e5c497c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1198,8 +1198,9 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 	return buf_mcatype;
 }
 
-static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
-				     unsigned int block, u32 address)
+static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb,
+				     unsigned int bank, unsigned int block,
+				     u32 address)
 {
 	struct threshold_block *b = NULL;
 	u32 low, high;
@@ -1243,16 +1244,12 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 
 	INIT_LIST_HEAD(&b->miscj);
 
-	if (per_cpu(threshold_banks, cpu)[bank]->blocks) {
-		list_add(&b->miscj,
-			 &per_cpu(threshold_banks, cpu)[bank]->blocks->miscj);
-	} else {
-		per_cpu(threshold_banks, cpu)[bank]->blocks = b;
-	}
+	if (tb->blocks)
+		list_add(&b->miscj, &tb->blocks->miscj);
+	else
+		tb->blocks = b;
 
-	err = kobject_init_and_add(&b->kobj, &threshold_ktype,
-				   per_cpu(threshold_banks, cpu)[bank]->kobj,
-				   get_name(bank, b));
+	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(bank, b));
 	if (err)
 		goto out_free;
 recurse:
@@ -1260,7 +1257,7 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 	if (!address)
 		return 0;
 
-	err = allocate_threshold_blocks(cpu, bank, block, address);
+	err = allocate_threshold_blocks(cpu, tb, bank, block, address);
 	if (err)
 		goto out_free;
 
@@ -1345,8 +1342,6 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		goto out_free;
 	}
 
-	per_cpu(threshold_banks, cpu)[bank] = b;
-
 	if (is_shared_bank(bank)) {
 		refcount_set(&b->cpus, 1);
 
@@ -1357,9 +1352,13 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		}
 	}
 
-	err = allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
-	if (!err)
-		goto out;
+	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
+	if (err)
+		goto out_free;
+
+	per_cpu(threshold_banks, cpu)[bank] = b;
+
+	return 0;
 
  out_free:
 	kfree(b);
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
