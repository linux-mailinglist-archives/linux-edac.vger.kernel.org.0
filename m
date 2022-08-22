Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2659559C807
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiHVTIL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiHVTIE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:08:04 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92FA217077;
        Mon, 22 Aug 2022 12:08:03 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id B278EDAF;
        Mon, 22 Aug 2022 22:10:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com B278EDAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195454;
        bh=MFqtz4e6LUMNlPiynDJkvf6PvWJf7XGMfVZ0Nv/X6dg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=YTMlJUTnCcXKcJCSzbIULdjIVWhVDDKIr/knpr/VnPcBb8ZrjzZWi7hYwVGvJ+VT0
         3BIEJj3lDdxS3pSSjmXdX+4pWCVET0SVZBleovyFausbDz0XE8zVU2KsGGTo+Szstv
         X4VbVvoGXQDvAkSnAycbNEQAgsxTWiyE2rLXTGPs=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:40 +0300
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
Subject: [PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
Date:   Mon, 22 Aug 2022 22:07:22 +0300
Message-ID: <20220822190730.27277-13-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently the memory type macros are partly defined with the multiple
spaces between the macro name and its definition. Let's replace the spaces
with tabs as the kernel coding style requires.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 include/linux/edac.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/edac.h b/include/linux/edac.h
index e730b3468719..fa4bda2a70f6 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -231,21 +231,21 @@ enum mem_type {
 #define MEM_FLAG_DDR		BIT(MEM_DDR)
 #define MEM_FLAG_RDDR		BIT(MEM_RDDR)
 #define MEM_FLAG_RMBS		BIT(MEM_RMBS)
-#define MEM_FLAG_DDR2           BIT(MEM_DDR2)
-#define MEM_FLAG_FB_DDR2        BIT(MEM_FB_DDR2)
-#define MEM_FLAG_RDDR2          BIT(MEM_RDDR2)
-#define MEM_FLAG_XDR            BIT(MEM_XDR)
-#define MEM_FLAG_DDR3           BIT(MEM_DDR3)
-#define MEM_FLAG_RDDR3          BIT(MEM_RDDR3)
-#define MEM_FLAG_LPDDR3         BIT(MEM_LPDDR3)
-#define MEM_FLAG_DDR4           BIT(MEM_DDR4)
-#define MEM_FLAG_RDDR4          BIT(MEM_RDDR4)
-#define MEM_FLAG_LRDDR4         BIT(MEM_LRDDR4)
-#define MEM_FLAG_LPDDR4         BIT(MEM_LPDDR4)
-#define MEM_FLAG_DDR5           BIT(MEM_DDR5)
-#define MEM_FLAG_RDDR5          BIT(MEM_RDDR5)
-#define MEM_FLAG_LRDDR5         BIT(MEM_LRDDR5)
-#define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
+#define MEM_FLAG_DDR2		BIT(MEM_DDR2)
+#define MEM_FLAG_FB_DDR2	BIT(MEM_FB_DDR2)
+#define MEM_FLAG_RDDR2		BIT(MEM_RDDR2)
+#define MEM_FLAG_XDR		BIT(MEM_XDR)
+#define MEM_FLAG_DDR3		BIT(MEM_DDR3)
+#define MEM_FLAG_RDDR3		BIT(MEM_RDDR3)
+#define MEM_FLAG_LPDDR3		BIT(MEM_LPDDR3)
+#define MEM_FLAG_DDR4		BIT(MEM_DDR4)
+#define MEM_FLAG_RDDR4		BIT(MEM_RDDR4)
+#define MEM_FLAG_LRDDR4		BIT(MEM_LRDDR4)
+#define MEM_FLAG_LPDDR4		BIT(MEM_LPDDR4)
+#define MEM_FLAG_DDR5		BIT(MEM_DDR5)
+#define MEM_FLAG_RDDR5		BIT(MEM_RDDR5)
+#define MEM_FLAG_LRDDR5		BIT(MEM_LRDDR5)
+#define MEM_FLAG_NVDIMM		BIT(MEM_NVDIMM)
 #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
 #define MEM_FLAG_HBM2		BIT(MEM_HBM2)
 
-- 
2.35.1

