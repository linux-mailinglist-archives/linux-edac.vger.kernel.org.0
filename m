Return-Path: <linux-edac+bounces-1194-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B828FD5FB
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 20:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E021B21708
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD1DF78;
	Wed,  5 Jun 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1aBt+AW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05019D880;
	Wed,  5 Jun 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613260; cv=fail; b=ujXQy5+uZt3wneouTJbeIxioACEfGxqEeC0+D6p8kNe2yNAZlpOSsgLDEvQ70ql2l7kMEDysVWB+qrXBXB4s8DS/H7FfQXBLYeoINMmEFSdUzsfNyg1hDGsKYG7O76CkjTBQ/nPk66UTQaXfZWOqUS3mJX647Db06Dh2N/YYLxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613260; c=relaxed/simple;
	bh=Au8Xn7F+HqQkGfrmyXgVipVG/qnqd04Fzl7nPltNPx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSX4KMvicbecMpQiXizvKN+Jx4DzZmskWnhjlkVHpzwCajny3iLHTNuL+10WFrsmN3jtuukzlDBRENh7YkceDgrpyn1tfcDYKAisUaIQPOa7DhxOgVwrupXHhx7KDPKdVvABrEXChlvskLsMR9z4JjN+SppJ9OGODMCUKZTGZ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1aBt+AW; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csm2DiqNizhqBpqElOs1SzRCrHDe48CAGhhqGFIm/balHlBoSm2H5BPOEdi7lPaSs1ffp3CyVDLlWAvpecJR7274tPh5r6yRlYh0TRtW4p0YlKiX3f7BWNqRjbEXZgyAqfdnIojW7yhHBRV5/x/qT7vxMbpmginX4bamC/f6SvXDc0q76Y7fgwggVYqC/LXdTZVYOB2Q2NHMd/lrrt4EK7OE0+4r1spqMrKZK4fdlyJKLOQ10v4jxLTgOhJ2zhFZG2kP9GKlNZeuaS1njP6LhlliHDvHTknJaVNwa5EASwONblRpDSf5XO8TaKOG3iczIOoTuUlLm97j+OP4aCmhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xi7NqitsgtvEOY4dtIgFAb7NPWKgw68AJgZGLbbpHw=;
 b=Ncg/HEfEbKAwD208nETD2bieYkiOTGOb2gF/RKSs289tLnC17XcsfJHIvi6p00e7GpCgtGxx9n9QMpKwHLa2Mv9zwlqMoEto/1FMMzCzq4X7uoON3z6cXhswOFV3Ajl4ra7CCmoEZ2DYPp7ulM4zU4mNN5Lcbpu7oO3m5tZwD+rNrwVWbxLC1nN5NFfTCXTv7EPFJgSuMPdFOuEuY8vciqflXxDGmSdxwan+5WhslcG3SiBwxUl0gVYh0DSzrbG6H76K1eH5vamHCWGNO9K7G0427TYPAEebKtD7YeBlxRIJ3MHUgmFnhPX+9Vwxpblbhm2OBuwbuh13p1M8QKtdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xi7NqitsgtvEOY4dtIgFAb7NPWKgw68AJgZGLbbpHw=;
 b=s1aBt+AW808/njLXiYe8GmRDurklJAajHj5AFUYpoO3b2waSzjhItqkU8szb7ODTEZynLBc0J1SU9rt1vKOB9HoHk5+Kl7dMnV389cZuKzLK2WYNCEMunecTVPcQoys8wTuudgkGn6sw7FTm3hdr9ZCwQw86Wml4URwQ29cyZi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 5 Jun
 2024 18:47:35 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%4]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 18:47:35 +0000
Date: Wed, 5 Jun 2024 13:47:31 -0500
From: John Allen <john.allen@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v4 1/4] RAS/AMD/ATL: Read DRAM hole base early
Message-ID: <ZmCyw4ePEl09hv5z@AUS-L1-JOHALLEN.amd.com>
References: <20240506154605.71814-1-john.allen@amd.com>
 <20240506154605.71814-2-john.allen@amd.com>
 <20240528081659.GDZlWS-9eT0U3_cf_V@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528081659.GDZlWS-9eT0U3_cf_V@fat_crate.local>
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e3ea73-70a7-4cca-7ed4-08dc858ff74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2xh3ECMFMJ0AihdY2/bdhK8EZ3BPIs8Ox9StKUuIoRaYxxnmDwZwkY/JlN8u?=
 =?us-ascii?Q?9UDA4ZCTNYl0etb9V9VBaKqgOKDGrBWU+idmgc88rJYB1RDJM0J/VtN0fT25?=
 =?us-ascii?Q?OMAxIwp/i7S65c7pnCb06qlrVswfN4UJl0VYA1URUOX4v4cWUI7KdazSadaB?=
 =?us-ascii?Q?HyJKqr0D6fvunZZ2zS3GJrdUuIH9SeqmulHNZ41HX8uIF7WWi+I6nlHhIWI0?=
 =?us-ascii?Q?mxW31iVuYYjMK08kLmiVJlDoRYxAN00Wto+Fy8c5dOngZ9aXHyLIR4qOua+D?=
 =?us-ascii?Q?nohhThrQ+8+E/+JlgPalPUKIQYcChWjmPEcf0R36Eu7INViIy3cV4+k1LuXz?=
 =?us-ascii?Q?d5OHygKi5OBJFUMlMy5JNDIjI3k+OcI6JKmRcoZtjCFSstO5pEJBHtWu13/R?=
 =?us-ascii?Q?Q8fejVuUTzbkIb4k39D52U70+u6/9q9VEPOxV7zE9aahscwqlJIyyUtOf2o2?=
 =?us-ascii?Q?lZLyIYSf9m8RxHCgh63ycofWqSEBljDU0Uem58nC8kDnf2J5sHvM1MJgOwMr?=
 =?us-ascii?Q?ooTkUWcYQndwiiQ5y7ndLLxBVIuz8Kt+2ToOg9g7YMCAlxFNaYs4Qm1Aazz1?=
 =?us-ascii?Q?ULLDE5p1fqRr9amcBqoqis+x4+OPRZsxFXjOCMchX+Is8uWs6Fmxqh7ATSSu?=
 =?us-ascii?Q?+rpidmKTADiiZmsqjUNFX2AH6eoMCEKDZwTVKl1mhwg2+km3RpBBTzcesKk+?=
 =?us-ascii?Q?broUaLXfvx0U9q5tZoqPINswsqVpH4JVkjXPfHOTgNiHal+1VkDwFZLSPpAB?=
 =?us-ascii?Q?hsybNDgPh2EFfeY130qggq53CrIa5MUIJ3DWTFzxUp9bl3p8fctoWO4dyv0q?=
 =?us-ascii?Q?8i/hi6xK86Fz4mKYSioezY1AKIZbOFiUCONfccCT7iEbaJBDu6rFA61r6sZZ?=
 =?us-ascii?Q?LEcZCIMUtCiatyShXlqBY+S/F93wTynJrOU+YCfcUvgbw5mCeiTB/kYoE7QN?=
 =?us-ascii?Q?tvGmmnhyAMDYZ1BGbHADAHqNDYmzneyAD7+fBoDyhGSoCNpuNqUvnsmP4phZ?=
 =?us-ascii?Q?G6gSNeU7NKIvYCO4MLnhiicQqVr/FkppFHIcSWs/FNQn7NQYjFf5oFp4G49K?=
 =?us-ascii?Q?Zxfm3HxlgI5Mmi5Ms/DovcYhpq2vw4uKDArqBYcqVEBqUz6q3oezh0Y6aCFO?=
 =?us-ascii?Q?8aHPyxoazUC3vZew62Xd9tMx+xZdf0PbyDyRQuZBGdJMieaKpgqaqfKCxtft?=
 =?us-ascii?Q?wu5HRed8EBIpqiFVOfA5Tig9bHu1Z0qKqilGgSHpOkNs6B5KTqZCj6hg4emY?=
 =?us-ascii?Q?5zNx86SX8yLj+SUmcDTOVB0v9G5sYrwO+bJTPLhGZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Ip1O6yIs90ZmeGEU3gvDNaM+s7jgwo22OuCewpATG1RLiRxD5PqZ7cUvc+Y?=
 =?us-ascii?Q?1fEr5NMbX+gYePhCBl2mSVacM9wKCF1oQM7OFg/8ONXomMrEz6lSHsSbcXuK?=
 =?us-ascii?Q?hIOuCBhePiVHRjyvdL0LYp1eN4CflDOwVgBkGW0xmarQoiIzxFUnlGydPjY+?=
 =?us-ascii?Q?ccHb/J9LFMVHGBDz07BeXsAUeEDhZ2AVSP85QQf2dZT4kNTwKtYYmlRZXnJB?=
 =?us-ascii?Q?Ae/vWopMetqDqjNAcj1J9mVkDikN1S22X6h2KXcUJxwrqbv+hRkeHBt/JvMN?=
 =?us-ascii?Q?xjTml71xCc6IdgSzOfYZSGAbROln3NFBF5yo/sXIVnT6XrvJuey2OSQgmv7A?=
 =?us-ascii?Q?8Gj1lKOXspWkMwWE3ejFoRVUv5cDRk3jhs8++KaRaf/myoWO5dJCjpk+S2n5?=
 =?us-ascii?Q?BvPOKmoUKDN89xq3GXrDOF4J22vuqc3j3wF74zcvXVsijEm98vMBWkWWjm7U?=
 =?us-ascii?Q?C1wuGDJe5C8W7/Ct/A02huSMXen5PUz+6Uhd995I9QEua2fxIRId+rIWAKuL?=
 =?us-ascii?Q?4KtSmndxxFENFKHfgerSjAJYslKCNSypkTPWKHxUAMacXoHcb3rhQRAX3EYa?=
 =?us-ascii?Q?yc8W7+cck3/0/+XNNsaIChxCbeme7lrhQ9hYlV5kaPVybYGXicZR7dieikSY?=
 =?us-ascii?Q?mMWBvgtj3LtVoQmRAGloGsCl4IwImgoN21EDajRX6OYHiKvCC2BnrCJ25p2M?=
 =?us-ascii?Q?BKsvYsOwyME0936IMIu09XIE9wgmRmA7N6Aux0G+zhyanG+L7bODZUdIAVpk?=
 =?us-ascii?Q?LEsFZuqUf/z9tKDj/IdiJ34Lbm7wCyxMTo2twUc6TxQvNv8Hb+O6xcOzScKh?=
 =?us-ascii?Q?uzy+SwctR0huqhxoXOr4kd4GD/1vIlCuimTeYMPQqn3fuHjExVB36hV9U0ot?=
 =?us-ascii?Q?08RWzQhULHc32F6VY7EJX5GFHvLwoTvZnODOeapyysKjXqqiR10by94FGZY5?=
 =?us-ascii?Q?NYuis/ZAIMpRkRYnXeKaOIfS4uWyEeAXytYOVQGlu1RaOfMYqQeeLjio1FeT?=
 =?us-ascii?Q?tjC1rFZwcJnO2Rg9Qo0E15XqQWEAk2h98yjiver6aWtLTHcsVz6wqqIxcMQ6?=
 =?us-ascii?Q?5mzGK1mT7s0ZXN2hay9NL7xAgKw06c+Z2vQ/eW8/Uw45p6BzU0PdGtYMVk1K?=
 =?us-ascii?Q?JSFWc/Lx1xoIbmc1BWXa42Nd93VFOT3RGcKvT9SHlBmfwKQTVZUP0NGdLc3l?=
 =?us-ascii?Q?cU8hWZ7UxC6tQEh27DsPgLhcL/YYaW/n/JGlMQUtnzKzA8kfuKu15CnF1AX6?=
 =?us-ascii?Q?VpgJ1RlkdqXKcPuGq8aMpHxhELsix08vVwnuH9rvUrUI87ZkhTVwi5QgdZhM?=
 =?us-ascii?Q?GYLHMjnNP0BYqHfbfG2MR81xqAeWk20JvKihiM5v1BU+bmBmyNW3+eDbEEKD?=
 =?us-ascii?Q?SjidEED2RmtnyclpYJ0v6pluN5kxV5GcD3cXccSVmLycxHisvP78fS3aL+nL?=
 =?us-ascii?Q?8LSoqpeyGMdqerktcNop+JntklvJ25S5EVuXNTx9Xt6RNk23hxTJO5I7hi+k?=
 =?us-ascii?Q?8BpIT2TdHbgD5NuO7v7nhG4+JCKQYKNL3EZcRSHtVulnPPe3SbpzkaS13/ND?=
 =?us-ascii?Q?7PwW2f4V03VT0+JQTEak87V1zrD/LDmX0pKrUq8a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e3ea73-70a7-4cca-7ed4-08dc858ff74f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 18:47:35.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73G3a3HKUVLew4Kuy0H+AIxldaOwi6YfWJGlxJzPRFMyonPEdpl53JUk/anpgvIS74i1F+Z+4qS7EXStEwmJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

On Tue, May 28, 2024 at 10:16:59AM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 03:46:02PM +0000, John Allen wrote:
> > @@ -282,6 +298,11 @@ int get_df_system_info(void)
> >  
> >  	get_num_maps();
> >  
> > +	if (get_dram_hole_base()) {
> > +		pr_warn("amd_atl: Failed to read DRAM hole base");
> 
> This thing with the printk prefix "amd_atl: ". Please do a pre-patch
> which adds
> 
> #undef pr_fmt
> #define pr_fmt(fmt) "amd_atl: " fmt
> 
> to ...atl/internal.h and remove all such string prefixes from the pr_*
> statements in the driver.
> 
> > +		return -EINVAL;
> 
> So this basically says that the driver won't load if it can't read hole
> base. But it did load before - on failure to read that reg, it would
> simply fail translating.
> 
> So why is that failure so tragic? Or is it that we absolutely need hole
> base in all circumstances so that loading it is pointless if not?

Yeah, I see your point now. In the case that DF_LEGACY_MMIO_HOLE_EN is
not set, the hole base will not be needed and should not be fatal. I'll
remove the EINVAL return here and check that the hole base was read
successfully before using it in cases where it is needed.

Thanks,
John

