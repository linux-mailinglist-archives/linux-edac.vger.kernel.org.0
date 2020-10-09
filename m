Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32D5288FE3
	for <lists+linux-edac@lfdr.de>; Fri,  9 Oct 2020 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgJIRSP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Oct 2020 13:18:15 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:64480
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729274AbgJIRRx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Oct 2020 13:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bItnSYuUlVIV1p9fn7MqU8p3bQfNIuLUCxJPTkopGuObYWOaIrixrdTyvBGmkJ0TOdRu6E+/zdXiaaLWh9mfVkqBqRR8H8A8hl44dcA+VVM2hyVYhDrTRUYRaV7wGfRUEQVfYKBXDhLftoRQtjFreuiuz+6div3q3+ZL3M6XyGY3OjW6yB784u2NtRPZegA5TCgUKh/IP6s/mVPb8c7V2sEQVyhRJ8eR223IlW4+z1LL9/zPHsdLlPd2IdvoR8o7QzV+1+SyBGcbVU/7nIKcXpocZ6AK/CaA6w+ZvNlAkUB5erlM71UcubHP/j6JEIFc1+7I+JIDL7/FaQHgnHO1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WT+9aQfScymrxOESzFGe70PgnUnT1rT1TAlVIYzos4=;
 b=K1uAeaf9lkXGzpXIML/iwS+QCSp7gp9SCM8aOt8SIbI/DKJ4KDK9Wx744BlhqecHMz8slDT2E7kkUbw5Rhzqm39xw/LQLY/8U+ZOL9pNLLyLAGPnQKXFbw0k9tGKT8/pd24+HrIRnICp397EObD6BSn0sdm0vSpe8Q3TCfB/pZyoHxseKaPDOSaBj89m4je30H13PhPibd9s2dQP+Ddg50MxeeNq05Dk88gi65BT8Dt4hc/Me/f1p4VjRiCo+1ag6WS4LCjg26INNBkGDkcOwV31o0UnVDF2gHWkZKEU+NnVzQo9N2qjbc68FcKh3V3k5pTX3YDdWKGKvv6C8pi/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WT+9aQfScymrxOESzFGe70PgnUnT1rT1TAlVIYzos4=;
 b=vvt3nMDZGngosesFy7e6aaabWbxs7M8ha/xfNIMp9e8YjruG/+GI2I/n1VqhF2RMGCI6LUIBBwjAioq+Q6ttzHJl5NmMBsP1tHAJjWjNmmna6eQJrAXlk8tj23H1MU921vSn38tXHCrvig53P9kS2OoHUI0SdLcMyX3CMENOEjs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0209.namprd12.prod.outlook.com (2603:10b6:405:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 9 Oct
 2020 17:17:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f9b2:c475:ea4c:7f07]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f9b2:c475:ea4c:7f07%3]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 17:17:50 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH] EDAC/amd64: Set proper family type for Family 19h Models 20h-2Fh
Date:   Fri,  9 Oct 2020 17:18:03 +0000
Message-Id: <20201009171803.3214354-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0011.prod.exchangelabs.com (2603:10b6:804:2::21)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by SN2PR01CA0011.prod.exchangelabs.com (2603:10b6:804:2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 17:17:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdfc4f9c-a1e5-45bb-3bcd-08d86c773fcd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0209FE4139C1C691016A587FF8080@BN6PR1201MB0209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+6RYqhS6eggXm+Rxh+eXioEoTNimVU+YUXVF4n06y0Qk1apNDQYEnI9ywL5orp+IdiiqsFFv8rakgAaZQDiLOSds3mnEWm9xuux+/GQT1qNBRgv5FIDBNP3ho2CiywGgXdpMleDY9sjYKO47cPu6qgHu+NoGGbGHdMaQ8YA2Gi21PX4PZfzDsMPQxwfjOewnhgUn/ofAi9ExD+KPifdzPTsSY2EYccYW4HZq+E1E7Bv1x9/cqP0V6WsnQPGN/wpYmK+AvUusJm7fX+hoiUh6M6J3e+xaS52dvpMLGtXkk/Aa7cJl4XzOy+0OSjkRgboDILdBgS1TaRkmdiG8tYbRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(7696005)(52116002)(36756003)(186003)(83380400001)(26005)(2616005)(6666004)(66556008)(478600001)(66476007)(86362001)(66946007)(16526019)(8676002)(6486002)(956004)(8936002)(6916009)(316002)(5660300002)(2906002)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QScxAy8/u+oWge3zdZouKNB3w99C/ouuls02Rte4CzLhXON7K+34goIAMxkI23YvWvq+Yp2JWKTT8T19C3aVAz+ogwHLPa8neaSZrdHhZHANALlMwPZdovHfGGavg6Og/Qq+7gl4ALz632/cCY0VkDa2vuSBkoE7iLJOrofVUSza3zXu2ItZau8dCk1cYbyCLxuPFa5Z4wcIemrQMNROxvM0gxeSUdFozzQNcYW2kwnnXGyfwb97Ovsqc9VEV5fhnH2Uqlgk0kxgXPPT4xcSiXDL4ZYye7A18X1dr+HIHhRImlVO2VcCu15ON5OGb365aRa4tiR52DUUCMpXSmV3tWEpv06t+lyMv8WTjqVokM03noIJ6TNWU8ctc94JvgYcKx9E5n9UbSiz+mpQaiFtigF542ps+5p8iQc5Is01mrwPq9pcfFu57OnK5qEywvuMZhyWjQ0FPxAX84SHpBIQ/LIrSusA2kTf5vA+O3tkC3jKeYvAjfLEbzPxvUb8tdM2eRvp677P5XoEciegQiprN1Y+zzznkd+3Ti9wzSBfoHDZ5IvS8ibX7ldjz6lZj0Sz5AU1zIJJEEVGoYA4hCFQK4b7Zh7/24Wbv+fqJrRq5HyAtIq8gKvlmIK/f+oXLtQvBUFGvQoQl5T3Xq8ywddfnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfc4f9c-a1e5-45bb-3bcd-08d86c773fcd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 17:17:50.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YErdnuc36LN/PxKn08RuswupfA/jgCyN6hEw5mJvPd0fS7oAt+iJYYLggxnzm4qPHJ5bWJ5aHCAdhMr3f3wJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0209
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD Family 19h Models 20h-2Fh use the same PCI IDs as Family 17h Models
70h-7Fh. The same family ops and number of channels also apply.

Use the Family17h Model 70h family_type and ops for Family 19h Models
20h-2Fh. Update the controller name to match the system.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fcc08bbf6945..1362274d840b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3385,6 +3385,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		break;
 
 	case 0x19:
+		if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
+			fam_type = &family_types[F17_M70H_CPUS];
+			pvt->ops = &family_types[F17_M70H_CPUS].ops;
+			fam_type->ctl_name = "F19h_M20h";
+			break;
+		}
 		fam_type	= &family_types[F19_CPUS];
 		pvt->ops	= &family_types[F19_CPUS].ops;
 		family_types[F19_CPUS].ctl_name = "F19h";
-- 
2.25.1

