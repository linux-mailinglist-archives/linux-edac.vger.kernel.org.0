Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F95859C8B0
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiHVTWG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiHVTVA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:21:00 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21B7B1835F;
        Mon, 22 Aug 2022 12:20:41 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A9BF0DA4;
        Mon, 22 Aug 2022 22:23:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A9BF0DA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661196218;
        bh=/tarMJ/Lpj3lIo7Fjjl2T4vGuOsDP7eZcPqYpQHmyVA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=AZgKD+ROYiobj4UbtS2PCkhDBf1p0+AAaqTuVPXRQZus1qjGmWJan6PRcgf3/MVMj
         NJ27n6XkwcZr/ORq5JeGVY66k27tMRLBREGblr/90OoW0bB22xu9XbR12x983VFHhw
         seyXp6YOdG3WNxxYeZoOJcRauBJ9jNlqM4tJP+Y4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:20:24 +0300
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
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/13] EDAC/synopsys: Add Baikal-T1 DDRC support
Date:   Mon, 22 Aug 2022 22:19:56 +0300
Message-ID: <20220822191957.28546-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
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
index f86d1be2702a..9780f61ac84c 100644
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
2.35.1

