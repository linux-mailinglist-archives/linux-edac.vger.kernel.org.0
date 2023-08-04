Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E80770013
	for <lists+linux-edac@lfdr.de>; Fri,  4 Aug 2023 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjHDMTq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Aug 2023 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjHDMTp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Aug 2023 08:19:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D146A8;
        Fri,  4 Aug 2023 05:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY6vfelLh+giKMnKkw3/eOvuPSRH9Rohi0V/jWj+hXvs7knhd8KC6Ls+rU/1aylIIR74B/SGmQyhqLEEFIqCmJl+lq59tsfmLFyFqXywgU2fXUNu6wQy8HEfSPDYZWpaJDGOlcNhrV+7vIp5nT4aL2V3BTy24Bm9OtjYGb0OzBtA6we3oAJx3xcAwRczy9V7I0KzOAJ48dP8ICYsNqrfF/8Lw2JGZNyF/bDXOw2FPxTTHudkC34g0I5QOfq67NJs/GvIiEMzMRKTw/Bxlb2BwfzkHTyQrkPXVzvJ+BVoEkcxZPfClNSrV8p1RQeIybdTJWeFU4mzrYGNZxPdIlSckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGkZD/yRZhYN1IYzw+Amk/IocYnJmdRJlD1O3RSJ7RU=;
 b=ag6AyX/sNxBsf869QCrEL3erumBluWaMFCOLC8rnNkHlUQn7O77/s7OhW+epU0/HdPR5xtJwAWL2oXHpKuhAjJ1Lll1fz8v4ypCnvEXxO/7ERDoPvRAV2mYpOSC5E1P7uxb4uyhy+EQCeY6ldzcOvPnkaDnfLoozSxZap1b+csYVqAqlbOTjedJik6obdxti6Ht0BNETgy1OeEMJ6N6WANhtMALtIuTV+4xojWNRMLsO7NsbdxDgCx80aqO02CSSjGq6mvOvVbbafOCMQLc2m41r1ZWEzqpF3kFe0MuW/STwprPR1fvvTVKxTA53CeA2TaIf6ZGQWHvaEqNkTC70/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGkZD/yRZhYN1IYzw+Amk/IocYnJmdRJlD1O3RSJ7RU=;
 b=v7HxRfWQ1lBu6VjjY6I07QAXR9XaDnpw6oAYrEzgn1wwIQPc8YuGi/p14rYJklXsRO3rN4Blb7eY5j76jPJhFVxpFrGzBPjsTTYV35YebDM8smQnFIt60NIbJKRhcuRpR2wuXnppGU9IsteQU3EyFKfUFMrVNvMbe6WNDFzI5xI=
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 12:19:34 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::6d) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 12:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 12:19:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 07:19:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 07:19:32 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 4 Aug 2023 07:19:29 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <sai.krishna.potthuri@amd.com>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <mchehab@kernel.org>,
        <rric@kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v8 1/2] dt-bindings: memory-controllers: Add support for Xilinx Versal EDAC for DDRMC
Date:   Fri, 4 Aug 2023 17:49:23 +0530
Message-ID: <20230804121924.18615-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230804121924.18615-1-shubhrajyoti.datta@amd.com>
References: <20230804121924.18615-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: c0277472-bb9e-4976-e6e3-08db94e51003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Tc7vs9gNXzwTVOb2maqHw0G7Cai3nZyqpeUnPDhCjDJw3znLoQjLHg49iRsJzMaiAFmgox78B0NxxIbyjPaw9IZTUMmCziICYWvZrHiwiRYteVOiCyD23dMd0xQ99XNW2wS9qTez7jjxo22EEdA6xcN8kXEUHzGRpQ71D7xRTyac8bzvTp7Rmrfp2gGxW1KDCHosmhe7+ELbqdGU8D2zj/X4cXsoEFvemPJtFMmy96YK8VwK+h4yTEVR1ESMvIXGuxvhNVWOydFoQDr/wUzPMvLJdbpVSiLDxFoTw1yKmiR/IU82LnhF0t94gTlxOW+I4TMZr57RzYKJ/ZToue8XfN24lftK6y1DowZFSmKV3pD3lu1ji/HgtldHHl+hWoKpW6GkcUNk7m+7N/559dwpkH9XCHqvBsYqGaWznS4KPFZmX3m56EKYRJEeY3PEwxuefSAdhblQa1mRqkL1Nl140mLfU+e1wpB4fXUkeWV4O3ZmgjoppE4YfMzWP8FMcHl4zu0HWXEbbhx2Gaad92EHmBwTzCfs0aZNEI0k7HNas0YphSOfl2tpc/mJohvYAUgaC+1GtojE1eyLAjtYAKe2jVaKb/qB5GyHWBT92mcdB1GiU9Ii54Dha7rZ1gETtESvp++U6ELGfPpCFGhgn9yiC/6YUE2UZMcJ2RzIK8R//AQD5SqXfBGTMmla/KlBTqQQmwvkLpOy8iBw/b7tUsJkKjwwDf5UW96Xv/CE3J4eE+tRG11EPp9qLhuhOCIMj9tW8oDVxUjugUVY5P7IuvJOf95FxwYV/VRKTPWydy1www=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400008)(451199021)(1800799003)(186006)(46966006)(40470700004)(36840700001)(81166007)(1076003)(26005)(356005)(82740400003)(336012)(426003)(2616005)(36860700001)(47076005)(83380400001)(36756003)(2906002)(5660300002)(8936002)(8676002)(44832011)(7416002)(40460700003)(478600001)(966005)(6666004)(86362001)(54906003)(40480700001)(316002)(41300700001)(6916009)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 12:19:33.8607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0277472-bb9e-4976-e6e3-08db94e51003
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device tree bindings for Xilinx Versal EDAC for DDR
controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v7)

Changes in v7:
Update the subject to add memory-controllers instead of edac

Changes in v4:
Update the reviewed by tag

Changes in v2:
remove edac from compatible
Update the description
update the ddrmc_base and ddrmc_noc_base names

 .../xlnx,versal-ddrmc-edac.yaml               | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
new file mode 100644
index 000000000000..12f8e9f350bc
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
+    const: xlnx,versal-ddrmc
+
+  reg:
+    items:
+      - description: DDR Memory Controller registers
+      - description: NOC registers corresponding to DDR Memory Controller
+
+  reg-names:
+    items:
+      - const: base
+      - const: noc
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
+        compatible = "xlnx,versal-ddrmc";
+        reg = <0x0 0xf6150000 0x0 0x2000>, <0x0 0xf6070000 0x0 0x20000>;
+        reg-names = "base", "noc";
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
-- 
2.17.1

