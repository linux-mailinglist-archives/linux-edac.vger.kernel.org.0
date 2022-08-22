Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD959C84B
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiHVTOk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiHVTOj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:14:39 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3C3828E36;
        Mon, 22 Aug 2022 12:14:37 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6268ADA4;
        Mon, 22 Aug 2022 22:17:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6268ADA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195866;
        bh=TPeq2Si62asloW2zZBCIFMbdjMgkAtayM/DHkCBcuBM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ps01/HuGO90TcQOPy6kYseX+Pzvr5Fz7B76pWKvfjwO7V7nQ+sN7gijgl7AvCn8F6
         FDklrB4ycJ+n8e0XFD1OiAQPGsR99VRyBRRFuJcuvcc6Z88eGrHkhooVaUfzrrNviR
         NKn+56dIQoMZvfy+gyqWUncKylK+S2k3M9y3tHM4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:30 +0300
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/18] EDAC/mc: Extend memtypes with LPDDR(mDDR) and LPDDR2
Date:   Mon, 22 Aug 2022 22:14:11 +0300
Message-ID: <20220822191427.27969-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

These are normal memory types [1] which can be met on the real hardware.
DW uMCTL2 DDRC IP-core can be configured to have them supported [2,3].
Let's extend the EDAC memory types enumeration with the corresponding IDs
then.

[1] https://en.wikipedia.org/wiki/LPDDR
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.501
[3] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p.1717

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/edac_mc.c | 2 ++
 include/linux/edac.h   | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 634c41ea7804..e353e98e01e2 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -151,10 +151,12 @@ const char * const edac_mem_types[] = {
 	[MEM_RDR]	= "Registered-SDR",
 	[MEM_DDR]	= "Unbuffered-DDR",
 	[MEM_RDDR]	= "Registered-DDR",
+	[MEM_LPDDR]	= "Low-Power-(m)DDR-RAM",
 	[MEM_RMBS]	= "RMBS",
 	[MEM_DDR2]	= "Unbuffered-DDR2",
 	[MEM_FB_DDR2]	= "FullyBuffered-DDR2",
 	[MEM_RDDR2]	= "Registered-DDR2",
+	[MEM_LPDDR2]	= "Low-Power-DDR2-RAM",
 	[MEM_XDR]	= "XDR",
 	[MEM_DDR3]	= "Unbuffered-DDR3",
 	[MEM_RDDR3]	= "Registered-DDR3",
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..89167a4459d5 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -157,6 +157,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  *			This is a variant of the DDR memories.
  *			A registered memory has a buffer inside it, hiding
  *			part of the memory details to the memory controller.
+ * @MEM_LPDDR:		Low-Power DDR memory (mDDR).
  * @MEM_RMBS:		Rambus DRAM, used on a few Pentium III/IV controllers.
  * @MEM_DDR2:		DDR2 RAM, as described at JEDEC JESD79-2F.
  *			Those memories are labeled as "PC2-" instead of "PC" to
@@ -167,6 +168,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  *			a chip select signal.
  * @MEM_RDDR2:		Registered DDR2 RAM
  *			This is a variant of the DDR2 memories.
+ * @MEM_LPDDR2:		Low-Power DDR2 memory.
  * @MEM_XDR:		Rambus XDR
  *			It is an evolution of the original RAMBUS memories,
  *			created to compete with DDR2. Weren't used on any
@@ -199,10 +201,12 @@ enum mem_type {
 	MEM_RDR,
 	MEM_DDR,
 	MEM_RDDR,
+	MEM_LPDDR,
 	MEM_RMBS,
 	MEM_DDR2,
 	MEM_FB_DDR2,
 	MEM_RDDR2,
+	MEM_LPDDR2,
 	MEM_XDR,
 	MEM_DDR3,
 	MEM_RDDR3,
@@ -230,10 +234,12 @@ enum mem_type {
 #define MEM_FLAG_RDR		BIT(MEM_RDR)
 #define MEM_FLAG_DDR		BIT(MEM_DDR)
 #define MEM_FLAG_RDDR		BIT(MEM_RDDR)
+#define MEM_FLAG_LPDDR		BIT(MEM_LPDDR)
 #define MEM_FLAG_RMBS		BIT(MEM_RMBS)
 #define MEM_FLAG_DDR2		BIT(MEM_DDR2)
 #define MEM_FLAG_FB_DDR2	BIT(MEM_FB_DDR2)
 #define MEM_FLAG_RDDR2		BIT(MEM_RDDR2)
+#define MEM_FLAG_LPDDR2		BIT(MEM_LPDDR2)
 #define MEM_FLAG_XDR		BIT(MEM_XDR)
 #define MEM_FLAG_DDR3		BIT(MEM_DDR3)
 #define MEM_FLAG_RDDR3		BIT(MEM_RDDR3)
-- 
2.35.1

