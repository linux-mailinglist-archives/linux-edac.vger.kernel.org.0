Return-Path: <linux-edac+bounces-3871-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8295AAFF59
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CBB1BA6CD3
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C5278E6F;
	Thu,  8 May 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nPPDJeqq"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071C278762;
	Thu,  8 May 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718671; cv=fail; b=cVWOeiaSIvn6u8gVSZDjVAdxRJpTiz5ozePO9s72BzlvbXjU3tPIgbkA5kbNBRCCMs6P1F/IwcYFVdpfFUKZK34ayMmZaPgyK0AWjTaPD2D4l0IN5rCS1K4jF5zbYsMstJ4lPMzKKvSVWLr/WlMjgs4D0TMNgcMOrEzl8Ghtxok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718671; c=relaxed/simple;
	bh=Dv7F2HkZIhYssqCQjHHCB/L3ErwmvjHcvFKdNamyVZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rCFWnNo5/KNxT8eE8oKTYYc44nQXALDQS//+oFe3LI0ENN2EQ5OUW4iR4ehNZeUMHDk8YOX1YdO8BVhBpBZ6/sxq1rjtz3DfurLRf7WNsZACrISSj21yQmXNBLYYtxBrqC7Ddm+G2/DGTNWRFdjYEpWDQ3bxkVaBCzWRdYtzxoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nPPDJeqq; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEvzsM4eW/A+DblKqiwWMtG7LOZ/8VeOs55cFTuoKKlpU36Xh1gIL9x08X8DKCo0vqSMO4NkzeW7ZCISiPZl4Q3Khg0EwIpihIZxgUdUGaaGyQl7bfaOMODo5N6lG0CQfCJ/vMGkaDX3wJNY1Ca/OmcmjzNukD7Rqp2X8Hs4JJP6Um3wXhoQnll+Uwq6YhW4MF1mXq/cU0tu+4TXz7oWclWtg84d33TVXR6MZpq1l9EyAaRUnSpAFI16d6ACtb3uunHQawgE0yCI8a0m7kM1eNn1XO3nsZVkA20X5tOXYx5MZZ7k/YfMVoU74sf7MexZTjhu3oScVDlTG/vjdHf0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPPSiC4bemJ6btGwWv8nhyyI5pW74t/KPs9A4MzZhyA=;
 b=tTRhXAsFxnwfTFW4WIUfFBT3xsDfEKQFNy5S6kJeuT7EjiH1qmnxk7N6vD2y47Po7/ikQHneqrxIrR3somkhl0/VAW8yXP5MvTJ5ilEB4DtKkHR86ooLm0tjXv/tzUyOSHgulBp01cWPfoEnBKSlKQbZxySfdHdRMK8t9VU+hk09Dj5CgW/itIVArRzoDHZqHRd67knv7H26eXgtwWriU2FmTQWxfJNgFllyVgENbKuyArkyTOocgZTN+vNkZl4VUStr7Sg82WmRaqp4ujpJWeynBzZWyoLf1XfFHgQWdf01aOrKctspEqzgQeNdmlOP5g7JHiqsv7W94i358a3M6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPPSiC4bemJ6btGwWv8nhyyI5pW74t/KPs9A4MzZhyA=;
 b=nPPDJeqqdnQgxH+iQ3dP7WJiuup1uQzpVQ0mrCVV5IWVA87zLfkWdau7pxcnqw4wNmToToi70QRaoFfkk59bakWTrTNo4GdUrJNHtBR9kLU4P86mpK6fwibsCPUMAVyC/kb4+WWwRzl7uiDpD5hRJW7HGfUcWuIkMpfxrXXowuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Thu, 8 May 2025 15:37:39 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:37:38 +0000
Date: Thu, 8 May 2025 11:37:34 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 13/17] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20250508153734.GA1939543@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-13-8ffd9eb4aa56@amd.com>
 <20250507092042.GLaBsl6pczL50Qdr3e@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507092042.GLaBsl6pczL50Qdr3e@fat_crate.local>
X-ClientProxiedBy: BN0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:408:e5::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 5690268b-9d0d-4c8c-3b27-08dd8e464327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cFQDnGb63jMiqo6Voi3H7WPegQKwWHGNde7AKbg5YuGd9ddN+CGQMAergPo?=
 =?us-ascii?Q?Fa3uzT94T6oKMzZ8NfaJgHu9fYuupQR5vt+sJPwJYnWWV5qgxxxYcHbbDjtm?=
 =?us-ascii?Q?Ke0uaz0OW8DCKkBhojOacB9BAUhlPf7Otz5MSiPY+8xvanuJDpslPZPbwCpc?=
 =?us-ascii?Q?yH4l2p8bA2XYt0c8W2t2EtuT53lxQ9OdjBlFT4D7suzRnkVhp8vU0HR6YJFe?=
 =?us-ascii?Q?DkODCh5Loo1XTDS6RnMzUaFy648x//sfnPrP8D/aOT0cpTlgp0p2TpeGHTEt?=
 =?us-ascii?Q?r+yoRypICUkqF6Xj18VZExnVJwPg1P9m82z1ijhM7YoVrO+GezD9JhDdp3/g?=
 =?us-ascii?Q?WnmNtSbrKpQNKJHtvKRoX3CITm5gantaC5W+cxOKEQd/GAQ86MLOQ4bYbz8/?=
 =?us-ascii?Q?fIIcR/xdTtAzQ0CDMBTMaZNmw0M7KsDS/eZ53oqRzYUbmbal2JgPEo6gd1VO?=
 =?us-ascii?Q?piu6SGVOa49LhXSKF7Iz4wPdx8qMjKy4MBz/wWF8aGuGasWbWI5jB5IqIzoq?=
 =?us-ascii?Q?fdRCQO0omvvEasG0hzdMssAboQMwIdXUKd7Nz085WNM/CFJLTRhutp1e92qK?=
 =?us-ascii?Q?zY1nOduWqikA7hOCFHFUa0ZFRnorHJ+h1ZwOHsZdgqisE+xThqRSTbMk9NVl?=
 =?us-ascii?Q?7TCm32JajgCWvyxcFIIJ23+pMf8bM/PEn+7B/21z54aruSiMz6WzxZs2WJuQ?=
 =?us-ascii?Q?CWti9DUmK8BG5vicShfMSZ5j0E/6SFIPLELK+ay/i92AhyRZkrz/HX1ieL5i?=
 =?us-ascii?Q?RTTL4lvuWWAi3c3G73wkD0mr9ov0yLCXz7D2fmCISWNOvsAA6m6vmyiM0p1V?=
 =?us-ascii?Q?gCrgv3N2TKL5Ef8/11byMVLPcPogUSUmhdcuZzRzrddaqZN9VcDTJhl1Wl3J?=
 =?us-ascii?Q?VZeQkTcehrNY/QYbvLDUC8KGYdRx6LTRG9t72voaROzsSBLs+zJmkipo1lDe?=
 =?us-ascii?Q?+gh4GOhg7y+EH2Z9OdkDNdkXyOzHgs1vR0cSTSj++vZA9Sbsbt5fjhvnpvSZ?=
 =?us-ascii?Q?/YmfC0DU1UAUt/lh67Ze74ejzvdXJz1nTw1MbM/B/JOVnyjSudK066Lha5nl?=
 =?us-ascii?Q?2MnPFUtR3yrAyxcRMIuy1iXisV7Vx+iFkFFOH/4MlHIrj1EuWbF4ROns4Wo1?=
 =?us-ascii?Q?XGSA5rOaxmLI0G2roWI/vJPmon7WkNGW2xuDu1iQl8mutyGvfS9YI25cLK7G?=
 =?us-ascii?Q?mVe9nRkDrrAf1WjxVhTQEN0rlmKCWxAKvcLAzd4S1VfRoo1iCCsI+dnqu/sc?=
 =?us-ascii?Q?nk/Eac45Sox/M8qU3wsrPTsuKQi9Ph/CltzUAV5y8vUqS6Ewm1O2qQYV8nB4?=
 =?us-ascii?Q?S9hkP275A0HJlWsvP7jzf89rGqeWQZM0hkdP5UOTEijf18Hw1CPfvWW+A0CO?=
 =?us-ascii?Q?9n4wRIOtJ9bM/X+q4D4oY2TZw/mpsVZMjDjlaTQsQjXUsz8VSkF+kpgKXZ4O?=
 =?us-ascii?Q?bV+iPcJQl+g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJfPkYUIdv0EOglsL4EQHPL+F0L+1cktvOWad52eGZuq3XbnR/E0iBpNhrWS?=
 =?us-ascii?Q?88iDnTgqkewiY18jCeLHOdQPRcDcRRGtafl0n/RCTN6hbPCHtJqgjUa6PfX8?=
 =?us-ascii?Q?iew2LKONib9z7fApYpQRg/BxiGYHTdZqhcwVkfuUsy9gmVi+RJ2t8xVJHdPo?=
 =?us-ascii?Q?bm8vTIwtvzW928mJ273Fiaj1MWV6lVoJp+t6XXJyo7Xp83Bunadv2u+3MrTd?=
 =?us-ascii?Q?fScGjvF1XiOzsauCbfEq3FLpwpsYlgRyqkmoaap5gAshZr4jH7X3MDufvYI+?=
 =?us-ascii?Q?ni1IcualVj8/Ji/2FHkqxlYlnrVgA71CalpZXa32mr4Zz3jQxUavzIjBZI7R?=
 =?us-ascii?Q?5xAsUVlTWO7B8qZZK/sVqBZPnKZmkuljD0Ay4mp09P6akVOua+L1FAEKyLRF?=
 =?us-ascii?Q?fdCQyzsSbDCXCNUOIRmPImQNRmJXs4Bp/GvTBDdDZulkfFh8mBq+bSH4MAnJ?=
 =?us-ascii?Q?eX1a90XEm9t+7J6xD4kYv+v/j9uPqbdyk7Rsxm9XromkUhzAMaLfXEdUSPj3?=
 =?us-ascii?Q?C1+9i/eYrwBSPEdwxaWSpxil2taLjdcuw2UgbV6t4eTG/oIm0ffYeysWShLW?=
 =?us-ascii?Q?/P7MuI/aSGo0jTy6bAzVzAty2+JW4n4qqH5UhZs2DeXVm5PfAq6INlT7eIlS?=
 =?us-ascii?Q?R8IETSOtwC8lSIpm0WTiR3rb3z/dV66eNKXODBtLcbRyoTWA635goXub74Y/?=
 =?us-ascii?Q?Cmypzcob9nlj8SdeyQgg4uil4hRJlxD+6UIZgljCUPBzR3ZX5dXuJQOf9Z6w?=
 =?us-ascii?Q?rp7cvIW4M3wX0uCQDlFKRi/AMtd+UsSrLrXx3WdHB8as1OgVA5MWkJ7OhRAH?=
 =?us-ascii?Q?eq3k44oj/eOhLoEsIWcqsaJdLItDeyGScODgWz55/4Kh/f+3aR6YgPmAvILj?=
 =?us-ascii?Q?wWoBbPCHG3GAcIU3gExlhxlX3edHE8OPmH6kJbPFq8G4hiY6UYApzjn/AMVj?=
 =?us-ascii?Q?z0WikpXH8HaSn1/Hu2QYdSXtigSBuhiPgdY8Mr62LPTCD1AVPhYUikFsfUZK?=
 =?us-ascii?Q?5d2uwhnyAqntRxGv9orPdG3S0jCt3W1gD0l7hdfw2EoZjT0+JiCIAPWjccHK?=
 =?us-ascii?Q?DYCCLJA9lO4TXL67+u6hQ9ErpRPLIGFVwRINLO6fRdRfSlHYaRTPHDrIKb6f?=
 =?us-ascii?Q?uEsTdji6gez2ZuR634wpOo5VsYHJhyiezcJ6g5bqhQScwPhQd6mhrw/r0Avk?=
 =?us-ascii?Q?lI4X3770njSTEzW49HsM7vxtVAygNYZKvMdu0qvyAigpC5kBWTt0JNh/sGmj?=
 =?us-ascii?Q?RsH58aMn0vcJ1mvBYQo2oO9nTmgztwVwWatxy2zdYNJxi7x5F6ke+VFQ1bYE?=
 =?us-ascii?Q?t4vlWW0g5n2YIDBvKWBsfCpRHdJLQgqrZibmypIWm7QzilBCnfbZTkATFZW1?=
 =?us-ascii?Q?cjQJkqS4LyInnhNxtZy4uqQjvpJHt69B7b0/NXr/s3dGbizQa23Jjqj8WaK0?=
 =?us-ascii?Q?K1HeGh4R/+nvAbCI8x9kYqvyPbovidQZPSzfTga/RjN3aw3mAJuPzrrPzA4y?=
 =?us-ascii?Q?zxkceROsFRIpyD9HbStJ+VxzYgXDu2+XI/0Mn34CUCIMLXSvL5MeaWO5lFrk?=
 =?us-ascii?Q?2ib2Xr/FjTiCT8udcru45Zbeh0+TM3rXx2tUnRTp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5690268b-9d0d-4c8c-3b27-08dd8e464327
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:37:38.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvGxNXPrGrwNiA70xQPSeCpzZmcFnjFSwEUi5pofrFNUdOtFYhGv1IGvUbYwe95crla+lQKphfObWzNDcptlPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246

On Wed, May 07, 2025 at 11:20:42AM +0200, Borislav Petkov wrote:
> On Tue, Apr 15, 2025 at 02:55:08PM +0000, Yazen Ghannam wrote:
> > +static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
> > +{
> > +	struct mce *m = &err->m;
> > +
> > +	/*
> > +	 * If this is a deferred error found in MCA_STATUS, then clear
> > +	 * the redundant data from the MCA_DESTAT register.
> > +	 */
> > +	if (m->status & MCI_STATUS_VAL) {
> > +		if (m->status & MCI_STATUS_DEFERRED)
> > +			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
> > +
> > +		return true;
> > +	}
> > +
> > +	/*
> > +	 * If the MCA_DESTAT register has valid data, then use
> > +	 * it as the status register.
> > +	 */
> > +	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
> > +
> 
> Superfluous newline.
> 

Ack.

> > +	if (!(m->status & MCI_STATUS_VAL))
> > +		return false;
> > +
> > +	/*
> > +	 * Gather all relevant data now and log the record before clearing
> > +	 * the deferred status register. This avoids needing to go back to
> > +	 * the polling function for these actions.
> > +	 */
> > +	mce_read_aux(err, m->bank);
> > +
> > +	if (m->status & MCI_STATUS_ADDRV)
> > +		m->addr = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(m->bank));
> > +
> > +	smca_extract_err_addr(m);
> > +	m->severity = mce_severity(m, NULL, NULL, false);
> > +
> > +	if (flags & MCP_QUEUE_LOG)
> > +		mce_gen_pool_add(err);
> > +	else
> > +		mce_log(err);
> 
> Except you have a function which is called "should log" which also does the
> logging.
> 
> And you have that same logging being done in machine_check_poll().
> 
> This code needs more designing.
> 

Okay, will do.

Thanks,
Yazen

