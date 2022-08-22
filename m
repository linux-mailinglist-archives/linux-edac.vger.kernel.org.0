Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDF59C7F3
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiHVTIO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbiHVTII (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:08:08 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 924801837A;
        Mon, 22 Aug 2022 12:08:05 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 5CC64DB0;
        Mon, 22 Aug 2022 22:10:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 5CC64DB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195455;
        bh=vb0QIxWsGVxI7xbQMdgDI1FWdI8H7WgLTCPN5ZxLhDE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Lw8uUjjEB5PunGS6XcLpXwBhCIJ7V4hVarPsPfvpXdZpDko0vv7Iol9UyKZeIn5Rg
         64HPVacEIpPWjPTMs2NGyWoLaxUoEo/wsP+bEb4gsQhbt35CRHbB/CYh3+dsl1Duhb
         HXwiDNASyHtvzZNZNMTb0ZZosqSlOMUhqZWHSgHw=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:41 +0300
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
Subject: [PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout
Date:   Mon, 22 Aug 2022 22:07:23 +0300
Message-ID: <20220822190730.27277-14-Sergey.Semin@baikalelectronics.ru>
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

The duplicated edac_dbg()-based dimm->nr_pages field was introduced in
commit 6e84d359b2be ("edac_mc: Cleanup per-dimm_info debug messages"). You
can find the duplicated line even in the commit message text:
> [ 1011.380101] EDAC DEBUG: edac_mc_dump_dimm:   dimm->nr_pages = 0x40000
> [ 1011.380103] EDAC DEBUG: edac_mc_dump_dimm:   dimm->grain = 8
> [ 1011.380104] EDAC DEBUG: edac_mc_dump_dimm:   dimm->nr_pages = 0x40000
Let's drop the corresponding edac_dbg() method call then.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/edac_mc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index eb58644bb019..6faeb2ab3960 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -103,7 +103,6 @@ static void edac_mc_dump_dimm(struct dimm_info *dimm)
 	edac_dbg(4, "  dimm->label = '%s'\n", dimm->label);
 	edac_dbg(4, "  dimm->nr_pages = 0x%x\n", dimm->nr_pages);
 	edac_dbg(4, "  dimm->grain = %d\n", dimm->grain);
-	edac_dbg(4, "  dimm->nr_pages = 0x%x\n", dimm->nr_pages);
 }
 
 static void edac_mc_dump_csrow(struct csrow_info *csrow)
-- 
2.35.1

