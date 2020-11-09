Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F02AC69E
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 22:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgKIVGr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 16:06:47 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:60513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729831AbgKIVGn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Nov 2020 16:06:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw1+XmopKxJTQvGwnPtU5JJSDdShq2jNPBWQpCg9TeUQZFRzU9gfDrM9PS46gQuA393afkbMUtWgJ4xS0ikOCRPNfsmP4enU2eoSDai293SPI5MXBLThpcGO3uH/vXszygPy0fKmXM9djypj/j075idZz9lKhHTNQeyfKz6VWFFkxSdesBB9+u+OXIZcNRuJuCQTtVxyUYLorEHPGYR4G7Y/q5kBy/b3qFODIuDI5/j5Q/+XiC1DN25U2pgB3idVhWLpge5xbrQ2dRXmrKO0hodnaGKH2CS/nnqb7vFzhXR3yz0MGG0U6hs/L2p0cbJpDhtaIxUTtTvo9EYmSoBHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12jbveMYwQasqwnYjv/UMgvCndVZXrnvxd2vVWCcOSM=;
 b=Lz9atFuTbR+YaPA8MZ0PAPL8tU4KEPXA81b0+88kxeYQMHQHOD4iWPSg1FIFyhmdOjfqZenTSIYEMnyWGVIczKMakcaMJem7a+qMldWuP3SNFirr3KjJVFCuD+OBrCj3YZKIpHWfYSVlYvsFdLtOjwIASbdAJTysyvjRPhdiULHMj05hsVb5ywYrktKeDwhcgJXU1ekySZNgS6FV4ikWLzF/sCi8SoxPLFNR41OmBXmny9WW2Lb2aodreC3tlB6PjeVtq+hBzKR+6RFzQHUrWo/9CyIyvcpG0gewhEJHg5fiBcgaRmU1Wt4biNjpjmWpfZDz7mDQY/P0EiUqxrO/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12jbveMYwQasqwnYjv/UMgvCndVZXrnvxd2vVWCcOSM=;
 b=afpeOSLK38tgcCw/iNUc52ND0nsnownQ5EFmVFt7JmWCdzeVT9bZaP61kSjqRGu1mUmvU05gmX3QXpGPhKwXmQ2/cTauPpEkhmeJi+lqNao2aoWxV4ej605fnScC5rQBLKI6TOny1SuJD2xpg1j8SI9Lw1ax6BgzPTSxSali3kM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 21:06:35 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 21:06:35 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     x86@kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, linux-edac@vger.kernel.org,
        puwen@hygon.cn, kim.phillips@amd.com, thomas.lendacky@amd.com,
        wei.huang2@amd.com
Subject: [PATCH 3/4] EDAC/mce_amd: Use struct cpuinfo_x86.cpu_die_id for AMD NodeId
Date:   Mon,  9 Nov 2020 21:06:58 +0000
Message-Id: <20201109210659.754018-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109210659.754018-1-Yazen.Ghannam@amd.com>
References: <20201109210659.754018-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:3:103::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by DM5PR12CA0064.namprd12.prod.outlook.com (2603:10b6:3:103::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 21:06:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a937df0b-6b50-4485-4993-08d884f35787
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2979C74B49458344693216A1F8EA0@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0W6752vLBV+lmGzMm8adHJptb1FMLeR5oYBfoKBwgYNbDQ4yT08ImLHHU1JScCQjkwLxG2lBHr8rVcxXRDXEgTUgigHj9XrC5zsNaLC0OAsN2XcJ4q/TXDnUa2zcuUBZqAI+NKWFs7ltKTs6oLjHcRMI1jucsJgDHTTWC8syBkOQ/IrsuHQ8bBuE5d8hk6ZbAbpuZBzPD/NorEp1RnYLwPYuuwcHH4tzmxB2Wq/ETEJGXwZUNNAhPbflQkQcND/b26mcQsW+z5m6oMeda6KPK9RG3zwKgh6ifSXz48FssWbMp62RGCZgzUgqYeBUhtsCbageNbYH6DKkpJaZIc+Zog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(6486002)(26005)(66946007)(5660300002)(186003)(16526019)(4326008)(1076003)(8936002)(2906002)(83380400001)(66556008)(66476007)(6666004)(36756003)(478600001)(86362001)(316002)(6916009)(2616005)(8676002)(956004)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R7Kya3WLgkrZh7TK+Pi27Vmy0ZQEpcVmJdj2NnQtYCofa1gwRiIU5HBfSg2d1m6P8vjoVgx0yAGbTViH9iaqusxFspfkOn59+0rWOmN78Be22V83iyH4ngMMg8E5Of+H3CjPCC/movHJTymNaKy5BN/eKULWZLod+fWAx2dd3zZjb72xa0xrfSelwYTtZz2MTjJdUieqM/fIuv4rbGwMQjIi+j91Bng5TQOx/gl2aOYW5cpZmyCSKVHjCluokc1iAir1dMvKxR79P5RO9cLr1wPd+Dq0s/l2eNZ2ro4tv282GDp3cSZNU3LeoV3UAEjmizFH9b6FFrhzJzp5W1CcBRW/j4t6HnbDwUFwj3cuSxfSokGvZUn358NAFprW46ZBX2PgdoCYmtuMch/CBIfYrP5HYoPE7HrMcg4GXTh5F/19rwH899xYymXsWrVIGFTtxcOM2KSQVXHHfUFrFjiz5Mx03LB+GlVYK/Y6hZxOKt8+jvkE3wAS0Gt9mbH8S8YDnht8GExFaSBO/3zNszscHnP5Hm3tt55dBRgypz3U3LoTSaSbUFf/mwTcozdcqw7PoKuyAIzzYrqvgKSc0p++uD2OK2vd1q9FM7DnBbf4/RZ+t2JE6BzfssOKLiO9h2At4ByHd/2Ldg+0RrDGN/yjoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a937df0b-6b50-4485-4993-08d884f35787
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 21:06:35.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIC8H4vXFGlxq3v3stK3M5McGGKhqIgFCLoK16Y/bb8tKJeOGEkrdCITdINF3tNVX2KfTDHFVvVc5amVnHXCyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
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

Use struct cpuinfo_x86.cpu_die_id for the node_id parameter to ensure the
physical ID is used.

Fixes: fbe63acf62f5 ("EDAC, mce_amd: Use cpu_to_node() to find the node ID")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 85095e3902ec..5dd905a3f30c 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1003,7 +1003,7 @@ static void decode_smca_error(struct mce *m)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(cpu_to_node(m->extcpu), m);
+		decode_dram_ecc(topology_die_id(m->extcpu), m);
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.25.1

