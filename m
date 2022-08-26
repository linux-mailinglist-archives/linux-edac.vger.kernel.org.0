Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7745A2262
	for <lists+linux-edac@lfdr.de>; Fri, 26 Aug 2022 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiHZHyS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbiHZHyR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 03:54:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA7DD4189;
        Fri, 26 Aug 2022 00:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlWtaRv7I/mjtwO0i8LowC/qGdyvpZtj2aKcws6ynrYgCkQKmrsHNLB8uLB2VKgUWGs3m/R6hviRIbH5XJQr8KnBC0WJbRPgL0N5p7Gn3cvpE0UWUZVcR+sHIRKYNDQDMJdHXFTEZB9FMSPtkTSa0rOGI6FitCf3tfA7GRD7sSdc/86HcxoWgj876YBHjJ15NERYSEONoau6vk/nywPrmC1l7I3rC3qIJvX2x+BHWOI3bnnQhU+oUx54Pxl/mrkxkI0YGveQAYXjmPpjUbEsMapLR5qYkOPEoT8JdtXrvfIORalHggofVRvBLHqGUa4/+RPg+XdqHPK4cRzzYZv4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yfsXcwXIDPs3nU6ySye5ERuWmhFxRrHeUL/m1MzAxA=;
 b=I+KtHX5E7FNz+bQlx+I6q3/+itNs8iPwaLWSJ50BHQ3iLArG07nXyIGMIsE9x21KWFTceLNcNBheWwYiw6pwKcxOD3BcZuc2cBsm0XFubUeSNc60wULWDK/tYIipsf0CUnT+o+fobZQi05kpmmxOySMY/StLpUeqmQVD5bdBvy9sekzpVX0Yea3kYE7LR46CrM7w8bbFcLIXaZABRZKtlpat/Vc3KL+62BH3kivesH+pjCKECVeXiY0wtOhKgjJq/LcmMp6r9uacTaHpQk0CVnE8BpaI9SOX0oJUJZUyL3XRcsWwY7h0S1miwjHByrgC6Inf17Teua5qbDHPkTUo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yfsXcwXIDPs3nU6ySye5ERuWmhFxRrHeUL/m1MzAxA=;
 b=fYikgqhMr/tgSl4/t1qArPcGLEN8NPu13cUII8M4FbX/X3CNjYAWVWavxIEnOFH46049hiNHLmudbKCdPtii/aAGBv9iaBNX1IZYarHQ6enAUD7x6+mnQ8pLOBt00oGrvcl8c/8xQcC+ZmBoLI4lYrv28vaKIM94cjEH2R7BZiA=
Received: from BN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:e6::13)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 07:54:11 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::d5) by BN0PR03CA0008.outlook.office365.com
 (2603:10b6:408:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 07:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 07:54:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 02:54:07 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 26 Aug 2022 02:54:03 -0500
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
Subject: [PATCH v3 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Fri, 26 Aug 2022 13:23:31 +0530
Message-ID: <20220826075332.30609-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826075332.30609-1-sai.krishna.potthuri@amd.com>
References: <20220826075332.30609-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d466bce6-2f6b-4321-8dd8-08da87382850
X-MS-TrafficTypeDiagnostic: PH7PR12MB6636:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjE7zIDnzymoJV7U79KafeP79FNVQ2L0ODI3wU0t0roUkrYAmq7EKtijtKt+W994rAXMlWu0hGS1SuO6BNfWiYxaIk0d+qxeHyQYTe/UevcNdJp1Q5ZvURAR9CtfBItp7BI9L5lOVp9MRZ3+Qn5cM7EkZO+h32XsqYhjM6XGFnipef1iSSE8AlJVENTpSx0df27WWaDCL2TBuOQLxDxJo6jSE5N9/l/yazc76cp25gOG4ffE4s9NObgqpavAd9zGEHsN5EzH9KrAbVmQPoltrsKrITOtEqxQ96e3nwvMpZfPRBhDYc4EJZ+gh5qdUGYAkF2Fc2Mo3j2BKhQY+S38HNxbSQTLcNNC/j0ZY+03uv3C8djDu5jF9Uss02HjHE1gVHWJwgDit/BXHX7oI8FKRPW1rmX7WB0f4SwOM0TLMrmG2t3prJNXnlRUiyfLgUs3QNTGA8aWPQ5TtaMcFPmp/1H8phOL5LNAjVEyZUYpzXk/G4vDp1+3qhfvQCHXEeCZk0svrnISvpalo1Z8mYrOVHTvrWGYfhZJUoXQ7VmeRYDFtBAfoEOEK0AuPF8mg1Os/QUDsj4FHpP6Eb30Fu7DIptXt/NR3SuOsiqHGP/GLWZOt9ODr+DXldW5r2g0V3+71/dsvoxXmSxiXriJUlYJ6AC57+j9DKQHGg+Z+5yP9YJZ0ftbDY+6hS997qcCjH1DykmSTFVNw9FhgXel3EGBj853CKpjOGsCna7mmuBaK9HGFZuMXEW7Mhif3uiIta08W6q1eNaFOFYFtncK2oSNfZQZkrp2FiCmr0D9unv2OHOhxBaPmRIFpVJD+LZUm47qZ2BmHGTvgAdml3YuJrjf1bjPPpkMjsySTBb/au8j1VI62THcDGMmvsbsd9MvlGB6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(4326008)(70586007)(336012)(8676002)(54906003)(110136005)(36860700001)(356005)(36756003)(82740400003)(81166007)(426003)(8936002)(103116003)(70206006)(86362001)(186003)(83380400001)(26005)(41300700001)(6666004)(966005)(40460700003)(82310400005)(47076005)(1076003)(478600001)(2616005)(7416002)(316002)(2906002)(40480700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 07:54:08.9851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d466bce6-2f6b-4321-8dd8-08da87382850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
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

