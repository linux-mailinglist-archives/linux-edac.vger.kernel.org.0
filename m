Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02C159BF21
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiHVL6x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 07:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiHVL6v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 07:58:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F1613FAC;
        Mon, 22 Aug 2022 04:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/Vz+EblsoY+JLsI5+lrGUsxiodQCsMuaFQL5OcASfstbSrpOueuvOjD4fu37JfIpb6A/R6nIpqupJQHg2lo3/2QlbYLeWdpiXvJyQO44u1wvFcO9/AZuGUpK0LeMYyw5OqJyVqn3sei8YhALViUEKV+coI1pjMdKAxa4bvaF1AaakixwuC0o4kd1ThWZiVUz11OcXF0bGXtybsZFmXHtw0I+L3MWZnjspU3T5mCXfvg6G7xSJdDryb/k29CAe0916Pf5iPv6huhH/DqdULs7dFfHO4HAo7GzA+p5yBs4ulWUYkdy0lutebF827YNtsGPqDUlQt2mhxgEUdiLFNU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAb4Ke5IaTQzWAiKF27gj0YMJA1V65YkwvvPL6z7ipc=;
 b=kIGT4nSBXoJfkHLrtz+WKrY4ty1sdA9bLmws68xbu0id2lnhJH16okcolOKZlOkh5PTXmTc7swBPqjGGMIjzVlhFuIWNEv9BfmqeiYWl+YWKDOjw0meXbSVSG8pM8+ueF1hqJ5cgpXxGCboh64VmRixEpbZ9gTufFUZ50QKXzixc6ss3Z+XgrpRebAgDAeKT9lOcw4+xsmjXg0xi6ph0S0Gq+DJzZf06uqT03tIVzQtEAlieyrk8FjJEpStAt+wG7/NgcEBnnC8Hm+WifvWtHdV4JZcPKK9y9Leeeve7A2ridERNxn01Hf/77cSXVewdYZ34K+yFi25YJoAPVdLCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAb4Ke5IaTQzWAiKF27gj0YMJA1V65YkwvvPL6z7ipc=;
 b=wD4MuuMRtP+awOymW4NA+EdFEGj5CO0eIJDjvk1b6ynHbdiDDsEoPyxIFXK/Y7iJQvmD2pCFLJXgZp1pIleZaiJ22C610AMRr6c7bj3RU88SazM998b8gTreluJ5wTxkhBweoqweZ4yqVH6dYKugKL3DAMgqt735IMgR5oXlnJY=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 11:58:46 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::3f) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 11:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 11:58:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 06:58:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 04:58:43 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 22 Aug 2022 06:58:39 -0500
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
Subject: [PATCH v2 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Mon, 22 Aug 2022 17:28:20 +0530
Message-ID: <20220822115821.3907-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822115821.3907-1-sai.krishna.potthuri@amd.com>
References: <20220822115821.3907-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6dce733-2cc1-439f-e98f-08da8435aaf6
X-MS-TrafficTypeDiagnostic: BL0PR12MB5506:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mxakN6vWn0rHgogOwLex6d2W3ZL+XG49LOw7Wz/PCZPdAspkJU7TCEVpptxG8zkXTHfWtxsuq7/INTIGcH68AetqsAJ5/QR91uhTo0YFVcuLXBfv3i6fXQZ2bgTx5TOKkysCLnrdTxwJB91rehhTf5TL2F/5gATm6BWuL2ICWcdiwQ0hmxG7THMgohG1HD53QZIK9TGTr8ru5i1u/18B94Bs+2EVjFISmetU3Bm++VaZOthTGYLR+Ly9VgtyLuOEAppMc1kQWcY/alWaA9s9PPUG+Y/2ZhDoRtTxOGqJj+TofuxXNfhc1YIXv/2m2xmbz0LfkYVkSWOSbghIKxOQGw5h5s717ANdHX/s9aeBhd0AL4W0ZTPzlM+TR6eICNgqq2PT69LVuEQsnHMi+CiGoGwmqsjMBXIDqd5eRBIO7f72EOj45Midw0xEOOQ9cSXkRqSppLTYCkK5glJ3n/KhUa21mbTxBpEnYkO/9KuKytJcHgIycVVoGnxtbkDPRVbfuJCim6o7caUpcJA68bgtVVNFetMueOK2b8FWzK7GGOFXmh/NQCFT06V7St1Tlla5D4QX3tNKRPrivi7CUU22PLGKuKJUVPhT8d57NwdsZ0sN2kIcD/IScabFUcxtug8CvcvZxkSwGLjJTCULs4j8jmUtF5lv/X92zFxtEkJaePsEjer76vaDzJm9pfoO2FlAax6t/CREmp4J9X2cxz9nvjurotgdRFv6JTj5GKbo7QZgH7tWiCFJHpysC0EBdtSpGeHsVAnBRtBcn0majQXS3kpTPirx0flpNP4xgjbz7z7Vzh1xPBOTMtLLNzHQlfkKay3CzUoOi6FEXY1HWiAigTlXRjCzjOpkHphfeE/Ej+/kja8xxU8pZ96lAH4tAJy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(8676002)(316002)(2616005)(83380400001)(186003)(1076003)(47076005)(426003)(336012)(966005)(40460700003)(40480700001)(110136005)(54906003)(82310400005)(36756003)(103116003)(86362001)(7416002)(2906002)(5660300002)(8936002)(356005)(70206006)(36860700001)(4326008)(82740400003)(70586007)(6666004)(26005)(41300700001)(478600001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 11:58:46.2006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dce733-2cc1-439f-e98f-08da8435aaf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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
 .../bindings/edac/xlnx,zynqmp-ocmc.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml

diff --git a/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
new file mode 100644
index 000000000000..6389fcb7ed69
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/xlnx,zynqmp-ocmc.yaml#
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    memory-controller@ff960000 {
+      compatible = "xlnx,zynqmp-ocmc-1.0";
+      reg = <0xff960000 0x1000>;
+      interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.17.1

