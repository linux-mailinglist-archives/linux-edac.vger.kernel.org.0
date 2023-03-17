Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AEF6BEAD6
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 15:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCQOPX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCQOPW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 10:15:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772201164A;
        Fri, 17 Mar 2023 07:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExqBpBD2KXp7D9xy3A5GAqZlbQ8xNug1k9My+9UbtO9a4tcJz7s8yBy1bESIsNWs6W9lophSP2P7wX/8jHSzN+jGZnKLpcbrX18tg7xsmnlm3Ivs7s5T3iBgU74HMlbZw9LzT3TkFNVKd9nrXm+P5r81ml34w8VJabIuE0HLjvszcx6x1mopb195fH6nWYf/f/UDuXm3v2Wm6E3eK9/tfce9qYp99EmnZzSHwG4zwNAXoqYHyIp9RcjGU6igyhKsqNqD94OpGI6xPhduAJLNRhvaDglf7jKX7GBDWbRHORwcKmNcRDlr7GmDpmd53E2JE955k9Pe8Ae4eYcDVXDgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=Wa6J9XZ4EEafLknG/VEcbP9mE+N1IDSAlpYCiObE7+rbU3bHSXCvGeP8QJlxsu7fOo3wjSSGHf0iOdaPfzWmIcr9cDRaoZIGGhcndwfUgJvUBYZez1SA911GIDNT2cH/4MfZZfoZtvoMyOZq+bXnnH6kwCPfQR9tIu/BnvBhMoHGgVS6bqhmb6ljW0uoH7Ahpa/gBMLeXQoGkcNptjuABJRJ0QQiWT/o8rsJfVY3arUnUE0JP7o70F7GVa+PbKn+ymUPEJzCGwyzYdJ+W/YNhKVIVY1DZ4N1J+ob8KHGnDW0fXDybMJ4IEjQVk4aV8Qdn+/TKRnljq3xtZuQ6koZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=0fB2DQz2vBklvyT5WcOSxWXhAMOAJ/5KiwkoPYSVq0z4etn3ULHsZyFIzXu5ai4bsaQjidUJXb3fLPgw+dxOH6Dn7y+sSW9n9rMem/HhKYcM5P9Bgr5s5irl3NMIjsF1txafSUqF0rMd5Qx909RYs6pbGWQdHcdQBmcUWhdQyL0=
Received: from DM6PR06CA0005.namprd06.prod.outlook.com (2603:10b6:5:120::18)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 14:15:17 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:5:120:cafe::75) by DM6PR06CA0005.outlook.office365.com
 (2603:10b6:5:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 14:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 17 Mar 2023 14:15:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 09:15:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 09:15:16 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Mar 2023 09:15:13 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <bp@alien8.de>,
        <krzysztof.kozlowski@linaro.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        <michal.simek@xilinx.com>
Subject: [PATCH v5 1/2] dt-bindings: edac: Add support for Xilinx Versal EDAC for DDRMC
Date:   Fri, 17 Mar 2023 19:45:08 +0530
Message-ID: <20230317141509.17534-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230317141509.17534-1-shubhrajyoti.datta@amd.com>
References: <20230317141509.17534-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f6c7c8-3f0d-420d-b747-08db26f208f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUcZeji9dlt/R3ehQCHYym/atDKPhF/1iPegLHKGbRaZgJjOrM7ilNDZyoyvNPNyVNbF7xXatSTQVFDcdMDZ27Qg5xiyR/T+UfAn3SWK4LG38Gt1rDmWm9mBMPt+2bQf2qrEdqpwMN0Bgr4NdpKI9S+mNl9RxTHLf4+XyZzpVJ1x9NkDhvyWQkQzL36uMH89frJAo57fOOa4obdaw1R2JHvD2MaudIImChO8D+AdLFJUkcHm+Z4numNopL9hwESf8IW8zGQK/DnR9cHlcaSSPx018ZBgY4BUkXKyqnNgbvWvic3salbo5coDPOPhI69l4CFgC+AVLozjbbalhGqRx4wSDtGeh4VDTkAaoRs0v6jeWObk/GSSL3UFNPSM5YbsB6OFCHP8VtCqoHwx9EnpXuMbA0yGeikbDt/mmdf6/qHwmMO6pZV60w7WNqUXL5gOO7RdFkw3KvUV1bRtJaWHWxxZk71D7v/J+nHZCAq12r6pJcMyc7TSO2/emHlRb3lZ+gqDCeq+l0OQZKevPBIZN4PspHYEV/J26OyYhUmsriLdjzmq39HZ4YW8lg8e5Uoe4IeD/fgRMSLjs6ine9uEpksM1UA1RAx1axMetjCS2TefDWzX2F8bykM/p6xUSLYWu9LX9w7mfxVzwjJQ1no5N4EsB4F2S/CYM+jN5/rCX4byBF4pEt55AT1yiUavgtEJUBliaLTz1ho1/hN9EMNOdWJPSWH62/pzr3uAPoZpL5F7/Zi5/ik/Xa9si1kcfAYGgSbduW1mLd5K7TN0U5Qojg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(8936002)(44832011)(5660300002)(4326008)(41300700001)(6916009)(36860700001)(356005)(36756003)(86362001)(40480700001)(82310400005)(40460700003)(82740400003)(81166007)(2906002)(47076005)(966005)(426003)(336012)(6666004)(83380400001)(478600001)(2616005)(186003)(1076003)(26005)(54906003)(70586007)(70206006)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:15:17.6447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f6c7c8-3f0d-420d-b747-08db26f208f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

