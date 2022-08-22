Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3266E59C891
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiHVTWF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiHVTU7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:20:59 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0512313D6D;
        Mon, 22 Aug 2022 12:20:39 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id ED464DAD;
        Mon, 22 Aug 2022 22:23:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com ED464DAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661196217;
        bh=ht7KqreX8ihKT1N4QxMPo0HkcPkOUBLxn2ek+VY5KSg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Pw7HORzRAqthHhixeV0/T8FmbR+puEz3lYtBC/rl3W7FENwGAgdMRgnKRrAYh1dNN
         I4sIR3y/RBcnvOvoH24LrTQZ52odiNr85xXZX9WwoIhPAyQI+hil3NK0CCBdbzENq+
         RQdfM3xdn+lr1DX0u+//x34ez2sgPmRp6hVoBh2U=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:20:23 +0300
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
Subject: [PATCH 12/13] EDAC/synopsys: Drop vendor-specific arch dependency
Date:   Mon, 22 Aug 2022 22:19:55 +0300
Message-ID: <20220822191957.28546-13-Sergey.Semin@baikalelectronics.ru>
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

DW uMCTL2 DDRC EDAC driver is no longer specific to particular DDRC
versions. It's generic in the most of the aspects now. So set its kernel
config independently from the ZynqMP/IntelFPAG/MXC platforms.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 98bcdadf4143..6aa59a0bacf1 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -486,7 +486,6 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
-- 
2.35.1

