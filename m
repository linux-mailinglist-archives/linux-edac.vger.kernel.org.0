Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F55B4826
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIJTnf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIJTnU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:43:20 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 623AD491FF;
        Sat, 10 Sep 2022 12:43:08 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 040BADBB;
        Sat, 10 Sep 2022 22:46:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 040BADBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839196;
        bh=/Wwg8uRjXKA66HOYpbFIEeBk3ZXkTNU7lcZPEN/Bn58=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=es49GdaWF9p95PslD2CzSHdhFXGgFNT5y96OYV7re5NCTnDCJovgvwGBUZmpEgYj2
         6sSa5j53hW4IV6wL9tcJjnCCVMxRreHIWGdFzO6is6c6CXvVcsZmh/TbRZcMY+VhiG
         362Ot1OjzoyCPbObSDECbJBTjLxPdM5ffuYW7HwU=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:42:45 +0300
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
Subject: [PATCH v2 07/19] EDAC/synopsys: Drop internal CE and UE counters
Date:   Sat, 10 Sep 2022 22:42:25 +0300
Message-ID: <20220910194237.10142-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
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

First of all they aren't exposed anyhow by the driver. Secondly the EDAC
core already tracks the total amount of correctable and uncorrectable
errors (see mem_ctl_info.{ce_mc,ue_mc} fields usage). Let's drop the
useless internal counters then for good.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e9002d9b3f09..592c7753184f 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -309,8 +309,6 @@ struct synps_ecc_status {
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
- * @ce_cnt:		Correctable Error count.
- * @ue_cnt:		Uncorrectable Error count.
  * @poison_addr:	Data poison address.
  * @row_shift:		Bit shifts for row bit.
  * @col_shift:		Bit shifts for column bit.
@@ -324,8 +322,6 @@ struct synps_edac_priv {
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
-	u32 ce_cnt;
-	u32 ue_cnt;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -595,12 +591,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	if (status)
 		return IRQ_NONE;
 
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
 	handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-- 
2.37.2

