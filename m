Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0962DB21D
	for <lists+linux-edac@lfdr.de>; Tue, 15 Dec 2020 18:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgLORCl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Dec 2020 12:02:41 -0500
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:49249
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728853AbgLORCi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Dec 2020 12:02:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH/a7dtbmIlsBnlOFFqOBv9BVLLCo/0we0PG0Eb9wGlXxSbXyK/ghN4hfDjBQG6Magzn2gPEpe2v4JvTL90OEkbGP8XBP6cuEsB1fAY8pbAbRcXCJieEkzuQbUDFrVtiy/qvLh5dQo3oHV+4O+RbxmJDHID8A0aBmLKk1kbB3GDE6qiu9/JirlbxFtlbLkml4URJOSRcjXSOZN2rB/04PuCH+gUJ5gAf1SBi0kfcyaU4ubdK2Oa/1Bud+65p3SKY/vME/j2Rfw6Xj2L60jeqAceEPh0kh79mjXvTT9mZAWD7J1jxkoQ74FjOxgas69+WJpR3wutqN5Xg3k57FZraww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGaDJz8H9J5ZU+WbZaA6I+M6ru2VK/fzCWSHXXsC6hs=;
 b=LpoOQLxlxPZyoHeuUI+8KC4OMD7k+yZjCBiQkJUyoZufYGppRURreIspjx9kI8bS3QfM/jBTtINhOSTyvMkKHU7zBt51eyGVViD1XFifeZSAyM/9PbkHFZ/p5qiyEoeddZKG6Zq9MeZuXFLAOsl1U6kC5EeBugR0QpLL5gt+ptCx/je9reVGlMPjR4RbuLfXXvghXxliyuF999H4o3Pvp5yia/LZU5fSvn9iH3H5tVTHUZelDIkoLg8wKPPABqLvUjWyN1UYH8QvIoCJbOqCq+O1mEwJpSX5+6Nr9/yQybpRKAJQc0uFieVAUH9PM9j6mchmOAurhfucySYmncnJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGaDJz8H9J5ZU+WbZaA6I+M6ru2VK/fzCWSHXXsC6hs=;
 b=xyQTgeZSkFVwiVYiTpH9a+hSa9qhGbQw8LhvBwWeXduKFbHDJOJDr+iqLnCmPPCwZhFPXWXo/cFAsucg7wJ3CTBKrWSahVlC2yPr0QOX/AsmoLqVCBHBdmI4++kpl7Tm01A1EK1aekwlu1ti5cAgvP/rqIdyo/KGs+u7UH+vs50=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2977.namprd12.prod.outlook.com (2603:10b6:408:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Tue, 15 Dec
 2020 17:01:44 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 17:01:44 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH] EDAC/amd64: Tone down messages about missing PCI IDs
Date:   Tue, 15 Dec 2020 17:01:31 +0000
Message-Id: <20201215170131.8496-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 17:01:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ceab0811-f87f-4bfa-e758-08d8a11b19ca
X-MS-TrafficTypeDiagnostic: BN8PR12MB2977:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2977964CE07CDCAC328A0162F8C60@BN8PR12MB2977.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hl6u/ijQzcDyFIleR0JXLKrgHFGhB85oJN9dZ/90EjH9FLBTzxk1jmgaUG3w3GI8WdS6FcejaLasVQ5iskrpYm5gVAUTLcNATPau09L/Dso9G0ZoGYHNQ59/iII85EW37kYp4LyVJJn1BZZ++aVdMGRnqBb8l0e4u8YoRV6tPFcmgqqNKkpL0q8IUn2mX42IA07kpTy6P1e85Ez7En4o8pfBS5KrMQvRdC5fkMUywtZfWpTVjvTouEV7WtdrnHEIvTgxd2Nz/GgjNhJPvZ2EVijqBA/V1O7yX8v9gzsIpggbR93ST0sw+JKV+692TIti1DOoT1jr61wqe0T14H3YrTIyRpQUHdCXFv4i8Q1gohxWeoxGXt5BKu1zz2ABkMpk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(26005)(8676002)(34490700003)(2906002)(52116002)(4326008)(15650500001)(7696005)(36756003)(86362001)(83380400001)(6486002)(6916009)(66946007)(2616005)(1076003)(5660300002)(66556008)(16526019)(6666004)(66476007)(186003)(956004)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1RlPlX5h3mxaS8UKkTWPmDF8WepoA8kj5zOardu7VySjAdgfw72iHEWQbU1g?=
 =?us-ascii?Q?H71ZkWkvBrNETmcpLp3DytO7dMwfIFXsyb+CHW18PDn4r9AWSprmyMjLK6Ix?=
 =?us-ascii?Q?pRyjMnSNs/W0crLdlX5IIuqqT6HH3NJbrnYWzYJkdQmPRm89WLoiqK+ENKLm?=
 =?us-ascii?Q?eqEIq2tppek5rAaz96IHhaZBj57nEGB0k7ghh9se5EBd0oNf0RZPL3QysCOv?=
 =?us-ascii?Q?YhJ7iwXNg9Wqx3Dh3UpJRDWf6V4y9v2w3DhaRJbR3iGUZADzNiicDPfqftMc?=
 =?us-ascii?Q?AZCQXn34y9rhLz6kOmzMzCRYDXdzczu/4pz1r/gTQyxiUlD6di1XOm3FwY4A?=
 =?us-ascii?Q?AKePAHzWWW4KdhP9GEmhHhJZ+MwfsXtJYNUB7+tgj/UriGxo0DaEk6sHqsrl?=
 =?us-ascii?Q?oGDcqBO/CvwbTJx+9Hiy8Ol/cHHiypcSIJVQfItRIyHuh1hTnU2qyELTQ6An?=
 =?us-ascii?Q?KY762yTOa1VQqeEzC4DV6A2ivkzgdVw3j0BCN8Xfowaw8NKebx6ajnmi0Qtn?=
 =?us-ascii?Q?YpR1Wr27ZWn4lUZlNEcpseX3SFqXlS3R0sUhgv6Tzo+YKpjP0R6zBpleJ0f6?=
 =?us-ascii?Q?9+0RXTd3XSML1Ren9cdlBOSOIBH7aLs+SfS5kPf+OSoj68J8p3/8S8x7cuyx?=
 =?us-ascii?Q?5RYAutqC5ayrjjjUTf7mr8dkNnKPt11AjmSnqQcU5Dgjz8CZ2vhMD+3qvgmC?=
 =?us-ascii?Q?ckcmva2qkedSH54NUkux1i0dJjcLa5FDzW8EactnlpB3a/BnNnkdcvXevu8s?=
 =?us-ascii?Q?GW9UHNuziIkzzODSwnOQXJL9hq7M6wDuqPTa5wbuMdS4N/gzVjlexu6sgQvu?=
 =?us-ascii?Q?9c0oonIZknXKVIJxtEP4w2C/+eeQ24n9CFrTt+3mUh7jES0+/ciWsgf1jH+k?=
 =?us-ascii?Q?3DrogmLF+DrRBEmUrj7QjhnedmE4oKYQxSs36JzDrKB8RLlcB9dGQmGAMAJ3?=
 =?us-ascii?Q?+a8+8zKW88yTz4PLLVFl1y3WOZ7at3WykI0xBL0O1MlYrvj+1bY2udoPQkFq?=
 =?us-ascii?Q?2sry?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 17:01:44.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ceab0811-f87f-4bfa-e758-08d8a11b19ca
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xa30XU6BFplP0/VNIcVvUESQoh/ULxyg3Eq2AqmrgbChwQlSOjrR1KP9Plo/BBEPx2s1FdYfumE0S6PsuxWPmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2977
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Give these messages a debug severity as they are really only useful to
the module developers.

Also, drop the "(broken BIOS?)" phrase, since this can cause churn for
BIOS folks. The PCI IDs needed by the module, at least on modern systems,
are fixed in hardware.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f7087ddddb90..a3770ffee2ea 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2665,7 +2665,7 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 	if (pvt->umc) {
 		pvt->F0 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
 		if (!pvt->F0) {
-			amd64_err("F0 not found, device 0x%x (broken BIOS?)\n", pci_id1);
+			edac_dbg(1, "F0 not found, device 0x%x\n", pci_id1);
 			return -ENODEV;
 		}
 
@@ -2674,7 +2674,7 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 			pci_dev_put(pvt->F0);
 			pvt->F0 = NULL;
 
-			amd64_err("F6 not found: device 0x%x (broken BIOS?)\n", pci_id2);
+			edac_dbg(1, "F6 not found: device 0x%x\n", pci_id2);
 			return -ENODEV;
 		}
 
@@ -2691,7 +2691,7 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 	/* Reserve the ADDRESS MAP Device */
 	pvt->F1 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
 	if (!pvt->F1) {
-		amd64_err("F1 not found: device 0x%x (broken BIOS?)\n", pci_id1);
+		edac_dbg(1, "F1 not found: device 0x%x\n", pci_id1);
 		return -ENODEV;
 	}
 
@@ -2701,7 +2701,7 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 		pci_dev_put(pvt->F1);
 		pvt->F1 = NULL;
 
-		amd64_err("F2 not found: device 0x%x (broken BIOS?)\n", pci_id2);
+		edac_dbg(1, "F2 not found: device 0x%x\n", pci_id2);
 		return -ENODEV;
 	}
 
-- 
2.25.1

