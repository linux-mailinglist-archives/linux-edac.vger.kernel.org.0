Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07F866D5AE
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jan 2023 06:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjAQFlO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 00:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAQFlN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 00:41:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF1218B0D;
        Mon, 16 Jan 2023 21:41:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJgHqkt0PKaLZ1V377qXylhXnlXuDWU4gFY1e3U/SxmhiEg4slGDqCTC1rWZjsawI1JB26lrf+MkVUXs7cgf9mjSyU9EKAKqBnOyusVUbh+wpYv2MG/gnlz44wtYeh4QUpLpL+HUd1G5GMJnS9cSzESpjOepYZqk7Gboqztg+ZqxUMJsuH70mn0QBE07abSAOnO0sjmZFtXKsRE5o8Oe2/kQFmXHdsWarIkCXl5rUAYD/aVpXROK09gEU95YHRgcbXMGF+65a+eUNwmOc+rKb+CzELhzdnRfgjejVBhsYXlgd6/37swp5cM57JQFTdHLSnqmeVnv3dBGBNK5qionOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXZGnlu8+N4AkyX3QtrxahjWtW29Gp6rq8/8SVLWTgI=;
 b=Z+rbe21v/Mx0CcnTsVxoBQZtBgMQJEQRfBrBH3kxdP2rJomf/wArkS9EMPOxFb4HFoynJ0JkXjAT9at4O6k/tuEkjHiwAbMzNoujQkh8I6OGYqueQ6vW6RQoMspUfgpa5YEchUhxiXHZlMkeW0tsEgwFCDaqsNVY/c9nCxElb2h8HQuwk+e0fC2DfMudMlmBiQjX0UNthjEBAPQdDFPS0Woq35SjkGejepHalI+XhWUoetetqbtbAeD8OJctfxSbzh/Pj1OIi+8E4fVuAMbExY92j+Nx7oTORLZkZxp7LL4v691Ro8GLJyIR+h1REIREiMaH7neeHqL64dj6DeJEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXZGnlu8+N4AkyX3QtrxahjWtW29Gp6rq8/8SVLWTgI=;
 b=2NquF2mW1tvcRv49WasTp1MJCofeS7gcWM61w2a7FtNg9rEJFNCHvGNouMK7u0JrbFtIVKpCjGI3ju1CZIkZjaQ3WIGOe/tkjn9PGdfjyJiEtyobyOGWL4Rk97qgGIqDyULkJGMuVlBOHWewWK/I9isQqHplEHWNKeZacWtptUQ=
Received: from BN9PR03CA0923.namprd03.prod.outlook.com (2603:10b6:408:107::28)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Tue, 17 Jan
 2023 05:41:09 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::7) by BN9PR03CA0923.outlook.office365.com
 (2603:10b6:408:107::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 05:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 05:41:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 23:41:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 23:41:06 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 16 Jan 2023 23:41:03 -0600
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <bp@alien8.de>, <mchehab@kernel.org>,
        <tony.luck@intel.com>
Subject: [PATCH v3 1/2] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
Date:   Tue, 17 Jan 2023 11:10:59 +0530
Message-ID: <20230117054100.8377-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117054100.8377-1-shubhrajyoti.datta@amd.com>
References: <20230117054100.8377-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 56028969-c83f-4f81-0905-08daf84d6fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/8gqgMScShWpXKiE7FSXv++RC+zbYeYsBn+ipCCq/Yj1tVBxZk7tPoHXgrV49n/EVEHqAlO2WOEUd+fe746kAkpm6X+mo7hol0DKAvzCwHmKZs0kZe7gkag7PmrexpqEoJRdYcrHCCd+oxbhrpP601l0IEa1YcCdtut+zE5tv54DtPaJxWZakfSCrNQNO76bkuaPohg+LPrCiCy8bii9UbfTMdn4ClT2nI/8kS1W4gR5Uk58K/4L+2x8fRgT3dGaTfG+senXeTr+qHJmZjeYyo5VO9fNgV10duAkyTx9jkQuHS0yGNuPzW+jRz5pcE+AcpMrnsPQLF5lGa2+YQA4885vI0LWTkqSleVtNEbkfkSqvq0OZwxy6niHrG8VPp4xDaRSiBBZ9Q4GUhoWs6XEO9dQpk+/JM2jezJoDvZYhLrUWF2j01XFN7B++6iJT+Kche72NXNzR8s3cL6kSDt6HoR2YtSd0gl3ROxq8x9FnY9DiAl5/PvvqMkURGJ4XyDk/0uK2J7JoqS3iW5MJb36tjuoc1cwEu7yPIjj5yYLIyRvzQgVylEff8Y1wMIS//03LwtPpDtbhShGjG/eNhNPycCedBK3aCTL2dcSQkV6fjrCPUNYYbyoq681EsSEodVqVsMJ/nnpRjcFBpFzF1Yev7pf9Z//XoHx+kyHMCrirIv84A0TM5l6ZS0mWm7wFfuvBmazhO0mHT6XnTpVucuTwokF/5Xc2rInVBx7zxPt+WpquGfwV6rEwcZlTdxwOb+U4I8zhLXxtNXw4dPQWJOwcObct1W+7ri8YTrN4bneYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(81166007)(356005)(40460700003)(36756003)(40480700001)(82310400005)(82740400003)(86362001)(966005)(70586007)(70206006)(6916009)(8676002)(26005)(336012)(4326008)(186003)(478600001)(1076003)(54906003)(2616005)(316002)(36860700001)(41300700001)(8936002)(47076005)(426003)(83380400001)(44832011)(2906002)(6666004)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 05:41:09.5527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56028969-c83f-4f81-0905-08daf84d6fab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add device tree bindings for Xilinx Versal EDAC for DDR
controller.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v2)

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

