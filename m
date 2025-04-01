Return-Path: <linux-edac+bounces-3451-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1DA781D3
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 20:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB0D7A26B2
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E91CD21C;
	Tue,  1 Apr 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bIHKD/Mt"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45A13AC1
	for <linux-edac@vger.kernel.org>; Tue,  1 Apr 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530458; cv=fail; b=XOJZMx9kjHmiF6+7swVJL+ZBd/pM81Mpnk6YYYEQArEvZ2F6da4V9ogSEMfziKIKYLOj/waOi4wkvF/UBVhZOK2pOkWZ00c6eWdGPhPr68U94yIby+G527ibCMhvt7zKJaLzVGRIUhnWcXGfvNlMJrKcabXJybDIpJLqLOC1MBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530458; c=relaxed/simple;
	bh=Wkq2PLhsGk1PeENghSWXr/Cs0q9X2fkJrmzIgnG+ISw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GI2qehR3ZdL2Yv6tll3OriF2/xnSVqe4XQWZ+JMZcVEkzti9hm1BEDw6yg6Qd68fNs78O3GotKT/ZTEcNTQMWmeVHBSgTItq0lXrdgHYfawopRGjdxweSFa5qAPfkrHAWXWC3olcyWQ60AExV1NWsoS3G2K4yqMrdGGUbjwLyaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bIHKD/Mt; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVVmWms1HK1mutTZa8XmsKPTKMipCKGHKbGykhHNTVBXTGtFM53JcMv9u88pJjU83LpfUC0SJu5IwqT/IbhRqQm00TWnMNKA6aINuGpCsO1bVjK7fq60n01YfxIyOXjjkUyRKNBtvwVzSdV5C79dGqVMrWRn9jzfbOZ37OPeR1saH9h/soYlN3G/3t+fM6Y/hHWEIb4cfDF936g/CIRA43bcASYEQnWU0Q0iDHQ5nlXxrwgr+CQ3yf960LLjCqKSUsTnWb9YRncdsNEBW+WqEJ/Vb69v+GhDrsQWu7KGOCJUnPBXsEEFt65dDf+z46yDLVEpSNWOAxcGeydaAo37hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epF97rQzMSv16EIfgTHhDYnb1oCIunNHGJAl7sIwq0I=;
 b=pra2rUGKZ63cU7RVb6F9I2tQhGbJfARwaLEix4dcKXFvYugS7UJMsorEv19gTfTaH8OqLstfTNbgQmec8mcPl/KmrAyzemIFcNslVH1QGauQ9XFD268Cus11eaPVL0f9PZuBGemkkmvuc21CwBWCovWSLT0IO7nNlk6HRu5OVO17VyR4YTPzj/8HWVj0wwdVpTEZLUXrtkUsI9Ys0MeYSPsEc4lBXs9nnO7DsgKBsm5AuQ7ypzsxLYDvSCXTs9bA6W1yihjicCe8N919g0D2f+96htJT1lWvP6hOWVG08ZlXO1fabcID2HS5+n6XaXB6YqkT77x36psgvPxwDDM5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epF97rQzMSv16EIfgTHhDYnb1oCIunNHGJAl7sIwq0I=;
 b=bIHKD/Mt65ca6Du/x2y29JCkoJxVEJ3aLH+5y27AVUcGhZI/MeoZ3yJFpiuMGaG3zrFt3ZRp0KR78PlX9zmth3AssHj8chesbxR8Pu8iv5pLns0ZkQxf2w6z2kksihqcOvaErMBtkfVuG89zUpeTBFfed0kltHcu9r+QsjntP3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Tue, 1 Apr
 2025 18:00:54 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%4]) with mapi id 15.20.8534.052; Tue, 1 Apr 2025
 18:00:54 +0000
Message-ID: <3d9b82ed-a5ce-4d15-afb7-bce1dd40649b@amd.com>
Date: Tue, 1 Apr 2025 13:00:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Memory controller not showing half of the memory?
To: mailinglist@reox.at, =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?=
 <zilvinas@natrix.lt>
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>
References: <20250317120702.GA7066@yaz-khff2.amd.com>
 <dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt>
 <20250328152415.GCZ-a_HzI0zpcaLNWD@fat_crate.local>
 <a1ed1aa7-96df-4c95-b818-4dd8f9da7c56@reox.at>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <a1ed1aa7-96df-4c95-b818-4dd8f9da7c56@reox.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::13) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3b0f4b-6a9b-49a6-ceef-08dd7147256a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXFYT2h1K3E5K1ZYMVltZ1k1c2tBLzFXYThsUU04dXZvU0hOQWZHbGpoV0o5?=
 =?utf-8?B?aVFGV1k3UzVjck9QWERjc2JmWXNYN1lRSjZWWGVJZkVmNm1oMit1RWJUQ1VP?=
 =?utf-8?B?bEQrM0JZekwzYlNnNEFlM0xzMGk0Sk5MSUJjZnNLWG5oeEdKZTNoWm5jaHlN?=
 =?utf-8?B?cjFhQjk5L24wR1JnQ05zRlNFaWlsS2ZHcDRBYlRvdmViWElCSGEySi82aEZ1?=
 =?utf-8?B?dlRVVEpWV1drN2MvZFZML2QrdE0xd3c3ZGFXeVRPQXE1R2FDdlZMZVBWOWpY?=
 =?utf-8?B?NzNNK3RiazZnT0FPMUJZWEJheUY1RGM0MVZBeDV2N3NmOGpUc3pmZ1NVU1Fo?=
 =?utf-8?B?bVVRT0h1WUlkU251YjI5dHBOOExZUGdUSS9lU2F6c2Y0SlN6MEh1TWNaNlhy?=
 =?utf-8?B?eWxqMnBDV1ZmcXJ1MkF6K0R2MUtzL2hwSmZsTlltTzdReEZJNC9VM0s1ekdQ?=
 =?utf-8?B?clg5VytPTHdpaHdJbXUvS3BNTWJrTXJXZW80cGt4QXZVbEhuL3pkYU43T2lF?=
 =?utf-8?B?aTR6MmpNaEduZ0x2SkdaY0ZoU2lGNGExRFlVcE9DMEpQem5kdmliT2lPMmor?=
 =?utf-8?B?RGI2YWtkVENqb0xxbXY0aENpbkE3TllDYm9sMTFsNXBiYURwcVp0Zk91YVdq?=
 =?utf-8?B?d1NNRC9TWEl3U3QzTEtwRGtGQjlhbnZBanBqWERuUlk4SGFsMHJBU0NOZkx5?=
 =?utf-8?B?TzZsK2RVU1NSRlFsdDN1eVF4YTYrN3FramJ4RnB3endGTFgyN25jRG5CdDZO?=
 =?utf-8?B?WjltSXAyUG9ld2FIODl5bmcwVFZNTzNFTU9DOFRxbm50K0dmdXRHeWltRmFJ?=
 =?utf-8?B?ZmJZakRlZjBtazNPQkYyZjFFL2pZNzBEOWx5MDZFcTlFTUhHSEZidHgrd0E5?=
 =?utf-8?B?OHBlUjMrNEtlQTJMMFgrNVl2L3ZDTUFtUmZYWjVnVlloYUo3ZEdBeHRrMElC?=
 =?utf-8?B?NzlMREdoUlNMNzZtQk9CaGp3cGNta2dma3Frb3pZMlp3NEpPaWhYYzBxZzhL?=
 =?utf-8?B?cElDeU9ZcDdvUUNncllDU0ZLRHl3cmh0dENpUXg0MmVsR2pTV3ZhUnFSOVZG?=
 =?utf-8?B?M2VCeWhmc2Q2cmhKd3AyY0ZsQUJUQS9WNzVIWTcvN1cwWit2RjNEUWpQU3lZ?=
 =?utf-8?B?anpRdm1BWU13alVhTlhWRk00anpHQzRLV0VNUFNDWU5VQ25BM3RnL1JFbWNi?=
 =?utf-8?B?RTQrTlcyNWpuRHdlaDI5SThNbng4ZWYwekhqbGdSVFhDR3dwNDBnVFF5Wk5E?=
 =?utf-8?B?RjhhWUVaam1HMmk5U3ZGTkhIcis0Z1drb00xNnRsZlU0aTNYMDdFQ2gzL3J3?=
 =?utf-8?B?bFM3ZG1jZ21lWnRVVitLMFdQTGwxRmE5OE1FMmZOZmJGeHZXWVlQR1lDdC91?=
 =?utf-8?B?RFdIZm9JSEVpOFd3eFZKQVc1aUlub28zU2MxdS9XMjMvd3UyNWdhUnMwTjlG?=
 =?utf-8?B?dHNqaGdDUDJRT283Z2NvcTh6dC9pYTJqT2ZFTWdvQkpuckloRCtUSENrVlVk?=
 =?utf-8?B?cnpFWFhXMnN4Q2lnaHBlcDN1aWNNL0orUkNBR2NWcWhMSDBRVkI5bW1nK0FO?=
 =?utf-8?B?TU5IVE9xazVnZUNCZ2ZldWdhY3l5ZmZWTEhsVEhSbGtuU3BmSGZKZGRSaWVF?=
 =?utf-8?B?b2g2VlJzcjd5aWU3Wml6ZGY4R3RvTUQ3Uloxb0JxSHJJa2JrbXk1dnBxZ2tj?=
 =?utf-8?B?dk1oU1Q1RTdodzcyakNXbUpmNmx3NEsvSW1BellrZSsvK1hCeHF0RmtOZ2Jn?=
 =?utf-8?B?UllMVlVFdVkxMUpFMGI4dTZlRDNaVFBSczdUNERIYmtKS04rcGVXa3M3eXdE?=
 =?utf-8?B?ZjcyenBVdHlRY1k1c2MwaTcwbGY5VTFUZ1lWbUx2V1oyMDFOS3lzVk9idlBw?=
 =?utf-8?Q?ahTNQf/lMQgCN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEtNY3lKRUJmbGljODRFYnQrRUV4Wk9IV3hCWCthUlNzUURaM0lIclh1TlJ1?=
 =?utf-8?B?WEJvSkNtYWw0RUZPOEhWaHBpaGhGK0JoRjJRN2lndUIxdmZTTEJYbjQ2clNC?=
 =?utf-8?B?WGlZUTBSaU04aHpYQkRHbkRLZ0pRbFd3L0p1ZXpYR2xEQ01XNWdsWldQYmsv?=
 =?utf-8?B?OEJRVlhYMWsyZmJUK282WlpqdklVRDA3ZG44YW9ROEh1TDVaK1ErSEZGNFM4?=
 =?utf-8?B?T0ZzTDlRbEZDbmFjZ3BtOW9LWDRzalhLOFo1QThwdDJhWEs4cTkreWtVb3I3?=
 =?utf-8?B?cUJzSTJGVnFMMUdjNGV3cWVOTHVLZ2RWTlFoS0VkWHNHSXo4TS9LZjBXaGJz?=
 =?utf-8?B?eFZobGhjS1BrbFJxNkxjTXlTZW1qODREN3ZEUDNZZkNHM21Wd21SNUU2M0dH?=
 =?utf-8?B?QWdiQk1SYzJPTFh1R1FMTHEzUUgxRlorLzhoUkl6SnB4Z3ZkaTErTFRxMk9I?=
 =?utf-8?B?RnUzT3p6b2ZiSmVrQnpQZU9aKzVDR0RLd0g4aTc4YmYrV3VWV1M4L1FHajVQ?=
 =?utf-8?B?WHZrVWxkU3BOdUN2YU1hUDQ3WmRqeGFDcEF1bnp2ajBVa2VuL252MkhZZlBK?=
 =?utf-8?B?aGFNeW90RWI2RldCSEhzRHVzTUh6Tk5HaS8vWjZKWmVsekRlK3ZxMnlJckVE?=
 =?utf-8?B?NWJVN0dPUnFiaGtUTEV6U2N6TDNnTkpJelBQL0svQ3ZJTGd0VW1BbGt6MUVT?=
 =?utf-8?B?TWxpR0ZGMytFQlJBVWMxeHp1eEMxakc4Y2NGWWJTaUN5cHg4b3NPTDVOSlVW?=
 =?utf-8?B?SXNncFAyMWg0VWhnaDVlUHE4ZXdadTRkZCtCVG84NnAyUk9kVjAzUDlKTFVD?=
 =?utf-8?B?eXExNzB1ZTViWWVYMVA0SjRYRGJ1dE9vWjF1LzV6aGN3MDBtRERGL0xxcDRw?=
 =?utf-8?B?NjQvZVoreXRsa2tnWVVjOFJRWlRZUGxsR3JMY1ZYL2J6MnRaRnkyZnlOUll1?=
 =?utf-8?B?c25Hd2FybU5Kak9vUlVXWTBaMUNOS1UzWW5DNnlwMktMekZ2MmVodzdqalFn?=
 =?utf-8?B?RStFWVVlQ1htK250UGlzaDZQT3Yzc21TSHM2blFic3BybE5Md1AyME9LV2Ry?=
 =?utf-8?B?eVo4K08vZ2xhTXFFV1FxTXUyenNaRFh1ZVMzdWtHTHpzaTNRKzBqNGxOLzhQ?=
 =?utf-8?B?a2xGUVlJbTc5bVFycG56QVVpbks1QjBUUnVXZVRmd2xoVVMxT1BFUFhqN3Jr?=
 =?utf-8?B?U1hKUG1aVFF6ZHpOWmhNcWxBd0JpR3BwUlgxaEtSaXdKYnlPeXFVSzZzT2pC?=
 =?utf-8?B?SksxZStQdndpYkhUbms3VHRRRmU3SHpYbFNUY3ZlSnBxUnRtTURjNmZydnZD?=
 =?utf-8?B?dm5FazdQSTZ3ZU1pNURpVGdpbXRlWHhrLzd4WDFEQ3dzMUh6L3k5V2FtM0JW?=
 =?utf-8?B?UndDanB4N2hGbk5hSVBjaVB6SU81UTROcTFPbE5aMmNUTFF5QTdaclk2QUcz?=
 =?utf-8?B?K3ZFOU5HM3FDMlAvNE8waGd5K09CQnNLUnp2WEx2aktxcWF1aiszcGh0bmp1?=
 =?utf-8?B?cnJvS3oyeS9EYXhZSDY2S1RJaTZrKzFlUXJzRFE4MUFRcnp5WHl3RURaaEFi?=
 =?utf-8?B?UGN1QlRlbjVQanNKMFA1QkZYdDdSY3RTTGNBL2ZCVmVaUWozM2JhYlVhY2o2?=
 =?utf-8?B?UlY3c3RGYlo2YlE2cFgrK0c2QTRTbFZMWEV6MFYzK2VMSjZ5QmhjVTJZQnJQ?=
 =?utf-8?B?YmJ4TVRWMDR0U244MjdDT3J6TmxpcDNBdkJ6TVFTOUJNL0JMTGJRK2FuQjA1?=
 =?utf-8?B?VWFNUnRyZi84akhPaU1YUFUxeDd1SW5hcUpxRjNoeVZYZnZSYWUxL3U4b3Iy?=
 =?utf-8?B?MUluV1VMaXVIdVZBd0VpdnhqMk5kOVZBZlRFd25XRk5IdDUzWnN3ek9HTElQ?=
 =?utf-8?B?TC8xeTZXWCtBTXphMWFEMVRhcFVjem1KNVZ5WkZlUVZZRVhPRkw0Q05wM0Jx?=
 =?utf-8?B?TmdwWlh4YlcrQnVtYVF1U3NsbTJkcERYbmRJd3huNS9Tcm4xTUF6eEQ4eGgr?=
 =?utf-8?B?VEVIMjYzZUVwd3VhSFFkaXYyR2R1MVovcGFYUkkzN0lBaStaaXhQQmZ1NTBK?=
 =?utf-8?B?R1cwVUVVVklKQTZxNzJNb29LR0tkaklnOTJZT2dPSFd1eUZ4NTJpVmFTM25s?=
 =?utf-8?Q?KGGESHCEyteOsrneS3PljY2kN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3b0f4b-6a9b-49a6-ceef-08dd7147256a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 18:00:54.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJM8D5UXSZkxS5/PYBX3ShJHjBQsltkjg4QUNHJItvyDsUc9TJXGvxyGHChW9G6CyrtKY7opQIlpLBu2Vug9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

On 4/1/2025 06:44, mailinglist@reox.at wrote:
> 
> 
> Am 28.03.2025 um 16:24 schrieb Borislav Petkov:
>> On Thu, Mar 20, 2025 at 11:38:58AM +0200, Žilvinas Žaltiena wrote:
>>> Hello,
>>>
>>> I am also having this "half" memory problem - EDAC is showing 48GB instead
>>> of 96GB, however otherwise whole 96GB are usable by OS.
>>
>> Both of y'all folks encountering this issue, care to run the below patch?
>>
>> https://lore.kernel.org/all/20250327210718.1640762-1-avadhut.naik@amd.com/
>>
>> Thx.
>>
> 
> I tried to apply it on the current Bookworm Backports kernel (6.12.12) - which seemed to work but I still get the same output, i.e., 32GB out of 64GB of RAM.
> 

Think we are mixing up issues here. So, to clarify, there are two issues currently being worked on in the
amd64_edac module.

1. For Family 19h Models 70h-7Fh all UMCs are not enumerated by the module. 4 are present but only 2 are
enumerated. Currently, required approvals are being sought to upstream the fix. I think this is the issue
being encountered by Sebastian from the dmesg logs and lshw output provided in this thread.

2. For calculating DIMM sizes, the module does not consider both Address Mask and Address Mask Secondary
registers. Consequently, for non-power-of-2 DIMMs, the memory size logged by the module is inaccurate. I
think this is the issue being encountered by Žilvinas.

The patch that Boris asked you folks to try out fixes the second issue. Fix for the first issue has not
yet been submitted.

> I may not have built the kernel correct though... I did not had an environment to do that and just set one up. Or do I need a newer kernel version to apply the patch to? Sorry for the noob questions...
> 
> Best,
> Sebastian

-- 
Thanks,
Avadhut Naik


