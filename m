Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCA6C0D62
	for <lists+linux-edac@lfdr.de>; Mon, 20 Mar 2023 10:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCTJeY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Mar 2023 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCTJeX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Mar 2023 05:34:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810691ABD5;
        Mon, 20 Mar 2023 02:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adUvrWoxJwmpWpCez70S61PAihPLw13zvDCr71E+5hT4ZvEFxZcPpdj03/kr0GT+JqKeWPwGb3joypM7pyYCefuuBVUQGrKlja7WSoAt7+c6hoRAhwYNBNy1csJMXzsXTWPeyqlti3K9FKwDwIAjTzdPgkTnu8/NOdeHTIzs/FDZMpWo1Vxsuo+BI+FgYgagvDgWmHIOOgKarhxgZ/2V913gA+XeGNDW3Snudhcc/6UYcYRnSFILIPwonOFGoeTbSbC6fsWHFfwBd6xCQ0/zO2WjrZCE8HkLm9bHn5WB/DiYS/Y5yJ7htvIKpyPignXOBxlXqOoCCRSxQmdC3WrqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=JKVfHJ/W7/yrf8waNQbuiGS+1C2betz3cdb9UktbtPHF8OpNbZBPYCiEPLF120PwwhzR6T3l/pE/NbKsMDIMdixvwH51IjsfKv43+qbo2ECvtG4mRdOcNTIlUW9r/C5IzSSPR+EXpUdWxw1EX9yKmYnMpDQMbUcDPl0z/vELiY0Pc4BH2sSYTK2CTvodQ1q+Dn+X1qTIU4bl1z/IvFGHCiMNYrh4HIO58Hdu+CqWepg8QkcwQR0Kud42l9Y9+u3jajEby6AMV5r4HPd9ADt5Tp6e0xYqppvsj/CE6JTZuTPqCXj17nAFygi1ZQKPUMrbV5vzbrTVoBCt7vic24eF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=H5xvkEwpZemf5GxMLFtMZk1tIp13/VJ0w/73r/rUJzRzhnDm5VUBwf58rPbHmdfGH2beDAXgsu0JucxfA0RZuhZ1+1/do3U6aFUF90hx9a8DPL140/qfHjchNW32QWmmTmDRb5/45yhcKh6TwfZkC6neF99EkTFNGqRlbfGFQd0=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Mon, 20 Mar
 2023 09:34:17 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::1e) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.15 via Frontend
 Transport; Mon, 20 Mar 2023 09:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 09:34:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 04:34:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 04:34:13 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 20 Mar 2023 04:34:10 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <bp@alien8.de>,
        <krzysztof.kozlowski@linaro.org>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>,
        <michal.simek@xilinx.com>
Subject: [PATCH v6 1/2] dt-bindings: edac: Add support for Xilinx Versal EDAC for DDRMC
Date:   Mon, 20 Mar 2023 15:04:05 +0530
Message-ID: <20230320093406.2045-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320093406.2045-1-shubhrajyoti.datta@amd.com>
References: <20230320093406.2045-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: a24f267f-5d34-465c-ca26-08db2926467c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0A7awPz3y16kDBJR0jrW0MN5Gdr9Ff10E2G5NQQP3GHn7ZABp6rKyZ9s1pbLRO8vt33uk7arOU6FOgoSzmvpTgni2qLAivU/paiSW+Kdr78IrKdmFk6oH50cjx43qTSfWT6deESgMx8zi+FmHHTLhLNK333ngWk3mjROEg6m7PxJg0+B6ZzYun5tw3IWQjX0mZtYV96Mr0bXUEyTdSDrEjctmCPGh6z87IfoioK06LNHBtn5Wq5g5fZ4hMJSZ/d8GQfQpP05Uz9neE9O7yzSroJC5TwV3D/zT/MkRMVDEQcBINH/qZhZcTtePh8QFwtNiRZD3IHrhUjA8UxJOWl3+/uMa9VHbVMEbb8fZqZEfb05M6NxouMwoGdZoncHDh4rKOHxTHfZ+oBwk08NSbPiL/1hCwLaVI5/Lho6VKRDFGJVhMueb28yt/cIW8QXTEN2HUZ+u9aZoVoqYYQJle4Vmakt+/18Xm18gstQ4r0a67l4Dptqdo46Al2R/Io1k2L/G9P7bVsxhhD3pCafCJfvzcDpfTOp+TBBe1BvWUBs5vCQikiwMgKg4Z7ZdeztnPrL1+eV0KmROwmm1RnVL4FUFEtvAhOJ0C2NP5IwedYE0X2GqwHYwErV79xnbyEz+o1g6w5GwdiAZGcq94H19/RAfl5hqznnQbCD4cuAerGErzKhvSfzfM7C3Hske3GtC0FyKOfTyX/8JRV/VGca8lz/K4llz6ulhKRF7aXnvgmfOAAN2WpifQgFu+/ivt7yTIRJ/+n0wTj30hbQ0K8OM2CeRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(356005)(81166007)(86362001)(36756003)(82740400003)(36860700001)(2906002)(41300700001)(44832011)(8936002)(5660300002)(40480700001)(82310400005)(336012)(4326008)(1076003)(54906003)(47076005)(316002)(2616005)(186003)(26005)(426003)(83380400001)(6666004)(8676002)(6916009)(966005)(478600001)(70206006)(70586007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 09:34:16.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24f267f-5d34-465c-ca26-08db2926467c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

