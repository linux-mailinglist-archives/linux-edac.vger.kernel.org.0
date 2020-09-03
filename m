Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0E625C9D9
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgICUCJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:09 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:37025
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbgICUCB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cahbnZeXmpTTuu7DpEvoKnG9iyy6DK6exotYZljISQy6S/1qxewYD04l1QF8Gmg8QaYIxw50AmhxzRt+WSMwcBopuCvoZUHBObOgKS8O/nktqrPwN411Ob+oEc+knihfVDPNFjANlh+NPGy7BZUXklBdqfO0K5A1bczcMXOjoOtlYXNk9bLE0Sg2WoM0cFe/5dhEcFtcixFijhPJpZtOm+24Q4XDwvdpV+IfCj0vsCnpktYhFCEr7A+VTLr5FTUVNKcZlKnwsuo9yjArCrKNvjjCYNGu7NjhEUBpdVeanm1X9w7Cf808KxlrLYUFQ7DXqMetqnve0A/lkATvALR4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLrKtFSUF1hi1Oba5C8ae3HZj9IXOshDWFurApbB94M=;
 b=htiMrjMT288tpK1l26v89ZApl/T7zJQA36sgsAaBfsQplFmU1GTfAR/8r2Y0OC3vbZp89Jz+e7ttsYfaqNC1UgeuamhcjhpBR2whykDrj3wzIknRkk0MLhFpqnbVQQAe0Sa/zeruP+b6cxkf2ylHEEXiXnN5LdaRkopT2erkgvOGy3QEoIVz5bC4m1fMFwfwzJPTbl9kPUKPLkJzmPmweeFOH4nqGwOWasMYMlcthEYvahy8MwszfXYV/ugniX6gFEgjr2VRNztmdqDXWcqM3T7EF6DF7ASCyZ9H/42j0lWl77a95Ai/UJBcOPEHIAtuhCnHzQbzsqzUr5WZDFU1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLrKtFSUF1hi1Oba5C8ae3HZj9IXOshDWFurApbB94M=;
 b=jJY3PrjpuJOn66G9zmMEWtXtkUQ5O+5XjddI0JNewM26GZdU5S08dJphUQkgtG1vtzIXru9sOKzQrtXQhkOUeP3v8vob0OF9Kh9ID0D81y3LzAtaMALaf0KObl+iSpr/DSziyH09n5JuYPl5CCPniAl/kxmwV5kILg0cLMsJmgw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:01:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:50 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 3/8] EDAC/mce_amd: Use struct cpuinfo_x86.node_id for NodeId
Date:   Thu,  3 Sep 2020 20:01:39 +0000
Message-Id: <20200903200144.310991-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 022f3f15-1d7e-4ec7-b8b3-08d85044326a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB31711F4FB871B2BABB6092D3F82C0@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7K61OJmOsvsJ/0NTyo/7u0eynsSr4IeU4DP4/iCKyxsaEoqsMHf0b7/HGdlFTm8m8Eh6VmnUektVTr8nyVm/+EO7ffQS7yVDZzBx9RQFnLsaiWGtFirH4FnPk9di4nce0kbP/gp9mOTLcAkcqIIGPMv0kLa0ByhULCfOOzvRK8kj+3J8QIniN5ruCkDHv598AhIZ7TQHHbBX3CQ5J5rH7erXbXmUhMTSzH92CqxMWLqXlO2CLlHy+GMvXodJw+v6+nYGNjR23b70l6nQlo+bqUM7gtPA3aDBELezVpRdvCl4fn9QgkzLQMhHzmZ544PpbXGAcna82OLQtuoEvbw9w2Z92BVYP3QIxwO/sxr6QFrMGtlJmv48PsNq5Wsh5HFHa44OYfbHi2faKXFStMIogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(8936002)(36756003)(6666004)(478600001)(186003)(316002)(6486002)(966005)(26005)(8676002)(52116002)(16576012)(5660300002)(66476007)(86362001)(4326008)(6916009)(66556008)(2616005)(956004)(66946007)(2906002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4ByozMbEfD0VhSND5g0pauegjp679qHLp83toec2DVQfB/M8iPd9IJxPrQdsT4/LNIgf8XY8mvr3hWzojXAUpvoMSR2kv65rBQfGNlzyYoUovYhn6tYuCChPXOC0pdetjHlLvRSbRRhrf2HfDu8q0b4sND4J5P+/lv65xd8EENF+gxMnSmtZpdqISAWGvOcDj8a10q9dG2/45c8AEgx9tBFIlMwMmYGmi0Idj3RrVx9aLs86XyWopihjSha71biceRlV1VKh2FCUG2EKyifXhAqAHs0u1va3EDlkpIg3yNBHfhv16Oj1hP/2zhgVO/yvRktZxHvZu+YnMWjCKoeuqNF6xZcY2S3EzeEe704ftgB5cFPBPBv4oFL4+gh1FKy4KI4qOvQvGRGEESvbfZ8QDo9rJKp+tkYe4iBDEcOH6Eke0P7j6LDIE8eKVUHyw8R8JbP97KrpnsWzLOS1n2zZqjAUVJX3rklH9lCdGiWCfoWZI96rnTwCSZobx+iXA8ZrJycRMMlQRtOZqbjqMmDYr9iC7dcxpBD9DeA6C3wS93QcrzBinkEz+CwMCII0hGAFujQCT2hhNuvpP19VdcqUdMXwarQ510BklaRZl3Cg5YzGSS+o4+Hl/VFD6JO1mLi8oSVaBtBIIp/EuCJRxbwOgQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022f3f15-1d7e-4ec7-b8b3-08d85044326a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:50.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiyNinjIOKE5FUJlMPuzwVeSfHuYSqyjuU7WvlehSReiVnn5oUk+qhpSYW0QwGXULYyPKEHjColBWRKZgSDV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
later systems. This function is used in amd64_edac_mod to do
system-specific decoding for DRAM ECC errors. The function takes a
"NodeId" as a parameter.

In AMD documentation, NodeId is used to identify a physical die in a
system. This can be used to identify a node in the AMD_NB code and also
it is used with umc_normaddr_to_sysaddr().

However, the input used for decode_dram_ecc() is currently the NUMA node
of a logical CPU. In the default configuration, the NUMA node and
physical die will be equivalent, so this doesn't have an impact. But the
NUMA node configuration can be adjusted with optional memory
interleaving modes. This will cause the NUMA node enumeration to not
match the physical die enumeration. The mismatch will cause the address
translation function to fail or report incorrect results.

Use struct cpuinfo_x86.node_id for the node_id parameter to ensure the
physical ID is used.

Fixes: fbe63acf62f5 ("EDAC, mce_amd: Use cpu_to_node() to find the node ID")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-2-Yazen.Ghannam@amd.com

v1 -> v2:
* Redo based on change in Patch 1.

 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index ac9bd74c92cd..91b5e3e0744e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1003,7 +1003,7 @@ static void decode_smca_error(struct mce *m)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(cpu_to_node(m->extcpu), m);
+		decode_dram_ecc(cpu_data(m->extcpu).node_id, m);
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.25.1

