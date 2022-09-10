Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617F45B48AF
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 22:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIJT66 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIJT5y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:57:54 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BDCC49B49;
        Sat, 10 Sep 2022 12:57:32 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E4F25DA8;
        Sat, 10 Sep 2022 23:01:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E4F25DA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840061;
        bh=2UfJcOKW2OlCpYF3e9k7H5AeuHeixk7MbgbcV4mzR8M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Yj1BiRqxaYjw9HyNECKVsHUz+eht4mmrIZVquyk0CNeILD+vLwIFTb1w0d7G72Dtp
         2931nuYHqFTXn0RX2w05k8pqPmAIwNKka0kTin4mJg+epYwvSWAxx9oHfIC8QXKnDg
         VM8nWpgs4hrcQLfrx2FsuwOPfkOwu2zGO6Hc/M8c=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:57:11 +0300
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
Subject: [PATCH v2 15/15] EDAC/synopsys: Add Baikal-T1 DDRC support
Date:   Sat, 10 Sep 2022 22:56:59 +0300
Message-ID: <20220910195659.11843-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.37.2

