Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0F65CEAE
	for <lists+linux-edac@lfdr.de>; Wed,  4 Jan 2023 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjADIrv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Jan 2023 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjADIqV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Jan 2023 03:46:21 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A96515826;
        Wed,  4 Jan 2023 00:46:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQjdxVnRMZAC5W7f1uuqtN5yUbg9njZoPvaMtx32bhKhWgwAr8l8OSO7YLdikiBnxjFMds+BTBN0UZc2tJ9lllloaVe5sZcifrfpLSHGsAnafG5aJbx7wuyTGr22j4PP6W8CR7Da5GdbQGaTiLrFydJ0zh0mNQnm/7Nd1+qpPgjKzJG63fu8GsgYd88GI/fUxpVO1q66YJfCIdhU4ZGXaAhWjOVag6+SA6pq1ce7zI6o0EpctCHCUPz8TuIkHSTPqnEjeX7F5jvIioH3DA2pGIAzqhwpk4RvMjHtNsjN4CuhxXPNOUWfd5XHpV0/Fedti4p2a3HsbjLMALtwViQ9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cQZZHGFdUxQAb3p5W87JKk65WI76ShWMAeOXr06COc=;
 b=BXalzAW7TA5NIOq27PyLtD66SpNRelKtMlCian5Qa4j17otmBO/eMHjj/Z/AAr/oWs/U6v4Tz1anKggjGaP5ab+OcVfA7FYGDg3vky7dpon75qz/Qok/0TI4b51dRrDP7+gwmVSiRQJJISSDX6W6o6U81tS+g+vXgmCHd2t6kO76w7l1R5zU9JJ7Elq28FMlr+BhJHwdpuZQt22E/ddUGYRT9zMp1U17qLyvWipsc0UsveShvtLf2zygn3oMPIbbmzcxudq2YhKnI93xdM5qJVwNbLSjehL1Xk7cCQuwAr9K1VLMRNHPyaoEUKpaD93OOloKnIh6nLlCbfLMl1GdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cQZZHGFdUxQAb3p5W87JKk65WI76ShWMAeOXr06COc=;
 b=iezJvQZuYOwBpytRySsrHYQZj8KlG3VMDae0HKzsHtpHGsvkQKnM2b3RmcvzdY2DHCnv5LIlJx82SrONajUzby2mjuL8wndTJ1VMQV6vguZwgRDkN8vMeWcBF6pcv/LAP3AJvySf7TvSMUSvTJxKTlDmOjnPjXqsmUmcxEPlWUU=
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:46:18 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::7f) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 08:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.14 via Frontend Transport; Wed, 4 Jan 2023 08:46:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 02:46:13 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 00:45:55 -0800
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 4 Jan 2023 02:45:50 -0600
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
Subject: [PATCH v7 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Wed, 4 Jan 2023 14:15:11 +0530
Message-ID: <20230104084512.1855243-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104084512.1855243-1-sai.krishna.potthuri@amd.com>
References: <20230104084512.1855243-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d597609-4570-45e1-a7b5-08daee30258a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSEHxa/TFqAAN7RzIw8AQA8ZyaiZNquiN+BqWOl2kvYgjgOfrjqQhVfzP53cFFIBzbpVF+RUqsuc1ra43geOtjgB8pCT3aZ6wBaOk+3Sn0tIYzeljE9AwPDpxbNQvz22dwQFTtNTw/pp7fmYBfv1FnTlHFT/vUH7eWPul7tFjSQ/a4hB4l/8ltlc7NSCJh0FqlfPdXIuvkcW102ggPOL9oQJqpFU2Jgst9t4aQsOr0jji5OxA8EN8iWSakGS5ANXMRdNAf12bTINB8rLFdWloYhwq3GPbku7HHQNaZdt7FwoFFvqW0fh7fmgP2qgdGb/jSxajykC/oH1zN0B8QkHUOKDpqARO0g2a8omAON97iKH+FjjL5mGxGwHFADVh/zw5+56y/19jw/92XEItJCfpyBzcW3zb1XfsyLEIGN1fbJRQVos7CtSgSh6A6VvH34SzDZOSU8WYaIme0bj0B5hYOi7kEy+oN3TClCKbJDFbRgQKDMBu5EWjV/VZ29dOfYUvHar/I/wMg/r7u8Wc9CNAL961BLh2gkx4PKGjYJ+albP5OdSJLXzdhtMc/PLj9qhlt3QvTcTi1fcViWFC7V/1P1TCl/OX/rETPaxZlr787iXGWBJDvMAtMhZFLXPuGo3EqAVgQt7PtoJoc3iSqz0OsD87a7bYQaUtORARW5lJGk1rQ6zhJI0CJfq2jr0cxVnGDXJTzJsonK4nxw26zT9ktTrn8deMEuOJWY3w0wIEAFZ+MgKZjuTrEUimXcp3bERkfONlD4ocIyyt/jdC+uwinjfRAutpzY6uNpzY/CVKyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(8676002)(4326008)(6666004)(70586007)(70206006)(8936002)(40460700003)(7416002)(316002)(54906003)(478600001)(110136005)(2906002)(966005)(103116003)(41300700001)(356005)(81166007)(82740400003)(2616005)(336012)(26005)(47076005)(186003)(426003)(1076003)(36756003)(40480700001)(36860700001)(86362001)(83380400001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:46:18.0468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d597609-4570-45e1-a7b5-08daee30258a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
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

