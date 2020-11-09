Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1512AC69F
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 22:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgKIVGt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 16:06:49 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:60513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729454AbgKIVGs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Nov 2020 16:06:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6AOGW+UlE59hRQmTO3Acgt7CN4W1o6tet1ZyOYuhxP2kaanbuA1w19CdYekfq27j7BCLP3pkzR79wlM4n+7ngomGpA+A8yhCulM8YUPsYR3mnsof8SwQitHqHha6zgsv3grIH1/lUMwybYpDYHj7lwmJgwLZwnSJbiaE/HYqRJBLCiQu1coumccrGPqE12B+HEK+aG/M/m16WFYNJ1pB4rCF8vekXKxwET1ZZCAgrGvu/SKH3hhIh2RIOHVeZYKRmzazqE/XruquKn5yuAEDraHLnuLly9qs+G2N28OyAhnXbWAA1S9X1ZC2OypNY4kn2aH4F+w4hjOU1dk1QvxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaniMYfCCkKQiBf8i3oiSqYwFGGYsIcgi872NusruWg=;
 b=UlSubLuTHf5x3J0smRYL8BVbgBc2UZX8grq8ZVMbeSrKT2ux/qrpQim+RRiDBpvg6uNVJMXqvgjx1PSXGCsVeu7XWeqJZhIga7wlVTakmaelgi1tHm9UmLL2gFrZt0WrpKLWDDXuOq4PsACidVoYOhvFDaM1CVw/Ya3DwefVlcMjEcRhyzDL0P4NL7VBel8sOALHlrW+V58GkJits2dsJESzpfgdbN8yMJrjDW1znxCXVgzxEVz4CZsyBHRRLQCBIOYprbfTdma0YMF6cjEaD8v6IgArSNEbay8UBIgQk6gsLR6QREKEK7T+qvg7p+peAsaeFXeunOoZPHRod+s1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaniMYfCCkKQiBf8i3oiSqYwFGGYsIcgi872NusruWg=;
 b=YuOAax9CXbk4UjvXerv1AlzA7D8ZX1pMIuMia1ck2rrZ2VHaLUbqsPTwyhpHzYMfu2Lq3ScayUSE7hkb3suX84gItEjxpHlDTBhFaGWJPx243mPSY1MZ1D8iRXaAh6vDx/iDPH3+fP26qmKamQvFwInqt6YDD1VYxTBBzQ9ljtc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 21:06:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 21:06:38 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     x86@kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, linux-edac@vger.kernel.org,
        puwen@hygon.cn, kim.phillips@amd.com, thomas.lendacky@amd.com,
        wei.huang2@amd.com
Subject: [PATCH 4/4] x86/topology: Set cpu_die_id only if DIE_TYPE found
Date:   Mon,  9 Nov 2020 21:06:59 +0000
Message-Id: <20201109210659.754018-5-Yazen.Ghannam@amd.com>
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
Received: from yaz-ethanolx.amd.com (165.204.78.2) by DM5PR12CA0064.namprd12.prod.outlook.com (2603:10b6:3:103::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 21:06:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7dccf44-a248-46f3-de8e-08d884f3591b
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29795E8EB24560BB8A5F86D3F8EA0@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdQ8ZTCqZS8NryJNyXovVXYHSY5OEEJ+zjlojFvbIYOsyZB2vUKLYOVzrrwX5FwboszRoSSKCdB8HOca/WgC/SyQCBg5tYVuUXRhNWATByM9gtEY3scuEdwA0dC7d7xUGD75a7iPwmzKHIyf6Xua59KXgW8hS+tPzsBr5/bEMlnxOjzsNCWQlLLslWNddMngXrMMaLIypqb88QLpuXO8ORrVJhYdOe/MQ0ze1Etc54/HyV3fc29ju1HLXItSkJKnTMWokHWuSKMp466uCVuCqMO8sWJHEOvALgc2fONQGxxMuJBdti4iKYp+myQt6/Sx1FSkesOgtT1uwRF7ZDniEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(6486002)(26005)(66946007)(5660300002)(186003)(16526019)(4326008)(1076003)(8936002)(2906002)(83380400001)(66556008)(66476007)(6666004)(36756003)(478600001)(86362001)(316002)(6916009)(2616005)(8676002)(956004)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iEGjPI5n9qLifmXI/cmZs2U+Qjvt/mJQ+f7cgR/OfFcZOoMDAD2+gnFhjvamVgieY4cxHwZviGv5OdSduLHrj7ixG2pym8Rr9pppTbI1uKnbutS/5epUyh5wxVWg3DcEif2k7laryXzUaMeQfEODE4s3x0j4MrzMY06Ibavl0UMtmmwSppjhAFyFlUKk1H0lr2vDQ5lLYPlPk5ko6a5QXdPIN0LBC5nOY8iYXlOioXT1/6DVuxAwXaCXiEF14zXPSI8R9F99ARj6YVtKM/OTTPbTAcdVwG4A4bbAq3qGozA8Km0gCpL5vJEqf9UMDJKvva+xfB7lFAQstblCgeJlQLeI3R3fVNYD/i7pzmOXYJwJbTkk7vrR16kxVUcw2pmW4/nV7MtMOvpPmlpwxkMWEf7Il3vg6gmeSC2OHtc3WaEN5Wbc8iBRzddxbI5hjIjYbg7jUxJk4NZNPI4IHCh8lU1CLbJYHHWJEv+jtIj3ChymEHm7EfA58kmGhomFGTiRe6AqOjSB0E2t53yzu0inwLna7Qxt6FxF34zL0uExEaGS9g3sZ2bzrB/lXFJc+nvMmAkZfNBME7I8/6CEhfQfku7hiv6dz1EfNbXebxPaprQW/tPoWx5m73sr7thfWX40CUUgqtkqJu53rXsCUZZXZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dccf44-a248-46f3-de8e-08d884f3591b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 21:06:38.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbNmlnxK6rz2dI83qaPsAUUjOTpl6cEnGXHG/+RWkqLrTYSHLbM7fVI0yZ1qqUcCHVhMI3xRnbHiFUEIMJjz6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

CPUID Leaf 0x1F defines a DIE_TYPE level, but CPUID Leaf 0xB does not.
However, detect_extended_topology() will set struct
cpuinfo_x86.cpu_die_id regardless of whether a valid Die ID was found.

Only set cpu_die_id if a DIE_TYPE level is found. CPU topology code may
use another value for cpu_die_id, e.g. the AMD NodeId on AMD-based
systems. Code ordering should be maintained so that the CPUID Leaf 0x1F
Die ID value will take precedence on systems that may use another value.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/topology.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index d3a0791bc052..1068002c8532 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -96,6 +96,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
 	unsigned int core_select_mask, core_level_siblings;
 	unsigned int die_select_mask, die_level_siblings;
+	bool die_level_present = false;
 	int leaf;
 
 	leaf = detect_extended_topology_leaf(c);
@@ -126,6 +127,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
 		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
+			die_level_present = true;
 			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
@@ -139,8 +141,12 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 
 	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
 				ht_mask_width) & core_select_mask;
-	c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
-				core_plus_mask_width) & die_select_mask;
+
+	if (die_level_present) {
+		c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
+					core_plus_mask_width) & die_select_mask;
+	}
+
 	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
 				die_plus_mask_width);
 	/*
-- 
2.25.1

