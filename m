Return-Path: <linux-edac+bounces-3391-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F3A6B187
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 00:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F43B79FC
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 23:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8252248AA;
	Thu, 20 Mar 2025 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GJlZHMAd"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA21202971;
	Thu, 20 Mar 2025 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512714; cv=fail; b=W+lUszRUS5/knvAH/zQEqdm5kMMWKRNY7KeoggPIWbpiAtMN0nguypfv9UBuudsRl7+bVN8BUvLKiBZU74ipCKr0Fz6iprBgo9NB6euHH6STP/VygJ94W32b30xHxZ/sPYw81dzhkXMpYjectiB6hgdF6ca6ka+65E9WroI2abY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512714; c=relaxed/simple;
	bh=JUtba7IbZ2ZY537pgwXx6wZy9FXFq6/fRADkxZwMiVw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LOxKQxCrMniljTz9xIlyRf1EuMfhmvhvt/fCPvJx1UeOJ4ki9Vc3snIvvwLrydkq0TafQrLiDf2vqHavn3LHQZQrY+JaMP1TiRInSZRkIRSK/iiO3wh3FM8ppFhMDGV/z9Okn6LJ1q5ohTX3UYa7mLyeQZzibUUbUS69HsEhWdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GJlZHMAd; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs3o6rPpOiE4gSWrXOmRRZcOwMoUjbaof8PIn32fAIewywwvCOqT91Fksc9jg1ERTmf0WYZzh3hJ6O7gLXhmv7DeYwNiDmoicw3S3SkI25bitKerTQHjCrnYtvAYIBPqegEAWn/EEUG0mbHgMv1aE9T0j2Lv/oGPIyR+x6SvCH13W64MB+zLjCEyy7e99+JpER1bzexTJC6wYHOR5Gqy1E1MxDcsJXvrrlhqLe0wliTxihzTuKgeaTzWbz1ByPDjoLgygLnxRUccusrSDLxEOuLYRRlPzqMtMyIUOUsMP6p/QTo0jYzfDZKYRj89Dnqt+cU3uBUiauKqBY73oK4n0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFqDGcqZ2/0o/xT3mucUo8NFwc28jTVc7T/OB7AofFo=;
 b=CkrQM7dBGbPOBQDz1x6I5r2no0Ig+RN3NLNC3Jayd/P1DklD4JVXaoLMFeqse9dRGFgJQ3NIwGFX1YDc1OYcnEY+Dtn0KS8LyXIV0PsMkOQQT3HJ6yNHBODZPUWDHtoF7M8bmEtdHaeWwpnBU62AUy3m88AQAgcOi/4lVl4wZx2m0oqwG3vnme/e5rEdgMa+HrcTdy8oYdfgHYuyIXtr0C0lOkZ7y7TKtAQUjUUmj6ZoPX04EoRy8xKx3Z1SELYVGelrXOo3SJps4sOJgFdavWVnn2x4WqZh31U2mcS06/Nc3u8lTkllbFL4XKbyxrRUo/yOatWzXw9rdq2BU6rrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFqDGcqZ2/0o/xT3mucUo8NFwc28jTVc7T/OB7AofFo=;
 b=GJlZHMAdu4R9irf9JTPVAzOc7tSSorrOBVcIl4MgeIHNVCbEyBP9T104TPYlp3AbMB5UUoK7lwqY2Nd18OLvmQdxDg6zB+I34jcK1zbnDYmdsYk9FzlPlUu4aN4JY0FrM/hgu7YWE2v5zLtyEF9bcU5dySc/Lw/hVOY8gg46al+z9dsFkWK6EMml93tRsYZAZOanhuMs4cY6CCm5xlTHHflIy9HjWk1KVPbGZLSeEX8SSdJpkt1/ur21IDLIF5dmeCsJ9U+S1CiLj0+akdkG3E0tZmpZtu+opZmmcLLG0NVIOOp7fW08KIv622hZHiQLvaCQXYbx70WAk0hhOaRU6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM6PR03MB5083.namprd03.prod.outlook.com (2603:10b6:5:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:18:29 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 23:18:29 +0000
Message-ID: <0a5232f3-9568-4205-b875-ca334fe77270@altera.com>
Date: Thu, 20 Mar 2025 16:18:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: edac: altera-s10: Convert to YAML
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
 <20250320164622.6971-2-matthew.gerlach@altera.com>
 <20250320192731.GA750632-robh@kernel.org>
Content-Language: en-US
From: "Gerlach, Matthew" <matthew.gerlach@altera.com>
In-Reply-To: <20250320192731.GA750632-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM6PR03MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 55acc15c-d20a-446b-ad5b-08dd68058657
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWFrWFQ2NUs0UktkaUxtR1pOc2w5SWxDaXJpbE4xa2xKdnF6em1NUXR4UHox?=
 =?utf-8?B?R3A1RDlla3d5K1dMazRuRjA4ZHZNNUdSNEJyWkxVaU9UUG5vOUNZc2NrS0VN?=
 =?utf-8?B?ZkhiUHlaSndzVWdoeFlMQ05na2lrbUtYS0NzYzNORStpOWt2a09lRHJ6ZGlj?=
 =?utf-8?B?Si85K1p1c2hpMzdHb1g1YnhPOG84NDBrVm5kK3VwbDdZMTJCZkNwN0xJekZk?=
 =?utf-8?B?YlFlQTN6Rk5PdDEvWWlTM3hTSnBYQWUwakxZS0ZtTFMzWit5eldXTjJWa1Mz?=
 =?utf-8?B?QURyT1JzK3kzRkpHcWpQZUFjbVBjZ21vVHQ1SDM2Mk5xVHpRNmxtbyszYTVZ?=
 =?utf-8?B?VWJXcnRraFJ4U2dJdE9XdVdPb1ozM2M4akowVnNCMnJWQnhscmEyU1U2T01K?=
 =?utf-8?B?QVNiRFlzR01HTFlPQ0FqVCsxRlkyN3QrVVNBbC9kRFR6MEtRT0VGTC95V3Jo?=
 =?utf-8?B?NThNMWpndkRJWmxOSUg5cnRHb1o2REhSZGFTbXBucXpFbENKeVRqcjZ1R0Jo?=
 =?utf-8?B?VmhHbTNVZXpsZHNFYzFPNHZzMWlDMlNsOTZsaFFwalBjdFBJdUNkU05vV2RW?=
 =?utf-8?B?YnhUWUpXclErcUxYNTZoN2VyZTZ1MWk2by9DcWY1Z0NXV3pJYTllOUovM1B2?=
 =?utf-8?B?T1hVRzVxSnhwS1RTSEtNRGVFajRLcjRpTUZZZG9HSGtCMmhEc2xuaWxqNFZh?=
 =?utf-8?B?MkEwL2RnbHdic1Q1ZkYrSDAyQUdhVVVwT3FPWVl6TCthMWpwMmNFS0w3aW5E?=
 =?utf-8?B?eS9ya01XejA3eW9xZDlZVUo4Sm9HVU5PbG9TVlErZWZkVzhKWmJlZ1NwV21D?=
 =?utf-8?B?aDRRR3lLR0tXMGNJRHVrU3FQVEtCWmY5YlhOcGhKK1dRbzFFbFkwYU9KV3ph?=
 =?utf-8?B?UU5KS3Q0QmdTSmtlR0tneTdvaERGT2lNMWxIbGtFMG92MkhtUWo0V2x3Tkxw?=
 =?utf-8?B?d3FZYW1tVjNVdHYvRlUrRjNFdHRPQ28vR1BiL1NaU2VrcVNDczBmSlBHdVdq?=
 =?utf-8?B?REN1OStPZE1xazZ6V01ySmZwZlR5Skd3RFFOTHVTMXZna0huQTMwVWpWVXBx?=
 =?utf-8?B?SEFmMi9PWFllZUJyNXo0UFB0QmQ2bENUSTdPajJMNC9lYmRFUjFqUVV4YUNu?=
 =?utf-8?B?RU4wM0JPZU9MejJaUWhPUi9sUEFCYlVjeEVNcW1TSUZoaGRmRVBkRHJOL2U2?=
 =?utf-8?B?ays2aG9RVmM3ZnR5Q0RSWFpHMnRjS2lLK3FjUm1VSWdobitUWFlzVzRCY2ls?=
 =?utf-8?B?VVVURjJHZnFFNzVBOWVRR3NBMElodFVUdk14ZUg0L3RYQjdRb2tsZFRmUVZE?=
 =?utf-8?B?WmxxeGVYeU5VZE43anAvV0ZyZm15dkgvS0lrWGpacHJSdVV3SFR0S3hSTlJl?=
 =?utf-8?B?aTlDWlVUYTJxL21xTWhPVlRubWJPY3Z4aXArUi9LdW12K1Y0VldXaVkveUtt?=
 =?utf-8?B?NytnWmhIa1RMb0ZqMXg1T3NnMWRXaSt6TjJ2Yms0TlJhSnVydUFSNXEvWjJr?=
 =?utf-8?B?NXFKN0ZFSU1rZi9ESnpsVU9LYWZSVUI3eHVYOVVnVjlBcml1NXNrMmFOQnNV?=
 =?utf-8?B?N0phd3dudEEvK0hBRFdFUFRDaTl3ekFyMm5WNyt0azNEekJReXRGUEUxUTZV?=
 =?utf-8?B?MlRoNHNsRXl4VHRKUGtEYUxheVVXWGc0M1pIZjIvM0ZhbHFzelZ4NE9SZU9s?=
 =?utf-8?B?VXg3dHprMWRrRWFScC82WVFRTDZlTUlHZXI2L1RvZGZqNWtiQzlpbmtsYWxo?=
 =?utf-8?B?aFpNV0Zzck1IbmlWbWxmWUZRd3YvUko3WVJBY01aYVQ1VHF5VUR0cDQzcUNj?=
 =?utf-8?B?VjVicFd5aGJGSVlkQzh5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStxc29SNit6UytUTk9Oend5cENXWWFkTFkzUjFucjFOUWpYTmRBMnBDZmdy?=
 =?utf-8?B?elBuR0ZhVW5CSVJDbEFqK3FzY1ZqeW4wc0hqSVhJc0lUbG92K08rdWhQYkxF?=
 =?utf-8?B?aWZ1Z2JmREZRNUF4a3Vhc2l4MHJQbjVaUzJvU1UrMEVqcWpkTlY2Z2RjUmlV?=
 =?utf-8?B?MzV2UnVjMUo1Y2lBeGlpMFRRc1RiUGhXUEZhSzNXa1ZTWnZFdlVXYkxQWkUw?=
 =?utf-8?B?MDVBaVIvcGkrZUV3UVdxUWVqTXJIN0p0aXg1bHRjTkl5Vm9oRFdQODArT2d6?=
 =?utf-8?B?Q1Z2dFQ4REIwaUt2YUZuNjhQSDE4ekE0a3g3cXorL0RaWkpqS1FQSVZCRUVI?=
 =?utf-8?B?T1l0eWEzOG9VQ0hWSUhJeEU4VU9JOEcwZXB1c3VvdlFVZFJpdG40ay81cGp6?=
 =?utf-8?B?TGtEaEhYaTQ0d25nc2ZoUTNZSFgrbndkNVJ1bDFOTkpDMFlkQmdpRWFFcGZv?=
 =?utf-8?B?Kyt3OWtraVhRVEJXUlk5TExXTjVBYXZHOVVhS0tVN3A0ZnUrN3VRWjFoRXBC?=
 =?utf-8?B?c3A2SEtPMHpsMjFCWVl1Ri9NSUJTUHB5QWRpTDNNazFneEl4YmlLbkpJYVBa?=
 =?utf-8?B?OTBmYUQ4SUFROWFpMXlxWG5YZWxNd2dIQkhuSVJlaWNvV2RoNGpDU3ZNTDEw?=
 =?utf-8?B?d3BKbDdFUjl2aUxmVkJSeThlZDR6b0xjcmw1UmFPYzI3Qi9MbC9jalNBWkxD?=
 =?utf-8?B?bVFOMkdxV2lTU01FdldPa3cyWGYyMzd3d1RUTVF5NkEvcVFRV2FuUVVJMlJr?=
 =?utf-8?B?ZUxPakxPaGVhUTZVb3FLTENEV25FTXpncEdDOW1pSGZhRHdWYzFTcTZPQ3lQ?=
 =?utf-8?B?amtNQXNvUHI3TFVYYllKUTVpOGZ5bHY0QUpzaEw3SUhVRm5LT0d1c1pra3ZO?=
 =?utf-8?B?aHN2WTk3MTRoSy90ejFaWWNjS1cyVEt1YU4va04vaU9ZYmdxKzV0WXhjbkpX?=
 =?utf-8?B?WVExcTJaUTFQZFFXZHhhVTBvUks2Z29rYTdld0tRTVlCS09NU2tRRm12SXVK?=
 =?utf-8?B?OEg5SHJDUlN6dWUzOEs5UnJkMHFsK2d5NzJqWmduTUZ4ZDV0TmJ5L0MrbGpn?=
 =?utf-8?B?b1EwTUxranJ4U1lGWkZERnRyUEc5a0N4eFdkZERCNm16TEpBYWVlT2lQaW16?=
 =?utf-8?B?WDdyQzUyWjF6eDhoN09uNitoaDZoeFBPcGlWQy9ybnp2aTFFdklBd0hNK0NJ?=
 =?utf-8?B?WVB0TDdPalBGNCtBWmZaSmdockR4czd2NWpoSWhidURTNG03MGUxOTRObm00?=
 =?utf-8?B?Vm93eXUvQ2JEMXE4L25QUG4vT25WRE9LR0xQYWRrSWN6KzlVZjlvNXFjc09B?=
 =?utf-8?B?Q0d5ZFpJQlF1UkxvZ0hpSFpQT0xkbXV4c1ZwYVYxWEY1YUd3S1c4ZHhRUktv?=
 =?utf-8?B?WGZZVEhPOS9kRURYaGR0NENiVkVVUXZYT2QxZ3dUV01pM2l6UlZzeDJZUE1m?=
 =?utf-8?B?NlBZTDE5dzkyNk9aaFNkRm5STW9lZDR6UXlzVVJiUk1udGlGM1Jpc2gzbm1a?=
 =?utf-8?B?U0EvdVR2OXBROVk2TW9JM0VUTXJhQlNaZFhHMXQwNUdWQkIxN1RFUVg5d0py?=
 =?utf-8?B?Y0s2ZVEvb25iREZ4djdOTHg1VFpyVHRWMjl5T1JRVkE4T1VJN0twaUNtRlI5?=
 =?utf-8?B?UUNLREoyWkdENjI3OFdWZVRDdFRQUEJqcFBDOFpGWEJ1VnZ1cFVkWGhNc1I1?=
 =?utf-8?B?V3czR3R6R2FYZU5Ob3FNSnl2M1ZMdytzSEhHT1lZRkZaQXU1VVNKZ2pWbUpD?=
 =?utf-8?B?K3dsK3V0MGlGYmdJUU5DWXVudmRlYlBEcFBhUURGTi9CQ1o5Wk9yV2NjeHRk?=
 =?utf-8?B?bTBkTVVaeGpJZWJXQWxsc1lHSUxjYVBiNkczR2wzU09jUU9RMW9DMXlUZjd3?=
 =?utf-8?B?VHYrWXg4anFVdkN2dHNiVWxZWjRZZFJFZHowY2JGNlZWVllsUi9UbmlaQStj?=
 =?utf-8?B?dW9kRDk5UDF6WkRyWDgzdng0MlZtRk1Td1lZMzVMTXREZzY4R3g1MjUxaWdi?=
 =?utf-8?B?aXZPWGFqUTFLV3JmdXIzY0Y4TlF3S2ljazErYktEbE51aTFHajBJdjZKYy92?=
 =?utf-8?B?NXQwSitoeXZ4M2YyaWlCUHhEdXhoYzdRbjltNEk3eC84Wm9QK1dTMXo1Tko4?=
 =?utf-8?B?aFhOMUpCbkRxZmgvdlExTG9rYmJmWTh5WFZocmdNVmo4a2NDTVkvUVR3WWNi?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55acc15c-d20a-446b-ad5b-08dd68058657
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:18:29.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdv6nFAM/XNE2Lqbty6q0ks1OFZ/rIUb0TLox4fTgGasKlY/NC2PzUBfjCfX2ievYMoNblPgTYL8EaxQ7MckOX5VTfObN9k2f4DoosbzadQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5083


On 3/20/2025 12:27 PM, Rob Herring wrote:
> On Thu, Mar 20, 2025 at 09:46:19AM -0700, Matthew Gerlach wrote:
> > Convert the device tree bindings for the Altera Stratix10 SoCFPGA ECC
> > Manager from text to yaml. The hardware for the device tree subnodes
> > have not changed since Arria10; so don't change the compatible strings
> > to include "-s10-".
>
> Nice to see this.
I am looking forward to seeing all the socfpga schema check errors gone.
>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  .../edac/altr,socfpga-s10-ecc-manager.yaml    | 228 ++++++++++++++++++
> >  .../bindings/edac/socfpga-eccmgr.txt          | 150 ------------
> >  MAINTAINERS                                   |   5 +
> >  3 files changed, 233 insertions(+), 150 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> > new file mode 100644
> > index 000000000000..ad057a63e88b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
> > @@ -0,0 +1,228 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2025 Altera Corporation
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/altr,socfpga-s10-ecc-manager.yaml#
>
> schemas/edac/...
I will add the /edac to the patch.
>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Altera Stratix10 SoCFPGA ECC Manager (ARM64)
> > +
> > +maintainers:
> > +  - Matthew Gerlach <matthew.gerlach@altera.com
> > +
> > +description: |
>
> Don't need '|'.
I will remove the '|'
>
> > +  The Stratix10 implementation of the SoCFPGA ECC Manager counts and corrects
> > +  single bit errors. Double bit errors are treated as SErrors in ARM64. This
> > +  implementation requires access to registers only available to the Secure
> > +  Device Manager (SDM) via Secure Monitor Calls (SMC).
> > +
> > +properties:
> > +
> > +  compatible:
> > +    items:
> > +      - const: altr,socfpga-s10-ecc-manager
> > +
> > +  altr,sysmgr-syscon:
> > +    maxItems: 1
>
> Vendor properties last (but before child nodes).
I will move the vendor property accordingly.
>
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +
> > +  ranges: true
> > +
> > +  sdramedac:
> > +    type: object
> > +    additionalProperties: false
>
> blank line
>
> > +    properties:
> > +      compatible:
> > +        const: altr,sdram-edac-s10
>
> blank line
>
> > +      altr,sdr-syscon:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: phandle to SDRAM parent
>
> blank line
>
> > +      interrupts:
> > +        maxItems: 1
>
> blank line
>
> And similar on the rest.
I will add the suggested blank lines to all the subnodes.
>
> > +    required:
> > +      - compatible
> > +      - altr,sdr-syscon
> > +      - interrupts
> > +
> > +  ocram-ecc@ff8cc000:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      compatible:
> > +        items:
>
> You can drop 'items' if there's only 1 entry.

Thanks for the tip and the review,

Matthew Gerlach

>
> > +          - const: altr,socfpga-a10-ocram-ecc
> > +
> > +      reg:
> > +        maxItems: 1
> > +      altr,ecc-parent:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: phandle to OCRAM parent
> > +      interrupts:
> > +        maxItems: 1
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - altr,ecc-parent
> > +      - interrupts
> > +
> > +  usb0-ecc@ff8c4000:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - const: altr,socfpga-usb-ecc
> > +      reg:
> > +        maxItems: 1
> > +      altr,ecc-parent:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: phandle to USB parent
> > +      interrupts:
> > +        maxItems: 1
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - altr,ecc-parent
> > +      - interrupts
> > +
> > +  emac0-rx-ecc@ff8c0000:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - const: altr,socfpga-eth-mac-ecc
> > +      reg:
> > +        maxItems: 1
> > +      altr,ecc-parent:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: phandle to ethernet parent
> > +      interrupts:
> > +        maxItems: 1
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - altr,ecc-parent
> > +      - interrupts
> > +
> > +  emac0-tx-ecc@ff8c0400:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - const: altr,socfpga-eth-mac-ecc
> > +      reg:
> > +        maxItems: 1
> > +      altr,ecc-parent:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: phandle to ethernet parent
> > +      interrupts:
> > +        maxItems: 1
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - altr,ecc-parent
> > +      - interrupts
> > +
> > +  sdmmca-ecc@ff8c8c00:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - const: altr,socfpga-sdmmc-ecc
> > +      reg:
> > +        maxItems: 1
> > +      altr,ecc-parent:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: phandle to ethernet parent
> > +      interrupts:
> > +        maxItems: 2
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - altr,ecc-parent
> > +      - interrupts
> > +
> > +required:
> > +  - compatible
> > +  - altr,sysmgr-syscon
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - interrupts
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    eccmgr {
> > +        compatible = "altr,socfpga-s10-ecc-manager";
> > +        altr,sysmgr-syscon = <&sysmgr>;
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-controller;
> > +        #interrupt-cells = <2>;
> > +        ranges;
> > +
> > +        sdramedac {
> > +            compatible = "altr,sdram-edac-s10";
> > +            altr,sdr-syscon = <&sdr>;
> > +            interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +
> > +        ocram-ecc@ff8cc000 {
> > +            compatible = "altr,socfpga-a10-ocram-ecc";
> > +            reg = <0xff8cc000 0x100>;
> > +            altr,ecc-parent = <&ocram>;
> > +            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +
> > +        usb0-ecc@ff8c4000 {
> > +            compatible = "altr,socfpga-usb-ecc";
> > +            reg = <0xff8c4000 0x100>;
> > +            altr,ecc-parent = <&usb0>;
> > +            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +
> > +        emac0-rx-ecc@ff8c0000 {
> > +            compatible = "altr,socfpga-eth-mac-ecc";
> > +            reg = <0xff8c0000 0x100>;
> > +            altr,ecc-parent = <&gmac0>;
> > +            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +
> > +        emac0-tx-ecc@ff8c0400 {
> > +            compatible = "altr,socfpga-eth-mac-ecc";
> > +            reg = <0xff8c0400 0x100>;
> > +            altr,ecc-parent = <&gmac0>;
> > +            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +
> > +        sdmmca-ecc@ff8c8c00 {
> > +            compatible = "altr,socfpga-sdmmc-ecc";
> > +            reg = <0xff8c8c00 0x100>;
> > +            altr,ecc-parent = <&mmc>;
> > +            interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <15 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };

