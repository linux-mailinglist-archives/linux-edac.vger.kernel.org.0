Return-Path: <linux-edac+bounces-3241-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE5A49C08
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 15:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038D17A1532
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F126E63B;
	Fri, 28 Feb 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IxWcGWPp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C507E26F444;
	Fri, 28 Feb 2025 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753000; cv=fail; b=rPxeKLKE2TcM+b0pZJ2OpkGL5i7T6gvHrWDKqCvR8magTPHVtZ0JggUqBa4CZpVqFH2O5dnSP8zmwjCaeHMGkjRTNzdljXRJgGUMJ0L13+MN9p6yXdQ/V0kEWY8HkIb/0kz6P9rQhBOnlo0EQXYeg7zGYC87Rvk5ZX92ETxJmPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753000; c=relaxed/simple;
	bh=xo/b+XG86iXfXWFci61LpFDsl3Vuu5nv2aomjFU4pu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FXvteLfkOuAPzry5gdqwTY8MgmJIkhzkz1JYFdzcmEpFweec14rsJgEtcvtSxuSC3QtOtKjJQBmgU7mV/1rMJ9sIIGY4bM352k5+z68WuvVnBrhrGawYd65lLA9qcoLASGBj1wlFFsJfVn/NQL+wPjUUYjgdKswn+LiZGOQB7Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IxWcGWPp; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kp8uKUrpsXDN8LDld0cNqFiQ9OSEeqGUGRfhw9KHlz7+JDTjqrcAM2mu2lr8aOIfou9+tMVhLGFZlKUo98Nd9KMtMKTQSGvwyIT/8y3St8rTP5kRnPEIPJ08krlHDNL+FQIMi8NVMmEXk2kkzm4+U0YjHfEzmUwyrVK+PTsSK5JzczZtgiWv6NuUUjGNKoUmvzK2Z5GK1ke8lulh2zqu4EbmJMEeDcFD5M32pMdVvusIL3cG6a0VUesmvOP/mxOuUeOdEeTT0E1EeksbWxIYTJqONyK3kut20asLNw3jx4tWlro65G6KEVY1Jt3DblqjZy9uQvdcsPVxunzcISxgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxmhKJrDS5dYTmlwm+W0hY5YlyZMQr9nq5Pz3eitRQ4=;
 b=mPBrTfq6T+cEg2NWsJyjZ2VKIqs/Anyg203EVMTtdiDzQb7vy91CTZKYnF59LkOqjM1+BZwLxzPR6IaDN+spvLjOSja+hYqZh5zGB2E66uB9bhxOqEAHtArWQnD/c+RIVLA/YuRJ7HTd/0Bq5rrf8q5eRwQAfNh8AOh6Bv/85atDWDjftOO/og5t2dUnUbWpKLszDwwkrwBb7K/PlLz8mzDlGYohFr0eIEm38pVEnm0ydTjkTu/FuwaMcZVqNNe41WxEBnZQHbI/JehjNFH/ZbSS0QH740FEe1phm3SQ3aR3u1+WhxxUuuapdMR224sbMzfHcpwtUUsKt7aNviRgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxmhKJrDS5dYTmlwm+W0hY5YlyZMQr9nq5Pz3eitRQ4=;
 b=IxWcGWPpABOgmf9aKxNxpUwlLXVa7/QLyWowNnbmlKj+Bsvlqsa8xWfWne7eiqWBDRNQyJz+szKXMPl5s/aODB4hOdjpyMIiU5K1kxiS8JUXLznI2KUlEn1pJ4oAZcC5+rZtYwvfjadtnb5vK2LaDFASfQTeVou5unFM5G8BN4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 14:29:53 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 14:29:53 +0000
Date: Fri, 28 Feb 2025 09:29:53 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Message-ID: <20250228142953.GA1053941@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
 <20250227152500.GAZ8CDzEBRWBUukmcl@fat_crate.local>
 <20250227163148.GA785742@yaz-khff2.amd.com>
 <DE184F9D-EF80-4A88-9275-C900C4AA13D2@alien8.de>
 <20250227195933.GA936031@yaz-khff2.amd.com>
 <7D626975-3F9C-4B7F-A1E7-FAB3B02964DC@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D626975-3F9C-4B7F-A1E7-FAB3B02964DC@alien8.de>
X-ClientProxiedBy: BN9PR03CA0395.namprd03.prod.outlook.com
 (2603:10b6:408:111::10) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff80443-8e5d-4b0f-98cf-08dd58045dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?deHP1pKmFhCbdEJvt2FDGRjLu7mdtAgttF+4F21OkqvRnTQjUFbFn9XSWVpj?=
 =?us-ascii?Q?KuR35vPyQeFDrgQjxM+Zcm3ok+c77aKk6vYXRnu7UL/ARX4evFRry169J/m3?=
 =?us-ascii?Q?FqvWWkSnL8IUiUCQ4hTPocAvD2WEUShBWn7U90d+gwWAEmXNsiALQ1MZaWcI?=
 =?us-ascii?Q?PdiGuNk+RFwV4hpKG602qF26YPgIMgssxnD4auGI3mLbSbwyv5GPuFNCUE2e?=
 =?us-ascii?Q?q6aUDBbvdwnZ6VIq6gMrTwCwJj+IBLS4s+Gejyw/Cx4yTFElXmNPseyaw4PN?=
 =?us-ascii?Q?XHGFRKfjQDrWKNN01+tTpEDBzjBfv+/fYJmlhtMapxeha4wEK1y+l9Ij+mbn?=
 =?us-ascii?Q?puyLZivwyYh8cKwWr2eod6XIyKMJXIB+Rlck9dHV9wrmB+n3lUMttiYLznL7?=
 =?us-ascii?Q?F57D55HBAN8weiHsOfea1dZ9Lb4XrQFY1R+0KYayhPRuzXszUkIooalk5Vo5?=
 =?us-ascii?Q?F2rpzkIuKSOrD925G5KRL8M3y4kVSulllKfggGyAXxUVJPOEtzy3FwJ0Q9Aj?=
 =?us-ascii?Q?DYleZvx8H0wB3N9FVYciRRZGfIUtVHF+IDUzdMBVWs77Ae6ADGW+JoOzBduX?=
 =?us-ascii?Q?h2ax6/6QuY75rBYhFWVDh16f6yMpk742zvHSUEvudqA8xI3k11cMSF+gCXkQ?=
 =?us-ascii?Q?MFkj30zXtSQcsojbhCL0ZAcQMsn/yU+k8Q9/F8R+4Sq3Nq6ByWDt097Jzalc?=
 =?us-ascii?Q?CE4p+DSfMMaQwQTY/eKsHyVVlI2CcD9pmMlmqaR6Ix/6jxVYMSPI4CwDb+wJ?=
 =?us-ascii?Q?D249rUrmSaJh9fMzD1B8aywKECOFIS5kIdwU+t7VNBeYIexUxFH5RsMiUYk7?=
 =?us-ascii?Q?PG5DtJu62u6roTTbbEPSiN/xuPWVIzH/HSeGDpNWC0lP0aB0vrAPVIuoouuW?=
 =?us-ascii?Q?N6ELCO6fbDVgju6/nJEvYli6tzv542+5mLrMomI1WFnvqHQkCxYo2X474/jX?=
 =?us-ascii?Q?WfiUR9h7AkWuwNcYiYqHtmWcSwlG1bN4QV1qMxpfio7oJZE5KqsIwWWikTVm?=
 =?us-ascii?Q?qjTU7HuMFt+Qjs5OKuxkoIlljnwviv8tXBZL06NMlLBKjn7KfLsYpso5pmcE?=
 =?us-ascii?Q?3em5dbrfvd3EI94iRP1rS2yfJav3/iR9F/9L8mPtwsmLtgSo43Qoz9yAS8Sl?=
 =?us-ascii?Q?qIEHfbwWekDpSnMN1xuiP1z8mt55l4bAOHZ1eUNrTv7lxh+uBwItgMNtmPQq?=
 =?us-ascii?Q?PeqicSauyHTjDV1FoZZRM2xUf9UF3sWVCb6PswuAdvv/JjzPKp5ijGXTu7a/?=
 =?us-ascii?Q?j9MEP1XG4Wfa09cxQXqe2TRqMul+EcWva5mcNNOy0cxZJDWDLzULss8dUNsQ?=
 =?us-ascii?Q?hgqXPffIc4W7eFob9zGLJx5WSKNJFhciyIAYxtdGZEKSF1ABT3vH1lZ1K/bb?=
 =?us-ascii?Q?NYs9MUOdanNIQATx/Ql/9eARV/1ZvxJXkZjNKHR5hcu6Xll0jw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCZUQwQYb1m9JKxujQkWxspO/nrkV5kFrQ6VycIcPpABsyGuJE2X7Z7lHAgL?=
 =?us-ascii?Q?vpAqFH5q1Ba9yfrn8IR162aDr6sgkpzaniAU+BagyC21gHWMDSAp8Ro9LIsu?=
 =?us-ascii?Q?pn+VroMAitk3/NkmmWP951D1p2uDjAdBJAaoEAzivZpc195pNZh7bW0yCPJQ?=
 =?us-ascii?Q?DTluiYV7OfP7tgf4ny3xsWJmJqeuAvwnmKk+EJYOWtwaiQBIC+8UqxxedTDP?=
 =?us-ascii?Q?WNoCwIB40C+Cgj6Ak9Lk0gdv1tI+xNJo10zhiIeGCcJxqOQ5EBz6UIqOwynT?=
 =?us-ascii?Q?BZioginreauY+OUTAnQp7kafWlKW2ZnAkuvaV2kjXSYMwpiq//1wxZXehl3H?=
 =?us-ascii?Q?qlXBZZioomslT5QnD7P8UCIYAVTeHqrivc1WUrzslXUkg5NDdmyrwLjwu5eH?=
 =?us-ascii?Q?bNa82PGseBwRTcZ2xr1hHzJdLYiiiaxh02YyjJyxMD8nVmcjwRcXR8jpD+hH?=
 =?us-ascii?Q?ueRtoWuN2dEaHsAkdjHuotjdcf4hCszqxyYZSpek24hG6U+w5P0to5cd45/v?=
 =?us-ascii?Q?qt4yBdsZcdXS1Aus9hIKt0O6RrMVrs4CLI0FNPDzJzocUitk9xvOV1jZM7/E?=
 =?us-ascii?Q?Z9GewwdotBoBtP7ccoWzroDYymCrDJGe1xvY0nOHcWq27iVrsgyuIja+FYd0?=
 =?us-ascii?Q?j8eE8gOw3zN21Rs4u6mysi8+9UlO2D6Xe/ahW/fi2hk5TYNeHDDuH06GZp4r?=
 =?us-ascii?Q?yJC/husKp7ItifgIyG7v34UQHUmcYfGi2QYRRAIBoMYDQvptKwyAOZxRS3HT?=
 =?us-ascii?Q?ySfalxPmcdFHafPXHirUXGm6BbNJNcgdYOFCiRwJweEvc7P9Txvb8SMXm1TB?=
 =?us-ascii?Q?0HktNzVMaef/eo6sRI52iy0n2pnA3D+FLZYCI9/iHEYzbg/Lez1FbJYGIquZ?=
 =?us-ascii?Q?5ZUKE0SQC6pdCX0oviiwScyLCXRo1FLrNq0mkJIGfkZS+PZ4H9Hk3E6We1l2?=
 =?us-ascii?Q?B5RRBM3nZbs29/hYJbyBpubQ5yZ612HvSaGa4WEsmxhQJsH+GmJ2lN9FBk8c?=
 =?us-ascii?Q?XiIpRu9/vSKfuAavvC27hRi86LsPKgURXvvdLOReUdPqY6vUie7QuE4MsDAv?=
 =?us-ascii?Q?L/MQkXuahE6PgBAaBCcpSt19a3d72HSVZ2CqUhFvi/GYCgVzFeB4Br66yFMp?=
 =?us-ascii?Q?aBIEi1EX/wMEUejF0kJsKKVTWtYQL8dV8tP59iMRilucztj1YWIjinnZwNCH?=
 =?us-ascii?Q?zgTmJa0WkCONHUang3GF9/+w3h06DGbDybvql8tDSOXpXyktFPwLmuq08I1n?=
 =?us-ascii?Q?ID/W0g2kiX7Z12H6ZV6fMc2O2pBacV/NlUhqfF1UUaiTgJiaoY77Tpcu3rMA?=
 =?us-ascii?Q?m/huyi4vhpVhdV/1gWj2wt7UvN9KrB/r+8DSzvmylsMXwAabDAfF1PbvYuh0?=
 =?us-ascii?Q?fH/gugT35gBr3YjHJV1PfYZEVhhOLdA1xNwssvQsHdLPoxYRwNfv1iBWwjcm?=
 =?us-ascii?Q?96nUUUWPOAbh0f3ehldeK9gmsdKYmpk5tY5FstBP6VXLrqLg/E9d1T3oMF86?=
 =?us-ascii?Q?nyNmoJvOl/nBFjAF0yC9oMGvL14QBZqnUztojqPBivh2c8IyY9cSN3v1Zrs9?=
 =?us-ascii?Q?RaAI77Wr0VubPXR8KLNdQqvmEBEPX4W/JE/9DOdq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff80443-8e5d-4b0f-98cf-08dd58045dcf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:29:53.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1Fvwgysv6ef0bL/v2trBUt7hLddq9z7QpTl+8+Z/TJ5kdJZqCZeZZdXM7pvE1/3ddiP/K3MIwJ739p093hsKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8

On Thu, Feb 27, 2025 at 09:48:01PM +0100, Borislav Petkov wrote:
> On February 27, 2025 8:59:33 PM GMT+01:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >On Thu, Feb 27, 2025 at 08:33:19PM +0100, Borislav Petkov wrote:
> >> On February 27, 2025 5:31:48 PM GMT+01:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >> >On Thu, Feb 27, 2025 at 04:25:00PM +0100, Borislav Petkov wrote:
> >> >> On Thu, Feb 13, 2025 at 04:45:55PM +0000, Yazen Ghannam wrote:
> >> >> > Also, move __mcheck_cpu_init_generic() after
> >> >> > __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
> >> >> > MCA polling event.
> >> >> 
> >> >> The reason being?
> >> >> 
> >> >> Precaution?
> >> >> 
> >> >> It was this way since forever, why are you moving it now? Any particular
> >> >> reason?
> >> >> 
> >> >
> >> >1) To read/clear old errors before turning on MCA. The updated
> >> >__mcheck_cpu_init_prepare_banks() function does this for the MCi_CTL
> >> >registers. This patch does this for the MCG_CTL register too.
> >> >
> >> >2) To ensure that vendor-specific setup is finished beforehand also.
> >> 
> >> That doesn't answer my question. All of the above gets done even without shuffling the order...
> >> 
> >> 
> >
> >MCA banks can start logging errors once MCG_CTL is set. The AMD docs say
> >"The operating system must initialize the MCA_CONFIG registers prior to
> >initialization of the MCA_CTL registers."
> >
> >"The MCA_CTL registers must be initialized prior to enabling the error
> >reporting banks in MCG_CTL".
> >
> >However, the Intel docs "Machine-Check Initialization Pseudocode" say
> >MCG_CTL first then MCi_CTL.
> >
> >But both agree that CR4.MCE should be set last.
> >
> >We have an old thread on the topic that led to this patch.
> >https://lore.kernel.org/all/YqJHwXkg3Ny9fI3s@yaz-fattaah/
> >
> >And it seemed okay at the time.
> >https://lore.kernel.org/all/YrnTMmwl5TrHwT9J@zn.tnic/
> >
> >I don't think anything much has changed since then, so I included the
> >old patch again in this set.
> >
> >Thanks,
> >Yazen
> 
> This is exactly what needs to be in the commit message - why is the change being done. 
> -- 

Sure thing. I'll update the commit message.

Thanks,
Yazen

