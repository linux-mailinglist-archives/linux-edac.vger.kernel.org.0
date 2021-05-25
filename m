Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445023909E4
	for <lists+linux-edac@lfdr.de>; Tue, 25 May 2021 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhEYTu0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 May 2021 15:50:26 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:20219
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232376AbhEYTu0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 May 2021 15:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQMsR5mOCVskoNxIrKZ5Bl6EGiZdYzCX97fWa4RiO6Z2RLoKf+FTsHcOlxXhm8P+9Dt44FWEFeEvDsgoOy8wiiY6N7BCpc/csdmZBkIEv+YbkqClm0lwiJSg98XWwVHQfpN2Eqbcc9M+Ja7WzQU2LA1dYflMXSlJjW9n4Z9Bx16UdeeuG0RqSlVoGDBYwQ/q3n9wHxvl0WFPEW/q3AenzuKuvPgToJP6qogKm6y/aZDBvTBwB2sPpvp0ZrYhtaTxDqVt3l6usRgD0aaBRmxpxNBkfkZzt4OpSZYcubujGbsarxxtJmmtWKk3nB4oq/juHB3dN+RMNBCcXO7BzdWVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMfkaedndnyZsvh6xmMkRjEECt6tPDNVi8gXfYjTyAA=;
 b=UooTFtiRXsqPF6jjts/mAlo7YWK7IBgfaFsE3djZnmeFuzTruQ6mwzHVNKgoMyjZtsQ2eZSO72j/CbjsWueb/JTpiRyiphJaoowV2NZCbByeVbf8WgACMMQwlY+bcerGv9hRfOnGLAN5NFrLpyES8Hds+daIE9SC+jbkB25uUwWCP9k5LHy499p7kVPv6tuNfEG6VXy1k7qn7PwHDzCQ6IExZEUynB1jVnDso1iEfssZcpPqtsAGy7gfFIZllFwnlQieRGCHIBZaL574nS+KbaAoe1Kaxq5kjZpuZQf/w8KQTO/SRkR05zEmbpRSOKn7VJkOnLZomLq7vgCzOiSRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMfkaedndnyZsvh6xmMkRjEECt6tPDNVi8gXfYjTyAA=;
 b=13MjShLPENJNJEz8JH1lBH0eqka2ClYaQiUKUnrtEQhggfB74rUfVKL6O1zo4N31kBYBjS5bUnSp1NQ0u4Hl93i+Xth+KidAJkd9ny3xNnatIJsrrLlohMMqr4xxliyAs2e0/i5AtvEY2XfebqFEVL1UeIsY8qbBdHSCCDCMCBQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2884.namprd12.prod.outlook.com (2603:10b6:408:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 19:48:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:48:53 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] MAINTAINERS: Add Yazen Ghannam as maintainer for EDAC-AMD64
Date:   Tue, 25 May 2021 19:48:34 +0000
Message-Id: <20210525194834.2710362-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BN9PR03CA0790.namprd03.prod.outlook.com
 (2603:10b6:408:13f::15) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx80b6host.amd.com (165.204.184.1) by BN9PR03CA0790.namprd03.prod.outlook.com (2603:10b6:408:13f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 19:48:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f60f78e-a611-4a25-553e-08d91fb62056
X-MS-TrafficTypeDiagnostic: BN8PR12MB2884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2884CAD74044FBA635A89321F8259@BN8PR12MB2884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duAXOpT1FhB6ywOPkfLQvJbjxVG7zA5aU2ohkH10yZN5HIvo2OwcqmFxCYN9ujXqHEY7aSEGjoi3Y8SVhQEZaiSZ+04PoLZ6lHjIyjoctXAUqZGXGF7U3k37rvMuLyloWt2S1eur7Iz2iRPyzHnjCKBHmX9QlESK9DohtJCnBTAZt9ms1dmG6Adlbrrs0tFHRxedpNX4r0kfPpJ+1Ngb55QPOL2QLEiLpAQFd360lNUdRkAJzjH0s5MVBP3vcI/ou5FAlQoz8p6iGPdl7f+wRdXRpReKANof3BUGzjNn0qEvDbqBXDL8HWRh4OmtGGmhHdT3noFmW0mzYn2u+SMXS0XaEFhy2hcUrgLrXmLUEWi2jERNdzcdW4yn92ZqOmSfrv45WaNkENps/zZqqlfmLU0zYSv8PRlbW3rpjiFxJXki3iejzQNw6NAPEwelBY75Bpxrk6hppt2O6iZGf5eXMAuTpomgS6QhdxUCWUIJJ89z18zXvRIR6gwvPnHhkvi45JlM75GiujUF9frbU30javpDvKMSa9vdf6SsuZSDfLDQ4af3viiDGVuNVoV4JNvrvd5KGGkIWfxPWAN/QdOn8mz1kKIuBNfGun1WdeZ9r6b2jI5lJesiIWQYFy20ripqgsCiIunh85cZ85tgcmyqQBqZqHRXABYyDEUCOItw8aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(136003)(396003)(376002)(83380400001)(6916009)(38100700002)(186003)(16526019)(86362001)(6486002)(36756003)(4744005)(1076003)(7696005)(52116002)(5660300002)(2906002)(8936002)(6666004)(66556008)(66476007)(8676002)(316002)(956004)(4326008)(26005)(478600001)(2616005)(38350700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R9vW8qVru5qX0ELVn8aZakl2lyqaQKNbmIGlZRXUtW+j51O0mMErVh+aiUW0?=
 =?us-ascii?Q?+iXVmAwTulLLk9U9RbeE0jEU+jQ4unqQ2ktJI+7GpwXKL/lebVepnn5MRKB3?=
 =?us-ascii?Q?5kx2vKFhNDlkM6Jl3/hs0yu190W8OQnXhafyuoZnn77znr1PmmTVcSkrCQTg?=
 =?us-ascii?Q?WCTZ1nEolGTHPadOU82+LHROvyBafNz4VmOZvG0Mx48bU0M6iRE67svtQKk1?=
 =?us-ascii?Q?FCEBXAuT4kNWs6gt1sRG4AxF3czDclOj8FGP22VDcXADJgyvgyAK+/gRxtjr?=
 =?us-ascii?Q?QbPOiOR7O9x7OABRJfZjs6G0CPftxbTGGmIKT4RAmux+MIOr/cqMVEWWtnGk?=
 =?us-ascii?Q?QSMxNYzCxTuQpd+f7IqBTKHkRcHDCpuMUiVi3MDz/R8oBCFv0AQu0mMYsdKk?=
 =?us-ascii?Q?UawMK3QYo3HK2EjVhdupWRTklyQzEgKv3SyKJkX/1PcHEA/Ef/Dl+I6ac9lW?=
 =?us-ascii?Q?nQLB2+1t8fKywydEog5ngx+5yPRz91TXfG3C1irUMN63CXOmsoND0WKNndUt?=
 =?us-ascii?Q?Y6bI8CTapsJzhbZCGTMEj7dmlhgLbv6lbcwff0UOhiGx+ZfaWEr5rwR1wapK?=
 =?us-ascii?Q?AAHHpL+bgp7uO8an81bQvCumREL1f8qk17tWVG7JOs6ogW1VUkAY9gHRVS/H?=
 =?us-ascii?Q?yJaBp+zUVuAWqQqyV0HxxhOMDAPg2SyONGuEDXE3mfc90fjBpA/jkzn4yteD?=
 =?us-ascii?Q?oGQaWCxbUu30msKEgI3b6ygKr+W9gtgd0ypZxMP7pjlnWGfzNzq83YXfZRWU?=
 =?us-ascii?Q?ub2xGWtk/W6tTxMQbpMeRzQNJ1pLbi64/oPcXuv9KwXIkFJwiBrBtMEzT+C/?=
 =?us-ascii?Q?QYJu1mcNQsBcCwq1p3N1PisAJSfOIW5GWorDRdCqYSKp1NI1Zy2Eot9YEJ9k?=
 =?us-ascii?Q?fHSvVF2Vd0HI+d4oYOGye/NDaI69iOwbmsrLiAOPxO0VIFDac+SDmTxU1Aus?=
 =?us-ascii?Q?26Osrp9HfPqnBpUeB+Q7KADz/zn2vSvcSQGERWxfGqsDhrC3k/kBSaUmt0po?=
 =?us-ascii?Q?gnr8m9JGBXDRJGEMoN7oNReW7eKVs+tWcDQf1+ArLsFYpB+9w0alnEz60IYU?=
 =?us-ascii?Q?9JoeWaZeDb9y922s+3uKmhYW/iHOmU54hYxrI5F+pLTUIb/vGPVrOU9CGwWm?=
 =?us-ascii?Q?otFJqdXRJ1EhErwRoU6u96CR8W6Kv5cdhRGDYznT/YArMIThqwV5VvEbKG6s?=
 =?us-ascii?Q?oN8pKNeyVa3JQKutXeB63Hp7VGWwzW8XH47qkBRoNRYdsZf4x/eKB43SNU+G?=
 =?us-ascii?Q?G/McbuHKCd2vYlmghGQyASbMwJQu4Pmn+U3HmMXM+lRGBBxzyUrhB2B0jDo7?=
 =?us-ascii?Q?WH8VaDTRKiTPDOFpWGj6dLTz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f60f78e-a611-4a25-553e-08d91fb62056
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:48:53.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Woa6mmLXK1+t05FcB3f1uKUKBrNwiVT9YTtEwk/K0ZHF+yr1UM2dy9metHGiGXV3NvnmucOeoSz5JCHH+Q8d5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Also, include the mce_amd* files under this section.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60f4c3079b11..c5f7853ef2b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6443,10 +6443,11 @@ F:	Documentation/filesystems/ecryptfs.rst
 F:	fs/ecryptfs/
 
 EDAC-AMD64
-M:	Borislav Petkov <bp@alien8.de>
+M:	Yazen Ghannam <yazen.ghannam@amd.com>
 L:	linux-edac@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/edac/amd64_edac*
+F:	drivers/edac/mce_amd*
 
 EDAC-ARMADA
 M:	Jan Luebbe <jlu@pengutronix.de>
-- 
2.25.1

