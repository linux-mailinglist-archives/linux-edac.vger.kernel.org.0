Return-Path: <linux-edac+bounces-3594-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F3A94850
	for <lists+linux-edac@lfdr.de>; Sun, 20 Apr 2025 18:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E990170375
	for <lists+linux-edac@lfdr.de>; Sun, 20 Apr 2025 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759CF1A315A;
	Sun, 20 Apr 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="OXEn0hC6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DFB674;
	Sun, 20 Apr 2025 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745167440; cv=fail; b=rC2mehoW6Ah5IwuxG0J/ksBkGTF0I0fLjW18h35GRu36HfFMw9bpxocgaWRFW1Rlfb1ZKK3vO+bkOjh3UhnJJNh5/eHIvY7OMNju2tZamLQvbuPjIfl9IQZy0Y5L6L+MDQUPlibI0ClqRAapaHrqNtjGCwdjN9E2u/89jBrV8hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745167440; c=relaxed/simple;
	bh=pkmgKmr//wQD6IsObY+Lb3gwCRj7CQ/PrRX6iZzLZbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCs02UITkREePIAucYGeIPqk5iMsMLC6kIKWQy4PGEWwR5QOZ3/SQbulu0+B4V8eh6fz99yo3CoVz2UXWCwxL/VlZ1Z+rLghAfBFairR0/iHnWObQvufMlhvOmAUjOf/A4Wh+dFghJu7VK94vy+vH8dRC1g3fRstdDiLZCGa4Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=OXEn0hC6; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEssnDjJXwYm8nEkAt0dylWSGm1oW4w7qads46lZDPX/9/F002sjMVc7U06xY6W77JY7Q49PqK81AohiTMS4wEG6qEIxhJPXTeIE8Mo8NJwzd/LP1MOhDMyX28qfpFkS9Hmu8h8rQx6Y/1jyXD4U4I7rwb1V0n56RxuOriBmK/B4bQDFOpKzy6rJgZurN4ggDJnWt8LII6Q8d0wZK0fGtBQKxpYGKc9hHeCnqCFR49qD7TZnifHl+f/tfVdocln1C6dYri6yXLk+1mGb6z6TMrw8LaUvnQHqHUa9CFDW3OhGXje4jAFfdwxYRpomPH+7pI3xarlmr+OBAmXhHX0yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwyW9NpCaLuidpnx9SlrskndgME8ASflEEa6Ey/5Ypo=;
 b=uCQHxZc2LPu+8OGwVUJfUIIm7fzdH+jtp0bvNc4tdrusZZOHjQAjhJhpZqdXYdbKMnO9rS92ab5FADc4N3HlVrJYVRs5VAlGgvBHQkEtOdYGT2YOkRghqFYe5mahVCYGxtdkCHNv10EhqUamW2WHGDvJ4MG0KhlhJ5YgrKjoOPGp3xzp/5/bx9Bo4K4PofJA27m5iQED7ivS39tiwwHAoC/GAQzSZ6I7nvdSldenu50J9Il5Hye34EeXPOVk9K+0akxQa4veWocqNed7HUYN1zRVzHYdddHKgNIGMoy3F1WZEyeaia639ZC0jYC6RyRflg6l3uNdq8XW4NQEgrUjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwyW9NpCaLuidpnx9SlrskndgME8ASflEEa6Ey/5Ypo=;
 b=OXEn0hC6Pm4hGmMXcCsq8HHKrxwdF+DJchqmbnA+Di03MqbnT3TstGFqzYFX1mQg585+Zqv9/w5QEwtFGsdbSTUDp198Nt7mxUAqnn0G+fCYs7ICgkw27dbIuqOvK5Y6KNWO0t6LDMiTFKMTM3bvzf6uAk9138IC4nEKQBDxHVKAOpgw87U8xMgUG+HU3ILfmTJQHCgun9CtrHNIqddX8NrmWMwxgZAWKccFdyLIW2mePlVQTK0NHztJZjW+O3fDkgx+T5Xg5R0yOlCGFVeVutSEnYiMcydEDUrqoxqQbOAAOIdS01XizabRPJKAJX15CmLerLygAdTXQ93uUb0RPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by CH2PR03MB5256.namprd03.prod.outlook.com (2603:10b6:610:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Sun, 20 Apr
 2025 16:43:54 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.031; Sun, 20 Apr 2025
 16:43:53 +0000
Message-ID: <2f2c62b7-7c10-4bc8-82fe-d300d4976655@altera.com>
Date: Sun, 20 Apr 2025 09:43:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] EDAC/altera: fix cut and paste error
To: Borislav Petkov <bp@alien8.de>
Cc: dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
References: <20250418143052.38593-1-matthew.gerlach@altera.com>
 <20250418143052.38593-2-matthew.gerlach@altera.com>
 <20250418204502.GGaAK5zt0verzZOQAd@fat_crate.local>
Content-Language: en-US
From: "Gerlach, Matthew" <matthew.gerlach@altera.com>
In-Reply-To: <20250418204502.GGaAK5zt0verzZOQAd@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|CH2PR03MB5256:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ced5a7-0bad-4e0b-a41c-08dd802a8855
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlVrb1pxc29PY2Jpc2QwR25wc1JIajF0THdJa3UzT3M2dG1QeXpvdEF4d0Jk?=
 =?utf-8?B?ZVlmVnM4N21sclR4VmdVM0pWL2MyaGQyWVNxT3piSlhVTzNUVFB1UlVPL2Rs?=
 =?utf-8?B?Vkdybld5YjNCTlcvT1MyM0FQRDErNzNOYnN1ZFQ2emJFTjhRQ29xWjBwV0xy?=
 =?utf-8?B?NUlGMTNXVUdaeVNpNmJBUTA0c3JNYU00ZFBQQWg0NmdqM3pDSmJ6b0FMVE1G?=
 =?utf-8?B?NFdKMEFRVmNOZnRJMkJYeDhhd3hwekcrWmlMN3FCYjQwWXpoWk9CdGgraFJH?=
 =?utf-8?B?M0tKdTVxdEFuNEdKdDNlQVJyU1FydmovM1dMQXcrNk9VT0QwMkNOZ3lrU0dM?=
 =?utf-8?B?SFcrY0d6QldLYTdFUkZzUUw3elJsZlFQckNpN0ZJQW9xZ0k4a3U0WlFGQjFG?=
 =?utf-8?B?RnJVdS9udUtUVDZ0UFVyVFZ5amhkRUhoNUk1WGNybGo4U042RmJPbDdJUER5?=
 =?utf-8?B?SUpja25WcTZ6bWdpMDhmWkE0VnZONmhUbVRZT2x0SFhNS1VBcm9nUjdUZVBq?=
 =?utf-8?B?aVJ1eFp5ZlZqZ3pxNWJZUXZOSFFadjV1bUZoMzRadlp4OHlHSXdNWmkrOUxQ?=
 =?utf-8?B?YU5GWXJHT0xiVGtMUWpPdy9zWHR5dzlUNnF3Q3FwTDkveUxiRzNqQnZrL0VL?=
 =?utf-8?B?VTcrSURIUWRlbzFkZjlMa3c0MW5TV0RvdE9YZ3hOS2lYbEtYMDlCa3RqbXlZ?=
 =?utf-8?B?Y3g3VlBGbTFZalpaYW5HYlJzTmNpV1NJdE5xZnA2SUNpS05KRzJkUDFJRERC?=
 =?utf-8?B?STNRWWxPYXBiY2RrTEpGQ1h5SThZZVppSDBraE1peUx4RnRMZ0VvSmlBS05D?=
 =?utf-8?B?cStxeG9KeEdHU201RXZJbVhQR0ZPVG1lZDRjQnZRZGdlQVAvaUE4RDB5bEVI?=
 =?utf-8?B?TXlUZzJqdEVtbUlGWFZvNzB5aytUbXlIZy90Q1ZSTnQyeWh6dGF5Mzl0NTc1?=
 =?utf-8?B?ZjRmNHpLWXpPWjEyTVcxeEVKNUpDOWtqSFlxRURsSDdaaVhWQXBpNitYMUdE?=
 =?utf-8?B?RTFYcFgrMUtteFk3RlIzeHVZb0JQVmhIVnEzUTFRSUF5bUlUelpxZ21URTdy?=
 =?utf-8?B?eFRYWDNlaWRuVnhsZjBQemlzQzJiV3VGTktoQk5XOWpQSmVMck1SL0UvTVlW?=
 =?utf-8?B?bENudHo2QWNYSk9EMkZUSXBFMFExS3BBUVpuMW1USENFQXkvb1BQM3BxdzZB?=
 =?utf-8?B?NysrSXQxQytpdkp2V3FrS0VkTFNOV2VGMWJzSExDZElNVFhxZnpkMTlJM0Rv?=
 =?utf-8?B?UStwNFBwbklMajhaWW9qZFF1OUJpY0xaM0Rmc1ZqaXNIcG5PQzNMSG00Z0lz?=
 =?utf-8?B?VjJ6U0JNZDdYQ0h4QkRidXlvY2xma0lvSFRrc2l5UnlCYUZNQVBEUlZ5SW5r?=
 =?utf-8?B?MUV1amQzR2pScUZIWmZOYTdkZnRrY1R1aDlQNzNZeFIwc2lYRmlubDhvMWxK?=
 =?utf-8?B?RTJLVVdOYzd5UjhVK0NXZXp2eDJibTkraE44QzF2aTNtSmpTbDZhei9oQ3lu?=
 =?utf-8?B?WEdBd1ZwWHpSRmt0dFJSdlJEbVlzK2gvNnNjcEhXYkVDZVdKak5rQ3MxT0xG?=
 =?utf-8?B?TUs0Zkp3d2hzYzAzUUEzaDNLY1ZjeFIvUzM2MFJrODhIRExrTzBHRzlLS245?=
 =?utf-8?B?RnB1RHZSQytDWnhPS0twRFBESjNLU0dzRzMvZ2pBdlBsaDEzVWhLNWRJQ3hD?=
 =?utf-8?B?Ui9YMncrd1BFS20vT1JLTERKb0lnYnFhTWJLU3dTSzUzYVV2M3ZNWUFFaGNZ?=
 =?utf-8?B?WjdpTFNhTWxqQk5NT3pHRWUvcncxN3F0eXFXOUszMGFUblgyZGpLcURrbi85?=
 =?utf-8?B?ZEhZdVF2MWliU1ZpZUR2VVVYNUNXbkluVTN5NDAzSDBuSC9jOWFDaUcxdmFJ?=
 =?utf-8?B?SlkzcWcwN2VEbVNiQ0t2TCtiLzNtUFl5ckJ2Q0lwTVZKZ282Vm41R3JOUnZk?=
 =?utf-8?Q?LLt5ftKLEz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWszeWR6Rk5WdjVLMFJCUHBRL3hpWmxsMUNlUEpFR3psSE8yMlZERHR1Yytv?=
 =?utf-8?B?Y2c1VjFlclFYL0s5K0k4K0ptc1hPVkc5dGROWXppY2lrWTBOY1VvRlJBZmtN?=
 =?utf-8?B?ZXkwV1V6YVIxcnd4UGRuYUdmRGQ3WXk1Z3EyZEMwRjlTdGh0YVBJSmc3UGVY?=
 =?utf-8?B?bVdHS2VCU2dreldTM1ZXRG02NWttSTZ6b0R4YmF3ZlZFTks2WFQ4a1p0YlMx?=
 =?utf-8?B?ZFFXdkRGL0xLRmZPV3BHU21rR0ZmWWN3azg0Q3UzTzBHV1ZDbUs3dlJOcUh0?=
 =?utf-8?B?R3ppRlVvSzVLQThBQXJGSkRRZE5ucFlRbXppYU5QYmRJT0xjck0wcndFUk1W?=
 =?utf-8?B?dWMrTjh4Rkd6TE8yYno3aDkyL3plNHlWRmxGMXR1amNKQnhyVE41cTFWT056?=
 =?utf-8?B?SzcrSG1mTHlMVWEwdXAvcE9oellxVm5TZ09MWDFZUUUrSmxlbTBqbUJxRkN5?=
 =?utf-8?B?WFlhNGdjUStEUmM3YXhxd1JSdGFtSWhTbW4raUU4OWdzVytVaXp3TUF3U3JO?=
 =?utf-8?B?dlIrT3k4SFhpRHREU1V3ZkpxK1h3TGcxMXJ2VytlZWRGVjE1SzliNjdhZENi?=
 =?utf-8?B?UlV0R3hvZDNXRG9UZ1pHNVVYb2tNQlhQOXA0M2Q5ZTNBZ1lIU2sxRlpIWlk4?=
 =?utf-8?B?aFh5eGxNODZ3aXptRDh2SXNBL0hwYUgyVUNTTnB0U2lqS0lNWmxEMk03Y1hm?=
 =?utf-8?B?eVJhamoyR00wVUxva3ZTMUUyc3ZNVjMxMFJNNHJISkIxWDBoYURQdmFWRkJY?=
 =?utf-8?B?OXZ5UjVHRDJVdmQ2SENydHVZR3FRZjA1V3psYUVhMFRwY1RSWmkwQlRodHA0?=
 =?utf-8?B?aUtYenMyUmlKWlBwS0I0bDBncFcxOHVQeGUyU1E0Z3J4N2pNaE1KcWg5bXVL?=
 =?utf-8?B?ZDBpd0QyaktaejBFWU9MeFM0dTdJS1lXTWxFNHBuNithTzhpdkdTMG5EcnNO?=
 =?utf-8?B?bU1KTkpweFFGQWp3UXFLV3JNSml3L1FNZ2RqUkdWalRYOU8yRHRBZFlvdEZW?=
 =?utf-8?B?TUx4LzY5UFBpU2p5MlhLNGtsV2t4WGJzYVhPbkFLWmVvQW56OHFxY0dFallq?=
 =?utf-8?B?N3FJdThNb0VZWDZwYWs3Kzg4T09paktxaWhFQ3NhYllHNVU1YUQ4SWU1Y0xQ?=
 =?utf-8?B?SFdZVXkxZzdRdGR0ejVZelQ1VEttVzlGSWwwaDczODV5UmcxNU4zeWFKZ3Ix?=
 =?utf-8?B?L2tHNVVPcFdRM3pHeGhEbWFUMlE5UEdzUXZhRUNrdlZVaFgra00zMDl4TEpo?=
 =?utf-8?B?MkdEMis0WXZrMmJRa2pMUFpvWDFFWXhlbUZjN3hGR3dDSUphZ1d0U3BLRDNz?=
 =?utf-8?B?M1p2bU5pTm1ESEMzZTFWYmpLd1gwRTY0cUZrWmk3bndxalFPVHFTa0pLQkp2?=
 =?utf-8?B?b3VwNHJCSDFOTTVyTUxSYy8vQWUwWjRBRTI1UHlOU29lL1c2K1NBS1RTTzJw?=
 =?utf-8?B?dGVtT3pBVE1WR3M1ZzU2Tjg2SG5kSzhmS1NHa0NtSGdYZGNsNEZhUWJrQkJW?=
 =?utf-8?B?TlhqTU5mY1VYdUxzM2tsNVQ3ZFFBcGpRaG5VZmhrd3RhQmUwQUZ4YXlxZGdI?=
 =?utf-8?B?djZ2UG1ZZWR1S0hkOFpwME4yblJQMGw0SjRwYjBjMG1aWWlsVTNQam16MzV0?=
 =?utf-8?B?bWJlTDNGWjJEcEMwc3pIOUl6T3M4NHVaTGJ5S3RBMVJsU3VSamprMEVxWUFR?=
 =?utf-8?B?UGhrR1FydmNpNDBRdmxsRStMcTRBR0JoY2ZVM0lMdkIwdVFwaWtnUUdsVTVR?=
 =?utf-8?B?c0VnMmVTYmNydmhBcDN5bFJtNS9xR3lyR3Q3NFhmTFJXZG5CVVcvc2tpeS9s?=
 =?utf-8?B?SjhqVks2Rk1jNTRmUUpLMXZIcnRma3pJdFg5VEs0WDZxdExjZjZIVlRMWWlt?=
 =?utf-8?B?elNjZWR3cVRua00vTmUyS1JCTlBHRjJRV0V5Qmh4THp0RmZXcmkyY1JnM2ZV?=
 =?utf-8?B?ckZRU3J5OE1JekdOVTNPZXJmVFNscUh5WG50c09Ha0FxK3UwaXhMOUEvSmU0?=
 =?utf-8?B?VVhrRzJaTzQ4Z3FtRHppbzJWQTlkQnN6TkRkRDNXdUxnTVhERXNSZ3JFRG4x?=
 =?utf-8?B?TFlXQk9TTDJ5Z2s0NmtMYXQzdGtxMkQvdGRSdm1TMENPVENDNEhkTy9lcW1x?=
 =?utf-8?B?ZXZPMGhGRlh4UXR6NHhJRkREbVBzMUVRSEIxWWZIYUwvYUhIemNwMFNoMTYv?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ced5a7-0bad-4e0b-a41c-08dd802a8855
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 16:43:52.9367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JECXv/H1vQfRli4MirGbg69l4+qXKxQRk2ixbyG9zd5i9rucG4Pdj4CGiGy6NKVy6CpITevDnOxzAAocjTRIzWl62Ice/a0rPhBtpoggXbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5256



On 4/18/2025 1:45 PM, Borislav Petkov wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> On Fri, Apr 18, 2025 at 07:30:51AM -0700, Matthew Gerlach wrote:
>> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
>>
>> Fix bug testing the wrong structure member, ecc_uecnt_offset, before using
> 
> A lot of patches "fix bug". Just write "Test the correct structure member..."

Your suggestion is a much better description.

> 
>> ecc_cecnt_offset.
>>
>> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> ---
>>  drivers/edac/altera_edac.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Any
> 
> Fixes:
> Cc: <stable@kernel.org>
> 
> tags for this one?
> 
> You probably want this propagated to the affected trees no?
> 
> Thx.

Thanks for the review,

Matthew Gerlach

> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette


