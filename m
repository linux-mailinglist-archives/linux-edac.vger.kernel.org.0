Return-Path: <linux-edac+bounces-5766-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOWKOSlMqGmvsgAAu9opvQ
	(envelope-from <linux-edac+bounces-5766-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 04 Mar 2026 16:13:45 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F6202594
	for <lists+linux-edac@lfdr.de>; Wed, 04 Mar 2026 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 923DB313645E
	for <lists+linux-edac@lfdr.de>; Wed,  4 Mar 2026 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B234B410;
	Wed,  4 Mar 2026 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dhp55qi7"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB134B682;
	Wed,  4 Mar 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636657; cv=fail; b=NjLYACcUeYHOe+EWvSi8NODgcnbqlmypTZVsa3HyZwKjob/y/1baYPRx8RpTwaIN4gFwUcSgG+s3+KrnmNTb8dAkL9VpQ6cKGc9n199TLPo1kQfpeBQn9Wwy79hxvHqZr15bPqK7qb+OwokZ2EaXR3O3f6YWN5esH59bP5EgxWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636657; c=relaxed/simple;
	bh=zaUais6ThQgTyQSeei6dSRQEj9vf/JQV7kphkjWhgwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BimCZfJRbpZeuk9lcZ81MiZnEgNVT3eZQQ1Jg2RCamw2J/u/kEY+U1JpqckrRnceySb1GfJY2hySZ+RDy853XPPl0drtvd4V79+vLhPa18u5vY7dOOXKPfLp5W520zfOwrefiL/dBefQGa8wOrwbV5+lV78i6gQdojDXLkrtiwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dhp55qi7; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS+33PB1EJFKozPZ+iFJ85yS4GyDA1bzzOE3HV4VOnv35ApQS9f5ph3HxexL2BozufjiNsRaG6wb4R7OdpWAL2ubYcC7Cs59z2GDOY1bKvuD0ATRBN2g7jX1oBvKYN0rAHR9hF0wmp5S0A3NsGXUBArlQvNTtaz6SxjWrkYqQfLNcbPOWJ4YGATJryOu/kElEyjEFjtUTTLCw+XAwbmv/Y4lEEOr4+kcbBXWOdF8QimPVJZuNf9PwOAwp0hHdFgc61EKTIuVKWwxFI6wCaOQiIXM4PE1qyCB/Xjf++/9NYxpe1+pkFRFYycia6MktdOIFn0pawMaV/vzroA2mGlvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbesJPwawfZPDkxpOytOVuHjd7PdjSvmPMefJxSdvqs=;
 b=CVecwkgVuOW1th2AsYNhfZmxeZ/qfEM61i5/M0CQ7ANOb1HzUAtQnvsBQnKjiaEKC9oaSXYV1LI/PT4J3upfr1bB6rzimOtwIKxKAxNYH0YCk9MItiu8IJjiC6qFfdSr7WXdvJiCRjcrukYo2GLm6qG7jL93UyjJjgUfKI3Ro8JWVKtvfe7O/lBRCWpIpjWIs4wcJcKmJNY1CGxmoFkvWsqnKioNKF1bGa+mVttZUfSUYgTcwpFQX7RoUC+y9/mIiGVesaCj7KOI6i/BQg8r1JzvbW1/9QelMbS2pPwp82BCm/r/dWxEcfwmUtjLaFcG5561BoUnOWemdW/ps4JcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbesJPwawfZPDkxpOytOVuHjd7PdjSvmPMefJxSdvqs=;
 b=dhp55qi7wb49adCcVKMdyoaKsGh4gIl1YtirKEHwxfgD9aRMFLDxaCBSejAbXkjhhHOsvvV2BLg0F55yk+UoebXJoCLs4M5kmdG7k1Jy5HaYRKbM17rsDTQvn3lbh1EPv38VaM4OSFEsCdvu0A21/vCBoiHrDAJzQQ0IgmMlltk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Wed, 4 Mar 2026 15:04:12 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 15:04:12 +0000
Date: Wed, 4 Mar 2026 10:04:02 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce/amd, EDAC/mce_amd: Add new SMCA bank types
Message-ID: <20260304150402.GA807247@yaz-khff2.amd.com>
References: <20260202172158.2455749-1-yazen.ghannam@amd.com>
 <20260228150447.GCaaMED_7sbC3OvDsL@fat_crate.local>
 <20260302142255.GA145106@yaz-khff2.amd.com>
 <20260303153814.GAaacAZrUnFNBhPq1K@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303153814.GAaacAZrUnFNBhPq1K@fat_crate.local>
X-ClientProxiedBy: CH0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:610:e4::20) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: d12e17e6-c69e-413e-7ed7-08de79ff4b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	Z3/VCz7PWEthe0p5w4LaYB12PbebbSf/R3UFmkqONLK/Lkx3+MaUoK6JQV7ZE/h7NZE771QXaA2bLesMctFDDKUBa6VzpP0/ZJJODlAUpyE0trSOkVMjrVZgyVRS4qy7lJbsI2qgdaZto6mDxHRy8P+zZwR07R74kbTtc+MlQolUujy7uIeur8BKNAOTL3U7LMgsGyWIm5YQVJgrxUN/W6UF//OsG2zxqnGUjDnSMMMQNyKtiZacxJ6iVg08Ym91WmpujT843PS9ENejsMgLyHM16CwtzticjLBihysns+O2UBp2BxrwB1EmC2HR0yWwznbaeN/SqgZwjwIhI3p1hOGGySBId5r5meOU4i3gbDgJt5H5B2YNKnEdHrs40wEi8wmdM3De/LOuFSLdjMCUXoZ9yI2MxF+LIONNeTlBFJFrcpzx+6o9l+1u/978ZUBVjodQVcdXalhWVbWj1XUr/J2wI/Lr0EZ8CY/iRCEuQKhzeV6rZWUcuMdr5x0gyfBst7ff/mBJaMU5b3CyUdEkqM72yq122LfPxFT4YUIDybergxe7BsVnldtVx7ZOcwlSxpHKSionPiCWzUpaS3Gpg104CC0d81Qn5gmFxBDuH+32iybFWLAz3RGJmBW3GGwaTJJsZfu+3jGnFshA1Xup5TwooBOQoBMsvOxJOew3U2n6mFvC4WikwZdmuwQ70o4t9/lFggooA1nzhTl5N2up4NLX46I0XFYHfpwnFMKDF0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uL64UghzEQyg75P4K9Aly72o2fcBeodcAvbyatdEpqTS6Wucln2EX8Tw6hm/?=
 =?us-ascii?Q?IQV1o9g/RPP6XDheGN/XwRSlEfmDH26mhNS+hkl0y5vptKsMlYAN+THGAThO?=
 =?us-ascii?Q?Y7e0szryDf+pXEz+3waeA2hxl3A3cZdSE0IIoatqyGu4RhDkQrqmKXkSrqeO?=
 =?us-ascii?Q?UhA6UzdwYiRD0UAUm7TnfRjVkDTGliXQh7mIji2ocnJnWBxS2c/Rc2WO1fxl?=
 =?us-ascii?Q?OlHXWJLkA1c6BjDLIlXrB1BFVjT8wi6jFGs6zNEzTzH7sqW5sMUQXlW6pqR4?=
 =?us-ascii?Q?3BUwdUhV7YBt6dwweE3bEP/SIDkmU7Q/1NSV3WPtTeGL/rp9fi34zxOH3Wrc?=
 =?us-ascii?Q?JSbJpfVv8FIGfigw1qPaqjoWgoAr+u3XOswd2lywMPeMdH62RMBfvRAcFxKs?=
 =?us-ascii?Q?fvWTEh3yScCnYSmpd6mBF/EsEDmiyoPaIYTm6b/CAKXjRq5+LZlfHTksueue?=
 =?us-ascii?Q?1tS6qEe2EzjZPPifhkpM8KwsNZb97xoqcugm47sKDEH4dMsISan+dIWlXVgG?=
 =?us-ascii?Q?CtqIJ7SmhQRMS3QGEOTELU+MNWiCZ+mb91HJb+TobKf3OXE4A8d0Exz1qWp/?=
 =?us-ascii?Q?tgLxituXBPXaI7xiT93uAxozI7tyhux11Y/cPqHBIYsjmRZlc3oc441DkDwm?=
 =?us-ascii?Q?DDBZ/RnksDOIxvSlFl/t7j48u6FQPxNouSVY5KpYPxkl8CdYSrwakXDoT11h?=
 =?us-ascii?Q?ZWGrkK62FKBdnqx5DjfXWgZJr2CMwL9HCZK+1p6Z33MIx+E3PY1ooBbTTh+N?=
 =?us-ascii?Q?OJBnPqZhQ7BBQjjmWTaDav8qqNdFjPeP3mq1FISyYfjfQ87N7/M1E5nYXHsK?=
 =?us-ascii?Q?bLAbuLpOUyeBAHgM39QKaETYpIhBqV5b+ftu2Hsg85oGZEW8eUYvJXFoAIO2?=
 =?us-ascii?Q?xZR9z60zYs9s0vzqbMupBwTWbn0w+eXNic5lHT3KAguXBqpXaZRhFu0zrVo9?=
 =?us-ascii?Q?qyrB6sdj3TuVCw1NcoPZ9CQPe6u871leReZeC2A3JglYbGJV22peGrSYNYUB?=
 =?us-ascii?Q?C0uMtsu8htXZFH/qMRgpllZhnJTEJjRd+ulSa2bMXSXR4MYDokyYN5D3h9EO?=
 =?us-ascii?Q?C+JXBjkgZKMLhEUaAvIwgoc8D3w3CBB+qBlm6GqyZ/Ae5k1MdAYGHUSkpPeJ?=
 =?us-ascii?Q?TwF5VyzbI9rMnbSi4XbgkWVTYopu/J9b5acNhZpEIKbFxIxss5S2s78+0G1B?=
 =?us-ascii?Q?fQ+LC23HcDbI9xLgojoWjHJDMn2pyj8xtcehqWJZKkAIOjV5ayjSuQKF2j0b?=
 =?us-ascii?Q?IZbvvqCfNab5FN5+DUC+ui+QfMTYmX6jCF9UYNPUiEyBy6lqdOQ3jFIRSi66?=
 =?us-ascii?Q?omcTz9cYIjFGgdkngKQXckKZr8nznE56iXx3C1GDQECyRHDajyn1lavF8SEC?=
 =?us-ascii?Q?9IAiFS7nA/8/FfAJlv/NO8RUDar9pHE5fb6jLZl2QSAwquS+f+W3orJIOf6O?=
 =?us-ascii?Q?nusxTZazuu4/STi5uFt6DcABlw/W9PF3XwPGJGhr3FpM6ZvwlGRBP6/E8Qlo?=
 =?us-ascii?Q?3ljeWXbzuWMfFduuP1p+yP9QXrhtNgvZ4k1C5FuEJHr/2EuEAs173YsOlgYr?=
 =?us-ascii?Q?+OoSYS3J1C6KW5z6+f8aPcdE5OAQ2d3UgqC82cz9zlZkCem75wt3mzMC/DXA?=
 =?us-ascii?Q?tRIw6yhZD9VEngkqrKjDF34iOjcxJWskZMnuiw9171+8iT3BvsEa4LfsMiSD?=
 =?us-ascii?Q?wGBzU2rYkwhtiONCWHyd7ZFiyrGCyLL2PNO7KArfvNjUSOdqfCWxVggpe+lY?=
 =?us-ascii?Q?vKQwE4jrrQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12e17e6-c69e-413e-7ed7-08de79ff4b1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:04:12.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP9GqS69UP0MlkfqAG5bytVnRe//62BkVW4RGY8XMZlM4yVzgrHDxW/Yk2bWzxrU2U3sHpuBdL8P/btY2d0KFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
X-Rspamd-Queue-Id: 494F6202594
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5766-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,yaz-khff2.amd.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 04:38:14PM +0100, Borislav Petkov wrote:
> On Mon, Mar 02, 2026 at 09:22:55AM -0500, Yazen Ghannam wrote:
> > The ordering is based on the HWID_MCATYPE() tuple. The intent is to keep
> > those in numerical order for easy reference with documentation.
> > 
> > See: smca_hwid_mcatypes[]
> 
> Ok, what is determining *this* particular order?
> 
> First LS, then LS_V2, then IF, then L2_CACHE, then EX... all those start with
> 0xb0.
> 
> Then CS, PIE, etc start with 0x2e...
> 
> I guess I don't see yet what the sorting criterion here is...
> 
> Thx.

Yes, you're right. IIRC, the original order was based on the first
documentation from Zen1.

Later on, we tried to keep new bank types ordered numerically, if they
didn't fit with an existing type. That's mostly the group at the end.

> 
> static const struct smca_hwid smca_hwid_mcatypes[] = {
> 
> 
> 
>  { SMCA_RESERVED, (((0x00) << 16) | (0x0)) },
> 
> 
>  { SMCA_LS, (((0xB0) << 16) | (0x0)) },
>  { SMCA_LS_V2, (((0xB0) << 16) | (0x10)) },
>  { SMCA_IF, (((0xB0) << 16) | (0x1)) },
>  { SMCA_L2_CACHE, (((0xB0) << 16) | (0x2)) },
>  { SMCA_DE, (((0xB0) << 16) | (0x3)) },
> 
>  { SMCA_EX, (((0xB0) << 16) | (0x5)) },
>  { SMCA_FP, (((0xB0) << 16) | (0x6)) },
>  { SMCA_L3_CACHE, (((0xB0) << 16) | (0x7)) },
> 
> 
>  { SMCA_CS, (((0x2E) << 16) | (0x0)) },
>  { SMCA_PIE, (((0x2E) << 16) | (0x1)) },
>  { SMCA_CS_V2, (((0x2E) << 16) | (0x2)) },
>  { SMCA_MA_LLC, (((0x2E) << 16) | (0x4)) },
> 
> 
>  { SMCA_UMC, (((0x96) << 16) | (0x0)) },
>  { SMCA_UMC_V2, (((0x96) << 16) | (0x1)) },
> 
> 
>  { SMCA_PB, (((0x05) << 16) | (0x0)) },
> 
> 
>  { SMCA_PSP, (((0xFF) << 16) | (0x0)) },
>  { SMCA_PSP_V2, (((0xFF) << 16) | (0x1)) },
> 
> 
>  { SMCA_SMU, (((0x01) << 16) | (0x0)) },
>  { SMCA_SMU_V2, (((0x01) << 16) | (0x1)) },
> 
> 
>  { SMCA_MP5, (((0x01) << 16) | (0x2)) },
> 
> 
>  { SMCA_MPDMA, (((0x01) << 16) | (0x3)) },
> 
> 
>  { SMCA_NBIO, (((0x18) << 16) | (0x0)) },
> 
> 
>  { SMCA_PCIE, (((0x46) << 16) | (0x0)) },
>  { SMCA_PCIE_V2, (((0x46) << 16) | (0x1)) },
> 
>  { SMCA_XGMI_PCS, (((0x50) << 16) | (0x0)) },
>  { SMCA_NBIF, (((0x6C) << 16) | (0x0)) },
>  { SMCA_SHUB, (((0x80) << 16) | (0x0)) },
>  { SMCA_SATA, (((0xA8) << 16) | (0x0)) },
>  { SMCA_USB, (((0xAA) << 16) | (0x0)) },
>  { SMCA_USR_DP, (((0x170) << 16) | (0x0)) },
>  { SMCA_USR_CP, (((0x180) << 16) | (0x0)) },
>  { SMCA_GMI_PCS, (((0x241) << 16) | (0x0)) },
>  { SMCA_XGMI_PHY, (((0x259) << 16) | (0x0)) },
>  { SMCA_WAFL_PHY, (((0x267) << 16) | (0x0)) },
>  { SMCA_GMI_PHY, (((0x269) << 16) | (0x0)) },
> };
> 

We can re-sort them. Still want to have them alphabetically?

I can re-sort in a pre-patch before adding the new ones.

Thanks,
Yazen

