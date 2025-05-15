Return-Path: <linux-edac+bounces-3921-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0ACAB8B79
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 17:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11023A4C1D
	for <lists+linux-edac@lfdr.de>; Thu, 15 May 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D921F7580;
	Thu, 15 May 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zglCHJmu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CA481C4;
	Thu, 15 May 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324041; cv=fail; b=ILwtuLdBvFEsox1YhHLVDU0rMhXLM+Gel9mpkQR+RfK2iqsA3Z1AL6H3bM3AtVpIXqtZ/0egIzzaqcOGELYyMvTZ2rqXn0XSMA4/6mkYM1Dhcan1AwIf7fm8llm74kEyYbi97t1V6A/VMEbshPJAfzVUR4rNfA+XxZNokF3DI74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324041; c=relaxed/simple;
	bh=3+K+/8he5I9TDp3m2ctadqs7PKv2XJrB7L9D8mf6joQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r6/yx6UxgPYtK9N61tOSy51vh+fwIMQZChTZE7DfpnTZlc85zffIXcnQ3fhIXIt6PiIbaIMhyWZqHkhrVE5js4zSuQCEE7XtPHW56em14vEoOyuavQZmonoLNiOUsbT+/qPb/KpX2S58OEWl/Yrp1lj18jKTsaBndJq01qT+cNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zglCHJmu; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K49pLfZsSqAvhEotGx+RwAJmxZ9fA7UtApy4vSs25u42yyzhj8xA0xKkuyQonpMQ7xf4DO3wiFrbhIkczNm9oGK663JRh1PRDmEvZuFX+B7luJJyKZTkVP7NkX6MhSN9OxKO5igMq7uhz05hqsnBh7QrE4RQ/+BoJpNhYtT++u0smdblg9ZFMs+iFkQkRetIFwEuVrncIlvTf4FdtX6ZsvkGnPHN6eC4Q5KeFqKhpqtyHFr4MmZNXTVJURaQvQJjcQBQiUe/QlXSONB+1ijNvXQmzbQLnpFTvtCwG+4JNErWz/eqzkfNsrdeCRIFFlLmF1zK9s5/PZNoh3x0jG1a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WxrRq49uGZHyM4NzJio1CqZhAPcXQHuCb7PheP749w=;
 b=LTs6talHpMtOzkc00tv1rVX0WtjpbLhe6PnzFZ5WzW0ilTyzfGUM8+c18eBlbEj8/Up4aswIE8pnXNgNIA/UR4kb9/5mHGsbLLUSiGnmWIZp9BAToZedWfVS0CLfFItOl40zAh+ORwqaU3L78fAmUgU2SylUwtyV8SKQEblGN2XMz07wdOv/8A1fMlTMiV5d7ipgwhELWofW0NgivKda/A1w/LNSoiDGhdESn+UlWz3NuAWks0EWY3OW9fPhI/WkFLDRxoabQkwJMS0OplDbh4jZYwMA/npw2jmiLK/46hSOmNkBX6nmMgKq0R2x7c0tLpxUMGF09Zc6fF6t+o7img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WxrRq49uGZHyM4NzJio1CqZhAPcXQHuCb7PheP749w=;
 b=zglCHJmuBSzq8MYKifgX1NxVhOSDaf32xma96dgQ7QQa+Ort5J+wm0ZYPrHPUUGRvfRqwhUTo9w0hGzzOt4tiSn12BCdmowILz704QVShX7xrdN1imgcTgFxFPMQX3qHzGYGsg7SdMXWBSE89QP39E8VvYCgRkmrV1px8AmvKV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Thu, 15 May 2025 15:47:16 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 15:47:16 +0000
Date: Thu, 15 May 2025 11:47:08 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250515154708.GA19721@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
 <20250513175543.GGaCOHn26isB18J9ig@fat_crate.local>
 <20250513210640.GA515295@yaz-khff2.amd.com>
 <SJ1PR11MB6083BB314BDEDB397861C845FC96A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250514143416.GA597208@yaz-khff2.amd.com>
 <20250515123708.GFaCXf9DLcsPqXhFSn@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515123708.GFaCXf9DLcsPqXhFSn@fat_crate.local>
X-ClientProxiedBy: BLAPR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:208:32f::23) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: a87f6ba9-fdf9-432c-a6d3-08dd93c7c48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PAMeiIprKGYJBG3zpyeQyLTuT5ix9Z1BbyP0lNbA+JhV8Yyv45sjv4T2wILL?=
 =?us-ascii?Q?7VmJtzV42sNbVIzdqQSMj18q7WckOmGTTzFW+4SBQg5IU0b89ne8lUJM5h24?=
 =?us-ascii?Q?VVzlrJParxdQEApWYLxwVcqqP2LgOEB18dkEdipgmkCrk3DNu0CFdm3u9gV3?=
 =?us-ascii?Q?N/SukJjD9jmvOJKe9d/G42irL7CfLwBQluehtFUZm1Q9psD4iNxzJphyQy7L?=
 =?us-ascii?Q?d8QwVMbbFW1Ge/+cc+YzdmtojkfmKjRzMevDuIMXSf/EZ7h+2Cgle95jzDhn?=
 =?us-ascii?Q?lG+q00K81w3E3NjdlK7FN0tObf2fABbva1UGJq6JDWRU+PTUYj/hnwnO9tDg?=
 =?us-ascii?Q?aLVfqCxSYv3cip65VS8rrYbpzdVG1ipTuPLDVFQhnQGuXnzguzen/lZRbE4H?=
 =?us-ascii?Q?fCdkDfGXW5ol1zDC/XxNVYv1Z6fMFfYTmDreJg7tlPyKLOEYMKpDtFwpOxbt?=
 =?us-ascii?Q?/d6W8yf+B+wmpC6+7k0us6tSXXOLFMV+a2fSOc9fDocIbPSoTi69wyDWqzE3?=
 =?us-ascii?Q?23UfRQ2zNnWdXmgk24uq0K29qBhEDHvHjkUuGFCgU/lUVArG2CcQ+VqosYg5?=
 =?us-ascii?Q?D1VcsN7ftMHKjQBK8ijH2f+y17DEisJtGvG7A9eM+RWjnOZJS4aR6z7+StI2?=
 =?us-ascii?Q?/2VhLswgzQ7YXlFIlNa1VWxVdkJgHknigCCB5fuDQY0fJID1mePg711D1t5s?=
 =?us-ascii?Q?JGFnfcj8mHZai3PvBk2fLiyLfx6PXhBSBc7bNGg1/bu0iFl3JoGQ7y0oCXIk?=
 =?us-ascii?Q?twrCK2yCJbpaltDZ/qi+WA7LhSQjXCtLamcTJlX9TG9Y5I2gKjDlmuCpyn+x?=
 =?us-ascii?Q?CtBgGfpGam+WdJn+dp8VSc2dUihiXZki4ri4GuH35S+Hyp5i97FTGn4H842I?=
 =?us-ascii?Q?Ycn7T/SbCuxJGOTc93bbsuM2fgsk7G7p12AgS0kAF8wzqTIQfp2PT0K8Kg9w?=
 =?us-ascii?Q?hAVxvu3VU44pyPepSSHR355huHQJKGW19BF7h0e+f8J5vbD/6+tqObvBZ6xS?=
 =?us-ascii?Q?DSLwsxiB0jYxVe/btqHTQ6lc5LTdS5xM92ExT6KG4N3DgQv6O5kFDAWzEYiM?=
 =?us-ascii?Q?gzxCrZfFDe8tp/gT7WlcQ0Cf3sHSQb56y2w+E385RMyPCnaOMDHjqO2m4tyg?=
 =?us-ascii?Q?/2+3V25IojkgO3Yp+hWQ2A38wAADMQdoE7EkNph3yyAk9sSstG3VTQldLc9H?=
 =?us-ascii?Q?f9ZrH5BV4bZSVmHbXCKQdRKDlIlQP8536tqD8kRx/KPzFbXaqLqDtiF6/chq?=
 =?us-ascii?Q?HrUuS6DBtZG5kpe+FfIbPkh7KfUNksVAjojiRxNfIA9PNnUvL+Zh07Fy1RGW?=
 =?us-ascii?Q?7FfK7GKwZHBtccIpZkAXK1PflmbqctCcASuiliT+9429AmJe+rYwJjAzMuIv?=
 =?us-ascii?Q?6OW2jXCRxFZS8/vrktGPGui0qiypqxvt/06LTvjuCw+ZNwd7vdeKPhVbiw1/?=
 =?us-ascii?Q?EPWyz37qjOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9RhVfW8U+1rq+LsVJ9N9NmVQfZmVE90qJ5Xd/bLcfm3QnQkMygI6KovUUwB+?=
 =?us-ascii?Q?5ixpz1x9npAQLH+RR4kt6ISYH3YsJpLfCjAR2zO4PSFTliz38z5Q1GO8ci2e?=
 =?us-ascii?Q?lhbKITP8L0FJMYyqCFMCAuo1PJD4xKI+Nd14A8Jrp69zjz1HjUMokRSrBV/N?=
 =?us-ascii?Q?BMMzgbJdwDbvCuRnkeYyI1ceSlbsJ5NN9xFwHDP2hR44Ucp1ofwdJAcTQaHY?=
 =?us-ascii?Q?TKionId1Vnx853xra1sCgF3rc5T+YcDkdKLJW9u3QfpbMY1vi9ToCEu0uyaZ?=
 =?us-ascii?Q?Us/1DBhmWhQhO9csswH+VCweheBrBOqCe8X4nMQYc3jfeSR3gzGlCve6XW/k?=
 =?us-ascii?Q?O/hiNtVQbxAxDLt8aexKhsNIiW+CU/1ukyxNETY5yn1YVy347kuOrPxUuiES?=
 =?us-ascii?Q?+J41iJyPdMSs7Wc6gIfABMfs85b+ItK8rBGaWhxLrxNcJ/GLPVANjCK6Pnrr?=
 =?us-ascii?Q?ayeaLtOP45hYzgwZahwWXZet7doM+pS3356qUoepu+F+RrDKA+KdMG9ilS1O?=
 =?us-ascii?Q?9yM1CMrBNz9cSkqznbzbr9GurC83Nj2kvXq+VGjlpoNWOdmxHQtORfXLe3/G?=
 =?us-ascii?Q?wqhInA8ga7YicHJGt/vvcfyzisHoLZbLDaQAn+sL2Yb/iJn3g7RsmRQcgnLo?=
 =?us-ascii?Q?NgG2toWBQrgDnH0/8j3hTphYmYIqCEl3NwQHakuVFwkH4ox3y+vuzjImiewS?=
 =?us-ascii?Q?TFnBsM5cSkTK76FDwftqbio6HedEO66HHA5DbT+TiIru2WJKK0WZ6DGXs2hj?=
 =?us-ascii?Q?s2PqPb5Ht3Nzd6BXL35HBZ86mSUHj3g8xzgN/FgPB+3XQ/GouKvgFhqUExbi?=
 =?us-ascii?Q?KglnTbpe5bOs4DE9A1r00YdqWILVvusn4Iu1JBhGMQc1cLuGNsmfwM8fvtmm?=
 =?us-ascii?Q?hG0kUlZxOAE6yUBZNsCTC+PTrND28GXJ2p1auG5HryCZVY9iOaMyAXpsLxgA?=
 =?us-ascii?Q?8nD/Ps8S8TZE8EcGCL1UVg6IH4Lv2aRumKZ3sSA/St00M2tTffIh7N8/zk9N?=
 =?us-ascii?Q?L+YbVa7TJ6eG5G030p0MAC8530KNG6Gs53+MboOVVPwGMxWxgZXuiCpcwEl5?=
 =?us-ascii?Q?AoXMmviUQkHlCgPjTKK1EjsKZrdR5qEEFtt9Fl5LmPdoxyI95r+Il/5mfHDL?=
 =?us-ascii?Q?0p1/SuRauMOaxgTlbwP9x7JEjps6iuINmN/RehxX85sYranmD/2pexM6QAOh?=
 =?us-ascii?Q?+jLONHIiocVTWcwVJsf2HAhUSwYneFX070Quw4pXeUg/uqE4Cfy2lw5q5ocp?=
 =?us-ascii?Q?GQVpc43jURXgRU0CQTzh/2fAc64m3ZA/dii0h/MjonRXh2QTC+N8Ma07wkE1?=
 =?us-ascii?Q?7d54pfWF4KnKctJKI3uAhfblcsIErkcdHRnCcOtU/Buf9y08iyNLe2x07XSF?=
 =?us-ascii?Q?nsgtcSOIdtHNl2qO9ZIQlSFRxv5K7KgSHfX9fvZORBl34byAlgsm4pJ4FqDW?=
 =?us-ascii?Q?kSQ3pXn4eWZgKN6ROcWpPRtnokySRfFJ/8wjF10p0t/muxek4G2hJ9/yOE2x?=
 =?us-ascii?Q?q1JCSrdi0A6W/pBnKpMh/T4/va33Q5mphqxyKi1N/TqQi1f55XmOJW/CTyFm?=
 =?us-ascii?Q?FlexPGc5PQLsahSFSRLwLK2dQO2pF1JrZaZDo9h6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87f6ba9-fdf9-432c-a6d3-08dd93c7c48f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:47:16.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8znvH/yXdZZLKSltbk0eDpxeqgVe9H/U9hSwa4nyg92C+Y66dRTaosu/0KkUeGWE1esgeMlIaSkdPoXXWJJXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

On Thu, May 15, 2025 at 02:37:08PM +0200, Borislav Petkov wrote:
> On Wed, May 14, 2025 at 10:34:16AM -0400, Yazen Ghannam wrote:
> > On AMD, MCA bank management is always 'local', i.e. per-CPU.
> > 
> > If a CPU is in the polling function, can it be preempted by an interrupt
> > (not MCE)?
> 
> Well, ofc. We're polling with interrupts enabled.
> 

Right.

The polling function is called from a timer. I expect the timer is
checked during a timer tick or during rescheduling.

Even though these events are interrupt-driven, it doesn't make sense to
stay in interrupt context the whole time. I think this is where my
thoughts were.

So there's a slight change of double counting errors if the polling
function is interrupted between reading MCA_STATUS in a bank and
clearing it.

Thanks,
Yazen

