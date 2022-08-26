Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD705A2260
	for <lists+linux-edac@lfdr.de>; Fri, 26 Aug 2022 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245724AbiHZHyK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 03:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbiHZHyJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 03:54:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFCD4181;
        Fri, 26 Aug 2022 00:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqOXLUsI/HhoQnMdsj22O6bSJm24RTFBNy0zytu8E3f/YFIJTvPOQSATE04fOls/f7NE4sT1IpAj5t5aCisGPNpAcqiFld+rwuAzvvMKtVxcj2x2PgWnwlr+iLcK5VHtQ7KFtaCPIT30aP0GfSqeKQaBbVwjzvOw+l/5qsJ6RcK85q6BfPqmXRSyRXQpN4arQuh/qBlYk7ymbj7FU75NubInZ0nRT+SJTUfAe29yZ+/qo30jTgLFnjESOFjrKh/EoPu7DeBfLIBBxIRN9bLjsKcYT/gP4g6aDQUKuI2cKpwIF9TJ6S5k4Wr+xQ/pbmareXX8EKdT6p8E4ViaF4VKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgxGvTeJ9+aB+3CF+EJzBt7GGH/roqzaOH/6b1kijxU=;
 b=jKlaOWEDGVBNQlee98j2W9ooBcUBciGGJoNBwATFij8PyBWO5KbTViOhTFhLy012Hyl5sosE5nUVC1PR/YzHxsU1zMDKsC5VdcWN4oWcm1NhNxo/rUe5FSte2gopPEX60CROkr76A8D7cGbMTl/Y+a34Lsg3/dPkOZiT1zSaoWjsnYNcIDjHPJvTtCDqTXuHr/MSzAVwzod8ZhNA+H5BtTJIJ/EBgBgeAQiDC/awSmxfcI6UVH2OTcKFC4nHbV9qdUlP1TIW+//VXoZofXE1fDQX/BY3AvEM2sNmL3swF5q857RLsUXyDgteYVeL6LDsv3P7fhkd6hdrbO9o67rYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgxGvTeJ9+aB+3CF+EJzBt7GGH/roqzaOH/6b1kijxU=;
 b=ZeR55G/zdng1CzgYYTkdwT4pNShtgqM6gYK5zAGFOy9vvGV42/1X/6L72waBs0TnWn+lGWMXD3ik6TSRW4OcBJ4cQfaraMHgNtwaFLi146UEC1XsZe0G20sKz1YUs16omqGZs3SuQE0GrQYPCYp/Zt5lqgHENgJ+WcJoKxbaBCA=
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by DM6PR12MB2842.namprd12.prod.outlook.com (2603:10b6:5:4c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 07:54:05 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::23) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 07:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 07:54:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 02:54:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 02:54:02 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 26 Aug 2022 02:53:36 -0500
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
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v3 0/2] edac: Add support for Xilinx ZynqMP OCM EDAC
Date:   Fri, 26 Aug 2022 13:23:30 +0530
Message-ID: <20220826075332.30609-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5b86aa-4047-48ae-f28b-08da87382601
X-MS-TrafficTypeDiagnostic: DM6PR12MB2842:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O67ee0MBdmonmBDlY1QFVCcle0Z82o4g8I6jFj0tTb5HCPkt8XVP/bk+toGuBvTlXaNeL4HX60OSGcKcE/Tj1sOC25htaJgaqLluBYuDulAUokwQno4JLlKgbRJXRRlSFoWEt9RK+hItn9xkRx314ZqgYPEesEHxTrvBWqyBmTqSR1O0PJRi8OoDRTd9OCmDwXdr6KZ+T3i+TSerFAIq+bONhB5STsnLpl+DIi3SQ89Pr5bqU+dtUFsbBrICNAIS39GB8GSoyArO1ZGS8Q9/znvCXn4tZfDMsSr+ZovOuHR7MgNPsVje4q21kUs8XRSXM3YrnjcXY3A9zfzWfZcaq4ZuNNcpiQtPsMBT4KPZsjpzXGZLnRZN/Zj6R8j4iA1CMtwWOPtydVA2CHVFfGOrJEW5DiyOq6DKL9uNwrG/tHWiguD1J2M2ZAl6XVG8KoYJ87aPfH6CilkgWZgg6r3uBoN93PDD/fXl8FCwgmDHq6IafmlUH+zPmfZ/9pGDIbC4vqRX5f9E8u0QUXy8so+KOoTlTPaDBDdW/slPtyUxe3FucivIH4wgAElU3JHtI5FLACcbl/t6yG4vAITtNCc8XW1zTYukmaYgR7sAufr0Pkzvl7yMg1uAnqniq7vFzEc81IHp/v1VrCrmjO+v1lsg0jx1TxygdArr3SUELqWzOxTASiA+Avr5FyIiDMNRPuLM9xgwgdCq4/hxrwwVP3LWumvjHYkkQl2dBIoDtIHcM4I655xKFGY+xlHCdKHieXAxkEDpc+v2PadY1t4FFYCIZI9opI7s7y24iG4bEvYQ8TuF7DbyxCLGlPbMPwUo8rnp
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(8676002)(478600001)(86362001)(82740400003)(7416002)(8936002)(5660300002)(4326008)(70586007)(70206006)(81166007)(316002)(356005)(82310400005)(40480700001)(54906003)(110136005)(36756003)(103116003)(47076005)(426003)(1076003)(83380400001)(2616005)(336012)(186003)(36860700001)(40460700003)(2906002)(41300700001)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 07:54:05.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5b86aa-4047-48ae-f28b-08da87382601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2842
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch series does following
- Add bindings for Xilinx ZynqMP OCM Controller.
- Add EDAC driver support for ZynqMP OCM controller.

changes in v3:
-> 1/2 - Moved the binding from edac to memory-controllers directory.
-> 1/2 - Changed the file name to match with the compatible.
-> 1/2 - Used additionalProperties instead of unevaluatedProperties.
-> 1/2 - Used macro instead of constant value.

changes in v2:
-> 1/2 - Used define for interrupt flag.
-> 1/2 - Updated the description and title.
-> 2/2 - Removed Kernel doc for probe and remove.
-> 2/2 - Used COMPILE_TEST, used wrapper for get and ioremap resource.
-> 2/2 - Fixed few comments related to static variable declaration
and print statements.

Sai Krishna Potthuri (1):
  edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM

Shubhrajyoti Datta (1):
  dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM

 .../xlnx,zynqmp-ocmc-1.0.yaml                 |  45 ++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/zynqmp_ocm_edac.c                | 622 ++++++++++++++++++
 5 files changed, 684 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
 create mode 100644 drivers/edac/zynqmp_ocm_edac.c

-- 
2.17.1

