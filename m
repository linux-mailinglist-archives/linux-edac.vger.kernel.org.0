Return-Path: <linux-edac+bounces-5238-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5050C15991
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0340402F09
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48F23446B9;
	Tue, 28 Oct 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GcOyH3xR"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42553225416;
	Tue, 28 Oct 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666200; cv=fail; b=LYzpujR5Zkxq+Pr8oj7NcPy0Ojl1ktfB08n/tRgdh2+fPAmYTZ3WJ32IvZaG4pn8dcRR7ldXpyU4UZQfkxoGVJULVsdOxX+b920njeZpvpp6g3NDVJE6QmZxaA9L1rklmqZfP02lpSHLdkU6ArWEDRqU0qvxkVHnhsY41YeZSc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666200; c=relaxed/simple;
	bh=oRzl0jfSBKpbt/x5kBXllopBrd+WDgghBn2mIu9V6GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YBn8im9UESTpaAued8wk/DV9L2GPXn6cGEzczrZ1OnyvZT/jnZPNHo58S2QgQEGnDxSirorjZZA7iIKwYJRHfnE2H8RLha1+fLITCj8nT+mN06pNnReIR/ULVtnVir8yUq0XbVpXxMF4fn+ev89ocKZe07Poylov0R8MU9ThpGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GcOyH3xR; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR6Thu1PUPBKtvUEKfx71TzBvYYzOS8+JW/Uvl0zHuuoJr/WhvtTgGkf/aAaQ28ZW+uQUqQ1XGpfNhqQW6pOpwPMP+QKH1TOcZSqqqJpplOx5uQ2iBXfxwEp1O6xPumzHPSc3geO7qzHxD2uagXTd7WtGd4m47VmSXdGJLlUp2/5HgD5UMWeLKp8CAyFjqp6BuMQdQRqzs3huoD3dWSAg7MwoGJSA7oI4AhmPmSmhi2/7/sh5746hG7rpHIeDWYnqA7tcTwaPTUtsfTWI3toN3bneMMeoxd4BoEeecLEAEB7d3y8M21Bn2w2VugoTgMiwHjMpEcJvmegcGPR7RKejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdmdK1tTj8zna7dmG8d5ZPRY1fHo6/gu6h1L9z3ph70=;
 b=KgRjpOW0z5DBXp2i/YV+QyV1J2c1uUBcekFU7ObwHefbiuOthZAsAZJABChx7pXo2oZNTGNQ8cH8OTaMHBPFet2v/RmZJiEHgqLDD7ckoJZ51XvILkwEzIPO+p2oenbSKTOY/wc+uRUmYLv5b3zJh4m1uyn/jb3AtGeCxcai4sSwh2UgtBdrI4FocvnccBnHYTduyeP1/LywC/NgSfhH5gr29mXt811NSq91fR7G3NFUO02w6XdUpm05P5NBhRWPovR42TEHMHysWfVVGae0Myl5PBvvq3QEccghzD73upSR2l4AB++oi5j+4zevmTbpt5mrz1kdsVGC3BEBCqahgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdmdK1tTj8zna7dmG8d5ZPRY1fHo6/gu6h1L9z3ph70=;
 b=GcOyH3xRvlSY+93k0uHUpTDA7kfDqdaRs1CLbpKtxf3w+B7fNNwlRyJloZ8tLfv47K7f4sYrWkMGK+/MnOpotFfAPIyd8WAM6gNWz9Xv2WJoJ6a/maUaUah9Rms6ceTaQJdrWECARfVZ/iASoGF045Xa2LTnUi9rbHjZUWrVXxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 15:43:07 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 15:43:07 +0000
Date: Tue, 28 Oct 2025 11:42:58 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251028154258.GA526743@yaz-khff2.amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
 <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
 <20251024150333.GSaPuVRQYxH92zyrmO@fat_crate.local>
 <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
 <20251027141139.GA51741@yaz-khff2.amd.com>
 <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0449.namprd03.prod.outlook.com
 (2603:10b6:408:113::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c87603e-641c-4972-59fd-08de1638b0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lsyPUhyXorVXtZaJLmQyNsI0LPiBLUbsV1rVNpOjLb1YO5DyQ0KTE3/2O1dI?=
 =?us-ascii?Q?rVqgId26SbeqQuAt2HcAPmLpRT4FKZ97MljG0vRpvnMQiCUCp/lnSBNiX/LH?=
 =?us-ascii?Q?RFu8oqWcsKL37JvK6NKiIS2HT5XDO+8wfEKkf0DqFJSHd13++hdhSJZqIQ7R?=
 =?us-ascii?Q?nyGmlpQvtvOrWYkj/LL9p+/Efi5ah+cFs9RgHxRIJoD+pqFHCSzrBBZHLdFm?=
 =?us-ascii?Q?bxoovWwMzAOkWihmmibYaXgTS5yB5uDrr3jXDSMkO5pswxU+DMgSbHekzJfG?=
 =?us-ascii?Q?KMVz5Jj7zpqTyBlZ9oy6XF6jxbGS/IoXWMq2i9xO4BYd43wGQKJcBPADfQyS?=
 =?us-ascii?Q?II33n4kT6vgbRsifEUhoWnfXKUHMAWrb5dvKiBZYyPqHOhqMkeDNjrBGHDQL?=
 =?us-ascii?Q?gf/6Vwa6I0LGVfZs0YBXGxzqGP06owqsM5MDryI6HvBK5feaLd6WqqRDdBeO?=
 =?us-ascii?Q?gsTg0Ota7lDMqZHnNFjXji5OXc1Lb6uQhwD2isTuGlevmFVYWbZ0WD39pgBX?=
 =?us-ascii?Q?BXBfuk4DN9oNaWk2vL8FGkZboK1bhwCi2EhG7o3TZ1IWoY5lCAJQ+JI7V22w?=
 =?us-ascii?Q?8fxDGKV/Gz7mCGeL0JyteRMnRa9DIwZrHVifs4uRXARljOE/xJT7p/FVtGy9?=
 =?us-ascii?Q?CTiV3eH4aghdu7CcH3c/DVK0rpstmEMggKjAtA5Yz0U0HeDe5ynGcvygExPZ?=
 =?us-ascii?Q?9OMsX7WDAPFzQWdTF5MLypwvgZxsNp9wKlMPblLAn3fXJHNWqw41R9MC3E1S?=
 =?us-ascii?Q?VfrLGqjZd+5YzQozCxHmMWnVdnPzO3gC2S8rN+HeYRoxkIvLuG+Zm1KNPx5T?=
 =?us-ascii?Q?MaUVHCZCaGK0YZ7PR+8vFSMDHtk+frjiWdPeIjIpBEHrbFNHm4vj5jmM0M83?=
 =?us-ascii?Q?XposeEh6oHpE6/p1JKwIDSPZIO4ssi0mvJ5bfUAF2Z11C3dPwPthziFmOduj?=
 =?us-ascii?Q?AH6K2bijRS5Abq60AtYhl3M5wmxgA+yQOUXkfSDQAcRmrnC4ml48d0QH0HKh?=
 =?us-ascii?Q?xD4rjZ9i2WqWM9lndcg6PWFTMq/tbxnS7NFvly6qjX3LTXI3CqxeUJG5S2Fa?=
 =?us-ascii?Q?8X/uziwso2ORTOZMh1zk8ZZm7s7eV147IyyS3zcEBv7sNUEwavwr2/5GFviJ?=
 =?us-ascii?Q?xEij1rmxwvacxJ8WKwhMsI8o07IlEs/kJ6We4czvigJxOnwBtEu9lDvsRLw8?=
 =?us-ascii?Q?T1wRMaUzV62+mPwhozDed7O1/z1yTe2W6bg5GgJS1Y3IYAyDYxdp2mbVvlss?=
 =?us-ascii?Q?UT+v0FPOENF6qK1CT/mPvTsgACSibH5C6cwj1SecB7rxBrF9Rc/sIoq90OYt?=
 =?us-ascii?Q?Edb3sdpzJhWbRkvTiKdxJ24ZmXjy0nLbuI0Yr0/kun+uZTghNmkyG0FYooCw?=
 =?us-ascii?Q?voDeQm0qWJ8FAJgboCl+r85yKRVHhH5WAbVO/HPQKK7oW2mcdco6VDGajl6n?=
 =?us-ascii?Q?JdnhTNRYI5mNrmlsTEEPLZl5FQZuY/OG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpadI6pSiOq0duajYYvmKQ1F42MYpiTOEK/W4T3iMaZxweDeejSM4pKHglg+?=
 =?us-ascii?Q?2OjYU8WaISOM3NKZGaChE6HL9a0X429EssM4in8r/SXqDcmSZTs7MlZJYhka?=
 =?us-ascii?Q?TgDm3794V1wOmzAvbZoTYNpd0pwU/S/Cd+3+Aa6p5cDReUOZapVlk/BWGFX2?=
 =?us-ascii?Q?hRR6RsVS5OKfjx2Czx+OGgBXJEQ/6Dl4SnjpD4Xg3cYVtX+PhE65t1YVHvx7?=
 =?us-ascii?Q?atfb/WNhkuJpoPZe5rfFKonqHmixIH3MTzd/uDUBlGwc9IW42WOtGzAVAK6W?=
 =?us-ascii?Q?8UFRVkaEGKCbsdF2MOlkK1cOG3UQ64EzkTZCSByeb8d2NgiGvv0uVrppVGcF?=
 =?us-ascii?Q?GlKNuKno+/tlJ5U3jNrjDdhs7exACiL2f5gWaqWvdRCTfvebgDATNVLV8muj?=
 =?us-ascii?Q?7dInLNnl13BoGkrhssly8nxu7GjiQ3d2JGbg4hbmVmKpVLiKmgVmwnbIcHVH?=
 =?us-ascii?Q?9Sbg2fPYf11lv/snyWK3zdmL17K1joECrlg4eWmpjSULaSLhhRq4P8YgCIZc?=
 =?us-ascii?Q?kePgWZQ/xqHCRD/qVEj1w+bGQ5RH0+3j5el0TbhTdNLa9PS9kLPtu9R5/MnP?=
 =?us-ascii?Q?UHWR9HPwi5F0b2XiffQnlBAKxq7FEwTrEO5tg9EcwvefPLh+xGZ/+2mgIn7I?=
 =?us-ascii?Q?x1E6IegmR1Rsjim4jh6aJHDF24LnseL8i0vOdp6BxmSf73maTYfTRtE/HARD?=
 =?us-ascii?Q?6tsRLGzHZrlTLhG04lqb9z5B510lDQJbl7RY7OJX6kLS1ExWnRf9YuJqn9P/?=
 =?us-ascii?Q?Gli656KAewmBaYLmPG80ImBfeop+e5nDfJKABqn1cbQRkvn3MWQRwAhKesO+?=
 =?us-ascii?Q?AbQyksZxNuj/2kkX7kNLg6qMR/gyZO5hQ2RTaMlfiiOZSYeUUzwMKSPiQrHu?=
 =?us-ascii?Q?0DKxyuGIn5g6bizZ5FvJvx0iBlIGEz6QEXaqTIKtcGxaN1faYpfgbdg5XiU2?=
 =?us-ascii?Q?/KZ3MIVv99Zy/OAdQTqffGhWWY08Kwa8I9r5YIosw1ihekmvo3wgUZFfpVwR?=
 =?us-ascii?Q?LyvP43KqwXBRW0eQiQWDbR37CaCKuPQ39TppTHsdUHanS3Qto9zy8VKdKboD?=
 =?us-ascii?Q?GnUWoExFiZxI2+kZUzaHCAIrtovPufxyMf120Pj/FfXCPcwdf/hHl7FN8DZu?=
 =?us-ascii?Q?asgznmzW9sGZbKJpPz28ko1t7lXvJPymuVQjhyjdZQ4XIu/ANhEZDFGbHQJR?=
 =?us-ascii?Q?Wke+uxm64cToJpOgy6rL8qwp/dSfr/ZkCb3iNcZmP0OwqjZg9R2hJ58MRBid?=
 =?us-ascii?Q?CVK0Lqvv3OfoBZKZNWPdsdUZh6qYnoBS4ma0lAOVLHHAPEvRQBO5GyX5rG15?=
 =?us-ascii?Q?0xafkvfwVe/qgr75ey5tZwhkms6vdFcEnukbJr2kwzPTqvrMBOWc3i6R2SyM?=
 =?us-ascii?Q?KSrpb6VDjHPCFpO4pqRX+QOzRrMrfNAfcW7PAHG45j2c6F+OeO3hAC/OgFMz?=
 =?us-ascii?Q?Bl1hIEjZbFKnceuv2ukRjiLKZbc5iWD4sPoa9nwN7SoXbY4ai5Ovyxmv96yS?=
 =?us-ascii?Q?gJRux2+kRRGGe7hO+Y8qK8km0JoqEErePYNL3r4lOWdIuaxlhpUvw0z8Wfwe?=
 =?us-ascii?Q?FiDAn3PvxqxggBrIYnwoDwiOHby5qUt9+c501Wlk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c87603e-641c-4972-59fd-08de1638b0c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:43:07.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFdf4/YtOoGQNmGsqoMiy0jisn7SmfKll0/bGaS8cB2RGNZA3dB+Vu/kFXQif7VjsIurbgwHUjiLC5YcK1gFlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

On Tue, Oct 28, 2025 at 04:22:31PM +0100, Borislav Petkov wrote:
> On Mon, Oct 27, 2025 at 10:11:39AM -0400, Yazen Ghannam wrote:
> >  	/*
> > -	 * If the MCA_STATUS register has a deferred error, then continue using it as
> > -	 * the status register.
> > -	 *
> > -	 * MCA_DESTAT will be cleared at the end of the handler.
> > +	 * If MCA_STATUS happens to have a deferred error, then MCA_DESTAT will
> > +	 * be cleared at the end of the handler.
> >  	 */
> > -	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
> > +	if (m->status & MCI_STATUS_VAL)
> >  		return true;
> 
> I'm still confused by those comments - we check VAL but we talk about
> deferred...

Yes, fair point. How about this?

	/*
	 * If MCA_STATUS has a valid error of any type, then use it.
	 *
	 * If the error happens to be a deferred error, then the copy
	 * saved in MCA_DESTAT will be cleared at the end of the
	 * handler.
	 *
	 * If MCA_STATUS does not have a valid error, then check
	 * MCA_DESTAT for a valid deferred error.
	 */
> 
> >  
> >  	/*
> > -	 * If the MCA_DESTAT register has a deferred error, then use it instead.
> > +	 * Use the MCA_DESTAT register if it has a deferred error.
> 
> This one...
> 
> > The redundant
> > +	 * status bit check is to filter out any bogus errors.
> 
> ... probably only confuses. No need to mention it.
> 

Okay, agreed. I think this entire second comment can be removed.

Thanks,
Yazen

