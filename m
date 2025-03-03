Return-Path: <linux-edac+bounces-3260-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF00A4CD2E
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026BE3AC93D
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE23235375;
	Mon,  3 Mar 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y+2TLEbH"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4979232377;
	Mon,  3 Mar 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036013; cv=fail; b=S8vzkBFO0xVIjsKTvTGp29nmwlXmtQXa3kBHqGFjxY3SH7f6idqNz1YevCZ39SUvAiDYmjKaQ+lbVZjhmLD/9cBRw4ERKe3X5vB0NFE65L8JC/GgWYsPqwD/fRNK8XYAIf16arLRACnzjnLABWohJBmQuyTMZETLKsY/AdWsm9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036013; c=relaxed/simple;
	bh=I4LH9cyFL51p3gQch83FjwigG16qODaF6NAikPx+ToQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z5iHCY+/tlojmhYSsaPbVgioD+fl2m2oGW6jUE+7qrQhVZgE+c+Ai2EmSC2nx1xYHdrZFP00/dY5wImkFgfQiQ47TF2vrwASvIdm4ITZBvUoqFZcVGXCWAsv4CN/WjeP5eKdGFk5dUPWAilZ3ULC4F0rdzy4x5mf3asMghd3Hg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y+2TLEbH; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqqJBbu/BzsoddYbUtk/QlQvjFT0Q5sWCOyFwRHdy3cvF6+k+brdEDF4ASPNsGeGhwheYYX0i6EtAxL3dYDLsTCWxE1lg9HeOJo/hyqDZRgXPkjbyvb2IGov5L8FojP9Ck6yaWj8JjAUTMs4djUSfdGHfVbtAA+YW7MUxiEPso3fAkcU3G7vAK14WDd2Dye2EAk+OCXiXEqB0SixI4ldFDqRFlRKB5SnxjlqG6Wd2LsaHweCYRQwyuSCmxAIP+f8ItsiO6z9Kzlc0FDi4MLQMDgtvJjkJUXCmSplI/jJ5fkcxEko5lY1/+pSQkpYwPWQIRymDRd+ELJ3vJitLVNzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BozRxWNCU6ehZu7Z+VnrJC0SRZAW86TPczRAdNRPXXw=;
 b=wpg13fDkYrbjaBwz8cPv32F0kCslpOHrJaXO9/35I6/6HCLDg5uDsnG0Cd3zY6+ej9wy8POjNGmo54fOxwsFmqdqXqVvwxI9m385BWw6ZfZ9I1oT+HhkJN3aw+vLyXgjtolbxWap3zSokcZYusw8wDxEMam66Prpub7MMC7dn+zHqCE52J+lCmY+Brk7yce4Mync6Sq7zVtrZDR5XwuX3i5kYdxJ/n3l0EM3+l24E/zE4U7D7IeRkyMaYQRd4E8Zoh7uP/dhUPPXm9XGuvV88WIhcm65c7FLHaZ/XETNfHMNiuCT8F3mxkihPd96aYkisKrSohFgW3+O7mFrV9PvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BozRxWNCU6ehZu7Z+VnrJC0SRZAW86TPczRAdNRPXXw=;
 b=y+2TLEbHbBw2idFB5agGjNm6zZOmEq0/vOMwjrND+d5m+Be2pphsWpuxV32nmMlj5LVUllDD+LdnSBVyA40zWu4VcueXCAqVJ9cLCuROUNKTUbtQfg+VE2Tq6XESsjmnIweADapn6CfluSG9YfpGl9PKnZTCdke8F4Xo59IiO5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Mon, 3 Mar 2025 21:06:48 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 21:06:48 +0000
Date: Mon, 3 Mar 2025 16:06:36 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, tony.luck@intel.com,
	lenb@kernel.org, mchehab@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, rientjes@google.com, jiaqiyan@google.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH linux-next 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250303210636.GA1617010@yaz-khff2.amd.com>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250228122752.2062-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228122752.2062-2-shiju.jose@huawei.com>
X-ClientProxiedBy: BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::18) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a024004-050b-43ea-3aa8-08dd5a974fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rnv/PkYbju1xw1S4J/ATls42gttwxAqBosz83C4gLQDt+5CrLZ2A97tXuhBs?=
 =?us-ascii?Q?1ZZAYBDWM+btaxjwTEXxG5MWqiu/yQq3hEz8RIYNTM3zAABn+RBWS7W5NICp?=
 =?us-ascii?Q?IjKgReWGsnNGh+cJFwmIG3sQJLJ1DD2GhlorNWOlYSyGs1ZnuwncrFjFNoff?=
 =?us-ascii?Q?9LUPOD0l0NjeUYSnB15AjiUASAA/OBDgswSUmoEGYXhRHcIes+BfwHrRG/GK?=
 =?us-ascii?Q?nPrR9oeJRBPyZ/gBGBOwxc7E6oBDTKazoQvrCgsvTtFtdz768+MylGJfoZsN?=
 =?us-ascii?Q?m2BD6mIBLlu2J6OtjQUvOi2g8nWWj9TAyqeCMFmZT2BP6bNGU7tpW0mSgflj?=
 =?us-ascii?Q?QEvt5FGe3ydmx/ovY2SQJFvd1Umnlgmbg6tBB2ALaFCsR5GzM3KY4JfOqBwP?=
 =?us-ascii?Q?D3csnzVVczXb0YbFoSgIAakF6c1EnqbGRAO6Sc1IleiKKUm5OTSedoklRdj4?=
 =?us-ascii?Q?mxxXVCARM4StqCwP01y/eEOiB3Rx6Qc9JCRNn3U9fIcWdpIvXx++8s+g8HJP?=
 =?us-ascii?Q?a01zTKgxb/nLTRNm3efwriA127R3oUd0Vmx5U1FzdAiJESiQQifMioPyFhpP?=
 =?us-ascii?Q?y3wZXsOa+llVBKfXFaejFwry/lts/IsBSxL0NqBqa6vU4ApVYSCDVQaG/2fx?=
 =?us-ascii?Q?Q3CUyrqB68tEEep4kiIMHgdCgF/IYNRyeBokpnlCqtNYbdcWLT9Mit3b1TB7?=
 =?us-ascii?Q?AEySLaT1QMyuGgHehsTVGy2IyN4L2wzYrVqDD0wdlv5oOWKc/kv3T/Ild7CI?=
 =?us-ascii?Q?2ueUK4I0D7dq98UNjvjWj4ImBFbcxj6JAI7EQas1IlF2MrQsDPZFyoiR2YF5?=
 =?us-ascii?Q?HY8b14DEcvppeBC5Rj8GWyw9UvmYQ0Ivvlu84NITcl4nMJ+X/AFlFqs+dwYa?=
 =?us-ascii?Q?7qlXQo5cliCUVQ9fIn8F3pAD8ELGv3qIdL8kmRbjLTW1j3M88Fx0b356yVAu?=
 =?us-ascii?Q?R22QxpNQpPNPo/gPmTRpyZNBWklizBNvA9n408PUOpQBz4iYLplotai6bIG3?=
 =?us-ascii?Q?uu28pRSZL7kkeYPqov4Eos5+/WzTy1cK+gPWDRkVWa2xSyXze/radsgeVtM7?=
 =?us-ascii?Q?RjnExgdL8V0xKtpBbNafC/qcAYVZtc/sI3cQQIc3bQ+mdrSWZ0YocH3ERtjN?=
 =?us-ascii?Q?Vu5hSBktn/3X8aM7UCETzWkmxEklj2C4C4qgxBpAMubz25ieiM88ajBA6wSo?=
 =?us-ascii?Q?lORb1iXpBxtq7g5eAMuBZrODvA55Jm17wUHdEVJN9E+O/cdv0wOvor3O2qh4?=
 =?us-ascii?Q?wI+mVOUt6mg0qL4rl/oIMNgpEZWFuJe2g4y6fSWrqsiSnzS3Khz2lv1qSWRi?=
 =?us-ascii?Q?CA/Mif8d8D/d57KO4+JLyOHkW9DNsjefQhiBekkE839KjFo4rEj33ElZV3mH?=
 =?us-ascii?Q?KPObskRmEEBsomf1t3RQGfG9Jy5f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKODec+qEu5EnUo8M2Nj8i3SQFVJAGqRrIDYKGo+p6o380qIGIRjjo3LMzA9?=
 =?us-ascii?Q?UWW4WdL7OkpZQMGfJus7YOXYJm8XsoAwItSb55QKHdXENTF/G7L+fBVQSLhm?=
 =?us-ascii?Q?kUuiZMHokjY6wX6qhXqVT+TrgBvt8WvEXxby17Lp3pgpu4avzS4O7B/cJvt6?=
 =?us-ascii?Q?hP3eDwlaZKVKw0SJeza3qDJDp0ot57BwSri6K37fYqVz/Vu3O+dqgRVoS+Aj?=
 =?us-ascii?Q?E2AMD9qKqcsDD/sJIkwe/yjWGVWqPB36PdsADWHL09t9a1hyn/XtmkGMXSjQ?=
 =?us-ascii?Q?gHvnS4eEO5tFchs9A9wFckU16ZFCrisu0Cyi8i5OkmioVood+Xo0VtbKiVen?=
 =?us-ascii?Q?gdoUCCYIYeGq3rtbYknqj4DYIq/9jgg0bSoz0ZjgEB5VGG5oFG6MEH2aBbET?=
 =?us-ascii?Q?D4ZvcO4DsaK5sfmhk5P2c5qrXfBP5QRA+ogvPPeQKVRO3DnkTRlEV2Y35/yX?=
 =?us-ascii?Q?RYqzjrgqfhYs881ImPkNCJip4mlQLU63BJtuQg1S2z1dH9wbEOWymRXGOeCP?=
 =?us-ascii?Q?eK84P3vZ7h4IX5QNfocugqToxuHZ9A6NRFjRUvcAOhm/j+VIJ/e4XezYDTf8?=
 =?us-ascii?Q?AOV4LqvO9Tgk9rvpTCP27A75h3JIif31WJiV8VtJ4n8rsL2rXs5EPd1MvSAk?=
 =?us-ascii?Q?yFxFzPfFsVGDg77K0X5PjYJ+TWVC/5/ZoLQLZqi3A6muea4mELsdTvjJM5Pf?=
 =?us-ascii?Q?PMhGkH8xbyfDvWSVmdAFFySFpSHgeiWd+eoCilcz02UTD5yY21WyA+anw6Nr?=
 =?us-ascii?Q?kNQSfuiSm1a8L1sNFGRRsA5iDLNAd0XSJdcqKPhykEm2MLK+ePhH6ScFoYZP?=
 =?us-ascii?Q?0O8eHqXBit9pVELc3cepRc3fzKxuUxlWanSNMHjnuTc7mpUoWG33o1ZsvEbH?=
 =?us-ascii?Q?/mpiJsU69BkHgDcVw8sbWPtQoPL9Js4xd/xCRJzMLKHROr7nvegbONZ42qar?=
 =?us-ascii?Q?1+30wq0sv8Cbey73nXoDwT6013Lnpj/dlbWS9m3RNghcX4rg9900+Ifsf+vh?=
 =?us-ascii?Q?eIlS4eLqXpR38+dCuP2Cz+0iZsCL41fTrY2TKzX1H8bo4xnEMykf2mCc3dDk?=
 =?us-ascii?Q?Er0RmEJK8Uy8ipPRZn6gsomaa7b7j7Nd6TJDZqs0z1hgWTdl/dtPi/ATHNr1?=
 =?us-ascii?Q?PQlY1gpJ/AKFvYbFX87WNBK/ESCBpeo8bsGu0SZGxSIgVPwJTk/hkFVb1JM+?=
 =?us-ascii?Q?GliQaQC/FWxDdVp22YYWWe8oq9bD9XGjdsCRy6VAfWGBMUmSj+w+jGBA4mw7?=
 =?us-ascii?Q?PugNcca7RzFwuOEtKf7J9HOuZaq6HnypBGrkD+aX6muIcoFyEgEIZzG8DP+5?=
 =?us-ascii?Q?2WdvmubMAI5sEG6mPjDMGmJxQmkvDFbxrzBYnOOltSPXbTlbxHar1FCaO5iT?=
 =?us-ascii?Q?5kdczpR7ilDR8R3xCsRRzZGN7updHSr7PKCnl6r7OW6fLkpt3T48rLyBKH95?=
 =?us-ascii?Q?yFABSnDaZ84UopoEK8WVrn+VricT0S5XZh3iGc+B1yk9PwX13yUmbKPjdYD7?=
 =?us-ascii?Q?tjEevXrnK75+9bNGkgmrln4MknMjy+CGhU331VROTLfa4VsuH/Rr+sr2Aylg?=
 =?us-ascii?Q?3UmjZ4cRJPe+NeP+5r+F51iWrtrBNdsKTzn3sb6B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a024004-050b-43ea-3aa8-08dd5a974fac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:06:48.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJmOAR/A2iyMgsMzjnfi4bEhAmuLTHZC7ycr2WUoKAdJT7A3FxL82cumF7mUbrJG3r9MOlMU9BuNBLYUjK8xvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

On Fri, Feb 28, 2025 at 12:27:49PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 Specification, section 5.2.21.
> Driver contains RAS2 Init, which extracts the RAS2 table and driver
> adds auxiliary device for each memory feature which binds to the
> RAS2 memory driver.
> 
> Driver uses PCC mailbox to communicate with the ACPI HW and the
> driver adds OSPM interfaces to send RAS2 commands.
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/Kconfig     |  11 ++
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/ras2.c      | 417 +++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2_acpi.h |  47 +++++
>  4 files changed, 476 insertions(+)
>  create mode 100755 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2_acpi.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7f10aa38269d..7b470cf2fd71 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -293,6 +293,17 @@ config ACPI_CPPC_LIB
>  	  If your platform does not support CPPC in firmware,
>  	  leave this option disabled.
>  
> +config ACPI_RAS2
> +	bool "ACPI RAS2 driver"
> +	select AUXILIARY_BUS
> +	select MAILBOX
> +	select PCC
> +	help
> +	  The driver adds support for ACPI RAS2 feature table(extracts RAS2
> +	  table from OS system table) and OSPM interfaces to send RAS2
> +	  commands via PCC mailbox subspace. Driver adds platform device for
> +	  the RAS2 memory features which binds to the RAS2 memory driver.
> +
>  config ACPI_PROCESSOR
>  	tristate "Processor"
>  	depends on X86 || ARM64 || LOONGARCH || RISCV
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 40208a0f5dfb..797b38cdc2f3 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
> +obj-$(CONFIG_ACPI_RAS2)		+= ras2.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
> new file mode 100755
> index 000000000000..cc8eef49c158
> --- /dev/null
> +++ b/drivers/acpi/ras2.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Implementation of ACPI RAS2 driver.
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited.
> + *
> + * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
> + *
> + * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table and
> + * get the PCC channel subspace for communicating with the ACPI compliant
> + * HW platform which supports ACPI RAS2. Driver adds platform devices
> + * for each RAS2 memory feature which binds to the memory ACPI RAS2 driver.
> + */
> +
> +#define pr_fmt(fmt)    "ACPI RAS2: " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/ktime.h>
> +#include <linux/platform_device.h>
> +#include <acpi/pcc.h>
> +#include <acpi/ras2_acpi.h>
> +
> +/* Data structure for PCC communication */
> +struct ras2_pcc_subspace {
> +	int pcc_subspace_id;
> +	struct mbox_client mbox_client;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;
> +	bool pcc_channel_acquired;
> +	ktime_t deadline;
> +	unsigned int pcc_mpar;
> +	unsigned int pcc_mrtt;
> +	struct list_head elem;
> +	u16 ref_count;
> +};
> +
> +/*
> + * Arbitrary Retries for PCC commands because the
> + * remote processor could be much slower to reply.
> + */
> +#define RAS2_NUM_RETRIES 600
> +
> +#define RAS2_FEATURE_TYPE_MEMORY        0x00
> +
> +/* global variables for the RAS2 PCC subspaces */
> +static DEFINE_MUTEX(ras2_pcc_subspace_lock);
> +static LIST_HEAD(ras2_pcc_subspaces);
> +
> +static int ras2_report_cap_error(u32 cap_status)
> +{
> +	switch (cap_status) {
> +	case ACPI_RAS2_NOT_VALID:
> +	case ACPI_RAS2_NOT_SUPPORTED:
> +		return -EPERM;
> +	case ACPI_RAS2_BUSY:
> +		return -EBUSY;
> +	case ACPI_RAS2_FAILED:
> +	case ACPI_RAS2_ABORTED:
> +	case ACPI_RAS2_INVALID_DATA:
> +		return -EINVAL;
> +	default: /* 0 or other, Success */
> +		return 0;
> +	}
> +}
> +
> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	struct acpi_ras2_shared_memory __iomem *generic_comm_base = pcc_subspace->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(), pcc_subspace->deadline);
> +	u32 cap_status;
> +	u16 status;
> +	u32 ret;
> +
> +	while (!ktime_after(ktime_get(), next_deadline)) {
> +		/*
> +		 * As per ACPI spec, the PCC space will be initialized by
> +		 * platform and should have set the command completion bit when
> +		 * PCC can be used by OSPM
> +		 */
> +		status = readw_relaxed(&generic_comm_base->status);
> +		if (status & RAS2_PCC_CMD_ERROR) {
> +			cap_status = readw_relaxed(&generic_comm_base->set_capabilities_status);
> +			ret = ras2_report_cap_error(cap_status);
> +
> +			status &= ~RAS2_PCC_CMD_ERROR;
> +			writew_relaxed(status, &generic_comm_base->status);
> +			return ret;
> +		}
> +		if (status & RAS2_PCC_CMD_COMPLETE)
> +			return 0;
> +		/*
> +		 * Reducing the bus traffic in case this loop takes longer than
> +		 * a few retries.
> +		 */
> +		msleep(10);
> +	}
> +
> +	return -EIO;
> +}
> +
> +/**
> + * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
> + * @ras2_ctx:	pointer to the RAS2 context structure
> + * @cmd:	command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
> +	struct acpi_ras2_shared_memory *generic_comm_base = pcc_subspace->pcc_comm_addr;
> +	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
> +	struct mbox_chan *pcc_channel;
> +	unsigned int time_delta;
> +	static int mpar_count;
> +	int ret;
> +
> +	guard(mutex)(&ras2_pcc_subspace_lock);
> +	ret = ras2_check_pcc_chan(pcc_subspace);
> +	if (ret < 0)
> +		return ret;
> +	pcc_channel = pcc_subspace->pcc_chan->mchan;
> +
> +	/*
> +	 * Handle the Minimum Request Turnaround Time(MRTT)
> +	 * "The minimum amount of time that OSPM must wait after the completion
> +	 * of a command before issuing the next command, in microseconds"
> +	 */
> +	if (pcc_subspace->pcc_mrtt) {
> +		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
> +		if (pcc_subspace->pcc_mrtt > time_delta)
> +			udelay(pcc_subspace->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
> +	 * "The maximum number of periodic requests that the subspace channel can
> +	 * support, reported in commands per minute. 0 indicates no limitation."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it can
> +	 * handle maximum number of requests that all the cores in the system can
> +	 * collectively generate. If it is not, we will follow the spec and just
> +	 * not send the request to the platform after hitting the MPAR limit in
> +	 * any 60s window
> +	 */
> +	if (pcc_subspace->pcc_mpar) {
> +		if (mpar_count == 0) {
> +			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
> +			if (time_delta < 60 * MSEC_PER_SEC) {
> +				dev_dbg(ras2_ctx->dev,
> +					"PCC cmd not sent due to MPAR limit");
> +				return -EIO;
> +			}
> +			last_mpar_reset = ktime_get();
> +			mpar_count = pcc_subspace->pcc_mpar;
> +		}
> +		mpar_count--;
> +	}
> +
> +	/* Write to the shared comm region. */
> +	writew_relaxed(cmd, &generic_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew_relaxed(0, &generic_comm_base->status);
> +
> +	/* Ring doorbell */
> +	ret = mbox_send_message(pcc_channel, &cmd);
> +	if (ret < 0) {
> +		dev_err(ras2_ctx->dev,
> +			"Err sending PCC mbox message. cmd:%d, ret:%d\n",
> +			cmd, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * If Minimum Request Turnaround Time is non-zero, we need
> +	 * to record the completion time of both READ and WRITE
> +	 * command for proper handling of MRTT, so we need to check
> +	 * for pcc_mrtt in addition to CMD_READ
> +	 */
> +	if (cmd == RAS2_PCC_CMD_EXEC || pcc_subspace->pcc_mrtt) {
> +		ret = ras2_check_pcc_chan(pcc_subspace);
> +		if (pcc_subspace->pcc_mrtt)
> +			last_cmd_cmpl_time = ktime_get();
> +	}
> +
> +	if (pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_channel, ret);
> +	else
> +		mbox_client_txdone(pcc_channel, ret);
> +
> +	return ret >= 0 ? 0 : ret;
> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
> +
> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_subspace_id)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *mbox_cl;
> +
> +	if (pcc_subspace_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&ras2_pcc_subspace_lock);
> +	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
> +		if (pcc_subspace->pcc_subspace_id != pcc_subspace_id)
> +			continue;
> +		ras2_ctx->pcc_subspace = pcc_subspace;
> +		pcc_subspace->ref_count++;
> +		mutex_unlock(&ras2_pcc_subspace_lock);
> +		return 0;
> +	}
> +	mutex_unlock(&ras2_pcc_subspace_lock);
> +
> +	pcc_subspace = kcalloc(1, sizeof(*pcc_subspace), GFP_KERNEL);
> +	if (!pcc_subspace)
> +		return -ENOMEM;
> +	mbox_cl = &pcc_subspace->mbox_client;
> +	mbox_cl->knows_txdone = true;
> +
> +	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_subspace_id);
> +	if (IS_ERR(pcc_chan)) {
> +		kfree(pcc_subspace);
> +		return PTR_ERR(pcc_chan);
> +	}
> +	*pcc_subspace = (struct ras2_pcc_subspace) {
> +		.pcc_subspace_id = pcc_subspace_id,
> +		.pcc_chan = pcc_chan,
> +		.pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
> +						 pcc_chan->shmem_size),
> +		.deadline = ns_to_ktime(RAS2_NUM_RETRIES *
> +					pcc_chan->latency *
> +					NSEC_PER_USEC),
> +		.pcc_mrtt = pcc_chan->min_turnaround_time,
> +		.pcc_mpar = pcc_chan->max_access_rate,
> +		.mbox_client = {
> +			.knows_txdone = true,
> +		},
> +		.pcc_channel_acquired = true,
> +	};

There are quite a few places where I'd expect a newline after "}" and
"return" statements. This is just one example.

> +	mutex_lock(&ras2_pcc_subspace_lock);
> +	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
> +	pcc_subspace->ref_count++;
> +	mutex_unlock(&ras2_pcc_subspace_lock);
> +	ras2_ctx->pcc_subspace = pcc_subspace;
> +	ras2_ctx->pcc_comm_addr = pcc_subspace->pcc_comm_addr;
> +	ras2_ctx->dev = pcc_chan->mchan->mbox->dev;
> +
> +	return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_remove_pcc(struct ras2_mem_ctx *ras2_ctx)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
> +
> +	guard(mutex)(&ras2_pcc_subspace_lock);
> +	if (pcc_subspace->ref_count > 0)
> +		pcc_subspace->ref_count--;
> +	if (!pcc_subspace->ref_count) {
> +		list_del(&pcc_subspace->elem);
> +		pcc_mbox_free_channel(pcc_subspace->pcc_chan);
> +		kfree(pcc_subspace);
> +	}
> +}
> +
> +static void ras2_release(struct device *device)
> +{
> +	struct auxiliary_device *auxdev = container_of(device, struct auxiliary_device, dev);
> +	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
> +
> +	ida_free(&ras2_ida, auxdev->id);
> +	ras2_remove_pcc(ras2_ctx);
> +	kfree(ras2_ctx);
> +}
> +
> +static struct ras2_mem_ctx *ras2_add_aux_device(char *name, int channel)

Why is the return type "struct ras2_mem_ctx *"? It is not used by the
calling function.

Just use return type "int".

> +{
> +	struct ras2_mem_ctx *ras2_ctx;
> +	int id, ret;
> +
> +	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&ras2_ctx->lock);
> +
> +	ret = ras2_register_pcc_channel(ras2_ctx, channel);
> +	if (ret < 0) {
> +		pr_debug("failed to register pcc channel ret=%d\n", ret);
> +		goto ctx_free;
> +	}
> +
> +	id = ida_alloc(&ras2_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto pcc_free;
> +	}
> +	ras2_ctx->id = id;
> +	ras2_ctx->adev.id = id;
> +	ras2_ctx->adev.name = RAS2_MEM_DEV_ID_NAME;
> +	ras2_ctx->adev.dev.release = ras2_release;
> +	ras2_ctx->adev.dev.parent = ras2_ctx->dev;
> +
> +	ret = auxiliary_device_init(&ras2_ctx->adev);
> +	if (ret)
> +		goto ida_free;
> +
> +	ret = auxiliary_device_add(&ras2_ctx->adev);
> +	if (ret) {
> +		auxiliary_device_uninit(&ras2_ctx->adev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return ras2_ctx;
> +
> +ida_free:
> +	ida_free(&ras2_ida, id);
> +pcc_free:
> +	ras2_remove_pcc(ras2_ctx);
> +ctx_free:
> +	kfree(ras2_ctx);
> +	return ERR_PTR(ret);
> +}
> +
> +static int ras2_acpi_parse_table(struct acpi_table_header *pAcpiTable)
> +{
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	struct acpi_table_ras2 *pRas2Table;
> +	struct ras2_mem_ctx *ras2_ctx;
> +	int pcc_subspace_id;
> +	acpi_size ras2_size;
> +	acpi_status status;
> +	u8 count = 0, i;
> +
> +	status = acpi_get_table("RAS2", 0, &pAcpiTable);
> +	if (ACPI_FAILURE(status) || !pAcpiTable) {
> +		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
> +		return -EINVAL;
> +	}

You already got the table in the init function and passed its pointer.
Why do you need to get it again?

Also, you can just save a global pointer to the table if you need to
access it multiple times. Please see my comments for the init function.
You can do something similar to acpi_hest_init().

> +
> +	ras2_size = pAcpiTable->length;
> +	if (ras2_size < sizeof(struct acpi_table_ras2)) {
> +		pr_err("ACPI RAS2 table present but broken (too short #1)\n");

This should include a "FW_WARN" prefix since the firmware should have
constructed a valid table.

> +		return -EINVAL;
> +	}
> +
> +	pRas2Table = (struct acpi_table_ras2 *)pAcpiTable;
> +	if (pRas2Table->num_pcc_descs <= 0) {

num_pcc_descs is a u16. It cannot be "< 0".

> +		pr_err("ACPI RAS2 table does not contain PCC descriptors\n");

Please include "FW_WARN" prefix.

> +		return -EINVAL;
> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
> +	/* Double scan for the case of only one actual controller */
> +	pcc_subspace_id = -1;
> +	count = 0;
> +	for (i = 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEATURE_TYPE_MEMORY)
> +			continue;
> +		if (pcc_subspace_id == -1) {
> +			pcc_subspace_id = pcc_desc_list->channel_id;
> +			count++;
> +		}
> +		if (pcc_desc_list->channel_id != pcc_subspace_id)
> +			count++;
> +	}
> +	/*
> +	 * Workaround for the client platform with multiple scrub devices
> +	 * but uses single PCC subspace for communication.
> +	 */
> +	if (count == 1) {
> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
> +		ras2_ctx = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_subspace_id);
> +		if (IS_ERR(ras2_ctx))
> +			return PTR_ERR(ras2_ctx);
> +		return 0;
> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
> +	count = 0;
> +	for (i = 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEATURE_TYPE_MEMORY)
> +			continue;
> +		pcc_subspace_id = pcc_desc_list->channel_id;
> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
> +		ras2_ctx = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_subspace_id);
> +		if (IS_ERR(ras2_ctx))
> +			return PTR_ERR(ras2_ctx);
> +	}

Why not just try to register *every* PCC identifier you find and have
the register function ignore duplicates? Does it already do this?

> +
> +	return 0;
> +}
> +
> +static int __init ras2_acpi_init(void)
> +{
> +	struct acpi_table_header *pAcpiTable = NULL;
> +	acpi_status status;
> +	int ret;
> +
> +	status = acpi_get_table("RAS2", 0, &pAcpiTable);
> +	if (ACPI_FAILURE(status) || !pAcpiTable) {
> +		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = ras2_acpi_parse_table(pAcpiTable);
> +	if (ret)
> +		pr_err("ras2_acpi_parse_table failed\n");
> +
> +	acpi_put_table(pAcpiTable);
> +
> +	return ret;
> +}
> +late_initcall(ras2_acpi_init)

Can this init function be called in acpi_init() along with other ACPI
tables?

I think the function can follow a similar structure to acpi_hest_init()
and acpi_ghes_init().

For example, the name could be acpi_ras2_init() to follow the same
format as other acpi_*_init() functions.

Most of these functions are called after other plumbing, like PCC, is
already initialized.

> diff --git a/include/acpi/ras2_acpi.h b/include/acpi/ras2_acpi.h
> new file mode 100644
> index 000000000000..0d24c42eb34f
> --- /dev/null
> +++ b/include/acpi/ras2_acpi.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RAS2 ACPI driver header file
> + *
> + * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises

Are these years correct?

> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited
> + */
> +
> +#ifndef _RAS2_ACPI_H
> +#define _RAS2_ACPI_H
> +
> +#include <linux/acpi.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#define RAS2_PCC_CMD_COMPLETE	BIT(0)
> +#define RAS2_PCC_CMD_ERROR	BIT(2)
> +
> +/* RAS2 specific PCC commands */
> +#define RAS2_PCC_CMD_EXEC 0x01
> +
> +#define RAS2_AUX_DEV_NAME "ras2"
> +#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
> +
> +/* Data structure RAS2 table */
> +struct ras2_mem_ctx {
> +	struct auxiliary_device adev;
> +	/* Lock to provide mutually exclusive access to PCC channel */
> +	struct mutex lock;
> +	struct device *dev;
> +	struct device *scrub_dev;
> +	struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;
> +	void *pcc_subspace;
> +	u64 base, size;
> +	int id;
> +	u8 instance;
> +	u8 scrub_cycle_hrs;
> +	u8 min_scrub_cycle;
> +	u8 max_scrub_cycle;
> +	bool bg;

What is "bg"?

It's not used in this patch. Maybe it can be added in the patch when it
is first used? Same for others.

> +};
> +
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd);
> +#endif /* _RAS2_ACPI_H */
> -- 

Thanks,
Yazen

