Return-Path: <linux-edac+bounces-4694-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C8B37CF4
	for <lists+linux-edac@lfdr.de>; Wed, 27 Aug 2025 10:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F983620D5
	for <lists+linux-edac@lfdr.de>; Wed, 27 Aug 2025 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C901F3314A7;
	Wed, 27 Aug 2025 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YNCYRzm8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YFoYQzzv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF12F83A5;
	Wed, 27 Aug 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282035; cv=fail; b=PvXFYHMEaAPmT4/AsNYhFtHkfGsU/KywEg3hkt9Adli1pMwxy08zQGaX9pyNrDhjX8fB4pRykvCZCUO1u+9k2+UW7elMVf5U2n/ERhGAWbwefBfb6qnDn3Bogkc6p4tc45CuA4mcuykRpQrpHaAaXnffVEYT0XdRLQTo3xs7cC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282035; c=relaxed/simple;
	bh=thp9NrixJk+rumMAS9+EVEQmtCL9O1jVH4/tBG5hx3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bPHUilIKthEFnNqz4z2Na3I4WNkGXcNF5OTLJjgKieCVwxycuKCtlL/xZrxREJINtR4sVwM1YR/9XgzD1OCwNjHQbqjgGnUylWYjOTRHYN3y+9g2/f8RR+EFV97re6z4teOpODlLq0IB7sE99mG1SOSWSvXdOFVue7FIYjR+7E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YNCYRzm8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YFoYQzzv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7u6tS008675;
	Wed, 27 Aug 2025 08:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2se6PluAOao52QurTxkmC77qaHSdhQ5LBfc4wQZ88n0=; b=
	YNCYRzm8aRMEpN3blQhFNgnZ/D5yOiWm7Ytp+wXgrXFiCQDTpyePaVNIqA9nEXYa
	O99+SxT53gI8Ci99el+IK5rqMqgFFgxBvF0zFPdtzQfYs6AFCVYXVTJK6pBzLS61
	s+SLbnbwgo5QSZwKjmKMebb61hJ2Pv/xVL/eTHXRHT2FSEkZDi/W+pAiteFVdU6U
	389eor8L+9MCALeDSK8SVhmS7MYK5Fjte2HhNFjRxn0J41EMXGKvnejuIdTGSxrR
	VozO8nZJswQqhVWSjPy5WHo0Ju9BL9wDOFosgZb0fotNgX1U8z1k/8XeXkIDWNg/
	kpcQwjuk9lDoE5KXGSiEDw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s5xxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 08:06:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R61wT3012169;
	Wed, 27 Aug 2025 08:06:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43ae0t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 08:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS0JDvmCKSKcuFd2f5wyJkowaeTtDaYvjLZP4w1bjsy8ZedzWFwaW/uCxT6OjSHDUW297eOAc4B/gxKtv5OZxgkYXRcIx67QU8ToAtYd2VI7i4kXhtbo1nWBYHh/wZbZpdiAbBrCDVNq/isKPqA78x1Qdo12FRL/63HTatnuSL6/DWnvTiHt2wYym2mRjO3OH2IQyTgFSeD4xaQiT0UKAtMY2/AJOJroJq9kRq/tbCde7fpyshKGP56td3xU0lNimnyG/PKgb3zatjqtwJl9cN998DMXrt3wYc5l5Rw0ebcHMijqSCJFAf7h1WLH//8tOTzy+6kZYVNnQfK5HImI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2se6PluAOao52QurTxkmC77qaHSdhQ5LBfc4wQZ88n0=;
 b=vPDtAVnBgQJ5NReqOFXzA1gFu0QIfHsL0yC4qUoadMtqnAepYUJqp4UNVm1I+b/UMoTF9g1znvEoa//xY/jnVbYOkAVrA2aIZ6fhKukM6CWbeqDoW8qvvpsQOed0+f0DEf8DgwWER4Iky0tGyuV75gaSnU3scvhtYmqzSrcSDsMkv7rIFQTzj2y7LV/75K7TSUzGkeruUSiCXs/AjctbHQBFRnrUG9xVuIescXlh2aKOQbv51zaX/1uzm4h1y7xoQuDtBjjotFWve7VMZv/DnD/bkxHVOGh95q9apb4bwf+mPOBdm8T5MWZNC4OSsBq+kFuDj9IlpnSLgFg2PFJyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2se6PluAOao52QurTxkmC77qaHSdhQ5LBfc4wQZ88n0=;
 b=YFoYQzzv2uvLAvzVEey0rHLJOKsOhy7UOwOp4bMosfuJAWjLqCljH/oxrgf5n5RnFx0DQgLaz9w3/0d4WXkRwr/hNhVSxZk+aWkQ8Ny15eQY3hyym3nULzjorOxPRpOgcOKSnbfGKjclPeSMI4hjnVV5weJi5dT5HLASt4pcFd4=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Wed, 27 Aug 2025 08:06:21 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9052.017; Wed, 27 Aug 2025
 08:06:21 +0000
Message-ID: <3d595920-d3c6-4b68-88fa-3b5639207121@oracle.com>
Date: Wed, 27 Aug 2025 01:06:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on already
 poisoned pages
To: Jiaqi Yan <jiaqiyan@google.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Miaohe Lin <linmiaohe@huawei.com>, russ.anderson@hpe.com
Cc: akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com,
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
 <714d066a-a06e-4b49-b66f-68952c6520d9@oracle.com> <aK4Ksy872gR7WuQF@hpe.com>
 <CACw3F53dULMH2UZLz8SR2GMuGTmjC-u9Mvomzi61oejeLEn3_Q@mail.gmail.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <CACw3F53dULMH2UZLz8SR2GMuGTmjC-u9Mvomzi61oejeLEn3_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: 59908a07-5ce1-4cfa-21dd-08dde5409bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGJmT2lKUU41eHdXb2ZERk9iV1VSTU82cEd3VUxVTit5aWVRem5DekFTd2xS?=
 =?utf-8?B?d1FYZ0Jvb09JNmNkeEVhSTIwcC9yNW01c2R0ejg4QWd2R0N5VStFR2s4TEdk?=
 =?utf-8?B?TVBNWCtQbHRQL1J0RWVlZmZqQUpmV1R5VEtPOGZNMkJoamExMUxIK0paZHpk?=
 =?utf-8?B?UUk2czVScVlaRUpwTXJFR3NUWnI4OVgrcDkzWVVoWk1uQ1NkMno1ODFZdFhZ?=
 =?utf-8?B?Y1lBTGg1WXVzSzF4WDRPQjRWVjBHR2thRDl1WGhJRWI2cmhjWEFlYkF3NEF2?=
 =?utf-8?B?d09jR1BmYURIMVBlY05aYVVjYkJvMHZhRTJNUkJKNjVzZm1tYndMdWJtQnJy?=
 =?utf-8?B?M2htbnYrZTZJY3FpRkNyZWFYNTQ4YzlJb3ZYbm11VlVBU3V4OUVGVTg2cVFL?=
 =?utf-8?B?cFZISmtTamFXYmZnK1RTazlOdXo2ME0zZEVENXVTTHdHeVJvRk53OXNBWHlw?=
 =?utf-8?B?WkpaTTRGbEdrVWgzMmp2aitPSjlPWDNpR3BoSThTQU8yUDBUdFUzT3R5Wmc1?=
 =?utf-8?B?bmI3Z1FGQ21aRUx2Q1FOMkt2aHJYbEVRMWRVUkl5S3ZLajZhYlphY1lnejc0?=
 =?utf-8?B?MEFvcER4cTdKRVhiazRJQjlGNTg5bXR6cDJtdlJsUGJMTmRSUWhoUnl2ci9C?=
 =?utf-8?B?Vk9MY25rTzB2dkxMTU11YURSOVdaUHppWnI5ZWNlbFpVMzNSSXpBbTY0VlFM?=
 =?utf-8?B?UC9PV1pRZ0trUjgzR2hJY2xycTBWYjBudnVaRTE5dFJTMDZTUXBxQ3NiaElG?=
 =?utf-8?B?ZUNXVTFTMnUzaHJqR1pVZG42emU4eEROdVozM0NlekpEQmlXNEdETzBFRHJR?=
 =?utf-8?B?dlk1cFJtNVFjK21VbmsvKzdIejhOeG53MEI3Nkc5ZFc0UXNQSUlWaXlOaGJC?=
 =?utf-8?B?L21SeVc2dnlleDlUZ0tJQlQzZnJjdFpGR0hvUUVDUG15cEtQSm0ycXV4ZURF?=
 =?utf-8?B?UWhJd3RsK01yY0xVSyt3ZEhZcWU1bW54aDhMRDRVdSswbU9CMjlpcTEvSmxv?=
 =?utf-8?B?bDVLbVhtYzNZYnNWNzl0YkhaM1d3YWdWZUZWSTlRMldkQmVvVUNrZnZYZnl6?=
 =?utf-8?B?V1JDcTJOam5RU2QydGVGWE5NZWcrNkVTMjl5bmVOZS9GZFF4WmQzS0JsZ1BQ?=
 =?utf-8?B?MHZncUZNODFNQmlVSDZyVkxhTVNNK0czejVmUm9QNFhYQS9lUWhnbHgzalZv?=
 =?utf-8?B?NjZzc1djLzRLWWJEbXdCNDVmbkp6ZlZXTXNub1p6cDRGQ1ZsTDdhRnJuc1lF?=
 =?utf-8?B?NzF4b00zWEJxVkIyVHE2bHQ2ZXVOMEpsR0dMNERuRTRFaW5XZ3J3V29Lb2g1?=
 =?utf-8?B?QXUwSUlNQXZ4ZUk5QlpUK1BhckovcWFGQWpTTURqcGlLdnF0UEZmZGhueUFI?=
 =?utf-8?B?SnB4akdVOWowVTk0VTZIMFN5dUNZdXQyNkZDNWovRnpiVEJVR2ovNk1Gc3Y5?=
 =?utf-8?B?MUFMWDcxMW1WWEEwK1ZPNjY4VUFhQXY3WUk1ZDhTZTdQMWFOc2ZJTjhudk1p?=
 =?utf-8?B?ZXlEN05nSDR5NnZjZkV2eWxKdkZ2SXBob1RKSXJrRzlVV1MwbHhIZXRnTDF2?=
 =?utf-8?B?MHB5M0Zic1FER25SNEt6ajJrbW44N1MxVjNZQlhRQ2UzZ2wydVVFZVZIaFRq?=
 =?utf-8?B?UUlHMG14S0tMQ1h3U1JFT0h5SW5ZZHk3TEdiNzBTOEhZSkpOOEgzUEJWeVdi?=
 =?utf-8?B?Smo1aktIM21aNHpSUFUwY3FjNHdWV1RXcFJHcXhQODU0Q0VTTUZYWE96K0tB?=
 =?utf-8?B?MUIyeHovQkdoTzFZK0VSOGJ1WTBHNVVndlliT3pDdEIvYkl5S2pmbkRueXJj?=
 =?utf-8?B?WTUzM09sM3JncTV3d0FQRWEwdWxhc292OHdPVTdkenBEMTVhL1kzckhDM2Fr?=
 =?utf-8?B?bnhCQlNlemUwOUlWVklIK3FvaW9xaVU0eFB3bDljUGZST3pVY0JxQjh0Q1pQ?=
 =?utf-8?Q?FKhAvy4Lxn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUVXZ3AzM1pNbTlwSVhaWVpmQ3MvZTdMcUJRL0NpZVpLckNQbDNxTE1iVnN2?=
 =?utf-8?B?dVFQWTBkbVZKaC90UytqYXlRb0E2SFUzTEFxdDhCd2ZoK1ZZZDJmek1qbnpM?=
 =?utf-8?B?YVIydW9rb3BSajZHL3N3UnovZzlJZ0R4N0s2VjdpazErS09KdGhMb1F6Nitx?=
 =?utf-8?B?bWxDS1NtdHZ6N2t2QThWTGE0VVdFWVk0NGc1VW5sUmxGL0orY095T1FOSC9O?=
 =?utf-8?B?a2dITU1nbFZITFlaVCtwaG5NL2lBWERvUjloZGNqM0huMk5FYkx3RUJ6TWpW?=
 =?utf-8?B?eHNmRmFUdDY1YTFQNnpBaTlJOGFtQ0toaFpLWEY2RE5LTHNJb284VlRON0lV?=
 =?utf-8?B?bkFMN1lOTW9EelcyNW0xVWZxT1IySVI1UUlmaG9jNk9KcUs0OEFPQzRYWjFQ?=
 =?utf-8?B?Qnp3SmwyWGxuUDlsc2xYNnZZVTY4eUkwZE1sVVhRRHEvd3YzREVQcWE5NlZy?=
 =?utf-8?B?QmIyTGs2RTRReDZGMjZkd0NLT1ZSWk0vc3Y0NlVIZ3FGNElWQXQxZG5aWnpU?=
 =?utf-8?B?ZTF3dEdHU0VURjZFKzNWTldUak1WUHZEcWVnSHZGeU1lRE12VDIzMUdnaHF5?=
 =?utf-8?B?Q1JCUmZkQ28yU1Y3TzZIc3RJNUl1ODJ0MlFNZW96aEdRTkhKcXZwK2RaV24x?=
 =?utf-8?B?VjBNRkpQYnFiNWFBTlVpS3NDVXZvdEM2blREdDZyeVBMU0pMZmtNSktITk9a?=
 =?utf-8?B?eWNTK0VySW9XRXFLZmU2VUlaMkZXUnp4SUtoRkxoNXNmSmEwVlk3bkRtcWVa?=
 =?utf-8?B?b1NhdXV0WnVlbjY3bm4rSG9id3FmT29uNlFRaFF3S09IT2NpMmMxMTkyN3RN?=
 =?utf-8?B?VmhNYVRmMXNSYjNxN0VEaWZXYkVnR3lwWTNYZTVjUzdsNGZDbDNsdkx5WE0z?=
 =?utf-8?B?RDNmeG9UMWFtdjQxaG9oSHMyWlBFaHBaTnhVY205RGFWS3R2bWlHQzNLVllh?=
 =?utf-8?B?RGF6QlIvTE9QMzc2OUc3YXAzY1crdTZxRnFzK0RsUE8zMHRkVEEzYkF3eUxW?=
 =?utf-8?B?Nkp4WExWZDhGTjlmUXhTNXJOVXBEV3oxNHhwQXBBekM4dnVkUnNVRTNMS1RO?=
 =?utf-8?B?RDhWQkNqVWhRS2JWQkhvbVRKeTlyZTZpekx1M1VQRU4xVGJHTGRWTmVFY3FG?=
 =?utf-8?B?bkcxam1XcmtmQnZYbVhUN0VGWmUrYkhMU2tTTFlSTStGNmtQcG1VL2gweE50?=
 =?utf-8?B?d20vNVdBRVFsMlViVDdWYWoxMW1RaENYcjBKNmpycUxzSmJjczgrWjU1L0Rx?=
 =?utf-8?B?UUk1ekcwVTluekliWFRPZHJNVkVUZkpLazV3WDlvOXNReFhQTTRMWXBqVW40?=
 =?utf-8?B?UXlqUlRRcHpERVEvQld0USs4YVhlSDQ4eDI2amNzT0VvOVMyTWtmM1A4aDND?=
 =?utf-8?B?L3VCblk3TEh2UHF6TlZhRE10aHVyRUFKV0Z6UjVhNjh6TE82UkRlb3h3aTdy?=
 =?utf-8?B?Tjc4LzRpN2ZPSUlOaWkxYjRJVi9LY0RmOGtiTHAvVHRrbjZUSVZNSnZOTnNk?=
 =?utf-8?B?Vm1lbzhLQmJKbVNwYTdtL2hCMHMwbFV4ZUpkcmVzMHV1UWtyQlJYSmQ1aVZI?=
 =?utf-8?B?QjNtYndFTk1WN280cnhnYU45Q2haRUNiRFk2MWkzRlllcXY5R0JOWmdSS0RC?=
 =?utf-8?B?bzBMY0RPZGdZK05uczJPOXdDanp6NlMwVWhUY0hyOUp3RjhnVnlSajNIMnd5?=
 =?utf-8?B?d0pvVlN5VGY5VjNQYTVVQjJZcjl2bUZiZTA1N254Y1FvZmYzTUlXVGxLOXBv?=
 =?utf-8?B?RDk3VGN2SEsyNWVpdTZFZVFnaFdaZTh2dFoydlNnMEFJL3p3RDBmaTZ3QzFk?=
 =?utf-8?B?UFY2UkNkMFFodWFVVUhrTU02ejRxb28wUmNTR3dJRUZ6ZWdtelV0VUJkamF0?=
 =?utf-8?B?NXltODYrd3dQRG0vSlBjRDFNbDFCdWMvOGRxdWZWeWl2UGp4KzZweVA4ZUF1?=
 =?utf-8?B?V1Fpa1UxOFFhKzdDUWEvZWFheC9zSUpiUjgwYk53MWpTV0ZNd1NsZXlIQzZG?=
 =?utf-8?B?TlNGcXVFL3BHeHY2UWh4cXZKNTh4cGhSZjQyZmhDbDkxNDNTUVUyYUxHUUhS?=
 =?utf-8?B?YXlnR2V4cmkxcDc1YklvQXMyNXRCd1VZNEg4bGRHU3cxbUplT1dseXQrTTZK?=
 =?utf-8?Q?hAhFd2FT6s5ES2p8wuW3RhM+c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PYR1hYobM8n3fjDfVGR8DqaYbaY1sNEfsyX8bLGX5eA//2t2oH/LXF/8K0olsGbvEBxiVIVBFYpRJkVwppSzBHZrwmg0TdqjGxCjxdOTQIpTRIJ9/qy1VHdrhWU2xvD1dnx5rr/UJ93pv6pNM5vD02rKcWsX9t/V7eFolPKEpyRFADoK8sd1Q47MLBcebQGWeRTnWoyJsk++P97pVdOv8Oj/946O5Q9viqtBiJOBrsBRv7Un8V2m2Q8HqUoc2KgAPDerltKi9Q8AFsrWZiZqCIJNcT4splm+DJsOStb0uvKSVmgryqBdvKVXqQFsJ8uQ3RZPVjU8M8yVUULXtX6nfT/eK/LT9P/fvwF4q8Ib6N79He8kYQUgctaXfvJl9XFLeCITbBHxkv8JbQ2SBnVFemn2MhBJkE82/ZYji64rg2MPpcZ319oDxB5lzhpSQokrzOgX3yZZErtCnTmljM0mNvVxLUlG+iqpdrueT8z4+/W4ycLqQJzkXqM5v2eW7JuICMlR3QyWJuT6fsWsZMfMjGTxakiPA9WZQY9jo6p40vpTcRXSUJtUo+mcSEIgg4AA+eD9DESyQR7X98Hg854Ofbvbt9tViYPuD+UlYKPyefI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59908a07-5ce1-4cfa-21dd-08dde5409bc6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:06:21.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyKctRSSVvf6Jmx+petawfoo1EcVNENGeTfNx78rd9ZVu9i4M+bpDWjft7gmxeQu74bW3b7x+cf3iheCxVdsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270067
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68aebc81 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=MvuuwTCpAAAA:8 a=yPCof4ZbAAAA:8
 a=1XWaLZrsAAAA:8 a=GAVOIrOOkzTXngZ7IxQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12069
X-Proofpoint-GUID: yp7UnAoKM6eMu_q-My2ZIwxjz6tRlpft
X-Proofpoint-ORIG-GUID: yp7UnAoKM6eMu_q-My2ZIwxjz6tRlpft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfX5ClTuXlZCBhI
 5DolPseMYW7FBFXiiQmoJi9ASaq0s1zrRpVM7hWgs9G5KZjKCHpTRmn9i2iRxj+q3Fqi2yZJPbN
 9vocKNMKp5cuxy72/PSxl46eWMDVlyaD72kpwpzAfNF3dG3gBvoZsgEl7Suf1expNAF9ryOJAJY
 +zzhvSVu4lfCKOvgorwfHbl+/V1ztVmqVNm7IaLOBgAUjx+yOD6wIRkU8Bb7yMUwSlMEwiXGy+N
 ti/pbPfNPeq9E/JpnuaGa6WOUZ09WYxvckupZfBWeSdAngQCFOtYaVKtQLmmxXmZFe39HW9AoE+
 VK51h4B+D59gmVRznJfG495GXgLqLFbdyVBgAdi3CckfLOJ0y5xwP5aCrvjSXk8zCoCU3j1x0JI
 dMKD/A3rZsMKn4LlmDawYYjaF5Olzg==



On 8/26/2025 2:22 PM, Jiaqi Yan wrote:
> On Tue, Aug 26, 2025 at 12:28 PM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>>
>> On Tue, Aug 26, 2025 at 10:24:07AM -0700, jane.chu@oracle.com wrote:
>>>
>>> On 8/25/2025 6:56 PM, Kyle Meyer wrote:
>>>> On Mon, Aug 25, 2025 at 03:36:54PM -0700, jane.chu@oracle.com wrote:
>>>>> On 8/25/2025 9:09 AM, Kyle Meyer wrote:
>>>>>> On Mon, Aug 25, 2025 at 11:04:43AM +0800, Miaohe Lin wrote:
>>>>>>> On 2025/8/22 8:24, Jiaqi Yan wrote:
>>>>>>>> On Thu, Aug 21, 2025 at 12:36 PM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>>>>>>>>>
>>>>>>>>> On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
>>>>>>>>>> On Thu, Aug 21, 2025 at 9:46 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Calling action_result() on already poisoned pages causes issues:
>>>>>>>>>>>
>>>>>>>>>>> * The amount of hardware corrupted memory is incorrectly incremented.
>>>>>>>>>>> * NUMA node memory failure statistics are incorrectly updated.
>>>>>>>>>>> * Redundant "already poisoned" messages are printed.
>>>>>
>>>>> Assuming this means that the numbers reported from
>>>>>     /sys/devices/system/node/node*/memory_failure/*
>>>>> do not match certain expectation, right?
>>>>>
>>>>> If so, could you clarify what is the expectation?
>>>>
>>>> Sure, and please let me know if I'm mistaken.
>>>>
>>>> Here's the description of total:
>>>>
>>>> What:               /sys/devices/system/node/nodeX/memory_failure/total
>>>> Date:               January 2023
>>>> Contact:    Jiaqi Yan <jiaqiyan@google.com>
>>>> Description:
>>>>              The total number of raw poisoned pages (pages containing
>>>>              corrupted data due to memory errors) on a NUMA node.
>>>>
>>>> That should emit the number of poisoned pages on NUMA node X. That's
>>>> incremented each time update_per_node_mf_stats() is called.
>>>>
>>>> Here's the description of failed:
>>>>
>>>> What:               /sys/devices/system/node/nodeX/memory_failure/failed
>>>> Date:               January 2023
>>>> Contact:    Jiaqi Yan <jiaqiyan@google.com>
>>>> Description:
>>>>              Of the raw poisoned pages on a NUMA node, how many pages are
>>>>              failed by memory error recovery attempt. This usually means
>>>>              a key recovery operation failed.
>>>>
>>>> That should emit the number of poisoned pages on NUMA node X that could
>>>> not be recovered because the attempt failed. That's incremented each time
>>>> update_per_node_mf_stats() is called with MF_FAILED.
>>>>
>>>> We're currently calling action_result() with MF_FAILED each time we encounter
>>>> a poisoned page (note: the huge page path is a bit different, we only call
>>>> action_result() with MF_FAILED when MF_ACTION_REQUIRED is set). That, IMO,
>>>> breaks the descriptions. We already incremented the per NUMA node MF statistics
>>>> to account for that poisoned page.
>>>
>>> Thanks!  My reading is that these numbers are best as hints, I won't take
>>> them literately.  As you alluded below, kill_accessing_process is applied
>>> only if MF_ACTION_REQUIRED is set, though the page is already marked
>>> poisoned.  Besides, there can be bug that renders a poisoned page not being
>>> properly isolated nor being properly categorized.  If you're looking for
>>> something precise, is there another way? maybe from firmware?
>>
>> Firmware records the number of memory errors that have been detected and
>> reported, but it doesn't record how Linux responded to those memory errors.
>>
>> Checking the ring buffer, the amount of hardware corrupted memory, and the
>> per NUMA node memory failure statistics is a simple way to determine how Linux
>> responded.
>>
>> Since commit b8b9488d50b7, that has become unreliable. The same memory error
>> may be reported by multiple sources and now each report increments the amount of
> 
> To me this multiple counting is an existing issue, and what Kyle
> originally targeted. It seems to me that as long as the
> mf_action_page_type is MF_MSG_ALREADY_POISONED (or HWPoison flag is
> set), action_result shouldn't invoke statistic related ops, and
> mf_results just become irrelevant (wrt
> /sys/devices/system/node/nodeX/memory_failure/*), right? IWO, we can
> decouple the two issues:
> 1. how to update statistics correctly?
> 2. what log msg to show for recovery result, MF_FAILED or something else/new?
> 
> While Kyle fixing issue #1, can we just keep MF_FAILED as is?
> 

Sounds good to me.

thanks,
-jane

>> hardware corrupted memory and the per NUMA node memory failure statistics. Isn't
>> that a regression?
>>
>> The per NUMA node memory failure statistics might not always be 100% accurate,
>> but this issue seems preventable.
>>
>>>>>>>>>>
>>>>>>>>>> All agreed.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Do not call action_result() on already poisoned pages and drop unused
>>>>>>>>>>> MF_MSG_ALREADY_POISONED.
>>>>>>>>>>
>>>>>>>>>> Hi Kyle,
>>>>>>>>>>
>>>>>>>>>> Patch looks great to me, just one thought...
>>>>>>>
>>>>>>> Thanks both.
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
>>>>>>>>>> but changing action_result for MF_MSG_ALREADY_POISONED?
>>>>>>>>>> - don't num_poisoned_pages_inc(pfn)
>>>>>>>>>> - don't update_per_node_mf_stats(pfn, result)
>>>>>>>>>> - still pr_err("%#lx: recovery action for %s: %s\n", ...)
>>>>>>>>>> - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
>>>>>>>>>> in memory_failure and try_memory_failure_hugetlb
>>>>>>>>>
>>>>>>>>> I did consider that approach but I was concerned about passing
>>>>>>>>> MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is a
>>>>>>>>> bit misleading.
>>>>>>>>
>>>>>>>> Based on my reading the documentation for MF_* in static const char
>>>>>>>> *action_name[]...
>>>>>>>>
>>>>>>>> Yeah, for file mapped pages, kernel may not have hole-punched or
>>>>>>>> truncated it from the file mapping (shmem and hugetlbfs for example)
>>>>>>>> but that still considered as MF_RECOVERED, so touching a page with
>>>>>>>> HWPoison flag doesn't mean that page was failed to be recovered
>>>>>>>> previously.
>>>>>>>>
>>>>>>>> For pages intended to be taken out of the buddy system, touching a
>>>>>>>> page with HWPoison flag does imply it isn't isolated and hence
>>>>>>>> MF_FAILED.
>>>>>>>
>>>>>>> There should be other cases that memory_failure failed to isolate the
>>>>>>> hwpoisoned pages at first time due to various reasons.
>>>>>>>
>>>>>>>>
>>>>>>>> In summary, seeing the HWPoison flag again doesn't necessarily
>>>>>>>> indicate what the recovery result was previously; it only indicate
>>>>>>>> kernel won't re-attempt to recover?
>>>>>>>
>>>>>>> Yes, kernel won't re-attempt to or just cannot recover.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> How about introducing a new MF action result? Maybe MF_NONE? The message could
>>>>>>>>> look something like:
>>>>>>>>
>>>>>>>> Adding MF_NONE sounds fine to me, as long as we correctly document its
>>>>>>>> meaning, which can be subtle.
>>>>>>>
>>>>>>> Adding a new MF action result sounds good to me. But IMHO MF_NONE might not be that suitable
>>>>>>> as kill_accessing_process might be called to kill proc in this case, so it's not "NONE".
>>>>>>
>>>>>> OK, would you like a separate MF action result for each case? Maybe
>>>>>> MF_ALREADY_POISONED and MF_ALREADY_POISONED_KILLED?
>>>>>>
>>>>>> MF_ALREADY_POISONED can be the default and MF_ALREADY_POISONED_KILLED can be
>>>>>> used when kill_accessing_process() returns -EHWPOISON.
>>>>>>
>>>>>> The log messages could look like...
>>>>>>
>>>>>> Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: None
>>>>>>          and
>>>>>> Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: Process killed
>>>>>
>>>>> Agreed with Miaohe that "None" won't work.
>>>>
>>>> What action is M-F() taking to recover already poisoned pages that don't have
>>>> MF_ACTION_REQUIRED set?
>>>
>>> The action taken toward poisoned page not under MF_ACTION_REQUIRED is
>>> typically isolation, that is, remove the pte or mark the pte as poisoned
>>> special swap entry, so that subsequent page fault is given a chance to
>>> deliver a SIGBUS. That said, things might fail during the process, like
>>> encountering GUP pinned THP page.>
>>>>> "Process killed" sounds okay for MF_MSG_ALREADY_POISONED, but
>>>>> we need to understand why "Failed" doesn't work for your usecase.
>>>>> "Failed" means process is killed but page is not successfully isolated which
>>>>> applies to MF_MSG_ALREADY_POISONED case as well.
>>>>
>>>> So that accessing process is killed. Why call action_result() with MF_FAILED?
>>>> Doesn't that indicate we poisoned another page and the recovery attempt failed?
>>>
>>> What I recall is that, "recovery" is reserved for page that is clean,
>>> isolated, and even by chance, unmapped.  "failed" is reserved for page that
>>> has been(or might not?) removed from the page table, page might be dirty,
>>> certainly mapped, etc. A SIGBUS doesn't make recovery an automatic success.
>>>
>>> Others please correct me if I'm mistaken.
>>
>> Thank you very much for taking the time to explain everything.
>>
>> Thanks,
>> Kyle Meyer


