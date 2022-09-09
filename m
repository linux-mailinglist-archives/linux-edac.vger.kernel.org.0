Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07D5B2E76
	for <lists+linux-edac@lfdr.de>; Fri,  9 Sep 2022 08:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIIGGV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Sep 2022 02:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiIIGGQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Sep 2022 02:06:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B85F7767;
        Thu,  8 Sep 2022 23:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1ghE8QrQIRauTOkZqGFPM5yfaNkMUay82riTtvlSTOOuLeBFgeFrTJNi8xfql2VDVOC/7hBlpYONgWCGeMoRJujcniEtcQb6rsdRzokOCp9zhcFDT0151phIfngwsSaurJf5ttipdsKC5ydFZ/mY/fVXsWr9b1SY/kejTlaBwK0fXRP0DOqlBvBSdKLzIj4QpeKvx9QYE9RhqWjg6ss30Xz4IJDPEDWBR/jqUJDWxT2Xpe3G4cXZQGOb+rmOa2Msgls8wYfCsvh3vPzvSXB+B76258agGH+pUJbgweoKIuJmlsAhu2MF9poz0DOn4NB2BZMKylNQJTOAKlvc3vmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkSK8vnX5eIRDE5Pz+h0RnYfAe9p+VQb7Zc46JcUE1A=;
 b=hqNvQPPSqjbTolH5io53uVDyPJklEktlS+twVlVrg8Bf/JTcsOIU3oHV2N/gBh45bkDsMYdZCFwPYfL0JodLeZ0uth86VLOYGRF5pA6ulPiIbPWrWVSRN6KXP8utG5k9Z53oBJXnj/oDAxfGSHadpAUirngdKxpvELwqTbbFH4+7TEEON4Fegcte2H84yiIzrbFLHOwBke1XWEWTSYIF2RS0Ta8KOBPH9XcngJdqkh/W0Xvvt5d47v9eoTqKLHRqh/RwXbVXwzCu5PaDD66+RFBy9qlK2qRij1rRFbMYfr0TU9WdPEUqZItfb/PrIE1eta+1KGZrZfNrHLVpcvpgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkSK8vnX5eIRDE5Pz+h0RnYfAe9p+VQb7Zc46JcUE1A=;
 b=yyOlLiDzKZ8fPbLlQZ0AiL6SE6NUYynCD2C9uSQv0VuD5BC70QF4FSboI60dxMvbq1qChhn2MkdDSCT5k2qAcvAIFF+2qcLd0XRGeiob3ZT71+zFbNshKH1PrSf7QVMPnUdt1LoLcyiGGdUq5w9BWGVFs559xB4Qyi/sMLPczUA=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 06:06:12 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::4c) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Fri, 9 Sep 2022 06:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 06:06:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:06:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:06:07 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 9 Sep 2022 01:06:02 -0500
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
Subject: [PATCH v5 0/2] edac: Add support for Xilinx ZynqMP OCM EDAC
Date:   Fri, 9 Sep 2022 11:35:46 +0530
Message-ID: <20220909060548.24694-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5489d7-6099-4aab-b36c-08da92296580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hJExN/Bq+mBl6irsvAuJXopjIVXMXiuSwY7UyMyT2u8TJpkFoE7EkRuR7awUBKtmb2eoyDb39x+sNb4QdU9wWlDLu74n4Z2OBBxhn5+klReAUq/p3/k9XbyYFcZoXSvBccYmAtrkK9OYHVrjwjCEXGUp5Z8SalW7nE5sSqVdwh61jvAz7R5Q/e6GSbrivo5iGlKIE/IUcnfR7rwwqDK+k1Re6Z2inHTbvulAZBsLRBwcFNfD6JvaX2swsgox2SonWt5+c20rN4LvZodaV54+i+1iQ9CSqUF8BMGFpZ40F2Lum7mk/yYTuE7e5FpX9X6fdqBQv3PKXxEETGT/EY5PQZBXznroiPZKpDWBXbu7b5x9oOQZt6Ti5q1jq15r81Nxx0YGVkMvDu/riwlN+ixDA105RDAbwLfT4sy5VMyHSmye3ljTqevm9eygk1TuCM29T0mDbgrPUTj2v5MsVs10Zz1tJDPAY6smtJWEy62ngAXHc8GnM1R2e30gIME6vlvH9YBIK7ACTkA88hRGDzHk3lidzDmX5O7w9asieE1FtqPkbszMMXuEhi+A/omXfIhC/1S+UcxVMKYK8LVgVaX/SQcLllHHufBRkHaE3QCMRWO4Wxej3Z8XR0KkTpoYsJoHPhYImgRslt1pJ67PB7Dgxb3Gip+Hv6LAzYLQ3qd9T4hs6w1TOLjAOnQAt/wmjK0wbtXrkLCABrAk3/0YcJXcYxCgSObYSYMI2iScNbL63NXMDMPI5uZ7O92PuJzaqQ4a9+r/J3rY5of4gOzbJ8CBh6YWLP2sO2jG3wscfm71UsYsB2B/KK2fWoYrxv8LCEF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(81166007)(478600001)(6666004)(356005)(41300700001)(26005)(36860700001)(83380400001)(186003)(47076005)(336012)(82740400003)(1076003)(2616005)(8936002)(426003)(4326008)(86362001)(70206006)(70586007)(82310400005)(40480700001)(7416002)(8676002)(36756003)(2906002)(103116003)(40460700003)(54906003)(110136005)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:06:11.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5489d7-6099-4aab-b36c-08da92296580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

edac: Add support for Xilinx ZynqMP OCM EDAC

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

