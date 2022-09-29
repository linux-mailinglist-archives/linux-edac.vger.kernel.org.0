Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF35F1817
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiJABOY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiJABOU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:20 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C1E31262D;
        Fri, 30 Sep 2022 18:14:12 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 46568E0ECA;
        Fri, 30 Sep 2022 02:27:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Jg6A2tfxOzNgGT4avwsXtljvj9hjtMePgR4Isdw42jc=; b=Kgenq2VZ6ec5
        P+yJvszCIqACL5/FK26zFAc5yAkNPwJZbbdhXxZYXd5S0z1h7hOIgkY2F04/bFjs
        RnppGGYzsbsAX0lZ+WboifDc+O8POZKaNkvVDHhlTU/0Rlvx14S4OnUo+1TvCY9c
        fmALpnmnzAHLm1IEfehwvouuqAduTDk=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 35A47E0E6B;
        Fri, 30 Sep 2022 02:27:32 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 12/17] EDAC/mc: Init DIMM labels in MC registration method
Date:   Fri, 30 Sep 2022 02:27:07 +0300
Message-ID: <20220929232712.12202-13-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

As a preparation before adding the unique MC index allocation procedure we
need to move the DIMM labels initialization to the memory controller
registration method. It's required because the labels contain the MC index
as the "mc%u" part of the string, which in case of the auto-generated
index isn't available at the moment of the MCI/csrow/dimms descriptor
allocation.

So nothing complex is done here. Just move the labels initialization from
edac_mc_alloc_dimms() to the dedicated method edac_mc_init_labels() and
call it from edac_mc_add_mc_with_groups().

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/edac_mc.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..24814839d885 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -256,7 +256,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	unsigned int pos[EDAC_MAX_LAYERS];
 	unsigned int row, chn, idx;
 	int layer;
-	void *p;
 
 	/*
 	 * Allocate and fill the dimm structs
@@ -271,7 +270,6 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	for (idx = 0; idx < mci->tot_dimms; idx++) {
 		struct dimm_info *dimm;
 		struct rank_info *chan;
-		int n, len;
 
 		chan = mci->csrows[row]->channels[chn];
 
@@ -282,22 +280,9 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 		dimm->mci = mci;
 		dimm->idx = idx;
 
-		/*
-		 * Copy DIMM location and initialize it.
-		 */
-		len = sizeof(dimm->label);
-		p = dimm->label;
-		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
-		p += n;
-		len -= n;
-		for (layer = 0; layer < mci->n_layers; layer++) {
-			n = scnprintf(p, len, "%s#%u",
-				      edac_layer_name[mci->layers[layer].type],
-				      pos[layer]);
-			p += n;
-			len -= n;
+		/* Copy DIMM location */
+		for (layer = 0; layer < mci->n_layers; layer++)
 			dimm->location[layer] = pos[layer];
-		}
 
 		/* Link it to the csrows old API data */
 		chan->dimm = dimm;
@@ -510,6 +495,33 @@ void edac_mc_reset_delay_period(unsigned long value)
 
 
 
+/**
+ * edac_mc_init_labels() - Initialize DIMM labels
+ *
+ * @mci: pointer to the mci structure which DIMM labels need to be initialized
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_init_labels(struct mem_ctl_info *mci)
+{
+	int n, len, layer;
+	unsigned int idx;
+	char *p;
+
+	for (idx = 0; idx < mci->tot_dimms; idx++) {
+		len = sizeof(mci->dimms[idx]->label);
+		p = mci->dimms[idx]->label;
+
+		n = scnprintf(p, len, "mc#%u", mci->mc_idx);
+		for (layer = 0; layer < mci->n_layers; layer++) {
+			n += scnprintf(p + n, len - n, "%s#%u",
+				      edac_layer_name[mci->layers[layer].type],
+				      mci->dimms[idx]->location[layer]);
+		}
+	}
+}
+
 /* Return 0 on success, 1 on failure.
  * Before calling this function, caller must
  * assign a unique value to mci->mc_idx.
@@ -637,6 +649,8 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	edac_mc_init_labels(mci);
+
 	if (add_mc_to_global_list(mci))
 		goto fail0;
 
-- 
2.37.3


