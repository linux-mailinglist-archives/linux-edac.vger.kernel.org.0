Return-Path: <linux-edac+bounces-1474-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B0F92BE10
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AF8B2CFB6
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8C19CD08;
	Tue,  9 Jul 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z2wmciXE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B719CD03;
	Tue,  9 Jul 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537253; cv=fail; b=mcxhUQte8M6Ba9ogLuKSA/kz+ePUwrrSXVClDBguWBcYSC5LQgTcZF+ijvXkcmLJc//dynnG00o1ecibj7xUmDzhuNb7s0c2iZAQMRBtx/gmOS4zlrwo4x1H1URgv1myC0Fhhxt3av+mXW7J1/6qlQjlVqNZmpMh2zZNV/R1QLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537253; c=relaxed/simple;
	bh=5I7DGdXbOomFFzNETkGuB7z3WPworbjeMCgjhM0awEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jYPw2PdyTWaZl4MkM42O21yppDideyFcIC7XZ1wHzW+WoSneRtkX6kdzgH4xCLLEtl3eg7WB3t7c2kRd5K11Hq4T1B1olW8nv88opkok1XV8N0XIKXN+SnAhJZ6k7MyKo3rSHQVUQGkULTAC2k7F94lStYeXa7CBYWD6glweYMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z2wmciXE; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXfE7cU4c+aucBL1ln1gk4qMtHbI2ehZXLtHrcRgA7tF0NSMJK/Vu4kRBri5rstr1my10puV4IkYboRQ3n4ufkOJnHqTzI0oix78PYlVbEcvKfgZvjNsZ0eMnsOSD5rtzGYAUm6YWNiD5wNNAMbptFvqnCLSMekSBk2mxTSQiPkxAKmeNy+TSmai4+VuXwaSp0onJS1a7EfVRYYBAd9kWzcGb62eruprn6gl6C6Eo3Px5NN9IdpZmWDqUiUdkIDpJtAHiuAb4GeHrs9ryEbstVtaL6LMRhaX/JDolX2uVJo1xek5wnxSzY7LnULHfIBhYUYBnRLN5NSJvTllOvzjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohtYlbAnypgJGAKsYVqP8N6qy81euojUrlZ5VhOZPDU=;
 b=GVqSFgwL8KV4+xvwCUv1y9xDCxzwCARBpj14ilnYzR4/Fu8VB9gRLmCWFBoJRGSW92ptV6MZeBZDuAuA25yChaKHX0ot1aXQYT4K4g7xhwGfxLcEpwKFoRkkBIUVn0AcMl3F7+7yqPUCVF7ahA5uh6BNY76AnIhP1WNlnQeQguZyjBJOPUJsQQI/MEKJEiIJah+t9PF5qPhuf2+Vxg35hDUH5l4REtS7g6LaxihOo4jGWoTi3Bt+hXK81FfpTVnbGB7Y6NG4nisM3UmBI0tbD97mUAqE1Yswr6GNBNKTZuubyjqy7HI4MTcqzMwVFMBN5ZgPvmwRCjls7bos9gyGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohtYlbAnypgJGAKsYVqP8N6qy81euojUrlZ5VhOZPDU=;
 b=z2wmciXE9m1lNEhHkVpjZU4ylLlP6AzTTExSQ1TE8wgaBwXDyfKgV2mP8IBXSiu7CX/DY//3EOWk4eyRpRAfQSoSMlkm469x/1z+hPyoACd1cjlg/1ML177Zqv2fTbPGUlD6fMXhggBg/cBvS7xIZgWcfsRZW705qICEoIlfHHo=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 15:00:48 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8b79:8f25:656b:2887]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8b79:8f25:656b:2887%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 15:00:48 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Ma Ke <make24@iscas.ac.cn>, "Potthuri, Sai Krishna"
	<sai.krishna.potthuri@amd.com>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/versal: Fix possible null pointer dereference in
 emif_get_id()
Thread-Topic: [PATCH] EDAC/versal: Fix possible null pointer dereference in
 emif_get_id()
Thread-Index: AQHa0gggox11Rzgwpk6aHLocGe33yLHufSRg
Date: Tue, 9 Jul 2024 15:00:48 +0000
Message-ID:
 <BY5PR12MB49020D6019CE24F863A5B6AD81DB2@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20240709135830.1172936-1-make24@iscas.ac.cn>
In-Reply-To: <20240709135830.1172936-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8d19e1b6-5093-4963-a360-3d1acede673a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T14:59:31Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|SA3PR12MB9131:EE_
x-ms-office365-filtering-correlation-id: 0d7bdfda-9989-4ffe-58b4-08dca027eae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gXHyB9v3oK2bTHrTVfwmMtGmWPdfKN3/mZFXlzosCiTwlG4aPNmXueIjwscJ?=
 =?us-ascii?Q?XCcmD+zm5gMs69vf6ln0EvvgyZXyMXkUEa3j7n8MW9VJdqLmYGhcsHuGsGzK?=
 =?us-ascii?Q?9SEMvaRmlf3UDdzaPD92z6AR4OvxfHWOZ6hzxKYEFaCa2QqwkwxQPA/BEQq+?=
 =?us-ascii?Q?UVgOS9mQzSd5o31kHt9ExMsp++yaUgtM8RwOWDoYvkszCvzngNMR6GG7pq3N?=
 =?us-ascii?Q?hvGGm+mZv4w6HANcP8Dssy69vL/9CsPGNwXsw+VkUcDdz7e2XNhz8SYtBPc/?=
 =?us-ascii?Q?tGIXLjbtp890ibnoF4fJEXFHbI6RCIchcAJnse114R1FbMqNfusLiG3yYkXM?=
 =?us-ascii?Q?0LOKlNhBHZldsnYK0rAEl1mlncZ5hweCrOXZitELKC42NqK4en2OvHrk0jFq?=
 =?us-ascii?Q?2/IspSIWdqb+IVsftmZPmU8Xvg0K9cuyWAWrGcQ7yunbpVcqZ5BK3uQ4CzzZ?=
 =?us-ascii?Q?x27biPiWEOESjr6BiL11JxbpHHumwEQ8pCjDNiZSWmdPpBWgldarXlKWmsq7?=
 =?us-ascii?Q?ceV6gJhztSxocxA/S9qcqqIIWDxhL+MwcGTukI4RyZUxjlD4+DqWJMvFyjQ7?=
 =?us-ascii?Q?afgvM+G/Pg6psblT1Uh9pgiRRRtKxBL5JDHJDNe4rhokDfUBFhhg7JYbcln0?=
 =?us-ascii?Q?OLRdy0s117REdAC2j2wDG6AhoqduDE79MSt1l51xRuiTTKrPjUv5hAv+Tky8?=
 =?us-ascii?Q?3LUz4M4kkDRNZU2b9vFXHfkC/gOC4EGTRVjI/FbsCuqdxCc+ZmeG0ph72Rmm?=
 =?us-ascii?Q?27gY8gmaoO9EAPGFmLOzcep9umtw/shgMGuZlfMbP4GdkLVxNwXYvivVxxbo?=
 =?us-ascii?Q?ewZDuJzlJGjKUntLrpOlXxkKIlX+XO0SMYldto/WRAcoZAbYNJiZVGGLRqMp?=
 =?us-ascii?Q?DvS2haGmm7VKtperXRj9eVzXwiFEmzbjlQmcodNLj/We1e+torpmVnlWad3D?=
 =?us-ascii?Q?f+CyJbIDj5jB6OuO8oqOzTAKpw6HY/KSVVVZUuAkYhlrsVjWC2hy473zlnxf?=
 =?us-ascii?Q?vg8yqrfGIsOwFr42743SVaSxvgEalL3l3V3j/fTkmXWjH7jYgNcn33AO1uuu?=
 =?us-ascii?Q?r/6b9NketBFEzfZbsiy5XgJgmPiWeGe+yPSmdh3cMhdI/YAQWLWC3WQ6gBrH?=
 =?us-ascii?Q?jEMK7+BGr4+WcQASItktRwxO+h+z8g87BG9H0QS8ovK0/yWuqUQswkZ06aAA?=
 =?us-ascii?Q?eOp06Zbqh3UYdYQmOJUw8Ym8BWM7lSLiyOJA4KELp6jT+ci9TacjN4ADnK6t?=
 =?us-ascii?Q?eH43dRL2WLa/GFgNcjwXJ1xDk8j/Sd+1fGl97M3mZh5G3JFdnd/G/IDAMgRr?=
 =?us-ascii?Q?/tmvk0WGcvzGKrRDdEz/genragrmNbodau7hTBypLswHbNTriGthr5P8MLbj?=
 =?us-ascii?Q?5daBQ/E5XE3Vnl+3+/Uyy3Stk5J3V2B+Tf+m3ZbzTbYiyTd9KA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2wOFh3xKXMYuXPgmyyFT4hhU7VI21xvGf7kdPiKwxpopmpdb3wBRztOlHKvG?=
 =?us-ascii?Q?KWjOdxjwekcXsE3PM1nHrWxaExDMO6RtRLWzy66AxVihYmmKQfWak8ZilLMZ?=
 =?us-ascii?Q?968ND+UDqFRQDPKX+N4FUYbAD7ZPzICu8AWmtRaFXHO67mnrMaELKHaC7vlW?=
 =?us-ascii?Q?5OGOEOouIHVh5oLC035Fw/nFU0d6+UMLrC44RNOlmlUbrQxVaO5fjuQOa0ie?=
 =?us-ascii?Q?XWTTdVSZ349ClqXXX8s40AmerHFl+z/xB+U4cciCh0LZOfra3q91Pw8ynknk?=
 =?us-ascii?Q?1XP3U2LSjhIcOYiaQ50QZpsbxNiQH4PKE/8bHHTFlgfjW+sne4q4sU2VraKA?=
 =?us-ascii?Q?THQF8SFjl7kpZEQeDbAUjjFVwcmYDvIaac5n8wPAzC5t455mbY8mx+iIjwUj?=
 =?us-ascii?Q?rEUA1/+jkf9t/0duiMI+V4fQQd0tfFF0NM7JmQ1HyV7lqAG4y999YcqXECat?=
 =?us-ascii?Q?aacWYVkqoxJo+QLxsv1QbR7rn4GIxhNTbxEfT3dY3Ru6a1g4w4tPojmqc+WB?=
 =?us-ascii?Q?NJrlX2pJ84oc5pCunCyvZq0C8vwWlCGMSOKHIfBZzVmnCssjWeylkg4PMb6m?=
 =?us-ascii?Q?uvRz6Ic+nD1z49/QMJN9CbYgMUxCR+M+6HmY5rltz3rh5ERN7OtVMFwelnO0?=
 =?us-ascii?Q?Chev4UN0n8KLBRiZ9XfsYEDPI1b7nxQWESjJmRUWGY4MxLtZ53JBpFZs25Gl?=
 =?us-ascii?Q?5a5kC14vTvmIV5baX16OMOrFQl5yLZS1Od6g+nokK/1xTGTUDU/tYsy+9Biy?=
 =?us-ascii?Q?03qVfS+RPemzih/91CjZFIv0OvU0qEbgQgKxWTFKMIao7bIlxzckVKAgkCmu?=
 =?us-ascii?Q?qnk4+pWexzJfSAAbRNy+S1Vk6j6WKZqzI5GXAXBp1gZsfD9SqczubdoEcN3M?=
 =?us-ascii?Q?6EX+z8mJY3gO/Fp3WIzApt/WJcAE2jT0DCq9Jbw0E00P0jvP/eLifXw6aNxV?=
 =?us-ascii?Q?OfTNekplr8Is12C+2GwyMessdPH5iH/0/yRGWtB5Gb0cWjQD2qFOhwpp2Msi?=
 =?us-ascii?Q?zBp48gt8yDQRfBM0VUhxQ7LRprwC1mwsZLnlcKJ2HAe2tcxYgkrT4ZklmHvk?=
 =?us-ascii?Q?pf0s2j6tZ7ZVTydfX2uGULB9UC5cJ103eKo1sJuZ0ZXCKwW9vWVeeqeq0e1N?=
 =?us-ascii?Q?FxZbSkYFBijwlGh/giUV1ff6LfyA601vOXZHXhjBeFz56ZtCwsyGuNwOcbF2?=
 =?us-ascii?Q?LX5fQrn+0eiK3tskUcG3LBy28SlsSNDNfqwk6Y9D8clFpb2Qa3+F6egNabpS?=
 =?us-ascii?Q?9S9n4+CtvIS7Qfy33DXjsVF+3UxwwF6rJQYTtqIwEqPcUcGsa12H0Tv2SlJf?=
 =?us-ascii?Q?QqV5jDGyED/bGhllxObMzqPPq22BA1v4ppbSyMLDlOx0QosqhTQSr3WD/f7n?=
 =?us-ascii?Q?cim6zGB9gCkk34kH/uESi5SkofZAmtIii5UvpJURLLLBuAQGsdMr1uk3OR9Q?=
 =?us-ascii?Q?t7GM9T7h4ZIITB9Y73wWMt0U69XoXneM6QeMoFX+yzwlhhvq3X0eT+DDF3G8?=
 =?us-ascii?Q?dBK4LA/3LB/iQcDAL28rrdxIk49XEgC0kaN4Lh9LlOio4HgqOBTKfsIJAt0r?=
 =?us-ascii?Q?Fz0SNDBHMcy422w5LM0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7bdfda-9989-4ffe-58b4-08dca027eae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 15:00:48.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwD3rtPg7deLoFrFqX3Mm9fa6aB1ob2V3/OgwYjn+1r6OGkok9rMatORH21Tdw/jfl0uevcSh5pJrYPu71AmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Ma Ke <make24@iscas.ac.cn>
> Sent: Tuesday, July 9, 2024 7:29 PM
> To: Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; Potthuri, Sai
> Krishna <sai.krishna.potthuri@amd.com>; bp@alien8.de;
> tony.luck@intel.com; james.morse@arm.com; mchehab@kernel.org;
> rric@kernel.org
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; Ma Ke
> <make24@iscas.ac.cn>
> Subject: [PATCH] EDAC/versal: Fix possible null pointer dereference in
> emif_get_id()
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> In emif_get_id(), of_get_address() may return NULL which is later
> dereferenced. Fix this bug by adding NULL check.
>
> Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller
> driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/edac/versal_edac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c inde=
x
> a556d23e8261..6ab87277d439 100644
> --- a/drivers/edac/versal_edac.c
> +++ b/drivers/edac/versal_edac.c
> @@ -1053,6 +1053,9 @@ static u32 emif_get_id(struct device_node *node)
>         const __be32 *addrp;
>
>         addrp =3D of_get_address(node, 0, NULL, NULL);
> +       if (!addrp)
> +               return -EINVAL;
> +
>         my_addr =3D (u32)of_translate_address(node, addrp);
>
>         for_each_matching_node(np, xlnx_edac_match) { @@ -1060,6 +1063,9
> @@ static u32 emif_get_id(struct device_node *node)
>                         continue;
>
>                 addrp =3D of_get_address(np, 0, NULL, NULL);
> +               if (!addrp)
> +                       return _EINVAL;
Please fix the typo.
> +
>                 addr =3D (u32)of_translate_address(np, addrp);
>
>                 edac_printk(KERN_INFO, EDAC_MC,
> --
> 2.25.1


