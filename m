Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2974701EAF
	for <lists+linux-edac@lfdr.de>; Sun, 14 May 2023 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjENRYp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 14 May 2023 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjENRYo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 14 May 2023 13:24:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103AE35B5;
        Sun, 14 May 2023 10:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYKUbQgG0b98KljkL474hDOPZfgXK40wVH8vPvaINZDPQYpQckUyD63rOpqON+bKkFaeYoAHzEtcrHQeQNSbtpLkYLdu6ZYtGEc6OVEWmRRD/5MmlFSMDxIEhgWY35EDTMevDtgqTwhg79JjUtoN/+i1A6pXROUHKldzy9JcZ8YRX5hCLdnVxzEyolrVlO44awLzrnoGr41ss2YRMKykV8sGNPTD9sfBrfgwnSn4NG3OLdRLUzYl8rsIS17paZW3eAa6cVqTjPmYn9I3CnLsRDnOO9xqR6jbNS8YxtCbqbQnz5+tGp8qxKHB+kkf0sq1AMHkPbjva9XMCgQOcU5GIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=m4JnKm2SP5+/fkzFMkm7O93h2fdXiT8TAUWVNX9K6mncJRWY7o7VGiQL2FZWEq1zSH6+57Q5ZTKO0xOjY5TVMYEQX32ylYHTyIZGN+hGGVhb5f/ILmhXYwJF5La6/01b48Xe3qerFUQygRlOELYBmRhrld2+s04/SY7ECY7ERu2x6PY8DgAEMEvIn+rC3PyuG/02w7HjABe/Iz0g/WVJsgGNpzcEE+Gz6eoH3ZUSskCei2Ul+BjeMUyapgjizoV22yI0lliL2l9M86qlLh9IJIRDeMVftbQWb6uDsbhwYqcbTK/H2YRemuY0tGSUefbzhKM9kfHtVFryiwVzoiDMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROcT7yXV+dPaNMUEhlH6XxKFE5+YTuvCTeu1jLDBrl4=;
 b=G7Ir5Li3bU0R2NvOJq3+a1GvNcK2nSKjEZagMDkVDhUgSHC9oxASG2GiC28uwESpb0ojHtB32vBNYdQq01YD9Z3xKlZ9L9fgHrcNSSC+VMZcMXOzdlsDndN2+245ebgXvz4pDKlN+rXdRWxyU8xVx4PfHI8F9H9TJP0qygfzXyw=
Received: from BN9PR03CA0663.namprd03.prod.outlook.com (2603:10b6:408:10e::8)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Sun, 14 May
 2023 17:24:40 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::a5) by BN9PR03CA0663.outlook.office365.com
 (2603:10b6:408:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Sun, 14 May 2023 17:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Sun, 14 May 2023 17:24:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 14 May
 2023 12:24:39 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sun, 14 May 2023 12:24:36 -0500
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <devicetree@vger.kernel.org>, <rric@kernel.org>,
        <shubhrajyoti.datta@gmail.com>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <mchehab@kernel.org>, <bp@alien8.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <sai.krishna.potthuri@amd.com>
Subject: [RESEND PATCH v6 1/2] dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
Date:   Sun, 14 May 2023 22:54:31 +0530
Message-ID: <20230514172432.12505-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230514172432.12505-1-shubhrajyoti.datta@amd.com>
References: <20230514172432.12505-1-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|MW3PR12MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: a358d153-618e-474d-9da9-08db54a019ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leGByuJL1aFVlQpPlZ6fgLMHlnNV0mQAFFIqq0YVBuC2C+vK3JwVCEORkFxw21aDEM9JtojdZr/aW48E2d0JiqJFwj/MNKLmj95trVnUMs4EgyFA11TUFewgE8R9Pp6dRPEHi8ZsP+2PnXREzQ4Ap7TEuBj9yEfPGQtXbGI+CkLR2G1hVEvy6ndwxfuB+UhXSuKT0ZzeEQEYHJkFSsV4t4pg6DCsTrtp7GBw+r1yIOZ8X6Ma2JrhvsD/GF6HGfG6oKw7gE69NnDVvsDcUOw2+kLuA8qoAS8wbxUFDpO4YYFH2AOakbygHlkCcmDMTor9Q/MIE1R/94my3/5m0n27vJTqr+wiL8j9CyXL9X0dozPY9EnI9dkD0gtaynW/w2QDkb2xQQWmuuKYwJBTbMICLzH3747IqTL5qtGy+ObEugYuQtoVSRjIpmGcOeHarBx5GRyJgnEA+40nxr/705DWvpGT0VyakyOM1v/Um3jwv/RmQCu7N1HvAlC0AhcsDOF5ZDzmMlD5jdRcK9+OzXhi7oShQHqeGFAg1/S6+mFPZekJPGtkzDU8mPcIIvcVENNTVM3xhe2tiq6ZtZ9W2gA1/htpLH3rW6O0aDKk30UCWhAK+L7JV9f77pcowtYIqzvmhsRpj0MlMJZ32u+LMgJviL2EpPXkLgORuxkFlVf8DwyAZAFB0MEz+gcLFfm60wWMFjxCuKTEGNiDa/5EK1xpxlMYdcWTwVnCVxl+7b3PUxul3t7Cr0WVqaVtId1AWI0nmgreT6+/yyemDyxKGmuwEIyhkvxfnafEmXlFyDoJsqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(41300700001)(336012)(426003)(966005)(82740400003)(2906002)(36756003)(40460700003)(2616005)(40480700001)(316002)(36860700001)(6666004)(4326008)(83380400001)(44832011)(26005)(70206006)(356005)(70586007)(82310400005)(81166007)(6916009)(86362001)(8936002)(7416002)(8676002)(5660300002)(54906003)(478600001)(186003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 17:24:40.4897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a358d153-618e-474d-9da9-08db54a019ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

