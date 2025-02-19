Return-Path: <linux-edac+bounces-3156-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D849BA3C454
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 17:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F917188D093
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71D1F463E;
	Wed, 19 Feb 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h8FNRTeC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433131F3B83;
	Wed, 19 Feb 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980898; cv=fail; b=NYIDJjaMzfSqWaYz+xvXgG4XoEbdCJb/jOjItJYs+8LGTyLTUIrAJh0HlbeLoecv5NhDh9wXDV8DVNu6e5IKbJaAtztiliwDvIg7dKnAfD4wP0fVr1pta+j/qi9VIS/XOEndhvsHaBtcKT47QlAAK87048do3oxKFopNG9qY/oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980898; c=relaxed/simple;
	bh=L3S389lxjmI5LKsixKHSPFcCmIIKGLRExHlJp6SUdfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SDG8AZjfJVhBIfy+jptDONufbgFAMWd/yZMcqqCFDbtpswNL70x7aKyGeNjCMvLHRA+aoLI78vkCN6Z/4q4uwcd1xga8bJR8m5uuuGzuJ967ye26zjhAhzI7+jDB8BcRV62Ktr3x+mDBhY1Fx2mwiHH+6Q/Z1FlkoXGuvLMWX/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h8FNRTeC; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC/Ru/nMoUYg9CXLzOic9A1w+UGAYMfiPf0laR5dKItkc8bwyLMPcgD+nArTJ9K0xxC0QnNSoZ5jRt+Eb7QYOFACQVVfy/KKp/JKBAblMAixly/mJYli2LnwbglyHGgHO7b9K/yRb0Ry4ZOU7phNDAFA+iQRTwVZbOvRTUcjrd0+wjYjgSTVIu/qb02s8QVce7BblwwOr73+7bUX6v52Vil7Vt0lydenLfoTorYyLQlZsPaNjmYPs+L5+q8t0IMkELlY3V5RuoWuxLIWd4cE1zFmDsA/mKt+zrWp+sO8+rOCU7nxx6WbKKBTD5CYwToo1LsK14hUFWKXfY0vlvhztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co3GzvIEFu6EI83NcMlK5i2ucW6REkoTpJlFEuhBjvk=;
 b=N4U+fQa0RxduMDuFnjl3IIDcAc1h3SRnzjxHpTHXXQ5H5qlMmybIeIZFtI+y7FASUuuM+4fmcORAXuvl/meDIdIekMMQdbw0vhkOuLK5NEr9ecNBC8k/jT6R0QYWJOJ0zec1BrF536Q7UBxy0Yip/nEakvx2mTaDxjpQsTM0s/kukoEnRCInKIQ/sblZSfCx5IF/gwldTQhPYlY85b6xAYYjxDkHu9g6zCzb+hQFQsp8XYBpNyYPhI0K6WIMGs9vAfMIuc7l3TfeQGyL9K1673DwiLZ3QJOqY5RV4rdIfZfNsWr2PoKoRVeo6rDGKbYxxUHDH76/wky3li1+rawHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co3GzvIEFu6EI83NcMlK5i2ucW6REkoTpJlFEuhBjvk=;
 b=h8FNRTeC/mzzxWUIv0oeUhhEDHX7pzaYUgbtxDqWsFIMrSTp15QC+dNERwATpuswUU5N8x061GopRuSUSNm1bGY6ujSp6ArbRcyRQuMiNGNNVgnJbtOP8PlIqaLNy5jediKLhjV5zGyUrmYgy2tgEBY9s95RaULcdTIkg4nHZk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 16:01:33 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 16:01:33 +0000
Date: Wed, 19 Feb 2025 11:01:29 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 08/16] x86/mce: Define BSP-only SMCA init
Message-ID: <20250219160129.GC337534@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-8-3636547fe05f@amd.com>
 <CY8PR11MB7134F491D46892FD5669E3C589FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134F491D46892FD5669E3C589FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 1057871c-d2ef-437a-6400-08dd50feae40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GHYp/Lyym/YWaJeBDu6i/D6fRCD6YciZxX4K2MxNWV6dq3JpIRGQf5DY0oND?=
 =?us-ascii?Q?oQrIJsEKIPjncTiZp/ZSIb2laUJ6EKpZScw1PZUQOzMNVo98hpU2ouphZwux?=
 =?us-ascii?Q?JjCqqy4HOiF1QM8Mjv6SuYzUIhwqQWASzcKKxT8lTv9GM/uFQNbEjM+CcFeE?=
 =?us-ascii?Q?8zROSbCFaYvT8s05jBclaxfbEDHajPoTc4SNj5uERZWWx1rUmFJeL/yyMc4y?=
 =?us-ascii?Q?ckH3gelgHSxgvgjcBT/tpLK2nH0Me27vCuwt3kk104qJeuZpdYdJjrUp9KcI?=
 =?us-ascii?Q?DMTpFlIJzvFmpmNfHyvdtwSJre8maxPLKdus/u422AbdpZLWTWBvaqclOBLF?=
 =?us-ascii?Q?jHNYPqBwY1xXb7BiNH9heiQVeyfhxqKRlvSDBHhySC+3oG+3AaGrLaU5Uei/?=
 =?us-ascii?Q?8iKvHjGwaKNadpd/6kcnQs+ZV8ohAboYYKG6yRGGPD5cNV99EdHofYMeXmK3?=
 =?us-ascii?Q?Ob1PMCmYV8EkJuRpL8fqAGtC+gnQNpgcvFPgJ6HtDP0vOE4M3rz5sZoRYS8Q?=
 =?us-ascii?Q?IzdBhQiKVLUnY6HI697Jn4BoC+uuRKoyBpBDxyNWGB2FWR5hJTIhCaYQ23Cm?=
 =?us-ascii?Q?Z9p6w+w42iZiOEr1OV3YFKo2wgS9Bm4JThCrq5ddYpBr5ujUMbfoYQnEsBTJ?=
 =?us-ascii?Q?00LMVmubMRePUrsrbrfrnQP75daPL417OyjKWiG1JwPvOVWXoOPaZKV97uhW?=
 =?us-ascii?Q?zeci6cxuKervEck8qfzOczCEg8L7a7Ot6OgX9+0BFtsMMMMPtB+JbdlMsGvS?=
 =?us-ascii?Q?IfBxrpDBh/seAwP/nUmys76u7ZLsvYr81Qna5YjB83kApOPZH4g+sJrzPeip?=
 =?us-ascii?Q?nJBA+TPfOshytetgrlQ4yv0tBruFKJ6XLDZjThybVUskO8pYF2uu79Ggl3t+?=
 =?us-ascii?Q?+/f2DN/UH/pd29T++bCBrZgXB7zqsIIFlKB+s8b3dE82nMuEPmxbeaWrOL2T?=
 =?us-ascii?Q?w1wc20ER6SncPaXs5V5hD+hjG2uvSfgpvZQaUkoRKxWNNvMOEA5QRZYqKB2i?=
 =?us-ascii?Q?Vy7NSmJO2WECwv5Mm7ZtesrPdX+w/BKiviXbOJ/8ab+Gb9KFsqBvFv9bQzxZ?=
 =?us-ascii?Q?/gqkyEX1BDWrAHRGxvZms3uxfS24b+5czpjBR9Ds0hjRhP8gjwgK+tyOdBRE?=
 =?us-ascii?Q?mRRX7irI//X7pSN65DHPACRd5QKFXUu0c1wfn3AuDTDUFsrPVlph5BClLCQQ?=
 =?us-ascii?Q?3+UsM3WTt1L7mNAxrCc+QVAEPNnrRxC4ARat4Pp6wGn3MvzLMOUuRg6oKhxo?=
 =?us-ascii?Q?V6GXbrv7jb28dWBdpo8FUyUH4+bd+HxzggA8FiiKmOfs4H1rNA99OyBYq4fF?=
 =?us-ascii?Q?XpFvPSJt51ZBsKhB0nZ2Xqlbo3bYN/5STWUq0BNoGLS+TNxIdzfZ13RWIPj9?=
 =?us-ascii?Q?TUENY3oo0FbIVLzZOGywXScfZOJK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NwAaflTx9iTMrtmErVgxbtSJnjXdSZYVSnv7b6go5RtQZtKKBqWf9IDkkIqo?=
 =?us-ascii?Q?Im0D8VhYoDeWjgI68U++APLVSfqkOV16vRO38kC4qT9A5MLAH5Dwier0OTLp?=
 =?us-ascii?Q?MGG2STRt4X4fnqgEsF0tnD6EAQNyZYBx7ElxyMlbBoSt3LNb9W4EtYrmNPJt?=
 =?us-ascii?Q?0aDcs6hN5zu5Lt1tBdtfVtEUSxNjxI/hd5Yjnd4Tao3hY2ubdT99WBjfSJBf?=
 =?us-ascii?Q?4RkP7l4Ll3gv0K9UTUrjvs9am56WKnwOuKVqgDZkpkpMh4QpsQdQWlcrCJel?=
 =?us-ascii?Q?H4if6E0eWt9nIAmPCsc4IjgH0psGvX46wVAJg1e/6ZMrMAxBNl9gpNS20MLP?=
 =?us-ascii?Q?1nCQyP5WIsQA9+EUk7uwBitDysuYxgeLqYI9qIm2+x0D4tINeWAR54x2+ACb?=
 =?us-ascii?Q?9TBbmhgSbP0Xe7gKdZ475qJ2wMdjdPVMCJgmpnAdsxT9Gozv05mUzuG/PNTa?=
 =?us-ascii?Q?CYIZGwG7ttWMqOxBP3BkiGfUpbD+nHID+IMfxOf889aIJmgmJ5hjLdKMD055?=
 =?us-ascii?Q?djQOeSRBgWrYSApymis8lCBUbJ7jeuRK/xSI6rllPbRNm/ATSMC1xnQmUlIU?=
 =?us-ascii?Q?1L68EjjZirKAAIWbrtCUEq7CpWNjooOoD858ekrFNv1x+LIqJN3FD+Q6BIsF?=
 =?us-ascii?Q?yglwp8TxtXP77jpg5/cLgkhJ2kjBtPVKFihDEr7WRczEvItwuCNYH3j4BqBN?=
 =?us-ascii?Q?wtH04bLfrrLP7r+xQZWru9Xl7n4sQxosGg6Y/lRBG0qfqqvF0887Zc3v5No/?=
 =?us-ascii?Q?jkqpZcGId9Oo+9ULJO7ZV45qDr3Z7eUCz3soI2KmaWahQGGHqVr8h3C6pcNe?=
 =?us-ascii?Q?+oRhJYTDeC4ZRCUMDYOFs21Fbt4gq4ddWKZ2sYdRI4orZnIeTdPnsIZnWuOa?=
 =?us-ascii?Q?YK3KFHapsCRn1rC+zcW4yMYqBo26GHK1wJpdxTBvHNxOH0LKB3bpb0FwBEvA?=
 =?us-ascii?Q?5GEK6DuRrWbYmYhpipsT8AiHiLuzVLbOcKOklzMcmpwldazmo5+EN29KSiHe?=
 =?us-ascii?Q?TwNJo4d08I9mEWVzF3oI79pMwNMawhYqsG1nIDaIBXFyAYWA9I56MRO8Iw8F?=
 =?us-ascii?Q?tD8SxBYefA4SHWHi5baQFLPvKZbCDSPfmqR0NGEBiU05DQBFZhvIA6tiPKR6?=
 =?us-ascii?Q?gS5H9CPVD8GLMZYe1FZkE3Tc/ny9I+2YjFfnW1AzSCaQsoaXGSY3TOI3xoyF?=
 =?us-ascii?Q?Dh7uWS6aq68+rL5BCVEp8HAC8cuo6srjcCkwOpH08Ir+7pvpq7MZydJP9AAt?=
 =?us-ascii?Q?dUF3YjZWlfT9qRto3YY3YLiwSK2ECh/GBSkruF7wiwHzBB0UG7qjymIlNhCl?=
 =?us-ascii?Q?VsyOCXbpKKWy5/27C1ORHCDUDVT8LFLi8Xv0wU9fDQ2Dwrl7ChpaDTqxZmLd?=
 =?us-ascii?Q?v2lRVzVVlLaO66XDNbfIt9TJJWXniJXwAKLBKcvzsxPpPoGrQKwOXUmsyVqJ?=
 =?us-ascii?Q?AGROeZFlg4tREYzkeDvSDWoh+TOTVUGvm6X7FDlEZV7JAO7N6hQDmCS/7mFO?=
 =?us-ascii?Q?iEmjKEHcxQUjztoAmYXurc3kdxw3rRc/YiJJf6ii7GETPILcMpS1QFCzcqtn?=
 =?us-ascii?Q?fW5AhMw/xgeMnnZRE8oWIVSsF3xFraMVa7NlsVjJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1057871c-d2ef-437a-6400-08dd50feae40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:01:33.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx6+EK5pg/z2tfaMhyyZrSjGVszNM081mjLT10qV/Wk1LQcwEM9A/l8cejp/kiCfY4AJ2uedZXdYa86JLrEtjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617

On Tue, Feb 18, 2025 at 03:33:08AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > Sent: Friday, February 14, 2025 12:46 AM
> > To: x86@kernel.org; Luck, Tony <tony.luck@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org;
> > Smita.KoralahalliChannabasappa@amd.com; Yazen Ghannam
> > <yazen.ghannam@amd.com>
> > Subject: [PATCH v2 08/16] x86/mce: Define BSP-only SMCA init
> > 
> > Currently on AMD systems, MCA interrupt handler functions are set during
> > CPU init. However, the functions only need to be set once for the whole
> > system.
> > 
> > Assign the handlers only during BSP init. Do so only for SMCA systems to
> > maintain the old behavior for legacy systems.
> 
> Looks like the interrupt handler is still set during each per-CPU online, right?
> What's the benefit/purpose of this patch? Thanks!
> 

This patch is doing the "correct" thing.

>     mce_cpu_online(cpu)
>         mce_threshold_create_device(cpu) {
>             ...
>             mce_threshold_vector = amd_threshold_interrupt;
>             ...
>        }
> 

This part remains for legacy systems. However, I think this is another
place to do more cleanup later.

Thanks,
Yazen

