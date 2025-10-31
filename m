Return-Path: <linux-edac+bounces-5273-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BEAC24DE7
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F381562384
	for <lists+linux-edac@lfdr.de>; Fri, 31 Oct 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D5347BB8;
	Fri, 31 Oct 2025 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="F8dpL654"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066C346FB0;
	Fri, 31 Oct 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911578; cv=fail; b=GDAzfXU13K6nf21PjBKlG77SGLtOC3SvYKtrxBp1cGL/5syt/5R3lvyf/XUXgrnougNjVw6LTxB60GqY8a72lcfz/xgzQ9G/GwpUKJ2mLwLMfH2k4Tr5kXcFVMyohZ9FZgATYwp2+CXa26CtYvqgFwXrEdnmmm09PHPBjgrjdYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911578; c=relaxed/simple;
	bh=J00ERh7pxE6m1EkJpK9t0f8cBqhuL3hyWqk/OgLMwvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OPX3MgE3NzvJtcOmZtdA+lG/UDhb/v64T2vHHcfUIqrZRRLnloDBHSKKlteEPFOpuwTHpwp+1dp7JI/i2klHFRL4ltp3YzV8RLfzMkSr9PHoyPgzZsngvSPpC6Q7YKaOQcZyiO+tISflTNK7TvTJth3D1kOgMxMSZS1A9uZ+egw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=F8dpL654; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptV3ivHJ2+Vhtqw+7LfHhr7J5qsIc5WhIUdV6x61sTIUStqMgDlS2k/kOQW8Q1L3+milpDHpOnMT2/AUIRuW8gP2vvo/RF/Xn/TpMJ9+lDd4rCS5g/pu0mqANWAvOCun7OQw4XWckfOJ8qwh3GVBnGxALX9tR9XtwfYSoEnFo5OgcfwVTDhD8S+V20v66/hjdBU6URrEldLDPdvTFMfaSvA7v9BeSWLHYD6UexDkZlYmc61tAUdpw0RNWQ0b1vip/+eGhu9CXH/bL05NK6VOI9lwUOiL3cwTaDFC8Iu+gOG9D//nyjGfKzgORZZZWD157FTx6gByQmh8v16yOZVtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QznhOdgCGkoE5XJ32yecM8L1CgoHTAqYu7b3zywpQ4s=;
 b=Q6j7t/9fT0hqp7QQw4/4rZVFv4DI9iT2JP+0PvTcUidFVbVVulwsKkELyBISW+c+toyID9COGfmmch9X8Apjtz1OkWlUrmbRzoxLYiXPjK5KkuKAxVTOyutc+JGQGkWEOqiBnXdt+piTqpZM+b7PS5JDzs8qA0rrukxUA5I9ow+xTfM9ZQT6x3BUGIRfKwVwnAkJoA+9nswZJutweAcbpYP2C8YRakIX81DAmq1V+TPkmpv2AQoirhWdmFgM09LsNYL2JTK6JaJ4jYF8hh5VWPcVgbRLM93/0m3Gh/h80duPfUpFDA/oKR9g8/oSJec4yzPHlrEzrOe2oriPK1P/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QznhOdgCGkoE5XJ32yecM8L1CgoHTAqYu7b3zywpQ4s=;
 b=F8dpL654l+v5TJP4ZDbt0xSSLdjQroCt6L9tcigOubDWHieO1eQjVACDsVU5s/6xj2/ASisbmQp8fUB7Nm/i4+VTXOWbRKSsbM24F+nAOc/vCTFTZrSjJ/lhBwbpHSpmahAAJaP6wKtwXz5K4Qsh/g+u9iaSjQD570Rwh3hEWs8PzhSFo+G/cmDAUR0DOJZPXrp0AMTJdnD7NPMLfn7FuQpo8Zz+WvgQNCCtF/yVHflz7c9YO8QE7DvDDYwOsBmXw0CyDjg6ppRsBUBh8+x92x6vaVEYLxZSXSFjSX7Yo9ZO6V1EFKtziWyA8hvsX2kFxFnX0hZyo4dUUP0NwTSNAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SA1PR03MB6612.namprd03.prod.outlook.com (2603:10b6:806:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 11:52:51 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 11:52:51 +0000
Message-ID: <24d2beec-129e-4545-b777-c1c717be956c@altera.com>
Date: Fri, 31 Oct 2025 19:52:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] EDAC/altera: Add IO96B ECC support for Agilex5
 SoCFPGA
To: Borislav Petkov <bp@alien8.de>
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, tony.luck@intel.com,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-5-niravkumarlaxmidas.rabara@altera.com>
 <20251030143051.GJaQN2m2fniYVRtBxn@fat_crate.local>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <20251030143051.GJaQN2m2fniYVRtBxn@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0091.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::14) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SA1PR03MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bbf6ce-393a-4c99-8282-08de18740491
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE5mekxzYzBQNWxpRmI5aUY2a2pITWpIQTFhbFhESnlaZnlFWWJHVGtsaC9h?=
 =?utf-8?B?bUJmZGMzVG1pNnFaWHh5UktUWmMrL0ZOdXJwK2R4R2VFQ2xJM3lKVDZSSGtE?=
 =?utf-8?B?RGo0T3Q2a1BqNnBZZ2xrajZQSU9Wb24xelNDOGRxZUx5L3l3UzJIdG04WDhW?=
 =?utf-8?B?TUo5K3hvTm9uNXpYdnNnU0xBaGx4WE55YTF4Zi82STdOMjdpYWhEQUZHYnlK?=
 =?utf-8?B?d3RrcmEyTklKMC9xN1FEbmJqWEdXZzhOU245c1kwTEpibWVFc2ZWQVZGVmg5?=
 =?utf-8?B?cEtCYmd1Q1lhaWcwSE1Eem80aTRubDc5ZDYvZ25renZFc3haYmc2WGhxK1VX?=
 =?utf-8?B?OEs1YnptTHJVbWN3VHllNit2MWNJRWxidlZXRkJ6WlFQa1lqTzEzb0lVZkNC?=
 =?utf-8?B?UUk1NG5BbkhHNXVxZSs2Wmpaa3NvNy96M0ZBeFBZOXFYYWpiczM0bUpNK0JY?=
 =?utf-8?B?VGxFM3Z2M3ZZckV5cm5mU3pOYnNEcklPSWNRb1VyeWRCMHc0Q1NJMStXbjRL?=
 =?utf-8?B?dVc2QlpYTExzTVZJMXU0b1BaWDJHNkJFalowUW9ZMGppWTJ6cGtsWldNbm9Z?=
 =?utf-8?B?MUdiQVZFWUtKMW5HQ21WY2duK1huZkZaYW1QVVBHYWRSY0VlRGxGQXQvMGha?=
 =?utf-8?B?ODVuNHlEQjA1REJkZGszSmhFcVVVcVV3d212UHUzeXBxMnErRmtlVUo0djhk?=
 =?utf-8?B?TmRZZHJnYVlGR1k4MWErY2FESzNLczFWV2VXRndHNDBkSmJSb2x1OTJhNnZT?=
 =?utf-8?B?d1UySm9kVWJ4T2JacGV0U0QzQmtVVE1VQjZYakdnby9RYXRyREtDSzZuSDlN?=
 =?utf-8?B?K3lzSHRTKzZ4alE4TlVyWm1iL2VnOGJCNzhHQlpSZHBPVzljVVkyMzRXZ01h?=
 =?utf-8?B?Tkx4bmYvQlltSW5qeGI2ekFiWkZBR1BVRGVjOVRuK3NWa1Nla2FBcXVXbGpy?=
 =?utf-8?B?RmI4Vm80UWRHZ1pYc2NNSno0bnpLd2FUTVU5bmdzaUdMNXBDM3dUWHZlNnMy?=
 =?utf-8?B?TXlsZUFPcDVPVEl6VG1UUmtvOUZqdVhUQXFyd2dlL3RxaWZOcXNuWUtEbnhj?=
 =?utf-8?B?NHdUcjBESnBVODA5SFJoVkNNTE41dEpGTml0cDdRdzlvYVFubDl1bGJWRzdT?=
 =?utf-8?B?b2VuNTlXQVl6L2FYdHFuYXI4cjlqS1NHa0k4bXRlTVd5Q3JkL3dDTXIzSWFu?=
 =?utf-8?B?QjJlZ3BMcDh3SVptTEd4ZEZzcVNtV3ZCZkgvY2E4QWRpUk41dlhIMkRCUkg5?=
 =?utf-8?B?N1lnRFI0SG9TVndjRkNiQ3ExUE9hczBQOE9HanVYaUNoMHdWdHlscUtkNTN1?=
 =?utf-8?B?cENZTVUvZVpTMHBYZGpONWhxdjdyMjBpUTdrYlFWOEVLcFkvNzZYYXYxczM1?=
 =?utf-8?B?cG9hK29tSnlrUE1YSU9mMlFqN1RwazZhTXR0NSt3UHYydVk0aEU1ekNSSENt?=
 =?utf-8?B?b2oxWGZNNzNQR05TWlMzb3JHcHBZZ1lKZmZGWGlOcUlQWGJxbUU3QUFtYTQ4?=
 =?utf-8?B?VWZOeGJsUll2UnhkZ21wVVZaU04xZ2JxdlpHV3lKMWtlRTdETVNvKzFWQW8r?=
 =?utf-8?B?RjVCSjFYNG9NTERDRU56VkhQN3hpUUtzRXJHcnZWaGdaRzVRVlhnS0VVSEVm?=
 =?utf-8?B?M1VJQW84SWZiQUwybmhmUnk4d05UVlkvaFhZYURnVS82Z0l6dzFya1BieWJL?=
 =?utf-8?B?Y2NvdkdQN1BCcDJvOXpkK1QxL0FKZFkwUGtaYkdUUEJTeXcycllVaVl0dlQz?=
 =?utf-8?B?NzIvWWF5T2xUS0dxUGNOTDExVFNMRnVSSmFGYjA5QUZIK1haL3Z6YnpOUVor?=
 =?utf-8?B?dWRlVEprVjhXSmV6S1Z1aHZnTnFlU1BvQmQ2dnMrcVBjdTVzcWh4WTVQNzdu?=
 =?utf-8?B?Vjk0ZXdyK2pJMVh2Tm1ZblNicllXYjR3ZW5ZNEZIVWhpczVkZDJWSG1tdXBl?=
 =?utf-8?Q?cvPKNX1IiC8JZGf/RtIb94sOsA1cRCd3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVpFUjhTYytDL2JJdTV3Zm9XcW9SM3IxMjFrYk9VWmdOQTJzT2hNNU0xMGVZ?=
 =?utf-8?B?a3BiTlROVGdlckI4RTM5R0ttZUpRTlIzakNGV1N2VGs3V21leWorRDNjNzhQ?=
 =?utf-8?B?K2JKNFRmQU1EaWRXbEM2cVFYQlhmdUtYMWhoWFdXWUowMmxyMUFYY0ZlMXg4?=
 =?utf-8?B?bmx0eUh4Ym5OUnhjWjlQaE4vRFFvVWJPT2tXbWZDQWdScGY2SUkxcmo4aENP?=
 =?utf-8?B?M3hDNHcxR0Y4T3ozUkdCRURRS05kSk5YOFFOeDl2d0lMT2tGUVNWT3lLdDR2?=
 =?utf-8?B?ZXRhclM3M0ZIWUpXZVZteEVLeC9jV3lJbXRlWHQzbC9mMzhidzBheFZ2eHlh?=
 =?utf-8?B?OUpTdkhCclFESUlrYWNUYkZSUjN2THBCS0NCQlk0bnZVMGpFdDJxWUZYWUVu?=
 =?utf-8?B?N1BaSzI4VzZJbUxKK2dVUG53L1ZLL3dUMFVxdkMwZUFZRVczeGQvUTRibU9z?=
 =?utf-8?B?T2FlVWwrRXUzQlM0VlBwZmJ5NEVTbDhuWXQycTNSR3JaSmtLY3NTL2NVNjRj?=
 =?utf-8?B?d25qSE5LQTRZMCtmc0NOa0pDdkVnS3UwVkFmNVJWSzJadzJrOVMrK1hpYTJ1?=
 =?utf-8?B?dTZ4cStUZCsveVgzRHJkQXh4Q3hYTGEwQ05MRkR4emRiYWZmMk1sbVBrbmxL?=
 =?utf-8?B?d2hFRmt4U0tBK2haS0FUcWJVU2hGbWVMRnlLNmRKaUNla3VLQVkyWTVXOHFS?=
 =?utf-8?B?eXZyNC9qdll5QkM4Nm9ydExCaXh5dmlxbUdWYjNFQTZmRzBjakY0R1RyendT?=
 =?utf-8?B?TWtjNjlQcHR6aDVMZnFlRXlIZGtObktudFJid0FiRUt5eHhncWw1MmR6cFgz?=
 =?utf-8?B?b1poRjFYMUJvdjNISFpma0toZFp0UmQ3WDBPYXV1VUorVjZqcnZaUUF1QWlS?=
 =?utf-8?B?UGw3UjdPN0szeXZUMk4yUDZqRy85WHgzWUNNb2VFUjhEU2RURm5EdUR4UTNK?=
 =?utf-8?B?WTBtdjZGa0lKdnRZOHZIWnhiYndadVY5eEo2OXoxcUlIK0lPNU1SNGlyaU9z?=
 =?utf-8?B?RVJFV0QrNkFaTythbzZsM052WVVzTVBucjNmTm9TRXVsM3V0elpjajNSdHF5?=
 =?utf-8?B?Q1BhOU1EeThqRlpTaW5EaGpiUWk4d3dqdVoxanpISjVHRzVxRFlVdE1BYUt6?=
 =?utf-8?B?WDZSZmRzL2hvWWt2L01vK3VudG9OVVBTeDEzM2FRQ3YzcTFpZ1pIU2hOZkRK?=
 =?utf-8?B?ZFVoOWYrNVo4ZXdBcWd5bWpWNnprd1FWSEJVRllzNFIwd1ZlOWZpL1JVM2Nj?=
 =?utf-8?B?eVBKekUzZHlOUHpScnFQb0JSMnZrekE3STB3aDFjNFRocG1qNnd4bWRSTWFq?=
 =?utf-8?B?R0YyQTBQMmFxMW5CaDFXYllXRzM4NjF5Z3VOUzBHN2pFYlozdlV4TlUvaHk2?=
 =?utf-8?B?QUl2SW1HZ0c5K1RWM0s1TnBxQ2hDeS9oU2xjL2FmK3cxVGxVSWYvbG1kck04?=
 =?utf-8?B?L0xEZi9BQ3ZySWNCaW1jYWtBRnM0dy9TZFZoTS9Lamh4RHFaalhRcHozSHBq?=
 =?utf-8?B?NjlSZVJmdkcxa0FwSVRqM2ZVdUp0R1FTNWNKeWlJMTRBTGZsZGpMaENpTDF2?=
 =?utf-8?B?SWkvZ2lyaThjU0RoYm13MElGZlYxUVdyanRJb2gySzFSL0pSNXczMzVHN3BV?=
 =?utf-8?B?R2tmSDRmUFArNTNUVktLWjRDTnJseXhCQm5jYzY3ZC9oeks4eXV0eE5HY2lr?=
 =?utf-8?B?WVhta2d2dTdYbkZzYWRBb1d2SzNXYlhYYSsvM3hYYVJxMzJGV05rMzFVOHBW?=
 =?utf-8?B?Q04yTzVoU1RMei9rSW1UZTdaQUpVN1k1eXFoY3dPR1BOdHlXSFg0SlZXM0xa?=
 =?utf-8?B?Vm1WVzFJZEZSN3FHZ0NaRFlYVXZaNWR0UDZ6bzgydnhxSGxkWVpGdGhUUU1k?=
 =?utf-8?B?RjRiS1FHdU5RTDZyNTgxRitPektVWlR1TzZEOXdpMGRhaFg1R1htSlk5RGtE?=
 =?utf-8?B?Qkt3YjZYZmJieFl1YTBzajJ2SEw5cm42Y3o1Nm9RUEhveDRRNEUrSVYwYlFj?=
 =?utf-8?B?eStTbm0xcFc5Kzg2OFN0N09qUGUvR2F3MzI5ZFhvZHc3c2RLbS9FcHNTaFlo?=
 =?utf-8?B?d2VySEg5Wkt4RjY2V3I4Wkw0dW1vUElBeklVTGhxUDhmMTRtU2lNSGVCd0hp?=
 =?utf-8?B?TWVPaTlpVGFiUHNNUlQwb2NqbjlZaWFYUXZwVzRrV2I3Z0tpK3o2T1ljbXJT?=
 =?utf-8?B?T2l6U2RqVUtvTGtaS3VVMTJQTVp4ZDAvcTMwbDhjU0ErM0JnY0QvZ3J4TkJ0?=
 =?utf-8?Q?Uy0MBOI0KvUxTqUSdvfxuvyEgHzoBf+fiZ2RIVFvUY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bbf6ce-393a-4c99-8282-08de18740491
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:52:50.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw3GxnLALQK1oXxi5Tqi/4BCoekMPwPWSUw8qYtdD+CMzMpRXfmpBjuBCbj5nyw3ru6SZ2ZxvBKijbxPc/URcFo12o4A/m8mtYT0HWeb/ZYQI5TOKqt0ooG6+GwW/bGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6612



On 30/10/2025 10:30 pm, Borislav Petkov wrote:
> On Tue, Oct 28, 2025 at 05:22:30PM +0800,niravkumarlaxmidas.rabara@altera.com wrote:
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 39352b9b7a7e..33a9fccde2fe 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -410,6 +410,16 @@ config EDAC_ALTERA_SDRAM
>>   	  preloader must initialize the SDRAM before loading
>>   	  the kernel.
>>   
>> +config EDAC_ALTERA_IO96B
>> +	bool "Altera I096B ECC"
> Is this and the other new Kconfig symbols you're adding absolutely needed?
> 
> IOW, why can't the driver simply load on that new hw without needing Kconfig
> symbols at all?
> 
> What are they really saving?
> 
> Thx.
> 
> -- Regards/Gruss, Boris.


Hi Boris,

Thanks for your review.
Your point is absolutely valid — I was initially hesitant to introduce a 
different flow in the common altera_edac.c driver, so I followed the 
existing architecture where each ECC device has its own Kconfig entry 
and corresponding #ifdef blocks in the code.

In terms of savings, this approach mainly avoids compiling code based on 
Kconfig selection.

If the preferred approach is to detect and handle the new hardware 
without adding a separate Kconfig symbol, I’ll revise the patch accordingly.

In next version, I also need to address Krzysztof’s review comments 
regarding the introduction of new ECC device names in the DT bindings.

Thanks,
Nirav





