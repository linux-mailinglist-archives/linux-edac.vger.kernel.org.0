Return-Path: <linux-edac+bounces-2727-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7599F3E7A
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 00:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752DB1885901
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 23:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAFA1D9663;
	Mon, 16 Dec 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gmARZ2RQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T+usSctT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28842A9B;
	Mon, 16 Dec 2024 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734393293; cv=fail; b=AWScl1r7I2rsKlbgJyWhb6cogyX/byb+RPuwlDG1Lw9XRaY8Ne0aYBCkHnYuhgPcQiXLqDda/PvdRViPgU3zpD4w+01K+nXtZDEDkwvAyLDUV/M8tv5c2OST/V0S5RstovHiZK2qYLW11r7nEZd1n67+3iVlfteVwfjsbVa61X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734393293; c=relaxed/simple;
	bh=zCGAXX8cDso4MkKj9uLpp+j3WqVenMtOhT3D11HTHvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dLvhRR9va19PgL45n17crEXJQ6VF6alE2k+lkMGwMwL4D/il/jQ9wPh8KaVklhqP3px1o3U5YD6W7v+KzzRn2l4krnX9xlP3ICG1mExSQzW3MdzHoGZP2vcTAqgGKpaE2zNRJgcu4CRXAlQ8VjVxFeat0ot9oWS8zWjJ5IBUZKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gmARZ2RQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T+usSctT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMjXLl009805;
	Mon, 16 Dec 2024 23:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=D7N4M6CrPFGokKGjnQ19g6ibmw1wFPVbvf1uyud1J+c=; b=
	gmARZ2RQe6kHxQ6kNVth/WVPoXNlZ6c5GzF4qKybHj5sNLekcTY6Ly9UYj6VrHI6
	wNSq3FYN+5+OXBfiXpcWfb6g/AbB0SPiPdRD1f9hhR7EQJCudBsN5/ek/aJs4riI
	efWl99y/F/O9ZDp9UXeInIfD2Aa9/RhDwTO4LDoTK5UDGKBwKIpOs8pmXRSYS8pX
	wioW+yapJaeE6NG3uATdZleFG1txVzZO6T47p18yGRSFAX3uFasQgCwvq/QWOq0i
	L3JQ3dGykwT8OCTZMnCSReahJYLMiLqAgBeIpzup3eLWRSGitXWiQLbsunARaE5I
	h30pB6Exb4ZW6bUOPItx6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cmp2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 23:54:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGLotUl019023;
	Mon, 16 Dec 2024 23:54:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7yv6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 23:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF3+WZ17RaLMf1Cv3B08QWauHEAqkz4G0PU5VwI9a4JC9XRpwFU/xWGNSYMsPNyrkkSSgYbV1AZ4uz1MN3xO8F0eaYpAzPLsm1D+us6C0EMjefQg6mODtYC0FY8MlVwaWOP21xZsorAN6Obghv6xcUibYzmYz/HGgxWcQ8ijZoHjfsnqNS01DSKNKa3K1o9XBtG7RePKGw5EtxTF2FMoH+MBmtAZFOq+nTZiLtSmzIlBthKrOwWTeKP9Ecm7tIKyXoItnLBmohur4Qsr1A8KtBrMRmIRaf0YSNQwdSq9z56z2HJ9KOSBtX5uhT20osBW/hqoKyZJb7ejz/LdGsrFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7N4M6CrPFGokKGjnQ19g6ibmw1wFPVbvf1uyud1J+c=;
 b=eJQWWIPBC2MCq4h73+a3rAv5YJQogMwnBEKmZopiQxpVpT8j2Jg///bkugImCX4vwQiHAH1wnnVcdJR5YrsG1WsRFSQaCGn+bTiClIOspMn6Zfpid3QeB2E75gyVLc7wXxsx77n49p893w3lV+J8KCxCLKZ9svQcn58lhhRKCW3POJ7zP2Pt/PFYbm2acqLcS6R7VwJm5VJ2vjuLeIHHCeIn83YiVT37MMwCm1Qmg2zY90hs4DjXBKONIm/qAptd8/au0BDDbzpAQ+oct/wGqbJdg/rpxgRh1TIq7nQRtWii+Q26Z/KfhxSc6F4e8NaGzvcBVNiEGK6EOXPnA9eTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7N4M6CrPFGokKGjnQ19g6ibmw1wFPVbvf1uyud1J+c=;
 b=T+usSctTdmaShCyDpAjrlf0mgo5DxiOx1jZSioTarRhAfPVbw2/wbl40VyNortLmAiguG+piXvEcjV8wJH5tTf5UQgOLXkrdy8mHjiJj/e4/I3A9UdRcwFg6Dri4inaVQVmVOUssv2WeBNJNiwaencpPDnNNdlQzise+9qDTIVA=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by DS0PR10MB7201.namprd10.prod.outlook.com (2603:10b6:8:f2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.20; Mon, 16 Dec 2024 23:53:59 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 23:53:59 +0000
Message-ID: <d7adcb58-7a1d-4f0b-a55d-40c12ca60b02@oracle.com>
Date: Mon, 16 Dec 2024 15:53:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 3/3] ACPI: APEI: handle synchronous exceptions in task
 work
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
 <20241202030527.20586-4-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20241202030527.20586-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|DS0PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7352e8-6714-4993-3558-08dd1e2ce8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXZVWitGcW5vSWpObDhnQnhDNWE3V1E3bCtqa0EvNDNuQUNUYmVJZ0hNSnRI?=
 =?utf-8?B?c0NFS1dqT2JpUWFrZlhjOG5WVVVMQk5xQkhqcVJhN1hQaHNLTTJKYURicmtU?=
 =?utf-8?B?RzF6R2U4bmxJSXdITHh0eDlXcUpLeFExT1FSRTF3dWIxT1JIZ3gzTGJVaGZP?=
 =?utf-8?B?MlRFM0VEV3gxdU5hb1VQaEtiMVFyR0xyNDJZTzYvOXJ1SDM5V3lvNVNTVVZ4?=
 =?utf-8?B?eTZsRU9mTFZ1MzVVdmlPUWpFRGRpNEI5Mm56Y2tTZW1Vdm91V1FSQTdsRFZs?=
 =?utf-8?B?V3c0V2VvZVlVNk5xWDFPdUdNNktnNE96bFRoY25UUkxlRGFJMjI1MFY1WUtj?=
 =?utf-8?B?Z2ZINlRBTkM5a0x6NnFiYVROZFRneWhuTEg4eDQxZThZZ2haQ0YwQUg5ejIw?=
 =?utf-8?B?UjNNdTEwTitSd0FFYUo5MDNqb2dQaUsxWkhTZ3U5dThaZWRXS21abnpxR0JF?=
 =?utf-8?B?M0V4TzkwenBVS1NwZGFUNUNkeEhNRlRpeDdrUys4T0E3ZGlLcnBwM24vTEpy?=
 =?utf-8?B?OEhDRFZ3aXhRUnlibFRkYlluUDhnREQ1MzA4SitwTGk4aWRWSitrRUtHSWJY?=
 =?utf-8?B?UktrTGxPYi83WS9UZkJ3K1pnMEZCb0dMczJBWUtKYTBvNUVURnoyVGQ1YnVm?=
 =?utf-8?B?OWNVeE95OExoUVVvbFNsSU9yVG1oRXQyWUR6YThBMGY0ZnBCN25GbFlta00x?=
 =?utf-8?B?S21STWJrYTgyZ09ITGF4TlhsbDQ4Sk95Z0JPK2JSaU9uZGJzbnJybC9nbkVr?=
 =?utf-8?B?Z0JxSVBET0UvcUJuTWNrR2s2WG5hc2NENVVNOFE2RHF2eklTaU1Va2h0N1RS?=
 =?utf-8?B?VWFENnZ4VHE1OTZKZ2phZHM5dTFlUFNzMHpNUFFOOGVKYU9oNnk3M3pFRXFm?=
 =?utf-8?B?cEFZQ1V2V3dCZEJyTDA1NU1Sd254eXpyZmU1TnZ0Q0xEN3Y5OHJJK29OakVC?=
 =?utf-8?B?YUNia3FRSWl5ZUFQSUVmM0xpbm1vUzIwdGhwamlJMXlNeXJTeUEyV0F4WDkv?=
 =?utf-8?B?Mmt2a2RSd1FWUGJ3UU56a2VKVUpmWitQVm9Tc0taNTVpYjV0WHpQMXpBSS9G?=
 =?utf-8?B?QzU1dkRwRlpQOFlEU0l1RjUxYWxOclVRUjBvRWhVcVRBb0plY3A1aWFUeDQy?=
 =?utf-8?B?dFZ2RTQzV0NiNGMxTlpMcWFPeEhFQW9STmpFL2w3T2RIdk9Oa3pqaUJtQVpn?=
 =?utf-8?B?cGE2bTJsRnlzSTFjVTdlWTJMUmtQREQya0YxT2RVY3V6dlk4RzVNVDNTWW5F?=
 =?utf-8?B?UlVJbHdDeis1N1RDNjhuNjV3eDZIVlVZU3lkQXNhWmJ3dVZoakVyQW9EcUJa?=
 =?utf-8?B?aDczb2FHT3dlSUtOME1IMkhPYWt6VEFwRGY1bXV6cUoxc1Nudm8rdytzaDdT?=
 =?utf-8?B?V3hhRjY4K0t6ZU91WlptbmJFdnVKSUNlNWY0N2t0Yi9TbkN3eGVOS3pPc2VX?=
 =?utf-8?B?SXV2WGxSbDRMdktGTWpadU9MUEJLQXpEUEpRbHJyelE1Z1JEZlZ0QnJGYUZV?=
 =?utf-8?B?RnFJWFg2TDNWSDVoZUJ1S2g2QU12dEpLRTk3U2p3cEVaeU03U0p3S2lkQzFJ?=
 =?utf-8?B?cWhrdVFVb1M1YkhNM0I5Z01XclNsQXpQZWJHZ2JyWTFaUE00OFUvYm1aK2pm?=
 =?utf-8?B?dGl5WU1tZGZZd1NhaE9MemdVVlBnV044V1VyVUU0elVtUURqMGp5YXhiRmQr?=
 =?utf-8?B?a1BrU1hYdUExNGFCcTlneFpCSVNPUkFHS2Y4R2wwOHBycy8xNWora1pMK3hM?=
 =?utf-8?B?OEdvd0dTU0F5NEJtMWM0dDBocVFaS3RBMVRva25ucXNZcjUvb2E5MitOL1c5?=
 =?utf-8?B?elkrM0ZuYTNvWGc5cTM1RXZnblEvMEVvTStwMkp1MXZ1ZTNSYnA3aEtlbXVE?=
 =?utf-8?B?QXlSM0dGQjFwQkxkMG91dmczUEtGcWxmT284Qm03VjZqVGgvc291SUNtRG9x?=
 =?utf-8?Q?HV0DXSbe0xg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2RkZFV2S0wySzBYWU41enFCT3JNOEI2aWdTQWJZbUp6YnUzaEQ5Ly9Ia3Qv?=
 =?utf-8?B?eXVQQ1l4eXE0RG1XVVJmcEpFSTJLL2xNSmtyMXdhZzJmWnlKU1ZqcGZHQ01t?=
 =?utf-8?B?KzdzQmFMaHZmMWtiTjhJSTVVbk5sOHNZemRPTFNTL2FubUMzSUlzcGhXSXRR?=
 =?utf-8?B?aVMrdkdPVjR5Rm9BNmFWV1JYeVZXaU02NGhXS3lXK2FBbTY4cVZuYWFmZEQ1?=
 =?utf-8?B?d2NNOWtGdnRGRGd3VU1PWERiTUE5ckZhQWhJV1NWNUxlVTk1T25xNjVNRUVj?=
 =?utf-8?B?ZzhLbGtJZHRpVUZOaFJyeEtuNld3a3JLbUE4UDlBLzdnRWdodTh5QTFheU9I?=
 =?utf-8?B?RDMwbjRHdkpOanlJOFU1bzBNTzlzcDlzbVVmTWthV1I1NDZSelZPYXN2bUFw?=
 =?utf-8?B?Y3lOekFyZDVRQWttUmcxbStSMFA1cmt4VDAvMEc5cGl5REs3cDlmT3Vnd1Vn?=
 =?utf-8?B?SUNvMEFwVm0ydHUrdnREUjhoSzFLSEcvWDNtSjdZTWUzZkFWMDY2ZnhPOHFk?=
 =?utf-8?B?S1hsNWxlS2FaYkNIMCtHL29XSlNKU1gzUzk2L2hrSGpOR2kyOXBGYmNZRmY1?=
 =?utf-8?B?K2RyUWI5OXByUEx4UUhMUHRQbFRzeFk4eGpDVWF2aHAzMEFJRTdzandlckFP?=
 =?utf-8?B?VGtTTWVFakM0dUNPMDMwQVZMU3ExQmNIL0Izb2MxY0xndlN6MWZaYzJ1YVJm?=
 =?utf-8?B?ZnVOSWdmcVNCZ1ZwVU5tVDFCbUFOQ3l6M1dvb25PSkpVc0V5cEZ5RitRakZS?=
 =?utf-8?B?aHZPellRcWQ0OENWVXhMSlB1TGQ1VVRLTmJiMjRuUVpzWEZWV01kTWNqQmZS?=
 =?utf-8?B?dlFic0xlRDVOeG9qa2hSSzJrNDhjc29zK1BvUk1PMUlwWlFVcUdGdTF1VFZj?=
 =?utf-8?B?WTU5TG1ydFBOczBibVNPazJUaTFTZGswYm9qN3Z0NmF4ZzRPS0lJSVNiSEJI?=
 =?utf-8?B?N2pNS3NxRXEwRXJnaGpKUkx1WDU0RkZwSHcxbzEvNUR6RC9qemZKTGJma2dB?=
 =?utf-8?B?UXFHWllia2V0YTUyOVBlVmo2dWJjZk44SFdNOVpzeS9yY0dXb21tNjhVU2pr?=
 =?utf-8?B?WDNLK3Z2ODd5MEhKbWROSFV3Q0ZwUzZMMHhTTmlCN0pXd3hqWmw1amwzSjA1?=
 =?utf-8?B?OUVNb25NbXZyRVdRbVRSZlpEcUdQL1dyOVdCWCtjdG9DRlhjNDE5cEpKMjh3?=
 =?utf-8?B?YnIvcVlZQytFbW9nTDR1WDFDY1FGY2Vid3NHR256cTV5cW5yeERMMEF5YTlY?=
 =?utf-8?B?d09BdUNqODZObzF3SHNKbVJ4VXA3alR3b2RkN2pQNVg1b0xaeVJWclVQMzNr?=
 =?utf-8?B?eC9nVHVtZzBnZ0JJeGNSVjBVL3hWbzdHRm1qZjB1YnFvbkJFK2NIOFZBVHdI?=
 =?utf-8?B?VG1OY2R4TnBGQVcrODB5QWdKaFF1Y0x0emhxUEhpYmZ6ZjdzK3ZEREQrSmpF?=
 =?utf-8?B?Q1dGMFZSNW1RM3pFclVWZ2FycGNadndOSzhOc3Y2Vk0rMmw0R253Wk43MEZu?=
 =?utf-8?B?eDFsNHRhZWZnczc3ejJlY3BxYnNJNFJkY085cVlhTWdnREl1WjJ0NGRuNk1P?=
 =?utf-8?B?em5ESTNtTGNTS0p3Z1FxRDhKSEZFZTF0K2ZpeTlZdHNmZG1VWW4vcmpjT3p1?=
 =?utf-8?B?d1dOS1IzTmE1cjJuS2tsRlR3ZU5MSU9YZUVZblVxRmNjYWZwTWtRclJXRTNm?=
 =?utf-8?B?cFBTYnhPckVLRDFYdmpLTHNab3RzMFo4Y09QWTU2WjMyblVZK09ENkNwcmw2?=
 =?utf-8?B?T2NFSVU1M2VSaDBCWURiL2dhQ01RUnRNUUwrb1hMZGVkVFdJOVNPRlFOMkU0?=
 =?utf-8?B?dk5jd2RsZHI2Zmh3WXNVa2tSRFJTMTk2UnlSR2FhVUYxc0dXdXlrZUxiSkR5?=
 =?utf-8?B?cFByY0dyTnZtOWd2OUE1QXRMY0J6U0Zib21iYVRaNS9mTmpnbVppdDNwVkVT?=
 =?utf-8?B?d1F4QUR1SmdIYjB1aXBzWmh4cGh4cmZMUmplVXJjTnh3dldCZGZaY21sWTNY?=
 =?utf-8?B?WC9DcFBSUVRxY0tTRUErTWNiTzM0NzdGcHhLTGZ0SnFldXhEZFFVK3VpMjhX?=
 =?utf-8?B?ZmlVMTkvbFNLdmlUb3hJQU9McHBJNC9Xb0VTdGdkMXkrdjlTSExMQmpmdG91?=
 =?utf-8?Q?hkRb5XRQrLvryKEgZ+G5A7yoc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7ktF/ssZ8wfPSlse0MGmNT1o0cqgrEIrWdyo3W+BVUT624S0Hgd1StCA+wtJbVziyrxYqGoJ6cE7ZlhlV2TA/rjlpoJsTTF7Rg+pwAaUGqFHPPW4Hn2x7lwQMufLSgEEoJFUC9kKAXUZ92A7tjlheDlyLvYJ+KY7OdDM+EEfZcTG8qWAmseenuZhz/8sBjym4lxCsvWXRgkXpe8xiIZ+HV2yOBRV6j9vw9LWDg0AxyW0z6E8jgU9fl/JhL5+BUF7JN0AGF1u+z54JYXIkUWOyjxpur71hJ06BUgRxD+T2YVvHzb/eTEJ/vzGLdYaiTBgjO19wD38d9fOI4S9qRve/+VPS2fT1bbeSptftkLuQb8YveSwXD5cIKKyABZV5vmDn6kPOhpdFOjD9fRoGYg24n8UqWgfjUAu5GWBzd94crQcsflyh1bAm8T9Lp+mydEjtHL3j36h6c0oPa/U2rRI5DDsXD88IhfiV9dicPDmQfRkSwMB4jBcPFsDBRtdIIc3HW2+TNIetznw13Y8BayoefRBkw3BDYNc0B/AlQyXpphICMyFItGIFef4dT4RJfeMP6kvQCz4jl6zibFHiRRSuZT/KVZX+BbsWMHa5s238K0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7352e8-6714-4993-3558-08dd1e2ce8f5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 23:53:59.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnSTkkU8MQ4AMfvmP0zxwJTybNzXqn7cLyo2xHCexiOyJsLw1bcz1QRnmUMOyBExaL7DnPhYkyVljXSiHLUsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_10,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160195
X-Proofpoint-GUID: OTKANeTCc_Nm3cMWGzq1qfnw3oZIoBUq
X-Proofpoint-ORIG-GUID: OTKANeTCc_Nm3cMWGzq1qfnw3oZIoBUq


On 12/1/2024 7:05 PM, Shuai Xue wrote:
> The memory uncorrected error could be signaled by asynchronous interrupt
> (specifically, SPI in arm64 platform), e.g. when an error is detected by
> a background scrubber, or signaled by synchronous exception
> (specifically, data abort exception in arm64 platform), e.g. when a CPU
> tries to access a poisoned cache line. Currently, both synchronous and
> asynchronous error use memory_failure_queue() to schedule
> memory_failure() to exectute in a kworker context.
>
> As a result, when a user-space process is accessing a poisoned data, a
> data abort is taken and the memory_failure() is executed in the kworker
> context, memory_failure():
>
>    - will send wrong si_code by SIGBUS signal in early_kill mode, and
>    - can not kill the user-space in some cases resulting a synchronous
>      error infinite loop
>
> Issue 1: send wrong si_code in early_kill mode
>
> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
> could be used to determine whether a synchronous exception occurs on
> ARM64 platform.  When a synchronous exception is detected, the kernel is
> expected to terminate the current process which has accessed poisoned
> page. This is done by sending a SIGBUS signal with an error code
> BUS_MCEERR_AR, indicating an action-required machine check error on
> read.
>
> However, when kill_proc() is called to terminate the processes who have
> the poisoned page mapped, it sends the incorrect SIGBUS error code
> BUS_MCEERR_AO because the context in which it operates is not the one
> where the error was triggered.
>
> To reproduce this problem:
>
>    #sysctl -w vm.memory_failure_early_kill=1
>    vm.memory_failure_early_kill = 1
>
>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>    #einj_mem_uc single
>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>    injecting ...
>    triggering ...
>    signal 7 code 5 addr 0xffffb0d75000
>    page not present
>    Test passed
>
> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
> error and it is not the fact.
>
> After this patch:
>
>    # STEP1: enable early kill mode
>    #sysctl -w vm.memory_failure_early_kill=1
>    vm.memory_failure_early_kill = 1
>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>    #einj_mem_uc single
>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>    injecting ...
>    triggering ...
>    signal 7 code 4 addr 0xffffb0d75000
>    page not present
>    Test passed
>
> The si_code (code 4) from einj_mem_uc indicates that it is a BUS_MCEERR_AR
> error as we expected.
>
> Issue 2: a synchronous error infinite loop
>
> If a user-space process, e.g. devmem, accesses a poisoned page for which
> the HWPoison flag is set, kill_accessing_process() is called to send
> SIGBUS to current processs with error info. Because the memory_failure()
> is executed in the kworker context, it will just do nothing but return
> EFAULT. So, devmem will access the posioned page and trigger an
> exception again, resulting in a synchronous error infinite loop. Such
> exception loop may cause platform firmware to exceed some threshold and
> reboot when Linux could have recovered from this error.
>
> To reproduce this problem:
>
>    # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
>    #einj_mem_uc single
>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>    injecting ...
>    triggering ...
>    signal 7 code 4 addr 0xffffb0d75000
>    page not present
>    Test passed
>
>    # STEP 2: access the same page and it will trigger a synchronous error infinite loop
>    devmem 0x4092d55b400
>
> To fix above two issues, queue memory_failure() as a task_work so that
> it runs in the context of the process that is actually consuming the
> poisoned data.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
>   include/acpi/ghes.h      |  3 --
>   include/linux/mm.h       |  1 -
>   mm/memory-failure.c      | 13 -------
>   4 files changed, 44 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 106486bdfefc..70f2ee3ad1a8 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -467,28 +467,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
>   }
>   
>   /*
> - * Called as task_work before returning to user-space.
> - * Ensure any queued work has been done before we return to the context that
> - * triggered the notification.
> + * struct ghes_task_work - for synchronous RAS event
> + *
> + * @twork:                callback_head for task work
> + * @pfn:                  page frame number of corrupted page
> + * @flags:                work control flags
> + *
> + * Structure to pass task work to be handled before
> + * returning to user-space via task_work_add().
>    */
> -static void ghes_kick_task_work(struct callback_head *head)
> +struct ghes_task_work {
> +	struct callback_head twork;
> +	u64 pfn;
> +	int flags;
> +};
> +
> +static void memory_failure_cb(struct callback_head *twork)
>   {
> -	struct acpi_hest_generic_status *estatus;
> -	struct ghes_estatus_node *estatus_node;
> -	u32 node_len;
> +	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
> +	int ret;
>   
> -	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
> +	ret = memory_failure(twcb->pfn, twcb->flags);
> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>   
> -	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
> -	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
> +	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
> +		return;
> +
> +	pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> +			twcb->pfn, current->comm, task_pid_nr(current));
> +	force_sig(SIGBUS);
>   }
>   
>   static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>   {
>   	unsigned long pfn;
> +	struct ghes_task_work *twcb;
>   
>   	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>   		return false;
> @@ -501,6 +514,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>   		return false;
>   	}
>   
> +	if (flags == MF_ACTION_REQUIRED && current->mm) {
> +		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
> +		if (!twcb)
> +			return false;
> +
> +		twcb->pfn = pfn;
> +		twcb->flags = flags;
> +		init_task_work(&twcb->twork, memory_failure_cb);
> +		task_work_add(current, &twcb->twork, TWA_RESUME);
> +		return true;
> +	}
> +
>   	memory_failure_queue(pfn, flags);
>   	return true;
>   }
> @@ -745,7 +770,7 @@ int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, CXL);
>   
> -static bool ghes_do_proc(struct ghes *ghes,
> +static void ghes_do_proc(struct ghes *ghes,
>   			 const struct acpi_hest_generic_status *estatus)
>   {
>   	int sev, sec_sev;
> @@ -811,8 +836,6 @@ static bool ghes_do_proc(struct ghes *ghes,
>   			current->comm, task_pid_nr(current));
>   		force_sig(SIGBUS);
>   	}
> -
> -	return queued;
>   }
>   
>   static void __ghes_print_estatus(const char *pfx,
> @@ -1114,9 +1137,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>   	struct ghes_estatus_node *estatus_node;
>   	struct acpi_hest_generic *generic;
>   	struct acpi_hest_generic_status *estatus;
> -	bool task_work_pending;
>   	u32 len, node_len;
> -	int ret;
>   
>   	llnode = llist_del_all(&ghes_estatus_llist);
>   	/*
> @@ -1131,25 +1152,16 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>   		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>   		len = cper_estatus_len(estatus);
>   		node_len = GHES_ESTATUS_NODE_LEN(len);
> -		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
> +
> +		ghes_do_proc(estatus_node->ghes, estatus);
> +
>   		if (!ghes_estatus_cached(estatus)) {
>   			generic = estatus_node->generic;
>   			if (ghes_print_estatus(NULL, generic, estatus))
>   				ghes_estatus_cache_add(generic, estatus);
>   		}
> -
> -		if (task_work_pending && current->mm) {
> -			estatus_node->task_work.func = ghes_kick_task_work;
> -			estatus_node->task_work_cpu = smp_processor_id();
> -			ret = task_work_add(current, &estatus_node->task_work,
> -					    TWA_RESUME);
> -			if (ret)
> -				estatus_node->task_work.func = NULL;
> -		}
> -
> -		if (!estatus_node->task_work.func)
> -			gen_pool_free(ghes_estatus_pool,
> -				      (unsigned long)estatus_node, node_len);
> +		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
> +			      node_len);
>   
>   		llnode = next;
>   	}
> @@ -1210,7 +1222,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>   
>   	estatus_node->ghes = ghes;
>   	estatus_node->generic = ghes->generic;
> -	estatus_node->task_work.func = NULL;
>   	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>   
>   	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index be1dd4c1a917..ebd21b05fe6e 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -35,9 +35,6 @@ struct ghes_estatus_node {
>   	struct llist_node llnode;
>   	struct acpi_hest_generic *generic;
>   	struct ghes *ghes;
> -
> -	int task_work_cpu;
> -	struct callback_head task_work;
>   };
>   
>   struct ghes_estatus_cache {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c39c4945946c..aa4246c7c23e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3936,7 +3936,6 @@ enum mf_flags {
>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>   		      unsigned long count, int mf_flags);
>   extern int memory_failure(unsigned long pfn, int flags);
> -extern void memory_failure_queue_kick(int cpu);
>   extern int unpoison_memory(unsigned long pfn);
>   extern atomic_long_t num_poisoned_pages __read_mostly;
>   extern int soft_offline_page(unsigned long pfn, int flags);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 14c316d7d38d..e0adb665d07b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2499,19 +2499,6 @@ static void memory_failure_work_func(struct work_struct *work)
>   	}
>   }
>   
> -/*
> - * Process memory_failure work queued on the specified CPU.
> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
> - */
> -void memory_failure_queue_kick(int cpu)
> -{
> -	struct memory_failure_cpu *mf_cpu;
> -
> -	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
> -	cancel_work_sync(&mf_cpu->work);
> -	memory_failure_work_func(&mf_cpu->work);
> -}
> -
>   static int __init memory_failure_init(void)
>   {
>   	struct memory_failure_cpu *mf_cpu;

Looks good.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane



