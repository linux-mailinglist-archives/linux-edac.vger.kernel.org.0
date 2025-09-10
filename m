Return-Path: <linux-edac+bounces-4781-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0363B51B41
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31591883ECE
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158830DD0F;
	Wed, 10 Sep 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NpeALrA1"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0A2D948D;
	Wed, 10 Sep 2025 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517222; cv=fail; b=oLvh/bivYHHeWilOvQ9ap7ozXydek19uS8uQB8+XTdNj2bcYoB5rtE/n7LPGBk1/PUpKvxiSv9mFbHvnb4E3j7zVqdugDsMZoR3Va/9NN07nWV80CQtEPDTQoGg7FdOPxeF61H2aW2oubaM87l+EJj2/76FDNLEp6syHKvDrBPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517222; c=relaxed/simple;
	bh=cHkqJAy60cAQu3uBvU/6/OLH8p4K1f7jr2BQxSzY7/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=seWQjQNepmHOq2IQJs0vET3LAo//rvb1zumBI+IqtRVtjAbXbL9aQyk2STknNAViDwwkCrJROfSyLSS+KLgrvJlR1BgGNhdmArVhOHM4Yj8N6oRvtthEu44qhKAs15YVTcvHeKB3FZRHDKzBQ5C3JsDFk/sidPR4mO723C5QG0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NpeALrA1; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4/Rl0PtDa27klBK1SU/DnD93PGVBRoI+zZHXQY6HhBK+BgNudYyGB2H+83MbiKqTMwZIjuwWCQ1o5WFJR/9O/3pdRqf3c45lsEczdv5+j6QwkKqdbJjjQ/6m7iWGZb1pHb3rhbAlZGdF22AAj2Jdvqmr0xmYxkjtOg7uJZuo9pxaDV5WtEYq2BS9b97tRD2y9Ot0wgyzJmtJgzkZLGlnTHGtejYBL66YvsmRhOJ9T7Tjqo+Mkwy5QEI8yRhZQiGptqEEBucwQZWRMPR+m12Fvf8VIst18r3nR4qpLsPscwsUteOTTgpAVsSzHfjOdvvZ/wgjr/eN72XmxFmVk+76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00UihxpjTrMAlFV+NC0s1siZKixPmqFj6vc1aeHLOI0=;
 b=ckqh5iuBwnOqq7BvACIWevCmLCKU8JvAuwxzNxGeYjJ2yaRtoBOnr6F/kU14DfETir1Ark5d2u4NhKDtSVJm5Jv/83PEpq4yjuTTtW9IY210mJurnWg/UZlpXrNg25r2HfqKR/1Lq24lG/JO12vg4F8veC5/9DLzPnTTYKgd1KFnD/6UnNI51RoEwYBSqcwlf0jcMy0gv7HEJJHK3NI0z9JxWe2oYm1Fht0TvbQjWjKfzyxkN+VhybJ9fIdc2TnY+/pUV+ApLxVzZc7SZqzcyOFe8BuQf5aSMYpILxS8ZLMGEv2v9yyQwbMxp8Ys6LWawSrzdhIn1qmzHypIt+V2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00UihxpjTrMAlFV+NC0s1siZKixPmqFj6vc1aeHLOI0=;
 b=NpeALrA1ksRRNlV3itSy3eANYdDjDqj3DyAL1+s7iPoPaQHpKuIS2J8A3N/1ajsTu33JijgLP2TN65+jFBSXZoIDI5rNggRWWrBqWBP6gdWF4Sfz92VXSc1rca7EZ7t2ztoGzjKFn+r6O+KbF/VzexEXTZ161B/LeuHyKrJRvec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:13:38 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:13:38 +0000
Date: Wed, 10 Sep 2025 11:13:33 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] EDAC/amd64: Add support for AMD family 1Ah-based
 newer models
Message-ID: <20250910151333.GF11602@yaz-khff2.amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-4-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909185748.1621098-4-avadhut.naik@amd.com>
X-ClientProxiedBy: BN8PR04CA0043.namprd04.prod.outlook.com
 (2603:10b6:408:d4::17) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 36db94a0-8ad4-492b-9132-08ddf07c9e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wz3uoiMWjiIW6m0++fGPCzeiQlxAcftGWMkZitYDfhUIHtLTzCzYVSmwoEh2?=
 =?us-ascii?Q?5fef8Buyr78WEQslH7Bi0CNi+zASB1mOwFovTAeJTfzT79V99gvPsDJLVSQ9?=
 =?us-ascii?Q?WVzgHhhHCdHlZt/S9jcq2dpeCIyrSWTE7woV3I7aWy6VPPxjGNy+xgwMXQy5?=
 =?us-ascii?Q?Qjphkq49rIDu3EpvvqAdQ4UcFeRK0OO85MLXFNzfPWKT4jyWsaMbVUvw9TQj?=
 =?us-ascii?Q?XwuczV6jeMzLDDwMBAtFQZX+p09z9vHts1QtwiLPripFrApyNEqPSmqTtDQ0?=
 =?us-ascii?Q?pMZciXRZ2yWEHBHPrx+2YLfc+5cJ5oUDB8twtctGmhiiLvMqHcgKgdQZ12XR?=
 =?us-ascii?Q?JsQzGQvSJ2rWfqRa4SqQwxeUTKivmtofL4wk9fZpAsF414Rxg/5ya+r+zmI6?=
 =?us-ascii?Q?qIHuh0Or47PjRBm1tpKIKTeeBcpal1YHEPA03LKovCdUqtOqZmUjIrBtR2SZ?=
 =?us-ascii?Q?AW/FGkPkOo6sDQfbnBX/Ey4VzwAktjqUrHt/8CC3Vxybbm8tD0iSF2zSeIMI?=
 =?us-ascii?Q?GomeRoVCYNYz357erWvXT5cIv+EFTi7Pvk0ZjJ/1YgsP56apsRIZtJpEWwSy?=
 =?us-ascii?Q?JOMagW+OWow4RnOEN70LgqYzlaM/4IDY1YNMTAuaUvLLL6biuFbaHnOdf1gI?=
 =?us-ascii?Q?H/+HRT2MHfeXz0de/XBaaHbmLiMlpVqz0i8Cr8/P6EMZYCMZbjRk1tTRtDw7?=
 =?us-ascii?Q?+YqtRe8lsuFKzi0CoPAcHuB/ufn1sVOecebIu2qK0xv2HLTh85bpN1enQoJX?=
 =?us-ascii?Q?yaTWFw+o+TMJ+RBL9m6OCd50rKcGadnCTXCrmi4lIM8w3ZQACy6m40yS8ghV?=
 =?us-ascii?Q?oxo+SaQtad4fgNjRhF2PK44snA8oFnSqJu2J2PG4ICtfKHcRJ2fgFAKMGz9N?=
 =?us-ascii?Q?xE4Q2ywBe9nl0hAWGPu5qUwMQAAvjw55Rw6jJV2iBiO0XZl5uPRJDXwBP/kN?=
 =?us-ascii?Q?B0EuVpUjOEPSL4dulHNy2eVV+zaFMV7dRZYhulTyVRjAZ53+M5SfJHzQ+fgs?=
 =?us-ascii?Q?q+04EgCKYcwk6F5foDVvVLnfEow+TdoDoiT3muYxrF6sEHOnrZDsRXxwnhPE?=
 =?us-ascii?Q?a21VrpevHqGSOSktFrPQ7avMTCCK4hmRcxZmrexTq5iGSgd8WZ7vMVu009vx?=
 =?us-ascii?Q?fN1SX23cU/OYg3kK32gML4qxbM20xw0yEo2++gaAIbVbfUWEY2I8JapJHGHV?=
 =?us-ascii?Q?ilsfsUumvxEOAPhNsny9Wd16pqTYzozXsuaZ0YPHtlkKXjK7pz43Fq/cbBdG?=
 =?us-ascii?Q?nep7gy9YqSj/6BhgczDha+LxnJz3oUdfjk5XksqV1WOCfeSjdTezVJ7TcFaq?=
 =?us-ascii?Q?cpiOOkfUUzOQCDsHIiUXx1Z1PaTZumGEniRzaezi0eEk83d2++hYsrqHnlQY?=
 =?us-ascii?Q?BEPNCJFgWgupcfVdtGTeN2XvE6oEUCWuA4y/jb7ugNscManwrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57Qhrk5bvyDaooOFkmfRCW38gN/6eNMX/8ClxFGcA+u9R7lgRT6T00mP02TA?=
 =?us-ascii?Q?/VAsEyFTKcMQgZDBtoaUMSAu1YAGG2g0BSc5sqccaG8FksF05QF3BVjgJPkY?=
 =?us-ascii?Q?ZzVBwauywZ5CcNEJ59CEMFLOwBccLuqK48D7rkecs7+Mjt3kb6vwU47Pg/Fs?=
 =?us-ascii?Q?TlM6AkQkxL8YXNmK56D1JrBHfkBSoUq1+3c8K1cPygXiFfto+cZ+CEEVewRg?=
 =?us-ascii?Q?L8g8LRlE1Ks9UDTvlOmeyTvt3Shf637UjyWKcseJy3r6HWdpLBOZvUHu8x86?=
 =?us-ascii?Q?iQFJ1KMp7RFZyQqKbkCoCp8SLWCRPGG9WCZe55TO4HH0ppFGcTfK5PDB51WJ?=
 =?us-ascii?Q?BjRKyOwMhyFXqoWeysYapvFBkNzQ2afn/5IHnRY8BNmq7nQAJUfGb0sflNmD?=
 =?us-ascii?Q?cfLQ7flYYV4CktYIN8zNgh2+4MGSSZrqv2NW0NbFQQCYdZpaXgWmqaGSlfar?=
 =?us-ascii?Q?Dcp7ZuH42WTExLzWiqoJv+yKBMD9DOgQ32TrI17DuWzotfbFCvrLjolkf9pe?=
 =?us-ascii?Q?1oma725RcjGiz83iMyzCs2tnFpigq4ix3ipDU5g6galqv7Vhf7eHoPQwKJQP?=
 =?us-ascii?Q?AqyZDXWpO1b82+Jd3Ms9p2rPAHsiovonIfPPIISCvhwLKfFrffE2dzJiicVk?=
 =?us-ascii?Q?cif76kX0jexjCaETNly4STd7yO78eM91bezTNvhT9JXieUj+hxJ06aM3jOhB?=
 =?us-ascii?Q?mI1lVqL0DaQOgoUe8mWFbzUefc52qTlSJLWXEWBYBR1HttjOdJuQgCQHxe/O?=
 =?us-ascii?Q?KqXS28m3Nwf66QkjfpvTSeG3rptRrGNluE9uwd/CHPDWkRwKD1xMh8edb6eo?=
 =?us-ascii?Q?NgKOGrj1sMm3k0sXj7bxwWZu6sjIUz1VCSr0SYL0G1uxj9GCb4bDNFLzcbPR?=
 =?us-ascii?Q?2a771g1s4TyEKHhoXTxu8naBLJ1ba8o7l1ASgaMDZiXtiz0wWUFpKDUVN7Kg?=
 =?us-ascii?Q?821GNunaVyGx8tmRv2IuzLzkSxXVq89YbZxR0B8ChydL+8tcu8KEtF1+HcPN?=
 =?us-ascii?Q?lJ0EAmhHFecgup9cXfU++hikH7AOBeW8/MbEY0IBc5wBAM5I7YSEuIWgFH8t?=
 =?us-ascii?Q?P4RFcuyW5NXWNPrdQ79fZm/llsMrRa0FGbgfrNMkY0pYT9dWDZiEqOkxE4jP?=
 =?us-ascii?Q?dYzK6iWLozNiWXtttQrmnMvtrDiET45XcfZNb1Nt/8LD+4RYeWqePv1y9/wR?=
 =?us-ascii?Q?R/vFNatgYo4dRy1iTgPwEaRWcrsSrd7CDCqDtXZ6tEwWb3LhKWOH2ASZm3Gw?=
 =?us-ascii?Q?FuybUAF2VsJcbHkeh7pqBGyg/+K72ti7s3Csrob5eDs691WzA55TZesZi4Jn?=
 =?us-ascii?Q?93euOxxZK3NuUNXQckbGg8LWlZb92oYK6jh7YuX69EzNXumb3/1/Uf0sCztv?=
 =?us-ascii?Q?AIyeje5Lrjmr7NWskxsfa3x7Ftj0IBrR9OBQS0W2SA6NcdCEsR45/Gu9fRyu?=
 =?us-ascii?Q?smA5lCpc8AX5a1tIO2fWqAOles3Ob/FAvl7Qo/SqMrPOhLpMfImevJqB7lnp?=
 =?us-ascii?Q?0rhAsKeNBqg98WHMlO0bZjfwcrkQql59New05nhaEc3tt/YwsLQeXhVKQtN1?=
 =?us-ascii?Q?a2vC7EPMNuLAx/cIioAKxQn6PfQrut4dlU72VGr+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db94a0-8ad4-492b-9132-08ddf07c9e44
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:13:38.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsw5SebHvQ7jcrcxCwhfRJDt6BI3Rl2hhKqsa3YJjDSyVMcLK42go2HcBWFSNzGyGzROUR+nOm4vV3niTV53bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718

On Tue, Sep 09, 2025 at 06:53:12PM +0000, Avadhut Naik wrote:
> Add support for family 1Ah-based models 50h-57h, 90h-9Fh, A0h-AFh, and
> C0h-C7h.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> Changes in v2:
> 1. Remove extra tabs
> 
> Changes in v3:
> 1. Since ctl_name string is now assigned at runtime, group similar models
> together.
> ---
>  drivers/edac/amd64_edac.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 0fade110c3fb..804d3c4c3f14 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3895,6 +3895,16 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		case 0x40 ... 0x4f:
>  			pvt->flags.zn_regs_v2   = 1;
>  			break;
> +		case 0x50 ... 0x57:
> +		case 0xc0 ... 0xc7:
> +			pvt->max_mcs            = 16;
> +			pvt->flags.zn_regs_v2   = 1;
> +			break;
> +		case 0x90 ... 0x9f:
> +		case 0xa0 ... 0xaf:
> +			pvt->max_mcs            = 8;
> +			pvt->flags.zn_regs_v2   = 1;

All of Family 1Ah uses 'zn_regs_v2', so this can go before the models
cases.

The register changes happened in Family 19h, so there are a mix of
models there.

We could be so bold to say 'zn_regs_v2 = (family >= 0x1A)' up top.

Family 19h would not set this, but then the individual model cases can
fix it up.

Thanks,
Yazen

