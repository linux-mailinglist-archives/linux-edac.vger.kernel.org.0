Return-Path: <linux-edac+bounces-4144-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79069ADB015
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 14:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DDE188D40A
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4A2E427D;
	Mon, 16 Jun 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0QTP75H9"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D92E425E;
	Mon, 16 Jun 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076446; cv=fail; b=fkvGBiWSY9OPZIwyCq59oqR1JLi6ULqdBiS6lCKLItINLFIKkMStiaJCCjVkG4ziu7h3ownNv6n9OS60NltsbhJNre63sXXjGzTr1Mu7bsBwZrZE20eeV7vfnfGblsIGfUVWdO7LUeiZIp7gtF/320IGCB4Ck8DUlhxLgz0VBis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076446; c=relaxed/simple;
	bh=LMdBvLqLKDjiU90cPHAwvqpKQL2+Ys+6OOXn8LIndjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWS3WcDGxA2zuPI8l0lf4m7fBsv4p99WeQlp7qAZb1mCo2OZejR1GQEeOLAFFGF5QEDX+q5nJrSkpizqNRL8HewpO3E4hYw7dg9Lr/yDpNXJ0D5/wWCeh13GcfA+SSFL4OzYYjGNAh/xDP9PWV2/nXChXDl1mEVYg0UUePnc+c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0QTP75H9; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBbxeyUGS5E6WI+bRvo9E1xjB6BgyxaQzEfWlxIjfI2f17Fjin7ckJEj6d5gUOaipkvkP7Gm5DukMpV23mr3ZibIIqnJEG0Z5SF3D5M4pMf/A1oXKUuvqBTiuevx7mrs0imyono+A1ZNbBv+zYV2lCZY9WF01bTzVHAF0nPkqCGl3owowKMq5PpsO01hnwcMc57u50TcYFCdeBt7wFz6ySLi3BIEsiScIfwHvUMF5ZrRTonsKrJB2KPvwg9yv0bY0wuyppn3xiOivyRFPVHAmLf7PooZpSCfFvgn4ticpvEjmIlKX5Nr5l8lDT8rHtXphx0tKE3eEUqLwCIZD+84Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP0nahQydsv7vyXpvOY0GOiMC9LLGhH44S0s4umda+w=;
 b=eX7cc136VLeqSBqHwQsWB9PgPLNzfFLZtj3ntWDT9XlMQfzDbn2wLCw1zPaMaxiXweDtzCV2HBCS/8Sy77a/Vu/rDcNqg32SqNoPQJO2kePI32NWh1SQ5gRome0E2YOlD1v/mNi4A7gV2HnhWzf1jJmsFIIfwuH0J0CFp+9mnb8NLnDlI2t21LmM9unVI6qbbBPdcHIktm2X/iLEj6hG5NLTteu8lrFteKANTmi2TVybCneK7AyKS6z9VFIQYj+AX60FQws2nmIwbgLXdc9UT/pTV6reonLsxImBlPoIQ1cLNtH5WKS82Pn8HIncj00en7/rBSjEBPqUCX9H5Uh30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP0nahQydsv7vyXpvOY0GOiMC9LLGhH44S0s4umda+w=;
 b=0QTP75H9D7buyiMWMGh/xMavfadxRzwp4trR5xovCI8uSkZ+rM2QmM30kve5oY7vJm9Q1KTRy3uoNmwMokHTokAX+vDpym7L42DV6kWa73ykTwE+T/A7jliZv+WsHDKwPq15YDdU+JHLII6XDGUhNc91g2Qw7+qo67xCiNrp9N4=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 16 Jun 2025 12:20:33 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 12:20:33 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "git (AMD-Xilinx)"
	<git@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert
 Richter <rric@kernel.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>, "Agarwal,
 Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and
 Initialization
Thread-Topic: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and
 Initialization
Thread-Index: AQHb0Gdq2gBD2sbZ202dCMp7SzlQC7QBnaEAgAQzPnA=
Date: Mon, 16 Jun 2025 12:20:33 +0000
Message-ID:
 <SA1PR12MB89474C0C76A66775B91A20C98170A@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
 <20250529070017.7288-3-shubhrajyoti.datta@amd.com>
 <20250613201034.GC171759@yaz-khff2.amd.com>
In-Reply-To: <20250613201034.GC171759@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T12:19:00.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|DS0PR12MB8272:EE_
x-ms-office365-filtering-correlation-id: 790e1711-1138-4ebc-5000-08ddacd0315b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YSJ0Aek8korrHGeX3pMliKQKnVSMgWu9KyTKgcPDEDi91RDrvdPMX8JUzo6C?=
 =?us-ascii?Q?hvRVNbicmBCL7UE14X1P5wMPU37UMrNL9Z6fsFq3lsIc8K1o0aEBRu5K1a0U?=
 =?us-ascii?Q?VOqmcQMkGqJWV+zU4jK6S0sgJcj6AXf6xAs9pWIXUG/c21gqx/YuxqDFqtAZ?=
 =?us-ascii?Q?AsgQN59HCP3h11znHzPEQxv2GG+sYhr9yY8LDXpRRTvjgd/eEWoRhJfZgBAu?=
 =?us-ascii?Q?RhHgT0T7Q4wgDk97vkp17q6vIM1rsmXEne0Lzj3QucjaVcxzA5dz8iiTGKC+?=
 =?us-ascii?Q?washL5JLGpKGaWHm5LiYpWpwl/9/3YMkTDCkcVrrD3Fkx4iiXwx9082s6siy?=
 =?us-ascii?Q?LP61F15MwK46vu020ms/OAe144Egb+7sk1Tm2xl5aNFNOcWWjY5vZZrdrUrN?=
 =?us-ascii?Q?aTaEAypNzQICY9ZEZapxbgD5uFvB4tb5vnZi9a/7gIOcMGzk2kiIkmFYg5iL?=
 =?us-ascii?Q?mq9PZY4IQqbE37Ta4LIvOozqc1COoabxZga2sXhgYeRBA+j3pr/colz3Sr2s?=
 =?us-ascii?Q?qrAaKv7JJqmX5kIIYv/TcvterGCGlaXiLUKHP/8cSWFX4ZDjufEaKabawRso?=
 =?us-ascii?Q?O1fw8xnXh3LOsRxbhCuY1J0iCuZOcanHtYZBND+svKga+sSy1TUR9m+1J9aF?=
 =?us-ascii?Q?ciMnQmSsDztfSVuj/vse1TKYaDrRe2mZa05l5HPfCYyCpQqgUQ7v35lWdqwb?=
 =?us-ascii?Q?ATXDYbIhO14qaVGPkCfgxQs4AStlUd82ETsy/pkzCoA/7888Eg6W3KzgLVYP?=
 =?us-ascii?Q?wFnxquhaanZ+5MuIV8tqye3usBnknr14GgxKhMpoAA+lF4U30CeKj9mnHTkg?=
 =?us-ascii?Q?m6XXb1jEPZ1j1cZsx+F6/LqRvO6BEz1g4RFqIKgCKtyB8Hx7sl00XyybWo2P?=
 =?us-ascii?Q?ibd3dPpndEqiKhjILtBI2znyWnytTe+adV9gA+Na/1QaavGcJ0h3gskTlHMT?=
 =?us-ascii?Q?oQkE6zmI1A3uf41yyK3CDKfB5gvFhsTzDgDrk+Ix91JnFGjlB7gH6DSyMQa4?=
 =?us-ascii?Q?Eecu4prV+fNTRJhvueln/zXR/Mer+09UPL4SgGgkwnt3gz1ioOVAUURC/22y?=
 =?us-ascii?Q?qH1yjRmb7M9jR8qB/W6x6WNRyRxMIThIdfyCOCHqQt+neptjS9yBj4KSryEA?=
 =?us-ascii?Q?EvOUxlQjGrOLZ0Ie3aFwvMNgWGW9/Iy03iJb2HXNJxDSE+18/UlxIalsN2cX?=
 =?us-ascii?Q?KPB+1XlEKX+O6EHNsH/eH7iRjuGiiOxVVlukf1Gi4rMCMBcaJ62ulD8Umc9B?=
 =?us-ascii?Q?f9OToprYwAlvD39JAEj7l58212w5QznTYae2/f4xC5HtHWrxflc2ffY8UfxV?=
 =?us-ascii?Q?ProjSfp6nHs7cHKymc5WV60mlmYPrXxTDG7E+5fDLfT+UhUPtr4eM7KXuPAH?=
 =?us-ascii?Q?bD2GA8IkkxH0J6zdEWjifGGRpV1SI7JVbiF40ZnA+deYPJ1SjO6Qi1L39/3n?=
 =?us-ascii?Q?JZmoOmPE5T3/x9rw6M36I22lX7IaHrdo583qssqhNKaYlS/aVsJFVA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2kGPL4vXwTMgOW+1/gWM5RWUUhYWEbsB1BLAp6zFB6swzOwebb+V5hhDZtSy?=
 =?us-ascii?Q?Q6LgekMMxnFAfFTEwtIJPXCmzCFMyCtVdrIS1DOrKAW7Phy1vG9YiGovVU0O?=
 =?us-ascii?Q?/LfRlnl7Q1ZyXRe+EwAfqbVPKggCnWDERnjWWhC1vdjhYAUXaZdYSGg+PHf3?=
 =?us-ascii?Q?Z9i01/3jJqCClyf1YMHaf4bO9SosZgfMYVZ/9ugTI2PE6U3MNwEso77W2mAo?=
 =?us-ascii?Q?6QTe1jxe+O/neDolDGJXTR2HIMC1Q9UdOoXaGXcpt/pWMInh9myZoQKUtLZe?=
 =?us-ascii?Q?IYB0SxXX7IBoaZ/rOqGjCQv6MjIVL2ppANqDirVQlb8/as8HfOG9r3i1opz1?=
 =?us-ascii?Q?flW3nJ2G5PsSDuyvwIihSJYnEGeiL0rFdTvTtOtkVnWADmF6TTL+6K150uUB?=
 =?us-ascii?Q?gmmuOcMccCaMXXOH4bpOo81dFLRuhx9hfSSGnYbj020rnmk+3KFm1R48Srlq?=
 =?us-ascii?Q?shIY7FXcHmjk+mXa2rrbtohWieJhunF7ph37m5YtprUqt0dcjY2HuG4D5qM1?=
 =?us-ascii?Q?/QN4ehDyxOwx+5vNUXzcih3nzqw9gS/u93XwSnt2dyuvG1OD2djojmKhnO2W?=
 =?us-ascii?Q?hkPH7s8VosS27R7ptl8KL6bBA3JqFZgNZp8gc1aZfCFgs66JE8p1i1IRX6l1?=
 =?us-ascii?Q?nHj7/KFY5Bslxy8TAsKFZOsQy32TrItfB52ETC2kMbn0E8qF/HDIQMEdU6Ir?=
 =?us-ascii?Q?mda1h3WybCuVIZWX4aaKILkVdYou+CLM6ms//UrtljFhPWkrJ5z3rmKPSYz4?=
 =?us-ascii?Q?MbTFnC8gqIZXoC1A+AJ4hAmTYDn13NLjayh7/PYg5y+Zj+j9zYvtnqu3PW6P?=
 =?us-ascii?Q?PDie+TUqAhi1B5oii3gPOESGiwaQorwGBRIsF7yi0bI2SodITznRDwtg9mlP?=
 =?us-ascii?Q?5y0eWOg/1+eA2uGNUcV85h7tEk0M3rQ2bPvAZKrSP+/f4btiiEqrxstJfXP2?=
 =?us-ascii?Q?7M2sPYdWdk6rff0WUAzXvv+UzmTS2qI1PfLu6udmV+xh189/sFf+HAJNLNeC?=
 =?us-ascii?Q?mY89/kQtUvsz2u68u2/zg7IPPV1alrFauUcchFog2ogXugzw0D4Kyb9OUHSa?=
 =?us-ascii?Q?UDUlYOKFN2Aji5jOQOTK/C3CPA2iZUZNVsSkDn24fzn/wcWEXMak2JcnIl6J?=
 =?us-ascii?Q?O3kSbY4U4beWWLzB50IzKJRwMPwoXxw9tn3F7c3/0wZ/Ln4iQAHKPQjq1Wuh?=
 =?us-ascii?Q?k5HWfg5jV1/A92c+kDp47D3rgkIoulQeD5z6/fmi1PLrq10P3G/W9pXiE3sH?=
 =?us-ascii?Q?jz409B1yvvezyGw1BLi5OtRUTm2TZSr1lxqgJLyIWdHUPxXqOBnB13DvRrRi?=
 =?us-ascii?Q?YePhDFfKFtxROk/InVdTDgXe2WEGfQle6DG22sxZJpZ73FD9e4/6oo3/d0Rk?=
 =?us-ascii?Q?+LsedHupa4QRHXzUbpFWgoelfaPPwi2HABE1unBSRwf88s23mxkxGnznjcX/?=
 =?us-ascii?Q?SuS8N2Ah3fIFnZMKFxd68THe7xn5uyNPT1drulT6zFTUn0nIOp/GrtZ5geqL?=
 =?us-ascii?Q?DLibMKemnx7YjXcnfsMw5wumSkAJXQE1F/bYRnCD11CggVVM6qbKEZhzDuo5?=
 =?us-ascii?Q?CxaWQQi0OU8HKdN2nL4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e1711-1138-4ebc-5000-08ddacd0315b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 12:20:33.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0t/1vheEi/afWLIcw/faFSPlOdq/lCFnh+3sUtRFOkxD052f2w5kRVGsUkUmz5s2Dqr/e2VeO/ZjxfE5OK+J/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Sent: Saturday, June 14, 2025 1:41 AM
> To: Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> edac@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Krzysztof Kozlowski
> <krzk@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Borislav Petkov <bp@alien8.de>; Tony Luck
> <tony.luck@intel.com>; James Morse <james.morse@arm.com>; Mauro
> Carvalho Chehab <mchehab@kernel.org>; Robert Richter <rric@kernel.org>;
> Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>
> Subject: Re: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and Initiali=
zation
>
> On Thu, May 29, 2025 at 12:30:14PM +0530, Shubhrajyoti Datta wrote:
> > The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions
> > are needed by VersalNET EDAC modules that interact with the MCDI
> > (Management Controller Direct Interface) framework. These functions
> > facilitate communication between different hardware components by
> > enabling command execution and status management.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> > ---
> >
> > Changes in v7:
> > - Add the kernel doc description
> > - Add the prototype from first patch to here
> >
> > Changes in v6:
> > - Update commit description
> >
> > Changes in v2:
> > - Export the symbols for module compilation
> >
> >  drivers/cdx/controller/mcdi.c | 29 +++++++++++++++++++++++++++++
> >  include/linux/cdx/mcdi.h      |  6 ++++++
>
> You've added the function prototypes to this new global header.
>
> But you didn't remove them from the local header.
>   drivers/cdx/controller/mcdi.h
>
> Also, you haven't included the new global header in the cdx/controller co=
de.
>
> Even though this does compile, it doesn't seem proper.
>
> I expect you would want to do the following:
>
> 1) Add the common code to the global header.
> 2) Remove the common code from the local header.
> 3) Include the global header everywhere the common code is needed.
>
> Keeping the diff below for reference.

Will do. However I am planning to compile test the cdx changes.

>
> Thanks,
> Yazen
>
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/cdx/controller/mcdi.c
> > b/drivers/cdx/controller/mcdi.c index e760f8d347cc..f3cca4c884ff
> > 100644
> > --- a/drivers/cdx/controller/mcdi.c
> > +++ b/drivers/cdx/controller/mcdi.c
> > @@ -99,6 +99,19 @@ static unsigned long cdx_mcdi_rpc_timeout(struct
> cdx_mcdi *cdx, unsigned int cmd
> >             return cdx->mcdi_ops->mcdi_rpc_timeout(cdx, cmd);  }
> >
> > +/**
> > + * cdx_mcdi_init - Initialize MCDI (Management Controller Driver
> > +Interface) state
> > + * @cdx: NIC through which to issue the command
> > + *
> > + * This function allocates and initializes internal MCDI structures
> > +and resources
> > + * for the CDX device, including the workqueue, locking primitives,
> > +and command
> > + * tracking mechanisms. It sets the initial operating mode and
> > +prepares the device
> > + * for MCDI operations.
> > + *
> > + * Return:
> > + * * 0        - on success
> > + * * -ENOMEM  - if memory allocation or workqueue creation fails  */
> >  int cdx_mcdi_init(struct cdx_mcdi *cdx)  {
> >     struct cdx_mcdi_iface *mcdi;
> > @@ -128,6 +141,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
> >  fail:
> >     return rc;
> >  }
> > +EXPORT_SYMBOL_GPL(cdx_mcdi_init);
> >
> >  void cdx_mcdi_finish(struct cdx_mcdi *cdx)  { @@ -553,6 +567,19 @@
> > static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
> >                     cdx_mcdi_cmd_start_or_queue(mcdi, cmd);  }
> >
> > +/**
> > + * cdx_mcdi_process_cmd - Process an incoming MCDI response
> > + * @cdx: NIC through which to issue the command
> > + * @outbuf:  Pointer to the response buffer received from the manageme=
nt
> controller
> > + * @len:     Length of the response buffer in bytes
> > + *
> > + * This function handles a response from the management controller.
> > +It locates the
> > + * corresponding command using the sequence number embedded in the
> > +header,
> > + * completes the command if it is still pending, and initiates any nec=
essary
> cleanup.
> > + *
> > + * The function assumes that the response buffer is well-formed and
> > +at least one
> > + * dword in size.
> > + */
> >  void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword
> > *outbuf, int len)  {
> >     struct cdx_mcdi_iface *mcdi;
> > @@ -590,6 +617,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx,
> > struct cdx_dword *outbuf, int le
> >
> >     cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);  }
> > +EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
> >
> >  static void cdx_mcdi_cmd_work(struct work_struct *context)  { @@
> > -757,6 +785,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cm=
d,
> >     return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
> >                              outlen_actual, false);
> >  }
> > +EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
> >
> >  /**
> >   * cdx_mcdi_rpc_async - Schedule an MCDI command to run
> > asynchronously diff --git a/include/linux/cdx/mcdi.h
> > b/include/linux/cdx/mcdi.h index 46e3f63b062a..1344119e9a2c 100644
> > --- a/include/linux/cdx/mcdi.h
> > +++ b/include/linux/cdx/mcdi.h
> > @@ -169,6 +169,12 @@ struct cdx_mcdi_data {
> >     u32 fn_flags;
> >  };
> >
> > +int cdx_mcdi_init(struct cdx_mcdi *cdx); void
> > +cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf,
> > +int len); int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
> > +            const struct cdx_dword *inbuf, size_t inlen,
> > +            struct cdx_dword *outbuf, size_t outlen, size_t *outlen_ac=
tual);
> > +
> >  /*
> >   * We expect that 16- and 32-bit fields in MCDI requests and responses
> >   * are appropriately aligned, but 64-bit fields are only
> > --
> > 2.34.1
> >

