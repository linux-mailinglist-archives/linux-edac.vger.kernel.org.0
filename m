Return-Path: <linux-edac+bounces-5706-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AE/CNLei2nKcQAAu9opvQ
	(envelope-from <linux-edac+bounces-5706-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 02:43:46 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521E1207F5
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 02:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104973021E7D
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 01:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1429B78F;
	Wed, 11 Feb 2026 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iba52stC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kwmoc2jB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F58299929;
	Wed, 11 Feb 2026 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774172; cv=fail; b=QUz8CWiUflaeGLtU3kBl1BJi6obWjRX9UR+MAk1ZCjrlXFCevRmZPE28qD+ucdIduiRWySHB22FlFq6T+5YAoYP/Sw80ovkZo0AQnLIE0deXNuwv8Hy4/MYMb2HlP71yoe6fsvUO8WH4iXFv+E4eD/lx5Gp+eG1adYTuF+Qp2Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774172; c=relaxed/simple;
	bh=GEYlurx4nrzd/3/rv0GEul7DpNslr1LEGDaYb+PITa0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+xn4l5sYcUsDdd/kGawal4hq3lSmHj8AFHRRYI4B8rxLhOM56juXtXYQCUyEO8CK58CSQidFEUjtPnxJ9cPs1wWAVvQc8zwsI1DOkEXKb5aB+cjnsxOuhtr56lFrxv3AggVd/Cv8ee9c0ZrOn6MYdk/a66NSnb3n+2/AV4+Xjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iba52stC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kwmoc2jB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B1a1gl1310351;
	Wed, 11 Feb 2026 01:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dAwZ8ze4l+hey5Nct9Ji+KipNM5jMutCyKJuv0tBiXI=; b=
	Iba52stCHv7/gdQEb3wM+pEZbmw7U8CAigzrlaDdUIZo2uRAaCEXnsgkjGgdRibO
	Yzej2GZHPz9jCUde4uPR8LdOm5OiDUP1zNmtAuCx7iCRnadYMI5Ugldawpefzna+
	Nh1x7J8nTXwMa+Al83j4rOE5YtdfJwhl9jzWfgoncCMyNR67BmyYHup3nqSv9w7K
	38VcTfShIpb0Fp+BJmo/Odmdc6u5L5P7q/A9PFAu72NtXpLAiyNQbADXuEr/fAzp
	RcBPZEhHNul43JBgiSxtB7afPudOfMkhTTOB1YNV2AAgBkhom/a4L0TC0BA3exim
	mC7DyauvQJy9nUYMgTmp8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c7rxu257n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 01:42:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61AMVrid030144;
	Wed, 11 Feb 2026 01:42:14 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c8228xby9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 01:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0GC18BLMB3PJYbvrBG5JiN5sup/fo90si5IHGopBRo6XjfEMB22+d73D5L8XyUj0U9UJQueUiAVBY7lqndhwvzQsEZWXnC+bgo0q93IHmYpfTkZ/+lxhxr9BI8jCzIFLCMZoGjrmLGQ9UnJmdlYOFaSQQva/GWVxcDxbWmFGaaJcd9+lnV4VokKqFH7N0ni/0aNyYm8r+n6bZTFM+w4uj8H9ppFQZO9ueqpF3rFtxGEmuKDkRcp3TC9+dbE81SBoxPOgAFN4LwIHh2xBw/y28aV/xdp8NjdZaLlIJgpYMPept9wWKPpivIZGA5euwA1kzHG0V8EjRcM8xFUughmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAwZ8ze4l+hey5Nct9Ji+KipNM5jMutCyKJuv0tBiXI=;
 b=Bf1+Gb40ApEE/3LyghMaeClpC/XOVTPCN5ocOMbM1v46do0IlMe8CJRWRBmMZVUxidhfA3oUqc95gZ0Y9IE6I1fhIe1/B6GR3eRvkXNlkmrtl8d3dfNHzjZZa53hHi57jki6sqAzW42nNfq2qkgIiVWQePDSOC7EL37+SbxIMSkQqU3MYJlQEkqdLIMKflK/gNclHfmLXHGyJWMWwGvZ49p7F9uAULryb4KtClMYpE44ntkNzooGwxZkbwIBIp4DmKhS1YYzoioZiWt+laebUwTkjp2WKq7ujx0lkA3+CIR5gFL3Q9AoQYHQcyyV9XswQiPAPC1rTywliKd9kOqxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAwZ8ze4l+hey5Nct9Ji+KipNM5jMutCyKJuv0tBiXI=;
 b=Kwmoc2jBIDZS349aM9XbKTCM0y1LWV3HIY+dyrCXCTzi2ssDM6byuleFglHHbTAujh/UzgV0OcoXd9NiXG08/qNgyRhIcbk/wicmwoHBSUXAZml3uUv/3Nbu23X/G/aD2aKh5r2+tbrA3h7KMTlqeKgG/TqG/DX2LCzRFpm29zA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH2PR10MB4135.namprd10.prod.outlook.com (2603:10b6:610:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 01:42:10 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 01:42:10 +0000
Message-ID: <6f87d29b-c30a-47f8-a519-0e1fba36f1a7@oracle.com>
Date: Wed, 11 Feb 2026 02:42:07 +0100
User-Agent: Mozilla Thunderbird
From: William Roche <william.roche@oracle.com>
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
To: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
        bp@alien8.de
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        "Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
 <20260209210819.GA445331@yaz-khff2.amd.com>
 <20260209211843.GA459737@yaz-khff2.amd.com>
Content-Language: en-US, fr
In-Reply-To: <20260209211843.GA459737@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0336.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH2PR10MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4f0ec5-6249-44ca-3144-08de690ec5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlRJWHRwYi9sSmYzN3duNk9GK0R3aDhUTkFySWlaY2tsNExWKytUMmhNR3R1?=
 =?utf-8?B?RGVSQWNYck5aYm4vNGlHQ1ZldlZJcm1lSUx5c0V4QWpRM0taVzArazZISkVV?=
 =?utf-8?B?emtUcXAyQUhZN1loL3hRTkkxUlNndmZLcG8xUzhSejlkV1pNNUw1SDhBenpw?=
 =?utf-8?B?bDhWdEZNMVlNT04vN2RkUDQ0dG5kVVpNUHBIQXByS241dEZiOEdzTHBLT1Ry?=
 =?utf-8?B?ZTV6clhBdWZ6elRudmtPZ3Z4eDR2c0I1aHRDZStLOWRTM1hGVG1DK3BsSys2?=
 =?utf-8?B?dWdscHRDcE5QYUxScDMvZDFHNzh0dEtKc3BHNkx5eUo5Tzg2UEt0cWVpdG9C?=
 =?utf-8?B?ekdKVzUzK2ZEWjRGSDhwVE9BUnRNUG53bCtuZ3VXMURnOWdyR1EyOWdzQUtP?=
 =?utf-8?B?V2h0RE82YlZLVDFNK3VvN1ROQnFIMDZTY0ZQWFBXYlh1MVF2QUtSNGxMWGww?=
 =?utf-8?B?RzBBbFlNTkpyRTBYVUhwYkNyZmVScnhEMTdQOGpjK2tKUEhJN0FtQW1Fb1oz?=
 =?utf-8?B?dVR0ZjF4R2luWkhMN3NLTUZWTzdIckFMa1VLZ1BmbXg1MWtadUp1eUFWS3Jo?=
 =?utf-8?B?UlBZSkpTOFV0bmVXc0RFSFFveGw0a3ZhVGJBcUdqdWFiUGZoWG5BT2taaGxm?=
 =?utf-8?B?WnlnTDhyNktvUnFRS25WZ2JPME1XSGtnZ3IraldrZHltZmhpQTR2NXorTGJz?=
 =?utf-8?B?WncyQ3BXcDhNL05TQ0FnRFhZcXplbEJCN3huUlJiQnBySHVmNjJqMXZtRDlU?=
 =?utf-8?B?Z0k3MWtyUk1UWDNaL2t3WG91UDlVY0V5WWZRU2tDWHZTdzdMZW9kdWkySjJk?=
 =?utf-8?B?ZE1uMlJRUm1RSy9SOGJSV1hIK0M0dlpzOVIrM2xkMlBlT2swS3F4cWxTS25i?=
 =?utf-8?B?c2RTSllNTkh4cVo3dXdYNFpBTXFudFREdE9rTjZHeHpKUGRKR09wU0dMTldz?=
 =?utf-8?B?Y0ZxN3ozNXpUUTFVaFFjWjMwRFpyTHVCUFArMUJjbHgyNGVoV0d0cFVYRmhB?=
 =?utf-8?B?OTAwV1VGTUwzbXdYQXkyRVRtMmVHUVJJV1FVK1dPYi9sTVJSelpQblVIUDBL?=
 =?utf-8?B?VFRaejJ1cVlhU1RselBXYm41NURWZjlBeFdnYndaLzY4WmU1Ym56M2lTdGVG?=
 =?utf-8?B?MnlObEt0L2RkOEY0dk9rRnBTbGg4SnY1ck9xM0M3c3RkOFIwblEycXBYTEZJ?=
 =?utf-8?B?SWorOUdRZkNFYy9na3hPOFNsK3ppczZhZGdhT2kzenpZM3hIOHFlbU5JM05i?=
 =?utf-8?B?dHZWeG5hWkhZamFFVVdNT0RFSHNkRS8zY1ZkVGI1a3ZwSTNObm9pb0lkMEEv?=
 =?utf-8?B?a21hTlBCNU54cGxwL1VERlI4azFodm5vL3NobEJPa29CRUpGdVQwQSt3MFEy?=
 =?utf-8?B?UnJBMDQyUVNmc3llVjBDTGdzRTRocytTaE91R2RUNGJ4Ulp2T3VYbXQybWdQ?=
 =?utf-8?B?YXk0Zzl5MjVXOFNHNDJTZkw1dkVzbmYwWXE3Q0RPRDlock5xU0c3M1ROUkNB?=
 =?utf-8?B?azczdjdGbWJ5RlVPc0J1SEs3QVVOME5ncGxnVk1USDFCME1HclVLby9DUDRX?=
 =?utf-8?B?RTRBMDBPMENRNll2ZGNnVmVQdlhwaEdxQ2kwQkJJR3Mxak5hYkRIR1ZZZy8y?=
 =?utf-8?B?aURLWWRtc294ODVmQmYxcFJmU2h6UTlPRzh2RnpteWozRUE3aTB0dU9MeFZp?=
 =?utf-8?B?cXBUM3p6Q2lnNnkzL0ZucjNLR1MweFMxNmdJVHFRNGkxTXZwTE5YMU92OXgy?=
 =?utf-8?B?RzZlUHJkVWxnYVMxeGdEQ0JldDh3aGw1L1FQY09iTURZaDUzbm1aNkwzUklt?=
 =?utf-8?B?KzdJa1V4bm1aa0hTd3NXd0VXQmpaV1EvbUQvc3J3aEhjMTA0Sm1DQ2JSNnBp?=
 =?utf-8?B?bjlKMTZaTDRXR0NZODRUNllleTYwUFprNnF4My9mcUNaUGJxMXZoUElKNm5F?=
 =?utf-8?B?S21JZS9NbjNkU1gxNUhGcU9OeHVEbGZoVEdXeG1ZMy9DaUowbGlCSnlLRTFO?=
 =?utf-8?B?M2ZJUWFPZVk1cE55aEpjNzE2dHB2aEUxUWdOMHNhcm1lLzVEU3Q5aXBMMmdD?=
 =?utf-8?B?bHcxWmlTMlU0WnAyVDhsOWUxenRILzNZcVorR0M2eWVrb3ZGVzdOVlhQbTZF?=
 =?utf-8?Q?TPVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enlQeEJzTU81SUJGem1oTEZHOWcvdzMvazhTcndNcm03dU1VYndlaXArQ2lH?=
 =?utf-8?B?WUtvNEhPRnNmQWZIOWJJUXlGU3FFczNvTDl0dDhCdW1kdXRhcEdwY0tNNkxZ?=
 =?utf-8?B?SjFSRXJhUlY0SHl0bTBNSVVLL0N5eTgxd1duU2M1TVdha3U5cjhOZ1QyeHJR?=
 =?utf-8?B?Q3AxYVJkTFAvVXBKYTZiSEI5NFh0Q0g4Y1IxSEdqNURjUllmczVZdm9ob0hj?=
 =?utf-8?B?UHA3TW15UUN0dGFMWEh2SUxzeDBJWjBMNUd1cCtvUk0wazJNdks4QXJWeFly?=
 =?utf-8?B?TlQ4MDMyUUNUUWpEL0ViUzMwWlJVa1NXYWUwWmJ1STZQaEZNRmMxdjNCekp2?=
 =?utf-8?B?SElDU1hqYlA3MkEvZUZ2cFBSdVRaa2ZocWVQclpLOXRyaXVhTzZYanIxV0ta?=
 =?utf-8?B?SFp5VUlWUkJSRmRiNUtld2ZQMi9td05vellmaTcvSWhCeEtIT2pzSlIwMDkw?=
 =?utf-8?B?dWRJakYvUHE1emt1MFJ1dlFYaHBDMllhOHVYTEcyc2QxVEMzektQQTVtdHJJ?=
 =?utf-8?B?WFh3eDZhMFlKalNMNXFiQzEydmY1OXgwTEd4MTU5Z08yb0hlNW1reEFvQUpj?=
 =?utf-8?B?U1pSMU9rbDN2TU9XOFk2MVpLYlEvdmoxYTNhNVZHdTNhdllBOHNLdzdrRjMr?=
 =?utf-8?B?UmN0dXdBaXg4Z3lmWWVoZEpuZnJNQXY5QjVCYXJueldVUDFkRHpqTnhNQUs5?=
 =?utf-8?B?b3BuMFVpRkQ4aGV5dFUwSUhEemZnZXg1T013YTduR0JobVI5SXlrSEhMRXQ2?=
 =?utf-8?B?VTV1YXJST1h6ak9vN2srbjZHZnF2cThPRit0NWZMdGNpUEdKckIyeCs1K3F4?=
 =?utf-8?B?TzEwekRudkhQNzVscnYvRkwxcDQ4YUpYZ2ZybXVZajlydVFrRmhDUGlabkhz?=
 =?utf-8?B?V211NTNVNnpqTzdBbmdvK2puL1UwWVFEejBtUVBjM2RtblpEdGsxOTdpdms4?=
 =?utf-8?B?MnBGSEVFZU04Y0xCZDlsc09FY0dNZzVJalVOTFNJRW9yQXBUaHQrUEcwbTBM?=
 =?utf-8?B?NFFxTnlSelpjekpESEgyNDJ3MVM2K3lJbVR1NUp3YVh3aXRPSmNZdWNMZC9H?=
 =?utf-8?B?Z2xVUkxjbFJjZ2xya3cwZHI4MHJpdlA0cloxaXlVT1NEY202UHg4bTJRMkw2?=
 =?utf-8?B?OXptK2JWNG40QlZVY0dDaUo2dlZFenpNUWpRd1p6Ly9zbVNvYzlYNmdMQTlq?=
 =?utf-8?B?WGhLSEhjNk9TdWEzUXlrVHVJSmYzMDd3a1A2QjhzTDM1RHhFU05JaXVKaG5L?=
 =?utf-8?B?RWROWWJJYklnYks0eGViYVJHcnRVRUFOMHR6bStub3RNbTJoNWlQYVZKd0cw?=
 =?utf-8?B?bldvODAyVDRpTWlvU0M0ZklVVmtnamxSSmlpdFZIUWJDWFpIMkZCR0U5Q1pa?=
 =?utf-8?B?RkN2bHFIZUFPM0lNYnMvNWl4UVNLeUs2cE1yLzQzTjU4cHMwd3hwTlJ2b3Bq?=
 =?utf-8?B?TG5yU2NMbXRHVHJJNjhBQmhCN3E4U3VSZGhFR0FNdGoxU2JaM0x2M1VSUTdu?=
 =?utf-8?B?cHZyYUEvRlo0T0lRZkFPVjlsbjExWlU4VUlEOGsrbDRLdmRvUU5CbW9XUHpB?=
 =?utf-8?B?SmlHdzNBd0p2L0R1VWhWSmJZdkpmS1ZwcWdBOHF1Q3lSRHpwbXVCWGMveVpH?=
 =?utf-8?B?cDR5Y2J6UUJ3NC9hbUZGTU1td2oxN0c4Q3JRS2REUnVxMC9NTzZJQ0tWTzIy?=
 =?utf-8?B?REhzWFpxck05VmZVMllsNWlXeFNOdFdEUExQd3ZRdWovbzdqc2FNajQ0eWZr?=
 =?utf-8?B?NWNJNENsNEN4RHpUTjJUd25xNTh2bldnNWJraHk0dkFESXVSQjFUSG5KSE8x?=
 =?utf-8?B?V2FGRXBwaVVzY21XcDcvNHNkZ0VRd1BGWFloV2tZcUExTjIwRzJFcVJqdlkz?=
 =?utf-8?B?V1Q3Tkhtemg0QXE5NmhqUlpEWDlDU09xMWdOcEV5aUZObGRrZnl1RFFuK2g4?=
 =?utf-8?B?U05iYzc2NjZEc2s1WVNKOTNEVDJUS001SGE5R0NLTzRVV21mcUJMd0YyaUxz?=
 =?utf-8?B?NkdNMHBnR0o0Q1NkOFc3dmdaVGRKV1dzL2R2VVgxelcreklnZG9mY1JCWk1n?=
 =?utf-8?B?bUoveDh3MTZGQi80SDhzR2pJQlRTelNQaEt6dDhIVW96RzJZVXRIZjgvbmJq?=
 =?utf-8?B?Q2s5aDVPNDY1TnRYdmRLYlY3eWVJZWN3dWNKQ3F1L1dpWFhDaisvOU9tT3lE?=
 =?utf-8?B?RThjdDNkQWJSdGhIL3FOV3Y0dms4S2tETzN1MXNVVVBuK0VuVmI2NDlxTUNz?=
 =?utf-8?B?Rit0UTR6bUJqNitlT3VidEVVUlN1WXJhZno0SjY4YUJjRFFtSkJEN2FNTU4z?=
 =?utf-8?B?THJIclpORys0Z29ZbTFnaHZrN3JncmRtQ0tqN3gxQnVibUU4NWRiTmVvQ2Zn?=
 =?utf-8?Q?ICr/616tnwO9p4rw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7PMpdVGKea7bgkQ3V6OkA/3lRmrvP5LcnUpdkTLtX/RI9lPu3L44yt7scUlCAGoeaUv/rwiRUvNv2ms6EqZron047BAGJUVpop8Agts8nXzwTf2OMcasrRPUiAq1zMYS1zWXvBvZEX9R6cMqJOJBG0JbbJB+iqOPiZNu6Fh6dqEFpFx8ky8dv5hVfYUgzYNuE95Amjvc2GHWNn1OgnuljuiOuZFprQfRlztFwJs1CFK2owLl0WchmLQn4272r/gZvKKPTETrcRj7wpS8EX9tGg7QYJ5UgQRSwJ0NeWLwvkZ9pbWLcguSpFKfv5JBu1mFQIgIQzLFJFgBXrP2YAFF+b3ifOFJ9I6U4UC11AziLSgeM1SDXnvbnysOow8RWQyCP7Ekmoyhr4+3ts0coxtO3ldwi+yxXW/NTAxp7/oSE55ssIt9hc6urKGlU9bS7vLhwoIfy3aYh4832gm4iqI+I14n1ZBNFrrnQiOVf5oSzk9ltcICnweO41XcAlxDq60Hoxkp87Sxe4ocxfis4pMSanHG9Cden/Fzy/UNJJx3Cjgj2veyLkOq6lLo2kLkJYIMxcgfT/aa20JNYv3B2RTQbeZIW5ieiZEWfSDBE7iAPRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4f0ec5-6249-44ca-3144-08de690ec5e5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 01:42:10.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYKE2khFQwJyEI/bLGkm7uzwkF30PFSmFnIyzHqEu8LmhVS/jnT2gSdWnns4amHq3/HIfPZYlok7MghV0um4q+Tge5deNRyDK+ex73xCcYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602110012
X-Proofpoint-GUID: fuwpJJ1ulP6DX3kScIzdHE5xySiD5WU4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDAxMiBTYWx0ZWRfX/y5I+t/RIDLC
 0+ZWJGT0aJ9Ntcs1kTkTSzF9iyaPPbKjVp/Qeq5WKzBR4TAFIRXOCEU5HOrRTSiPVu4lphapJNp
 61UmnICoTz2A9ms85mHMzsywtOvM5fUCM2lbu6ZXcXWpHZBdWkoKfnPWgWcg4rgU/5DtNLQ3fUv
 x7eKuzPvw1pbj5GVUOLKPWxoFxvJMD9HXlWWEkBACgDeNHbBYDr+QbRh4TefFMPHJAbskbVOgLx
 XQynznZwp62Yy08k3VLcwSUlxB3G1sxQLVbvU+pCeg2uFvfuKUpkjuCjnNP4t5sJAUsZWq9wMMZ
 FgBLiipXJV27Ze1cIM/whUA7W/aoA8GoqLg0pQ84zBnmT1FgZticgqTj39Dc5Nz/ddcwCOECHl/
 5l6+VjaDzfHSOHmoPr24LC8oYF10t9eZwNXjj7GUSYm3v0UnEiznNS9lVNshUapK9njr8dPsaY0
 KkiPhjfL+sMWi7Y8mUw==
X-Proofpoint-ORIG-GUID: fuwpJJ1ulP6DX3kScIzdHE5xySiD5WU4
X-Authority-Analysis: v=2.4 cv=Y6f1cxeN c=1 sm=1 tr=0 ts=698bde77 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=m5S7z3iT1-stU5rN2sMA:9
 a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-edac];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5706-lists,linux-edac=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7521E1207F5
X-Rspamd-Action: no action

On 2/9/26 22:18, Yazen Ghannam wrote:
> On Mon, Feb 09, 2026 at 04:08:19PM -0500, Yazen Ghannam wrote:
>> On Mon, Feb 09, 2026 at 05:36:32PM +0100, William Roche wrote:
> 
> [...]
> 
>>> According to me, this small kernel fix relies too much on a Qemu AMD
>>> specific implementation detail.
>>>
>>> Would you have a more appropriate fix to suggest please ?
>>>
>>> Thanks in advance for your feedback.
>>> William.
>>
>> Thanks William for the report and details.
>>
>> Clearing "STATUS" registers is a normal part of MCA handling.
>>
>> We seem to allow clearing the regular "MCi_STATUS" register. I assume
>> this gets trapped/ignored by the hypervisor.
>>
>> I expect we need to do the same behavior for the "MCA_DESTAT" register.
>>
>> I'll do some research here, but please do share any pointers you may
>> have.

Yazen, I'm simply trying to find an answer in the AMD64 Architecture 
Programmer's Manual, Volume 2: System Programming, 24593

This documents indicates (In chapter 9.3.3.4 MCA Deferred Error Status 
Register) that:
"When the deferred error has been processed by the deferred error 
handler, MCA_DESTAT should be
cleared. If MCA_STATUS also contains a deferred error, MCA_STATUS should 
be cleared."

So I would imagine that allowing the reset of MCA_DESTAT the same way as 
MCA_STATUS should be what the platform has to allow (or ignore).

> 
> Sorry for the rapid reply, but I think this is where we need an update.
> 
> Linux:
> arch/x86/kvm/x86.c : set_msr_mce()
> 
> Please note the comment:
> "All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR."
> 
> We should include the MCA_DESTAT register range here.
> 
> What do you think?

But before trying to update the set_msr_mce() function, I don't think
that KVM keeps track of an MSR_AMD64_SMCA_MCx_DESTAT set of registers.
I can see mce_banks (for ctl, status, addr and misc) and mci_ctl2_banks
locations in struct kvm_vcpu_arch, but I don't see a location for SMCA
banks like MCA_DESTAT MSRs.

So if we make kvm ignore this update instead of raising a #GP error,
would it be a valid solution ?

Thanks,
William.

