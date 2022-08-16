Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669AF59560A
	for <lists+linux-edac@lfdr.de>; Tue, 16 Aug 2022 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiHPJUR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Aug 2022 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiHPJTf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Aug 2022 05:19:35 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FCC89CF6;
        Tue, 16 Aug 2022 00:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvneYuCG9fIoEEZknG1ARUReQD1ZmmWNpbw2vAeC+3xg6fTmM3o6y5T2RaXeGzEkjUoZ8a7XU7WLiM3ppTkF8Jdn1rZj+GKKyXV9lyGk7uRmUwhScdryv6/tKiao2NQgiqeuTyAofgs39zyNC3MqNBv7MeZ90HT/7ZB0lDK2gCGbvPu1ECUax1ngfLOnrLk+xmso3Pq74SkFtwtOCaYOTRm9mzHGriemzuJX0TFPYxwSg9SiY/f9VULEpxFtvitsbOj0i7NjtL3PBWpw+FYSz9hWm+ms2R+cfhA/v16KfdrKgWg/a7l7UElSMqk/Ea1qV8QDrP4sx+Jdh2fJ4v+XQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7cic3hUBZu5lOpka+OZl3gP3SajrQUGyBG9OuiCX84=;
 b=OOuD+gGNqYquQuSSxi1yRtEZV7fhQ5mE3YbsRv64c+2FpwtOrglRjT7rktDtzd2bLO2yjd2k1M063B5/AmQugJgVGhBKDp63cZDlfwB+b8wQdkZXys9pOOx1mFKEWaTbDRvZUDQsEYz0g2CWgCTTAgltJDbpLxp4ric0yDTslYIwAysv0V4Hy5SVyUlXZ6Q0RBnakM6+5e8Xjk7iyK7j3A+90KE0h0C+0+TPZyIriefbBHsTM7ywJsogzaIOharv++E3J0WQ2lwuLwmTHOfl7u5RV8u30JkjuwC6hl713w8nH8ofDHRwZH7JFZ9GbTazysUf4N6l6LEd0c/n91BC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7cic3hUBZu5lOpka+OZl3gP3SajrQUGyBG9OuiCX84=;
 b=Odd2Pq+DK/Dfx5oUmK8KGQT93PWEmqJ2Ni3vDwZQek3Aj5gRb5l9KVYFfMTXiq4I8C61wdBPbKUHpAk/J40guNNxsb1tjy5MsOiu0AdxXB9z9APRvTUqWLTZLqn3F+P6Nt+EQL0NViwG66A7tqCDa93qP9/Pg7MOE6SexV9e/xc=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 07:35:08 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::53) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 16 Aug 2022 07:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Tue, 16 Aug 2022 07:35:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 02:33:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 02:32:52 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 16 Aug 2022 02:32:48 -0500
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
Subject: [PATCH 0/2] edac: Add support for Xilinx ZynqMP OCM EDAC
Date:   Tue, 16 Aug 2022 13:02:01 +0530
Message-ID: <20220816073203.27314-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760583d2-8c90-4949-0cea-08da7f59d803
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhJC2kSOTIPH2kubORwsaeDnN5LA5a4YQ1eCSpBTamj5zSuNGtgU+t0B86Pp1+zKfGf19Zi9MuPPvXKteUDx0TE4v6U/tPFHo/TdDq0UmomFWOEmedEPEUIm6HaZ8qZ6jAzhbs29vIOPwGpqnGDWBqrrjkLXsKzaeh8FhkiomSXeIYrqTNal+GQbfsOeDNqkCNL7T6B9g6fvSji1newQaDcsa41VuOkvxhMvdjeFz4LX9t6+lA3TEZSe/1svk1LqkentKLHLhM3KdM1gIHs5/CgPiz98TFUDg2bQ5tvMYwJqzGK5PPATSHtZSCk48ghwiujFO3oB8XeNUExXUYxG1774XxmYh4f23DD477dIs9cZOSHpdNnUahQThkHjQFyjRimJQmV+HZ6dTQGpG2/QCWOdvDkqIrZnvhAVrxDGSGSGvdqL2GjtkxzwUHHMcN27hihe+n4MSXjmad6CeFVaFJ17ljBMpXEfYitLq3L8ytogAATJCFikv/VF4imFXE/AdrRq/ujL+vgTqcvYYAGgzjZksAbcimlmQ66YP5g2g7mi6HHqpGx19oGOlWJdk+nvB7xIOsxkyYYX6I7grOYdTVTWsK1ov7Q8K8dPqLWowNlzYak9qW5P74fPYJKNDxc54UwmEzSSSzhH2YgMX7gdZ2zh8oa//XonAcvpifjPuwXSh74OzVrskpvniAZRvzVpsloKYjGB5aAcAD59ZFqyIZQ9POpGa4bIIKMwoRBsqxUMY/nqNFZzxMVjw9uQGQj9DxABAAx9LpapUgeTD6XYGgEgDxOVhHU76TM+KEpjuakbllpO9vWkYxu3q4cYbAMlxCJmK+P3j2NrzeMnhYQsqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(40470700004)(46966006)(316002)(47076005)(4326008)(2616005)(70586007)(26005)(70206006)(8676002)(426003)(186003)(1076003)(336012)(36756003)(103116003)(4744005)(7416002)(81166007)(2906002)(82740400003)(356005)(5660300002)(86362001)(40480700001)(8936002)(478600001)(82310400005)(110136005)(41300700001)(54906003)(6666004)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 07:35:07.7523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760583d2-8c90-4949-0cea-08da7f59d803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
- Add bindings for Xilinx ZynqMP OCM EDAC.
- Add EDAC driver support for ZynqMP OCM controller.

Sai Krishna Potthuri (1):
  edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM

Shubhrajyoti Datta (1):
  dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM

 .../bindings/edac/xlnx,zynqmp-ocmc.yaml       |  41 ++
 MAINTAINERS                                   |   7 +
 drivers/edac/Kconfig                          |   9 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/zynqmp_ocm_edac.c                | 643 ++++++++++++++++++
 5 files changed, 701 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
 create mode 100644 drivers/edac/zynqmp_ocm_edac.c

-- 
2.17.1

