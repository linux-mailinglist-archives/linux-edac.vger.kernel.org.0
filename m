Return-Path: <linux-edac+bounces-1344-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416591319A
	for <lists+linux-edac@lfdr.de>; Sat, 22 Jun 2024 04:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35761F22AEF
	for <lists+linux-edac@lfdr.de>; Sat, 22 Jun 2024 02:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485179C0;
	Sat, 22 Jun 2024 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UX/ylSgo"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83002119;
	Sat, 22 Jun 2024 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719023067; cv=fail; b=FAVEgsnD2VkAqMmnNvmLEeapJcTxWrjKOzm1Y6fkYHRvBjFenuRcgqZ1a7Rk8yc0D/XS2W0MwJDcnjkw2HIGUhMoSuNsbho2bcDG3aL9n1ytq0LwpPwVEqmm+x9iMwc7ZYrgfjFxmvVE8/LzGFdsTVYa8ykpmt1jF+Kgj4IPjb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719023067; c=relaxed/simple;
	bh=RNUSnIMg43Vp5XfPtXMqQ8bM3bJOekbmfjW3gZBx6J0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ThZpJApJUGlCaiRk/Ukyz7nDzUj/G5RF8r7jkW5FQedZhaG41CEFdUKDLA4E3iWoI7fR8eKiCbThDudD8u546hsn8UCHw04AgccdspwMBcbZ/qjgO4n4nb+CSs4BhE0XcB7Jhq6/XdTr1hSVVQjAYgH6ddWkDHniJOqW2p234MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UX/ylSgo; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVhPW02ueiA9is11qe9iLs3i1ByCTHQuJm1VXdHNrJ38N0Pe3LJ1M2NQBwPwjyvx84h8SpCJGp19i8QLCSB696d+ICp8iwLwX6zp+zmN971UJkqLyQdmFYXnEmG+2QfN6VN6wK1nRgVc6S8iJq+SwQgOKmJV9Tce7yIEboRYYDXgtv9tyvjxvbrJnShzJbvQdONn9MUqCjl01R6U8l6x3yHnJZPpdPGtS5YBfaaKhwBlL1E0Z1tenxHZaJ1BbDKtjKVsARUWGMaEpjZI3LaVGlsrj3a6GS4A0TuAyTKsnNgKE81IaOO4JH9HhrQPgjKUwVFzsCmxLHtemLD4Jzn3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmyblZZ+TM1+bl3udYC4ATbWWyjG72AYhzGghUMqqpg=;
 b=Kj6wLvh9KIVVM3aEmPBaT7b9DKEPHcWNDdnFBXO/wgI+rLf2s5lpHOxSrGZAs5xOO1y066ZtOw4+sFJXb6u8efW1Umy+m/ApjWdE7uKBRyuEuSVR3F/uj/+SM383SyCpy2p0reXcer/QaAmm+zTpdch9LKmqYzRky/WNGJC4womciIL6cTefsz9rDN2jYQif/wKqCMVptaXYbkAzYJKnClQ0RYwUaLuMYfuI/69WUQjgYXlGdZEbmUFkUUksuFxKRVT5j7vtlFNNk2t6V4ZkFfB9ZCr8Cn/e8gres/ivQe+f2ZJDfpAjEDC4QNX2YD+XOyPcfpzyPE29XnSRFW9o2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmyblZZ+TM1+bl3udYC4ATbWWyjG72AYhzGghUMqqpg=;
 b=UX/ylSgoz8uFPfKWVbWN9AzirG1/ZK8vxCG0llORDVxknecvNNzs1hgyvto+HBj6Gf8t39Ecrkujv1m7C8olMyD3XML1ISDbEMrDLD+OWc66KwEBboct2NGSoCQ6lX4HyZoVX7jpRNEo+MexNjPTStDgL1OAvQ4fsiwnazS6gjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Sat, 22 Jun
 2024 02:24:21 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7677.030; Sat, 22 Jun 2024
 02:24:20 +0000
Message-ID: <7603da2f-bbe5-4e39-ad0c-334e26fe53cf@amd.com>
Date: Fri, 21 Jun 2024 21:24:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] MCE wrapper and support for new SMCA syndrome MSRs
Content-Language: en-US
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
 avadhut.naik@amd.com
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, rafael@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 john.allen@amd.com
References: <20240530211620.1829453-1-avadhut.naik@amd.com>
 <20240621165823.GJZnWxLxd9BVhQDBUU@fat_crate.local>
 <20240621200110.GA5956@yaz-khff2.amd.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240621200110.GA5956@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::29) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5fa319-52ac-41e4-2f30-08dc92626c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1o0NUNNdHU3K3JyRGVzWjVwWmsvV3B3YVlyQ3F4ZHFHNUVScEd2enNOdjBV?=
 =?utf-8?B?OGVVeW5iQ0pnVmZvamZ4Z3craGZ5d2FTWW9oQVpHQVRKNDBMb2RBdXg4YTdU?=
 =?utf-8?B?M2d4VGE2SFBYcGRSUndkVjRlUWcxQUFnV3lNaVFzaE1KRzJHU29mMm5EWm1k?=
 =?utf-8?B?NjJlYzgzMlVqVCtVWm12a0tveGdrSEMwandSY3ZUdmtnTmUrU2Z6STRaMjdX?=
 =?utf-8?B?WkZndXdaTE5oWkRuS1lSdUwzdWNtdTVqZXRQVnhla3hzZ1ZHVEZTcTFBNXFH?=
 =?utf-8?B?QVJNZEpkSExYQnE0L2s2aGkzM3g2U3JxNUsvZVlhTzQ2ZTBkemlLL240Qmd1?=
 =?utf-8?B?b1hlS3R6Rzhna3dBeXgwbFlPZWpIVlY0Y1k5Z0trcWMwc3B3a2p0WDlrV2wv?=
 =?utf-8?B?UVdsYlBmWElsa25mZ0JDNkV2S3FDZm5xM3dMalliMjFKZ09IOVRham9HMDJ6?=
 =?utf-8?B?b0tsN1l2SWpTd1d4bTErTndOL3pTdFpuTkJVazg0alhKQjNSY2tnbWcyQ081?=
 =?utf-8?B?NmpMWW9ZalBWQjV3OTVqVCtPYnJValNaUHRwTWFCSFEzWnlnVVcvMEF5VjNl?=
 =?utf-8?B?ZGdnaHFMMlRySmtKQVJhOGx2NmR1Mmwvb2lXbnQwZTkvQk9JeXcxSFpWRmdI?=
 =?utf-8?B?K3ZUVURQd1ZHbml4SmtGZW50VnZMZ08xNkI4ZUFlQVpreXMvY2JiOGRmVzdG?=
 =?utf-8?B?ZEJWa241T2xhVWlvT1NrYlpwUHJrdGF3MGdOTjJoQnRSd0xFbDVrMGlIbHlF?=
 =?utf-8?B?Q2FVZTF5aUl4K3JLeExLZDc4RG02SHdIeFk2Y3pjRUZsVlpjeTZwSlVhNDBm?=
 =?utf-8?B?SjVsalZiWlZIWFp4a1lFVkI4SnZqRGpDNVFkUjJSTGdNTU5Ma3hCRCtFdnhv?=
 =?utf-8?B?d3VzWVhOd3VnL3FxYVd1MjYzRjhOemtveWRRUVhwVVcwckRJOHVsVW5qcjUy?=
 =?utf-8?B?UlF1djE3b2s0a2ZCUzZDUWxuSXJDaEhRd1lBRFZYWnlUVU1uUW5OVGJYYlZH?=
 =?utf-8?B?eFpLSGZBMEtGclRUS0RQZ2E0MWk5YktubmdmL3FEQTllMDVVNTZqanM4ZU4r?=
 =?utf-8?B?R3FhSHU2dTdhaEM1YWlOSDhNNjB6SC96aVpvUVJXRlZxUk1YOEp0SklETU14?=
 =?utf-8?B?OFNnRkorNHFWcUxwWXBNNW5RbFVRM0VMaVlhc1p4SUxwYXRjVkVOdjRUci9X?=
 =?utf-8?B?M2VuN0pXVmFVSnhjQlhCdVZvZy8yUkxyWnFXTEk0OW04TFVIeWVVVVNaS1lj?=
 =?utf-8?B?N0R1Tk9nVmFZSEoya3NwK0U1ZDlLS2cySmtKQWphclRlSHNYWXFpN0xsZHdL?=
 =?utf-8?B?RWVrOEpYL1NidGNoSUlLcitEVzVDR3NrS1NtVDJkVUhpZkoyWE9zeTRpbzRB?=
 =?utf-8?B?ZXFMcEpIZDBrUWVvdUxENTNjMldyTnZmQmprcVcxQ1NjK2RUWnl0MGVPQWZx?=
 =?utf-8?B?dWxySm5WdDd2ay9maFBvbWdKNGd6MUV3c0V5NmZjSUxhNjh5cVF0OXI1NzdB?=
 =?utf-8?B?L29WWWV3TGNVdk9TR21aeENnSE9jMWJlTVpmSWpnM0Q4bGpUUnoyTDdvNkJO?=
 =?utf-8?B?aVgyNElSOEJEaldDZUIrNkJUSW95aG9zSi9UQTF5cHo1NjRaZVRHWHFGejZk?=
 =?utf-8?B?R1BpdWtDUjBrMncvRXRQdVYxMStvUjdXdG1CR1VVcFZSV0dqWHFGZC81UGtG?=
 =?utf-8?B?WXdLYTUzRTRxVGlTZndLbzlhS2JPdlk0bnFLbW9XVWZoZEdKSlZEUUZGNDBv?=
 =?utf-8?Q?xBDdZdMjeinPfXAkVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnR2NWIrNmlwMmd6VHJqUUFRbkZRWTg5MVBHalpFT0c2Z0pma1d0alpyZDBR?=
 =?utf-8?B?dFRXUG53U2JXQ3M3anc1RitjNG1ZMmtmNkxESHdrcmpNbFdtbUN5dXk1T2p5?=
 =?utf-8?B?VEQ2ckNhMFpMN0krQUowS0lXeXN1dUFpd0RnR280VHhkaGN6THEyVVdBNmFC?=
 =?utf-8?B?NjJTYmJrQm03R2s3TFNkRE9Qang5YVpCN3ZzekpUWitIT1VlSjhKT0libE9Q?=
 =?utf-8?B?VyszU0F0eGVSZFU4UElSTVhYVlh4b0JBSjM3S1kzeTJKUGRFSk1KTC9NMTcw?=
 =?utf-8?B?K1BPUGhBd3d5M21qRmh0bXhjK2dOZnNaeXU2M3VScG5nYldIYUl1ZWgzdkhw?=
 =?utf-8?B?WnIzSURONENwK2Z5WkJOdnpycHcvQXcvUmlZdlpLL2hYVm9GTStzM1ovWWF4?=
 =?utf-8?B?eEJVNjkvUWJNSjNDaWF6aFk1T1liMmxSakhGYVJPZ2JUdWQ0M1ZaNTlITU1z?=
 =?utf-8?B?L0xoazF3d29CTklJN1RicldMQitWZXhrcEpac0owR0krQWlWaUFVZ0FiUHVG?=
 =?utf-8?B?RGJQMXArUUxRRlFzZEU3SERlNXo1RmpwQTc3MG5ZRFpVY0MzN3QyUWlOSkVn?=
 =?utf-8?B?bkVXNndIeE0xUThUcEZNdDBpVXF6WkwxMzhaUnFFdWxUdkkrTHFROStsZDdh?=
 =?utf-8?B?RTZtbXBCdm1HeHowQTlybVlUVjdpK1RjSDMrd1ZMeUg3RjdMckg2UjZCQkFz?=
 =?utf-8?B?NzRHYlZQYlJzd3BQZXlza1BPN095S1hmTnJlYWpaRUZCMmJZVDRNbDRSbmJB?=
 =?utf-8?B?WWRQbU8xb0ZlV1lLYVB5RERNTjNlU0ZLcmlyS2oya25zNjRhQ1VuQ3V5THJF?=
 =?utf-8?B?dnJncC9wTVhaQm1pUE1PUS90RjNYeGRmSy9rUEFmR2VNZm1Wckdpc3Ruekd0?=
 =?utf-8?B?Tmhpei94UG1oUVN6ZFVhV1pBbGJqTmM5NVVrdWtJQjZVWmVSVTdjRTB6NDV0?=
 =?utf-8?B?SFFBZzByalB5N1NOa1lHRVVNZHQvU05oZlZaYXBqVUtGTlZBRm00RFZTc1dn?=
 =?utf-8?B?bUU0cWlPZW9BdjBidUdJL05iN2l4WlowOWt2RzlJQVRSZlIxbnl2c3o4bUdr?=
 =?utf-8?B?UVdLQ2NtM2pMYWNhTVowdnROWWkwVThZRDBUSGVrMFgwb3duc2g0ckU1K05p?=
 =?utf-8?B?QklBSjRnOUxqTVlWWXRnOXdHRS9ra3A4UTB2aEJ6MzJxNkl3Z3dxODFoK3NK?=
 =?utf-8?B?SklXMDdueUw0YzYyaHAwcXkwZ04wZkJqSnNPbXNwbTFaRS9ZQXZMQzhTU2ll?=
 =?utf-8?B?TlBydjU1eVM5UXNRbGVZdVM3QjBONHZzVFY0RDY5M3VUQTVBMGRTcEs1b2g5?=
 =?utf-8?B?eUk5enRuRnF2WTVIbGFkRVh1YXRURGtqekliWktkVSt3REF2QkxBbTkxZG4x?=
 =?utf-8?B?VmRUendMZXhpVmlWT291SEE1Qkg1Q3JZTitaRHJxVkMzZDlBditFcXF3KzBm?=
 =?utf-8?B?NjVRZ1UrcmloaDhzRDNhNnpTT1phSXgvS1FvdGtPOGNsV0hOTmhCam0vNEtp?=
 =?utf-8?B?MjhyTXdYc3l0eGhwZk5NTWhPWkxUYWNsVnFzcTdvMHZ3Ly9pbDZ0N1J1ZzhC?=
 =?utf-8?B?dTVKMFBmcjBzK1JpN3J4Y0dsV0wyMy92QkJyazRwb2lWbGJ6ZXBLQmZ5Z0dQ?=
 =?utf-8?B?RUE2Vllzb05aVytqemtCdkNiajduVk5Yd1U3Qk9uckdzUWkwSy9uT0ViWTRj?=
 =?utf-8?B?a0pWYWhXQVFLVGlXK2FWQTBUUjRWdTBJQ042OHRlVGVvUHhyY0sxTGp1Zjlt?=
 =?utf-8?B?NTV1ZW8zdE8rTmp3NkhvVmVSSWFOQS9Ya28xZVZ1aTRGcFV5MGZvc0hZRkVK?=
 =?utf-8?B?L1ZSQml0QVA1TzhVdStOa1hTTVlRa2NOdE5adnZzL1pId1JFbzFYZ3V6eWdm?=
 =?utf-8?B?NGVsQTVSc2VnRFljTG1NRkFjeFdjaVdnQ0NucVlGRnN2M0Z4TDcxbm5GWEF0?=
 =?utf-8?B?KytuODFsUFVmZjhodzNUaHQyQTgwWGhuWStMaitFVjZ4c1FBYy9UTUczZGEw?=
 =?utf-8?B?b0JKNjlnVFZRaFhKTTNOUXdRSEpsT00zdmhnck9hNlpjYTN3SkhWVGVRSkNF?=
 =?utf-8?B?SzdsNmt3MEkvOGs3cE1DTmk1Tk85MVdETVdxTnZ3dkp5Y20vbFQ2b1dSbkor?=
 =?utf-8?Q?04o1mY5ErMEl524H55EMJrXOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5fa319-52ac-41e4-2f30-08dc92626c5a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 02:24:20.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vp3JipaFGMphmR+cGxZRqVr4M7DhQCMlx44TxAKw79EGsAmQbfQn9wFGx383ktIAEmhJHsZVqd7v+mm2hZ0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014



On 6/21/2024 15:01, Yazen Ghannam wrote:
> On Fri, Jun 21, 2024 at 06:58:23PM +0200, Borislav Petkov wrote:
>> On Thu, May 30, 2024 at 04:16:16PM -0500, Avadhut Naik wrote:
>>>  arch/x86/include/asm/mce.h              |  20 ++-
>>>  arch/x86/kernel/cpu/mce/apei.c          | 111 ++++++++++----
>>>  arch/x86/kernel/cpu/mce/core.c          | 191 ++++++++++++++----------
>>>  arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
>>>  arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
>>>  arch/x86/kernel/cpu/mce/inject.c        |   4 +-
>>>  arch/x86/kernel/cpu/mce/internal.h      |   4 +-
>>>  drivers/acpi/acpi_extlog.c              |   2 +-
>>>  drivers/acpi/nfit/mce.c                 |   2 +-
>>>  drivers/edac/i7core_edac.c              |   2 +-
>>>  drivers/edac/igen6_edac.c               |   2 +-
>>>  drivers/edac/mce_amd.c                  |  27 +++-
>>>  drivers/edac/pnd2_edac.c                |   2 +-
>>>  drivers/edac/sb_edac.c                  |   2 +-
>>>  drivers/edac/skx_common.c               |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
>>>  drivers/ras/amd/fmpm.c                  |   2 +-
>>>  drivers/ras/cec.c                       |   2 +-
>>>  include/trace/events/mce.h              |  51 ++++---
>>>  19 files changed, 286 insertions(+), 164 deletions(-)
>>
>> This doesn't apply anymore - please redo this ontop of the latest tip/master.
>>
> 
> Avadhut,
> 
> You can drop the dependencies on other sets. We can sort out any
> conflicts as needed.
> 
Sounds good! Will redo on top of tip/master and resubmit.

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik

