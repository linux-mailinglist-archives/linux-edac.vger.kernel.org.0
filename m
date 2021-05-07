Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB5376A4E
	for <lists+linux-edac@lfdr.de>; Fri,  7 May 2021 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhEGTDJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 May 2021 15:03:09 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:18843
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229775AbhEGTDF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 May 2021 15:03:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc3ymPczDQ0B2I++hUm85ER4sj1bZLgSiH/MCV0+gSwpTHEIul1CmXwzQuWboukQhstrvaq+z/i1IuJfyQWsx81GFa0EBfoMWRVYNpr6nZE3pA8aok3oIjcZzmmhTklmgk3LtbPcstMA5NJzpb+ixdEupHJjzDeMSrIUN1GA2tWhWYr57Hub2niW4LRgV6GOYTOc/WUcd1F8XJJ/gTSMwBfrQ2ZT8gJhHZfSF7SbXco0LqY95Lueu2J3fNCAaPF2vVAhMtesCzbvFDinMPVkry+vwNEwnUvn99+Bcs2HiNVCbPKPlBb4IE70nzLjcoRBZZAbeMK/iUkKxNn0cR9PPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjwIbB8SP02VFUo6iTLBOw5zmh+x11IV1ifhJVwns5c=;
 b=OAGC+5f5WYL0/e7Q5IkyqbQ4Eqwvurw1w7pyhzVPFNLZkproQnHOXO6MsxFyPLpGp3fOlgwXdhjLQQSS5+uXQfHo1wvjTwF8xCBpDJ/DY1BSyR28jr5OiHtwTh2CV6TywqhDbU/1YFAgxpB5Wreth/bJMccY1wR9MZ/zetfDsaFL6yo8i7HPIs6yTLIdHjD1TM6KP3SoKVY5NMxnBGxez/okBPu0q5dnlq+m6L+sNaTv5h8ubPXA3Xl8RzxqSqLf+8cBZ6mo8Kc3GlRDl7MrVEcOvCOFQXqfdS+y25EysUzoRsKYjeGepWQce+FBoWMY3o3YDLzp9gu5JmsojyXK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjwIbB8SP02VFUo6iTLBOw5zmh+x11IV1ifhJVwns5c=;
 b=hy/vuMT6ocYREP/5l+ije9GT+ORjPlMFIZZFtl5D76I1P3s7t4oCHvthXTtuJqJAnOIaGA17kDLq/dBHDlqIMqVUnxZ+CT3oYIcTidLfKIpudOhZDY2MVrAbZTnPPhvd/zn3xEagQHC+uRXJ3zxNdQx2zk8N28X4EsWCKRceq8A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1748.namprd12.prod.outlook.com (2603:10b6:404:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 19:02:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:02:03 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 10/25] x86/MCE/AMD: Remove goto statements
Date:   Fri,  7 May 2021 15:01:25 -0400
Message-Id: <20210507190140.18854-11-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:404:8e::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.3 via Frontend Transport; Fri, 7 May 2021 19:02:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 178802c0-7c8b-448b-2466-08d9118a998a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB17488519A454B7700FDACD8AF8579@BN6PR12MB1748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PG9kgxW9PhHcHORq7QgvgpqMGkbr0lDYqoX5zZIfym4k/Wxp119099BPO5/udO7RSxBSS+LlFo+2NKm+hpidQaQUStGfFHSXYO61w1pJpnK5Z4BsWSdogg3+V8KNYsS34NGBUmK2AVQWJERpN4CDAWw6yb/SjuLgdgBebDD5YfpwAKnePOE7AuGq+agHURxDz5o1eSaDis4gW/hD+UuAjNwjA3nx8KmtRIr2TH3IqDSZpSHZgSya/0pcugZazElG30ggSNMjzqwguceroBgAgczbgvok0MXppxu6uzGzQEMKMKBhBGjgZ1VLnTMYFuALTFFku+NmJn+dkoG6Kzt030oOs9l/Mw6KG+4sMVtQ/zP3s2wrTm7CQoICYSsa7HCCU4Wkcky6DCB0bNDDVmD+CVeG6iUwu7mwQKy29wRsktqBxO8V6sU4q2/LmvnnnjQKcFtAthAV/GSGT+HskaXljvFHjp0BwmIlMimLZkcFeRt7mKCEyiUtuXbKh/WSJRR8nfISwqQzYWyoJn4nPu94UDmVpaEcRUaHZGCJNTaNAhEUA56l26+6QJlJH3wSVaYSunckAASlE2ay0liP6Njk4ON1y13kNkrFAcYRBzLqF20U7+S3nMgAbitpwraKQLyNXOM7wzDG67V5dqs5sW6qZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(1076003)(6486002)(186003)(38350700002)(38100700002)(2616005)(86362001)(36756003)(956004)(66476007)(66946007)(66556008)(8676002)(16526019)(8936002)(6916009)(83380400001)(26005)(4326008)(5660300002)(7696005)(6666004)(52116002)(478600001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hopvjDdqmmgT2m4Azmftx9y09SrM4m8++4q3YmC7ZWQlFWn+r584qoz4+aAK?=
 =?us-ascii?Q?Ri/ZX2OTyez1mV8WkkaeOQQGvx7DV5HGcZKCn378wpvSXVdKtlOrPWwXLa/K?=
 =?us-ascii?Q?39wADsOpv0sJkCbE5V6cGzU/FYOudCWtJrtWLGs4nIvUgJ07+g8LjsbSSH8p?=
 =?us-ascii?Q?6L6w4jgyKCpCy31zQPxl/w/iUD7XLaYNyECxnPTeCBuAAvu1GkU6dt8wW+ol?=
 =?us-ascii?Q?Y0YjJal/jr8FTDErOfNfD8bU4Nq8k4Hvzp+N1oLKnj6nkVbma5/Dlp48ERQ0?=
 =?us-ascii?Q?87AcfRVG8imFc+aH2kPIb04AGuC0Y87aMMQnwJkCabPsclHlAtNnaPLiIIK/?=
 =?us-ascii?Q?o8AbVfGFNhPVh9oZevDhLg6HL+K/NuvFG/Wku5nDJmuzcAcEZ4WVZDgFJjnj?=
 =?us-ascii?Q?IHad3zHaImlkLD9vQ8QAsA3wLw5JbLQe46gIj8jLsa3kLwZe+eK4lo6cJsH0?=
 =?us-ascii?Q?laIf7MCtTk6J1LBrpW4IUnZbTbVH5JInQVQlN4NtXdProU3mIoavL5FEPcpB?=
 =?us-ascii?Q?fo9Z6wXIbG6rnG67QbxO3zGzPbjsB7DtV3AS6SsCjavgSqntUQ9pc7g7lonf?=
 =?us-ascii?Q?8GW+7KPDuk2iNp8H8y4Mm7xEpDnNHU0ZaNZSVMsGNaxHpqX5SpcfIIChu8uD?=
 =?us-ascii?Q?U2TIVhR0gSvgYlmny1OuKH1XDxSn/Pt5YOFyjjLICaP5x8DFnQJh/3UHkwCK?=
 =?us-ascii?Q?eWg5YxEjLUchyFUakW+Kndg4GISmfl/2BPXUeml9HO6mvtB9m6aTFy5IRTTh?=
 =?us-ascii?Q?SG50OVPy7PJEnkEtcl2plvWogpk6P6oHPl3DF+9YGikK+v0359gwoM8oL6Pz?=
 =?us-ascii?Q?ckSJF3LpNIq1IY0In/DnqNP1bAzM1/JTyQjdO/Nie49YTJb3imRsxdAPGe4A?=
 =?us-ascii?Q?blDnPLEp5gTmKga2es2IUrLC6qHl84Z0qMdtvt7uy2gtq22g35JnQN573qst?=
 =?us-ascii?Q?xxgbf3H6OInre9cF7UaC/ASlyXFfUk5Lr3VgwdvmyZ6HnA0BeZbtAJxqHg+i?=
 =?us-ascii?Q?GsfBDXGFiMrNvmOoxteoWY/rX33rPQHKOoklz/1PrmYkMF/t3chfPrZhHvxx?=
 =?us-ascii?Q?gmzYE2fHX7//xY3LP/Kmc+t+NTJlAPUgrQkOD6vBp61/HubGJpB7Bkq1vkeQ?=
 =?us-ascii?Q?rt1di5ZINsMmsIL5xuzROcpXdFDSMfakCwYpkUdADLdMMA/4M1p4eem0MMi+?=
 =?us-ascii?Q?nVoOJnt2c4X6DXit4JSnFSpgWCJscHEaRsrLDuzWxk7Q1S7FjmjAbmUNjxm+?=
 =?us-ascii?Q?oaJ0xaGJ0DIqOtSkJHIwwXlayuIX1/E1pU6LbF+pL+Zno78rQoahxhiL6KVr?=
 =?us-ascii?Q?5x552gUmmXFWLwfMcCS0SOfh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178802c0-7c8b-448b-2466-08d9118a998a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:02:03.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC1W36k3EG/W8AZUcbwg6zUbNI+3/rGlVKFtOD3QknD27764hxMs/dwjgBXhW6j1PNP9CSZLwOnt/zJamUf8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1748
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

...and just return error codes directly.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 7aaf8a1dce2b..d51ec5c2f319 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1015,28 +1015,25 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		return -EINVAL;
 
 	if (get_dram_addr_map(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (get_intlv_mode(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (denormalize_addr(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (add_base_and_hole(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (dehash_addr(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	if (addr_over_limit(&ctx))
-		goto out_err;
+		return -EINVAL;
 
 	*sys_addr = ctx.ret_addr;
 	return 0;
-
-out_err:
-	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(umc_normaddr_to_sysaddr);
 
-- 
2.25.1

