Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4EB5916AF
	for <lists+linux-edac@lfdr.de>; Fri, 12 Aug 2022 23:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiHLVVe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Aug 2022 17:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiHLVVd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 Aug 2022 17:21:33 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 14:21:31 PDT
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE59AFC9
        for <linux-edac@vger.kernel.org>; Fri, 12 Aug 2022 14:21:31 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 3701 invoked from network); 12 Aug 2022 23:14:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1660338889; bh=felEuMQG3TpPkG90OlnCvkO3MCmK1jpTb7bLda+6Yow=;
          h=Subject:To:Cc:From;
          b=dqd3kq4LDJMG4qe9rnlEQxnnXgPFFfkfCqmRXqP4FN8xQlrCm8Af9UdxWGgQ0M6SG
           MWWsfoCC+StaDnBWBfaPWBeQ6dYP2n3vjvYUD2ZQqUOkH1B12n/4p0dl3yuS6OaZO2
           Qde5DjulF9ng9k2+5UPGe3TJPAsKmZKaF8NCH2SY=
Received: from aaem85.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.116.85])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yazen.ghannam@amd.com>; 12 Aug 2022 23:14:48 +0200
Message-ID: <7c8e34c8-f12d-e7e4-b6bc-4867824865ea@o2.pl>
Date:   Fri, 12 Aug 2022 23:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Content-Language: en-GB
To:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com,
        gregkh@linuxfoundation.org
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <20220614174346.3648305-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: b204b02620e9beb10dace10d344ab1f9
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [MWNU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W dniu 14.06.2022 o 19:43, Yazen Ghannam pisze:
> AMD systems from Family 10h to 16h share MCA bank 4 across multiple CPUs.
> Therefore, the threshold_bank structure for bank 4, and its threshold_block
> structures, will be initialized once at boot time. And the kobject for the
> shared bank will be added to each of the CPUs that share it. Furthermore,
> the threshold_blocks for the shared bank will be added again to the bank's
> kobject. These additions will increase the refcount for the bank's kobject.
>
> For example, a shared bank with two blocks and shared across two CPUs will
> be set up like this:
>
[snip]

Hello,

The problem this patch solves (multiple warnings with stacktraces on suspend)
also affects me, on a tri-core old AMD Phenom II X3 720 processor.

I have done some further debugging by adding printks to the code and to me it seems that your diagnosis
was correct. In the dmesg I can see:

[   66.094076] ACPI: PM: Preparing to enter system sleep state S3
[   66.510378] ACPI: PM: Saving platform NVS memory
[   66.510718] Disabling non-boot CPUs ...
[   66.511043] mce: ENTER mce_threshold_remove_device(cpu = 1)
[   66.511046] mce: ENTER __threshold_remove_device(); numbanks=6
[   66.511048] mce: ENTER threshold_remove_bank(bank name = northbridge, bank->cpus = 3, bank->shared = 1)
[   66.511049] mce: ENTER __threshold_remove_blocks(bank name = northbridge, bank->cpus = 2, bank->shared = 1)
[   66.511060] mce: EXIT __threshold_remove_blocks()
[   66.511061] mce: threshold_remove_bank: EXIT after __threshold_remove_blocks()
[   66.511062] mce: EXIT __threshold_remove_device()
[   66.511063] mce: EXIT mce_threshold_remove_device(cpu = 1)
[   66.512247] smpboot: CPU 1 is now offline
[   66.513915] mce: ENTER mce_threshold_remove_device(cpu = 2)
[   66.513919] mce: ENTER __threshold_remove_device(); numbanks=6
[   66.513922] mce: ENTER threshold_remove_bank(bank name = northbridge, bank->cpus = 2, bank->shared = 1)
[   66.513925] mce: ENTER __threshold_remove_blocks(bank name = northbridge, bank->cpus = 1, bank->shared = 1)
[   66.513929] ------------[ cut here ]------------
[   66.513930] kernfs: can not remove 'threshold_limit', no directory
[... stacktrace]
[   66.514246] kernfs: can not remove 'error_count', no directory
[...]
[   66.514485] kernfs: can not remove 'interrupt_enable', no directory
[...]
[   66.514719] kernfs: can not remove 'threshold_limit', no directory
[...]
[   66.514951] kernfs: can not remove 'error_count', no directory
[...]
[   66.515183] kernfs: can not remove 'interrupt_enable', no directory
[...]
[   66.515412] ---[ end trace 0000000000000000 ]---
[   66.515414] mce: EXIT __threshold_remove_blocks()
[   66.515415] mce: threshold_remove_bank: EXIT after __threshold_remove_blocks()
[   66.515417] mce: EXIT __threshold_remove_device()
[   66.515418] mce: EXIT mce_threshold_remove_device(cpu = 2)
[   66.516669] smpboot: CPU 2 is now offline


> Fixes: 7f99cb5e6039 ("x86/CPU/AMD: Use default_groups in kobj_type")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Tested-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com
> ---
>  arch/x86/kernel/cpu/mce/amd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 2b7ee4a6c6ba..680b75d23a03 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -1260,10 +1260,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
>  	struct threshold_block *pos = NULL;
>  	struct threshold_block *tmp = NULL;
>  
> -	kobject_del(b->kobj);
> +	kobject_put(b->kobj);
>  
>  	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
> -		kobject_del(&pos->kobj);
> +		kobject_put(b->kobj);

Shouldn't there be "kobject_put(&pos->kobj)" here instead?

Also, it seems to me that "kobject_put(b->kobj);" before the loop may be relocated after
the loop - so that the refcounts on the child objects are decreased first, then the refcount on the parent
object.

Additionally, shouldn't there be a call to "kobject_put(&b->blocks->kobj);" in __threshold_remove_blocks()?
From what I understand, b->blocks is a list head, so we need to decrease the refcount on it too.

After these changes, the __threshold_remove_blocks() function looks very similar to deallocate_threshold_blocks()
function just above it.

>  }
>  
>  static void threshold_remove_bank(struct threshold_bank *bank)

Thank you for your work.

Greetings,

Mateusz


---------------------

commit 39df75c672d9620a2967f993befedabb36b2616d
Author: Mateusz Jończyk <mat.jonczyk@o2.pl>
Date:   Fri Aug 12 20:21:46 2022 +0200

    x86/mce/amd: debugging messages

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..10c37c0599e1 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1238,6 +1238,10 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 
 static void threshold_block_release(struct kobject *kobj)
 {
+    struct threshold_block *block = to_block(kobj);
+
+    pr_warn("threshold_block_release(block = %u, bank = %u, cpu = %u)\n",
+        block->block, block->bank, block->cpu);
     kfree(to_block(kobj));
 }
 
@@ -1245,12 +1249,19 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
 {
     struct threshold_block *pos, *tmp;
 
+    pr_warn("ENTER deallocate_threshold_blocks(bank name = %s, bank->cpus = %u, bank->shared = %d)\n",
+        kobject_name(bank->kobj),
+        refcount_read(&bank->cpus),
+        bank->shared);
+
     list_for_each_entry_safe(pos, tmp, &bank->blocks->miscj, miscj) {
         list_del(&pos->miscj);
         kobject_put(&pos->kobj);
     }
 
     kobject_put(&bank->blocks->kobj);
+
+    pr_warn("EXIT deallocate_threshold_blocks()\n");
 }
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
@@ -1258,24 +1269,40 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
     struct threshold_block *pos = NULL;
     struct threshold_block *tmp = NULL;
 
+    pr_warn("ENTER __threshold_remove_blocks(bank name = %s, bank->cpus = %u, bank->shared = %d)\n",
+        kobject_name(b->kobj),
+        refcount_read(&b->cpus),
+        b->shared);
+
     kobject_del(b->kobj);
 
     list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
         kobject_del(&pos->kobj);
+
+    pr_warn("EXIT __threshold_remove_blocks()\n");
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)
 {
     struct amd_northbridge *nb;
+    pr_warn("ENTER threshold_remove_bank(bank name = %s, bank->cpus = %u, bank->shared = %d)\n",
+        kobject_name(bank->kobj),
+        refcount_read(&bank->cpus),
+        bank->shared);
 
-    if (!bank->blocks)
+    if (!bank->blocks) {
+        pr_warn("threshold_remove_bank: bank->blocks == NULL\n");
         goto out_free;
+        }
 
-    if (!bank->shared)
+    if (!bank->shared) {
+        pr_warn("threshold_remove_bank: bank->shared == NULL\n");
         goto out_dealloc;
+        }
 
     if (!refcount_dec_and_test(&bank->cpus)) {
         __threshold_remove_blocks(bank);
+        pr_warn("threshold_remove_bank: EXIT after __threshold_remove_blocks()\n");
         return;
     } else {
         /*
@@ -1283,6 +1310,7 @@ static void threshold_remove_bank(struct threshold_bank *bank)
          * away, remove that bank now.
          */
         nb = node_to_amd_nb(topology_die_id(smp_processor_id()));
+        pr_warn("threshold_remove_bank: setting nb->bank4 = NULL\n");
         nb->bank4 = NULL;
     }
 
@@ -1292,12 +1320,16 @@ static void threshold_remove_bank(struct threshold_bank *bank)
 out_free:
     kobject_put(bank->kobj);
     kfree(bank);
+
+    pr_warn("EXIT threshold_remove_bank(); \n");
 }
 
 static void __threshold_remove_device(struct threshold_bank **bp)
 {
     unsigned int bank, numbanks = this_cpu_read(mce_num_banks);
 
+    pr_warn("ENTER __threshold_remove_device(); numbanks=%u\n", numbanks);
+
     for (bank = 0; bank < numbanks; bank++) {
         if (!bp[bank])
             continue;
@@ -1306,14 +1338,19 @@ static void __threshold_remove_device(struct threshold_bank **bp)
         bp[bank] = NULL;
     }
     kfree(bp);
+    pr_warn("EXIT __threshold_remove_device()\n");
 }
 
 int mce_threshold_remove_device(unsigned int cpu)
 {
     struct threshold_bank **bp = this_cpu_read(threshold_banks);
 
-    if (!bp)
+    pr_warn("ENTER mce_threshold_remove_device(cpu = %u)\n", cpu);
+
+    if (!bp) {
+        pr_warn("EXIT mce_threshold_remove_device(cpu = %u): bp == NULL\n", cpu);
         return 0;
+    }
 
     /*
      * Clear the pointer before cleaning up, so that the interrupt won't
@@ -1322,6 +1359,8 @@ int mce_threshold_remove_device(unsigned int cpu)
     this_cpu_write(threshold_banks, NULL);
 
     __threshold_remove_device(bp);
+
+    pr_warn("EXIT mce_threshold_remove_device(cpu = %u)\n", cpu);
     return 0;
 }

