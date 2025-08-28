Return-Path: <linux-edac+bounces-4704-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79DAB3ADE3
	for <lists+linux-edac@lfdr.de>; Fri, 29 Aug 2025 00:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6019F3B0BC0
	for <lists+linux-edac@lfdr.de>; Thu, 28 Aug 2025 22:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6EC293B75;
	Thu, 28 Aug 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LgPFlePf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e6RCleVI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169723D7EC;
	Thu, 28 Aug 2025 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421632; cv=fail; b=Eao9hv9wZRHbYVZaPiSin53b/lDz913hyOidbP0xkLv7H9l8hFf7hja3zmfpLJNL/qWSXPA/a6YRLnXIFRrBjNI+oOBwb2iNHP1KZGcBYvuQ7YiszWwujMzOvhTtCAtIPvOLeCB7CL2LQ7rgQGyHV9htMur0h/0DohIgXOgQLsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421632; c=relaxed/simple;
	bh=cylZAMiuRsLFNwSVcf79wjHWdFCzkIj9AMmJ5/IfZig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=byWdKKTngg3KTEPRrfc4bwpGOAWmQWlzL8bG7jWueCVq6TCkGDcyaCenWUbgsBIwjCeMx4VOP8lbllUSq6gqcosxFfX5cFJU5zlrN1s29EW+P128m1o94ocz/5OGGfz2RduRjQVbB9IONvmyS69VM0/TUDuMx24wwI0lDB8Uq7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LgPFlePf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e6RCleVI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLUsKE022120;
	Thu, 28 Aug 2025 22:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cYIaTAoEpEfs34coysLIBvfnDcvqOVsicL+//p2fWLs=; b=
	LgPFlePfc0cfdOdhL1gN3bpyHY7m7LJk7LJmeD1NvAuEqMmSUYbo3MztH+sfzjdP
	bjmbtRYpD+x8VQ5TqvL7l/+ol/OcjfnltliiKCszYY/lavYivEdWOEBghUnMWaXC
	RmfUImvkute27yiwiZlN1Wkk/01d+05CqoQ4HhJ+Qg/SDx0ikWer7ECnzX8cWfP5
	JWUGbs8fRfK12Mmzb4wfjKA7L09jKdQoyqwUicEccE+WHrM8ljMpx89tmd0FpXO1
	bFoOi2OIz332MpXZNh/hSpHABSOPZ8x0u60x/Q5uCiSnF8q0XawBXROkzxZFBROY
	kan04D0FSzoXJhCeHqRtqQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q6791hh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 22:53:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SMfvr4005065;
	Thu, 28 Aug 2025 22:53:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43ckvvx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 22:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYJuwA20ZAw+d6FWhIxuvOQOfR6sLCnWev5TwpUP1Rem4HhFuaDmMRTmAK3V8Q+f02yUL8tofOQ4KMlxiKLgjYd6mjwKL6mIZofPmLtlSvahkq1z86DqzWQrw0hpPH9vgj8n2hDcDwy4RHvcHD9XAJlZpzCU34xEjWxmxUeePcvP7/nBq/aCYbjwFu/DsEPRX/p4Aq+lirK2ej4fodK+22U+pumQzE5VkPagHc4pD0mYwbf3OtiMN+UE9LQI2K+EmqbRFV+Ysa/bFk2+VRNdCYH9Y+kf0Eu4Glc4f5XRPHyj3rfje3iOSz8PZ0Pg5IlVGALZRU5Og2hFYmAWoe4UUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYIaTAoEpEfs34coysLIBvfnDcvqOVsicL+//p2fWLs=;
 b=pPIHbQdxrz/lg0Ie1MWzDbPiXN99boAWT/eIH3EVXlb4Lg53BQb5+krLyVvWSa5bHgSEzbkOD8OY6+t3NMbKxQ0bwVCUOBVvWsaa0rBbJaXV40INV8wZFdruhkIiwLBo5JyKEDnT9VsxENXIrueEJ/mU3dQChdcTBLCZHWEnvXlOzCCjhQ/FsYq/zhGrZtnqMM6srnN2Mh9gBTVcJ/q62FEqCRvUy+/Y7zPc6A7Yqij7fgTRDVm6Hrgd0qi5K9Lpf3JC8z0UzgkggKPMQ3L3tpQ93Jn4pAKtCWhO0DKZ7RxhUeT1sbEPYoRki7egeSFDsPPWcx8KrffeYU7SmyxD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYIaTAoEpEfs34coysLIBvfnDcvqOVsicL+//p2fWLs=;
 b=e6RCleVIIWKRa3q9icDmOjIbGNqnLbaZQYqyRUT7f44LvTvCkOdFj3YDGx7VsKKhWAJuj54gh7ITeGRsxKxTmAZFchSMs4pH9rOg5e6fA1LqV7gt7jYcp+DqmiLtzC2tCpKtyWJaXsgTN5Wg43kdwJxyY0t3Z5o0+PfBt8miGVY=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 BLAPR10MB4883.namprd10.prod.outlook.com (2603:10b6:208:334::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 22:53:07 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9052.024; Thu, 28 Aug 2025
 22:53:07 +0000
Message-ID: <2d5498a6-e07c-4a4f-8ab5-2a007c08bd70@oracle.com>
Date: Thu, 28 Aug 2025 15:53:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Fix redundant updates for already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org,
        linmiaohe@huawei.com, jiaqiyan@google.com
Cc: bp@alien8.de, david@redhat.com, Liam.Howlett@oracle.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
        nao.horiguchi@gmail.com, osalvador@suse.de, rppt@kernel.org,
        russ.anderson@hpe.com, surenb@google.com, tony.luck@intel.com,
        vbabka@suse.cz
References: <aLCiHMy12Ck3ouwC@hpe.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <aLCiHMy12Ck3ouwC@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:408:d4::13) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|BLAPR10MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0f87f0-27f7-4faf-3e62-08dde685a786
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RGV2V1N0aWhsNmpHakY2b3g4K2VjUVVWd0VQT1Jpc0xKM21YRTNDTHpsVHky?=
 =?utf-8?B?RERjUTYxMjcvdmNqVlNzOFUrdGFaeVgxdEJzaVdpVkh2QjV0R0dWTzNHRzFt?=
 =?utf-8?B?cHJEZTI5N3FmMjJYWDFPbEVMTFlhV2V1ZkNhazdET1lMSXRUZC9GNS9BdXpG?=
 =?utf-8?B?UFJtMmZBTGlwUU1PbHJEMUd5OGQ0dlJ2ZWtRaEV5Y1IwcGtvck1IcWJIdWFa?=
 =?utf-8?B?N0NLNTAzVkdzcXlnR3UvOVVKdjZHOGxKOENuQlVKQ2Jac001ckxwTzdUeWNs?=
 =?utf-8?B?VmJXVTI3dmtHeThEa3JaNENxejZsT2Y2R3dERjJrYThhMnh2M2N1UVJIbzZM?=
 =?utf-8?B?em5mcEgwbHdIcTZPSUQyYnc1RnEyR05TZ0RJdHUrNW9FY1F6a3ZUOWFtWHVI?=
 =?utf-8?B?TEpxTENBWGdUaXJUWDFMcWtnU1luY2pzcFVzeWFTajJwTUg1bXVHdDljMEJ5?=
 =?utf-8?B?Sk9BUm1RbGdSSU5NTEJhY2xrS1d5ei9DU25aZS91Q2dIR21nRlBDWEFKRGZV?=
 =?utf-8?B?aXFDK2c4R3BRODBQbVQ4c1VOU0dsU21iUko3eVhjUmJQeFc3VnpSYkhOZ3Zr?=
 =?utf-8?B?emNLbzVWcVYrUEZFTU9hMXIxSSt5T3R4YU54em0xTXRtZXZoTmRzN3VUTFBq?=
 =?utf-8?B?WGZWVUVZRmx3UnoxMHNSa2RQTWZYK1lSNEpjWW00ZTFFVE1Nb01GV0xmUGN1?=
 =?utf-8?B?RHdSYTlhYmFWM1RHazRaOHIwaXBvUVpSZXY3Yzk5QzNxdDI2UExhQUZGaUtI?=
 =?utf-8?B?bHZIb1NaQWtTNU5McHNwMXowdjZqMkhpK3hubGl5Qk9UMG9rQmkvZmMzSlpP?=
 =?utf-8?B?ZkJ6cHFWQkxuMUNkQ293amNTRUFFaGg1RE9XTGN6aCtvUExPWWZXSkdrOWw5?=
 =?utf-8?B?T3NoRkpyWVgvSlJOa2lQbkI1KzcrNVd4NWNxMkkwaGtKRDdFdHlVNjMyMUly?=
 =?utf-8?B?RjVjWlQ3Rm9SK1JHelZrK0Z5UXFxRnN3Q1hjRmxZYVZYRng3VWUxYXNsdEpj?=
 =?utf-8?B?MVRxQWRPUmRzS0t3NUxyRVNBU1VvRUF0Nmt0TjBhZTRhMGJjdkZWRWpLTUI3?=
 =?utf-8?B?WUw4Ui95MzduR1FsbUtENU82a0pZdDF1OGhPLzNXUUljZHJycDF1UDgyTWx2?=
 =?utf-8?B?VzduaitiZHBwUHBSc2tybWlwUWo0dXArZ3FJMi9DTmY1OVRhajVGREF0TEIz?=
 =?utf-8?B?anVXeW90ZURsMll5RWMwNzRHRGQvZW9xckVZTmlBeDRvRjczanY3SmxtL3pP?=
 =?utf-8?B?Qm5YSmNzTVp2TnJUeDZFQ1lSNjJIOXRDRUtkVDFMdGpsV1d5YVNQVjRIOVNK?=
 =?utf-8?B?L0ZFVU04Ny9sNzY0d0Q5RXhXclRJd2F0eDB3a0FjY3JTZ0R3Z0lPWGp2dnZ4?=
 =?utf-8?B?R1BFTStodnlTRUx0SmQrVk1ldDFreGkxZ2NtUUNvakJNWmVqeW5KSndmWDRL?=
 =?utf-8?B?bmVkSnNWaUVyTUJqN3VRU1dIcVpxOGozYmFxRGo5dkxYRFNCTStSbE1pRzQw?=
 =?utf-8?B?WHkwWUFKM0xtMUdkdE5iVFpienNBQWxDSUgvcEpITkllMVVSWWx3Zkg3ZlZr?=
 =?utf-8?B?eHM5VmN1dDU2bS9PdCtDUitrUzZpbW9xN2UwN2xTd0lsNFVpbGxEOEEybCsy?=
 =?utf-8?B?cWlaRVM5U0Y1S2lmRWdyOGUzLzFCM0RVdmZVK0wxVEx2bVpvVDZzOWZqakQ4?=
 =?utf-8?B?Y2I0dnhTUUZqTlVjQk1aVW1ETS9heG00MGNqUjZPU3BGMUt6ZkNhb2t0eWZw?=
 =?utf-8?B?YmtXZEhzR3l3SE1oSmhKOWVrVmlnUzBVR3ltZEVVUWFUY2owVEt5MWxsd1BH?=
 =?utf-8?B?RTdlSVhabnpyWU4raDZGWmREVURBM1JwN0lPN1NNR2hzWWtwaThlOEJnY0ZM?=
 =?utf-8?B?WkQ1SUJSY0JtNGV2bVpTQThIb3k1Y3FMRVVGZytiQUxOL0JUN1drTkg5bWpE?=
 =?utf-8?Q?x5HrFm2TE1E=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U3RlNHZiQW84aVlpQklNRXpicUdjQ0RlVGRRM2NNZXZxekhkSDdOOGdJL0hy?=
 =?utf-8?B?SEI3cHN5aFNOcWlLNldid1dBU05yRDZwUGphS3laZzNCUmFUVzZveTEvaDhr?=
 =?utf-8?B?cXNMVzRjcm9QdCtad09HQVpPSzY5RWVJSGRZeld3T0R2cTZzcHFOT0dPRDl5?=
 =?utf-8?B?blhqRVZISXpCYUNlSjJpU09GdFJFeVo4U2tyUnJkUTB4bmJ1L2NEQVh2c2tY?=
 =?utf-8?B?djY3d3FXZlUwbFkzaWJzSkJkb2RCQ09CMlZpaEJzVDJ5ZXFlV0NVbWduSW5s?=
 =?utf-8?B?Sk5pb0tmOS9qQmNCNGVST3VqM3NvL0FFVUx5NjRkVUVSY2IrWEhkK2kvWDJP?=
 =?utf-8?B?MWxFdkt4TzBiYnlwTW1Ud0QyNlMxVFZqTjV2eDF0b0xnck9rbVdDUVNBRHdW?=
 =?utf-8?B?OEZ2UFBVcjdNaDJINjFYUHRnWkNpek1IYUpZS3dyREVUTzdOZ1N2NjFTeFc3?=
 =?utf-8?B?WXNMQjBTUzFQQ0tZWVB0MEU5aFg0czhSVmxBR2JTQTRYdUxVZnF3UU9vK3Zh?=
 =?utf-8?B?WW8rZHRaRG12WUl0NHQ1NlJWL29rZUJnK0NWVEFmQkxrdEwzeTdJMnViQU5D?=
 =?utf-8?B?RjJMSXR3UlBMUGZ6c3REY24vQ3BCejUzR056SmRoYktRU2srdHBaR3c5YlZV?=
 =?utf-8?B?TGVyek5HSlUwTDQ5MG8wSHdKU1BObGZQZUtpTU9EMFRjTjlUdFVudW0wOHFE?=
 =?utf-8?B?QWpnWFZNbmFuNUtNaGdnbWtaQm5raXozTGFjYjZ1dVI5aHdndHAraDJVZlRH?=
 =?utf-8?B?YTE0Wm5UQ3V0bGF3MFZyUDVTL3lMeGU2S2hva3VnWHd6U0svTVZUcTFnaDYy?=
 =?utf-8?B?Ym1NU3Y5M1FSUlYxZWtrSjZDSEsyaGIraUxXY0UreHFzaW1uMlJBbXZmdG83?=
 =?utf-8?B?akhSWHQ3V1MyMUJkYU5FeFRLM2ZXSGcrL2hpTUxhRmd5bnpnYmhLWGViZVE0?=
 =?utf-8?B?SGg4MGdUZGQ4MDdMRmQ5elc0Yi9CM0tYTDJaUnlLRzA0UmFONkpoZjlLSlIy?=
 =?utf-8?B?cVFEdlFZaTAyR05OdXIwaS9zcHh1Syt1cHlVbG5yNnNpc3NOaGlUN3R5aGV5?=
 =?utf-8?B?KzAwNlVqaG5xM3RGWWRkS1JwY2F0L2NISEZzbks2Lysvc3RtWmRzaFM3NXA0?=
 =?utf-8?B?RkRrZzF6Q2IrS0dMV2VYOUdhVTZHTmNidVlwOWpXQmVickZTekpyT1laUkRD?=
 =?utf-8?B?akxWeHJleWk2M2Y0aTVianI2N1YyMEJHeVBHZnV3ak5iK2R4K0pxVVdkVFZL?=
 =?utf-8?B?WUJTM1hMUU40Mld3emRueG0xc0J4VEdRWmhtS2MxTlBKcGpoQTVNLzZMVEpG?=
 =?utf-8?B?S3FJVkdtYzBHemU4ck1heXBUMllrZjNscWx1b2hZKzVVY1JYdm9xdkhZUGlI?=
 =?utf-8?B?ZjBXQ3dSd3UwUUNPK2ZCQmcrVzZ6c0hQNmFyTTczakVJelRtNFNHejdpVGkv?=
 =?utf-8?B?UG83RWU1Uk1ZaGdSSEVtNXVKS3duVDZDQ0ZVWlp0UjlkV094Yk55bzUyRlJB?=
 =?utf-8?B?TC9SaC9GTjBxdkpadE5YRmNqd3Zpd0tLbmNpR09CSGpQMDdhdW9RVHdXeXRy?=
 =?utf-8?B?aThIQmcxWDEwUXRXbnJvQ0h4STJNQzZYWGVaUmovNFQ2YUxmM010TDViZmcz?=
 =?utf-8?B?K1ZtZHovZE9nTE1UVUtCOVFTV1R4VDlPUC81VUZxZmlxcDhGV2NrMC9yWjV3?=
 =?utf-8?B?MEwyV1l5RUdxMlM3MnJPRkNWTnI4MU1wVlBGT1lTbEh1WVRrK0xINEx6UnlN?=
 =?utf-8?B?ai9oWFNvV21oajZkcDhXUlFwZTJYMVFYQlVrZkFkZ1ZFY1hxSUFlWlZTZTJx?=
 =?utf-8?B?ci95ZHJIQ3N5S2N1Y0llS0hFck5rbmtJeUZTS3dyOU54YS9EeStrUSs2aXJN?=
 =?utf-8?B?bUhuZlU4dTBqYWZhREM5cWFJRUlDUy9MWTEwNGJXR3hPUHJVLzBxTmNJTVUx?=
 =?utf-8?B?M3Z3UzlVaHFickcyMXdNQ2tQVTRzbU1wS1lzd3hGWUdoR0M2RFkrN3RycENX?=
 =?utf-8?B?WnlSUzkrMTZQV0VKc0txMnpvRmN6ZlcvNU1RVitWbC9zVlBtYnA3TDhwblVF?=
 =?utf-8?B?a2tRTEpHZjg5SXVQUnBzNUZOYUJvZXdrWGppS1ZIQnBlaHBzTWJMNUFjMHhL?=
 =?utf-8?Q?4JAauEzy/5g4Dz3UZQS9GKaLp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BK4jJhPAxfJc36yn3BZQei3rib/ftdJ3Qncw72uE6Tu2zqa3QJNvdAWqmtVUMGYjijCe/IIGJRfmH+mmKnDMp3NQ8luKDCS7CCkM5xpYLGnBAtB82S595uQOjJJotCz3Um4rJTJyht7UW281p/+SYzXmtBMXWspKdkTto4iRMaeQ9kgX+ULTCo8AJs4Wx3Q3Njm2RtLL12+jSy2yyKOmf2C+QISTKoh1VDB1RPzEvTRzq1NQHqE9fwlx1MfnVfmXEswtmi7wXeMxOr7qFwe6LJVTeHFc1XGBok96kbixgexZUxIUuZOrDWDavepIfOJYO4B6FoHkTsb5cBlmngTuxr8b3sQ6GxgzexC2SMlwurVaWs7+RxtMSrVgW95v9NZ+TTfY3A2kC5lqWiK430ReVxkbQpz5XEGsAC46haBCuNE/zLIr42fWC3zowX/WzJeLDTexTBe2CfAvKFpIy2FRP8jOM5yPI35/5JPPAuqC6YggFbl7EbASyiqq14lVffOpyr3X8iOFgReqRld+Il8Q5MsLtmd4LTkqENLtQC+m0TBgFsHKo0j+Flynv5flIZb/suo4kwvJk7NYPPP6htQCj35dAFNxQC2zZLCsy/mog5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0f87f0-27f7-4faf-3e62-08dde685a786
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 22:53:07.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0PVaGfDPQ5Wf0smHq2GO0E7V9BEEnKON8ZIXsuE2s0yvx8AA2sHSbfZX++iUBKxel6+QdoUDpneyV+gnqTccA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280191
X-Proofpoint-GUID: vB8MBLC4BTiX9R7HyexZQonpTb8rY97e
X-Proofpoint-ORIG-GUID: vB8MBLC4BTiX9R7HyexZQonpTb8rY97e
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b0ddd8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8
 a=yPCof4ZbAAAA:8 a=vLOEdQ6XIQR-RO_0T90A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX5UL1FJozypXE
 dCPyk6fKrCGm1YKN3Z4vbnEBtFHO96R0uK2yhHXCjI+t8hLSJAoKG2H7ZXKrkWmsv2EwwS4Z9QV
 oLlL4NgNIjEI8QdPPaONoHZgmiemexc6WMekvxRCxxN6DYQ3iPjAYY7zIteb7hvM5orb49jvi8x
 u/KkfC7IO/s5b/nReNeLlZfZe4Ju7Vz7rZ3du4vXetR3uYwXU6ZHqi/clKzQ1n7nor8/OFQOw+G
 tDR5Ptjd8jeqgzQyNXA50a3nRN+x3+unq98WI4cr++aBzM0uApCSHH5vpWGXTO1o7+2YJXBcfsx
 yzBHhHXoTSYf7VG1enNLkONS4FtLdExg7bV+QVFFkZGNJ457INi/jYOTcfG1REfG9YQoc/ZPQBZ
 IwFEZ7GB



On 8/28/2025 11:38 AM, Kyle Meyer wrote:
> Duplicate memory errors can be reported by multiple sources.
> 
> Passing an already poisoned page to action_result() causes issues:
> 
> * The amount of hardware corrupted memory is incorrectly updated.
> * Per NUMA node MF stats are incorrectly updated.
> * Redundant "already poisoned" messages are printed.
> 
> Avoid those issues by:
> 
> * Skipping hardware corrupted memory updates for already poisoned pages.
> * Skipping per NUMA node MF stats updates for already poisoned pages.
> * Dropping redundant "already poisoned" messages.
> 
> Make MF_MSG_ALREADY_POISONED consistent with other action_page_types and
> make calls to action_result() consistent for already poisoned
> normal pages and huge pages.
> 
> Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_result messages")
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
> 
> v1 -> v2:
>   * Continue passing poisoned pages to action_result() with MF_FAILED but don't
> update anything.
>   * https://lore.kernel.org/all/20250821164445.14467-1-kyle.meyer@hpe.com
> 
> ---
>   mm/memory-failure.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fc30ca4804bf..10b3c281c2ae 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -956,7 +956,7 @@ static const char * const action_page_types[] = {
>   	[MF_MSG_BUDDY]			= "free buddy page",
>   	[MF_MSG_DAX]			= "dax page",
>   	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
> -	[MF_MSG_ALREADY_POISONED]	= "already poisoned",
> +	[MF_MSG_ALREADY_POISONED]	= "already poisoned page",
>   	[MF_MSG_UNKNOWN]		= "unknown page",
>   };
>   
> @@ -1349,9 +1349,10 @@ static int action_result(unsigned long pfn, enum mf_action_page_type type,
>   {
>   	trace_memory_failure_event(pfn, type, result);
>   
> -	num_poisoned_pages_inc(pfn);
> -
> -	update_per_node_mf_stats(pfn, result);
> +	if (type != MF_MSG_ALREADY_POISONED) {
> +		num_poisoned_pages_inc(pfn);
> +		update_per_node_mf_stats(pfn, result);
> +	}
>   
>   	pr_err("%#lx: recovery action for %s: %s\n",
>   		pfn, action_page_types[type], action_name[result]);
> @@ -2094,12 +2095,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>   		*hugetlb = 0;
>   		return 0;
>   	} else if (res == -EHWPOISON) {
> -		pr_err("%#lx: already hardware poisoned\n", pfn);
>   		if (flags & MF_ACTION_REQUIRED) {
>   			folio = page_folio(p);
>   			res = kill_accessing_process(current, folio_pfn(folio), flags);
> -			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>   		}
> +		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>   		return res;
>   	} else if (res == -EBUSY) {
>   		if (!(flags & MF_NO_RETRY)) {
> @@ -2285,7 +2285,6 @@ int memory_failure(unsigned long pfn, int flags)
>   		goto unlock_mutex;
>   
>   	if (TestSetPageHWPoison(p)) {
> -		pr_err("%#lx: already hardware poisoned\n", pfn);
>   		res = -EHWPOISON;
>   		if (flags & MF_ACTION_REQUIRED)
>   			res = kill_accessing_process(current, pfn, flags);

Looks good, thanks!

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane

