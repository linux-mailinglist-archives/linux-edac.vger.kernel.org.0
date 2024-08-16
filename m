Return-Path: <linux-edac+bounces-1658-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85170954C02
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C31B285E5C
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE91C230B;
	Fri, 16 Aug 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2WtEFQfj"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCA1C2302;
	Fri, 16 Aug 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817343; cv=fail; b=ZiD2nG+YSfAK8MhHKwLy7Rudi3OfZAjOjHfEcyEXKVrJGwNUK/HR2AnTUEOd0XaM2cUWKngxaej5/7adMORPtgOH7HUT0tMCcfLjp1E0X9DcTkRJASz1ayH0VU2k4hHTqRIuAl8yJiqqCjzFzz0fxB1KZxp80bDV0yJrOiFswZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817343; c=relaxed/simple;
	bh=c/LOiDcUmRDHSldYwbdfa7OLAEM6Vo6Zhdr/twU/xO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pcUBnxj6N9fhI3Sw3zwAg8OHs+8y0anSwkS88/bMbhgkfIYmB9EHiElhkvkrwTDsLmpr+58OeJdAav9IFWNpAnG2DkkEy1qUnBqrft2FOOCBkRX/shf/btp9fZZ8DJ5jaH/+yglXxLb+UMEW40Etk1f11p+3moJJk8NulkT+Nsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2WtEFQfj; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC2AspDBcmenobTzg6RIiLttH8H8TPuCUrBbKnGIxrEY31tFrqHWOOwZCLYJE9dOgYV85siEdKShNbM+f4Gw3cel0s9jFm5IrHrV/MeYisXyMhYfVdCr4M9N4m+eqbermVsDY4idEOFeUqhEoBCbjHaT/aySQs12iiRpskwuqjWWXi6YYL4Cu2eEZfqlbmbWFgz28olrcaQbwqlEg2t6wxm2AizVrGWvQ3/bZVPhk/O+DmYzG5vPlskfnrVjzxR3O5x9AuyTqa8fHvghhss31/Pwm1AEUadtwILtVf7wMTRC1adSnX5e+Jgd/NeAfMnO6DR3C9dJreeukLgAByf20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TqODEwF7rQIpCVMNRtVrQd5TmPlyCwQINdC44fiu+E=;
 b=ns29FflSZ5aZcV+ASCZB85zKOPlOcgZ80Dlz0coqjOmr7rtfQYnTVItpgf7pmLg3VFryboUJjD21NNEfu7KZb+D/yKqsfUsAV9+LFIgm8DAHPCcHEWiZ/nq6/f8avlSO3OxSzUi63oz7gY6ychlS4FDgf3BeJjwE2mFrizADum/SMWTxP83B9g5JkE/B1aGW7LZ0GEX13su/OoL2sVHONPEfVj+Zi+9d/Tpc2Eu3b3p0ZJ/5YBgbsTXJ8JyrAzaT2c/cutQcJLvuWip8zewhAZ7dsyU1u06rq4mya8z4MFugixFho4vF7D8NtZDi2PrT+gkmSqL4LIFGXf2q+zlhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TqODEwF7rQIpCVMNRtVrQd5TmPlyCwQINdC44fiu+E=;
 b=2WtEFQfjJ2aNyyhR3s8yilR3xLAWYGK0hQcSIWc6CGuyM8pmNpUtlWuDnraJPOwu9jU1FqhysPgVFx2RnMB2L8X0iQ1UbetMg6karytN4ZQqR84+eeYRM6JPCIeM72smGYY2ec6EDqgYBB26mwoJTPpf93cHoqQdpNFZlx4kgAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Fri, 16 Aug 2024 14:08:57 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 14:08:56 +0000
Date: Fri, 16 Aug 2024 10:08:53 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 7/9] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20240816140853.GB29375@yaz-khff2.amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-8-yazen.ghannam@amd.com>
 <20240604110528.GRZl70-MFo-EikWRHs@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604110528.GRZl70-MFo-EikWRHs@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0743.namprd03.prod.outlook.com
 (2603:10b6:408:110::28) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0f7c33-935d-4a2d-f5cf-08dcbdfcf7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BBHZZuCGK6QIA19Lp2YySxt7aBRlM/AlZDsLps/DS+go02yMrAri4I2px8fx?=
 =?us-ascii?Q?s2TR83SYuRtuS9mBnxLQlHWNeBgcJXP8WbumXfGZ741fpnTzW8Ci7cwBuAkh?=
 =?us-ascii?Q?lsuyReRY5Av3Hq+NQXzMs1775vDa7kGggB8sumrvG8Wce6+MGbCLtd83EUMY?=
 =?us-ascii?Q?i2H67nim3q5C6s/MoBeNQYiFWHTJej9HLf6CmjHNMbHH3kP/xNjxI+8X9D5O?=
 =?us-ascii?Q?dHVIv5Iy8XfLxWG5gQKzlQIlpifGmkqQmudXvDU5wzvh7oDL6kaK7xbW+B0h?=
 =?us-ascii?Q?f0B9ADKZTjMlwinhlcH6ZYf2fexkvSdyPEmbtIOwkT2fIaBwZrBTDQiWxE1Q?=
 =?us-ascii?Q?IqOcxR5Mj9VNGVfaX4asYr7OMjpAJkgAz4eVLMApNf1D9oWIKsBfWYzyr0yD?=
 =?us-ascii?Q?MLC5w82HnCFn21NOVGbe8tUcH0tDlH1qxIHaiizXfRduF8cA+MzgFwMA+XN/?=
 =?us-ascii?Q?Wm0ndYGOm9BpLX8KRHpBS94Fwne/gOYYEqZPIsViqkFg772ZABJzUnNbMKDW?=
 =?us-ascii?Q?cOmiMXCiRvm2ww/+ZhfP7+proCf+31aPgJgWkm27v9ATw4oHQkMLWohdLQwL?=
 =?us-ascii?Q?B0xvIgQJmuMlLdh8hlxw9GQzEIv0y0ivKcZGr1evrj8l7756GmmgGHjjF+Ai?=
 =?us-ascii?Q?mUIkAfV8k6AjwTZrWT5pFC+pqNXdlP+Kwqu9eXFmoGjMS29YYkU1JgNColH1?=
 =?us-ascii?Q?Xt+vCrG3CKo7JDIONoUxPkb7bePmT21IYPksPHfGNcPFUMwbZXKdzGQz1Eqk?=
 =?us-ascii?Q?SlSzixo7RGJUJeiSAJOYYKDwmvLUc4wcunvSnDIf9j9BU+3ZIqwymxYWdF/0?=
 =?us-ascii?Q?vkxnjB3PYPG8j+rOVNypxP8zo3JWHFWJmrmSS/bUjIw3oWUmLA8BTKiPtSJJ?=
 =?us-ascii?Q?iRV2Wd8koFTGbWJ1jVC2t/5kBca71TQXTp+MqT6vUIU6tRlo4MVCauGUBv/S?=
 =?us-ascii?Q?u6Bk/n58LsYwBvdI0nB94dPBMRl+Seq1k34T3ggl6AO66Iv4bwv2OinljCuA?=
 =?us-ascii?Q?ncbVwZZjokBTHKkTnAuarop5lw6KeE8ub/5q/heR4aq0/yeY8RMI3rpLIL14?=
 =?us-ascii?Q?ybQyyUpVQv9uCPc24o/mATSEMBeyUPVUandPXY0xLoFPL7zMnBCVH0rCakko?=
 =?us-ascii?Q?vFHK89zUKkt86yh+pK8x9bHXNZImTjHHGHwVDteZKL3jMJhtMRJWjsHXmgLL?=
 =?us-ascii?Q?w0tu2CwmpMbEWEfnE3hg7EPI85b1cV8W45gn95XybO+c4+BRWL7AfQnT/Uer?=
 =?us-ascii?Q?K9roJ3fjooKc5nd8+6CLOBcbuInE8OniYtvDSFXymGRKuLPa8rPSARrMGneM?=
 =?us-ascii?Q?A7OEpmZYyzYZe5tQy4DQo+6j0mOUDutEuaSgGb/8GRhQvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWx18IXksWqIYCPT4b1f4TLm/YpzIovCOAzfShq7DfWZQeBObQgpfdfxpCA7?=
 =?us-ascii?Q?sdABwF5FpVOLRTVydHqm7uFea7IJpxAnoCv2HQ3KtRFs13sJvOgelZjLPOR4?=
 =?us-ascii?Q?ng5Sn4/76P7Uwg804xIA4dpC3UfkP2y49o+nWGXpo1maJOzfLvQejMlWJnq/?=
 =?us-ascii?Q?AsTB45ISMSFzzmYmP/uwfGsZBHY+HoYKsBu6Jo5o9JirY7h+F8dUYi1YERuo?=
 =?us-ascii?Q?5DWRZ+mHjauHxM+89TM+kZvD4md74XQnNZ0WZ+2nnw6J6QBu7S9b/d5ueuyl?=
 =?us-ascii?Q?rS74H/aKbl30474dKg/xHcbdXZxqCU1fWj1Ey1T+UHD+WL7a65HC6xedDu8d?=
 =?us-ascii?Q?sMQb4+yO3NiVWaD/W92w3RD8b1digGF0IYqBQgcPoTK41k3wbvMPg8IqnIh/?=
 =?us-ascii?Q?X94Z2HDQz6c8Us34x0s+/YKa223mIaCa5yNIRpVRPp98YamFz/X1udoUR9yG?=
 =?us-ascii?Q?fJDBcBJFr6QJybZodkcrkPU8VmAGk37CS8th+x2krf/+MvjEI+m1JAJwz2xY?=
 =?us-ascii?Q?rQ69vUpN43ao5B4BACEt0U8LnveYG/F+dhiC9R12fnZ3FwL4yxe5AOIMuCsj?=
 =?us-ascii?Q?kmZDOZDwIxqvJfVHedCUgyyXB7uaIOlzhZytt2gwvGLzx0tkI9pNF9F3yVZw?=
 =?us-ascii?Q?oGZW9tAnEjI+Yb1sO+algQq0Mg81cFwrf3LeArFhNLBz0bkVk4P6Oy9/X8v4?=
 =?us-ascii?Q?cXrj/uJHXLydXGFYOREUT1JOcoc07SLdTxN+acogHRZL3Y1cPqNJFrTAZPrg?=
 =?us-ascii?Q?s0uk16hl/5jdI3bY9Yk4YBu7W4bIA6TEotkyO8XqmcRzcMHLKOhvMz6bMxoj?=
 =?us-ascii?Q?oSKDmrdvH0hZM7cR7rpSZ6zVHKeQml1CnSl2amv1XtJfZf7V4iOcj63jX5Em?=
 =?us-ascii?Q?Nk5vd1fJ4QzZ5Pm6wYG20gnSr5mM11MJ5AWHNRt5u8xMTw4JXHGsd4XQaFN5?=
 =?us-ascii?Q?pHZU0MMG0JlRDeevL6uytkJg3b4jrhKzo2r3WMuT3Pu9iDM6JZbi8smr5X5D?=
 =?us-ascii?Q?KvPRNxIBF8S2B5hwe8fIBtQzkDs5R2D2KZ27CqhU0FuacN5IWlEOlcQ96nf4?=
 =?us-ascii?Q?rvZqQ5dmwLZWwxCbs6eWTU+vWQc5hhXE06FjC0ZW/xIxY12ZKz2ue5AyWWrk?=
 =?us-ascii?Q?CMDfrht9df/BsBYdXl4rD8kMVyROBFFNThDS3Fn7te5qVz+393lMvdOGlcF/?=
 =?us-ascii?Q?8WW+8DUA7HPQtoZKS6Y373muN/okPtg+y9XmeSrO1amzEqVoTk4/Buc7N/VL?=
 =?us-ascii?Q?nu8X5/S7PLypueMWLpU3cW2cjpsi5P5laXJRxAccR1GLXIxsm8iOqHrJej8f?=
 =?us-ascii?Q?bWpVpTZHMNdIyW5WS1HYZcBK/+vBveVNSPDZRk4N9HEf8oeylOp+h6Oa08Dk?=
 =?us-ascii?Q?xzLTC/j9aAUrk5bVM4gF/rFaLj3k3fpj+jSZkzX32ltua8qjHrFeFvbwiOGk?=
 =?us-ascii?Q?DWt/fVQ9i078P0tuUiXRew+NykpOVb7rkwrziDkCxbbs5OLsCEzD0N+ZnI0t?=
 =?us-ascii?Q?8x4YdRGbeiCKZGGYkSf7a2qM/Rt9SsG4R9ENn9yexc6x5/dIFsvYBy0+RSX/?=
 =?us-ascii?Q?vNLDUgItEZsfojBvuvHvmMXLh54uKlwcw4GOdKsp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0f7c33-935d-4a2d-f5cf-08dcbdfcf7dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:08:56.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhdWHkiXoLNEONVzD76ACKgHUytMAsvsAVNZpUHhQvwIXwUb5r+Sj38fPUp2kgHc2NLTwLSAUSRELNqrclGFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582

On Tue, Jun 04, 2024 at 01:05:28PM +0200, Borislav Petkov wrote:
> On Thu, May 23, 2024 at 10:56:39AM -0500, Yazen Ghannam wrote:
> > +static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
> 
> That handing of *status_reg back'n'forth just to clear it in the end is
> not nice. Let's get rid of it:
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 0a9cff329487..a0ba82fe6de3 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -669,7 +669,7 @@ static void reset_thr_limit(unsigned int bank)
>  
>  DEFINE_PER_CPU(unsigned, mce_poll_count);
>  
> -static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
> +static bool smca_log_poll_error(struct mce *m, u32 status_reg)
>  {
>  	/*
>  	 * If this is a deferred error found in MCA_STATUS, then clear
> @@ -686,8 +686,8 @@ static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
>  	 * If the MCA_DESTAT register has valid data, then use
>  	 * it as the status register.
>  	 */
> -	*status_reg = MSR_AMD64_SMCA_MCx_DESTAT(m->bank);
> -	m->status = mce_rdmsrl(*status_reg);
> +	status_reg = MSR_AMD64_SMCA_MCx_DESTAT(m->bank);
> +	m->status = mce_rdmsrl(status_reg);
>  
>  	if (!(m->status & MCI_STATUS_VAL))
>  		return false;
> @@ -695,6 +695,8 @@ static bool smca_log_poll_error(struct mce *m, u32 *status_reg)
>  	if (m->status & MCI_STATUS_ADDRV)
>  		m->addr = mce_rdmsrl(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
>  
> +	mce_wrmsrl(status_reg, 0);
> +

I had to think on this for a while. The reason to clear the status
register at the very end is to make sure another error doesn't come in
and overwrite all the "aux" registers before we grab them.

***BUT*** the reason we are going down this path is because another
(higher priority) error *did* overwrite everything. And we're trying to
gather any leftover data. So all the "aux" registers are already
out-of-sync.

I don't think we can solve this in software. We'd need all the state
registers to be duplicated in hardware. We have status and address which
seem to be enough.

I'll see if this can be simplified even further.

Thanks,
Yazen

