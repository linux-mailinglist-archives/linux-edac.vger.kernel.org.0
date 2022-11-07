Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9327C61EAEA
	for <lists+linux-edac@lfdr.de>; Mon,  7 Nov 2022 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiKGGYw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Nov 2022 01:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiKGGYv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Nov 2022 01:24:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D527B10B5A;
        Sun,  6 Nov 2022 22:24:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgmKmnKsa80MaB6knW/WdTzp41zTvn73OOu/D0jN5EDb0qEWyUE92OYF9jsw/7e550t3N/8lrMFfpkZlL4fpj9rONYhNrzvI3XI19IN+nIWy/SS4acnCoW+1DPio2V+MPsLJDBLhlBL92/aAvglFA5Q17qBBUJGTZj7FFxZP7KNRLLThMBHy+6qbd2S4bqY5yuugjbY2184KBysfAy4+OI7B9ZmET5VNK0iQXlDQ4vIWTHDgEKNrD1Ft+FZd/LVBQn9+GjjTgCw6zaiHj7X9m9/AtCuJd4HrtlT+XyTMlaKMCNBMndBQwRrmDAIknzQdoa0Cd3qY4qCdTSH2Y+OAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKrzToKXBKd10yUK2245cAQqPB90mbQ9EbfRs13FVxY=;
 b=MT1BhR5YxxURWY9d0/ehIi6UTYyuBc3IjUeogZXpMzx8nv0C1XgYiRuj1Zh6la3pgu6l2iJPxFPesM22i9pwPz8BXv6toh/3SOkAvnEiCWduGFajuP1otRcrXlK/nGrQzX1FY3EGSvYmRWOU1jxV9JRWG/gC2qRjjGMKbx88Q/X4Ppujb7FuRRp03jQIv2iDzBLwPcrG1Es/MFCtsLBaDDvQb0hIl4fBt9nsrq2AfHvnmHx38kM9HTcC4OF25mkkaBfzL3xPWwRVy/6wSBrL61ECRDiTiUAT8CZiHlR8/8UtuzEtHEIo3HCMFNkGLZNhwgA+kSIb017HUmK4r/mbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKrzToKXBKd10yUK2245cAQqPB90mbQ9EbfRs13FVxY=;
 b=GYZiGnTPmF6BTKM/+8itD4CkJ7e9Amew4CDV5H7rRBoWcr5j29UFOvzwjmyyoryXAWCASrmV74zb0Z8+ouMWNbpx+rK5Cgju2vQTfy9DdtmPhf680fwx8IEUcdb6lkQYwJX1FgxsjygTlmv4wcvd4MyFkR8AXoGEZQO7d3h6rq0=
Received: from MW4PR04CA0093.namprd04.prod.outlook.com (2603:10b6:303:83::8)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 7 Nov
 2022 06:24:47 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::5d) by MW4PR04CA0093.outlook.office365.com
 (2603:10b6:303:83::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 06:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 06:24:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 00:24:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 00:24:42 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 7 Nov 2022 00:24:39 -0600
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>,
        <michal.simek@xilinx.com>, <rric@kernel.org>,
        <james.morse@arm.com>, <tony.luck@intel.com>, <mchehab@kernel.org>,
        <bp@alien8.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
Date:   Mon, 7 Nov 2022 11:54:12 +0530
Message-ID: <20221107062413.9642-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: b81be6ae-f8d4-4f32-da3a-08dac088c4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wbQm/efAilmGZXzMnnB2QOmPVfO3btsb9VV1lM9ONvANXP9b7BFYHTHiLtTHz64u5qCDE4I45XaCCdlhm/uTk7ZvBr4cFf92ThHyIWd96xnGaZqVMkvqkiUAdrtzzndwZcVAJFTYJs2ZQknn0fJIOBdfYB3y/P9frurV++LBLXfYkIhkgoQuo9xtz6UGJAMAg/SMlx4CaB1abBjr0x3jXb7Md9yiAHV2lv8J5MYyjShKYKt3AeyL1wiKpQhf5QmhMLbxiMbAcQFsQYSUjMmNN3m5lID5XHZMZWwGwT3J9Y8nk8QFfpKWyTwarQIrTete+JFYLBHCGZr4Shhrz2oGET29dHFxS2WDGDBndr4eKm+ZmELXKcF+2vxm7rPDJLnaWsDbvi+54tTwpBaVaKg61UOHW5CPJQ1bLcH4mgYEtWxbJZqeeUue6bb2i4Iuf+9VnQok3GKmdxdU9Alc/JFCrRA01UdM8UyuBUYljvBu/7QvyPnm126ktLIdRLk8u0XC7WFu23jEm+8XDK9WQvlXnUFVsIhOWUdcDhEa6plw9NrWtM74dgVr8TXJCMtntcBTpFYA28g1Ywcy1nv5dUAt0RoPsNBxTCRdHCx0QBXPOoa66T5qwoRQKRLAiziBA9lGDWFcMCbA1yY27rT/KPr+I3gE7OiGcP+V6GpvGFrPkLPShv6etZjhxzQdFcD2+qxqqdRqGbk/XCAy4CDvvvbsf1AZExMgjmPxHktkcGkv84/SOwJQ9LLN2H3nzRdf+EuQw5c+aGV7LUrM32KaH9Aj3VpPDTA+jwlijtQXfMi0acRKCKtbroqwy8CtJFW6f18Y+ypJgeT0B4E++ti1Z6qXN5lwzl5g5juPsuJT42GQ9xmLIfcwvUJOUyoG+fgC1Ld
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(81166007)(356005)(86362001)(82740400003)(47076005)(426003)(44832011)(40460700003)(2906002)(6666004)(83380400001)(1076003)(336012)(186003)(2616005)(40480700001)(26005)(36860700001)(6916009)(316002)(478600001)(966005)(8936002)(41300700001)(54906003)(4326008)(5660300002)(8676002)(82310400005)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 06:24:47.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81be6ae-f8d4-4f32-da3a-08dac088c4c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

