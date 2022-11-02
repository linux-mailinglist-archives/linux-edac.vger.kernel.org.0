Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493C615CAE
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 08:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKBHHf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 03:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKBHHb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 03:07:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C2201B6;
        Wed,  2 Nov 2022 00:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcSUqMvPioOxoNdb+w++u/gr4A7XqQi0NapV/E12v10Tb+rvdRt+7Tg22V73KRDWnId86y+N1/ABrXWDsOT/fYnBYlDIByM2NKToH/+cNmOLTi7w/V5dwcdZy20ieQDMrSuMi8GyQvFwt9vHls2yP2mrbnToqtUW57YyMbs18p2SmzX9CwMTijmeoMEmkLqTWmdSqKd4bQ0ZX5mwBJiYVpzljr6w/Y3XD/9IoZJTOtsDGlsKIDa/VxPvfVHBs1NGx+gj/n/rvdMoV4tYCLJATXyXkiQq6sUhykVnea3+dlAceb+Mt/bn69XE+QgoTUi8jY1oF/5yh3yCjteY+zwO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cQZZHGFdUxQAb3p5W87JKk65WI76ShWMAeOXr06COc=;
 b=hf8URk7hg4N4GHe93ou75Vxht+c+tOWJIDnQnr2zhIj84gJrtt4tb0jjStOoUx8VlYWmHdIoVcl+aTPNbfmXPU+lNDBYX4GId/OZf+m/mM5QvNhHQMKEdsLv7KUGTi9+pqwT/Tz2MJvCXvyXsP91ACEyKYs1dfa2L1MwLbOOFOhCc81iUAkZYNAQic2PKfgupUHtYpSGLTbwYz17zCnx1M7vNHDr9ZRkXSy47qnglE+S9j+EvMvP2qwYho/ekVx3ZiyMz2icLJno7B5C9KY6wpxoKaKm4dOZQ8gKgt+AsGxm9U+iVC3ojHYzKZu5TKH6/ANSNwO5ppK0hbXUp/+KQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cQZZHGFdUxQAb3p5W87JKk65WI76ShWMAeOXr06COc=;
 b=wiC31a6gAZwZXkUAcdhhEiq9dR1Vq6xFW++jM0nY8Vbl090mdxSZCksSj6L74ZXa3OLiV129Cr1lUzsEuIvo0aS2Ek2z/fuu/Kh1pN2QGJC1vy0jhnebdbms3zZg58ViMhctx8+B6ylaqsEboc3ZFrP9kebVqeJMCM5U/DRTRXI=
Received: from DM6PR11CA0004.namprd11.prod.outlook.com (2603:10b6:5:190::17)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 07:07:21 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::76) by DM6PR11CA0004.outlook.office365.com
 (2603:10b6:5:190::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 07:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 07:07:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 02:07:20 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 02:07:16 -0500
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
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Wed, 2 Nov 2022 12:36:54 +0530
Message-ID: <20221102070655.247511-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|BL1PR12MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: ba35b177-0288-4a8f-7c53-08dabca0e2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymEsM1WeL4xZuzw4AKjl7b3DQLveZvsBjqKfItSTD59VBb2s1HgAH66WtZ4nyjvcfLy6M6J7Mb8Dpy5Iv8jX98EH3RFUWEzelAlMBQaDYL3oteeNF20btBscitmLR8+DPqtGr/bCYar2xoAoEkEt216V+Ne75BDb6qSvjfJkJag1M7XaJrdEPVYrnOHR4yhZNORN625hA/vdHfl8mEJpAJ9BuM1zhqhCtkzELzmRVrLrmWQJXRmYnAat8vvOZfHhFtv85fIvtQC0nt/E7QkU3BEI1h8Re5wmHnwUp4DpMwgLCO3+R6C63c9+0a581/xWc0Rf0iXPdtsO8IjGz8dHjh/keB3BjZGLyK5hNyAzZ5C6m453rRNJREeDFhJw7wJT3IckFMcStwRmh7qaLfUYRXGL6sHHViE+BLzRaAlQXigUvpk4GOZAXEMc/r5lnro5vonzatWcukhVH9FhOKbWq92XzmohvzlnQVgJ1mzAGTPclcwKBktkqF8nRlI1oi6dMDmW0MtKN1KpYe+WQ+2mxW3qqm5x1hbbkC8PFwQSTbdZMkzti1zj+qacWQYpny/hSK0ZuoKlbF6mh5eP4j/I3zXkYfcQKPCrS/T0CXktFVBtde+LeF4YJRn0wjbFUpcDDduAG033Ieup12V6Kt0ut6zXxwTu010Tjb3DFG/fPZ7ICzFnj+vn++Rpta+2jbiOMibcXOi2uA5YpsfS65ahyd4hTU88Rc3q6K1WieBnJ/Qel5XESW61XX7KH/k1cC3xasimdOOHCktCTJmotrmPI1cs2605udR/5Lz6ZvlhzP2uEgrt1PMkCEycYj7MPd9QwD1fRYrlUN2+upchQBt79vCTLFrHz3pTQvNytxmth6sjbtf7fl2pL3S4osXyzSyT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(7416002)(8936002)(4326008)(5660300002)(8676002)(70586007)(70206006)(2906002)(966005)(54906003)(41300700001)(110136005)(40480700001)(103116003)(316002)(81166007)(83380400001)(356005)(478600001)(36860700001)(82740400003)(6666004)(86362001)(186003)(336012)(1076003)(426003)(47076005)(26005)(2616005)(40460700003)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 07:07:21.0751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba35b177-0288-4a8f-7c53-08dabca0e2c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add bindings for Xilinx ZynqMP OCM controller.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
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
2.25.1

