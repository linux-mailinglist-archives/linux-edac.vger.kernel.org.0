Return-Path: <linux-edac+bounces-3872-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14649AAFF9F
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C45501B2E
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF227A93D;
	Thu,  8 May 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mmq11VaO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599627A932;
	Thu,  8 May 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719599; cv=fail; b=oN1sVUfFTIYFSkkv3YyxDcfirOsgRxr7Bws5wawVwVclS6DWkmB33LDoMWhTr8A/KJTEWUxASkJqxO6sakYpKar719Aq4eMHXr0q/0JKd0uFDFKRIkhGY81120AS5rkCBRndhbpyGbaJomOl+wOl9iys839RISRJfkubsiTp6x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719599; c=relaxed/simple;
	bh=Jn1WV+mI2+TNvLBGUvWnUVB9ijy8LZ7zzBZbB7tZGvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EMFWz2KeJ3Ci7+tVCkZpkVBFNinB6tEzSgGCBP29qSMS+Lno3+yClvNXRaSQ9i2lR7qxDtPC+SHoygWfxIpmPu/RHx8iw7Lg3pguWQ8H35OJ9LcAVP5q5zMFefrHatx6N6o2LN/k06wjxzrujfbsYVKKQ972sTpHhnFlsliDRwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mmq11VaO; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHhWfOkB0lK/KddrNna8e8Xm7HuU69LSEhtywgmuCZjNb3xUmKxC6a4DYz7pvKcr+4cL8JhfjHmtwYIrW0OOQQK3LE4FGZ6uvuAsYvf7iLCE3fLqUivtayjXnY4cbEARnK1xPgl1jCFMu1obRT/elTTkjeuIkNPcniEgmd/LpuBRNFOui1FlQnSi7xroFVjHErnxweWrdNmYHWMdY5jB+wDxbBWcshq43x+3EcXZpdW5teF/WYfOG3Ggvzj3xp77QLWWjFFz2GzI4DqQ3wEx6NbO/kYIQ+8kXPx0vBeu+uKpfDwha2H7fe5egAI0F/gYQYNorN43cCsfXapyFJq8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stiyL6ML0v/njMFy9nqSkTIy55nMUGIy5nphZDA8G9E=;
 b=emWSj+jkSGJOp4OXKdqqIrMkFJ0xorAvDUgs6vlHhogimOEXfXEoV/AJNf0YppjaK2jckUmdFVtcFb28vng2u+QWHNBWevpGYdTQEtWMw7XtcTDapb5crcoUzqHIUdzN8lB+oUrDVNgRb8WyYz/LaYtobGiRcJmiclypvbsmJEwPuk4inORJxXho9Q/QvkvHMAGlXAmIrDwcOqUsWCU7lxC4KpaNHjzSYLL9exhlFb/wEubvysKu05yyyHfhx5EYYoOwkeu2KvkmCd9ETobGOsfuy2P6LavvN8w+6BNt39gwcKGPKi8c99w8/+eFrMLL2llnZizDoYm+SZtmUFiqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stiyL6ML0v/njMFy9nqSkTIy55nMUGIy5nphZDA8G9E=;
 b=Mmq11VaOFe/sJplXfAtLVF/LKe5Bcrxde80dhfO20CYEeT8W/YadatiluFw3nTJHomfQ6qBeWimtFn82xeh0IHNJ+PrJBt3uQ9zxEzKwmOUOfwxeOGsNgzFMK/LH4bDDoai7ZNJLHYnxhkk7zBMyGk5lEw6jIdo26ytE94c5qVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Thu, 8 May 2025 15:53:10 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:53:08 +0000
Date: Thu, 8 May 2025 11:53:00 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 14/17] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250508155300.GB1939543@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-14-8ffd9eb4aa56@amd.com>
 <20250507193539.GPaBu2C_Gt7ksvRHoc@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507193539.GPaBu2C_Gt7ksvRHoc@fat_crate.local>
X-ClientProxiedBy: BN1PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:408:e1::26) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: c563e11d-ff75-4f3d-7d82-08dd8e486d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Murf0Ii//SKo99qE1UXDlL8d3BZBVsM17fb3lKG7slkXXGlIL/V8nzLwCp1s?=
 =?us-ascii?Q?L2DIixl5fMPjqBYHVbXP1dZJSXJ2uljfjf37t+gXv72rlvsOAKK5w7cyJf03?=
 =?us-ascii?Q?8f997+p+MklTDtQHqinGdKjr+9P9oTqk4SF1/tf5GYMTmfr2sTnLaHuIN7U7?=
 =?us-ascii?Q?hSlMKy4odTpTxiUmwLXL54ZXzQuLLGd2LqPWyEiwcCoefZwbVeLw0dgt1P2G?=
 =?us-ascii?Q?j58sXL/5r6qbDWKbYH0st3xSBf4tnWa6FHJcbtglGlniBk1Z0Yk12WK0ZEbJ?=
 =?us-ascii?Q?Kd+v1dKSZixYxHMLUO1NGPZOopUb0872ceJ00DaPp+XDMhkfhF0N8AEsMXL2?=
 =?us-ascii?Q?/2qo1ExWJ5otLI0Q6xmIKJgJwE04TTavv32kgdkQWfwW6GIognh5pfk9FsdJ?=
 =?us-ascii?Q?R26KK4/b8P4GFLoIxH9N/ZZ5VlWeKxOD2G5lerB3Bl7MUDqxP3rYDxeQ6cz/?=
 =?us-ascii?Q?a8ZzD8rVqKP9hDLE2T5dHMBGXb8vfMsMowDDntGv9VFDprfxBe6BOz7T02Z7?=
 =?us-ascii?Q?hxKNW56J80YpksKWJFO+ri8+UHxvCgOaadIEwpeSJZ+1Cbgn0nYOTmbH9gOg?=
 =?us-ascii?Q?84kJPD0p4BEEyPYzJaOkAWod0LiPyoTZIxLec9PjLTC3tgqPkPnSP/I7NqZL?=
 =?us-ascii?Q?NiClU9VIdw3cfzwKZYu6pYYXSeYpMhnMQ7yUk+jbWcqv1Xw2KW02e/Nm7IVE?=
 =?us-ascii?Q?ThAseAdcsYQBTa08F+Umf/su2Ai22d0C8GETyQ74JROMy5l2xGEFjMLPLIdO?=
 =?us-ascii?Q?H29raD68KVbS9mKGX71iAUdDOAsZ6NxxH7eEJFG6SwenXl4F2BB02ATNaA4a?=
 =?us-ascii?Q?q3++2UlKzmJFmM3u5zZAmY9f558ceti/S8Dij5HzVR4tPHnf5GU4fs+uBKAR?=
 =?us-ascii?Q?KHqQJ9FRgnxUeodM5VLBzTqMuU5QXzoCxccMmBl4getQw7/CGtmyqOINbdul?=
 =?us-ascii?Q?f3qvzcuoZPD9tC+n0reWDCd3thlEqEhV4cZw1eYqYbDIdyuj4Ch9c4ZF0SWs?=
 =?us-ascii?Q?MHXiUZ93EfTabvi91SFSvCdJBD8+pMBXti8WgsGCS8V5bNwFKyKRZT7EgCrZ?=
 =?us-ascii?Q?wWXZpUjEsXZ8tIxFWLVZLSmX8uO8/Rri7kWe7R8R30jY3O9rLJ965xsAYiBx?=
 =?us-ascii?Q?rsm3mVVjMLAuRr2ZR/lXZk1Rwe3O7/b52bIc9GU2mWiECCYFJ56QDD+ZiD73?=
 =?us-ascii?Q?QhbQ86uSYSj79iSparA9RuTJrp4cWO7JcmsKmU0Qielc2nXhsJjojJnFUmCT?=
 =?us-ascii?Q?k653I9zzYbVWAtESstPpwdTcjqszWas1yG0FtQK1AI6JijW8hYvSH+Xzafcq?=
 =?us-ascii?Q?pZyGlUPEyhSYurPR5RpLKxd68njHEcVFrPJYavd6gav9iUsY81Std4TCa/qq?=
 =?us-ascii?Q?2swQoqhu5MsuaAYSR8/lRzs/PJvUbtQ8UoKgr58C0DAANWMEF9v345eiPKQC?=
 =?us-ascii?Q?Tt/Ysgw/fVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgehHeHGLygL3iMHXgRc5mIiD3nFW1PEq3W4hIVHQBb2pAwgKxh9hc3ysfKA?=
 =?us-ascii?Q?PlkXbREYToOp76n4HZi4qyewkCi5anj9jOZnl3ihZB1VJTFdo6CeYvwAzXTy?=
 =?us-ascii?Q?zAuGfH9HyNHRfV6GfdBwxNsUtPaDiWN0PUMAZi1iDhe/19bxNtcIGYuzlxUv?=
 =?us-ascii?Q?MeNf3nzdBzmDQcSOIpzXPSWqeQ+xTiYsx8STZ1+KwHP0FemgkdPmjmmdMaPO?=
 =?us-ascii?Q?bUnF/j+8SlBLoDFUn7lJDcutZjbgdRGAbb2jcLYOAbt1JQa2uDO8+fnJuPu8?=
 =?us-ascii?Q?FiD9dh44/6sQu+ia5RJWLl7fVuLvSUo3zqBf9qBSbqiadeiWP8mUZTG4+ifl?=
 =?us-ascii?Q?JSFftRw6xuqAiqn6HB7Mf3zur72xOpX9bi+v2nssIfIy5TAn8Vo2cP8D/Zqc?=
 =?us-ascii?Q?Qpt39DAbqxKl78lo9NzKeBVqfdWc8Ru1K2Jva62GsrlUMK0tMNCXjXBH2ZEU?=
 =?us-ascii?Q?kp20csVNAFBVY2lOnV8WT0gY+B4KMsTmbaW5S5JHVaLfpI665MZ2CAAo5P32?=
 =?us-ascii?Q?UYb3yVKN4nOGasmCjfpAXiw+2xfSCED1iNloQFEfur3HERafJJDArRLoP0ec?=
 =?us-ascii?Q?2Egvsk0a2EJraAqz2u7kS7sSl0PED7vHCZktsktvxml6BdalJaXHtcCXTTDC?=
 =?us-ascii?Q?vwFWoF3qHWb3VTbdnUzuxsbNSqgky//1Yzl4WSEyN/kBf1LwqM9ChsdP30zx?=
 =?us-ascii?Q?oW0XzXbdXuztausKYLJ7OQk/7iRkQx+mxWH1zexyiY39TriUl+OEpdPfXIyh?=
 =?us-ascii?Q?ddyk23CxzGo3v8W214sEuLvDU6c3SdOIH6cBpAROeT0TxNQbYVepOx72jANG?=
 =?us-ascii?Q?urhlCIjCxLbjy3SfF1h25BS6LDGt/jQp4fI+iY1R8RkaoYyHENMeCbt0wl+T?=
 =?us-ascii?Q?q6kNky07YleCklJYEWWQg/2nGH2U+K4ZM5ksPmKQk1nI6f7JT0WCvNtgmcom?=
 =?us-ascii?Q?jo6OhHcQFFpEQ3lXhlrN1gYZdNH/zgJs4EWDkY6x+6nt6QATz8sDAzh4TtZN?=
 =?us-ascii?Q?r9LHAANdVCKUdOVdcgjcifUvop+NbheJJT97cc61UoKwPyUsN+MxnrvtIgb9?=
 =?us-ascii?Q?xg2nCp/f7Z+ZAmB56feihxqAuOv/679XZVcncjXSiVRfxCANPgQInJX8htKn?=
 =?us-ascii?Q?YxuhGIFmHeVD4VFm84xEt6a04EOXpq+yZs3IktCeRLCYv5+nuIIhzsTVRRLk?=
 =?us-ascii?Q?leRSDJ9tgH9G4VWiamNYVBoAhAAPzQo3qmsyxdLapi7Iv9EONHEE6pD04k7M?=
 =?us-ascii?Q?DMfWr6Bil+ISUOM89S4ZN6epcyFShC0662Yj72wza51PcjIiwGsSI+huqWme?=
 =?us-ascii?Q?Zsa34sgXwUZboDrMP8HN7FOxOYyo6epm0AUf8cpRifGm4nd6eBxi9PL2zG82?=
 =?us-ascii?Q?HuIvtsHcWrIS5TBAPbVgSrw1QusNpxKfaGWkOa4OG9aZgI+b7Pdu/b+eA3IC?=
 =?us-ascii?Q?zRb/Me3YQhyXUQyoPt9urNlJizhZIEYInnRs/n3fR52yxX1UdJ2m6sRqGQBH?=
 =?us-ascii?Q?r5kEb12uPO6Rl5F2Qk/+BDLbnophd7np3FQoeYxPPba2gI/uSLMv/xBIhyD3?=
 =?us-ascii?Q?mj/6LZ2MTCxoRJuUYmk7rJEVUrFQd8QItW8zPsF8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c563e11d-ff75-4f3d-7d82-08dd8e486d66
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:53:08.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+0nkfKoJNsTdFVHCu69zhRkHI7ugrwWQrkneT2U4RIIEeZkb5q6zTQ4olvKo/e6hTFo3KbPf4SxCl6M2d+UgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

On Wed, May 07, 2025 at 09:35:39PM +0200, Borislav Petkov wrote:
> On Tue, Apr 15, 2025 at 02:55:09PM +0000, Yazen Ghannam wrote:
> > -static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
> > -{
> > -	u32 low = 0, high = 0;
> > -	int def_offset = -1, def_new;
> > -
> > -	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
> > -		return;
> > -
> > -	def_new = (low & MASK_DEF_LVTOFF) >> 4;
> > -	if (!(low & MASK_DEF_LVTOFF)) {
> > -		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred error IRQs correctly.\n");
> 
> I'm not sure why it is ok to remove that one.
> 
> /me goes and digs into lore...
> 
> Here's why we did it back then:
> 
> https://lore.kernel.org/all/5547906E.3060701@amd.com/
> 
> and apparently that was for some bulldozer BIOS.
> 
> How can we trust Zen BIOS all of a sudden?
> 
> ;-)
> 

Let me flip it around. Why is this check needed at all? Was there ever a
real issue to resolve? It seems to me the deferred error updates are
just following what other code did.

I figure the reason to have the platform give the offset to the OS is so
the OS doesn't hard code it (in case it needs to change). These offsets
were hard coded in the past (conflict between IBS/THR), and it caused
problems when the offsets switched in the hardware. The registers that
give the offsets were introduced soon after, I think.

So the checks we do are defeating the purpose. The OS is still hard
coding the offsets. The goal of this change is to follow the intent of
the design. Sometimes we need to let go and trust [the BIOS]. ;)

Now we could update the checks to verify that an offset is not used for
multiple interrupt sources.

Let's follow up with the design folks to be sure.

Thanks,
Yazen

