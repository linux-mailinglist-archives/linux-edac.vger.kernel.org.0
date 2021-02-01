Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377FD30A70B
	for <lists+linux-edac@lfdr.de>; Mon,  1 Feb 2021 13:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBAMBC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Feb 2021 07:01:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44089 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBAMBB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Feb 2021 07:01:01 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l6XqE-00053y-4X; Mon, 01 Feb 2021 12:58:02 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l6Xq9-0000DY-9w; Mon, 01 Feb 2021 12:57:57 +0100
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
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Date:   Mon,  1 Feb 2021 12:57:53 +0100
Message-Id: <20210201115753.18349-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210201115753.18349-1-s.hauer@pengutronix.de>
References: <20210201115753.18349-1-s.hauer@pengutronix.de>
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
index f02fd10de604..80dcf90f3e78 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -269,6 +269,12 @@ properties:
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
2.20.1

