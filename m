Return-Path: <linux-edac+bounces-3157-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2ECA3C47E
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846D43B39E7
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5C1FDA8E;
	Wed, 19 Feb 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QxxD9gPe"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733EF1F150D;
	Wed, 19 Feb 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981209; cv=fail; b=QlQ85HHuYkWF86uu8hGYojVu0EBYOH/TIVjFZVc8JN6yEM2CFVNKZrIlf7U6IzC0c3PviFAxZ2MGorNwxIVqIGhFVwTOo/ziVX4KDQ45bH0FdKncVYXFvLsK8ldsTj0FK3UW1i1q4Fbstrh0WPdPKtxW9zjpka/vLd1SfMk2oo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981209; c=relaxed/simple;
	bh=IZfKI+OtoKhPBN73PKRm6hp1+Q/Rb0NFzdNAJj/H4GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XrvLFOBQkjUTbDcoryideDBDZtzOya4QwU2fVAYOU0moxZe8s8CQYoxgGgoWBT3ORz4nV6rgpvEQ7aTecMt5LM8qRxtynka6cISAz2KKuUO978mHWiNqRRm6cMNN2rx8eoHYHd7M6zjqy60K1Xxmmv5gZiKCBLF62PmzDunlD8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QxxD9gPe; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puVStQfcEPNVO2jWKCQ+7BOITfEgyH5uOMIB9fj14ESBFQ2JQDaECrRmZrHsMKfom2KDaBFSJTl64kx2+LdIlszpaF2vspE2C1vpvJZofQ1xI/d2Ab43k9AbqSX1MjyvhmsKzDDd3s/PMBT17fuV6uJL4QxK8g1MxL0/ezgY7AXP6dT3OyB3nhrz/ITjPJp2xNufMlqWHZitk4PqKzBgV++7ik1EOD9O5Vm6bgS1BXEXn//LFrn67chTzUoSmYe9m9X15BGRIcDFd7bAkWoFlaPN/alda6Vr78+h4C3uSYfHWZ6gCJUhfsT3dIzD4l5+Km3hOr6Q26QXJ3f3pgIDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdyvwedgpZkWL8Sapq0h04++BuROX+BEizB2y/s3W2o=;
 b=RNm/ZWL0jixGJUczqmdnT340CvAFpLgTCdxYhV3jkZedtuB0gqwSg7AAIL3S5v8nFaG8WUd0Rn5o+G4a0qEIG8cc5DXRZGmHH769OndmQbWZNDT2RFEKUqyEA5uetxExFm7xhdXzFarS1ZKTvDzBdOQX59oaOOe9I3qSRr2DO7MAy+VwLoVoe+z0sVFRPexOZYQRLozzrBGQV7UmFiRQ2jKuphsZ1Xd2Yd813ZKFa8envn1vqWDT2G1S7C10OKdj2m2RX0wUbCVazMJThr5lUyfzSHJC4niZ+J9slqXSBuqDgpCNxdPuQGwXcGvhwK7riPjOlv+60nG8zOSMQtvRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdyvwedgpZkWL8Sapq0h04++BuROX+BEizB2y/s3W2o=;
 b=QxxD9gPeXouF/50V2PXk+0wH90j75XXPw66n3BDhV+cbGrtR/LZMHXjd1ylGhgw0fwjD+wUzCo+paDrKQf5JVy7xFya5AaZeEVNm7470JbHtwWLWpIvrKm8lRmUK+nGnysUXda8Sxe5gr9/bCpd9iXlnQOA8gbRiL2atG8QeBSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:06:45 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:06:45 +0000
Date: Wed, 19 Feb 2025 11:06:41 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 10/16] x86/mce: Separate global and per-CPU quirks
Message-ID: <20250219160641.GD337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-10-3636547fe05f@amd.com>
 <CY8PR11MB713455D3FE3A60DF09F5404D89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713455D3FE3A60DF09F5404D89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:408:fc::6) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 9407def4-5caf-4162-310e-08dd50ff67f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4JYuLf3C1y7qquAH5oNX9yeUhV1r8gFBUk1Kdz1lyMpXrz0vi0Qm1BGyIuT?=
 =?us-ascii?Q?ZstSx1OqCCGiHaDcx6ilKqhhkkpSN5LGiP6yeOM9H34BaUF4lMIqiTtPMFsO?=
 =?us-ascii?Q?+SE4voFd7KOuX0c5+ge6e42pt3PzSDzMy82UH328RwgxeXBomjXmAdw1tBu5?=
 =?us-ascii?Q?yD8wX9VUHmar1bOABXgw5WHJ/WDP9CRT8TLaWWzUKnDbQJmskd52S3RWsfaj?=
 =?us-ascii?Q?RN0goWau9OdUkkHNCUKA8SeVgLCqioHjwlV+ANPqfh2vDbiY5tvYBsn0l6jc?=
 =?us-ascii?Q?BS5OPdY6pz5zE+6243zlkXZE/Hvwy0qVW2DKx+TLYsJPIKmEAgCQmBUGeW/M?=
 =?us-ascii?Q?c+ExKCj6UFpVkypkVow4o8GUyiA+TbfrJC104bdOaH6ZL2s0V/BgijnSHUO1?=
 =?us-ascii?Q?373PJTWrb47PYZcGJOrnoa3TGEmefrIAvEheGiDlDlWfnBqN3mFIwcv4rpAa?=
 =?us-ascii?Q?FSUiUHmxROsy4xV4GMB3spoYPNsb6+ro5PrX6REg2MNGSy+SMfr29YYBiiO+?=
 =?us-ascii?Q?Mcp7eHTUMXoND4cczRjH02MA/VSagBuCxXbKNSdiDEI8VnkkwEbP522K+rHM?=
 =?us-ascii?Q?PUifDG/U5lJYnkTliYhCIiiET2Wdp5oWP/URgTIEM/Y0CsKQzPc+r9Hu85I0?=
 =?us-ascii?Q?Kbl2elOMUDDvhW6IW4wnScnLxvn7Vg6pkUVcuR37WYJCO58O1O8oG0if9+YM?=
 =?us-ascii?Q?4MBbKEAfC8rdmCHHv73rBMqb1q/2q5j405ZLrnOQkl8afWM27+8GLluXj9uW?=
 =?us-ascii?Q?Mrsm0BVle2SgamtV4eC14PZ2/BEgjZLxFN0v5ic/Lwo5uC+DZdvTkVTwFOrv?=
 =?us-ascii?Q?l9Acv91RLgXwrMmq0qowNO5rruRnd1z9VQMZrdG8zVCMvJwvRnn/fTVFJYY2?=
 =?us-ascii?Q?hPQ30oGtnCy04ZECUK4OiB025ahYdkmOj0hInr0mB/a5CBuzF97lfWvmmmRh?=
 =?us-ascii?Q?gHwXAXc3cvhtAgZ1tcI9dBQNM89xdFQtK5jT5zjaCjKPIYANwmVnmY604e2P?=
 =?us-ascii?Q?7By/dV43024kU3TfTwGFIloHBHJL4g/qo2RTlPnCQEfai52LDoa3ifLAT1XI?=
 =?us-ascii?Q?2bmIh71gnK2P0NmuMzRKqV1DQNOO7w1N9gqxFWrQFSAE9PetjXxY+gYNPEKQ?=
 =?us-ascii?Q?f63SYco3gzDaIGMNJXKTC9XvW2xYlk7G65xd5tcKweExGDFq/XmnH2mV5ulI?=
 =?us-ascii?Q?5hB8gdM1wRgik3eo77kAwqueYDQUjYRk2WL4Apa3h86ja1JbdTEhVzWK7hQ1?=
 =?us-ascii?Q?3c2DUHwRlviVJ+QVLZkvguDsyg6t9HdZgt5fqauPALuhzti6OAo/KZuds7m7?=
 =?us-ascii?Q?SAW0TC5bxCwhQbLz+ecASeHwVHlCHq+fGVchMkt7K3NG9zuMVFQWBKI5dPwm?=
 =?us-ascii?Q?pA0NodhufRIeg/AsAtRM7wkbanMn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSWP/4FMJNqcRQxKiHutHbvIxTYtREMpQVwygNkIqkExQUo+8ZOCQYC8P14y?=
 =?us-ascii?Q?k+r3nhy7E/jAVEGGQCFBBlCzE8RiCu13nbO5Qk8pTqVd8geo+RCmbi9NGmIo?=
 =?us-ascii?Q?WqDyaZjVOtNSra17+XPdpuGhWzJE4CDwITl2zSU9Y53KRLOFS8B2gEfZIkmh?=
 =?us-ascii?Q?0GH2jYAuL2UEzJVwfHMMtog4Ch9NEsPUUmu0r41dPFH1yi4UjbJ4GKrBPl8z?=
 =?us-ascii?Q?/3jF3DYEG/9SkwqImTUDw6tf5j/U0mjKI4npezd0TTJZD4k7ZWV3BRQ2ucTN?=
 =?us-ascii?Q?wsBgcJAuf/IKuuodws6sYyf4/qHtSU2dc1FtZfZr3y0BJW0CjgSU8g4R7uYy?=
 =?us-ascii?Q?OOvynXULTlvbG9q9R9X6eZhSJ0lLe/zcevNIXiYfM+h3SXRjrSzvAZn4EwaL?=
 =?us-ascii?Q?7rmjc5vZIUxuyp4DoqZFF7pGOe7Frz8zm0cjwxIDiC5DOPxiva9IoWLfaUlA?=
 =?us-ascii?Q?geF2jkxbMapnAlVatWZ/TG/QZvwuq0JRCbl0xj5s5rLFJlHaEkF0basyI0aK?=
 =?us-ascii?Q?4fz4NsQf4lnVg1VmzE+XN7CvNES/bUe1aEqXjhwPnAMXXehuhICnmLCeQORK?=
 =?us-ascii?Q?dPuFbCRv1zqKDzuSVTch9Wi1kwn8gNAHZJJa9LX1moAHBqfdcR34IoK+7a2Y?=
 =?us-ascii?Q?MlLObLHXAG3Bg43MkR8jEzXTnyY+nO6ukMqI8MPVwEk8mWAEfJWOmD6rOyqN?=
 =?us-ascii?Q?mnObwZUrg3K0AgGJgSU6xRK2vSYLNS9goPO4f8bNr2ZxDSbe0RcyGIy8MX3M?=
 =?us-ascii?Q?kWiB2k0vxkUwmXpM9V4FUyKDB3+BW38w+yecOUk9UZiugQpLlSv3BJsz9Zj/?=
 =?us-ascii?Q?MHlRQ0Q+5zIySFQYpPhgXRk1NrzSINq+uUt60LPqGPsQ01nPe0Hti/5chz5m?=
 =?us-ascii?Q?8D8t17PJBqUZXjcrSLxfVE/jIi6mudB4m7U+dStMxVP3qkEZXaISHxGxyc4t?=
 =?us-ascii?Q?aTU4fdV7KG3jz9/8EkronVSYiIUC7OueVCdrFoGMR9llPs9Y0I09QdwISO4l?=
 =?us-ascii?Q?CVvAVeXBDNY3M24qm4jQs9M0Befif/7udOgK15h293jLL4iNW6A2QCYDl+G9?=
 =?us-ascii?Q?Knbq+UBMXtLNUzKxFxFBqvtNCrfr7Y4cmGRVOokVaOOYNNIxAatxCweh3HtU?=
 =?us-ascii?Q?3IYXP+z/kwEvEe9u5ETgG1MJGTAC7dZHFKhzabwEam4tE8Ktu5+pU5tkzRT0?=
 =?us-ascii?Q?kCNmCyKs0SGqEnVQuYE2VOPyjw7pBOIQHBGjhUZfoyVUJ3tazxwCdJbEa6yX?=
 =?us-ascii?Q?a1WxUpSiS5TFLGdtuLtSI9GXBft1MnxTGtv8S6yJmNgsr33zMejwAR4B9XNc?=
 =?us-ascii?Q?rmFmFsX8waZoErQusBdHOZxeqXSntX/0cYti2SKSzdYIkiScazwiAMCywtV2?=
 =?us-ascii?Q?vv6ZqFfUJREsy6UJsmG214B51ImfcQ+adk07ie3MD0/DgkMwlx0PkdteH/lm?=
 =?us-ascii?Q?02EOHMel7F6xP24PV2x8K1+MF5ApLbKjkoSWl9USQoU+wHsmcO1qy1+jZTp2?=
 =?us-ascii?Q?T8V4/cQrzWTK7WPiJNHM1S7JbwZOLLSem+OLs/sdu4uBXny01407yKpDTtHz?=
 =?us-ascii?Q?fG3Win1BSskxYS7knsO/YC4gYwIhMxnJWK2+u+O2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9407def4-5caf-4162-310e-08dd50ff67f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:06:44.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKnCc2tgHuwGXiqhOhZAwrbgSJD3bZiiR0KBhvWurVOdYopLEZb8WS1DH4qrML1rCOm4LwoaZoQljOfCfsUkxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433

On Tue, Feb 18, 2025 at 06:03:42AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > --- a/arch/x86/kernel/cpu/mce/intel.c
> > +++ b/arch/x86/kernel/cpu/mce/intel.c
> > @@ -468,8 +468,23 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
> >  	}
> >  }
> > 
> > +static void intel_apply_quirks(struct cpuinfo_x86 *c) {
> > +	/*
> > +	 * SDM documents that on family 6 bank 0 should not be written
> > +	 * because it aliases to another special BIOS controlled
> > +	 * register.
> > +	 * But it's not aliased anymore on model 0x1a+
> > +	 * Don't ignore bank 0 completely because there could be a
> > +	 * valid event later, merely don't write CTL0.
> 
> Is it better to add the following description here? So that it's clear
> we don't apply the quirks for older CPUs.
> 
>     Older CPUs (prior to family 6) can't reach this point and already return early 
>     due to the check of __mcheck_cpu_ancient_init().
> 

I don't know. As you said, the older CPUs don't enter this code, so why
refer to them at all?

> > +	 */
> > +	if (c->x86_vfm < INTEL_NEHALEM_EP &&
> > this_cpu_read(mce_num_banks))
> > +		this_cpu_ptr(mce_banks_array)[0].init = false; }
> > +
> [...]
> 
> LGTM. Thanks.
> 
>     Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 

Thanks,
Yazen

