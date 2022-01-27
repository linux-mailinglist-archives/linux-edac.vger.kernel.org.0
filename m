Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8554049ECAA
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jan 2022 21:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbiA0Uly (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Jan 2022 15:41:54 -0500
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:53376
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344148AbiA0Ulr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkb4Vli0Z7BlJKKWgolpzQueVT0MYKATifR+8S91YYP495Dk7YkR3iGXkh8+lF46NL+YF3rw29ce5wkAd1JLVZpBy7/Yo20dsI5pGlXNhuoZWE9vouiKw/huohI7LHMW0yleY03rtIMJEZ2mFIQMKj0bu1N/7kkjQIk9waDu4gm77+dZBi1HMJiNNL68uhk1HtAWvr109Yx1f9dBZMUHa9W6rvZYItr3EcftzmmzMX/Yc6GYxd0WdltjTQleJD9FWCF1Z3I5KMKQO0UAivJVWVyYyKpDDx+vigPXfPnwXl9O9tAskSC1R7bNouh9vz5lgPg+2GEcEs8Dwx9BMW4Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cuvvJHvi9N30OVAfBrOItujXER/Ie064fNeEsrd9GU=;
 b=a9zAuMdyRp/oB2EFz8vvvjQwXoeOHBp0Ldi6eu56w0YQuLOo3LlCl1Ie+iYpwpGcWHUr7ZJe17NE18jTIHG4nWDEQ0V1oS9z/sfHr5lvoGinTu8a+Jf37rdfMfcLcjoDRv2jb1xJJ56BOHCtDlQGaxv7HHX4TCAmen3DQH8Rp0nbUbzaelp0M+a9lx6KbUzA+5yq/ls1vOYWgZCt1b/ldDljciw/RTQOcuZKFaflzz04VrYjpgJa/8IfRnNvpgEoxgL1MOsTcBNHYNme6AHsPmp5S4TGNrYUT8NRG/NQtiCR68wS/bk01K7JWVfrHjXxpoHF+a/AIonFjWgi2hApNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cuvvJHvi9N30OVAfBrOItujXER/Ie064fNeEsrd9GU=;
 b=SIwTOfJLLObEfHx/U/i5yajoGBJxGiMvc3krZstX1iqsXNj1pu5H0hJY4OOdk9/D8yoXlkkEfkX9pw3kGZUH+ALqpfpvXnPTwz2dsSPkiMxnMsumnu7sKtCW3tXrd7vnJJjEr/3oyY/xlvXVOyTl+Bm3rjQ7Iv9W+in2Gx7bRrA=
Received: from MWHPR17CA0086.namprd17.prod.outlook.com (2603:10b6:300:c2::24)
 by DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 27 Jan
 2022 20:41:46 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2::4) by MWHPR17CA0086.outlook.office365.com
 (2603:10b6:300:c2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 20:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 20:41:45 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 14:41:41 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 11/24] EDAC/amd64: Skip denormalization if no interleaving
Date:   Thu, 27 Jan 2022 20:41:02 +0000
Message-ID: <20220127204115.384161-12-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127204115.384161-1-yazen.ghannam@amd.com>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0bd9119-e304-407c-ea77-08d9e1d56f4c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2407:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2407A6B9818ABE1E6AF082F2F8219@DM5PR12MB2407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0O1HniytTaa3wNV7/MgdlWiyOFTdid76r9AgGQ5lPBJcPbc8qg/IsFOQ26mrt8+kQNWb+kQFwRMCIBR/3Y43iEXTW/3C337Mn2ygsv8ZkTuJYIQkc6O2o3IYJuUjURlHPG0TCxxYx0iISo4bYCRE49t0iZ4zBWUc3ecW0f5KRoarY5wzEmw/PZ0wYgZcU71DSJMc9Ls8/a5+XeI3AWvoSHnfUNYO24eUOTVxlqvnNvB2WCV5GvlfjsGqvcBbdyIEUzflDL56jsWqH96ys3ZS0tPiUrW4mVHGCaGfXZWlGQMMF+GwtRTR2zJsCsktH77JFdfuW1Un78HkRA2Ssdmv7B+EG3VvpSXryMMffAmMqHqP5mbE+fB6T/oojXqaYohPhTBsQX4d8mTP2LDJgpdlceX5C4jURH3NscUMuukk3C9S85Y+wmvAJXjU7hP0OMlWeFObWjZj1WiSwNxEdzOitYNZUb1Nhx8k+fNMhkdAxFcsx9INncdSWa6w0iIseUXM6oSX/Bhf26J25shmn+ny2d+Ui4uFLNnf59u/1i3HNwzv72TD3qGEFuGVECXTMU5CKoLx/xj6wb2dHQtXSSLJ1mkQXW20n6xmxe04PIc0yXK+nYaGSPeqUWp/6rB9y8ErfB1fugoQLH3oYZJr/rSZZK27kPBE6iqqq6jwoidW0EwUFVOqb7dj+HAcnlrV48bHyL0KymJIZAoiBnbxe+9zZJvD+Rpl+qYkqFWmwEu/rMd28uNM6Te+cZmEHtXNQR4gg+KFQBwK4ePVQM1QPj3vWiQUvH/0TYIsFLx4EyLbzKBrtq2CpKYNYG9PAxmTch7hYNprmit8+KUh89mXRR8IONTpLTYAXPpf6AAatJSopV9th2u+raKYFP0T3TVZjh5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(4744005)(1076003)(316002)(44832011)(5660300002)(8936002)(54906003)(40460700003)(4326008)(81166007)(86362001)(8676002)(426003)(2906002)(82310400004)(70586007)(2616005)(47076005)(16526019)(186003)(6666004)(7696005)(6916009)(36756003)(26005)(36860700001)(70206006)(966005)(508600001)(356005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:41:45.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bd9119-e304-407c-ea77-08d9e1d56f4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2407
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Denormalization doesn't apply to the "no interleaving" mode, so return
early without error in this case.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20211028175728.121452-17-yazen.ghannam@amd.com

v3->v4:
* No change.

v2->v3:
* Was patch 17 in v2.

v1->v2:
* Moved from arch/x86 to EDAC.

 drivers/edac/amd64_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 53d9c4b1c233..b75311acbe13 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1203,6 +1203,10 @@ static int denormalize_addr(struct addr_ctx *ctx)
 	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
 	u8 num_intlv_bits, cs_mask = 0;
 
+	/* Return early if no interleaving. */
+	if (ctx->intlv_mode == NONE)
+		return 0;
+
 	if (get_intlv_addr_bit(ctx))
 		return -EINVAL;
 
-- 
2.25.1

