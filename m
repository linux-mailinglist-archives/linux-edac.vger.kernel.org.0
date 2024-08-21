Return-Path: <linux-edac+bounces-1719-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC6595A4C0
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28141F236A4
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F69157E62;
	Wed, 21 Aug 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="orH7mHg1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gvtzoiOx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0C1D131A;
	Wed, 21 Aug 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265339; cv=fail; b=MeszZJTOl8olwNDUliSaKtIIoVfjyGn0JwtL0VS/UdEpDNNndNJPQg2NOpgJDRSt9icHIP0jWlq23hbLCcQIGrAL9KpgtFXUld/Jbzyul4JHmBHF1rgob/NA8xHbUf8JTO6HcL2LAE7YlG7DwuaZPCGuQ1hJU48K4IWzD7CVgw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265339; c=relaxed/simple;
	bh=j9xgVT++wjVffTcPhPLJxe1q4/H+M/LRlzcZHB+n2Pg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iZ1uUxU7RsndIB1Sej8h+8nEtrXE7nJA2gD7V27qZNZeIm0iFCJaFt5TOzgEHitE98fr4V0IH/fLwoCKg3XojMj7IMbIB7y/lP5sunVPZHriMwMTjM4T09sHzt/p+Glg05EIGNyxhe/wqb0gFHCDjtdny+77xTJP8IKnRuUucpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=orH7mHg1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gvtzoiOx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIX7G000944;
	Wed, 21 Aug 2024 18:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=VSkRC+rP9zdWwIreb3gHq+mEzmHYQd/Z09xKvIRR93c=; b=
	orH7mHg1kGzvM0w78C+YuYNR8rHLI1P2Qw+SuGhcRg/J6kdJq0wyVMpfB98Ruaun
	anTHV5acoY1q8gR+EzrD25ySp5OSewU5PnhgG/ZS0xPtJOayCE99/FUFnCeKLMOr
	biPTucHKcKPbPVsQcIMdj77W4QrRlfdqJdKA1GdOPpItA1tE1TfHw91pJHaNxrcv
	hkBMYP8Vnz24vArChFhr/H/FWHKXL0m4PmTX5lMtjO/d/FuQ/uofNLXO2ZUWvRoA
	JWpSFuETc0ue9FQMtoJJEfxF27K7qrAFsDZN9K9877ZtjfSheLPup0pHSHbKPtYM
	b6X65uGit966oUxW/HTsig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj2hxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 18:35:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LIXtcf004726;
	Wed, 21 Aug 2024 18:35:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415nmhr1ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 18:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T03wizVROo4SgcOXXan7gcHoWoCTr/SnRqpMBab5fQgYdefWR8LF1m93/GbPw+hG5WP6O1SM4KNZcZCZMrIsuqcw3bB3NPV6BUqkznMoBZEfxJlpdQwcajLLrFedQqGinO4z0kDYDHi8chveYJDiOpO/H6ZXCHn+1tJJkRe+jmoQ8Q+ZZ/8EShaDKQ4tzhaIU2n2Frxme0gcXzqWK5IS2XwVar+2FEw09k+3DnJURfrY4QxRdbVZ4BrV4dzgK8m1zJtgmgbrG6T1ak/7xU7OQF9N7FSBpPQg233KivSbvrla/PboeZv/UJL40qM0syQ+MUaPjQKI7EPUA5RXugfUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSkRC+rP9zdWwIreb3gHq+mEzmHYQd/Z09xKvIRR93c=;
 b=D0FOg+RJFpRmJ+C51mSalD8jceZiPvGL1lEqPRS5rId7HtyWMF128W0yMUgLuuPVLEp3pwQGqyvMUseO+pWyvthtrhPVg+rdcAd1jkQxJ7SiG1szOawP8DZambb2Vn/3uP3z1BRatw0d5Y0HdsKqEhtdL9cOSXzxml6WGyrs3lKOQLo0ehhvpKtPpuGcYxyO+dTQwd483NY27PEYwzADS0pmOv0dHNpOq6jh3rxi4ZXVda/gD8v6de6JpVxXmS1hbaJ6p0loSYbQzVJr8IS6XACBUEydket2d/mxFxIvXCT2d2HEqeiOX81wwwwH8P5yjJFxYeMq4eHmG8XFY4XDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSkRC+rP9zdWwIreb3gHq+mEzmHYQd/Z09xKvIRR93c=;
 b=gvtzoiOxcnLVtzpSJe4oVLCdysQI+q6vZIe0/pl3IZb/tOW4Ix76cEfx2eu1zd2DcgNSvE+vM6PicwT7JEFwSgJdYL2ho9POnwXdtyI2i+9qvAk8EesST+03DWDkr/K7dcAQleMVd1WRTwREOf/gR+SLJUasD3zGvHu/k6sQgss=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 18:35:27 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 18:35:27 +0000
Message-ID: <2eb4d710-fc8a-4210-a681-666a7ce1afe8@oracle.com>
Date: Wed, 21 Aug 2024 14:35:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/MCE: Prevent CPU offline for SMCA CPUs with non-core
 banks
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com
References: <20240821140017.330105-1-yazen.ghannam@amd.com>
Content-Language: en-US
From: boris.ostrovsky@oracle.com
In-Reply-To: <20240821140017.330105-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:408:4c::46) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|MN2PR10MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 66404efb-878e-470b-7404-08dcc21006cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ukp1UEdHcXR2azh5OXVnQ0VLMTQ4c1FEeXVVdlVvOEJ6UnZ6d09PYkd4TUhm?=
 =?utf-8?B?L2hJSzFGR3JMb0ZZTzJocWM3ZzdqRU45WGlNbVF4clFIcDFiL0l0VlJ0Y1c3?=
 =?utf-8?B?ZUtJUmFSUVJzMitySThPUCsyaDRIb2g5TDk0ZUpYdytQV0M1akZBLzJMSkRw?=
 =?utf-8?B?UkMzTWZnQ09ZQlJlTTh5S1R1cUF5elBWT1JXcHA4MzNwNFA1bHUxcTBVU2lv?=
 =?utf-8?B?cTN1aTYveU45RGcyOFdHaTRSZ2ZBMVNxNlFLZTlwVlNOZkUvR0hqS2ozdjR2?=
 =?utf-8?B?YTBqTXhLWkVadU5ZYUtPYzNtREtTU0N3TmVMc0JKaVprckYrc091ZGxvc0Yv?=
 =?utf-8?B?RzUyV1ZNTERsQ2czRnRNdkFLbzFTYy9QRGdRcWg0bXBXN3I0bm9YTEhpa1JD?=
 =?utf-8?B?NnRKNzV4Sm1uZi9wL0lYbFdRcllLbXdvcDhjemJ2NStTTVBNTmRPRTlLeDJP?=
 =?utf-8?B?aGVtQ0RBQjEra1gvdld2eUEzZzJoakJmSzNhR3pnV1hibnE0Mkt4WXFEd0dw?=
 =?utf-8?B?dVo1MzltZ01IZEVXU0tZTU11UGFaV015T2RsWUo0MUxMbiszQmZqYkFQaC9W?=
 =?utf-8?B?SHdXRTNocHVUL0Q3RzJCSHJ6L05Ielk0MjR0OTNaVmJoWS9XVXhHVmQ0TUJy?=
 =?utf-8?B?bkNhQ2QxMmIwR2d5YzBhMm5aZmtZNEhTSEkyRU5yNHpZN1pGeGtJLzVIWWhL?=
 =?utf-8?B?QVNna2xWK0lMQjgxMmZIRDBvZnI4R3JpUWk4elVCRmNxRmdyOTdWa2xWdmsx?=
 =?utf-8?B?VFZGeU9PNzlmYmpUM2poNm1QUE04Q1lGbEdsTk9kV2JxVXJNb0tIdVY0U3Uv?=
 =?utf-8?B?ckt1Y3NqWDJsYWZGclJiTm8wOFlEWDc4T3hnWERLd3NrRVZ1MTY3RVoyQWFX?=
 =?utf-8?B?U3FhazBOT2gzbFU0aWZERmYzVGpySVBXK1E4QnI1TDhJV3ByTGZuVWNjcU5Z?=
 =?utf-8?B?YitkZ2kwdFNLNGozakxzTkhubllSbDJMS1VRemNmWU1Idy9OQ0orNEhvSnF5?=
 =?utf-8?B?REpPMGFWQklxNTlYOWoyWVRrQzB3QVVrcjlPNVNybjRwcVlvNzJBMGxUVjh3?=
 =?utf-8?B?dE5wZG4vSzgyUkgxZXNtVTZNTEVDdFlNV0J1b2RPaU42eG0zd3pXODZlVm80?=
 =?utf-8?B?Vk9TZ0NMWUIwMnpnYlpWclB4OVpVYmF6b2xtYTc4Mnh3Mit4bHpaMTlEWVNZ?=
 =?utf-8?B?RFpWNkZnLytla0w5NGY2N0lkVTRiQzd5ZTViK3pWU1E2QXNodXV4dk1WYkd5?=
 =?utf-8?B?SlZMTWZUMjhEMzNIOG5FYTRGSUhXUUlpaFRMSHpWUU1jWHpsS0VyWUR0WWlq?=
 =?utf-8?B?Ujl5MUhTWUV1Tktwb3hYK1QxUmdrU28wbWkwWVh6L2ZQdFVsMWUxdVV3QTlW?=
 =?utf-8?B?anNEWVFxNGVMTmEyZzlhZ0l3OThnVzFLQlk0bjY5SGpod09KQnpHazBGcTE4?=
 =?utf-8?B?VFpmT0VhV3padDhqaThCTDVFNmV3RzlheXBRTzl1dmh2N1J6SnlRSSt2L2JJ?=
 =?utf-8?B?bkY5eGZ2dVV0RTlhRm5UOUlqa2VNRWR0M0JWRVM1ODkySzJ0MjltT1ltMmtE?=
 =?utf-8?B?aGFUY0I3b09LL2JMVTZSREY3SW14ZGdic21jdWVJMWV5UkxJdDV2aEZ3SUpm?=
 =?utf-8?B?Q2g2eE8vSjdUUUl5czEyakIzMmFKcTlOendzakQ1Vmd1OS9hZERKeHFBcmMw?=
 =?utf-8?B?b3RsdzNTRHNyNmY1NHkvUkRZTy9qc3pUbldIN1FuRDVXQ1krSW4yN3MxVEtl?=
 =?utf-8?B?dFZFei9IaDZzOEFJWlppTWthb0txczlzMFlRem5xZER6aTJrVldGYTRDQ1Zt?=
 =?utf-8?B?czVub3NqMVlWOTRoL2VlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnYxK1JyQXplcDRuVHJZK21BYlNVVnFPZUxVUkEzOGE2NmhGYk53NUZ6bDVi?=
 =?utf-8?B?bzUvazRYK21hTHhwN3hhQ044aFROQ200cFlZVUc2ZGR2emtnaVRkdk12Tjhs?=
 =?utf-8?B?OFluK01KTkNHeTlVL004LzFoelkrWXkwYmVTbUkvemp3ZE02LzVRejdXOXFF?=
 =?utf-8?B?Y0pMV0FsY3UxWURRb0ZhbnNEdG9Yck9JNVBSaFhoSlRSdCtNc2dYSVhoQkR0?=
 =?utf-8?B?c2FldDVlbHFFVWhQQWhnaHdhTkk4WFE4aHNmNUMwaTFsVlpKTER0akFpRWh5?=
 =?utf-8?B?U3h5QWoxTUUxVk4yYzRmRG5kTTUwKzR3dm4ycnQ3UkZXZFF2eG01eWUyeVlj?=
 =?utf-8?B?Zlp0UFp2Mm9namZXb1A1WVlIcXh1eXo4M2FNZ1UvS1JwRncydmRZTEdNdXB2?=
 =?utf-8?B?YWVQUlJ3TUFIaGQxbHplZVMrUUdVSWprZXdyMG5haUpWNGw1cDhnYlpTU2xk?=
 =?utf-8?B?bk1JbDR5dE5YOFpIeGlIOXJJdUYvVVN3UjVSMXZsQ0tCYWNxKzVNTWdGM2VS?=
 =?utf-8?B?emZYc3dPQXZpS2FwSmFUbEMrWEV5SmR4elFZREhRYVBzM1dXNTZuRXhBeEJm?=
 =?utf-8?B?YWIvTUY1MG4zMjhCa09pbDNHWDdENndBZWdqQ1M2RGhpdlF5ZUJwSTRIRGJD?=
 =?utf-8?B?TTRnNmxOOHVzTFNtM2RwSlFpc3JtVFJYaWNQUFFkcXZvQjVkdTBQWFo4NWMx?=
 =?utf-8?B?bWhNanVXRUVNRXlQaUx4Q1RIR0NzRTh5ZFppdnRidzY5cml3TGJkK0JSLzFs?=
 =?utf-8?B?b0FmeFAzYW5heEwwbStZSWkxdWd0TStvdnFBUStLaHcwbk9tbFpZRzhJODFP?=
 =?utf-8?B?VXJvbFlOVGRqL0hSVk9ESFAralU2am16WThXVTBjSGliNTBEdWd2dFpObGtM?=
 =?utf-8?B?NGtRUjNPckIzYklOSFZXV2ZBdWh0eFlLREVBSzVWbXNUenBKdHgrZVVlNG1i?=
 =?utf-8?B?KzIyWC9GVnJSTTdkYVBlZGZjZkM2bTRpNkVXcGJLWHlhYzI0VWNlS2dld3kw?=
 =?utf-8?B?TU9Wdlh5RGlMQXpGT0IvZEhUYXpnNWsxZVVxL1VxcFVCNFpqWXMvcWJhZGZM?=
 =?utf-8?B?UzMyY1Z5WWVWZFlwcit4K3pOU2xKcVlnLzZGZTJ6MHVSNlRsVEM1eGFSWUdm?=
 =?utf-8?B?Uk80QXpiREVuaGZXQ3kwQit0T2dTUkFzR0grQ1IzQmNUcG1jajcvNXhodW5u?=
 =?utf-8?B?aXhjVUQ5c3lyOFpJYlkyUkhFTnBvN3l0VDFkejFtS3ZLdnFBeC9pOFErQ1hZ?=
 =?utf-8?B?bldOLzQxZDBmN1Y5NlhwSSsxSjZ5WnFiUi8xYStwNTY1RDdPUTBnZU9MOGI0?=
 =?utf-8?B?Y3h4QU8vNG54cWZxTnBoL2JEMWZRLzJVajFDZXJ1TGU4eDI3dVFnQTFvbFlO?=
 =?utf-8?B?K2NjQlRvL1NoQ3lLTlMwcG56MnkrRDQ5bjVESlFIaDM5UHlJQzR5UVJWWmd0?=
 =?utf-8?B?QWI2R1R1bmJZa1RyUEgwcUovVmppZTFqVHprRG0wSDM4ZlZxNExBOGtJVUpm?=
 =?utf-8?B?ZW8wOHFZUkpEdkhCcGFabVJoVmR6dEN2L20wTkhGUDRhK0FmOUhydjVGazFZ?=
 =?utf-8?B?cnhLS3hYYVJQRnBQTFp0VG9IRmF5NDJKaDNzMXYwdStOdTJqaWVoSnJ2eWsx?=
 =?utf-8?B?M3JhUnAvYm5pTTZCRGJSa1hlU2JBUmVsWWhUeUJyVVBTV2h5MjFaY0xuSEIy?=
 =?utf-8?B?VERndTYxWFMrMnluMlNaSGpyYjZFQk1oN2htZkRHZWtQdVlSMkh1algrYndV?=
 =?utf-8?B?bVI3Z3o4VFlzOE9PUitna0duZWp3QW9DQUxZYTJNZVNjZm1JTnJjeXFGNlFG?=
 =?utf-8?B?Slo1cjVCcDNoYkRIaGYwVzNuTWtIR0VKbmU0OHo0SDdIV3hyR0hYRWNZWkx1?=
 =?utf-8?B?SUZlSDl6T3M1ZFFYU2VKUVY5WWZDSW9LeUFYWm1VNFRLVldqaHlZc1IxV3lj?=
 =?utf-8?B?a29yVVJtemdYczJJRFBUQTlYRWdudC9KNE1OaklWd1N1WVdnWCsycm1sUy82?=
 =?utf-8?B?UFhLOXJhOFhESFdSVncxWHg0VnprUUZMb09nNWlLM2x6T3p2T09VU2FaRHNP?=
 =?utf-8?B?QUNlY3ZJa0c5T0hFOW5vM2N2SVNxQy9PSzZ1cC9uSkt0aWZ2VnpBb1p2OWhC?=
 =?utf-8?B?WFovTmNZQURlb0V1M052bU9ob3N3aVhUY1hzRisyL3hKQkwxNDVnT3ljVTJm?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IBvMsKlGOJXvUnDZYBICW19TFPEh6B0WYkjnncLGfKW+cS1WLoc8FY+Bhki1Uo5tov3jWScfK2XF+FQxf1YBuenexyGQA06T/PS3OWmG/aQ/T5Zcr1UlqFm7QdrdZ4a5PbWqPVfjqZMTAkyC0GgBh60aR3yKKoDk/ED8kSAWPVW3JH3amNDC1CI2e+G7gzZ5Y90aOwpP3i0eSKLdySTSSfzpPIDZsui5jdECaRNE2GPvwSQFdA27qWBx3oxwzl84ZklMSpME8KnUdXx0DX1ge9TajESe7R0OcdKNoAcQSGbpswPZdzwHFW2lwN0Fo8WUEzTnAXYlanEqan9+T9JRdnhG/rjyig0dO2mUxE0LnJC8apYid+ZQoJ5VF9Y3/FvO8/TPDH9PCY05lBx2DKEAg4AyysidFNSuUs1x/36aPcknlPnFJ+LKFhfIJuBdLYI7+vweQSH6wGqiBmZ6lq3JmD59LR6F5sadRoyJh1zLDnX4C8EFSIZcSov50iDtfRWFZE9TN5c8xrqxwrogzlpzxMbHyuB/K7sB1nY4FYWX488YmaPNCAuyb7jIma2nAECqOnO19kqGa6Lkp4r2io8rxdYMLs2y8Nh8vAx5iygNmSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66404efb-878e-470b-7404-08dcc21006cc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:35:27.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5i47CCWf7eg0lKBncp1t1o8yYlW0VCsL/pZh9noc2tnILJp0b9d6wTklxlLSmTLp1AB5baaY3FB/slj0NOcg+5hL1HG44JlCspJDgRTLGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_12,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210136
X-Proofpoint-ORIG-GUID: 9d6ynw5A0kYCcvZ273WGTMB-BXfbfQqH
X-Proofpoint-GUID: 9d6ynw5A0kYCcvZ273WGTMB-BXfbfQqH



On 8/21/24 10:00 AM, Yazen Ghannam wrote:

>   
> +	if (!mce_cpu_is_hotpluggable()) {
> +		pr_info("CPU%d is not hotpluggable\n", cpu);

Can this error message be made a little more informative, e.g. that it 
is emitted from MCA code? And is info the right level? I think notice 
would be more appropriate.


-boris

