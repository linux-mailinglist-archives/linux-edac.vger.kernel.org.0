Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AAA615E2D
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 09:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiKBIqX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 04:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKBIqU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 04:46:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32C25EA8;
        Wed,  2 Nov 2022 01:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0AOQWgVFvy7niPVEQ9ManU1mD17RWi82BKPxtfCReN1TvdnNVzt7mcUWwBV0NzPfN1JxNHxZhqOc9MJTqVgcQCOOLbbUg1Dah5yyEvmzA+LfRrVfuhNKa94wQ67P9GTwLzdBL5lEXUXDu0NYbKRr6X/QxlPK7Azf16aygycjfGVHU/x2PfcrJe38TZRXUisW+9V9O/mSUmnoe97wkRYufJMoGG0QxSgtbuCphGphx7o4vEUIriZdyW+mLy7SN/oXtcGDGbEtjeCmBQ+EGSafQafzbXvRuDIfwPKCzMncCulfGbb90+cfL4utVXQiogREhJdLad+XWW2SWCs6aloMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODJT8kk8ufemJphLj4ATF+7G5U1Ndewui2qUfdqHIsc=;
 b=hC+w6CLL/vl5hEKODxsowimMF2724mPyvEvaWM1vqkhPXdlqCHhm7zH6fTXclwABrrGayIWrFHnSFoDqDVpk6C/H5LidREFp+O+T/RhXtp00XuLbQSvF/E5cwNaf5atMTFdZhu/7VYsEHHA2yMEfaebWF+NdJOYiA89coTTh4nvn0ouBR1qq8NLRsacNM5RF9hHdbISX5+LyesvYjFVYWLNptPR7DPwwQiKvQvZQvz67Qq/UYO7XKQzjL6iPETNsZirP4BoH2Mz8i/xBKrQ525fMoVellnwAKtn9BActEYOEX7uJOTSIVTqY+4SUgKzRwa/Qefrb5vyjcEdtk4DoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODJT8kk8ufemJphLj4ATF+7G5U1Ndewui2qUfdqHIsc=;
 b=QkPpeSlzWYhGo4yiFXntO0hjqlkj29EEiw61rFB6hUcazN2uTbMfcR1qIc8bLWaH5XNX41XwQ6PZbje8UMmcuAANWQUMMTPaByTeSsFlRqPPZjcr5LakFblAlV5CDHiUmieivsQeH0ieKBcyfXOK+ccnTsLnpd0Yjnd5Ud5bZ7g=
Received: from DS7PR05CA0062.namprd05.prod.outlook.com (2603:10b6:8:57::8) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Wed, 2 Nov 2022 08:46:17 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::2b) by DS7PR05CA0062.outlook.office365.com
 (2603:10b6:8:57::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9 via Frontend
 Transport; Wed, 2 Nov 2022 08:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 08:46:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 03:46:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 03:46:15 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 03:46:12 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <michal.simek@xilinx.com>, <rric@kernel.org>,
        <james.morse@arm.com>, <tony.luck@intel.com>, <mchehab@kernel.org>,
        <bp@alien8.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
Date:   Wed, 2 Nov 2022 14:16:07 +0530
Message-ID: <20221102084608.28894-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102084608.28894-1-shubhrajyoti.datta@amd.com>
References: <20221102084608.28894-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9e3109-5c04-4e0e-0984-08dabcaeb50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYDGQ1K4OKfr3xgtufZYdxogsxIYFB2MGvvf8fv5AQp3uD/hYzhdreP4/HtM0edG4jTWxznqYZHUXUW61J2rH9iOM+8vCvEbiLu7aKTebKCud4JBQxw+AR/B5ezyFj4NhJ0FzCJ4eOxrdG/zwT49+9wbOB1Ael80DY/dyn8TUJMmFwEsBKnOMyq5Uakdcj1otsMB2wwXOZobZz4rppwFnDTuhOs34N4B2UJNL8du61/2VYULP9JgUMLQDux39dMebRkouKBqnDNSS0AymByhB8LTu3bQGyydwHnDnq3PCmH/UgoKuAOXBzytGq1xf4Rzv/UrDUEUt7sro/T6XRLst5tZrZJu0LJxkvw9/qUcaGA/JJyFY4JDy6nZgCN1M4V3xdTwbi7OBs34p9dhllI9mzm2mhqQMQSw4m0hiFyVF0IDFkIobUqgFRPMKA8n90ApMRAkDs77oiNlkNlRFkVXTj5lxq6YbygrKINxnKY8+oa/wLFb0jFPaZpdOvQMrRgVUl0zK+rmdkqr/zWVcIvXuUqbK7Y0nhO7HGswv+HRoKn2xysrJTIMQ76odz1ho1SyfnmXHM5/A4/+Xb7YmFPjjkFRwwSEHdQWBF5fbbHs6Vl713pIu73Ik8sJLJmzvR9CdJtNX77jRRDX0ghXeo4qSJLRXUl6VQL9ngxUfm1B6gWzDkcvo4WpgCedzDOAnvpSXQH39o0G3psE0K72UcSKkzY5H/VgTVf8Oc2+/QucF/byhkBWAhmx8d3ai7+yHVw9YnAxOoHNnStdVPr3uKmVKLp0Mt290xB42IUH0bCUWicxCx7xy9/SYOVHE4nFc63MfLC8wuymfDkGgzURs8MypDQ5DORcTV4ddFuOYS6o7FOT9bt0PCmebm5n7Ps/MPQJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2616005)(6666004)(82310400005)(44832011)(316002)(83380400001)(41300700001)(36860700001)(82740400003)(86362001)(26005)(966005)(81166007)(356005)(4326008)(8676002)(70586007)(70206006)(40460700003)(36756003)(54906003)(6916009)(1076003)(478600001)(336012)(40480700001)(5660300002)(186003)(8936002)(47076005)(426003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 08:46:17.3336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9e3109-5c04-4e0e-0984-08dabcaeb50e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch adds device tree bindings for Xilinx Versal EDAC for DDR
controller.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 .../xlnx,versal-ddrmc-edac.yaml               | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
new file mode 100644
index 000000000000..6717bc0f3be9
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/xlnx,versal-ddrmc-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal DDRMC (Integrated DDR Memory Controller)
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+
+description:
+  The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/
+  4X memory interfaces. Versal DDR memory controller has an optional ECC support
+  which correct single bit ECC errors and detect double bit ECC errors.
+
+properties:
+  compatible:
+    const: xlnx,versal-ddrmc-edac
+
+  reg:
+    items:
+      - description: DDR Memory Controller registers
+      - description: NOC registers corresponding to DDR Memory Controller
+
+  reg-names:
+    items:
+      - const: ddrmc_base
+      - const: ddrmc_noc_base
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      memory-controller@f6150000 {
+        compatible = "xlnx,versal-ddrmc-edac";
+        reg = <0x0 0xf6150000 0x0 0x2000>, <0x0 0xf6070000 0x0 0x20000>;
+        reg-names = "ddrmc_base", "ddrmc_noc_base";
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
-- 
2.17.1

