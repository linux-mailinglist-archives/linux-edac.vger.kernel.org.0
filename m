Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379BA3E7E29
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhHJRX1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 13:23:27 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:43873
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229582AbhHJRX0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 13:23:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cdu8jdWkGKzeCAdRkpbdokfU0bRFndKeMQkVxx3CHAOzQjGSPVhYis0ZJeWKLoKcrjjWi+hDhEerwTQo6TIUtXTI/76rr5mY+z77JeGx/yf/CrmVVaqpIMccx1mlaOYjcsXYZ7dLSYH2+aAx+TXyeBaFEkPxIrWd8uFkZhLJPtsh3ZRLcmOr3wyJuTwKMe/g/BLlnSwhgMzTeDzdez/prEtyQvwHFeD4cmgMua4BoKu7vLOXeQgTXM0EaXBHjzxTRhF/VW2N6yJcowEZrtXZsJ6h3r/u5DaEJpNvaw/Ud7DnhHprzI76mjxRHQjhd+kvcXgqbLzLU9TVqRr5nURk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRrxuVRTI+PoZEteeDNrCJsnPWzYNUaipkancwLpO4M=;
 b=RuCq0uD9L2ZBRskGcLiXmMGUGJKJI9zthTeXOz/oij7pISPaFA5PZBdSz7cD6bOHGAzUiQiBeDCi4VDUyU1qUeWBaEYgoeXBi2IsGncgwour1QIHlcyy/5zCbUAG3xO2CGTSCnmpzWrR+KGZhbLOy0UDptvmOgzh31QY+LdLiHdhmPz7trB3x8NHBtbJF8g0kLmWD5WdgEDi/3/RjV1Y5EusUq5KAXiDwzLeZUlbtmLf5FTv4dNNtRLkk9++1bQRpC5dMmtaGx5CeiPdjQ42XQEK/aKytWOo1X/A4EpKvRKxooNzkvRjhNDMT3I8JJ99no7lBKAOmUgmeZ4ZpHuMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRrxuVRTI+PoZEteeDNrCJsnPWzYNUaipkancwLpO4M=;
 b=VlXt8xIrQUTCWNmoKsUzzO04WmEYolWBR597k9jHBAi4IigGJ+npmVEYEag+WTuHIrV4G4rlINxCSyqtAizPjHFpGk8FW9ks5lAugEETaVM0eQUmvlbvhYt138aZ/PfPU2xLsQyZxbFCyLn5Z8F879hcHuir44IVhlrRFgLsxYM=
Received: from MWHPR19CA0008.namprd19.prod.outlook.com (2603:10b6:300:d4::18)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Tue, 10 Aug
 2021 17:23:03 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::d5) by MWHPR19CA0008.outlook.office365.com
 (2603:10b6:300:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Tue, 10 Aug 2021 17:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 17:23:02 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 12:22:59 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <mchehab+huawei@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH 4/4] rasdaemon: Support MCE for AMD CPU family 19h
Date:   Tue, 10 Aug 2021 22:52:14 +0530
Message-ID: <20210810172214.134099-5-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810172214.134099-1-nchatrad@amd.com>
References: <20210810172214.134099-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0821693e-142f-4108-06da-08d95c238260
X-MS-TrafficTypeDiagnostic: BL1PR12MB5334:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5334C7B83E1C10CE9A3A13E8E8F79@BL1PR12MB5334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aedL1TFRLPFgA+4zuf4FjxdukqHvSy8hHp8wdbsoscvYmVw/KF9Z6SqNiIyoopSDz5jaUoxtQtb36FgRUv9Q3VjKLLlB8N8G4vLLjYIQNJblzZX/i8l7U9dmrEgEm74KIeV2ZBYBRsL4/hDiEdqu/4GpwCrZtvCPDfCmGVuVxVjcjoJ5k3GiXyZrK/REUXSpslTd9uYxj4PBLYtIMXe4xR/kjJtHG176SRgwUxa3UfCMR6tq7LObf3DY5r9IfqC+sbXRp0/sF6bYyaGa3SKdBCM/8zviXF22154gcViQpg+JUzmq+I6JGK0iwFR6SGfZVIMGJvueXDaDX9O2vw0YS/z2pvDz6wSPokW7yKF7fI9Plok5EWBmicW5IMuS70AfEZ4MSvrXlmiRwIVNFf/NBLCcQW3Y9gFEeQPI9I3ELvhhM9YNL4J//zoZSVvg07Dz/IvvUxRiE6HB2WENT5t1vunWnb6S4SLLVSqw8b6eVOmE5XAMEx7MKO4isBXkFr8BhqTwxAwFHjl860QfU1s0uKgSLZu4469jwjmVSzvCcv0n11jvSLtCEQ2dT+ZUsGEgLPmB2WFm2XCoTM6bHwsLJuiwimxALlQzSil0noK9hZUb8QyTaBppMTLlnTX3VrZOwDu6V8jtTUcFWTMDia/60qrmShE99i5VBdXSD6W+YqYhLB6CahrYJ7Ao/IiTLmUQRO50Ec3n/Mtc4GUiWHcIluUDoSMFLTc8tAeZjXirz9kBVqG6q1k3cilZdz0EntEobe0oNgcVdZCETXZ+DpaMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(316002)(83380400001)(6666004)(36756003)(7696005)(336012)(8676002)(356005)(34020700004)(82310400003)(26005)(8936002)(1076003)(54906003)(478600001)(16526019)(186003)(5660300002)(81166007)(2616005)(47076005)(6916009)(36860700001)(70586007)(426003)(82740400003)(4744005)(4326008)(70206006)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 17:23:02.8978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0821693e-142f-4108-06da-08d95c238260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add support for family 19h x86 CPUs from AMD.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
---
 ras-mce-handler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ras-mce-handler.c b/ras-mce-handler.c
index 805004a..f2b53d4 100644
--- a/ras-mce-handler.c
+++ b/ras-mce-handler.c
@@ -208,7 +208,7 @@ static int detect_cpu(struct ras_events *ras)
 			mce->cputype = CPU_AMD_SMCA;
 			goto ret;
 		}
-		if (mce->family > 23) {
+		if (mce->family > 25) {
 			log(ALL, LOG_INFO,
 			    "Can't parse MCE for this AMD CPU yet %d\n",
 			    mce->family);
-- 
2.17.1

