Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54166D5AC
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jan 2023 06:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjAQFlM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Jan 2023 00:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjAQFlK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 Jan 2023 00:41:10 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D091EFD0;
        Mon, 16 Jan 2023 21:41:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2Dz3w+CBX7O5Sax0GoCHfS7yrFCpEsrfzBTyqe6Ks2VSABhEdLYjS2mXP+Ftdde+IOI8RlIjEAubOSSc6tSe3cSuXUTaLGSSUOAzCj2qjEqI/FBefhcznj4y3G4wHqndDPu+1XIwCelP1K3DuWmhKJnzaKHJ5NRd2TTgbAYnaQFedm2OiowsM9vUjVgUztuuCvxkVHkEa7tADQK9U7WCk0XgAKe/f5xvyYyuMzT7gxtTHmanF3GGnOmmW7tqcqspI2Yd0Nr4XpGQWmqOuv4QsNzCbOsSEnLbgFMtP3RNPkqCYSDy/U9eSneXSvx3lDQ87eQDwR2zZ7JqRER0qXGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEIhOEKgRrxG3OnJyp5/W6PW/hD/kEwVmNYkNN4drcI=;
 b=EmXmRBmtIjCC5zYFLsSAebv9GeDhdHq8VIfeQddOsuuKN4evM9tTF4ck21KsomAANj8hbdA8jAw/GYpfEZdFCphgchwRQtmaiNlP9S2ChGQfa4/xWYNfblE5bQoJqL8rtu27hZRxkUsG/enchwX+ZXZ1ml2Wbb88Q//Ir/Cm76RoBdEmXX40mBwWtQZ/rKZySX3ixRigAw4BxQiGwKO3LRdURzkPwG0AObbfwUiK9+S8zoFdOsoUvmPq54VBPRyIgEQk2NrljQ8TdDZWt4UHGQ/owfGmaLMDe246K1qjmuvPt8cVOBRYRf54FX7Hf6Yp+LjbA7NLHiZ9qNKJ7h3ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEIhOEKgRrxG3OnJyp5/W6PW/hD/kEwVmNYkNN4drcI=;
 b=C40PlX5pkkdjndTu7oDhC9EeR4eU4EpPC4EtDSIE7PqaCJ6wfE+y3sLCY1ZnVJKi+5d1tc5ICdyN1ZvdxDdSzX1tfuu2KT9H0A9SVTwDcs8LNm/S7jWJCdIdxXS1YHAmZoZWxZj2Sqy+e9z6K9kk2JDDZyKjsYsfOmv6cliTzbE=
Received: from CY8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:930:45::23)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 05:41:05 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:45:cafe::3b) by CY8PR22CA0014.outlook.office365.com
 (2603:10b6:930:45::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 05:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 17 Jan 2023 05:41:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 23:41:03 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 16 Jan 2023 23:41:00 -0600
From:   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <bp@alien8.de>, <mchehab@kernel.org>,
        <tony.luck@intel.com>
Subject: [PATCH v3 0/2] edac: xilinx: Added EDAC support for Xilinx DDR controller
Date:   Tue, 17 Jan 2023 11:10:58 +0530
Message-ID: <20230117054100.8377-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f2a169-2e38-4f05-b856-08daf84d6d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQOy7mN4zlTwxsmo2PGu1SDFW6W9pxxrSJxmwNnSxfnReXX1bwC1cRtPbZjRK4pXJSm49FXcwk9ujL1OfjWfO3pllLATdMNS8RAxWQP/1eeFAJRQntK72U3BAQe17IYacKf4femgyab221kNIq1sAKasgBqmiAgDfy2BzjM75uwFou5IPs9y4G2RaNz5bN3/XxJ+dJwU/4nhWTuPy+wfTNHbu7FIGJvHykYpIInWAZRO4sI99W8RqiE9oiHTgp7H5SLHfQ3U4BxCONlSwKkTYuLaUkMHt4TXyMEp4ufGR6d6/MA/fQ3QbLAtmjVGHGIAe0NGrLDjUj+5JYqkH10H324PEBptkPMPV+pD7Vg7oZi5PUDKoJw/HHQEMH+WbTvsMHy4Nb9yv1TZL6WixRy4WgRdxbm1vNxUgH0Dpk6OkAXNGzsPlDDuUWhoTYNCb8vJ/AIM3kFVjCqS1OVoYAvLXP5djMLnpTM9uXKFeUWWCxYnJ7uCdi1GzEuZqUtZnYfGznOwjIPG0UBt28NQHdM9BxfAXtbLDvCTB+wCMzIjXBqgiRPmjyNXDGUjtb5tCKBSxMuyTGDCGbFKeKS8KIswq7h9y0qtrldnnO6CP4o119Tq7/Q3NarhHwsBjutv1vY3ArAFtGY+y05/ZIzHFMo+mraFoDYcI30ujH/Xkpvyu06/thSWSAe7yVM7gfwVlCjlqCEphnnG1PqtvDFHN/deoIDOsDzXsbuv4dj7S96hrFo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(83380400001)(40460700003)(54906003)(36756003)(40480700001)(478600001)(186003)(356005)(36860700001)(2616005)(81166007)(1076003)(86362001)(82740400003)(336012)(47076005)(426003)(2906002)(41300700001)(26005)(44832011)(8676002)(4326008)(70206006)(70586007)(6916009)(8936002)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 05:41:05.2873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f2a169-2e38-4f05-b856-08daf84d6d29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/4X
memory interfaces. It has four programmable NoC interface ports and is designed
to handle multiple streams of traffic.

Optional external interface reliability include ECC error detection/correction
and command address parity.

Adding edac support for DDR Memory controller.


Changes in v3:
Rebased and resent.

Changes in v2:
remove edac from compatible
Update the description
update the ddrmc_base and ddrmc_noc_base names
Update a missed out file
remove edac from compatible name
rename ddrmc_noc_base and ddrmc_base

Shubhrajyoti Datta (2):
  dt-bindings: edac: Add bindings for Xilinx Versal EDAC for DDRMC
  edac: xilinx: Added EDAC support for Xilinx DDR controller

 .../xlnx,versal-ddrmc-edac.yaml               |   57 +
 MAINTAINERS                                   |    7 +
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/xilinx_ddrmc_edac.c              | 1251 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          |   10 +
 6 files changed, 1337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/xilinx_ddrmc_edac.c

-- 
2.17.1

