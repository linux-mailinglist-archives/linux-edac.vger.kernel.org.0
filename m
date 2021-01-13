Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227412F542F
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jan 2021 21:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbhAMUeI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jan 2021 15:34:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbhAMUeI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Jan 2021 15:34:08 -0500
Received: from zn.tnic (p200300ec2f0b5c008b135c504218dbb0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5c00:8b13:5c50:4218:dbb0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3BC11EC0328;
        Wed, 13 Jan 2021 21:33:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610570006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gs5XV09kFPO/LzcGSrWIs+ddVaQyPgG2ssQWVMfMQ2U=;
        b=DxjWT8Ui/OLnNujmMRblgBuGJ4OGZfdT91uTYlWrvlI3t95zfeVEx7iyCNbIRQYIiUzNus
        +T3MVY47eW9CQxUIKS90x7kRf/J7jaOdMyJTRWMMa+cQHmHRd/DCKOM/3tMYnWwLVhxBJF
        yjOM2hTgXBJSuV/+A5/4w1xGOlstHrs=
Date:   Wed, 13 Jan 2021 21:33:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: EDAC instances probing
Message-ID: <20210113203316.GI16960@zn.tnic>
References: <20201211181915.GD25974@zn.tnic>
 <20201211203520.GA2128@yaz-nikka.amd.com>
 <20201211205850.GH25974@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201211205850.GH25974@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I'm soo stupid. Usually I do the simplest solution but this time it has
escaped me.

But I caught it now:

---
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9868f95a5622..105d00b27be2 100644
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
 
@@ -3867,6 +3861,12 @@ static int probe_one_instance(unsigned int nid)
 
 	dump_misc_regs(pvt);
 
+	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
+		     (pvt->fam == 0xf ?
+				(pvt->ext_model >= K8_REV_F  ? "revF or later "
+							     : "revE or earlier ")
+				 : ""), pvt->mc_node_id);
+
 	return ret;
 
 err_enable:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
