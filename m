Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2665CEA4
	for <lists+linux-edac@lfdr.de>; Wed,  4 Jan 2023 09:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjADIqd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Jan 2023 03:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbjADIqF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Jan 2023 03:46:05 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3118B3C;
        Wed,  4 Jan 2023 00:45:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkbXcd8MPuh2svqppW4DAOUoYyqk+WrAXiknsp/3GJA5xTBxopTOHYcYjEtnR0FDfXEwTCVBZMu4RSuW31XaSKQwm/Wi6yBhdo1g0jgM0Wmkrt4qg1O+cdPz4n9SxJ4Zka4GXafc1h9FSzsHJzErqUWI80DvUhPbHDv3jhsUCXGmme04Uem8eu8fvoxB+9vW/YTk+JQJs4hMN3O6mndEOJBmDQUNhv5b0W/8usCSyJIEoWNLjH52lz3qO1HcV9exka7t7hwglFUMClas3kCcp7WpoGU3OZRnBwFDMAROtIYkKNKsnLMa4WyoJ0Y5WPWLGST1tz0sHazT5nO2vHCgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9DRz61tYaKyVo5e8+t3w/hhVLA6iVetsBIlDVf6XLg=;
 b=QHrV0B/qc2VvyUJTcbyv3xKoCD+27ffKwc/IdzjlZjvcB30nCejtxmQm6DJf2BLDdzubJkXL2zWTh6TaIK9x9AUs1DARJKI2lliR3UAmGlLxcaBOwx/2WWYCSkwPmnR0boaZQplrSJ1j28DPAGT3aK6zIMUGkxWkrc8GdCBg3f+64YRzEc2PcVHOKk4wMYNNoHCidJo3QCDuNr8hQJZ7xyc8zvu8qnoLo25VJJg+JwheNsVQe5wRrdKHUdYqoC6ztlpGOsr7XmUHgqSgKIl9xRR97nN+xhC9Ep5msi3K8xkOxxEc7Ov6+2BxUxyVZ8ANJfBp+3JlxpMeXIx4cBqW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9DRz61tYaKyVo5e8+t3w/hhVLA6iVetsBIlDVf6XLg=;
 b=xmgbvMf3xf0Qs+2rsmWitUvt92+ws24lWP4RDc9OW6Ng1opX700smbrcglCzNfsYGQhmeXXqy0YM9HTrUSrkhh2rq6u2lpat6PsjRxDSwVcCEsftRIh/Fcp58t9wqyuvtiWQe4TbuTP5pn8je8rDYjFVqrQeF/pDwD4Rwtv+90E=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:45:52 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::71) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 08:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.14 via Frontend Transport; Wed, 4 Jan 2023 08:45:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 02:45:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 02:45:50 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 4 Jan 2023 02:45:46 -0600
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
Subject: [PATCH v7 0/2] EDAC: Add support for Xilinx ZynqMP OCM EDAC
Date:   Wed, 4 Jan 2023 14:15:10 +0530
Message-ID: <20230104084512.1855243-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 0843cff8-57ee-4273-7ccb-08daee3015e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8dYcTMZmlPMLM8TeUSd9S0vKZpLEvp0EeHDCImJT4pH9OtsKznZQZ83nO5lxAMkpmzUUbwUg5CWk+toZRDR0pplijk6q17i9ZjtA5TviQvT4i7EAOHIFef+J1eFP4pHsw16Kgi2Dmsgp4Gl7RkcquwHLboX658TCsneToXm60zMOD3GFD7VIszQtKRfG7jw6Fvv5jld2E8za8FH1XphG79L7LNyFzTxZFbSv/ijLfHG441UjteOGRqbv2o5yoA54Hfvv5r8qP9cFKvqwwFBGL0v1fV2k2UaBAQoHYG/4BT+jUWKvaMQJ87hr/iecKvPN3Uml2xDAHlJ5ZSNt+wIiKs7aykNUv54uIx/BQ1RBLyw6KiYxKZi1K3jxmALOyf+j4yN5DEN36Z9+cb1N34ZjOMWEXknrGZrjeRWDx+AOsNjLfEKHR5bWe1wmS/91ck3HP3IgjpH5qG76wZIFuFKS0KHdjyYvibXqXWZPoapgwQrq7C5gC5QLf4hxDIvkH384+EFj+biFreTZEiKbrTW0R8tGQbHhgQDXA9AqLfZFI/moJKWuU9MSf5XSW5CUfuyTdbKrmiay28WuuIYB2oA6L8Zs0qvQ0hp1wItIRsjuWPnRKrT4Rx1+L2+/AQRcYYB3HIDqMCbp5ABMTbsvy+iFKs2b3RifVuBcPfhTZPea37S8Ga9MDSh4dymi+TTgY9lWm56pEpmeRCi5Vfqqpeo+PoXb9auANDP+25/ViuXRmo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(82740400003)(103116003)(4326008)(356005)(86362001)(5660300002)(7416002)(70586007)(70206006)(8676002)(2906002)(47076005)(26005)(41300700001)(40480700001)(82310400005)(6666004)(186003)(1076003)(426003)(54906003)(110136005)(316002)(40460700003)(81166007)(8936002)(478600001)(336012)(2616005)(66899015)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 08:45:51.7986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0843cff8-57ee-4273-7ccb-08daee3015e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
X-Spam-Status: No, score=-1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add dt-binding and driver for Xilinx ZynqMP OCM controller.

changes in v7:
-> 2/2 - Renamed the driver file name to zynqmp_edac.c.
-> 2/2 - Update the UE error injection logic to use string separator,
also removed the inject_cebitpos() or inject_uebitpos() and handled in the
top level inject functions.
-> 2/2 - Changed the name of the debugfs directory to "ocm" to make it
simple.
-> 2/2 - Fixed few more comments like update commit description, used
IS_ENABLED(CONFIG_EDAC_DEBUG) instead of #ifdef, removing "controller"
string, local variable ordering.

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
 drivers/edac/zynqmp_edac.c                    | 465 ++++++++++++++++++
 5 files changed, 527 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
 create mode 100644 drivers/edac/zynqmp_edac.c

-- 
2.25.1

