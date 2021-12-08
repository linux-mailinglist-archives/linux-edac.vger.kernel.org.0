Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F322646DA45
	for <lists+linux-edac@lfdr.de>; Wed,  8 Dec 2021 18:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhLHRrx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Dec 2021 12:47:53 -0500
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:2593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235411AbhLHRrw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Dec 2021 12:47:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh7n5TJ5c7eT/ye9ORtPAvKPTIpYghzgCPBj82a9u9xuvQz76xbbSO1U03yQ3G9d5ptP9rRGVeVGpXw/+oXO5ku4oDWEicNJQZI4PNuWFlwWWjgIwBiLsBWmEDHPQIk8uJEEFU/heeZyoCwo+tbqjvYbwXZDqT0NZYH3IJTxBvctjl+mfu5ud3olfd1VjjJVLtMCzTlQcSWvcDrmqcFWYLAj7VlaM75A3Aizhg80eZvNGXfskkg9/hhhDDTUU2UfZOaTfFKhjjgD6I3caDqwgd0D3rwEFFsMfICbg0S0XcOX//ul+5Atz3SBw4OqgbC7IXk+S9Xe0JQflT6bLKzQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efpeA6h4Fg4rCSnSQ0Eo/Qg+G+VgNov+h1JN3ZqMp1w=;
 b=FTfrmc5A870JqWnrqcmiZqRSV6ukOC9vgFmUHviM1jvVMJEFjbFV4wgmOI3HpsD5xyj4CBTHjwQDZWYJjgrpOWz7wqZR0+8wzwp328elClQDGZ6AG02btv1xc047252FsEZm2dN8LiMJpMWo66LLhYqvmGNAaUjAowg9HNZAFG1/y2wSEr4RntOdhBIKj0MCyzvWoCByFstxFdjRXlJJllzlz3c8lQU1V9zlr2o7xCuWI0ngazTnezQqK+qR372fNoIwn60+pdoDKwEKh1MGq1qKBWicnIheUj5OT/qvOlSFCNIb3rXvegVSRVUUpigQMgR2nBXsfj2ISbmEr/kbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efpeA6h4Fg4rCSnSQ0Eo/Qg+G+VgNov+h1JN3ZqMp1w=;
 b=Lkq8R61WZ2G3qceo+f0E83dlBst0WyjIAD3geJ/qzyy3YVc0bFYkpmSSSlCX6suK5Xxk3MVmZFu9bt+VwY7UKUYNRWieMIMINNsDy98oQChpxIOwW5KzVQvp3pVaOUr8mhyKuRdyced9CcFoB5+fgteETqrviow4graxnP3cWSo=
Received: from MW4PR03CA0264.namprd03.prod.outlook.com (2603:10b6:303:b4::29)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 17:44:18 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::80) by MW4PR03CA0264.outlook.office365.com
 (2603:10b6:303:b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 17:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 17:44:17 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 11:44:16 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 3/4] EDAC/amd64: Check register values from all UMCs
Date:   Wed, 8 Dec 2021 17:43:55 +0000
Message-ID: <20211208174356.1997855-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208174356.1997855-1-yazen.ghannam@amd.com>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a9d846-2938-4dae-8e5e-08d9ba725bd6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3794DD4894884B08D7AA8CF6F86F9@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4CFbmtu1SVLiWRZvXmT1MuxeI0J1jf9qtslJQKUT5e0FQkKHm1WXYU4WnUR5Ljdxpk+O8g0R9gimEhsQ2wxAOKdWWfhFNb2YZJVv/4sNowmI6syfN2EWxQvgRcFa4FazDXyc/hEtilno9fiyGuw3MOfPbVyzKJ6DGcV4pHitCq+tes5CsfSca7kRqTW2VG8IZguwX+v41ntR6mUc8EvaKjNd6ZFSlqdN6rhj8YHFqyrWh8nnxT2uxkI5LXcc9BZzsKnu6P5Rsd8AMArt6/RM5yZdUncl9/LybaktlhfzQBQnvH6FOjg/p0N7QCRKSAdD+j5qheWPEdW0JTLBDUxzK4+SUf7uq1Szhi88ofjRgx3S+NnELYFzTymnZtz7BCzTDGhA/U0OoLffSg+nY63r08gIklAa7V0IyjO7+EzXDQhL6eRofq/G+tFFq+0IDe6nqBi6IniPyOeKhAaODFfOEgD7J29wz6cv6Qrtw/yb7UVPd4qhUfytGR91CUP5cGEMaf4MdlWegQkng7ZGLS9TQZSX+62PjvZdni0FyfP0/STXOvZocVqWdRABRuwx3oqsED7TBAZHkVNKyrYS1e9YbKCfEn+GDf5xOy7wc6OOepBlmrP+lnaHJFV5lw/a4OBsxq8JUIeLePbuXoD4A0Fr86loc18QzjxhiNVKQlTrOLZFmb+anx7eNgheaw8SbBUcL+dWOYrN7Eq/5lVu92g43XxI9RXNFwD7jEFjPUuGwUuiZEgC0QpZs1pS+O+leTHkALv0olWLPajQgW7Yt9+iNVjM84va6k+uB827tFOKw0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(8936002)(2906002)(44832011)(6916009)(40460700001)(70206006)(70586007)(426003)(8676002)(54906003)(47076005)(16526019)(82310400004)(1076003)(356005)(83380400001)(7696005)(5660300002)(26005)(86362001)(4326008)(36756003)(36860700001)(6666004)(508600001)(316002)(336012)(81166007)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:44:17.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a9d846-2938-4dae-8e5e-08d9ba725bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Loop over all UMCs and create bitmasks to check the values of the
DIMM_CFG and UMC_CFG registers rather than just checking the values from
the first two UMCs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ff29267e46a6..1df763128483 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1621,9 +1621,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	u32 dram_ctrl, dcsm;
 
 	if (pvt->umc) {
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+		u32 umc_cfg = 0, dimm_cfg = 0, i = 0;
+
+		for_each_umc(i) {
+			umc_cfg  |= pvt->umc[i].umc_cfg;
+			dimm_cfg |= pvt->umc[i].dimm_cfg;
+		}
+
+		if (dimm_cfg & BIT(5))
 			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+		else if (dimm_cfg & BIT(4))
 			pvt->dram_type = MEM_RDDR4;
 		else
 			pvt->dram_type = MEM_DDR4;
-- 
2.25.1

