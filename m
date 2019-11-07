Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83DF2CB1
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfKGKjI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 05:39:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46172 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbfKGKjI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 05:39:08 -0500
Received: from zn.tnic (p200300EC2F0EAD00D550E8D60855E7CD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:d550:e8d6:855:e7cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD56F1EC014A;
        Thu,  7 Nov 2019 11:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573123142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oYXCV6R9J1ueEHLss+nq+10lxPXIIPwFikS8Q8Y6JkI=;
        b=eUKKS4zXu3vliD5VNO8HgtmVb3xrphKFnuEHO6Kz2mwxUKh2oGYBmpCVQb+1SeYzqZtcOu
        E9Wv6eL7HTgtGJXPdXRz7+e0osITvpvNAj60yvxrBQjTuv8L/iQ6nrPLKkmREeree31h0B
        nyZbbjgmUeWEfTEqs7sCSaX7lqL9fVA=
Date:   Thu, 7 Nov 2019 11:38:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191107103857.GC19501@zn.tnic>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191106195417.GF28380@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106195417.GF28380@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 06, 2019 at 08:54:17PM +0100, Borislav Petkov wrote:
> which are also two attempts.
> 
> Anyway, I'll queue your set and I'll try to debug that thing because it
> is getting on my nerves slowly...

Yah, the problem is that because we have:

MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);

it gets tried on each CPU because an uevent gets dispatched for each
device, and each CPU is a device.

That's why I see it twice on this box - it has two CPUs.

And Greg says making it attempt once per system can't be done. Unless we
start doing hacks with sending uevents per BSP only which is too much.
Or we can remember the previous return value of the module init function
into edac_core but that's nasty too.

I'm thinking we should simply kill this fat ecc_msg thing which is not
very useful and be done with it:

[    5.697275] EDAC MC: Ver: 3.0.0
[    5.909530] EDAC amd64: F10h detected (node 0).
[    6.345231] EDAC amd64: Node 0: DRAM ECC disabled.
[    6.370815] EDAC amd64: F10h detected (node 0).
[    6.370929] EDAC amd64: Node 0: DRAM ECC disabled.

That's probably still a bit annoying on a large machine but better than
nothing.

---
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3aeb5173e200..0738237e3f09 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3188,18 +3188,6 @@ static void restore_ecc_error_reporting(struct ecc_settings *s, u16 nid,
 		amd64_warn("Error restoring NB MCGCTL settings!\n");
 }
 
-/*
- * EDAC requires that the BIOS have ECC enabled before
- * taking over the processing of ECC errors. A command line
- * option allows to force-enable hardware ECC later in
- * enable_ecc_error_reporting().
- */
-static const char *ecc_msg =
-	"ECC disabled in the BIOS or no ECC capability, module will not load.\n"
-	" Either enable ECC checking or force module loading by setting "
-	"'ecc_enable_override'.\n"
-	" (Note that use of the override may cause unknown side effects.)\n";
-
 static bool ecc_enabled(struct amd64_pvt *pvt)
 {
 	u16 nid = pvt->mc_node_id;
@@ -3246,11 +3234,10 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
 	amd64_info("Node %d: DRAM ECC %s.\n",
 		   nid, (ecc_en ? "enabled" : "disabled"));
 
-	if (!ecc_en || !nb_mce_en) {
-		amd64_info("%s", ecc_msg);
+	if (!ecc_en || !nb_mce_en)
 		return false;
-	}
-	return true;
+	else
+		return true;
 }
 
 static inline void

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
