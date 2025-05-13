Return-Path: <linux-edac+bounces-3903-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBFAB5E3E
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 23:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0840B3ABA1A
	for <lists+linux-edac@lfdr.de>; Tue, 13 May 2025 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1231F3B97;
	Tue, 13 May 2025 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rqpIVWcR"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA61A0BE1;
	Tue, 13 May 2025 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170414; cv=fail; b=lzVZS+/Q54ZRLmy43IK8dlWCrSzURvZqINApY2pU6Afu/Wbb1cCGyrlQAbHT6KL/6arImBc+WaQLgT13QJykonl/qc8oIeavm8zspuU3MN7YkInKYkJSn9Ur9f+aNT5Ws8z2Gm35oEEXDwZ4q6jcDPZrVAN0HFpZq3kDmQhkMcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170414; c=relaxed/simple;
	bh=cXwp+WbFsJiZaEz1uJTGaQOyfNtzbo5X6n8i1tS17Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ilJxhjtsA189rrLrj1rTziuCqH4R3MpEv6WnDH57WGOeD/v8W92VewIKYQNZHBcioGZg5sVaAoEoxOL9DANLpFUXAtAfMEShOpkqpsUMsCAhe6/065mR0lOfopXk+unFxtRdqpw9mX6MYnPPFF7kmkrbzizusPsIDBIN/uLAovA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rqpIVWcR; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVnBj4J0qKId+fQIoWU1rCbdjw4bPNCSDEFXUptqMx/5DMp9pPVMrIRi1EEnOOH0pQ06Z3NrciEMAWecI4iM06LULwkroftQNKuWpTPzWnP3VMNyH9EV8B6vXZDkXGAKUIe3g12+A1vaFIIg+88oATul5A09lVQfqr2YwOfkBqRRKeNEZ5Epd/F0jXpQ7UIWgVpx6MX1l34sADvcGh+/+ec6RMtsNMCXsOYSoYGPr1AUVe/H9DpLbII4p3aPS2GJ5N3JoUeQkGnhylq2wdLCjMepl/WLWp+XiR4URyUfJT2iKrOjrGWu8a4oSSZH518n8BtBR2rsHH1pyz5Jo+W3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT137LxKok42X4D3Kh6oFtLLh2q99JnbOUGiu13jUlY=;
 b=grxHIvY9Vsn/3LcM3NyLQKbvvskvktQ4ivtrN0qqqM3V47prqzOBL+M5g0Vx8rhfqKdgVcIs5l3zuWDJzpl6fqriwFJ1r4ra8lC1XvdRy14BmAvM9A+w5xqmfOMfIh0smjWSvkhZpmzNw61ucpD0lxzvIykpcs18cYJzAHRj/1vw+smjPqRrhoj0cTFhyvjNSB1dTR3bCmGmPyTEsUY4lMBh1YNQDmC3JJCiEWBLi3PiPtO8pQWW++gCCAKwQFeHya+EzbosPPJlcDBGmxWBVK0TATFalranAWOtKWhdmCPaFDQrfkYj8UC577dl9NVFhmRaqK8tlttjqy0psflPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT137LxKok42X4D3Kh6oFtLLh2q99JnbOUGiu13jUlY=;
 b=rqpIVWcRrsZIIvfnwgQnhOZBPR+NHYu5jci8E3M71Sw7XT1jJElyySXS5BEq1e38N//62yjC+i+s8leLbs5w4cD4OOlCmoEnzJ4JQAZfujRNXiKK2U2Wi1F/r5egVDih4m+ODPF50HuJKhwLPE9kQYUyyQ1JSngmp9wwOrlPbOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.35; Tue, 13 May 2025 21:06:50 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 21:06:50 +0000
Date: Tue, 13 May 2025 17:06:40 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250513210640.GA515295@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
 <20250513175543.GGaCOHn26isB18J9ig@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513175543.GGaCOHn26isB18J9ig@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0569.namprd03.prod.outlook.com
 (2603:10b6:408:138::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: f43acf37-eba6-4991-59d1-08dd92621415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQ8jOBIB6H/ON7q0jN45mwb9AG8sOIZTDtq2GOfRv/+y4RgYfzipIP885u/w?=
 =?us-ascii?Q?TAYxDFdobsbopiISM7w71lt4KEFT7ul5bTm6iNVJYNz4fcxEe/tARKJ+RdQE?=
 =?us-ascii?Q?XQfc+wxm4YH1iudNnkpxqfglFNbSNDcolXOTPa2EKx1Z0dvuu2OdSFNBIaba?=
 =?us-ascii?Q?8TSUf2PKCMdL/2cXByLX+eSeZAlF7rAxAr/fF6/zm9E+otaqOHCN4BvXFSOa?=
 =?us-ascii?Q?JZGkBfeIMYpEBhNoApis71Ghz3mtQ4ZWOsc5i2ZYAKpXhkR5UHupVRwxFXQO?=
 =?us-ascii?Q?TC/UIguSlqDfurAkPAQKHX+dIxVRr06aGCFI4WT+X1122PSoxH7T/0JlcIma?=
 =?us-ascii?Q?CqKk+lWLMBEYm2qb3EwFV5DgDDS+A4hLcbgYd5Koj6X1VMVYpRb6LxGTrgoK?=
 =?us-ascii?Q?TZdqKVegDRmrGSvXbaUY/GJycGyTK6Si/Kx6nTybFZYiXQEqXk/J3Dk7h1S9?=
 =?us-ascii?Q?+9YRLDryYgwSVBYUr3gP2qv8Xl0CmZqOfiHabrbzPrNBx0z/Z+TY4Qk2rQeW?=
 =?us-ascii?Q?hLUaAjU879x85AjiCDhGXOLUybIUBK144c6W53pQWN9IzvPuenyOP3V92c6p?=
 =?us-ascii?Q?i3t71NuyJIUs3ZyTmXmVG6Sa7yZPone90zkaTCIbkGVNGmQyv78TzJRbEwkU?=
 =?us-ascii?Q?yZCDd+2DeVmrdYFGS3nXE2LYGQ5fEf6ti0TesuIxBxOkk8KDVktpdefs9/jV?=
 =?us-ascii?Q?+NkG10vWR9yg1XVF3L4lrDXzZ5Jau/uZ6hdZaytMxaSHNdRarufoffAvTk1F?=
 =?us-ascii?Q?VBlvumDiK7qvGvfCtTpin9Dol/OsoJgDDTm299GMc299E2wY9x/A6R1DeeYX?=
 =?us-ascii?Q?Qfr6AwPD94SIYWZ1FDaNjUdJCCfQHbUnFDuEEb2PoWKUGY39cK65V+uPvZom?=
 =?us-ascii?Q?IO8Ermx+Qs7on533h+6cW7RiOMjPjnCqyuW+9hpBDL7EhPAXY3MEqp5QKcyI?=
 =?us-ascii?Q?6BaSUqURQ6Ky3yFx9+I0h2CqI99IsAoc05UXm+L8J6tHRj7+O1STQMMNixmu?=
 =?us-ascii?Q?++EmxGdOcsEX+30qimRl8EEJddNaKrig1eg3Xc1ziYVFnyFLwkRrJ5nqNzap?=
 =?us-ascii?Q?dbE++vg3zw3IBPGucsEFZ/Opmy2shjWMMsTpC0IvR/uO7EQK+vpZtqxtDeam?=
 =?us-ascii?Q?2lSfmRIrJJAPiQJdTciK/joYqbZ185ngEpAN/4LiMZosvZvVmuqQ5OhpFkiT?=
 =?us-ascii?Q?/lGcwGIBzhoASu8MhQ+0BjYZXM6yEgycTzIvsrJL/FtSnpkxZ7/XmYEUT4vM?=
 =?us-ascii?Q?2FumoASbbMOT+72LdiGJS2owaNZxUd3PnXq3Zwix6pGjz1foboe7+BFOE+aE?=
 =?us-ascii?Q?iBbdl/2VHXqnXEqd+7kx/Zw7BIpWitBnDbaBNnl4o69j1/N7Soik8M5EPQx1?=
 =?us-ascii?Q?QVJGdEW6myb+mYQpAPoQPm0gVYgDy804vfUGy7PFm1e1XCm2xBv90tSNAIFc?=
 =?us-ascii?Q?5tuit4mZoj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y2GPF903BM/86O9xsBuPM0Bei2u7dEQLFCJMm1Erbsxc4yczjgxfG58XR4b4?=
 =?us-ascii?Q?lhFJg+oaZ5YCvzDwBTY6G0MRaxX9U9DOH6J72ikovlIB6rvmKXaAm9P+www9?=
 =?us-ascii?Q?101ok81b/YdGWQWw60QgBT2gOPue+WVo2aDpVedjuJquvOuRS7fX7qB3Djm5?=
 =?us-ascii?Q?fBFpseXlEcJZ0FDHab5M6AXraBZU9xm8QcoYVcO44wEBu1wKntPJp8cQv66d?=
 =?us-ascii?Q?vpQuTL0JjB2008Nat0nSVGmDG59/I1Olu0qipAUC5wJKfHbU6LpT5CVgnOkz?=
 =?us-ascii?Q?KuE2hA3aq0+j6gwraUoryn33tsXZBdKQaxwEaB/hv0Hk+At5ZMMqYW6FpErk?=
 =?us-ascii?Q?KiHwvb3wTAVBSjHZ6LPI90vYi0wMub4t48s9333USSl/jIpqgtkOQ8B1f8T8?=
 =?us-ascii?Q?GBC7Tf1ILrX8hNtX9GqcLCdDQw5fODXvFSv/VxCEG5oIq2q/YMkhWVrVwvB1?=
 =?us-ascii?Q?VKoavJ1xnTh/WTTOv6THT3gsrUIaSVlbH66K1DUrhw8bT5jj93m20cYNlGCU?=
 =?us-ascii?Q?SlZOqEnVUI674EnhfB59RlUWerFh2BQDrORhnigWDr6WEkmNQGk5HWufuHXj?=
 =?us-ascii?Q?rj1wezsLboyIhGa+F4147uD/wTgG3PLdZIRfOYUuLn5OzDigfzb9v1lq/Nq2?=
 =?us-ascii?Q?OWTxFlf0Z0YQj5cxtsHJ8QfFA6pjocuhxcJ8vSAmOTgqQjR0ZwIJ1rtvzl73?=
 =?us-ascii?Q?OEdgMTECTi9FJ6VCLt5PBIM2gXc8tuJUpvbdAykxy5l23MtvDLsKnrDxTlyR?=
 =?us-ascii?Q?9if5QYTXCY0+V0qyzqI6P0qfr249mMdl9iPF9XWo5O4i04KcGDAlbrCAGBJA?=
 =?us-ascii?Q?5C5IXthREiBFUE8z0n0QHBYOVj1s5eqOH1eEQcyOCOmi7iNYFJUeyqfoi+NE?=
 =?us-ascii?Q?qPRb8yUitJV5X+SMvPZwz5ASiHXYK8oi6nwOr8q24FBHZI4TnUB6DU27+GpM?=
 =?us-ascii?Q?cDHwoOSGFtQtQpvcrV+uq23lHvPBtx8YRFuPXnCnE2eLoibW0HdUHx2eIAdf?=
 =?us-ascii?Q?wxBCi6TMaVay1XhCcs/BNqSGWVOBoMsAKIUeEfL5z+0RcNdJBmtRe/XxiJyU?=
 =?us-ascii?Q?a0pjhx4yYzDnsTNbtPmcNxIrJ4hFbATRDU2i/Z9sAFmZbAmTXi97yIfTvzj9?=
 =?us-ascii?Q?Sub4rCKG9fxFBWI/otIaArPmECREuqVhpGAyHOk3IWBFoFGnuBoMVcjkgBnQ?=
 =?us-ascii?Q?Lhu9kl9OFRkIS5HEIrFp0sg1cJv+ULCqsP3JhfXOoQCfcJsS4w9kZf8bMM2U?=
 =?us-ascii?Q?uDnxiFR1JmSs6YizbGdOBMyN1YhhYfcYaubBh/Szo1U7xykAweTTT/06Zkzc?=
 =?us-ascii?Q?wcrcC21uXq22ew4pA3NXkr0fBiXobFuMGGja9/dx4Yr1qdFlfaCodVSgIjjR?=
 =?us-ascii?Q?a5qYd+8DkL8d//qbgZf+hvvxf19vyrJe8a54838bhtw3O7/X4ItKVtRpM+rK?=
 =?us-ascii?Q?QOOUUjhXcdryJeIOhf3L/19N1aNT/K2Xp4crrFG7OYW06/RhvPCFbXTbjms0?=
 =?us-ascii?Q?YUoghtNmqVuL9Yjr7Q0pRuPz/bTSvuBXkJ/Er81hwiH+YZWKqV8pffEo1EhG?=
 =?us-ascii?Q?8FgEpvDduPIlG/0HzfrUHEL4SfKYfBGFRgon2J3w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43acf37-eba6-4991-59d1-08dd92621415
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 21:06:49.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPWQIrIQiCrwai46v/cijQ7brVMbnHIUswtL97Jw5exBw6EeeJtVfLC07R5k2a+xPwL1fIxD22igQRYHIxCCdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326

On Tue, May 13, 2025 at 07:55:43PM +0200, Borislav Petkov wrote:
> On Mon, May 12, 2025 at 11:43:15AM -0400, Yazen Ghannam wrote:
> > The use case is "disable MCA polling". I just gave two examples of how
> > this can be done.
> 
> Our documentation says:
> 
>                 ignore_ce
>                         disable features for corrected errors, e.g.
>                         polling timer and CMCI.  All events reported as 
>                         corrected are not cleared by OS and remained in its
>                         error banks.
> 
>                         Usually this disablement is not recommended, however
>                         if there is an agent checking/clearing corrected
>                         errors (e.g. BIOS or hardware monitoring 
>                         applications), conflicting with OS's error handling,
>                         and you cannot deactivate the agent, then this option
>                         will be a help.
> 
> it basically disables all: polling *and* CMCI.
> 
> So why do we even bother with storms?
> 

I think I see your point. The AMD MCA Thresholding init flow doesn't
check "ignore_ce". We should fix that to have more feature parity
between vendors.

Another item for the to do list. :)

> > We can focus on "check_interval=0". The user wants to disable MCA
> > polling and rely only on interrupts. They still want to see the CEs.
> 
> Is that a use case we support?
> 
> Where is that documented?
> 
> I can see why someone would want to avoid the recurrent polling but I'm not
> sure we explicitly say that somewhere in the text...
> 

Right, good point. This may come down to another vendor difference.

On Intel, the set of banks for polling and for CMCI are mutually
exclusive. So polling can be effectively disabled if all banks support
CMCI.

On AMD, polling and interrupt are independent. We still poll all banks
even if they are interrupt-capable. I think we discussed this in a
previous revision of this set.

So I think we should document this use case. And also consider changing
the polling/interrupt behavior on AMD. Even if this use case is
documented, it still requires user intervention which we can avoid if we
change the kernel behavior.

> > When the storm ends, the kernel should go back to how things were before
> > the storm. If there was a timer before, then go back to the old
> > interval. If there was *not* a timer before, then delete/remove the
> > timer.
> 
> That I agree with.
> 

Okay.

Thanks,
Yazen

