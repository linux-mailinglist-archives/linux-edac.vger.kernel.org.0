Return-Path: <linux-edac+bounces-3884-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85273AB3C38
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC3178611
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A123A562;
	Mon, 12 May 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AkAWsxUe"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419C1AA1E0;
	Mon, 12 May 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064051; cv=fail; b=NZuP2PMJc9iuA77R1LuDhr5O7oxoGvl6HrNvAHBi7dVORasMgn3mzDuC5dCZGLx8ooYdiKR+qZCUJw4EGhu2+l8u0Vne3poWZAhNqkB7qIPTSTnMSj/9pytAazixkCotoL92vWCAQbSslpqsrX3VWTu0npEkYbl0rg362qetpdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064051; c=relaxed/simple;
	bh=fUGxPd6XQqB59YxnT/1Y4gFWqS3d9y2nztI3AN9YsfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5omw4Ei5ndbJy/EwE632vdo1t/6wXdvNQxrI/HF8L46ohall0UcFTedWIhu92NVjdPu4TUMWlHiidAZ4xzaTt3gc8rjyGWoJoNXGygjugShK960KbjNcu8/iAq9s3fApwm0IHRhXnhGsxjCcFrozTwwP8iku+yxYi1MZ7rJPhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AkAWsxUe; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVclRgaqtBPJgcI9K9OjUpqrWwlHrpZvsK3gP9g1NPvwl304wtgTRFOzhdlpcv4b6oumpK5wsos3SmouP7NjpUb/xGemebEVYwKjM3JE/z8s0Log8WPeU9CsFDNKqySngQ4hp955zX3joIe7gFxtEDFWnZo/uP7UA+WBeo+wVBmjjWnbzh+qFQkfnHGPBvnXbckMEUi8f9aleR3n9lD5Xv1B3piFV11cNFHVMleNklKR7+S1HTEHbetSbGxDMJqm9AQnmAzvzlrqVbif3rHkSWuawuCN3z5KgcmbsPkCDU7o9sAc/rGKloO1EE5+xULC5KZ5W6cVMefVmh2stcOfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKc0dsOByVG60TG641VJvv4KQWi9t1SbnAnLmCVGq/E=;
 b=UQlTsMy+pot2eFumUpWALgvyE5MaJI3a5GiLcYjbOYGcAbIkTkgUzKcKN5mZl+7UIy8Skd4rLSzUex5+rLlbuvGSLLrdeg05+1wniZZGjKauC7Z0tBnHkX9WaNAYg5wuZSiML+rav+8RtRPF6tR2Y8SFtlF2MxOp0se+LF0elsu3nZ0DIRpcPOvJDh2CqjF7JErrk+5/q8dRLSPAJyBcCfYUMro/6dNvd6bwJGg6JyngWMBfMb2UJqV6j85NV4dvhg2CUyN8L0mQ7I7jK4QsgFcq4i3pEcPPuNQLpeoRTbhhMssyNjEn1jURbZMHGforMB9VMgjDa/hOYVIQ5wGDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKc0dsOByVG60TG641VJvv4KQWi9t1SbnAnLmCVGq/E=;
 b=AkAWsxUenUSR4/hnk64T93CNU+QDwUcD2tuvsnu9QFC+TQqC/fJoTMCC6vkX7+MKJSArpYUigEgrha7aiY6jfjGaItORJln7otFPGeVh2G+mju2AsEsKx+KKpGFcIAMr2cVkI/48DPa0B7o18rMh8gj0nQNUHZF0YMr2Ljot6eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 15:34:05 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:34:05 +0000
Date: Mon, 12 May 2025 11:34:01 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 14/17] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250512153401.GA2355@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-14-8ffd9eb4aa56@amd.com>
 <20250507193539.GPaBu2C_Gt7ksvRHoc@fat_crate.local>
 <20250508155300.GB1939543@yaz-khff2.amd.com>
 <20250509140821.GQaB4MVUiLk-a5FWM-@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509140821.GQaB4MVUiLk-a5FWM-@fat_crate.local>
X-ClientProxiedBy: MN0PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:52d::27) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: d99dce0b-e503-48f9-fb66-08dd916a6def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WZdBK4NJ3g6yNtOd041T7uu/3C35VU1ZX1xt9RZhGgSL0DjZLsWJHgoCpmQE?=
 =?us-ascii?Q?V6pcDVcXzyJ/ZUBv9bjRWLXbUQHx797Z0rbxcTMEsnvcpFM/rMI/2fsF1tbu?=
 =?us-ascii?Q?Ek0A5BldBgzPdt7gcEXfwZfIrwnzBmkZyPGBTrteuGDYS+o1Rkehlg2kkUzq?=
 =?us-ascii?Q?egcVq7j06zT1Hp64LZ7jYwBlQteBuIY1wrvF7/UCGtBnTzVvGnd5aDVvsMmg?=
 =?us-ascii?Q?nbBGA3mUcwayEHMbQXwjpd+butxszzqjdTetZBAU4mhObvZyIVC+/LJfXq8e?=
 =?us-ascii?Q?JK4csNWDMYn21+AepohaPR8QaXS/eBy+YijGUyh1aaaPYQtiSHl3ddsK0gks?=
 =?us-ascii?Q?yv4ipeu13Njd43FOP+lsGgcF0te3P9a0L1WiUziRyFChQRsvuKPDkAIpxsfI?=
 =?us-ascii?Q?P8EunrgA8iV1MuFTacuZfh9XcVM0fN/Dws/Awwzg6xFhNmrPOCM7OLb9qXdQ?=
 =?us-ascii?Q?zH4Yt+xonLu0x3oZJ9NNQhir8wTTb6d9b857QvYXYLi5vFvTBVRZw9IVIWbi?=
 =?us-ascii?Q?MhJQFCN3jvQ4tLbC5Wl5APS5NPzWIIzlYHJ+R/FFgNSOZBgx+/PDtc9md/Ym?=
 =?us-ascii?Q?pbwsHhuqsP47Syv4N/dscaplZu+Y1KPeTwETL7qRvk10SdYt3YqKd6Q1u+gC?=
 =?us-ascii?Q?x7aT801AHR0Rl0KrMW3xpgypFtxMjDgMbDoDBoxJJySVFcA8+WgjZfnlo+2J?=
 =?us-ascii?Q?q+LCLTjE6NzknJeytGOrPfdHpED6r7zlwvW21s+SdyRQSnYApthIhozihUZA?=
 =?us-ascii?Q?4zacQnRdsX4NOKBkfoTMhNK0QN/Zw7kOKssFaVMO/W5XeuZoLMV98ehLdyuV?=
 =?us-ascii?Q?vdZDZcE+4uQ5rbAYJkixd6BIstr9ZoOrR88TiPiBSExymGBbt45/FIngmzE5?=
 =?us-ascii?Q?QEZUzwL/2nCDco49h42QLoQ4Mxsi0xkObbsjQSU74HBTAS3O4vhG6rlcgEdH?=
 =?us-ascii?Q?SgjOp/flVQwUaQWJmhyB4qC+vP8+0iVqnZGCBa2liBRPpFYnQt1uGq9HZpIg?=
 =?us-ascii?Q?zLgGN4qibg3cgkEAc9E7eRo8NjucPpb615/ZLWmNjQZokQx5+YiAUV/4kbHj?=
 =?us-ascii?Q?whm2WFLZB27mhp4vchZxPsd272bHOaVPX1mRCzyI+OgwSjJsywejdtBAhD5K?=
 =?us-ascii?Q?yLk8s9gyxzaE8xu43/UgwVNBlQseXFKpqQIFgZgFpt18PXBXS0Kcn8+62E0L?=
 =?us-ascii?Q?h8K0GRkORkcoS6EXmQWbpsBW6LsdeW6GAhIOwkC+LlTBheGMrbXXcpwyH/Er?=
 =?us-ascii?Q?S83b+ghAxmTsFnKiCjVuQh5/WB9E6cwO2UEJts/351jvkLzr1nnJVLBi7jcv?=
 =?us-ascii?Q?EDcz8u9r+2Hc2Q1n2eN6b/a5kOPWTjSD/LZOt6I5jVCHp09Jr+4w/NZOfRdb?=
 =?us-ascii?Q?q16u6rdqdrph9UyThfxcTDp2pS4k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwb1bJWF48wG6Fz9oh3OKkd8S/PsRH00bXQzOkoqmhWn1hQY02XEYPDbZV/F?=
 =?us-ascii?Q?AQei9pe7sxheCzj9pZHwVv79jJeLqYzxokeuDHUqKmGRbm/vJqNZTOuAdqWZ?=
 =?us-ascii?Q?qWBchDX1v6K/AjitdxbpG9awMmv21w4vC9FDuQNrOoIqd7OvFtvT/LAlqx5i?=
 =?us-ascii?Q?Y7Hb2mXby+ljg1732x8LGlSOHs8zEYhF9CUTh11U2GkswaYyJM2v0vt0SKxI?=
 =?us-ascii?Q?mUXGe/wJyrHhi2tY71rxC6PJMoeI2YsfsMWPml06mHTCZki2ouh8qKc6nWd5?=
 =?us-ascii?Q?g0UyZBExxCVemzmEl5qH9OnfrdHMYrTBYDSFii1dourAjZ4g2OzdWLxFqTWH?=
 =?us-ascii?Q?wE6xEDacZ/shnMROjOoz0zAG/hivvQfLDsMZWF+Rfnjjf5aHuPuf4mO0/bOv?=
 =?us-ascii?Q?7oKDARiTdk1TT+iuwbroa3ZnRNhY4T8iPCxagFBpq3b2DU1G68C+gfjTI4jb?=
 =?us-ascii?Q?JL8tX53Ea63S/ZRg+8Sy4AqDEYxaYz+2/olPPFSid/f5K0/Dcyv8GICVfh4e?=
 =?us-ascii?Q?K6R/no8NsuGJS7EwFFi/jj2S3wqkFQMU+4bMkpu34+uO4APukXpXJMx/Bk0H?=
 =?us-ascii?Q?DzoFeJePTnPr8MRJyFbW87sSMQ28QARJpLSwtmUU0QGzGOpXgs7YsQZvQJWa?=
 =?us-ascii?Q?cZ50DI2T0PPpzBgLTn6gADSr17J99CeRn8XTG/E+UDSvYpDzRpnTkMAd/fs5?=
 =?us-ascii?Q?ZnGViiqFtVCqN1Tr78bdHPZy3Z96LHQs92/SAcyrcPZk2NeBSQfe0y6rCfWh?=
 =?us-ascii?Q?/pTdmiF8WNZWTXk0m8UcLsbOPvaUd6gu2hzoMH4JKgupTECIFDDz4EomJchC?=
 =?us-ascii?Q?zDDBKUC9753x2rRs8j3Rf7PO6y0N6TIepm+HSnblkSE0JYCwri6hXEsnsa25?=
 =?us-ascii?Q?mi3bmJ/cKbYKbd1crWs9Sa4+11Ck6YNBPpsA5xmfYKfC6pA+yS+vZCOuPnDy?=
 =?us-ascii?Q?b7W/HCjjVUHcXTK6bQPUM/oorYSSa6dE/XKl1aVNZnxRqdvqEKrPyiErKBW+?=
 =?us-ascii?Q?QdhtTvAoeUmF9m/IpMGgZErUOfE/UnIrT9VNN6iNOWCTnaby2006XiL5u/iD?=
 =?us-ascii?Q?NuOt86A2WkliTNQxzZvtESib+vtpZOdFHcVV4139ZddSeIHfVM83lHq13sNj?=
 =?us-ascii?Q?GeM0RQVuuDU43InTNLqrQIKjhoXIUEu5OwrQWp2QiVqSt+LZ1wuiz7ABxsGR?=
 =?us-ascii?Q?zBE3F1kqAGKaO1mbUa9cVE2sP+SJ/uh5bM4XXndOeBP0y7LgfARHIRwmi76F?=
 =?us-ascii?Q?JRHeCnLawKQSdDxLHne8vql1RfkfG22F1zZX+zdglQu6SyyediwbCNakNFmJ?=
 =?us-ascii?Q?WNXqMLa0VJJbVfLowv6jEpwi6ljPt+wEia5jKgwx+QubFQif0T9ZNIyr/uSe?=
 =?us-ascii?Q?o/Orw1LMI6cGckld7JEXcvzOhHzYlH9H5RJM4XqDtgkBfGSfr4PTJACn/3rq?=
 =?us-ascii?Q?8NKgnx3OB0cLy3RwJ8ymr9pfzKCZtwC48vw8pX6J5EZGQBMXo0w4dW0+2S2l?=
 =?us-ascii?Q?kbZgmC3PIxYQuUnPenmsOI2hyJ1xQZUYy3fvGd4wb89p49fqjcDSV0hrxcbM?=
 =?us-ascii?Q?2gsMKHrvhI2LwJjpXKJVaArcTyzaRSVnekrWjDJ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99dce0b-e503-48f9-fb66-08dd916a6def
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:34:05.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGowpYf3uigRhmM+LdAGoqBgP843uPG6DNPzLKckgrjOhNoN7J4rc2t9H1ewKypFTW7zHGethX+2aNhlMRS3eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833

On Fri, May 09, 2025 at 04:08:21PM +0200, Borislav Petkov wrote:
> On Thu, May 08, 2025 at 11:53:00AM -0400, Yazen Ghannam wrote:
> > Let me flip it around. Why is this check needed at all?
> 
> As I said above, some BIOS f*ckup.
> 
> > Was there ever a real issue to resolve?
> 
> Not that I remember...
> 
> > It seems to me the deferred error updates are just following what other code
> > did.
> 
> Let's search the web for it:
> 
> * https://bbs.archlinux.org/viewtopic.php?id=299379
> 
> - silly guests, who cares
> 
> * https://gitlab.com/qemu-project/qemu/-/issues/2571
> 
> - another misguided qemu...
> 
> Aha:
> 
> https://lore.kernel.org/lkml/20241219124426.325747-1-pbonzini@redhat.com
> 
> the usual virt silly stuff.
> 
> > I figure the reason to have the platform give the offset to the OS is so
> > the OS doesn't hard code it (in case it needs to change). These offsets
> > were hard coded in the past (conflict between IBS/THR), and it caused
> > problems when the offsets switched in the hardware. The registers that
> > give the offsets were introduced soon after, I think.
> 
> Right.
> 
> > So the checks we do are defeating the purpose. The OS is still hard
> > coding the offsets. The goal of this change is to follow the intent of
> > the design. Sometimes we need to let go and trust [the BIOS]. ;)
> 
> Look at you being silly :-P
> 
> > Now we could update the checks to verify that an offset is not used for
> > multiple interrupt sources.
> 
> ... or, we won't do anything until someone in BIOS f*cks up again.
>  
> > Let's follow up with the design folks to be sure.
> 
> Yah, sounds like we will have to verify them after all. You can see how
> universally widespread the trust in BIOS is...
> 
> :-P
> 
> In any case, whatever you do, when you axe off stuff, write in the commit
> message why you do so. Silently removing it is making me want to know why it
> is ok now.
> 

Right, it sounds like we should take the values from the platform and
just make sure they aren't used for multiple sources. In other words, we
don't hard code the offsets, and we verify that each source has a unique
offset.

I agree we can leave this for now. So I'll drop this part from the patch.

I think this topic can be a separate set, and it should cover all APIC
LVT sources including IBS. I'll add it to the to-do list. :)

Thanks,
Yazen

