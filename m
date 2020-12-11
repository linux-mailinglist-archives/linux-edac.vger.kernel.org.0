Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF962D7DEC
	for <lists+linux-edac@lfdr.de>; Fri, 11 Dec 2020 19:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgLKSU0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Dec 2020 13:20:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37032 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394028AbgLKSUC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Dec 2020 13:20:02 -0500
Received: from zn.tnic (p200300ec2f124300da799288a8bc7530.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4300:da79:9288:a8bc:7530])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1FF71EC0545;
        Fri, 11 Dec 2020 19:19:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607710760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=RDVfxd7AKozIgTODuCAkkQUIQHLXJRKfrTeEOVdp+Y0=;
        b=gsFHf88A5rpeQVsNSNKq0UpI33ieZntIcXVHCF2BL6gufYHYawteRobo9zo6DI8tJV+8CN
        lsHDy7JblY1OfHLzhTyO91FUXOTaQO/UsfDEX6fJdRKqjb4k4sdIYFY35NGxJKCx71SjFL
        hQ8jyhvX8QdCVHJKPeJlsQqBGgJ/5DY=
Date:   Fri, 11 Dec 2020 19:19:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>
Subject: EDAC instances probing
Message-ID: <20201211181915.GD25974@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi guys,

so we converted a couple of EDAC drivers to per-CPU-family autoprobing
instead of the PCI device IDs one which needed constant adding of new
device IDs.

However easy the new probing is, it spams dmesg on each CPU as it tries
loading on each CPU, when there's no ECC DIMMs or ECC is disabled.
Here's the output from a 128 CPU box:

$ grep EDAC dmesg.log | sed 's/\[.*\] //' | sort | uniq -c
    128 EDAC amd64: F17h detected (node 0).
    128 EDAC amd64: Node 0: DRAM ECC disabled.
      1 EDAC MC: Ver: 3.0.0

that's 2 lines per CPU.

Btw, people have complained about the spamming.

So I tried something clumsy, see below, which fixes this into what it
should say:

$ dmesg | grep EDAC
[    2.693470] EDAC MC: Ver: 3.0.0
[    8.284461] EDAC amd64: F17h detected (node 0).
[    8.287953] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.381430] EDAC amd64: F17h detected (node 1).
[    8.384684] EDAC amd64: Node 1: DRAM ECC disabled.
[    8.461902] EDAC amd64: F17h detected (node 2).
[    8.461993] EDAC amd64: Node 2: DRAM ECC disabled.
[    8.536907] EDAC amd64: F17h detected (node 3).
[    8.538923] EDAC amd64: Node 3: DRAM ECC disabled.
[    8.643213] EDAC amd64: F17h detected (node 4).
[    8.645474] EDAC amd64: Node 4: DRAM ECC disabled.
[    8.713411] EDAC amd64: F17h detected (node 5).
[    8.714818] EDAC amd64: Node 5: DRAM ECC disabled.
[    8.807825] EDAC amd64: F17h detected (node 6).
[    8.809882] EDAC amd64: Node 6: DRAM ECC disabled.
[    8.908043] EDAC amd64: F17h detected (node 7).
[    8.910883] EDAC amd64: Node 7: DRAM ECC disabled.

Once per driver instance, however each driver accounts an instance -
logical node, physical node, whatever.

So it looks like this, do you guys think this is too ugly to live?

---
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f7087ddddb90..de37d0d9a27b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3581,6 +3581,7 @@ static int probe_one_instance(unsigned int nid)
 
 	dump_misc_regs(pvt);
 
+	set_bit(nid, edac_get_probed_instances());
 	return ret;
 
 err_enable:
@@ -3591,6 +3592,7 @@ static int probe_one_instance(unsigned int nid)
 	kfree(s);
 	ecc_stngs[nid] = NULL;
 
+	set_bit(nid, edac_get_probed_instances());
 err_out:
 	return ret;
 }
@@ -3674,6 +3676,10 @@ static int __init amd64_edac_init(void)
 		goto err_free;
 
 	for (i = 0; i < amd_nb_num(); i++) {
+
+		if (test_bit(i, edac_get_probed_instances()))
+			continue;
+
 		err = probe_one_instance(i);
 		if (err) {
 			/* unwind properly */
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..f97186237ccc 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -53,6 +53,15 @@ static LIST_HEAD(mc_devices);
  */
 static const char *edac_mc_owner;
 
+/* bitmap of already probed driver instances, 64 should be big enough. :-P */
+static DECLARE_BITMAP(probed_instances, 64);
+
+unsigned long *edac_get_probed_instances(void)
+{
+	return probed_instances;
+}
+EXPORT_SYMBOL_GPL(edac_get_probed_instances);
+
 static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *e)
 {
 	return container_of(e, struct mem_ctl_info, error_desc);
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..7c0d4ac7c35a 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -255,4 +255,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
  */
 extern char *edac_op_state_to_string(int op_state);
 
+unsigned long *edac_get_probed_instances(void);
+
 #endif				/* _EDAC_MC_H_ */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
