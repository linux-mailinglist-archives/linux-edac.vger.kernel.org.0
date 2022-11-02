Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5D615CAB
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 08:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKBHHV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 03:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBHHU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 03:07:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25D201B5;
        Wed,  2 Nov 2022 00:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBNIuL+3X0IJmSxW3IP9TuG6XY81UKC1oAqhdU75rZ1X1Uieh4ln2viRFQU87Jvrin09bC6WltT9esm9sDmyPkmoTjeJ42j2lAu3KTDLdntX8QvBkqrOYvN7YjKtZu2LVcKcu/lHBgFC54go0y4MXpJlNLwb9bRNGQH5ZynQeRYjR+daSN4KBtOt5LUybo+5mvRRvummp/0JNKAbyAaXJwi0QqsZOfKQNLwHbZmqOeftc17raw0ywA3WpgY1H++Z4DY5upw0Oydm67zAQkNg+AhivYoAdhsznq9LBVvaG1KxgV4ApbFaqOANeK4xz1JUlwdDUaNn6etLezmeZaTnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozma0MdizKED3wqwUrCbUfu0j98k+GUMNMKeeRIS+VE=;
 b=k92uVLQ8O3OzT0cOPicLNWSxco1A1YNJYjKnXIWQ38SCBj2O9eHeFDt42gr7S7WPSHMOfbyAwm00ik/yRn9Nk9patZEYYEUFsIHO32ym4LAjZwFllxRQz0Dntfn/z6HRcC0pxR/L32hbejTI+pjsXHMftWWclpYOYYxaiJ4tkMwz6wanCuh1djEfBlrPhcBeo8trgsXqdW9y5kXtT6Puids2BOiBwPb/VVMBJCR+yQUjMzgF2+b4v/nIBjr+2XNmFYCTcfJc/DFNpBUJdC6ySvEvizyYGmwSrCvLHX5E0/Zm/Cls0Z86nFVCiZMsX4rmQHk0XD43U7mvRZxeMMilwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozma0MdizKED3wqwUrCbUfu0j98k+GUMNMKeeRIS+VE=;
 b=b/Kc+iHc1OCujpkQu5K2Lf8nY93bLkLvojIHZaclxKSPpNcqcVeSfqW107KQC5ZTbazRSBdU/begjulUSajX7TtM9q/0DZOLJEd6yjC9uXYPnPuVE6U162JLyOzA8R2kO6TGSoMifWwrNMPvvSq6zC9c+pkbXxbiZgjYAhI56w0=
Received: from DM6PR17CA0025.namprd17.prod.outlook.com (2603:10b6:5:1b3::38)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21; Wed, 2 Nov
 2022 07:07:16 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::fa) by DM6PR17CA0025.outlook.office365.com
 (2603:10b6:5:1b3::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 07:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 07:07:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 02:07:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 02:07:15 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 02:07:12 -0500
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
Subject: [PATCH v6 0/2] EDAC: Add support for Xilinx ZynqMP OCM EDAC
Date:   Wed, 2 Nov 2022 12:36:53 +0530
Message-ID: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bafc96-6bbd-44a5-0f11-08dabca0e023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i9jfDa9/WtxBQuRV7l8bJv6mQOKbAGtvtoQJaUqVuQKRhPJ0yRVPO7d7r4vRRJ578bgfI6+qB+KTW4FMxjzCBTVDTNXaOzG91580sxeCUYEbBJTCsTrciGAB9/VaJLb5GGFHA5mxAWupPNbzDV0Tar/Ysy3JDiA/tR46P458fRol6cHcWhi202E7Rj+DPP2Zgd5pGmDc1wCo7YH0B8dnb+/lz3iVJbPXvQ9LXKFOkguT6obSnw6GOmqza1EyjO3nTl+NBsBhMclc2Voz+rpdCjFdG6gVlWjRapofhZKh7aZPjtbmY2YGYsyzZGoU7WSJNjZa+noJKmBxDae7NiWO4tRnW3p2oXQqu58I8uB6CCsGugrqWda4oXE+ueuzrkUY31n6OkaH4XeugS4ul0UOtjBgT7jVjagPg/mMtIntSDGWam4hCTmCzt026KJh3+XyQLqleqGtMT5Ebl54Fj7Usp+dQLQ1PPpwC3pfhtE45DXO2LPKwJ8kSSQiPdyLjKfvlAqkBRN/Qeyrludl2+Gak0MLGsV+Fxb7HbqqWF4sW7TVeZ0PnMbPULn8qahuM+5TfGVhOE04822krmivNd2BlCc9tu5QPiI8lmMee2FVNnNt9RXquqQlJ2UQAz2Cc2g2X0N33nvb4khDRPKcqnabXgfJhr1jRDJulRWeypzSIu7LFDopupL4T0Domh++7Jb/Vfj/U3CuhYw/Xy1WTPJ3qeb1+bArRKsUv19L3SAkad9z/FgFiwQV/Uvmuxal8Sb/RFIF+nxFdWRdLhiiuAud0xW1QnctKm8Q3No5u/Ofyp4tLL1JWUNr6x17wu6Hd/QV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(66899015)(36756003)(41300700001)(356005)(103116003)(81166007)(316002)(8936002)(40480700001)(110136005)(83380400001)(4326008)(8676002)(70586007)(2906002)(70206006)(478600001)(5660300002)(54906003)(7416002)(26005)(1076003)(186003)(336012)(40460700003)(47076005)(426003)(2616005)(36860700001)(82740400003)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 07:07:16.6748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bafc96-6bbd-44a5-0f11-08dabca0e023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
X-Spam-Status: No, score=-0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add dt-binding and driver for Xilinx ZynqMP OCM controller.

changes in v6:
-> 2/2 - Updated subject prefix and commit description.
-> 2/2 - Used Debugfs instead of sysfs for error injection and
placed the injection logic under CONFIG_EDAC_DEBUG.
-> 2/2 - Dropped zynqmp_ocm prefix for all static APIs and structures.
-> 2/2 - Fixed few more comments related to using caps for acronyms,
dealing error info, UE logic simplification, using BIT() definitions.

changes in v5:
-> 1/2, 2/2 - Added 'Co-developed-by' tag.
-> 2/2 - Updated the driver hep text to be more clear about the hardware
this driver is targeted.
-> 2/2 - Fixed the warning reported by kernel test robot.

changes in v4:
-> 2/2 - Replaced \n\r with \n.

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
  EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP OCM

Shubhrajyoti Datta (1):
  dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM

 .../xlnx,zynqmp-ocmc-1.0.yaml                 |  45 ++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/zynqmp_ocm_edac.c                | 485 ++++++++++++++++++
 5 files changed, 547 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
 create mode 100644 drivers/edac/zynqmp_ocm_edac.c

-- 
2.25.1

