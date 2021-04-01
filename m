Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4021E351434
	for <lists+linux-edac@lfdr.de>; Thu,  1 Apr 2021 13:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhDALHS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Apr 2021 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhDALGk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Apr 2021 07:06:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B0C0613E6
        for <linux-edac@vger.kernel.org>; Thu,  1 Apr 2021 04:06:39 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lRv9a-0000Bk-9G; Thu, 01 Apr 2021 13:06:22 +0200
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lRv9Y-0008Pw-FI; Thu, 01 Apr 2021 13:06:20 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-edac@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Date:   Thu,  1 Apr 2021 13:06:15 +0200
Message-Id: <20210401110615.15326-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210401110615.15326-1-s.hauer@pengutronix.de>
References: <20210401110615.15326-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Some CPUs like the Cortex-A53 and Cortex-A57 have Error Detection And
Correction (EDAC) support on their L1 and L2 caches. This is implemented
in implementation defined registers, so usage of this functionality is
not safe in virtualized environments or when EL3 already uses these
registers.
This patch adds a edac-enabled flag which can be explicitly set when
EDAC can be used.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 drivers/edac/cortex_arm64_l1_l2.c               | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 26b886b20b27..74be19c0544a 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -270,6 +270,12 @@ properties:
       For PSCI based platforms, the name corresponding to the index of the PSCI
       PM domain provider, must be "psci".
 
+  edac-enabled:
+    $ref: '/schemas/types.yaml#/definitions/flag'
+    description:
+      Some CPUs support Error Detection And Correction (EDAC) on their L1 and
+      L2 caches. This flag marks this function as usable.
+
   qcom,saw:
     $ref: '/schemas/types.yaml#/definitions/phandle'
     description: |
diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
index 3b1e2f3ccab6..6d5355bae80c 100644
--- a/drivers/edac/cortex_arm64_l1_l2.c
+++ b/drivers/edac/cortex_arm64_l1_l2.c
@@ -190,8 +190,11 @@ static int __init cortex_arm64_edac_driver_init(void)
 	for_each_possible_cpu(cpu) {
 		np = of_get_cpu_node(cpu, NULL);
 
-		if (of_match_node(cortex_arm64_edac_of_match, np))
-			cpumask_set_cpu(cpu, &compat_mask);
+		if (!of_match_node(cortex_arm64_edac_of_match, np))
+			continue;
+		if (!of_property_read_bool(np, "edac-enabled"))
+			continue;
+		cpumask_set_cpu(cpu, &compat_mask);
 	}
 
 	if (cpumask_empty(&compat_mask))
-- 
2.29.2

