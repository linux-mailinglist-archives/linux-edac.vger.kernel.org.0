Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0857244EB6
	for <lists+linux-edac@lfdr.de>; Fri, 14 Aug 2020 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHNTPI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Aug 2020 15:15:08 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:57313
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbgHNTPH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Aug 2020 15:15:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq4HD0dM7t51dfoJQMHn6eJu5TY9VkRCwd86OGW8fE35wkbw1MSldggPd6nbmaXxNTtY+fyO4zKur5nwF3Bpgev/Dkrsetqzqjz8z5kldUJvQEw3uqJQfC/BFTcwvCN7D3rVqO/IJQzxqM5hBNAQPNW+0pH9Y2Aksh8cilmN1dteHPGouqkn/xTi5ecVRVXeKb2yyOb2p9FWxmA/yaeTm1K/YzB/AnzrVBa1P/Mr+f4gvJPRSszxoMX1nC1h0pemMPaD0ypllCc6EOBDcyAvDkVVtBwwslaCISDpUKNeNps4l9Qgh2w2x0UdvWUMPAB7d4UC13rbRs/IgQYmKRGtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYhxE3dBuJbYbr8dmqCho8mZBcEyAEc1v/Wci4pStes=;
 b=NsepjdCYowo4O7QEBl/UXS81LlrbVoWGCAiBHva9cZdt2woATTDZGxO/1m2JKxBCiinsdOsTl4HqZ37O+zMG5mzPqU598DCEwZVhokQYOfmn47Q8r998JheKxSnkLxKe9xa5olDoMQ51ra4FsoxDEUgcihbKP9OL8dBDoy/H4UkeObmOzNlQEckLyuAJto/Rp8YGzD4vLaCb4R9fgtv713kj81HRorV+8zuJpcEoa31x7o1eca3TyWaG7623uUAHAPaGfF+1/BO9dqr0MOGNdoI+W3c0i00eurfZ8rgaP1ABpfZJRimHaKaUYlpVkWHf7c9qVhxNoqJf0KY37+d4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYhxE3dBuJbYbr8dmqCho8mZBcEyAEc1v/Wci4pStes=;
 b=pJP2TVZOgYHv63Grzh/lEFOg13B+rHV9oSh0QTBXdvHXQeiRMBWsrRI1V/Dvd/fkcEpthjaPpNharJ68gK1dyIykrexT5NqdTNdlo9h58F7Ut+xz0we1sa88lwBzMqZCjj7f1VmWZX5QVnffXs6FcQX/rx0RuV4Fg310vladzjM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1700.namprd12.prod.outlook.com (2603:10b6:404:108::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 19:14:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 19:14:59 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 0/2] AMD MCA Address Translation Updates
Date:   Fri, 14 Aug 2020 19:14:47 +0000
Message-Id: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by SN1PR12CA0087.namprd12.prod.outlook.com (2603:10b6:802:21::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 19:14:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c41600c6-1609-4135-1d01-08d84086563e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1700574C849ED038172A653AF8400@BN6PR12MB1700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSrSIfA7qSWx+we1Oq9/i7qOixHwzXRSYRPKKTi81ZJKJkxaHdSukTaC7BozqpcTOwJSx3FWCxOoQN6bAM519MlXp6n8OoRv90uV1G6RoR41b3htJv4ylEHQMh9UDh9a2oGrCWhPaARg1k39zJ4JNfKd98CM/gVj6lK/lrlQq4BE6UchtCwotdpBj3e3fZEBgzwdeRUrsFnRnPfmEEvwWcHZBM/Fcm2PsARSINAKL6oWd2oFjlzKWn2immM88Klg3i+vEdrpf0ZE6lCRDuR6XNxAcRJCQUobdmd0YdcqORoiVi0B1LYInElDPWs0NFjFBw3K0ArXJVJt4P8iYmpDjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(66556008)(36756003)(5660300002)(83380400001)(66476007)(66946007)(1076003)(2906002)(316002)(478600001)(16526019)(26005)(186003)(956004)(4326008)(6486002)(15650500001)(8676002)(52116002)(7696005)(8936002)(2616005)(6666004)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qEsvHlY/y9Kf6DZqxQxEsSSEseTXakJ/aGL713JbwuKdd7NNxmrf+VitbzaNtw4vWPQvIVhNFxeKrU8s8PWAP/YwGC7GoCF+YMkzJgG/HlGt48sxYZ9eJ+QUWXT5V189E5sqL+Yu8PJX+7/2cFM2uf8Do+jOwuIeZJbazgAq7JR1X8zEN+SmUfx0NBefhW5Y5seq41s2iRouhorvJDuqR1n/F02bCF8Ui0hv41kymmET2L/JI3wqveo6v9KmqNko/VeaRw+2TNXQLU0JV4lx7MaQ9uH1CvydkSwZib8+WWMGdJjcY8w/4i2DsgemvsX3zMohIA/JcjUAtaRUhy9Lct4BTTAfRMhdW3NWbi4cS1vDW9o2Hb4//C5GqNx09LkYHMV8D01hH4Dze+btWym5/z4a70FLHd0M8B5TYC/9JSEmZvl5r5R7Rl+f4Zidr/ZS4WjpUsndytEDVRe96R3hpS/p9diYRSz6vq7scDV5EgF1kEKGlmGux4NSgdcMl+5bAstUHdzm7C54wvL1A83bqMRWjZUwRoArXaCFjP91KG1xIDozq72uUycM01LCgsyzDqOWwltaRWEfX1z97J/3Z88/qLuDH6JqTizmoYLWavwQQw+XwL3U9ENPRet2rjdlEl1IaVBjNEFgPAynWWLyew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41600c6-1609-4135-1d01-08d84086563e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 19:14:59.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoS1eupGFaJnrZfYHOWlU2xZ/nXe23RM/qGIOMc5Y9y9HnLKas/b8v/StdrHLxpZfwq5wrZF5qObZFWKn8fcYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1700
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This patchset includes updates for the MCA Address Translation process
on recent AMD systems.

Patch 1:
Fixes an input to the address translation function. The translation
requires a physical Die ID (NodeId in AMD documentation) rather than a
logicial NUMA node ID. This is because the physical and logical nodes
may not always match.

Patch 2:
Add translation support for new memory interleaving options available in
Rome systems. The patch is based on the latest AMD reference code for
the address translation.

Both patches have fixes tags, since they do fix some issues. However,
stable is not copied. Patch 1 needs some fixups to apply. Patch 2 is
large and doesn't seem to meet the requirements for stable though
comments are welcome on if it should be applied.

Thanks,
Yazen

Muralidhara M K (1):
  x86/MCE/AMD Support new memory interleaving schemes during address
    translation

Yazen Ghannam (1):
  x86/MCE/AMD, EDAC/mce_amd: Use AMD NodeId for Family17h+ DRAM Decode

 arch/x86/include/asm/mce.h    |   2 +
 arch/x86/kernel/cpu/mce/amd.c | 248 +++++++++++++++++++++++++++-------
 drivers/edac/mce_amd.c        |   2 +-
 3 files changed, 202 insertions(+), 50 deletions(-)

-- 
2.25.1

