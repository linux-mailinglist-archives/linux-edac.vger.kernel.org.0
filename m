Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B433746F3D
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 12:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGDK6s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDK6r (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 06:58:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951F6E6E;
        Tue,  4 Jul 2023 03:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRZOqETYujdzuCGEY3T+QQsAG+pLgMAtysoQawLCKstErZUvvpk4CF5lnFggSJCPISDHad1n2xT05WQSDEEtw812c9ZhtT26ZrQA3rHEcQ4yzPaKbos2+zyrjnUkVhOfwW033QMvOwksBtKu1+VlETLzTbGARrgFwrhOAjaUQwvOCD4R/FtRIHgcFDy+a4ekWsnum+2Na6FVU+wzm+v/BT/afEYLpaaAk4zy5NdMFoPWMjQcY7sjAiEz2bjdIJEZQyc+4gUKhDs9GE6klCE8OrgNuGcFAeGIGarElovlvU1riQC8YMOHzTbdi2b1GxYv58HNY5xXEyZ5vYyHNAPQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElYD1DECEllFaUY57hPSs9+Ry/XT56/eprT6r+ehKdE=;
 b=nb0Y3j7cOOcJH2p0nlIuBCNnG6boXLZc9y3jJdpQZgVy1bxncL/WjN1yD+C8hoq+j2UMOvlAd1c9fRgQF0EFCKhnsgw7csTDShZ39QbuY7NZC6K2DAohHzXp2CYHLdcu0BaLX9XZZOwlJ6Cc4M+xm5VDEN+m7XuETFZb4F054AXP9BoUkwnHk/1Y89jVsPj+L+Qm6KH38Brq0WoZLU99cYZMtgpQUNAcMPjpxrzchsUZxtLAFeue6s+2Z6L1XMTJrnKVEbiSEY+2i9cF2ImvoXkTPxP+I0r5+XmbCDehsim4va4zTVtb+Y1LQbkHCN5iiihyKFfwU2ZvgL1iyUK5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElYD1DECEllFaUY57hPSs9+Ry/XT56/eprT6r+ehKdE=;
 b=BUc57KOvwbgQgWAYzRbR0cqLHuADIbbaOmDLQDlxF1I1s4fADSnyd2o4oviSAme5zLZw4O97nPB191ahSm1Oit5uypRAfEKwtSczZcKZWeLV1iODvqQzr68Nm+zrfUVSofFP5bt2GUUMNXll4I/EyJycS0BGptkhxBR3UfRRu4w=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:58:44 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::12) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Tue, 4 Jul 2023 10:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Tue, 4 Jul 2023 10:58:44 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Jul
 2023 05:58:41 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        <bp@alien8.de>, Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 0/3] Update rasdaemon decoding for AMD systems
Date:   Tue, 4 Jul 2023 10:58:20 +0000
Message-ID: <20230704105823.3516889-1-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffe6da7-4580-41d5-02f7-08db7c7da26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFc2/E7p4yOAmt8jApj/YdtFcVBVLo8vFksGORGiBE15eEV+rEcxBowbRq3qUyigzDZCNbUV5TpSx/v93qY4SRvmbPd2zu5xEKd6LvwzYfsCfUKiv/XPgJkXZj/T586mX1Kc3WuumWzbYBOtCVt+GMZc5ojUP7RNI8d3vF9nFkVUXaCkBWMtpGKhWE9WQHTaREYQVra55YzsBb5iqDvCfoi6FiQFUZsLVmPIugokNJZg6KTwFDLO68QRqynDoOBSaAPqwS6JuDML8VazzwslgJxi4PST5MSrUIfFd7D2onmHe1mXHwULqzoHzbjSgAK7dvnyEflSc/XKvU6ethi5aZIpWl9KGMauO6W2JAQ/giXDrr0+R4z9kjtyMIU5JHM2StdzFIjsiqBoG1bipZC9fgTFC1pgpxScFxlUY9WQg7nqR5T9RS1guP8VE+FHIXA+GkPSPQ5jamKhdOajVMRgk3BXIqaglqOGMAkhjCD1wQzoarFHoCd7W2dY10ixu2Hqw6Ov+mi56OeQQoSm9/vTShlHrmLScyk4sP2I/3OCgLEa4rrOylVrIqSWBGpQooZchs1bV+IEToMhrslcFFE3igptcQTEtaIqoJQ7fF0C4TJWsQE+fpKZN5LKp01aQ5LMTnKzUPVTh2YZ7fFhd602cFM8G7T2NanZoKVecAvNvU/6tBc9PbvunJr9HiVK6xcLtPkNVhROMFkNP28Lr4OmZ0nV0bJSZbGwmb7SoUcU10OkQ8UVD1a44UTaSfjh69trc2TkK1cag6OKb+0bwKE/EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(82740400003)(81166007)(356005)(40480700001)(40460700003)(316002)(4326008)(70586007)(6916009)(70206006)(36860700001)(47076005)(2616005)(83380400001)(426003)(82310400005)(336012)(186003)(26005)(16526019)(478600001)(8936002)(54906003)(8676002)(2906002)(966005)(4744005)(5660300002)(7696005)(41300700001)(6666004)(36756003)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:58:44.0019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe6da7-4580-41d5-02f7-08db7c7da26c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

The below patch set is rebased on top of pull request created by Avadut
https://github.com/mchehab/rasdaemon/pull/101

Patch 1:
Decode banktype based on InstanceIdHi field in MCA_IPID register

Patch 2:
Add New SMCA Bank types and update error decoding descriptions.

Patch 3:
Decode reassigned bit definitions for UMC SMCA in Fam 19h Models 90h-9fh.

Muralidhara M K (3):
  rasdaemon: Handle correct bank_type based on InstanceIdHi in MCA_IPID.
  rasdaemon: Add new MA_LLC, USR_DP, and USR_CP bank types.
  rasdaemon: Handle reassigned bit definitions for UMC SMCA

 mce-amd-smca.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

-- 
2.25.1

