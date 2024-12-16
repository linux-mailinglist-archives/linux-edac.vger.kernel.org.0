Return-Path: <linux-edac+bounces-2725-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352B9F3E5C
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 00:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE4C1890124
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33AA1DA628;
	Mon, 16 Dec 2024 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G3JSm8K3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nm2m0RuU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A201DA60F;
	Mon, 16 Dec 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392304; cv=fail; b=fddvgzK0MN88lf6A75uoxFOkpJN4gvaoN9SWIU3UU734xm4yeOvlo9+cNEADBNLxs/M2DXMCmzSMAk2kBr/aToZ2v8NJUvWadZGMf5g+DHTLtNCELdf2/hUQjCgtkr6as2/xTsBjtT/X8BEDYRQ9Cc6aiF3Wbdna38DeYuci15Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392304; c=relaxed/simple;
	bh=BUOv/9YROScHFJ7yjwUXOaG411YkZrvzT6yTpK9WTAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGXqSRUeMsmYb+fZjPnyfd+4AW+smN5JPENkN1FD7IicGxhCQSNGpsT0vr3bvtHccH88WaQ20dV7ZmuWjdj2NzI0zJQH4UmPABFTOTmisuAGUwfo++MPSHyqiFSoy8CYQ5TqX06k5OE8nciTWdnU0OjAx6basgFzlKv17xCelOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G3JSm8K3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nm2m0RuU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMjgIC010220;
	Mon, 16 Dec 2024 23:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Tq2J/qpsM6Qsv9lHnu/1dpnw2zpdtXpoPXiwJsuMtvg=; b=
	G3JSm8K38TcV954p3AMYqrqacttTPgtZUgRVY1wcKI/3nofKXL8C3p59g2s/Uucc
	P3OfY/YVVFd11oHyAAHIhAIhQFJViy3OukG7zPP8dHFM0r8ugSx6JJT1z86Izmm9
	Nk4hN0M01FLX8l0/5ruM3qBqf/mhuI/w/jGEF9ZHKdjkrlA7sfqnO3/madaKze0y
	raNJXgcisefPmZnhvrQRZMqL70sByerG0prBNyo7WuaccXuEZjj4yosAyd+gywpG
	wxYv9ydkXbLB5qg3lO96+fNhGqiMfX/rG9NrI4Dsn7oaTkti2pDj4eN7zskIPnhm
	ouloTdVp9RolhOO6PripXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xavqp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 23:37:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGLUvpH006434;
	Mon, 16 Dec 2024 23:37:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f8p9ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 23:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8ZeFVUDvBU/bW/KD3pmb/6L1XT8Yn1C6FMpIh9fYh+wQIgc2ayX4CcIUhign1OPH4j1LhM7peR0lf0HKZTL0DKoJtDU5J+AOKxqh+oR26APqf0u1B3YfPAmZ/mo5MtElUQIylDjaCxFw/J2nrABc6RR0gYsPE4ucrmfsvneq58WJRe0dhDYGW6Vjfv7iPye6SJcOKyP4E/fBxAc0YoMGsxgIb1c6KQEWcbllfxDDfT7ZoJqlDQpazdJSU1ZwHOaFZGZG5gy0Q/HvUs8nnlMfoPLDL76Tvb3CmmNGAF5MY2PFL/Yf9PCtNR5fJtvUtydHgwMCAyjVhfam+NOqvkXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq2J/qpsM6Qsv9lHnu/1dpnw2zpdtXpoPXiwJsuMtvg=;
 b=MR1KtWyTzxLdOLd5sW9OIxjDAVuWoSzrw+p1+osOpdAisC39xafFggiF9yFK24oCdTBwU6BG91V9rC6lhZccCvznsYo8tmFcYmYKsRIJkpAECE+f9Xi3SrSpYif46L0WBU7pjLTTZ9+XPwOGx2EWgviXx/SECs0I8MWvFZnMwpk3pKPphpWNR2SGO6ESzkpOZD1LNFsxvyItjvWnz74PTMK3OymkVX3l3dbg7xnLns6WS3FZd27pJiBh3QSPuUIq5FHrsFQ0nVidMkCm0dBmaPnkSS4QtbeUepmdMbr/yYVAFmjMvGwAXZtOVXiSesN6Zacslr+OqfIkE3PBOVt3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq2J/qpsM6Qsv9lHnu/1dpnw2zpdtXpoPXiwJsuMtvg=;
 b=nm2m0RuUFYnEIZnnCYgf84M7iyErzzkylshMN0MSv6ZdPHu7NJBLVCgDLRCmCDSxSBYuodxzL63znk5bPrq8jJQVdXShBajYlyPGrCXd47sERhVM+Pg7bSFa5dAy8P+KXrzvmof85HQ5c53QB0hAebtYlg8dE5/hZw59NkB15lE=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by DS0PR10MB8200.namprd10.prod.outlook.com (2603:10b6:8:1fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 23:37:29 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 23:37:29 +0000
Message-ID: <2fb8b1e5-d606-47be-a79e-a4e37a3b8f7f@oracle.com>
Date: Mon, 16 Dec 2024 15:37:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Shuai Xue <xueshuai@linux.alibaba.com>, yazen.ghannam@amd.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
        robin.murphy@arm.com, Jonathan.Cameron@Huawei.com, bp@alien8.de,
        rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
        wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
        mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, james.morse@arm.com, tongtiangen@huawei.com,
        gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
        robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com
References: <20241202030527.20586-1-xueshuai@linux.alibaba.com>
 <20241202030527.20586-2-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20241202030527.20586-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|DS0PR10MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: d3238717-5785-42c7-6c79-08dd1e2a9adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blhCRHRRSHVDbGlWOW1ZWDBlcFNTWmNrM3N5T0N1aWR6Q2hUZWorQTlacWxy?=
 =?utf-8?B?Z29ySE1yc2JCLzB6UFZCQllVYnJoQ2xvTFJUYmhBU013RzdVOGJQM2JrdHIz?=
 =?utf-8?B?cFVyTTlnT2RHajh2enBFN3o4ZFZOK29wZzg3NDJ2WE1LbG4razNqRnpCOFBv?=
 =?utf-8?B?LzVFMHhPdElNdWRPNWQxTmhvbWdib1RNUmtIQkRDSU1OYTNpcTFTYTFYbGV0?=
 =?utf-8?B?Q2FLTG5LWUh3Zk9uY0RsMHhBclZOMURmcDU4VVR5clhkL3FtclZodnlIeGRS?=
 =?utf-8?B?TTNTbGpZNkJrR3B5SFlwT0p0amFxVWJGdnJ1RkNXQ1VtbnhYbkV2SmVrWDRG?=
 =?utf-8?B?RFZwSW1nRHU0T2pTaEpzb2xwTENidEwvTTB4Y3FPNVlMRldvSituV2ZoWGY1?=
 =?utf-8?B?eGpGOUYvU1VNTCtiQWdVZFQ3QXVjNksxVTV4WmJVVzBlSEpya1BNNHBvVVFi?=
 =?utf-8?B?WDlTYnJjK21jTngvYnp6QlI0U0pZNm9ZZmVvQTFsbjdMSHY3NVJDTFhUKy9R?=
 =?utf-8?B?MXdzdzRMMzVoQnBqTnE1T0tCUmtNUGZVNnNMbnd6ZDlHb3MzNVN1a01ockpv?=
 =?utf-8?B?SkJPeFJQbVMwSlFlRjRtNXZya3k2bFdyYzJ0MVBZczM0ZHl2dm9acmZUOXFB?=
 =?utf-8?B?MW5RYXlnR0EvQmxqVk9wTVZ3Q1dSdDJ2ZG9YMzNnZmVNdkIzMEwrOXlwYmV0?=
 =?utf-8?B?ZnMveDBwY0ExSWhONVhwZytLbklhZmJ2bnVaUWVrZHp5ZnFTR1JlY0N1cDVY?=
 =?utf-8?B?eWJSb0QrNEVvSWEwb3NBaXZOM0tlTEJ3MkM1OXYvZ01vblVJZmFwWEJQN0NI?=
 =?utf-8?B?Uk8xRkk5WjJHNUJjWmRISEt0amIrM05QczBtUWprQ1kwN1ZJMVZwdmJoQkhP?=
 =?utf-8?B?SGM1ZzV0VUJDbnRFS0tET2VOSDRZTENwUWUwakFmaGdFOVRYbTFkMm5RcGNj?=
 =?utf-8?B?VjEweVJKZUUway8zR3N3TzFUUEZERHlKUURVSStEZHR3Uk8rL2s3Z3V0N0VF?=
 =?utf-8?B?SENuenJQcjRyaTNVemo1bHpzeUtmOUN3cThmM2VDNDllK2daRk1id1RjZ0RL?=
 =?utf-8?B?U01NYi85MVprZVBKcDV1Q2hjRnlMRFlEcGF4QzFqU2FFaE9QSzZNeU9nb1RM?=
 =?utf-8?B?TTI4UUpFMnpqcmVwQllpcmNKN0ZZV2pCVS91SnZ1WlUrNUFqQ3ZQRUgreWd1?=
 =?utf-8?B?V3I2ODNDSDJEQ2RTUGxsMmlqVUxLZFRGazJPK2w0Y2RzdTl6KzdkSStVaHRp?=
 =?utf-8?B?bThKK1pzTmdPYlZlUHJSYURORWNrOW9Vc3hTMVJFbkZTSjFGMDZiZEJ4ZnRM?=
 =?utf-8?B?RU41TWZDWWhRY3N5a3VIcU1CM3hhZlpTS3RLMU1ZNGRSUUsxME16MU5MY0dp?=
 =?utf-8?B?WVN6Ukl2Z3AxRDFRQnIrZW5JTHprd2pmNGlmVGgxUE5qRkY1c0oxekRoeExW?=
 =?utf-8?B?dTFaYWZHdnlOTm00SUkxVUFRaE1pZzRNbFRxaG1HeEJVRk83NUNUQ29WUlZn?=
 =?utf-8?B?T2dpOXVCcFI3V2E4RTlDZ2s5aGorcVZSeGpNb0J4L3RhdlkxZHplZ2JKQ0Zr?=
 =?utf-8?B?OUZVRG5tV1Q1MUh1azdrdTlhSE5DaXd3Z0p6Smk5RkNHWDhFV08rWmpUZVF4?=
 =?utf-8?B?U2REc3B2TE03ZTNUTDFlc0xRaktCWUxZdVVaSWtnOHZYOVdHUmxjUlJrSmRk?=
 =?utf-8?B?L1FXaDg3MEdkSFQ3d1FDaTdROGVLRy9Yb1ZGKzNFb2NueitlRWpZOUxndktm?=
 =?utf-8?B?NjZFMU5Hek9hSCs3b0ljZjRKL0dDT21VbThaYkpxS0VXNDNlV3doaHVWOEEz?=
 =?utf-8?B?R0ZRQ3dtaFhkazlzcVVCMUI0d1pDVDE0VzlsRWYyY1RIaEZhNXk3TW4vaXBK?=
 =?utf-8?B?OGNFdlhLbjlucENHRklTemNLamptR0xyaGFtWW5PVXNaQ2pRbVE3eWczK2tN?=
 =?utf-8?Q?l1fYEtgl5IM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amg2VGk1Z3F5eDljSStrb0ltMGxDcUxLaEwrd0NqTWxNWWgvZTc1WU5qVzVX?=
 =?utf-8?B?eHY5ZkVmNS8wUm9jTmp5YlBIR0IyRmM1NG52Q2h5V3I4Nll5NGNBd0gxT0lP?=
 =?utf-8?B?QlY1NGc0bVFKaWRWN053dWR0VGxCUGJiaFdIVVNMUWxtSExvNjlUTjR1aVZ6?=
 =?utf-8?B?TFBJRnZaMzlqR1FLT3RjTS9uYXFScWdPTDZJUFNMMVl0S1d1dERtL3lvUkth?=
 =?utf-8?B?OFI0R1hwaXU1RFlpS043MzZCYlFXMnpuWGJyNUFWTldpVGVkSFpuc0ZWMlNH?=
 =?utf-8?B?aGlHMVI2bGdlbEpCeVFFK2J1VVI5MXpETDJjdWpIRkM3ZEhiTTBlSmU0UTE1?=
 =?utf-8?B?RjFOeXJkUjZwL3RjNzM1Q25yODN6Yno1MlFoRjNRMWd3Ujc1UFRpdGcvcERS?=
 =?utf-8?B?K0pvTXlhZUlQRE9CYXhkamhUMWFTakh0WnU5YmlETWNpWXc3aGx1RlBmOEts?=
 =?utf-8?B?UERpczNjSkJxOXVCR2drNktZLys2cjF5RURNd0huci94b1A3Sm5pUlN4SDN6?=
 =?utf-8?B?UkxYNlQ5d0lYbFBsMERYVm9RQlloM3FybTg0dmRWUENxQUpNbXV1b2dZTzN5?=
 =?utf-8?B?MjVwYndxTWloTmpJTmRIaHFRWEtVdUNwN3N5Z05IUjMrNTdYVVRFTEcxNzRq?=
 =?utf-8?B?MEZwWXhDbXlnNkROczhkODlud2o4d25BOHUzc2l0K1RjRlJzSFYxQnVua1kr?=
 =?utf-8?B?bFN5czExem1oWmJ1OGhHVGpaRVVrR0k2S3J6L0JRcHdHNTJEWFBYbmFXTEk0?=
 =?utf-8?B?K0lqRy9QV0w1SVJMblNTMmpFdWdoN0k3RmdGMzgxa2dYNzdjRm5neGZpN0Np?=
 =?utf-8?B?MHJWT0dacXQ0YzlEQk1nazRkdEFsK2VieUkzcytvS3VEMVhYMDd6YnQyVFFh?=
 =?utf-8?B?Mkc0NENIdXF1d1FkWE81T1hYM0Uwb2lSbkc1MjMwa1YrRGJ2MDRPUXl2SThM?=
 =?utf-8?B?eTJTSkh0UlpCbkt0QVR2RHN4U05iQzYyRC9aUFRKTXpqMGRFS1NIUWJzbE9a?=
 =?utf-8?B?eEpTQkE0ZWU4QTljcmZiaDlqOWZ5aDJaSkdrbGNLeW82VFc0aHRwMzZ5UnNY?=
 =?utf-8?B?R2R0bHZNM3lOUnVsT0szbmRGSHdrUWk5ODJ6cVk1M0dPQUZhZGR4dElSTjZ5?=
 =?utf-8?B?MWZPZCtmRmhSMm13K1oxUjJPaUVzcmVzUmIvMytnSGlDOG1YSUxMSTV1eXEr?=
 =?utf-8?B?NXlEWGpRVkhTRm1RZEhod2liMVpIdUVnTTR6U0gzam9kdkd5WWFIdzRCaXU4?=
 =?utf-8?B?RXNzTVhkeCtxR2tUMFo2RG9xUTBhTmpyQjQrMFpBb3VoRmg4MXNUeG9yN0Jj?=
 =?utf-8?B?NjBWcG1PTitWalA3ZDdSUEhORHN1d0dGR2F5ZlFROGdXOVZzWEViMGpHVGFj?=
 =?utf-8?B?cVNYYnN0bnBXYWo3QmZVbjBPTG9lV1VKZWVhbnVPeUsxVk9aZm5uVHI0WHJB?=
 =?utf-8?B?a1RjMERmZ01FdFpOc0VVclJnTjJGSHZzZWhXdzBoS3lQbGk4QkxhREVrMWFF?=
 =?utf-8?B?TFkycjgzWlZIRFp1OG5HTWNmWWF5NnQ0NjFTbFh1clgrem9FOEJ5T1J6UXll?=
 =?utf-8?B?YjlOTGdIUzJJVVZIeUVDNWJqYUxHYVBHRnZBVVZ0Y1p3Z0JOQUZYR0NCeWNh?=
 =?utf-8?B?OURuUzQyYi9Cc0JDYXpNSExiQ291amtxNzFsWjZjQm03bEdEUlNmazNsQlpj?=
 =?utf-8?B?UDY0aURPc1Z6cGFpbEl0bUdUTjNQU1RBdnVXbll2U0xaaDdLUXZMM2VTWDZI?=
 =?utf-8?B?bThJZnJwVTY5SDdSVXdEL2hJZHNwK2IxTUlUQm1ENXI0blVHb0V3SUlFVmdN?=
 =?utf-8?B?T2JodFZBQjJRL1dWUkUyN0NUOXdNUUkrai81V3JqZk01TWR3U0VZVFllYW1o?=
 =?utf-8?B?aUV4Q2lUTDQ3U3hEUmE5b3lGUmhrYlpOUFBkd1ZpREZvbFF2V3NCTG1wWitW?=
 =?utf-8?B?WGNxTytkZGNVYy8wM1VaYVFmcThNeEJRUDJpNFdBUlN5THE1Vm9INXd3QXlt?=
 =?utf-8?B?T1pCeEttVVF2bnRtSDdlR0JEZFRPUlRQNzRNNVA0WTcvK3h4MnI5OVpEaWJG?=
 =?utf-8?B?bFpxbVZGNk4wOFJwOHlrNTlOQ002akViRWVPTXA2d0xHM29TMFQxSmtoblQw?=
 =?utf-8?Q?ye7tlrfne+I2WTx/IIdh7E34/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xK0twcfDPOCBNlIgkjaqb1vLIWDKB4zUFia9WDzC3zMPT/1ku4gidofOOiAeU6hoQPuT0UVWjCM3/6WNyRUESgFbVPfxkyA9l+wNfmvnTOlpOuGHthpeG57tJxifNsElV6fo7lm5LQnSY5dMucdyfYzG7GAT4JnBkXPiAa4idRkubsNKt2r7kF+oI5MChwGTXepVa6NS/gNezGcG83j+IXnu+lqBphezSDSs/Az9VkB2UhCN7FOr/URiiKpRr2kP+gCaz+YY3lewmamULETw9B9Np3j8DbKWgGUoyAXN3pdA4nudVMJp4D2KaRL3LDszStESaXdnXVwif/if9nChE/xw/1P8NclK/S3sWYURzHWaD1JjltTeXLvqX7gfGzoR3u4RPvD/dr2DkUMOEUSq8/NNG97kIb0glJ36Kx3xHFBZn0yg0LxQT70gnwU8gRz0DuVNSwkA0urWdjWj20cSsGmz/HXRWJ98FmTCU1LgMUsRH3+cNKNCKgWbvoQzES7H4qmmWvXjeziuqJGt+s3+1tEjoFF1a2phqh6Wg5e5zXohDVDKdOHJsBVe5cCRJeWqiRfmNwbO3Grc7xoi7T1z27MsuRv4rjlvtRst2lVNC9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3238717-5785-42c7-6c79-08dd1e2a9adf
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 23:37:29.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aul0IPFigoZhjC7ds+18Js5wbpbJd2fGyiF30PTn6+1bVjRd1HuexUNX0GfvOGi+es4XaMDHjU1KXo2iaVJ8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_09,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160193
X-Proofpoint-GUID: TcSwBqqXnt3vweaKPhonjOVWNb93x7g7
X-Proofpoint-ORIG-GUID: TcSwBqqXnt3vweaKPhonjOVWNb93x7g7


On 12/1/2024 7:05 PM, Shuai Xue wrote:
> Synchronous error was detected as a result of user-space process accessing
> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> memory_failure() work which poisons the related page, unmaps the page, and
> then sends a SIGBUS to the process, so that a system wide panic can be
> avoided.
>
> However, no memory_failure() work will be queued when abnormal synchronous
> errors occur. These errors can include situations such as invalid PA,
> unexpected severity, no memory failure config support, invalid GUID
> section, etc. In such case, the user-space process will trigger SEA again.
> This loop can potentially exceed the platform firmware threshold or even
> trigger a kernel hard lockup, leading to a system reboot.
>
> Fix it by performing a force kill if no memory_failure() work is queued
> for synchronous errors.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>   drivers/acpi/apei/ghes.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a2491905f165..106486bdfefc 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -801,6 +801,17 @@ static bool ghes_do_proc(struct ghes *ghes,
>   		}
>   	}
>   
> +	/*
> +	 * If no memory failure work is queued for abnormal synchronous
> +	 * errors, do a force kill.
> +	 */
> +	if (sync && !queued) {
> +		dev_err(ghes->dev,
> +			HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
> +			current->comm, task_pid_nr(current));
> +		force_sig(SIGBUS);
> +	}
> +
>   	return queued;
>   }
>   

Looks good.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane


