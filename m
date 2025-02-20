Return-Path: <linux-edac+bounces-3173-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3EA3DD3E
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 15:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2E03AA7A0
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC51FCCFF;
	Thu, 20 Feb 2025 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xCzMo4is"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB11FCCE9;
	Thu, 20 Feb 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062469; cv=fail; b=vCYljWgByjTz1w8pbMSHxoL0K3VccLtXXeyzS3/UhSH1VpOgj46u4onEs4Dm+GVDlecYuDJOJ8m4bXiGIEjoztGDVCXycCWTotRNfK7/ShtcjIbLXJUrk0XnkhCdUvOItiKnRyYxwxyHuordnt7yLNJMytQ+YPo4CIXheEk35uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062469; c=relaxed/simple;
	bh=06GrEMQJgWX+rEr6+j9PSWQtj0vTuSbp03WhtEEL9/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HlhsJKcaxyjp+yumvjnKVIQ7lAN3Zy5roEM997OIX4rSVgB/72Y4nmG89qH9+CIH5wG4OUxyd7sSsdgLAd4/imRB82NqjC6HLPSpqHPklIImmXg/RoXc94bTl7UZ55bLNmlbQOlAkqVu/6wEQV/PPUrCMdXKiQFNgm+AmBVzMSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xCzMo4is; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNa0CAeFcjHMKMbXyTDaGb2MD4l1Gd65YoSkro+cnt/eYkG5JNHfrmdvm9vKi4ncGxIJn81+YbVG9m6j5cjYQmOypbC4Stht525Rnrc3cDuKI56siiFZGY8Td39+Ym7KkMX9N0Dlt/EzogvSGw+gL/jJMn15zzEhyfhD6oZA847bvgGZPABv1F7KaJ9Wd2kQBvZ0OV13RuDJjxCBqJZPT1YGdmmnPFhbRKXAlZqWnOCL0e1pYPM7wcpcTR0SdRpVFWmWcF6hZWdRcZJ3aQSQ/bc6UNueKJQVFNIVib5rnYVGQnZpWaDWfO0lSBMxpSlhOCXZp+lcHqaPjjhgDMJDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+OboyW36tKp1+u54vS7eofH/Jqoqw1UVX5/Lw9hpFg=;
 b=hsJ8pungBlOxLVHH8DgbA+/I/9nXbJdCu9wYHpyu4gs4f2uebvSclSOZDO37qWzK7j83i1WYO5vBuYgNP4n1XIDuC43vUSWbEduLXIZTAbSzJ6gft1OBj1t9A2PVxqET8vJpBm6nAAxLRgBKjP7fcMHu/bvQNmDgerd7aqCNamOT2H2pNpkek4SyUBF/tTYlPy/3VyptLBnysFgPeZq8rfZIqh5kwg+CXA2OiwOYiBWH2hbYhv1siWDI1urDUMa1pA5lvn5kwLNzbHyY5xvQDkcmReFqpJMNSHdPJySjMgA9IGUapb6JXDbms03q57dOmEQCipkwf641XX9rjWM+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+OboyW36tKp1+u54vS7eofH/Jqoqw1UVX5/Lw9hpFg=;
 b=xCzMo4is6ESMIxfmaQ0Gq/SDTuOQL2K9RfJelkMUS1qZqoJl1y5Y4i8+1iWm/eL2TUaCzUxQNG5cx03grZfiuJPA2VNea+JhQedKWAxZu+22DT3cma4dPEy+MYqqDLjQwB5RqObfO8eP1aRXmcgPKU67MCUELlOHa+jseeTO1JQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 14:41:05 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 14:41:05 +0000
Date: Thu, 20 Feb 2025 09:41:01 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 13/16] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20250220144101.GD589698@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com>
 <CY8PR11MB7134EE8E03532382B8FC23F389FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219160930.GF337534@yaz-khff2.amd.com>
 <CY8PR11MB7134D8A672FE9F10305546DB89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134D8A672FE9F10305546DB89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN7PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:408:20::48) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 897e061e-728c-4ead-573d-08dd51bc9ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rtfl7ztr1gNQADF80oW9gpKw2M6Me3QqCld2in4hMg8tfiacvS/gBXQlvObH?=
 =?us-ascii?Q?ev6M7ko5f1wODEwEobTN7M+KQpaChJY8Q30XJ5cq53A1pHKS3pshQ3P4ZFH0?=
 =?us-ascii?Q?w48lzMG5sWsu01jFiL2M6XI8eojQ7dHHcl31u8PbTMkAXl0uTaWV/g2lbeQb?=
 =?us-ascii?Q?fS+zKWhs8SxA7DwkheLVYXKh8LmPtaeuN6zv9lJiWcRuZs7ioIlffY8YAS5N?=
 =?us-ascii?Q?aB6qjekI42e8SONv0IiL7XaWYjoQ0RMajNnO0p2XvJFcnImJCX5dTm3D+MMw?=
 =?us-ascii?Q?HLqCve7t5e9+lpwgH3awN1NmYZJn62ah0KEusV9dmYR7IxOJ+bOW2m6Y1dZG?=
 =?us-ascii?Q?+iUALYu+ADvkSU70wqpO/5BfrRlnEAcTCUwWugCjYRUIfHKLZtQeAtsiL27T?=
 =?us-ascii?Q?MvWqacf65exDB8CPpqY8859/+pWl1gMNECKGkBNwbeOLiSunZZ+AW8s1Xfpx?=
 =?us-ascii?Q?4/IOefxpPmk91IiytZPINco8ELu8fdElhgfT8EcYOGJRyMLoycnIXFKf3lkM?=
 =?us-ascii?Q?4Pex8oVbmy/6uxmisHwA4FUHywT5OyRQ+7GxRx7m8YAlg0jEilVzg/1tBeBI?=
 =?us-ascii?Q?WXazyClmJOOIUQHUzsJCNhBGSJfRUt8PtQjENqhlD3cPRnSeu6zu6T4lba8K?=
 =?us-ascii?Q?GACCbNdLy5Uyjig9qHhk5ZeAYeraCm0FQabc9upSNSbeZCLbwWnKEiCXQtmK?=
 =?us-ascii?Q?Cgyh9dGWBZdeYx0TtvXX9B808S9gBktGKVy6zaD8l0zJGS7DAiNoTokm3GMc?=
 =?us-ascii?Q?3gQ677jE5vT2dMVh2pXll3VZU5zGtT95KDQ/7BRRcMNPqdDXGXdtbJ4WrWC3?=
 =?us-ascii?Q?mMtHfp9xHlq3pVq0fpRibtGUe/9Mi7W5X3/NR1k6YPItGAJE3pzZiSRwzzts?=
 =?us-ascii?Q?g6ybaJxfIyGRJj5amHSElWOZksL5mvvj1xNvGPy7gtva6LRh+iMmiMENRU8r?=
 =?us-ascii?Q?oPLxIZTxsy+pm4tjzJetL5U57eEA/X7jNVJ0az8OhLR0TZwkcJLwPlwGFFhg?=
 =?us-ascii?Q?WTtk8GU0WdtYm9WFNDCgFNEtdsOsQFvE90zLYojDxp6+IVjN3Ab7jnlgvtUc?=
 =?us-ascii?Q?5JLuO93WjfbdLBOpDU0UiuZN8lDFaoRZ9qwFim0RyU36NV8yDS5mGJ0RKwoV?=
 =?us-ascii?Q?CaDHMvelzGWEF94shEVF4Ptewz9xMrENw2DslaB8cNwERwQMbwnq7o0FTCH9?=
 =?us-ascii?Q?2pzI5DUYYYcSciIaTHNgRJwm4vXiY9eK2Qxj4WeyHgv1V56CdEGIU+1X71/Z?=
 =?us-ascii?Q?27pxhQYtREmTFrYfDQ7IFnZ3GjMndm/lNSSZjbF+mODU0tk7Vxdk9l7Gtz14?=
 =?us-ascii?Q?tMWUCwEy1Zo8Z5ZIKXpKwWYNWySc+KxaABo0wdPrJGevCRGebwXrDXASqhxd?=
 =?us-ascii?Q?MCVB/k1PAOu+O30lZUZODhp2u7Ub?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ffmyrexk+d2HNUIH+ehwNE7FQ0B8GKrMNf8JhFQ1zYSY5vu+a/1lV7YgnG2N?=
 =?us-ascii?Q?veUKq5wlh1Dd/hPEdlbIunRngxw1gkH4GnMyhU0IUWzZxVRiFxylLbCHWrdz?=
 =?us-ascii?Q?HWKmF/2qxdVH2D9qgNA6t6RRnBAosma4rZJKuQeYZ3i8GRJGeMpygYeKTP47?=
 =?us-ascii?Q?m1Pwcrhcpi+Er2Z4AMfDWlz06ayIrdRlJL2x44L4Wz9cEjG4MhIRDpvfXypS?=
 =?us-ascii?Q?+LbrLc0cAF4ohbIEvaOI6cGKOd7a013kaE7+qjtNZFYL5IXj7/rlZrkprxS7?=
 =?us-ascii?Q?8K4b1EaE09Hvs7FtOWiYlG4w/E37ls2CvqMfmu+I79i3p9ZEDSreTJ6IvdDD?=
 =?us-ascii?Q?8Yff1lF0L9VeqmVko+59VQRBLAV3zgPT34bw8GLFZFebMSLXhnhJJfENyO1X?=
 =?us-ascii?Q?D/rIC4n+nP8lyeN59mbB6R4lAnugLAwDk7HYb/P5HhTfV8/eCWGAiJStXgd+?=
 =?us-ascii?Q?RYkGz3cphPUqadWsa2AsnM/HBa0y8psDM4BFHrfEFbBKKjQ6QEzKEjRPho6v?=
 =?us-ascii?Q?iQfrIy9yA54g2/Dw3EvV2xSlxb0I7xRFq9jD5kzx0dQYb8B49NEjVqIP05wu?=
 =?us-ascii?Q?ePDE36XD0SjtKKPf+A1NkYrSuM5o8yb8hYNUIB3T1LRHMlG34dkF19mpyxJM?=
 =?us-ascii?Q?sGfPrIQ6oMNG9LK4c/yPKTqUHFdXUErWR2A6ze0Bysqe3GZwR4HMzxj4OswJ?=
 =?us-ascii?Q?j+Oo1WBIsCXdLRdo1DTkuoWA7mjSea1vVH0Sg3JJDq95DNE3igi2pbxrcz+h?=
 =?us-ascii?Q?TmaAILTdW+hd3t9EipbskPoDmZ5ZfOmU+2kWkBTlnn2xkbu9nfi5mHSkW2SD?=
 =?us-ascii?Q?8l1lOUmBOiayLtYOCx0/5ekwMM9pr92wufSzeUuT/2zVYEJVQM6saID33Kh7?=
 =?us-ascii?Q?8cDbcWptFfOIhNzfmiTQFt13C5JZ1i8GUFCEWMfAdDdr0Tg1xzsSoKrNs9Kz?=
 =?us-ascii?Q?tm+VHoMUl44Hpikd+m2jLyAyGOaP3TwP4PzHJ2LFOC7TfH30P9u0B1DpCV63?=
 =?us-ascii?Q?kpRAtAeE3sGSoIN2lItqlAUl3H/rJpDUkYq2yzyjB8thqg11mKg7okS/N1MD?=
 =?us-ascii?Q?fUMqLAEctJzq3o+C+th+wCwG0fJMElkBaEMEmg7+MYoh+Z83PnojlmLr0Kfv?=
 =?us-ascii?Q?sr3KgvsbgSUlz40C8uZ4eBng2OEQ2KB1KoIpk+YygCWE0RnZTAHL1YIraXf/?=
 =?us-ascii?Q?4FXMZvwsy2RD+ZJlyJLCtBaS+85p9YswJOA1OlzLfOXWnM6s5GMkaowvVlLf?=
 =?us-ascii?Q?mLEtg9Qj5gDvVilnbLAYgTbWN5pGMdRrgLV0/SCk8UJ6gie8RpazFHM0UgVY?=
 =?us-ascii?Q?/s/16g5cujsEVuEjRf3C7XANmy3aIe042Sjk8x1Q3E8VB6+JazDfU137ocBu?=
 =?us-ascii?Q?YPIO7EVujaRh7xnBXc8d06xCGxdY5dgQVRf2/cClEZxUdVo6atdw9XedG4Wg?=
 =?us-ascii?Q?OP9Beb9w3hlPuFu2WebKEZhhSV1xo8lua0iDPjQvZL444o2aZfzZpD7Glulq?=
 =?us-ascii?Q?fq2ZsOfZekE3UQ22YUoWmn13ZM9lOWRCovKxq2G7Yud1/rBwY70lAyHJlNbl?=
 =?us-ascii?Q?6urKHn6YihedSlNefCdcxPjNMMh7j6ip7Dg7ag15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897e061e-728c-4ead-573d-08dd51bc9ae6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:41:05.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxV4rBjaMdSboUV+W8DwgC8qHoo4z6u6L71CvV6xwT7966pl/J3zzncTy+Un50gqRsBrdXFoYHlZDdcROXhVAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051

On Thu, Feb 20, 2025 at 01:41:21AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > > Is the following check in machine_check_poll() needed before
> > > queuing/logging AMD's deferred error?
> > >
> > >        if (mca_cfg.dont_log_ce && !mce_usable_address(m))
> > >              //Just clear MCA_STATUS, but not queue/log errors.
> > >
> > 
> > Good question. Deferred errors are uncorrectable errors that don't need
> > immediate action. They are not correctable errors, so the 'dont_log_ce'
> > flag shouldn't apply.
> 
> Thanks for the explanation. 
> How about the 2nd check "mce_usable_address(m)"?
> 

It's not relevant. We want to always log deferred errors since they are
uncorrectable.

Thanks,
Yazen

