Return-Path: <linux-edac+bounces-5264-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B99C20694
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A413188D45F
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06324A047;
	Thu, 30 Oct 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XVvy77cg"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3E21CC47;
	Thu, 30 Oct 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832128; cv=fail; b=QwZQdaS9Mk7fqiTIudClTors5h4xFovRu8vEHLc0+Yfm7TOsM4kJJY/4jOqvNwC6T02KH6XdWUodmqiY4wuSwX8ZwUt2omiMKrTzpnvso0U8CtFFsPNXZVNeLSMdHFjJ/3tt7ARuu/fu5OLAzCQrDy6dCVIUNohrEWgw6J7GOgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832128; c=relaxed/simple;
	bh=8/0uoMs4KnT1AQXJZEHLjagLWyClDyTdGWN3NDBUGFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n+yR0Zf7wFr226fpq//Tt3Dx1zt53E6AD66dYFHvYOxRzaab/GVbALvAWi/xrdo0G+MYYH9OmYIqbpMkNNDHldh80ASVxlBYHxtHIlCv8565XzzNrpQW0dsZzfq3F+/q/NsiVw9UmMzm8cMd8pIeLpxNuZU11LtnJOZXKVF9bR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XVvy77cg; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggfbVEiyqGVZ1h9V2FsMv6KTcPZl2v0xx5DDImYPCZkjkKuyzt+kI+heECSqXzx7TNHImNCUKuPgXZWsikvmUI4pm+pY7WsgfvPYB3oQeHsdulxpgCiWa78A2VLuyG/jZSrX2L3lfdquk1tUUh2347cU+e34WgcIbMH2DFyF6Yx8b3+hfBZa7u7KChS5p+2q75YFKHToT9zTl7RrMLqMd9WU4XOdVhX4qGtOsjhwX4f80aSr2c6T7dxoS4K8ThyXdjtGCbGhMncryZLp9Phap7CvaFnvXp4wDotaptXx87GPCq55A1bbh0Yh1RmoYuUOIBc2BjIm53ahu/SuOlqjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP8wuOB1rUMXokSy0dr17/cGHHyKDeBh3fPveGhGOH8=;
 b=laAa3sQbiBGzCZWZccOewPqRUPfqz4eyNs4EIEfrCZDD3RpPMWZORa6kjJmCZ+6yYWknjP5nCqLXMGwVEN3wL6Pua9Y+SvTI2dj/gJqjJO4sZYlVgQ0gL1zxleUqmb05Y1kn76NFu5YaBzq6N+cgS1XEYLM44xBCMKGz7DvMlepUOxGqFMdumPMOhUkcBfZs0yeAsyfjVYCu6V6BoSre39/N1SYBxw+RHWAhiZRiy25JmvV49Sr52ygaPCib3UGNM28ZXhkP0uJJEbvL+Jitw26rjoz8tHZ0muaPE2/RhrnVYgV2WHt23S10jQ869EwrvkPpzRHTjuVS6uA9sRE8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP8wuOB1rUMXokSy0dr17/cGHHyKDeBh3fPveGhGOH8=;
 b=XVvy77cgbLOdAbBKwtblc9kHGcM4hGEEaqAl+3Z2Z56Zev5SijRvQznUS1bbuqoM61BcVm6Ed9H+z8pHn6IMgYQal+3jdW2wFzw3x3nAoDpvPjv0mpHhsJ0l6a80NJWk8ZMKNhrtauIh2ZnpK3A2iXOQP61rQOpwYOuyWI696Zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Thu, 30 Oct 2025 13:48:43 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 13:48:43 +0000
Date: Thu, 30 Oct 2025 09:48:39 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] EDAC/amd64: Set zn_regs_v2 flag for all AMD Family
 1Ah-based SOCs
Message-ID: <20251030134839.GA3209@yaz-khff2.amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-4-avadhut.naik@amd.com>
 <20251029171057.GFaQJKoUUKI_VM2GXn@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029171057.GFaQJKoUUKI_VM2GXn@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0904.namprd03.prod.outlook.com
 (2603:10b6:408:107::9) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b545d6-6c51-4f2a-348b-08de17bb0a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LH3D19DdXzVvEdhzeh3wmJu1cP9+VQ3Q4AMLty6ez9+OmxaGUEv8b46hG1Gu?=
 =?us-ascii?Q?Q+8MtGrOfAMb04x65jBsrbRxbSVNaYKyfkFdxuatGDReDZLMXaOxqHEON7LJ?=
 =?us-ascii?Q?W1W1UL4RgpMUVPrdk77TWxH77rLvFodRnxNi04z6pjAlft86+O5dnPQSr+YY?=
 =?us-ascii?Q?LMQwmNnPnJ2u8QMI2JXaaybeonR72yp6Y+63N6casg9jjr4RJ1U/yA82Dz9F?=
 =?us-ascii?Q?b48Qm18jyERoJmlod4zCRrWNTiSq1Bxkq4mTBWhZU9dd2go2tIzhCTs1IBtO?=
 =?us-ascii?Q?GtFPFx0POu8R4UWsqx0H77R9plCPxdkrOZ2vtqH9FSesh3FKv26FT5pa78vE?=
 =?us-ascii?Q?UiaeZyvJt0C9dJCOHHwI5cDYKjx7bcRU5WIUpKzLuz2GYRux0Za67yie0SOK?=
 =?us-ascii?Q?dGnRkXq+tmhSY3sd5QviM8FOOyTuU1frnYB54YlXS1uJyCePLO5nr3q6Z5u9?=
 =?us-ascii?Q?kBDVNeG0aanxf6mlFSXa1I5Z9iBMxYaZj79uIfNpldMZ2oNO4PGT3Wb50ujt?=
 =?us-ascii?Q?D/gKlKCjZ78+EEprdpnWXvI6/RKIWEq1H4pNIJTGudZVo5S6ZnVT8BycYjUo?=
 =?us-ascii?Q?bc15VNRdHEHU3buUdkRLTrELHwrKwRX2iLlufJ1mY2vPIDZcbi2AcMyiZ9Bb?=
 =?us-ascii?Q?f7eoZ9D3B19jLpiQet1TyFZOiUP96UjatABy5bu/SkYrhiqUu67jqltsWRRV?=
 =?us-ascii?Q?T2pnN2osUIJCxhg6a9TFTzOWYtC4ripoL4aTrojooVTwy3z/knbwLB1cjUjn?=
 =?us-ascii?Q?UBAYWteKOLpgds61tNEuG84I+bLuRiHJjNFhWluxrFUjisX7lry2bI/d6+qZ?=
 =?us-ascii?Q?P8ztNdsY+r2m9NwwdvHjicAYM7g5PT6ItdbWkkBNX9INMnrTjwXgHQ/bak+J?=
 =?us-ascii?Q?73QqJn6UKm4IpsVWCB/IHX8gIBLDtHJ31QeC3EcSnwB0mLa5YP2TWkZrJPgF?=
 =?us-ascii?Q?9my8GTvfMU+l6ds+TWsARX7uVxmsQ0/XY6Fqk6X27s0wtC9D6b3wp0grby+U?=
 =?us-ascii?Q?JWXYiAWoAAVV4/d3re0XXj2OLmkFkSKVTOVLg2QLc20s41iObzyqZgNcMJLz?=
 =?us-ascii?Q?T5fz+nYBF8CDvaJNEzBhDQNdzRNMLAFT3fmEVktk7jut37+CTjoJDd8Hnfef?=
 =?us-ascii?Q?t+TSzXgqpoxHyBYcLeD/C+rYB7CGVfM/4Q/iS2wiFBzfhGJb9yTROEv3vV0q?=
 =?us-ascii?Q?OhyHPHRg8wD5NurbHfm3lDBnoua7BpOVrNip0lC7n7SuyCnC3bqK4nhunHcW?=
 =?us-ascii?Q?Y20hNVixP+iP0Olr3At6AVfIsrS3XXFeYBj4uPqvUjZDOMPjqQrBiPKAPJNr?=
 =?us-ascii?Q?zpDD81dbE87HaK1Chw2vVsym+b+88HnkKXU1BfzNkQwrBjfXgi5KEKwf1Ncz?=
 =?us-ascii?Q?x23pKmPU0FuPYmuMcNcP0a71zFRCyyHFy4yLj/qW5nz3HEydt9Y6lwoLrP9P?=
 =?us-ascii?Q?h2GxcURTpQUNR6QIMEd9jxHwEg+jMFfI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOKz5ey3YpJlhgXwsOiyx03tE9/r3Z/LbFRcaQyeiYaQCPDMNPOtzY+np46K?=
 =?us-ascii?Q?uTao7fgGso0IWRobLklRFZKhYhglHNP13yyiVvAYQGYiMVcWKNJmtenWnTeA?=
 =?us-ascii?Q?PBJQcX6iZbwduSzKztwQE7LsfExkTnw/4v0Wzo8sUzQoLyqgr4Ykua3lESkz?=
 =?us-ascii?Q?381M28jTNCzZFX0vdsBlzTStxQFZ5MFsZbD0MlavXLS4SVKfALAGpVFhn7GL?=
 =?us-ascii?Q?jnR1LMrEWqmg9oIMczMPibQYLL2O8K5FesHFNqriz9e47vOpYmTYXb+rYOoH?=
 =?us-ascii?Q?lP+wgReKzi1VyivpJ8PGwmldUxJnz1Ps/tfeLkGuwNAkg2AHhw84Ot4oRc5d?=
 =?us-ascii?Q?CKEQcHThkcle/nPVvdaqhoJHBt3DeFzF5qSBXLPP1dx0W8ot8GktMkDwe/uR?=
 =?us-ascii?Q?xzb6SHgK/F1gAfJKJg/WagIqZTDmsYv15YkGo1CzoibiMZ8BNkwVMHDI4nPb?=
 =?us-ascii?Q?qH+zuL0oMmtgDo+AzwxAwsvoFa/Z0Dk1qNg6xulQjbIlKPoGTzlULhgl2pPP?=
 =?us-ascii?Q?bjarypaCzmPe6tgJaXjvscMIX7/V4L7srbH1Y9f2vb52MErmMc9bBvGAeTfC?=
 =?us-ascii?Q?4ww9c3WSZ6b8eNfPBtYp3AnBb4i4IiudbrQ/CpHvZSlhcDia55B3RD+l+WIo?=
 =?us-ascii?Q?5JJHAjo5JRc1DakTPK3y3a5RbXEFcZTBahjL8Ds0L5hnNotDTyijWYle7Rpl?=
 =?us-ascii?Q?gSq+I+qVeVz8phQZpRV4VoPhuxxgn7SWZFtDPnE5VMynkJe+aXQvo/nePfkr?=
 =?us-ascii?Q?PPta4EBL3l4Bk4HxE6io4rmtfS16W4QiDgdv3yC1NlfF5KfQxJVbSKeQAwFz?=
 =?us-ascii?Q?4nM9FXSB4D+M5WNZs6yrRz4/b8I+McQdnzMTUrIHflxOeTZh8lgXMJNo9pNW?=
 =?us-ascii?Q?Q8Y4KRldcaKa1LFi6/7rxX08T5P8hNQPJ51LxPmXbhxNsCG5bBMiGgERZ6OU?=
 =?us-ascii?Q?AOy5LM1auM6w8lbIyBXZBBK6oEZkys00PwA9LqsxeXYgbITguPzGrrHuwBVe?=
 =?us-ascii?Q?IJayKg21ebgmtMoHFl1EXP7H+20y10vF2qS6gg88EeR8Q1dQDlYeSfoax+f2?=
 =?us-ascii?Q?YvoDRp7x4gkmnJQEbCJz6MBVETKEUT+nMAmRl4D4tD+rkjzzEyCw0Vz0bh2F?=
 =?us-ascii?Q?Wkak/8MULIPIWhGcySoIH74FCkJUOhQkM4JBTl/AT9nJlHo4Y5jwG7fEYcED?=
 =?us-ascii?Q?LFb9tiHINeQwyh1+9a7gv78c4e1yfSOrFc0P/KiPFW8qSsJwCu82KSqvbyrw?=
 =?us-ascii?Q?GPhl32lKxR5dyEDfD/hG/WK6rJ2ZHxJYT0WenoOWL8o9jx4Rt8Nvo+lKqm4P?=
 =?us-ascii?Q?g5LXmUfEw+TmJ4PzKnzdMV3wrtxtIOr90oWQZGQNtIi3/XRHaV6qRihMGQAa?=
 =?us-ascii?Q?NjTHLbzUGDdzpZL0wXnhyOqJCD+1PcJCDqLOZSHgRUTVH9OubkWJ21s/ttnx?=
 =?us-ascii?Q?G2XBu6e7e55JZlU8+gEN2ViWpprhYWJTq/gt8ldrkRSwC5pPxcmAkJqnJrxM?=
 =?us-ascii?Q?h0Xf7rUUosjyAD4Vhm53AkwS7usZNfekzRlTgN3+iUI04CNGh+K433mohcI0?=
 =?us-ascii?Q?GBWtFH6tvHZhA2pPPscpAs2l5RQK7fbLwXmZRdED?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b545d6-6c51-4f2a-348b-08de17bb0a32
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:48:43.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9+mJRB+kpFS4vf5Y0Fj6U4qDKN12arlbGhHKMF/9tq7C4SZBmnTv+wYVYxCHzyKqfLkZo8VomArLgmxV5t6KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

On Wed, Oct 29, 2025 at 06:10:57PM +0100, Borislav Petkov wrote:
> On Mon, Oct 13, 2025 at 05:30:42PM +0000, Avadhut Naik wrote:

[...]

> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -3779,6 +3779,8 @@ static int per_family_init(struct amd64_pvt *pvt)
> >  	else
> >  		pvt->ops = &dct_ops;
> >  
> > +	pvt->flags.zn_regs_v2 = (pvt->fam >= 0x1A) ? 1 : 0;
> > +
> >  	switch (pvt->fam) {
> >  	case 0xf:
> >  		tmp_name				= (pvt->ext_model >= K8_REV_F) ?
> > @@ -3887,20 +3889,14 @@ static int per_family_init(struct amd64_pvt *pvt)
> >  		switch (pvt->model) {
> >  		case 0x00 ... 0x1f:
> >  			pvt->max_mcs            = 12;
> > -			pvt->flags.zn_regs_v2   = 1;
> > -			break;
> > -		case 0x40 ... 0x4f:
> > -			pvt->flags.zn_regs_v2   = 1;
> >  			break;
> >  		case 0x50 ... 0x57:
> >  		case 0xc0 ... 0xc7:
> >  			pvt->max_mcs            = 16;
> > -			pvt->flags.zn_regs_v2   = 1;
> >  			break;
> >  		case 0x90 ... 0x9f:
> >  		case 0xa0 ... 0xaf:
> >  			pvt->max_mcs            = 8;
> > -			pvt->flags.zn_regs_v2   = 1;
> >  			break;
> >  		}
> 
> I'm not sure about this: if we hoist this particular assignment up, then
> what's the point of the tabellary switch-case where you can see at a quick
> glance, all the settings that we do per model...?
> 

I think we should take any opportunity to get away from family/model
checks.

Yes, we still have one item (max_mcs) left. As a follow up, we can see
if this can be removed also.

Thanks,
Yazen

