Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D32517C3C
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 05:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiECDcH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 May 2022 23:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiECDcH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 May 2022 23:32:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D11CFD7;
        Mon,  2 May 2022 20:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC4oYDd7uDN8W5OUKiUKCu2ecWhx1wf0ijJ3fvoaa6nVV1RG7QglqW5e8UZ5rDkIVOkoCAtZTeSRgc1OuCCE42Rr658S0c+YlkEUn0WZSHVH6LYk5N8BbvzUMIFH4NB+EuBivnPQ5sVnDElccPOLhn0NBf/ub8CFi4GtJa7Zfb6nAi23FGoHkyucAqTOfWyBZYj+2+yGCvjpgeNPIbbsqz8HVKszUqrbvxwd5L39l2JqOyrLuVskYyd2KKAbkAFQN5aoralDgqMmsLJI4LyFGwdUbBjG7Z2QiV7T5wRRFRqoWCORRZluND5pmEP3iqWh1lqD9u1nKGuBXHgHFsZu5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxx9Zv68qRRmYY4S50T1G2GEMLZz76QUh+dPUB7NwZE=;
 b=TGZj92nV0B9JDWW75ng+7xd7vlWbFe0mwnRdoufGhWpKSRKSFwBUaa8TbWnvMnxImAGXy0kYzmG+tso3pgsyekQG9VXKII47wWZAAMhiV5iViij+t/A5aOdcxPsRZoM8mDpL8Sedbda+45W4fJRMmQtpBXOTy7DRlNbyjC+5PdG1PC5NG53AY5qAB09OkqQ5hnJgQ17a2U+IW4eJPvrvbbDa793JsMTYIaXnYFrRwhQ2qYVnE971S4DAN+VDqSmKwHModfz7c+yAJP0wuD56ybtl+jPpIZ0n4VpXyvh9FGHwV5XRmV57nI+etAmI5fPeGy1ZjpLTOGgA7FmVPl6Low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxx9Zv68qRRmYY4S50T1G2GEMLZz76QUh+dPUB7NwZE=;
 b=rX3ja036TaKua3visY7b6I+yMLaaKg3lDJREN/ps6y+B18K0EpRUntsB3TPLCyYRmHR0d5H/zHlJSyeXcaXBB8EggHUIVGcjp7vTnYnGvFZPnOoam2JmIHQyHk1yn/nCPQYm9YSnRM4FZNUV4XUu/NbgZVdMLQZeCw7J4RyManM=
Received: from BN0PR04CA0175.namprd04.prod.outlook.com (2603:10b6:408:eb::30)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 03:28:32 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::3e) by BN0PR04CA0175.outlook.office365.com
 (2603:10b6:408:eb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 03:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 03:28:32 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 22:28:31 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v5 0/3] x86/mce: Handle error injection failure in mce-inject module
Date:   Mon, 2 May 2022 22:28:16 -0500
Message-ID: <20220503032820.61667-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be2d4c4c-9905-45f5-0426-08da2cb4ffdd
X-MS-TrafficTypeDiagnostic: MW4PR12MB5627:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5627A1FB1D0F5C6692F49E1590C09@MW4PR12MB5627.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNmDyqCuoDH16V0JlS2L9oHZLj2tVvWrbcWHNF6HzXtBtcW7qQOSbSDVdqVBHUwG45xYybT1lw50u9j3u2SIAA7aeaoA8RDkGVE3OGhXFUfeorULC6dw46xqNjYXa4jOVJaUT7Y8/iYXnhwxD3mFDMo6o96EmJJJUIF85fZj8S4QoQu+3MUXTlH3JBqazAq3mN4toG5OJn/bspr/Ihkm37fWBJhOjBqN+u9Q8YRhDAvwh5j6Y9E9RmCuw5SK4C/yCzQDyVFxt06JOQr2L2vwmZAwMOwZtE2CkfW8Zj8MF/bvs0bdplqEkD/2eJp47/8qDdyAbAcg17TXtSLhyQmIHl6XW268e0njeNoJEHUEsGgzE4/cTJrHsaKF+M5UCF7DFp6ydUS1TbDJaQZ5GNpkG+Yr8uBdVoJR8soW4gJ9PDLM753762ARaNJBhg/PfqIRCyeUhjVs+ggiqp8xYhi2If8aUTPpYmLd57/4oljGmt9LBsMsSSJbag8rVaMR+Z5jNxJS3gfI8LUa/xnKtHMsk6oeCbcJtFcBLIwSw3dYOS1HzYA9yuCfOG3s45uhMwIvYKzlL1u5gwJodIpvN0Wfqdn8XdlqV2TVYuDhU6rjpXRwH5eVvMq76WCZqbt2eeF67G95x9puP0O8t2Nvymh65xt93XaKUdmVt9Wk/cRy9Pr5DHjQvll/KakTEbwftTJczT008CQYFspLxuSbL0VZ5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(4744005)(70586007)(6666004)(8936002)(70206006)(508600001)(86362001)(8676002)(4326008)(110136005)(40460700003)(316002)(82310400005)(36860700001)(54906003)(2906002)(356005)(47076005)(36756003)(16526019)(26005)(186003)(336012)(1076003)(426003)(2616005)(83380400001)(81166007)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 03:28:32.3975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2d4c4c-9905-45f5-0426-08da2cb4ffdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This set of patches handles a scenario of silent hw error injection
failure on mce-inject module and returns appropriate error code to
userspace.

Error injection fails if the platform enforces write ignored behavior on
status registers and the second patch checks for writes ignored from
MCA_STATUS register and returns appropriate error code to user.

The first patch does some cleanup by replacing existing struct i_mce
with inject_desc and including error field as its member.

The last patch assigns and returns the error code to userspace when none
of the CPUs are online.

Smita Koralahalli (3):
  x86/mce/mce-inject: Replace struct i_mce with struct inject_desc
  x86/mce: Check for writes ignored in MCA_STATUS register
  x86/mce/mce-inject: Return appropriate error code if CPUs are offline

 arch/x86/kernel/cpu/mce/inject.c   | 124 +++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |   2 +-
 2 files changed, 82 insertions(+), 44 deletions(-)

-- 
2.17.1

