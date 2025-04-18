Return-Path: <linux-edac+bounces-3586-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 741EAA938B7
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E5E447855
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C61A5BBA;
	Fri, 18 Apr 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="IOUlx3g4"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378013D8B1;
	Fri, 18 Apr 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986675; cv=fail; b=bL/dx+D2j5147wN/CJfnjvDwe+66YXY38F1x4FP3+ZFM0VWlWUzkhwDMDxxFnge7clRVVjJgjQz5QMsq7gD5zszP4STGHN6fx2js8XYSzkAmK9W8nbfMVKwcl4wQ9yo9yXSHx0vPJjMQJahRbmXhM7cHBaq13zflsyxeRlM7aQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986675; c=relaxed/simple;
	bh=36Aw5ZXLA+/2KycsFcSoMWxs29XOhdMP950nUhX6lw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEt6tNa4pFjikEH6nFhcPMQ3ngtosvqD8cM4UtBDsYipkUdjA5qSuW92najb0+Z9vEe1zH+ZVJouZQxlFv41eEPjvOvccGKNGuCDomWqxbRLGMZXYhZfK6537bdwG7v4HrCcV6/isv8pOfUc4zZ8vkcb8St32iOSdf+16ADJe2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IOUlx3g4; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZE3+n5Hiw585BTJYbgG1aavYzM9f9RGF3dzsL57/+3LLA4d+8xIRs5u+sfaLqbvMgoB9TKdBqAhli2BOw1vCUlBN2qDTtJIlwVB2XSEzQbu6KFzyVJtxEvnXh44xF1+GcR1jgSzKwxziIZD0UPf5ozHz8s0hYIpiBbdaWCVbIVmK549P1lQki4pnE1vgenOl2IGMJIdvWCU53+Am71L11ANx6Gaen7KSRuV86i3BIcja3Np62d73i+BZzEcXI3gOFwiuFByLIX76b46sKFQ+G6KN6Drk21I4hpSnRWSsMTiGamkBPSGYpK6YkxpjeWzETMtktCyvGJal6bwmRgWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaj+SXbPw0X29ht951pfeDodyXcwBFXH/SrrHlel0+I=;
 b=DsIEShol4obhQywISR99XLRn8N8UznTvgE/9T87zx75umk7Om027jtMXufmwWw3JqGBajUOgYITJL7uUGR9LDMrexxZAD0E0TRNy3HeFa6sbxtd3/FDSZK8JN1Mfb2dO3gz6CZoqpAEixGav/rXYGd/AslI3cBJWoS0QmlYaPY4gJXrMUwXuqNltgXNT4Nd5rGoOFHngJFQBMzjnwQT86FjsmAoaC1++T+xmG0QtAZcz9EgK9EC1l01VDw+tR6tItz+pZR1cX3u1tcFogy0oXd+MdRFkeKfahVndBYRRicQmlP6NgGj+60xknJSgXTzRlkqi695PAqLEcu1d15JXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaj+SXbPw0X29ht951pfeDodyXcwBFXH/SrrHlel0+I=;
 b=IOUlx3g4ijqrLcuD0PhOeWUeT0eAgeXn/G0BRHRjYqidxmCyuvkiBx/CYroE2tD5g5pijUaYLeEHUciSr9JpGDhBbOTTT9TW9L2PcArbnv1ydhVzpAZxf1J1TO9DSfbo4IlNiGBjUEDToRF0DsFf8f3Bgu2CLtBGlnI4PIpeiit0ILkiUG05FrkPD92Xd7AUIS86GkCM/yGCkvm+UH+NAVGFm8RwJmfYkMS+3+ezsGswzF49CCMskeJSxuCVLQLMC6F5Q6cOvMiBq47TGWWmpKXrSvcwmJ+o/fYcjX+KWVFih/6jZlngOForE1i9Jm5aYvD2fKRapkJ4NoDHNdP7tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ0PR03MB6674.namprd03.prod.outlook.com (2603:10b6:a03:396::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Fri, 18 Apr
 2025 14:31:07 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 14:31:07 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com,
	james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 2/2] EDAC/altera: Set DDR and SDMMC interrupt mask before registration
Date: Fri, 18 Apr 2025 07:30:52 -0700
Message-Id: <20250418143052.38593-3-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250418143052.38593-1-matthew.gerlach@altera.com>
References: <20250418143052.38593-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ0PR03MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d54747c-fa1e-41ab-6284-08dd7e85a726
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBsJLdXplvx2R5x+GBjUIXZD/UZIE6C88L51PKrz9mynHcu4oxg7DOasLiug?=
 =?us-ascii?Q?+7PEUrw9ulIp9zksuoNcQhB4QRQNMH9Mg20W32LCtZ0rJnMiqf1mUbYhrMF9?=
 =?us-ascii?Q?b9xAVGKOSLd3KlLZZZncGNKZ0wBXjDVwvYjd/LkvOY7B29HJDsMuW9e7adQg?=
 =?us-ascii?Q?5sFBwCDvHoSrYRYwSYDwSHLjKP++B1/cTzvSNRtLk2z1fpTh/S7t635WjHge?=
 =?us-ascii?Q?IHIC0BhbLRJ9oZP57R7DRFysK/Gon2mIO0rljBPGB75kwhl2N/y4r+J4025U?=
 =?us-ascii?Q?Dmmq644gMoeBOwQA5N30wqRSx3JbiWaa116ff0C2BVvjZ9VUThgs3fXq432A?=
 =?us-ascii?Q?D+5vja11Be313de41TqN2c4fVXhqPycHJPaFL9aZh9PUQd/xAc64UWWjfuvy?=
 =?us-ascii?Q?ik2zfmCC7u/d5nkfC06+EZutJtavD1JDkxiV+pLYlLF73m4gD1n9N1kXv/D5?=
 =?us-ascii?Q?HpQsKuNSr340wQ7pKvmS91A/yb9HGfQ/6aLMXN6Vdvy71whhsCBEYnQoRJ80?=
 =?us-ascii?Q?DZ23FP1bIWi3SZV2WNJ9CcI5TWzMCnKb6jpZyt4PMKoJKGeuuh8vrvhnYa0x?=
 =?us-ascii?Q?vAmqnjrv1A4h1FqFKALJUUyBUdyh2AKp8Rx7z90quBnIjErqwRHcAs3ZWDgE?=
 =?us-ascii?Q?dQyDGj3aedINE2hV0GnLMtJGdFiHs+p5KB/S4XTFSG1uETSBsCTH+M8btuKS?=
 =?us-ascii?Q?hdfS3D5OD/4SgN5/GXMV2gDqSOK6i36JcraPWFEOVGAjMj+QEOt6qkNg/XXT?=
 =?us-ascii?Q?qTf79GUIH8h5ZhtRvm7THFXadwwNNOXR/O8nZHSPb86FrcJbLw2ikJXKxhh7?=
 =?us-ascii?Q?KeWKnriS6AZjz30tSNrPqTrBow1xmSIhAldamiuyV6L4Csm2GZtGHqCj6FlW?=
 =?us-ascii?Q?/WdrCofgcUBMKpuqgP+KzN8/FvkA2jqVNXmNUDkFTMRFJD3c1nxTUE43T9yS?=
 =?us-ascii?Q?h0POtY7RkeEyX+wgS5BMtsW+VNBwhSZGufcexJUiitabFceylZe9l8eUfTKI?=
 =?us-ascii?Q?BLZZKGWvHC06eWVY/SisX6778+K6WHYnfFO17XrzepFzjnXek3H5AmJIztr3?=
 =?us-ascii?Q?Q9PDVQfCXk10OyPzlTd+2SWWYEvWFVOBkRfOzyW1+YR7XbT8kbvsXYVp70zI?=
 =?us-ascii?Q?k37kRbrzuT+HZQNVjM1zB2QdbaiwRunl5oRkROZ5fC14t6Kme833ygotSpfr?=
 =?us-ascii?Q?crJTQFs/cYm55fpwPkFnLr+Fbvm68hICNeCDMlbu4yRJgK6NYbdugAMp3j2u?=
 =?us-ascii?Q?nqqw49AikcvVc5QgbGTBNMSzWei/QVd8+WhEsAoqRt36OVamigoPCFbHfSQO?=
 =?us-ascii?Q?JKTzGA9Ob1IGjzZ/TkcKLMcw1ftgsQwccBjRYr5UIstr6hwB+e/NjlaRMuFZ?=
 =?us-ascii?Q?3b1UVip1/LVhrej3/jbN6+ixBaTOQ7K6sL8F5No7NuZkOQ1mChzFOOz+yVhh?=
 =?us-ascii?Q?Nk+9BsOSn0w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMr35D6WVElNYfXCD+HPsv7/gFGEoPXT/rAyg1qzwpf5nNmjQp+V+pDwkjFf?=
 =?us-ascii?Q?eNbNPqUY+GwLmzFTg8ETX9c7QYBDldIMqJ2Ao7IFMN4A5f7RdMWyl/5coXM1?=
 =?us-ascii?Q?WjWivRLL09ncf9cAiSaMlA2ipb3bcJMb9jpewEbMy3G+504D4EGke3zd+8Ky?=
 =?us-ascii?Q?OtH244CxSFH/AMy1+gS6vc2V5FZPJJbFNyo4aRJ2bVfuQuQ0dVOXlK2LtiGk?=
 =?us-ascii?Q?/aSsXaASootQ3edJ7LP09pOSg/SPmhALlri+/RBMENLRdjNWKxz+CJD6XSZq?=
 =?us-ascii?Q?1om8vw19CtG9CqLAkSwbgjcMsY4R80BLKdxiEzz0nP0zuUO5BA5V1drbTmYP?=
 =?us-ascii?Q?mKpNxqsLWZer09JbppqpA+6ZSX++QzCj+Ocgy7Ckp7vgN8h34Px3lVto0aU8?=
 =?us-ascii?Q?6zJjyZnF+9JhYwMNun9g4rSW5bM6HhiWvh1dp0jOS7yvJwQIMBqvDOq05G74?=
 =?us-ascii?Q?mhWsAUotGEWlelw4YuAI6JF11kI3fwmfsugEENtC7Dl56uNn4zQsgVTMd5Iy?=
 =?us-ascii?Q?vAnWyQIuT1P5er7EkMV6CurdK5EL9yLTdSFN6U7uc+j8GLwPYf0Y1xTvdBGR?=
 =?us-ascii?Q?8eM7fSmQUUhsYcJ5BMlHwlZQeEzMtESc1n+InXWqMwBa+GHRGeua80dybZ9h?=
 =?us-ascii?Q?hSILwa1Sl3z2OZLq9hIo9/Z3HxfttYVKphVZHAsugVJjaJ9yICr52nS1LR9H?=
 =?us-ascii?Q?SJOr7bW5EuVz8ZyeeRtWcOvoqNY798QeG5IjBNJSug1qI5sZk0vQomtSg0d7?=
 =?us-ascii?Q?G7SpdUSJnVcCYeXls1Z/RSF2nhfz5rQmPkcWvO3+6c1jnJvBKD3x0PY/kVGc?=
 =?us-ascii?Q?h/e/l5niDzPFgVWiR8WGiM37X9TXoPSYn4XGeyxAAYT94OFSIQTrIIJvqhRM?=
 =?us-ascii?Q?8/T6TqKQp/UaEIOEv8QxSB60zFRBNOJGKI/VTFZqdWhyI1Iw8/Bp1cyaBah3?=
 =?us-ascii?Q?6uQezscbxKBvf2ftN9Ky4Z97204KefVeFFtWla3W69ytYI7HzTW6rsWVvptF?=
 =?us-ascii?Q?pPYllnBZo8lY4NRp70fwt62HHgxEvPToonTMJ9aUgd0uSA0FaByUT1kpvSUQ?=
 =?us-ascii?Q?I0KnQ5YEnd/QKTRdTI8x7UBBwqup7obnlVyuG8Tt5AhbCaU2HObV52chdxqm?=
 =?us-ascii?Q?A5UDTHk5xx0xI0nH/EYTPlEm9v17RxIFLjhrGFbNDDaaIHUse69b8G0iXVj3?=
 =?us-ascii?Q?L14hTZz8PmQidbruJr+oYphGzsRd+vhPOei9V7DuSfdysAyRoJ2WS4p/puMl?=
 =?us-ascii?Q?6KepTSTnDVnrOjOiOsHSrvqjFVTwLlHQ4h/mQG356iZCX6NXLGnfMuRY+6Zm?=
 =?us-ascii?Q?CDFZfB5L0CZAF4nJtN/aCMnngmgkRUReU6aXmHNhk5EhUi2ahYDb0LHOnANV?=
 =?us-ascii?Q?Hsq6w7MuqwtTNKnXGMtcezMI1MI8UYpE9ML2qi2tvc0Y0Orbplu5CRrwkJgC?=
 =?us-ascii?Q?ETk5N6AYbtGhZ7TPiDDQx8caY5ml9YWdLlitX5XUPEpGR8e6/iNJW3im5xbG?=
 =?us-ascii?Q?XPpCqemcILDpfQSJjy782OUAadsjA4LbR+Mr3uKv0jhk8qmlQL+TK3BoQ26J?=
 =?us-ascii?Q?i8z+8NhvL9/T8sbvZOB+T5t7TwWSAa7daN8m3v62j6V4Opm/ZEm69fN0KtmW?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d54747c-fa1e-41ab-6284-08dd7e85a726
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:31:05.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZBSivwwzRnwiLft5klmxNLapvBEc2OUAL3sjyvOX1OF5cGD9rNFeVIXn0YoaLmsxnuRsu4g+DD1GkCgufBMVuJibn11Cnkpovc26eb0U6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6674

From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>

Mask DDR and SDMMC in probe function to avoid spurious irq before
registration.  Removed invalid register write to system manager.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/edac/altera_edac.c | 7 ++++---
 drivers/edac/altera_edac.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 88d9d2f458ee..dcd7008fe06b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1005,9 +1005,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2127,6 +2124,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		return PTR_ERR(edac->ecc_mgr_map);
 	}
 
+	/* Set irq mask for DDR SBE to avoid any pending irq before registration */
+	regmap_write(edac->ecc_mgr_map, A10_SYSMGR_ECC_INTMASK_SET_OFST,
+		     (A10_SYSMGR_ECC_INTMASK_SDMMCB | A10_SYSMGR_ECC_INTMASK_DDR0));
+
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 3727e72c8c2e..7248d24c4908 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -249,6 +249,8 @@ struct altr_sdram_mc_data {
 #define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
 #define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
 #define A10_SYSMGR_ECC_INTMASK_OCRAM      BIT(1)
+#define A10_SYSMGR_ECC_INTMASK_SDMMCB     BIT(16)
+#define A10_SYSMGR_ECC_INTMASK_DDR0       BIT(17)
 
 #define A10_SYSMGR_ECC_INTSTAT_SERR_OFST  0x9C
 #define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
-- 
2.35.3


