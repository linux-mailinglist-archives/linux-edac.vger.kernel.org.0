Return-Path: <linux-edac+bounces-4691-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF8BB3714B
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 19:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BBE7A26FE
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498E2E2DFB;
	Tue, 26 Aug 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kc5CJDDj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q/370a7y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DB22083;
	Tue, 26 Aug 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229092; cv=fail; b=e1cM7PApvOXzYry2iaJutoHN6XDvTgvN8RRV9cc2QJ3kTiP8u1CHqPz9HBBjjmGi7vev9Vk4j25dF+XCM+TliKX3wfFqkTr59fVHVzikH5ogswHhdBLtXsTb2Pj7nFcTzfo2iDkbVt+/feeeIX7jetYKQ5L54OoGJfxoNqo8ubI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229092; c=relaxed/simple;
	bh=FvagV1SFhRth7y5Y6KaFXce8mGPUs8A9Aa53xbeFH+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/11oDaxxtt59KlkGdyQ9W0WzktMwe5xD2lETxLJ+XteYqFDlJL8QgocNXHWPwiOzBn06QK/MPTmbLSTaKEvfcDL3xzbH+qU6wHZczKjjl/EXzFaPOg0NnIpz9bhV9jwT5Ap6xKc7WWF9r5ZE0jgU3pnKswDeDAWFuQRLvPEr5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kc5CJDDj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q/370a7y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGfrUg021413;
	Tue, 26 Aug 2025 17:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Pq2UChQULsDwyLB/YRbRcPzk/JtI4WcFQ8eB8L9RVNI=; b=
	kc5CJDDj4vGmuGb91AROPrTPUIUIKmlFnjq5tDmpKiA3zAi+uIIUutl+D24jw5mF
	nfHYe7MnzvoVddlbYDFMWSJo9K1NFMLsDQgbmHqigPCzmZ2qEoO+9KCzXSbdGeI8
	OuUK0e4JKA+mYIlg5RVVPiRsfhSufxpgBKajQCOe8IFBmxtV1bPNBaUAG19ld+Tb
	mYHVt0nBRjZXrhGHW1t56l0hhQah4SuttApeZGINkxXZkRXeYBb6Mx0pWcDpFJLq
	dX4ABrtVka0qTXOZzE4v5fckMKHeDwHIXOv0v7/QabYxiHuKtb8EsSNUEE6HZFJl
	Q0cz+uZ1vzYrlKgLscwslw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt51qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 17:24:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QH5Po5019707;
	Tue, 26 Aug 2025 17:24:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439vf5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 17:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYoUNfUWavGOjmjXC5IAzIc1MvPfvTo/KPCAgdrqORY8e0e670kLP9UwB/ebzvfAvynwMW/CK8zMwIsrkTlNDMn1dEC/BK0m0TKzNOuRKHIEibq9VyvCQ9Ehqxn72xHNkkEQ2v7Mmk592QeuvOnweaDtfbQ0Y8XInUFaxzKuf/rcdSVg5IASWKxZ1KoMZOB+nzAWFGbyhDC2q8QPtuLOQ50HtZtOKOeKhHdeg7NHcR6JR59JWDjeZGd/wGlGss8cJXkcOduz9+qlOu1XOflHxzsClmPfzJyBuvnOVIHAyJHv+aG2TiDDD3OQtMKKx/+ER/7LUmd2jPOYGO9cdruxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq2UChQULsDwyLB/YRbRcPzk/JtI4WcFQ8eB8L9RVNI=;
 b=jL/a5n91IJkl997tbXxOkWdagp1RaHEIYWQ1QgOjFOopC9cXcclXsLEYYVJkQgf781jGv8t6qGf4MlHUyk45OzFyy55DhAAWUHLFMR5yAR+p8NGB7zs4sN8r2DF5yLCnSx3gANjRcp4MqSJO1g5TOS19g0JA8zrKqYFHDrMsNPtU6LQZ3/o1zwyAtUvs0m/om7n/HL1NK4WuahHxzWHPCjzYQX9onahc13JHTPWR/X9UigTs5/GrbFN0tSZJbg5EdMrWdUT8L15wmSQotz944xpccgBYpl+v4UGyKxqdc0GsNCp9UXNZmOPIo2TlTPurDD3s6jWKS0mJHMeiZN/FQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq2UChQULsDwyLB/YRbRcPzk/JtI4WcFQ8eB8L9RVNI=;
 b=q/370a7ylx4nUFcs7qIXEqg8EOYLi2obQkB5H3moPWt4fSzi+/en2JGcUn8utuWa3v1rcZ/+Gb7G88GNkJqfXCrbTcZqcrGjbLlwrMDi4eyDwEjsQqUnk4++F06YPw3ToqCZPFvb1oks8NK5eDgiQhxJXp02FkT8m0K5rmNeX9M=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DM4PR10MB7475.namprd10.prod.outlook.com (2603:10b6:8:187::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 17:24:10 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 17:24:10 +0000
Message-ID: <714d066a-a06e-4b49-b66f-68952c6520d9@oracle.com>
Date: Tue, 26 Aug 2025 10:24:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, Jiaqi Yan <jiaqiyan@google.com>,
        akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com,
        bp@alien8.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        osalvador@suse.de
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
 <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
 <aKd1K3ueTacGTf1W@hpe.com>
 <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
 <14a0dd45-388d-7a32-5ee5-44e60277271a@huawei.com> <aKyKort2opfQYqgA@hpe.com>
 <2bd5c32b-dfc4-4345-8cc8-bbda5acdc596@oracle.com> <aK0UTovxnKfjPwXs@hpe.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <aK0UTovxnKfjPwXs@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::6) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DM4PR10MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dd6ae3-4d3a-4778-954e-08dde4c55e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azMyMUpZYTd6T1FzR0Jnbkl4RjltakRydTExMDZkN3JPeS8yYTI5dEF5dlEy?=
 =?utf-8?B?Vmc3SGFqRkdiVEl6NTVaRThoRXBWRjA0R2IrNkZZeEJCNVJKMThwRUR1bnZ2?=
 =?utf-8?B?UEcrUUZPc0toMlQ1dDlJUlJGcFhWUjJ4NmRzdWQyWlZIbGsxMDlTTStVR3dO?=
 =?utf-8?B?MkhPaVppbVREMS9lNlBWZk1HTzVrWEM5U3FSZGI2VTZrZ2JQRXU4TWQ2TkVl?=
 =?utf-8?B?ZjVZd2tMdWlnS2Rlc29VSG9wRnFMWjlQUC9TYWxzS1pFSmRvbm91c1UydGVX?=
 =?utf-8?B?RUpCa1RNazVsKzNvTFBEWDNmcUFEOTR3Z3ppU3Z5SHhpb1BmYThyZHVBK1dm?=
 =?utf-8?B?Vmd3R0thNHBoVVpSdlgxdU1MM3NxVEk5c1g5N1JRN3FOd0JuQW81QWJ3Y25X?=
 =?utf-8?B?WTlCNXUzemNsci9HdUxQWkt3MllRTnJWS1I3L1hSMzgwa2d5QzN1TVlnUUY2?=
 =?utf-8?B?Qy93M3F0OEN5VFVjQlVucjVzMXVEdXZXdHIzZnQ2NWxidjFDVW5OTERBVDFB?=
 =?utf-8?B?dkwyODAxTXRVZmR5RTFhR0F6OC9hdkJPTzFIRFdpYmdrdks5aEpDblR0Q2lu?=
 =?utf-8?B?REZwWDVTV2x1UDBKV0lJWHkyektRYXZnajVqUmRzN0hCbzlXZHZuNWdLa1M0?=
 =?utf-8?B?SWNqQytPaEgyVmFWTEF2Qm9qZzMwd2Nqd284WFlEaTltdjU2QmdQVHpjNk5O?=
 =?utf-8?B?eXpIRlpNOVQ3Tm9SVFE4WlFCbmN0MzkzUGZ3dVBYRXpFN211SzY0OVB0VjMz?=
 =?utf-8?B?L3dsbzJudUgxdzFWdExPRGVxZzYvWEVoYVZYMnZUaXhlQTcycUZRM3VLazJ0?=
 =?utf-8?B?WGtCNmkxSmhvTG5TWTlwNzdnV3QyRkorbi9zNkhqbVJZMHlmcWdhU1ZCY20x?=
 =?utf-8?B?T2wrb01heW5pdmpNQ3BZeFRqRGJuSjdsY1VGWis0aFU5UkVWeS9Bbmd2MFVI?=
 =?utf-8?B?aTEydEgrVE9yL0dLM0xRQnBvUU1kYmQxczYxc1F5MEkrc0JraHNwNEIvZWsx?=
 =?utf-8?B?MDFpRWpGblByK2hWR0RlSE04eUVYOVk4Sno0N1BBTEt6ZTlkUHUwVVltSmta?=
 =?utf-8?B?UXpwMVVya2l6YmlLam5COUZWS2NibUQ3ZFhSeHlneHR3aWRMbWNUWVJHZ0Rr?=
 =?utf-8?B?TVB5TTV5K1ROM3JMTE5MeExqUDNwdG5SeEhyQ1RZT2kyKy81UFl0TFlJNmNB?=
 =?utf-8?B?ajBrS3U3NDZkYWY3TkZJMkZma04yVXIxRTFVSnhKS0s3QmdlbVZzRjZ5L1lY?=
 =?utf-8?B?ajk2a2h1eHdPWHNFRVVJQXpWdXhNNkZUc2psVjFZOTZESmk4MmdiYU5UUGRv?=
 =?utf-8?B?U0ppRnhoMkdxUys5MGxpZVU0T2YwQkRYOHNVZ1R3dElnQmJIUmE5bG9Xa1R2?=
 =?utf-8?B?R0NkOXZ0V1F0bi9VTUpNUGFqRkJsVHZGMHJ1Q0NLSi9abUNtK3Mwdld6SkZG?=
 =?utf-8?B?ajdRZGRGMFRWKzNJZHN3Q2pJM1M0bGpYODh3MEtFSldtQWF0SzdDdkJ2aTZX?=
 =?utf-8?B?aHNSVXdaOHVSbnJ1UFh4cFJycllJNURzaG5BSEVUdGhQTWJKaEZvUng0MlJQ?=
 =?utf-8?B?M3ZwOTdVS3pyM0gvc2l5NHF4cEtSbDY5eVl4RVM5QUxkQWxNUXlUS2Irb3pI?=
 =?utf-8?B?WGc5YXR4TXBhTU1QV2hrUWRHWUxrYTNaMXVVZVB3WTR2VXJra1NNUzFIOU5T?=
 =?utf-8?B?R1FNaGF1SkhHb0grY2tRV2JNS0NpNWxYNXVHdTZ1TjFpaVY4NjlhUTVpQ2Zv?=
 =?utf-8?B?V2kwRXQxZm1POVA3c0VVM3p2dG9MRTRQOCsxZVVRS0dqUkVNbkF4eVhYNWRw?=
 =?utf-8?B?YVgwTmFoK0xIM3B4NGpYQ3VTZ1dGbjJ1TEpvSXhWSktrMzF2RkdZRG5SUVhW?=
 =?utf-8?B?Ynh1YlJYcUxFSjVyd2lsemZaekJMUnRGRS9mNW5BWVJWc01iZTR1QmFRVDZW?=
 =?utf-8?Q?1jocP1FCCOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm45N044NDg2Uk81a0tuSTh1SWtrbG1OUVczMVhHN01PWXZRQThxL1Q2bzlR?=
 =?utf-8?B?NnhFWU9MRmIwOWpqK0krNmpUQTkvWHNIRlc1UElMR1pucEpoUzRiT1FiNElV?=
 =?utf-8?B?NGRiR2pneUVaeU5BWDlpaGVRN2xucTJLYkdKTFN3STRKUDFyUmhzVEcvaUlV?=
 =?utf-8?B?aXhZMUg0YVlNa1lTaTVZaTJmZlVyNkQ4SWo0YXpibHRpb0laeC9IZFRvZk9D?=
 =?utf-8?B?cmdwSjk3M2ZyNWhnczIwQXJlVjVjNnZyd1k4R085ZFFnZUpwc2ljNXFYYWhO?=
 =?utf-8?B?TmRmcjR0d09EbU5ha05GcWZRSUJnOEczRGp0Si80aWl2bDVKRGVSRnkrdU9n?=
 =?utf-8?B?R0FVcHZobDNwcjJXSW84bzZ2QWZYTTU2QXB4WEpJOUJEcW9rTkhMSFgxRU5K?=
 =?utf-8?B?TnBCWXdhSDB3SGJ2WVdkZ0dDUnlXdnUvZmdaTjNmR1dWUGw5d3lPZTFKc2JZ?=
 =?utf-8?B?UlByR0RzU0pVY3ptZXIyUjV2MWZsc3BWYzl3czQxYk93dXlraWtKYlhFcVhT?=
 =?utf-8?B?NUMxdTB0YThXMS9sSFozQ2RGejloOStQOWNoMTlFMERCNVh3MVlTdVJSeXdF?=
 =?utf-8?B?ZWF1blo5ZEN2S3BuaXpHUG1xczJ3QkJtblZIejZiaTdnUkRnNmZnb2RjVENP?=
 =?utf-8?B?R1ZZdWNQaEZpNnhmTWpxMCs4S204OTJHWjBKOGpxSU0xUHQvUC9TV1g5aXpI?=
 =?utf-8?B?SmtjTWd6SnJhTUFKaFRXaXhONTJKUnRIWHp2V0ZaNUhjVWcxRmhSK3RmU21m?=
 =?utf-8?B?cVB0WlQxQ21Zdng1SnR0M1ZTS213K0g5K1RQVnNXUDkveDNsWEJqTWRSRzVj?=
 =?utf-8?B?eWhicjMvNm83ZENTV2poZ1U1V3Q0d3NZUzdSMTMvVDFwcEQyZEQ3cXI5Ti9z?=
 =?utf-8?B?RXg3N3RTTGhWWTZVSkt6R2k0RGhjalMrcjJyNmZPVDlsRm41VjFmcGxTWktT?=
 =?utf-8?B?U2hQelJQaGw2UW1nb01UWlE5dXd5WEZDcldocUErU0x4bWptUzduc0ViZkh2?=
 =?utf-8?B?REtxaUR2NDdKcDlHaW1JZk9FREJZSlFMTDYzVFhEL01QMlBzdXh2OXM2WWtP?=
 =?utf-8?B?RkM0OElGMlFNU2RUWmhmenNxc0Z1ajMzUnE5TldoSjBoNEFMTm1JdzlTTjk4?=
 =?utf-8?B?TGE2cmVzZkQwL1VMVVQ3aE1oZnZ6bXFFS1ZoN2JMbUc1VW5UL0hFclRxWW5J?=
 =?utf-8?B?YVM4aUw0MGNGMHFXWExuUEdodXlGMzdVT1Zid1Q3MkV3ZnN2dmVaV2JxOU80?=
 =?utf-8?B?ZVVRbHR2OUkvTkRLRkFrK2tvZFNaWWczNS9ISzhHVGZteStDMGZ4a0V1YXBn?=
 =?utf-8?B?eDNmV1E4ODl4dVNLTi9CaXhqN0RZKzRzc2RoQjFXUXNaaU0wV3ZxWGw4c09o?=
 =?utf-8?B?U2FhY0tacVdjWmxPRmZ6RFBRYXJRRS92U2JYWmFtc2xmYmJWSkJmSW85Vk02?=
 =?utf-8?B?UXJaY2pGais2SDNWdHgzTTNOenVSd2VoNk04UjQxOXh5alRma1NuZmIvb2xT?=
 =?utf-8?B?dlIyTkJYTXRPeEJJM0xmaTF3S1kvWmZ3SFNOWE84UEhCaElSWDNNWW9Ic1Nt?=
 =?utf-8?B?ZGhudmdueVN0TlpZSGdrRzUzd0wwNjdRZnFDWkJ4OHFnQlpCbzFxM0pveXlO?=
 =?utf-8?B?bVJsekswb3pLcURpMXlaRXdPa0lYWm9rWDh3WU05dW5pQzdwTVFEaFNXOHFB?=
 =?utf-8?B?TVdRY1l3Nm45clJXNy8vbHNXeGJ4NzZadlgxRFQvMzRBYUl0SnZUK1hWeTRw?=
 =?utf-8?B?VThyWFFpZU5WWmtRRWFTNUExdStTMjBIU0ZaZ1ZXRFpBSlpobWFrREJ2STdt?=
 =?utf-8?B?bytPNWx5UTczZE9Mc21Dc2tmbUk0L2ZaSytQdE9JR3VOUXFoSExvTG1MUFh6?=
 =?utf-8?B?cVlXU1I1d2NyVEdHUmU4eXJDNkNIRmlsQ1NOa1FnVXZ5cEZOTXo2dEVKQy9x?=
 =?utf-8?B?anIwZlFWUlFjemJFcEx2ajgvcHNzdDRTZ1drcmE4VzVtd1BKUGRVblEzSU1I?=
 =?utf-8?B?LzNPVkFPT3NuTjJCa29RZ3ZMRHNqbWcrZHJKOFJwbjkwRmIzRTc3UkhzZGRH?=
 =?utf-8?B?Sjc3cFFacUl1UHJTMU54UzRlNSt6QUdrdndpRStZczAxbE84QlgyWDV1TWtY?=
 =?utf-8?Q?3/jFsRlZeSebyzJA4WbSbFZy3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I1gebEa9ftUVrlStuhgGQ41bPh2AzjQKyFLvNWWl80/NCA8WJsGAgpvxUxi3VqOvgzf9ULJWS7LzE1qvDYx6VyGLk9Uj466+ZYjODmJYiq40hCxsMxoClpdAEkllomQhCydhDUhvyD6PbqtftIUxncRz18KHEyQ9K6ELywgG1QZR61roOysbY1NyMf3nnz8DBSO9ByuBK+JiXXXHQROuyTW/f5FX4YR2//buj0Dsk/ICk4CQnuhmHoQuEIQQS3SOxZRv3+5/7P9/NNV5AY2Inje1ik3swc0YkLsMwGX48dlRZVY2/jPlblvXHnCZzI8rM51IxtfaEB+tcv8I3C60s9zyf30EWJc/go5ArW5EJUGo3dITRIcdBUuZo8LDzO0RDRpS7dMLNzcl7qTHTuRhhuJMQ8Kk27xLG/fau8UZxKDdQzVpEuKk5y+sUhf6EHXa4SRO/V1/KSjUKjvk2IViwhQ4kiHfEFr1qikwJueY1hBNMLmK0Gq3aGAJk/6MPlk0rpB3ZUnPiAyCsozLON6REfs1YS///uuBQXMSgOu7tfD0ATeRX6nP4GSXsOAxhDInl2lHHEvzYK4UzXM/bG4cOPgMDljCedO4i70oOb5ZPRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dd6ae3-4d3a-4778-954e-08dde4c55e6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:24:10.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKBGNwArO3lz6Ao3PkCmPj3jXxaLK6Ul7OIPdUDnH5LBtHcIHb0ZOz8sSVrPdxNfq8ccFIMFFa3daM4JRMOOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260153
X-Proofpoint-ORIG-GUID: lgcthk5b6kY469CeZEaRuNvRYF-km2R_
X-Proofpoint-GUID: lgcthk5b6kY469CeZEaRuNvRYF-km2R_
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68adedbe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MvuuwTCpAAAA:8
 a=1XWaLZrsAAAA:8 a=TudOMMRRcpkxdpn9tkcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX6rSAR9ie8YYE
 vlxwL23m8pzYv9lCCd/XOIxvJOjynxIg3pRU8XdIeGt0EyW0Ambc2SuxO0Gl8vkOk0gN6bABS6T
 qI4d0lFE/9KqUE5Ifh4vvBm6I3aqyvZvwCYQK3gqnx2iKvnzx5Vf07NmDfN3Ai8U0ZvcnezExCN
 OZpcZxdl6YJDFfWhvETrEX+S0Fg7J5qweKgIE/wUqCxu9/eavFpAE6jYxzh8+I+ELGQQ+f7IcYb
 0mBAQN/CeWVyZbP2evyBe2Dzt5tLO3mEZeIjHOIXQFHFaEpsx2zimTE/hWMETDO2UnPXzFWYQBo
 9CBV4GiqltXgvY+k+NzPeH1QAqzCmDurGOui3y7r5IERpY55+SSYt6cPWjT9slK1zeLUnaQ7q6Y
 VLt6NaFM


On 8/25/2025 6:56 PM, Kyle Meyer wrote:
> On Mon, Aug 25, 2025 at 03:36:54PM -0700, jane.chu@oracle.com wrote:
>> On 8/25/2025 9:09 AM, Kyle Meyer wrote:
>>> On Mon, Aug 25, 2025 at 11:04:43AM +0800, Miaohe Lin wrote:
>>>> On 2025/8/22 8:24, Jiaqi Yan wrote:
>>>>> On Thu, Aug 21, 2025 at 12:36 PM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>>>>>>
>>>>>> On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
>>>>>>> On Thu, Aug 21, 2025 at 9:46 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>>>>>>>>
>>>>>>>> Calling action_result() on already poisoned pages causes issues:
>>>>>>>>
>>>>>>>> * The amount of hardware corrupted memory is incorrectly incremented.
>>>>>>>> * NUMA node memory failure statistics are incorrectly updated.
>>>>>>>> * Redundant "already poisoned" messages are printed.
>>
>> Assuming this means that the numbers reported from
>>    /sys/devices/system/node/node*/memory_failure/*
>> do not match certain expectation, right?
>>
>> If so, could you clarify what is the expectation?
> 
> Sure, and please let me know if I'm mistaken.
> 
> Here's the description of total:
> 
> What:		/sys/devices/system/node/nodeX/memory_failure/total
> Date:		January 2023
> Contact:	Jiaqi Yan <jiaqiyan@google.com>
> Description:
> 		The total number of raw poisoned pages (pages containing
> 		corrupted data due to memory errors) on a NUMA node.
> 
> That should emit the number of poisoned pages on NUMA node X. That's
> incremented each time update_per_node_mf_stats() is called.
> 
> Here's the description of failed:
> 
> What:		/sys/devices/system/node/nodeX/memory_failure/failed
> Date:		January 2023
> Contact:	Jiaqi Yan <jiaqiyan@google.com>
> Description:
> 		Of the raw poisoned pages on a NUMA node, how many pages are
> 		failed by memory error recovery attempt. This usually means
> 		a key recovery operation failed.
> 
> That should emit the number of poisoned pages on NUMA node X that could
> not be recovered because the attempt failed. That's incremented each time
> update_per_node_mf_stats() is called with MF_FAILED.
> 
> We're currently calling action_result() with MF_FAILED each time we encounter
> a poisoned page (note: the huge page path is a bit different, we only call
> action_result() with MF_FAILED when MF_ACTION_REQUIRED is set). That, IMO,
> breaks the descriptions. We already incremented the per NUMA node MF statistics
> to account for that poisoned page.

Thanks!  My reading is that these numbers are best as hints, I won't 
take them literately.  As you alluded below, kill_accessing_process is 
applied only if MF_ACTION_REQUIRED is set, though the page is already 
marked poisoned.  Besides, there can be bug that renders a poisoned page 
not being properly isolated nor being properly categorized.  If you're 
looking for something precise, is there another way? maybe from firmware?

> 
>>>>>>>
>>>>>>> All agreed.
>>>>>>>
>>>>>>>>
>>>>>>>> Do not call action_result() on already poisoned pages and drop unused
>>>>>>>> MF_MSG_ALREADY_POISONED.
>>>>>>>
>>>>>>> Hi Kyle,
>>>>>>>
>>>>>>> Patch looks great to me, just one thought...
>>>>
>>>> Thanks both.
>>>>
>>>>>>>
>>>>>>> Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
>>>>>>> but changing action_result for MF_MSG_ALREADY_POISONED?
>>>>>>> - don't num_poisoned_pages_inc(pfn)
>>>>>>> - don't update_per_node_mf_stats(pfn, result)
>>>>>>> - still pr_err("%#lx: recovery action for %s: %s\n", ...)
>>>>>>> - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
>>>>>>> in memory_failure and try_memory_failure_hugetlb
>>>>>>
>>>>>> I did consider that approach but I was concerned about passing
>>>>>> MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is a
>>>>>> bit misleading.
>>>>>
>>>>> Based on my reading the documentation for MF_* in static const char
>>>>> *action_name[]...
>>>>>
>>>>> Yeah, for file mapped pages, kernel may not have hole-punched or
>>>>> truncated it from the file mapping (shmem and hugetlbfs for example)
>>>>> but that still considered as MF_RECOVERED, so touching a page with
>>>>> HWPoison flag doesn't mean that page was failed to be recovered
>>>>> previously.
>>>>>
>>>>> For pages intended to be taken out of the buddy system, touching a
>>>>> page with HWPoison flag does imply it isn't isolated and hence
>>>>> MF_FAILED.
>>>>
>>>> There should be other cases that memory_failure failed to isolate the
>>>> hwpoisoned pages at first time due to various reasons.
>>>>
>>>>>
>>>>> In summary, seeing the HWPoison flag again doesn't necessarily
>>>>> indicate what the recovery result was previously; it only indicate
>>>>> kernel won't re-attempt to recover?
>>>>
>>>> Yes, kernel won't re-attempt to or just cannot recover.
>>>>
>>>>>
>>>>>>
>>>>>> How about introducing a new MF action result? Maybe MF_NONE? The message could
>>>>>> look something like:
>>>>>
>>>>> Adding MF_NONE sounds fine to me, as long as we correctly document its
>>>>> meaning, which can be subtle.
>>>>
>>>> Adding a new MF action result sounds good to me. But IMHO MF_NONE might not be that suitable
>>>> as kill_accessing_process might be called to kill proc in this case, so it's not "NONE".
>>>
>>> OK, would you like a separate MF action result for each case? Maybe
>>> MF_ALREADY_POISONED and MF_ALREADY_POISONED_KILLED?
>>>
>>> MF_ALREADY_POISONED can be the default and MF_ALREADY_POISONED_KILLED can be
>>> used when kill_accessing_process() returns -EHWPOISON.
>>>
>>> The log messages could look like...
>>>
>>> Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: None
>>> 	and
>>> Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: Process killed
>>
>> Agreed with Miaohe that "None" won't work.
> 
> What action is M-F() taking to recover already poisoned pages that don't have
> MF_ACTION_REQUIRED set?

The action taken toward poisoned page not under MF_ACTION_REQUIRED is 
typically isolation, that is, remove the pte or mark the pte as poisoned 
special swap entry, so that subsequent page fault is given a chance to
deliver a SIGBUS. That said, things might fail during the process, like
encountering GUP pinned THP page.>
>> "Process killed" sounds okay for MF_MSG_ALREADY_POISONED, but
>> we need to understand why "Failed" doesn't work for your usecase.
>> "Failed" means process is killed but page is not successfully isolated which
>> applies to MF_MSG_ALREADY_POISONED case as well.
> 
> So that accessing process is killed. Why call action_result() with MF_FAILED?
> Doesn't that indicate we poisoned another page and the recovery attempt failed?

What I recall is that, "recovery" is reserved for page that is clean, 
isolated, and even by chance, unmapped.  "failed" is reserved for page 
that has been(or might not?) removed from the page table, page might be 
dirty, certainly mapped, etc. A SIGBUS doesn't make recovery an 
automatic success.

Others please correct me if I'm mistaken.

thanks,
-jane

> 
> Thanks,
> Kyle Meyer






