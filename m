Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAF5F1725
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiJAAVG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiJAAUg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:20:36 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D59336DC8;
        Fri, 30 Sep 2022 17:19:11 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id CE36EE0EF4;
        Fri, 30 Sep 2022 02:41:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=tIFko1L6or88/GVnsEDwf0248T9U3azU2y4h1UIalJo=; b=nXFrPkkrCooC
        cJf+DC2Xy1Xgu8TZDAoy5YzJXJA5J4axFdnC3opfES1zF87HNqaZLto+5mqgQXed
        hpLKnda9hvmyw3J53/pivKYRjYrZ24tOOI0dAJZL3rHsIlUbxYICNKxBPAOqA6+/
        9rgsdEzvbi39SST5OoKnU8OTqMczQec=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C2824E0EEA;
        Fri, 30 Sep 2022 02:41:35 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:41:36 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 13/13] EDAC/synopsys: Add Baikal-T1 DDRC support
Date:   Fri, 30 Sep 2022 02:41:21 +0300
Message-ID: <20220929234121.13955-14-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
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

Baikal-T1 SoC is equipped with the DW uMCTl2 DDRC of v2.61a with 32-bit
DQ-bus accepting DDR2/DDR3 SDRAMs of up to 2 ranks, 1:2 HIF/SDRAM clocks
rate ratio, HIF interface burst length of 8 Full DQ-bus words, 40-bit
System/Application address width and 128-bits data width, 3 System address
regions with block size 256MB. There is SEC/DED ECC capability with Scrub
(RMW) and Scrubber features.

Since the Baikal-T1 DDR controller is capable of the ECC let's add it to
the DW uMCTL2 DDRC EDAC driver. The most of the parameters above will be
autodetected except HIF burst length and SAR block size, which will be set
by means of the Baikal-T1-specific initialization method. The controller
compatible string "baikal,bt1-ddrc" will be used to attach the driver to
the kernel device. It's chosen in accordance with the just updated
DT-bindings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0a00e80ddeb9..24cd8f23242a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1342,6 +1342,20 @@ static int zynqmp_init_plat(struct snps_edac_priv *priv)
 	return 0;
 }
 
+/*
+ * bt1_init_plat - Baikal-T1-specific platform initialization.
+ * @priv:	DDR memory controller private data.
+ *
+ * Return: always zero.
+ */
+static int bt1_init_plat(struct snps_edac_priv *priv)
+{
+	priv->info.hif_burst_len = SNPS_DDR_BL8;
+	priv->sys_app_map.minsize = DDR_MIN_SARSIZE;
+
+	return 0;
+}
+
 /**
  * snps_get_dtype - Return the controller memory width.
  * @mstr:	Master CSR value.
@@ -2470,6 +2484,7 @@ static int snps_mc_remove(struct platform_device *pdev)
 
 static const struct of_device_id snps_edac_match[] = {
 	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = zynqmp_init_plat },
+	{ .compatible = "baikal,bt1-ddrc", .data = bt1_init_plat },
 	{ .compatible = "snps,ddrc-3.80a" },
 	{ }
 };
-- 
2.37.3


