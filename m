Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841C55B4841
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiIJTn5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIJTng (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:43:36 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D48624A131;
        Sat, 10 Sep 2022 12:43:12 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9F225DBC;
        Sat, 10 Sep 2022 22:46:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9F225DBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839196;
        bh=c2KDKfbI5k0kD8up5rTK06u62IYkdIDkizAoNpJYaaE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=p2DtjjMOx6Hyj5aXks0jWPL3YxKfCUaJAoCAxbGPjfedE2okLXcXfmV8leXURXbOP
         gzGFYqnhKrygZ7/Z9gIroEpbSaZxMQ4QL7MJP3Ah3ll02D7LlBrlKKlvm8QdjMAG+k
         EFJJ52juIKqUvJQrVWytqXdURmNeO3dP4WKZYM7s=
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
Subject: [PATCH v2 08/19] EDAC/synopsys: Drop local to_mci macro implementation
Date:   Sat, 10 Sep 2022 22:42:26 +0300
Message-ID: <20220910194237.10142-9-Sergey.Semin@baikalelectronics.ru>
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

The to_mci macro was added in commit 1a81361f75d8 ("EDAC, synopsys: Add
Error Injection support for ZynqMP DDR controller") together with the
errors injection debug feature. It turns our the macro with the same
semantic and name has already been defined in the edac_mc.h (former
edac_core.h) header file. No idea why it was needed to have a local
version with the same semantic, but now there is no point in that. Drop
the local implementation for good then.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 592c7753184f..9a039aa0c308 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -949,7 +949,6 @@ static const struct of_device_id synps_edac_match[] = {
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
 #ifdef CONFIG_EDAC_DEBUG
-#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
 
 /**
  * ddr_poison_setup -	Update poison registers.
-- 
2.37.2

