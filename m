Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9AE59C802
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiHVTIG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbiHVTIC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:08:02 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0096A13F92;
        Mon, 22 Aug 2022 12:07:51 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 42807DA9;
        Mon, 22 Aug 2022 22:10:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 42807DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195451;
        bh=rPnXGa4E/xeGmWWRdl2JzvAT9t1e1g5ZyBEEG7gtGKA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dlMppze5hfaT9XcEGB4Rhdb2khUYJQL36GunK5EFQfifRJ98ZHnxlJkSUwqOo/r4E
         Sagaz/FI0ztBm/3pgycGqLEe2fuK8LjR/uerGHUKFqvPHhg9xaQpVnlBW1huDvsIOH
         hr6M/vB5D7Qx6KVRH/Wx6+OCrGdzN0Yu0D/nPXz8=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:37 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>,
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/20] EDAC/synopsys: Drop internal CE and UE counters
Date:   Mon, 22 Aug 2022 22:07:17 +0300
Message-ID: <20220822190730.27277-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
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

First of all they aren't exposed anyhow by the driver. Secondly the EDAC
core already tracks the total amount of correctable and uncorrectable
errors (see mem_ctl_info.{ce_mc,ue_mc} fields usage). Let's drop the
useless internal counters then for good.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f38c326f2cf5..956de6fb3125 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -308,8 +308,6 @@ struct synps_ecc_status {
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
- * @ce_cnt:		Correctable Error count.
- * @ue_cnt:		Uncorrectable Error count.
  * @poison_addr:	Data poison address.
  * @row_shift:		Bit shifts for row bit.
  * @col_shift:		Bit shifts for column bit.
@@ -323,8 +321,6 @@ struct synps_edac_priv {
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
-	u32 ce_cnt;
-	u32 ue_cnt;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -594,12 +590,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
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
2.35.1

