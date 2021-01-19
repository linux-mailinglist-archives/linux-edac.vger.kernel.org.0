Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDA82FBCC7
	for <lists+linux-edac@lfdr.de>; Tue, 19 Jan 2021 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbhASQqG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jan 2021 11:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389476AbhASQmd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Jan 2021 11:42:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA92C061574;
        Tue, 19 Jan 2021 08:41:50 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca005ed5ab9a356b3c50.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:5ed5:ab9a:356b:3c50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D9BF1EC0622;
        Tue, 19 Jan 2021 17:41:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611074509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Nv5jEc80G7wIwGUWg/8u6iDRcfP4GOU2xU+S4vSqdhM=;
        b=cDZk3NDXmtZkGgYH3An5E3NgTLjk31sxorcy0zuCXX7FUml2fHLNT97eMj0yxlSiSMKj3R
        NI5K9ONgS+23GMpQeqdDWtdWCoYjMqdhDTfP1kSRBJcWzhOht1uQY36j49IlJc8rlH4/Ol
        HyugGkJpiTqiL4msbKrfCuRfW4kZjrw=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/amd64: Issue probing messages only on properly detected hardware
Date:   Tue, 19 Jan 2021 17:41:41 +0100
Message-Id: <20210119164141.17417-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

amd64_edac was converted to CPU family autoprobing (from PCI device IDs)
to not have to add a new PCI device ID a new platform is shipped but to
support the whole family directly.

However, this caused a lot of noise in dmesg even when the machine
doesn't have ECC DIMMs or ECC has been disabled in the BIOS:

  EDAC MC: Ver: 3.0.0
  EDAC amd64: F17h detected (node 0).
  EDAC amd64: Node 0: DRAM ECC disabled.
  EDAC amd64: F17h detected (node 1).
  EDAC amd64: Node 1: DRAM ECC disabled.
  EDAC amd64: F17h detected (node 2).
  EDAC amd64: Node 2: DRAM ECC disabled.
  EDAC amd64: F17h detected (node 3).
  EDAC amd64: Node 3: DRAM ECC disabled.
  EDAC amd64: F17h detected (node 4).
  EDAC amd64: Node 4: DRAM ECC disabled.
  EDAC amd64: F17h detected (node 5).
  EDAC amd64: Node 5: DRAM ECC disabled.
  EDAC amd64: F17h detected (node 6).
  EDAC amd64: Node 6: DRAM ECC disabled.
  EDAC amd64: F17h detected (node 7).
  EDAC amd64: Node 7: DRAM ECC disabled.

or even

$ grep EDAC dmesg.log | sed 's/\[.*\] //' | sort | uniq -c
    128 EDAC amd64: F17h detected (node 0).
    128 EDAC amd64: Node 0: DRAM ECC disabled.
      1 EDAC MC: Ver: 3.0.0

on a big machine. Yap, that's once per CPU for 128 of them.

So move the init messages after all probing has succeeded to avoid
unnecessary spew in dmesg.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/amd64_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9868f95a5622..9fa4dfc6ebee 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3528,8 +3528,7 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 				     MSR_IA32_MCG_CTL, nid);
 	}
 
-	amd64_info("Node %d: DRAM ECC %s.\n",
-		   nid, (ecc_en ? "enabled" : "disabled"));
+	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
 
 	if (!ecc_en || !nb_mce_en)
 		return false;
@@ -3689,11 +3688,6 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		return NULL;
 	}
 
-	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
-		     (pvt->fam == 0xf ?
-				(pvt->ext_model >= K8_REV_F  ? "revF or later "
-							     : "revE or earlier ")
-				 : ""), pvt->mc_node_id);
 	return fam_type;
 }
 
@@ -3865,6 +3859,12 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
+	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
+		     (pvt->fam == 0xf ?
+				(pvt->ext_model >= K8_REV_F  ? "revF or later "
+							     : "revE or earlier ")
+				 : ""), pvt->mc_node_id);
+
 	dump_misc_regs(pvt);
 
 	return ret;
-- 
2.29.2

