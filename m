Return-Path: <linux-edac+bounces-3155-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6959A3C452
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804D33AE9D4
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1C1FC7E8;
	Wed, 19 Feb 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SwpZ0F7G"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502BB1D5175;
	Wed, 19 Feb 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980674; cv=fail; b=iz3bgwD3NN+LXnc/8EZ5oLErioKStxiUXcNqG5p2n2QAwhnLlf7WUFhS0zbf+zxuojhKKtQ+LjYvTLLHC+BQ3hZPMKSBSCnUJxP7ap55HZm2W3tTrrbgxX0zXumS69sHiSuPr/PAXY2+hxeNWArdnpzwWOkAAPCAd8tDS+Mjjgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980674; c=relaxed/simple;
	bh=hSdsb7ZeiK4YAjON6hD/AxYD81mVwTlFMrZAMHKTHro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5FLzWZGUrNI9tu4BywycR11o5zcdOaUaQ8Q9C+N/SRsd5+QSPamS4hf/pb25s4l3NbOUBnp0VjU5Th4jfzh7a0qg+LLOFclhWUFHowEq5/wnA1w3FVXC+MCO7u/ACatF6CwyWh2UtkYWraI2t9sonVBpjWgIbFZwQQ+ZGlAIt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SwpZ0F7G; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZO8TD89L2OaPel17GP9kzE9eMlV6wslcros3G6YJbL9JZ1B97HHBHT/QMeKe/tioKtAkebuxbmX1m3930ULQAggH4rCKNjD/ptIHR8eYimMp7B22eS0lZu2ipvpdpmknxTJIeJnN3rVnIcCrvgRkq+mhAdc1NxxF7w6jkFtYek88zCUTcG6cMRhkZMNQL0EwTDe2mLNtXCFTOfUR927Lm/gkZ3xzEC5KYunoHnzt66fxwwRgbzHSD1nc0XEh89UUeHsF6ayNUV+Rd+pkIxoUfQro8TPvN9j/epcVUkFZp9eIpJUe8gspcOIR7fygHMqljpcSN8stKlWevHYhXwZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZYMMIAEx6g6WwEuASLdppXZMjG6/8H4QW8RVr/QTGQ=;
 b=ykck39ZviQGKgCnhJAZnxSPZ2N8xBLCu5Q+hjgppWCwwbNyJt02/zeD0VvL1T/DngnpYVYwZ1fxLbgxabPM3zxQ+Mt/JVjpg+eCHPGTYPkQNaCj5Pc604t4dwWob3RDIQHbe0UVufuEwfpJUkLUZM8UIHyX8xBiKe0aI3tzLCq0RSJQR3SyTT/YBnPjDHb8F0JE/rSZALCffxgbtlfnYuxlhHWl7qj0labW9yJlCUtktDN3D89acmnN0giquZDAYbZDvFF7ghjtmG21HRBgVMmvJpgVhazbHSYqfoX6i98GntdguhXWY047P/NtRJ+FTHC0yzKBJ/DWI05DEeTEZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZYMMIAEx6g6WwEuASLdppXZMjG6/8H4QW8RVr/QTGQ=;
 b=SwpZ0F7GQBe+z2Xg8ROiDGoKzC+48y4gs1gPgDn2w0VZosTpDHbYOc1NwtUKOpsuYRmNaRO3gZl4JLsyw7VwagWdW/GnK/ZQr6HcQseJyee+caMSg3sJPDB8+VE/GUkudZYpQTNqF6BwVvzB0BBz2C8nYcQgH1PO/IgmfP0ybAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 15:57:49 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:57:49 +0000
Date: Wed, 19 Feb 2025 10:57:45 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 07/16] x86/mce: Define BSP-only init
Message-ID: <20250219155745.GB337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com>
 <CY8PR11MB71348FE4A5684E941992B5CA89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71348FE4A5684E941992B5CA89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN0PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:408:ed::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e01672d-d8b5-4c96-1210-08dd50fe28b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Do9DLGkyyKH+8MUp8hrnGB7kPjdOs/q0CtKToz9sm2gjP037GXWmQQrqfXRK?=
 =?us-ascii?Q?PcJk8dGLrwZZ/G06wIZtbnI0z/MbSGO0x6prBcbIl0PL+Vxn78udkP05omhF?=
 =?us-ascii?Q?LkagKFodO147WLMjycvRHja3yKlxh+B86vApP+CWdwqZR7m7b12OHgO4B8rl?=
 =?us-ascii?Q?sajnP35G/ji8mhc7LtOXdu9uw9aPgMci19E+L+pDc8V+jnjzI249ytXLlYJ2?=
 =?us-ascii?Q?O8LZns0auoHpqpIpsEP8uvZl1GU0CeJTSez8L8rJzlTP5ITu9Wjv3TQDoB3c?=
 =?us-ascii?Q?huP4tofeM82eo+VfQ1UqRXhDuipMRpX9+/no3DccAAob/MlUubtSiPUa9iBF?=
 =?us-ascii?Q?sMvlXGCfYhhNuukxFPOOa/ZtJkXZ4lC5nC/AUahyca/Cyg86Zs2gduvDRnwR?=
 =?us-ascii?Q?JD7/s/WCvDHwMHk2XNE8KIVOuPCGBxhoBArX7pcAplHZ4a3/1UCPgfPl9LPJ?=
 =?us-ascii?Q?766E/YaOHdtztiFrzNKkEE+OJ7WrVvvXRtWvfLUpy5+xsWJYXLYU+1B7LPCD?=
 =?us-ascii?Q?7FtXKKpib3URpSyDS++1oP0Vark6F+2zMwDmMyRjjDvaF7M7cnTML79+iOxY?=
 =?us-ascii?Q?JJDEYkzZM18TtnvpkyCcAyt5hFKJl1Vl/uFpZVJHzU/ggYsAcz9oyT8K+R/Y?=
 =?us-ascii?Q?Qq5n7tyTkcu/ewrVAY0WZ/y5hTYV2srFg4McKmdIWf9BNr9V/YNnv4PeMLWi?=
 =?us-ascii?Q?5zOD//lBEDw7hihz0TKIJJsJjviWVFT4SNyt5Bcj1x+8J1UcoOKDQT4h8i/S?=
 =?us-ascii?Q?XX9LC7UgHJyU7bF7fJmn/iiz3EO08QqC6Aupg74dFl+3HGbLmQ0xSWQ3aQzE?=
 =?us-ascii?Q?Tk/n11+8PUpDmDJq/vk9yWtQv0fYe5woBjN3zoOeysbFLZp6Y34JLBaDMIKg?=
 =?us-ascii?Q?XBuXno022/bsxM4jhTSeaxevy/diHDYli7xGbDjkkSqPV15s9ZU91gQgCrCU?=
 =?us-ascii?Q?mPizevrgj7/RZHjN/IVbTmEG7nAkuN+iWRTLC1RrIXHU6IwsENaAgBjbpZmT?=
 =?us-ascii?Q?ACZbjKCMNFXrOm+sHjKYZ/0A8d/+GV2BxvycxDmfINpi4V+Pe35DyBs/I6nN?=
 =?us-ascii?Q?STj4MCeNcTDUme2WW368ASxLBWrn/MAAN+swVE29gkjkrhxoXDpJ8mFRZcqp?=
 =?us-ascii?Q?ccr6c+HhcYtRahzCRxGlIqxjIk5/4reW4mmsmQvy2q2kR4wuigWL13NBR8st?=
 =?us-ascii?Q?bV5Nm7q+nFpIpJaDKCh2rz5PFJbch4T/VRgnenyakMjjm6l62wAOoClXOjgw?=
 =?us-ascii?Q?3rc+dEC1bJaWop5zLKaaUbcajIhUZGX5nqZvygJSyhTdOkbsukhpdrmU8Ghg?=
 =?us-ascii?Q?qOSMfA4GlY81fdu0aQaQojBG6bl+6NgH+9EX2PidAsxHgOwx9DPZv0CDiJTU?=
 =?us-ascii?Q?YP+lzLJcpbWZO17qYzDaeQK0u3ZZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jFoP48msgCNhnUfBEVVRUyOKto2KLXWapz/yA4WzhDfBV15BhMKD80yPphN?=
 =?us-ascii?Q?v5UesXa7I2mdZB8+STUkm+T0j2vJmjx+8S81mC39zqfBOy71YKQHiQA70uYy?=
 =?us-ascii?Q?AlKZcrUnMnGaDhdH1Mm03mSDk8BZ315T3iiSJPYdRnEqLyZjMr1OH5JFiyX+?=
 =?us-ascii?Q?EtYqpLCFc87EdoIXnruslHki4L+MjB2U9wK4tqzNmE5b4oDeFvoej5SjVb+9?=
 =?us-ascii?Q?2a45MuhdXxTR8UlwpbobMSPfUl+spekRlQjq2OglZ/jhq28d7cANPjpPntfj?=
 =?us-ascii?Q?FkbHVr8/fNPQ8fOnnjWPUChmbuTveLwmMX1kyLZfwV0Of6H6uoDN0FKNwndW?=
 =?us-ascii?Q?4K+wmVKhUdSaaCr9Q084/wqmGEKgJTm3uEk9Hc9iZHsxP/RDeRqK/30uVNFQ?=
 =?us-ascii?Q?02XO6iseBU8JBIVRyc6BTNUD18BXghwPaabgIci4aiPVAAo4QZxKIr95GkUy?=
 =?us-ascii?Q?ydHhkOZ5P+qqewsoCvew9TsCjj8rHPowIJ6FRYozDk1+2NJ6gOhOVMw1KAvo?=
 =?us-ascii?Q?b3WZWwUJpXMHwiOJIm7VZ2Y1cQZU0nx9z3f4dW0WauYwUGPuYhbQH9WrpS2O?=
 =?us-ascii?Q?Jw//m91AKJc/iejvwaA/r/FjUQI939jud5il61ceqXTbBx0BdBjI6PY++shS?=
 =?us-ascii?Q?VuWWZTfbrOKQPpZRuSci+7teeLlMOpEsVp6ARd0/AhimFp/HDcHmZUBu5KZ1?=
 =?us-ascii?Q?TX6o756CDtAleVTlptkc2ntLU2ZcXJdKGqdalPKcfYVovtu0pa/KmRgwiYhC?=
 =?us-ascii?Q?C1FPOHEPnCaMlI+TFh+bro/6ezMNH2ShJr3U2ao5J0el43nigS6+nTf2aZye?=
 =?us-ascii?Q?ynym+wHK+BxXPe86az1wEhNZ6Cl2BNNx9554CzZyyH+TTgDDf/ye/3Gn5Oqs?=
 =?us-ascii?Q?vD51UgdRvQ0w1Q7gf/23jyotN1FkWd/o/jyV4PQIIvYPoZFawrfzjS1YqlKo?=
 =?us-ascii?Q?BVAAeDJQzFsaTRzJqqmZ66sxi0bos0qshfDWTcuOQyszhDf43/DFHjPLhj+A?=
 =?us-ascii?Q?GiZkvsrR+Xi2aSXdCU/gTQdG0HPemSXanvjSkhaiwhDShZsy5n+7GWBvyefU?=
 =?us-ascii?Q?lZqKYRrg4p+aG8YCMQF3KGUEuzo3ImoJi1REzSPiGMpHujcbenm79sH8pOEP?=
 =?us-ascii?Q?ktnOgvEMsCsOu8C+PONkQQnioqYiD/Ewdcanq1r5MYdp2cPZGu8tUV4XP0dL?=
 =?us-ascii?Q?eKwr5UnQpt6ddk0q4MYuTVE9aGaDcSoJNhG0wvCcaO5YtWWgaWl3FhzpLkM1?=
 =?us-ascii?Q?OHaNSND/GKOxuPmDtpL8ti0sCSVzLK7gMnH3s8+CZDJdaP9vbkHvA+urAncr?=
 =?us-ascii?Q?lVISq7RrAwPaTMjJ9hQHAYJ5797HuKq4AtI4M2yYw8aWGBpVsJ5U249gvmrh?=
 =?us-ascii?Q?1n4CIsKgfh960eaQvbqJTjvFk3OBTvcWNhLTJp6D1m2ZuknOvUHdXc7v1s7E?=
 =?us-ascii?Q?HvmgCTjPXm+Auyx6kqlEyf3vAcJaVi3YDpDfv6ZIYgZO8LL/MtSEKKntKb9C?=
 =?us-ascii?Q?T61ah2rkEqPtub4IuHA2H+DrQevMd3XEXEqMRIbM1MHJyiBBFcn9ohhix2vs?=
 =?us-ascii?Q?03mvWAjkrfKGQddFiw838jP38iDzer+RmoAZekh7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e01672d-d8b5-4c96-1210-08dd50fe28b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:57:49.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6g5eOpG7BvEqAHXVy+IShSeSzLdqgH9conlFpd3t+UjF1wPtKK8yjloTBeW2bbBgn7NT75XJyh6s6sZ9e7zkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596

On Tue, Feb 18, 2025 at 03:16:49AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c
> > b/arch/x86/kernel/cpu/mce/amd.c index 302a310d0630..a4ef4ff1a7ff 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -656,9 +656,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
> >  	u32 low = 0, high = 0, address = 0;
> >  	int offset = -1;
> > 
> > -	mce_flags.overflow_recov =
> > cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> > -	mce_flags.succor	 =
> > cpu_feature_enabled(X86_FEATURE_SUCCOR);
> > -	mce_flags.smca		 =
> > cpu_feature_enabled(X86_FEATURE_SMCA);
> >  	mce_flags.amd_threshold	 = 1;
> > 
> > [...]
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > [...]
> > +/* Called only on the boot CPU. */
> > +void cpu_mca_init(struct cpuinfo_x86 *c) {
> > +	u64 cap;
> > +
> > +	if (!mce_available(c))
> > +		return;
> > +
> > +	mce_flags.overflow_recov =
> > cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> > +	mce_flags.succor	 =
> > cpu_feature_enabled(X86_FEATURE_SUCCOR);
> > +	mce_flags.smca		 =
> > cpu_feature_enabled(X86_FEATURE_SMCA);
> 
> 1. Before this patch set, the above code was executed only if the following 
>     condition was true. Do we still need this check?
> 
>     if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) 
>     {
>           The above code.
>      }

I don't think so. Feature checks should be independent of vendor, so the
vendor checks are redundant.

> 
> 2. Can " mce_flags.amd_threshold  = 1;" also be moved here?
> 

No, because this flag is not based on a CPU feature. However, I think
more cleanup can be done for this, but that will come later.

Thanks,
Yazen

