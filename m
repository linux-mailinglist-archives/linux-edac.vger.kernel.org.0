Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC85B02AC
	for <lists+linux-edac@lfdr.de>; Wed,  7 Sep 2022 13:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIGLRM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Sep 2022 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIGLQo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Sep 2022 07:16:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF639ADCE5;
        Wed,  7 Sep 2022 04:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMOixBol8oOX+a86ArcqIUmd2SizAYF5zAR0OOPKaB5rbG9EgN7VX4WK62+IjXY0CJhrKU4p7Idg/rQAcAySNGqiYuhkDI7TlpOd+3Z9cYJgNDxXxWWjNt4/8TuWBcvjacSkBTfWbpVmG+LHY342dk6SGMKtdarAysAn/w+fXkUJL4fHqIX585GMCgezKn115fSOTpMog9/ydPmLf2GkMWvyOgsf7SORDxQ5eGIHX7hLg2nOS2xQsVeTfAeP2sIoALY4XXLcDUFoN8R3/8fINGC6U54O358GqvM/0rYtkBXwnuPtfPKIWHN0K0dCCDfDgrB4lDRyS2K3+i7dYvHYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mduTw9thKSAvmnNB2VuJzOWaarW7uBm9XmuH32B5Ug=;
 b=U4MKQVesWgRRv7KwuK6IBvGsJJz2gpk9bCbovk9CSnoJGGINSdbmI9KBpNKRWDrZKp/hhPGpN07hv0ATNWk7j85F0cyKaoSK+kL8fCey6GHqpV4jlftx6+WWD8k5q2Ka5wrzsTRj3/gS7lkN0Q4fDV5bebWaCADcX8/L1q4qdDHmT9qQjPcUW+iHUI1nLTFUw8btgZDJ6T5ec6nvQGdRygJ5iJKfdlE3bNZ/WuGhelWxT4qlKAjr7M91kc+4wPl8Z0LepIozoaW5czMj+REAsF1nHb8zwLwNhpExoZtDDmIAH7JOOieupw74yT6mX9foLl4J6B90NI2ojk/pZkMAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mduTw9thKSAvmnNB2VuJzOWaarW7uBm9XmuH32B5Ug=;
 b=P1bH0qnKzmdRa9Edlj40QieSl7dxYaqqlOSA6IZVjOZAeVZDEkoVlSr4KzciuTcveqh6K2KroKhIgMDRNOC9vRznyRAc9xrxDxMuCGBY3KRUciHgcWyp9NjblAdquQ4UTzIE3fJJH23xXmv/EuonaAY6wqZaX/l8jmfFU0afiJI=
Received: from DM6PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:100::33)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 11:16:32 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::7c) by DM6PR03CA0056.outlook.office365.com
 (2603:10b6:5:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 11:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 11:16:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 06:16:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 04:16:19 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 7 Sep 2022 06:15:39 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "Robert Richter" <rric@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <saikrishna12468@gmail.com>, <git@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Wed, 7 Sep 2022 16:45:30 +0530
Message-ID: <20220907111531.703-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
References: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4a08c4-ba91-454d-ae0e-08da90c26b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iF7o9W5R/O1qzov15OgH+wziaAg2+bJRsU4K5QCyGgm5crJfnHP4dOLs5bol+55FgaHmEBgi+/IY3az77sGJeAU4lYrtuIRcvMWnuS0CFMiaENNZ63ITKUzXEqETqStp72ZWrrfhG26sbQGDwYQVQSi8hXXmbNQmf2AbEdX7Tzv0SWj1aDq9iMtQ3lyJKg9tgoijJFgliE2C9f7w43JzZXDfEiAW7MTLMtg6ThmDFxMpIiRGzEdS6VQjdhqM0evhtzBgeqmpb8E0jXvQZ7hUt4SIeEk4iPnDI6Q+dS/iA8pSfi+gU1gomC4G2IVgJTMHv+8HXZkpC4VjWPx8yQc/y0wlJsYz3/ne+33/RQeevFX4jrdrotkGFrGF8Cb7er1xUfyYIyHZMkZqqPnRgrCGWATNAghU4wX/7z8l7G1CHfuTihV2+Z69Nr6Mg/DA+wuHfq+E5fI1oFpKgnxYTcBh5bDYw6jO+9FOQgSyRY+KUCpRWdqOdOyW094CONuWJ9+iyVVsc/jGz5q4nzWDf7EYJKl+G0zSyZo1IOvLyieu0NjBsfh9xFgTTB4sUlG8GcSc2oOQMcN13Z6c3d/NQUyzJXdf+aUg0Nq5owM9miJru1Cek87fXXxd+O64ZCtvyEqsrP17HmUGIWAwp5xWHgK2HxxFqy6Ap4NMwbENmBv2OCnYOBD7UKmwRwoNnylTZD3F/l4zyoZATdTWbq3MEYQyv1zJfU8BVDfeBlSfRgkoF4gW3t2Uc1bNMKbYSMwOWOynofoPBQTL5/ChrTTCu2A8VtOCprxJ9/kwf90jyJkjkPgQ2uV7Da57+IGAh2tDXb/G4iR4MRAWSb5B0kp3zLIUCxWdutDbNuN6CEy5nWsO8DwvsC7QAKLmuctDruTeR/X0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(40470700004)(46966006)(36840700001)(8676002)(47076005)(966005)(83380400001)(4326008)(103116003)(478600001)(70206006)(70586007)(2906002)(40460700003)(6666004)(5660300002)(26005)(8936002)(186003)(426003)(336012)(1076003)(86362001)(7416002)(2616005)(41300700001)(82310400005)(36756003)(81166007)(82740400003)(40480700001)(316002)(54906003)(36860700001)(110136005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:16:32.1988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4a08c4-ba91-454d-ae0e-08da90c26b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add bindings for Xilinx ZynqMP OCM controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../xlnx,zynqmp-ocmc-1.0.yaml                 | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
new file mode 100644
index 000000000000..ca9fc747bf4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynqmp OCM(On-Chip Memory) Controller
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+
+description: |
+  The OCM supports 64-bit wide ECC functionality to detect multi-bit errors
+  and recover from a single-bit memory fault.On a write, if all bytes are
+  being written, the ECC is generated and written into the ECC RAM along with
+  the write-data that is written into the data RAM. If one or more bytes are
+  not written, then the read operation results in an correctable error or
+  uncorrectable error.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-ocmc-1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    memory-controller@ff960000 {
+      compatible = "xlnx,zynqmp-ocmc-1.0";
+      reg = <0xff960000 0x1000>;
+      interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.17.1

