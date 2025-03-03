Return-Path: <linux-edac+bounces-3259-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A3A4CAD8
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 19:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B43D3A5597
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75FE229B07;
	Mon,  3 Mar 2025 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DasxIEgx"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D1214A81;
	Mon,  3 Mar 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025330; cv=fail; b=F+Nj8KoBvT8miJ+N2DGbvRyJSGxgFVTj48tGZDZWt1B6zXceZ06uRtXVH52WoMY0lPSC41t6g2leLj85yH5gcdBuf+eryEIb1rClDCpCuibZISxxEQrNDZYmjhhuZJP73WJF8I+Iw8fSKy/38Yvf2pyHOyCgRBvKPp6/NMDvDdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025330; c=relaxed/simple;
	bh=xpSrgVLd37ozlCnGDMwXLlMNsOGuPRZGaTY3Z/WDrYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FmM5Rlxh2jARBhZGKLhT/2aZc3lWBQS+K9r0wVwIyysU8GMiBE7P0cONxdOV8Uns6IyEJx+4+4MFKxi7q9zEC00fed+PE/C+9WLBWgHBUnUT1VndjZfDOJmI+oG9ribqRmyMKg09/oPHAP8XyhRNcApzNsFLndrnIkw5CWxMdoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DasxIEgx; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM4Esa8okWBht7ItEyL1py7BRjO3LV+9WcH0KbNyVxH6VogxLdKXOWfVCLq8VN3bwNK9YbN9ydfzgNsJoIfQjrH/creYhImi1eYpJCVGZIlHpsLvgKuvjnPu2/cMWD6ofQ1CQONtdRaWKiVNQm7bs4D5NYJSl6R/nan35OKFufqnaNYHYlUDwrt3rmLvZSLxxYgcOjpgMxgzkmuXtQt1IotnjuyZKcNK/Fz1+Z0JkypdUnvYNQoboVwkp7e28mMCvVQDr5ltvNIHc1KL4WVdqwkIIcpYhi1EgNe++lsHlS+Vcx3SnUPayqGJOLi8u6qeekHcjD3q4MkJ5ogNstHoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLpi5+qlUY7lvic2i4NIZgtCZTrzIJMX3LfSYFBh0u0=;
 b=S4eI316zXuPZBjtMrGYygHuXx2iINBzCyLPYzOG4ftCedy26Lh+S3SFMMUiLdfGJW0TZ2dXanPEMc6VNMAj76wTeowFCBVzKqy6WD0Wsrp6VmsN3Do0CUITwOLPvGBUYUHhkkCOoweYOrmTbBwNivKK59+FFHZjAMtL5BLXLeg0BoUclMXaoAVefF0n3XnceHEos1WVkiU0/P6bzZ8mUJMuT4oyw6WiBOv+usb34+xEzqLyuJTCXWuWXXlBcuPM0iFmsnI7cfFpnUEmH0mnqDqRhh/CVIYSIXoTimqG7vA6kXndVvScm7WF8e2EjEeeZ63csVr5Oz7nLe/2DcOGHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLpi5+qlUY7lvic2i4NIZgtCZTrzIJMX3LfSYFBh0u0=;
 b=DasxIEgxH09ZNsJ8Em8BGjMmdkafnO0ujm3FBSRYwyqlnswq8lg350yZbg83qDb9cn0oWa/dLx8+/TJO6TUFfKRgg0XWCZ9Q46ujhQssrcx5M+s6sVXqVG768RGbz2Rprw7DZQMQo6SJUY965UWg6kJW0mxkbPExLXavYhCOl7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 18:08:46 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 18:08:46 +0000
Date: Mon, 3 Mar 2025 13:08:41 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
Message-ID: <20250303180841.GA1520489@yaz-khff2.amd.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
 <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:408:fe::35) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a48cf3-e0bc-469f-8584-08dd5a7e70be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3bLlROQx4uuKQ/e9vUT4kH6qbyMg87q4XdA+OILx4VaDoKEcDiBlawNHysh?=
 =?us-ascii?Q?7KL4qYTUoa53sbXq7ZOtX7lBGif6utLr9l+xiTDq3CYX+FzguMU/XIWi8gzY?=
 =?us-ascii?Q?91MmLWA7ED6jsceV0PRJKd/TipQcFPEuKcjucm3e9vEMM7msbVBcfmXHCgCJ?=
 =?us-ascii?Q?mPlvbPVwKbsNyz2cPflnGm2OrlXTKGUIJqH3dH4WhygUO4zRZ1ED4Ee5wsh7?=
 =?us-ascii?Q?Vjg0FqDPDmL1geofbkhCBiC3xnyUDSVqZZ8usjoxtlO31RZECmM1dHeWPmzR?=
 =?us-ascii?Q?p4VdR2HngQb2e8NaLjDKtqXkHzKsoGqM/CWycjkHwk8wBzBcFPOB9kA/aXlm?=
 =?us-ascii?Q?JLtmTl8oTnOrSTjjKyO3EiIyvw1KLnVEd/uwXGvYoovsw9zr2OoS4UIh0GoN?=
 =?us-ascii?Q?00vjI/jO9v7CBA5GK3G6t4P8It7Pgbm3zXX6OkrnyItH+AGQVCzje3IukGaV?=
 =?us-ascii?Q?Ezn4hXMHoa6R22Seh0IUlaWylZWwjFxsHqTf9cShsMAue+jTnpR7B3pRDuzL?=
 =?us-ascii?Q?fkKccFltG26uR/Tt41IR2e6tmYgWXg0fyrJzAEKdtzqgR+MsaRkdvakhhsvM?=
 =?us-ascii?Q?RSqFVnqZXe45jwkqwUXy8kHpeK6i9Fx6+PkgdA9oLYEwEkLI6cGonpvu+9wS?=
 =?us-ascii?Q?FtUJyp06CRI8PtYwM6Cq4sGwzM8DOwDRAuSmVrahEICxNMmLYVKh5LaVvLL3?=
 =?us-ascii?Q?DdZMdMCJuzJYwnhsWtbjc1TDaBOy3bcqgk3KjyFWn77K7ZSqxF0D1uK6ovqx?=
 =?us-ascii?Q?yvis9ZlHn5qXF0Wu0MvwVvUJ7zWCqQ6l7/b88hQnXdUHkSsvL7HNsgw3U+q/?=
 =?us-ascii?Q?W8W5EEiDwKGATyGJbanQ0GuUMjrBQYQL374mn/FxuhFM2/JROhG/oUUWG/XL?=
 =?us-ascii?Q?XcLLGJYlo1ERtVp3t7xNfNEhMOaF5JkSsgewqxqDygU/Lk2ESebft+0Eevqq?=
 =?us-ascii?Q?zmHyugIfMrU0IQ1FOMxdmyoT8qNukf37wEaNAY5kRQvkr8mQuzsS2zN8jk9Q?=
 =?us-ascii?Q?/39IQNEWkZzjlEbbqVU1yvpbskKk7wW/AaG1MebT01hxieRv2AbiZ4gewJl6?=
 =?us-ascii?Q?px85YNfE9PUYIu7EivDt0me8Ei/C0Bkz8rcPlBfKa6ImtJ7AB9Zb4IjIehlE?=
 =?us-ascii?Q?Ia27J6kkHqObDcdsm6iSbR1glJIu50n1yasGAsVJ4ETFOAT3zTZ6zByDpsDB?=
 =?us-ascii?Q?X38uJ5jiPPntm0FScNqnK9c00UkmK2HdLHrRxGNkylzbKT5qpZ8ibZKry8ph?=
 =?us-ascii?Q?06uCcL9r8pV6bTewBcqsl94eGy+kJQnYCRQJc90ssklGCuTgn96v3DJW9LYY?=
 =?us-ascii?Q?PcggyTjkgOO789dUcu+/16XvDXwPE0IUaUY8gf7lLHgh5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5i0OBgtnrP+sqTJHobA+Xkky/8WG03kzuoFQC+J/rvBmNGsIRv9IyJF6RN5f?=
 =?us-ascii?Q?AoTFxM1ufa6rxja1CzRuVlh0S4tQjw6PPZVWq0H55ANwhuv0OM9xJezbI3PH?=
 =?us-ascii?Q?R29QPfCB0LzOCGSzQPdxe40wBVARiz2/EpQjF1jQGqd2Nlm9xSlEDiI++gDU?=
 =?us-ascii?Q?w70I0MvbU0hsZwdB66/K78yN73U9J8yQXKvcezMky6KEQ64rAEjYzJZ/7AMA?=
 =?us-ascii?Q?qgPLb643er/FAkEFuIKigHduJw1w1kG+AwsN6hOSVLdHo0tMQ5ugU+JD/sdR?=
 =?us-ascii?Q?fn/Zr3PpXLgg+OA+v1qU6Sokr0SY2e6jYKe/8uVgS03LcWOKB+DGN+6T4bqX?=
 =?us-ascii?Q?G5RG+QvJt25rN6+6wBTvitFGkh1OWR3aXdu8SmK7ImOpJ5A6FmCfct8xplg4?=
 =?us-ascii?Q?Sp1IocaOng0FPickGfFB6aYYx/+s7ikA8USGI1UEI2hKILgGYz+IAY26MpLK?=
 =?us-ascii?Q?Prqfb1Q6SMTo5SUfu7rWJsLSRjV+Wi35g+ovaujETir3S2yA0kyULVgfSXSu?=
 =?us-ascii?Q?ZpUKZ7F0sSFC9HK2j6LvfTqQou5i/izZVd0053ouf+jNy1yvAFtEIDAvOgtS?=
 =?us-ascii?Q?XT0syKFP6d63CfAKWZwDd+d781mjJaM7Sl6Pv+pJK596ANS5Tt0SqU0Uv+Xu?=
 =?us-ascii?Q?+R4hTuXOOdTzqY0K7gxEigJzW4OLR24QIhrHUyU1mAQYKFb7rrIrVfoae4X0?=
 =?us-ascii?Q?5evjfMmcoqMP0wAc7yuK80pqfa9ZqY+QIFr15tnUNVOL6DSZB6TNrB5PF4ZM?=
 =?us-ascii?Q?gxzhQ5VHddQq8bO8pn4sBG5rCieO+xdA7Kp8e08gF22satwlP61IQX/fhX+y?=
 =?us-ascii?Q?SFFMin7vIQncCkC5W5/zJBh172Y14uaH4dIOMAAv6pv+Vveg8pSwoNCETZbF?=
 =?us-ascii?Q?W0mv1fJYD/cQwhOW/BVJVL9MUO2cT8w5exgeVVJmQHMyspUp9MEZBFRoquvl?=
 =?us-ascii?Q?tW5hKZhmSCqzMxTfwCG9gMnOURHoxX8CQ1b+16sEB+Z+THr2RFQCcjqaT17U?=
 =?us-ascii?Q?8Hmf5Ij3Z13QhMy6jQxhj7/nWqIxG88i9dur7UfGABUvrjV8WuDEfERqH5yv?=
 =?us-ascii?Q?i7G4Rc15uZ1+4N2TlMPLeqRpxE7o38WxXn/3tAuB1p4MM1jiKaIZCZm0K7PM?=
 =?us-ascii?Q?dQbKa+ox7nVoQ8plKMu5TJcC5FjTwd4DTn8032F2fk+B7ZTdPjHkbWnIq5Bf?=
 =?us-ascii?Q?RcqtlXv7IVKHMBOvH/xCpdODRzaoO0WEqSyJKiXDzm0IoOWhawYjSJn0AHSx?=
 =?us-ascii?Q?CevA6r1G5tG1YDrggfGi4bojmXeAOLdEODHH9Inn3qhHVKBPZLQ+NGw9Wm6U?=
 =?us-ascii?Q?akx5aSOwm6dge623YKlM6K5JgiF26NZQSMAIV+9cInZRikuXbliTxIUaAJYf?=
 =?us-ascii?Q?GMx3uqE+pun5fkzRlwYcHGEv3HUuZmsA1LYEQ0jspGBsrU942lud88EFkyEk?=
 =?us-ascii?Q?nhd201lRhqzuYAqE48VlaSAwlgb/xJzH/D+EETyguutJDk6BLPJ7U88Jvcfi?=
 =?us-ascii?Q?JjayKr3v+dytPcn9gxQYvKfR76Jq/7u8oEXiZlzcB7yAp+wXSsuA0KFRY34H?=
 =?us-ascii?Q?kkb4oX3FfueYMmmKDJZiBlSBFyMydqHbnNqDm1z6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a48cf3-e0bc-469f-8584-08dd5a7e70be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 18:08:46.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/aFsqDeXt9sHDJWWLW2SbBuq6e2O7zco7qlY7e3GalcipQfpa6ENGtzoycOwrB5PR8GbCZBdbZjcKOewfoswA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379

On Mon, Mar 03, 2025 at 04:49:25PM +0000, Luck, Tony wrote:
> > The error context is in the behavior of the hw. If the error is fatal, you
> > won't see it - the machine will panic or do something else to prevent error
> > propagation. It definitely won't run any software anymore.
> >
> > If you see the error getting logged, it means it is not fatal enough to kill
> > the machine.
> 
> One place in the fatal case where I would like to see more information is the
> 
>   "Action required: data load in error *UN*recoverable area of kernel"
> 
> [emphasis on the "UN" added].
> 
> case.  We have a few places where the kernel does recover. And most places
> we crash. Our code for the recoverable cases is fragile. Most of this series is
> about repairing regressions where we used to recover from places where kernel
> is doing get_user() or copy_from_user() which can be recovered if those places
> get an error return and the kernel kills the process instead of crashing.
> 
> A long time ago I posted some patches to include a stack trace for this type
> of crash. It didn't make it into the kernel, and I got distracted by other things.
> 
> If we had that, it would have been easier to diagnose this regression (Shaui
> Xie would have seen crashes with a stack trace pointing to code that used
> to recover in older kernels). Folks with big clusters would also be able to
> point out other places where the kernel crashes often enough that additional
> EXTABLE recovery paths would be worth investigating.
> 
> So:
> 
> 1) We need to fix the regressions. That just needs new commit messages
> for these patches that explain the issue better.
> 
> 2) I'd like to see a patch for a stack trace for the unrecoverable case.
> 
> 3) I don't see much value in a message that reports the recoverable case.
> 
> Yazen: At one point I think you said you were looking at adding additional
> decorations to the return value from mce_severity() to indicate actions
> needed for recoverable errors (kill the process, offline the page) rather
> than have do_machine_check() figure it out by looking at various fields
> in the "struct mce". Did that go anywhere? Those extra details might be
> interesting in the tracepoint.
> 

Hi Tony,

Yes, I have a patch here:
https://github.com/AMDESE/linux/commit/cf0b8a97240abf0fbd98a91cd8deb262f827721b

Branch:
https://github.com/AMDESE/linux/commits/wip-mca/

This work is at the tail-end of a lot of other refactoring. But it can
be prioritized if there's interest. Most of the dependencies have
already been merged.

Thanks,
Yazen

