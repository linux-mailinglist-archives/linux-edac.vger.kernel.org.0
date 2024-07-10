Return-Path: <linux-edac+bounces-1493-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E106B92DC2C
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jul 2024 01:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9058B280FA5
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4BC14B95A;
	Wed, 10 Jul 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gsbkfP0K"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54567328DB;
	Wed, 10 Jul 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652395; cv=fail; b=KiJxoBLkO1ZCT2nqNLSv69qGgIznT69h5/jFNXKAGziItUFDu53RtsJLV5WzFH+EtgRIIkqvhQH/rjuxmcpnlB9v0t0454hiQljZkcSRMEhDEyYD2ewmIU+HQ44ctwZBye7wrfWZbV8JsJYHoh7tuOzGYJzc7MSIt8fALduhOzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652395; c=relaxed/simple;
	bh=NvXlY6RgOoh/joW+wQcTV+EmXOcBYmnEQzxnbhcltU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4oe/RH52RGT1ell3sxUGQxU5My7i2IgD0HRWy8+vY6Xl/LaYXPZ/tn2oJc9byhOIj1Fx9IYL9aYDo80uGf7eURdsLC01B3hwenll2sw/wSu6s2F9B4nl2Ajm/mqfQqgxZVMYZZYVAoOYG7IRp1X19Am7M8oGuuEbWY1sGthzn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gsbkfP0K; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4n9HcxImuv8m+yWBAtFLk2H+LcrSfR30U89UHYPwadOUtkZTFXMzTaxKAOOrcDucaYYnR4s3uZMUEEAyrr9O3IkgSS6iXoktNlqQlEeiQGfA/ceJjsaleNBkvSiPh4ZeEm2viUyo+UgaB4xmWrZNfYmr3kmw78rJdZHINV1yyEBskc7geqAz1Q+KvBQLGk0qx/3i8oCie3pHPLbGbPQmtb3xUWa4uF/MKj29w0kr0CMzZWBfSSBhs6mP4YBMV69JjhITkTWqaselKGupRYfiXe/IaCnLy2Hei7lHgY6IEK7g278LMKkPthvLSCuVkTV/DKstQgEixnwciEE23Gl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xPrG8Dt1GCpFEcdSgzoolu+NtafuUQvA33nRZ6WJHU=;
 b=SoS22AZ92V1CxWNM0wRRDckI1M5MPnmM8stWLRODwWOdqy2v12Jh8ZaTkIHlyA14WrnoQw6aCpZ6xzFoS+Cv/ecIuBQdN4wvgzN2HX73rmEU8kUcYOxzzHFfaWHmjUYhNiSdJI2aTQraLQEd1xjzfiPQqOvT325/Yr4QtfYhwcg5xv08NZjKiXZAJwCuBmYCw8ilOf6VqMobOSCds9nMLerMwbWHhQKn6JWilxYwYfuR3skQBNmROsNvnO4E1gFtsyB0RvLFSJFBt1PWXJ4GA6f82gXgV0qDO8b/ry6SJfQPlHItgmogRcp1+re5ptoeROCNG2tcgsnCb2lbhg5Vyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xPrG8Dt1GCpFEcdSgzoolu+NtafuUQvA33nRZ6WJHU=;
 b=gsbkfP0KUKCDrdD2PCXnhufU+BirfY9a67FzhcFLheFRBDyTtPHdw3Pckdf37+0yp93zpU25KMbgqL/RmZ8BwiekixafCrlKhM7kpvwuL5D3lH6t0DjH679B3WhJSvtQ11vdZY0F12BY7eIfm+tpk+1CkM8Q1oobWYFikf4ywyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 22:59:51 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 22:59:51 +0000
Message-ID: <ebea8908-3069-4892-97c1-fcefaffa079c@amd.com>
Date: Wed, 10 Jul 2024 17:59:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, rafael@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org,
 mchehab@kernel.org, james.morse@arm.com, airlied@gmail.com,
 yazen.ghannam@amd.com, john.allen@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-3-avadhut.naik@amd.com>
 <20240626111036.GOZnv3LFCPnYfrRYSE@fat_crate.local>
 <6c318161-9ae4-4965-b8f3-e38bf1393628@amd.com>
 <20240626181805.GDZnxbXRJlCecNeDGW@fat_crate.local>
 <17bba31a-9bb0-40e5-be7e-96ac6d421066@amd.com>
 <20240710093828.GDZo5WlPrXLg-SbBHd@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240710093828.GDZo5WlPrXLg-SbBHd@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR18CA0048.namprd18.prod.outlook.com
 (2603:10b6:930:13::33) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d110609-d222-49d1-2181-08dca134011e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2VITTV0bU5NREZ4clJCdHYyTkd5Tm5jQjZlaktpdjVFQkR4NmdyYlZMUkhI?=
 =?utf-8?B?azNpTDFsaUhrbFdkNEtyUUFUOGpRMnJkR2J5alU0VEk4cU8wS3Avbk94Qmwr?=
 =?utf-8?B?aW9iN2dxckRwWXd2RUV1N1BLNHArSDlMaVFNQnFObVVsOTlxQ09NMG9NRWdG?=
 =?utf-8?B?NWQ1SldLOEF4anRXY2h0VUtoYXdKajAwYkZjYll1djhvQXhkTU4zQ0paa0kr?=
 =?utf-8?B?aXR5ME1jRllFTXlHY0FKYjZrMW9YeUhnTmJKNmhtOFhma0svSExCKzA1cFc1?=
 =?utf-8?B?cGRCQTBYaFhCYXBpOFRLYllDaTR4eHNIRS9xMVNFMzJIUUU5amVFNkxqVU0r?=
 =?utf-8?B?NUhsR3BYWkx5RTFueEI5RVFVaDRKNThGVWZUNVBPbkNXWThPZVpNWlJpYldT?=
 =?utf-8?B?ZEd6d0RxYVRVQ1d1UlNBdGZsMVdsZ0xSR3BDRVhtbmRMNW41ekRMVWdRdEVN?=
 =?utf-8?B?WCtOcXBHclZhTE9NL1ZYZ0RLdzRHVFA0cmRHNlp2TlZTZENXUXhxUDVYaTJ4?=
 =?utf-8?B?UGpyQkhNYTBHa0NjLy9PQ2NZWXZsdkgvNlFFd3lGdlRBblJ2OXI1Z3E3SDlL?=
 =?utf-8?B?bkkyZEh6OE5qa1VsamZsYzIycVJrM0dwZm5wMmpTbHlLZk9kVXpmcDN5NTI2?=
 =?utf-8?B?T2xWWngrV1FqSFdhUDVDMzNSd3BDTFFKb0Z1QjdyQ2s3Y1RrRFpTZ0tOK0ts?=
 =?utf-8?B?K0FSNTUwS1hQUlpjc2Y1eUoxWUtEZ3E1Mzd2VnBia0xieUxOZW43bEpyQnBw?=
 =?utf-8?B?WmVMUzFFZzEvWUdweGJhM2p5QW9IcGxBdHZQNzJMOUF3Nld2TlZDOFIxN2ZJ?=
 =?utf-8?B?bVRaR3NwZjhOMWJCbEo4T0c0ODA2aE9UcUUxMituTmNiTFQ4WTFPUk44YW5m?=
 =?utf-8?B?TktENTRMdUpCS202ZUh6ZlJNRUl5Y1FOU21QZTFvSW01dFpRYTdET2JaR3lV?=
 =?utf-8?B?Ymg3d1RDdktVNEpvK0hXcjROQ2ZXUGdJcVBYNHN0QWZtZ2NneldjOGNNRk1B?=
 =?utf-8?B?RzRIOHhvRDU4U21td1h5WmlFWDBPcERHWmVsbnZPNEdvejFQTEZXdTk1eDhr?=
 =?utf-8?B?d0pFMVpKT0p3WWZEVHNZS29CNVQwWUdsYUliMy9EeGFtZHRLa0g3WTZydmow?=
 =?utf-8?B?RFpFbEUyYWxrSzlRSjI4QkJjdmhkbnFqdEZ2d2Z2WmFoRDNWemJCNGdGdVgv?=
 =?utf-8?B?bDB4bS9EeHZza1F2ek1Ea0J0TitrTk9rclVBN1hYK1RuOHdvNVpxYlVWRnNq?=
 =?utf-8?B?djVLaHMvR3FDdzh0dkRhWE1VbzdYaEowWExWQzRzYUQ5bXZOZ1VPVGFRR3dU?=
 =?utf-8?B?MkYzTlB6V1EzSmM2ak41R1pnVlcvWTB4a2thSFZMeDlPYnBUb1R3cHFaUGdi?=
 =?utf-8?B?bThsS1NRYUkxYVdpZFZCOWk2bXlwNVJDUnF5c203akZIc1hyK2lJRGJEYVZm?=
 =?utf-8?B?WnU5cXJBNzN1Ny9Hc1VPNGZ1WUwyME9KdVdFR2E2NU9VbjZmOUJwQXVDNDlE?=
 =?utf-8?B?ODRsbTY4UmJuekFwSUMvQVNBdDBCVGtab2xodU5YTjNzR3gwa1hab01TT2dt?=
 =?utf-8?B?Z0xXaHpCNUdEMVd6SHdzeUR5aXpQQ1Y4UnU1eDJObEtSRzg2eDJrcmJqdVpl?=
 =?utf-8?B?THFhZ3RCS0xjZXFhTUhLK1FJUkFaNDRySXd0SXNjK3RlWFh4elJwOEVJUjdi?=
 =?utf-8?B?SDVwRnU2SnhUaE9hWXpCN0dlNmNyWm1Na2g3SWFIdjdrZGp4MEpETTZzR2FE?=
 =?utf-8?B?STZoV1hGbnNDZUNha0JMNy9ORlR3K0o2R2JoTUFZUUVpbnoyNk1JQlplTUJr?=
 =?utf-8?B?NVh6clpZRktRTEVWUS9sUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHRMVW9FV1k1dGt3M3k1Q0lBdXNGdExCU2V3dEFRMWVpRjI2UFBoek5RTFpR?=
 =?utf-8?B?SXJpMjN3L0tlZEQ4TVhTUlhzQlc5UkU5WTVWNW9IUTZQaGdwK2NtNkpjdjlY?=
 =?utf-8?B?dW5mQnEycU45OSs3aFF5MmJNZFlZZ3pBUWZsWEQxcWFFbXdZQWUxRUV0WFhB?=
 =?utf-8?B?SGtrVkcxUWFma21WaHQ3VWRTNnowZkRGczRLb1l3bnBHZ3VlRVRWTnRCeGor?=
 =?utf-8?B?TWdDRmNZNUwyajVmdXFBZUFETk50RjVLYkdBYU94ejJrQm1Gc1lHbWQ3NGEr?=
 =?utf-8?B?WWgyRHA3N0taKzY3aHZ5cVlQMGt3U3F1ZnVpRGVsSW1wRHQxK2xuT3NMRXU0?=
 =?utf-8?B?OG02VFBCb3A4dUM3QlUrMFU2ZURzNXhXU3NndEZ0c2Rualk2RW9ZQi9IcTlV?=
 =?utf-8?B?N3lYeFJnNkxBdmU0bkRFazZYZThKSjFPLytldEExQUE3TERGOVBpdHNpQnEw?=
 =?utf-8?B?UmhWT2NrM1l5aWZ1czBnZjFlY1RmVkc3ZHM1NEIxSjBoNWhGdE0wREhMVlhS?=
 =?utf-8?B?dlJiNktJcDJuNHpNSC8vK1h2b3RFNmR3MWx3eWY0ZlMzckNsV3ZMV3NHSlVG?=
 =?utf-8?B?dXZua3MrZ200Qjg0OFB2dXY3WEZ1NlF5WStPRUcxZE81UUpHd1NNWnZTSEJU?=
 =?utf-8?B?aDEwZmF5eWUvVTFqb05FOUdsQlVlVFVaeVlGSFVrRzF2ZmZtdFRoY1J6MGI0?=
 =?utf-8?B?Q1lJWEJ2dTdoS2U3THYzM2dsbnpKYU9xWUdPRFVpOVRNNUxxNnJ3ZXhLMi9S?=
 =?utf-8?B?eEwwZVZaQUwrY0xaVUNvazl2V2JmY0IzTXhJZlNQVHBkeEtKZVB5Nzk5akZr?=
 =?utf-8?B?UDNLM1h6NE1pemhwTW8rUk9aRUZWMlB5ZGpsODBSMUZMYXAvNmpHTXNyc1Fm?=
 =?utf-8?B?L1pFWG5la3pPVmsvb3ZjZVZNTmlRZTY1cEJtMHp6dVZlTExwL0xEYXRjeVZ0?=
 =?utf-8?B?Yy8vZmNVMEVEc1ZCV0VodXF3WTNSTzBtMk9hWE9CNUsrOHo3Yy94ZitIVWRS?=
 =?utf-8?B?SjNtM0JqNEozV1o4Q0hOOFVwb3dSeEppZ1RTcGtIa1dKTFV4SURRVlI0UEdO?=
 =?utf-8?B?ZzJUVGNxOG9PVjkvVCtqcU5UV3IxVjBOMnZ0aHUzNzM2Sm9YbFhnQnl2TTVl?=
 =?utf-8?B?b29mL2pnSmdOeVFvdCtGL25nTko5RmFPc05HN2RuenVwNTJGakZSVnZsODd2?=
 =?utf-8?B?Q2lYMVpMWEorUm9GUGhtV2NacThCN3lETDAxbE02MnFJYzEvRXU1ZGVqMXZM?=
 =?utf-8?B?c2x1cG8wRXVnZk84OEU1b2NmNzY5SHdhRVg3NTJDYW1pZEtraElKZHlMay9G?=
 =?utf-8?B?VXZ5NWRZbnl1ZWZjUkk0SkdqSW4zQjl3bWloRFV3dVJ0Mmdnc1pEQmUrZEpp?=
 =?utf-8?B?blJmV04wUzIrVnlwWW83a0hvdjltSVZJN3M1ZFg4M3dMOENCaS9KeEpzT2Yw?=
 =?utf-8?B?NXBxc1F0VXNSQS83cVd0U1pQdWZic0xiU2cwY3czY2NlaXVuRTBYOHdZSno0?=
 =?utf-8?B?d1RVRG8zVW1XWmh5Yzd6QWp5VVRDaW13R2c0K3haSERzamwzNndtaHZ5Sng1?=
 =?utf-8?B?bWM5cS8wVzdkdys4QUFWak5UdmUwbUYvVVhuRFZFcFBWZzI4QXhhV0VQM0Y0?=
 =?utf-8?B?cmJTdXpxMk4vQ0IxcEVEWE5Dd2szRGNEZEhvMHl5QWFQQUNLUEtaWllGVnRj?=
 =?utf-8?B?dlBOZW1Pa3VqMmk5QkFpMHRWMHNxWHA1NHBnQ0FuTFJoYitFWGMzUlhTK090?=
 =?utf-8?B?RlhaRWo2THFwMDlxbndrODRhR0ZHNFNWVlJPc01QWmJOaEhBUWFRaEVkVVk4?=
 =?utf-8?B?Uzg5emJ4SjlvQXc0L0JRTjB2bEU1T2Z2bk0zUHBIK0N4THdaeEVLMHpjQlpX?=
 =?utf-8?B?citsTVhNTFBtSHl3NG0zaXVGZUxOYnduN0s4Qi81cHlkdERydHVyY0JOdEp5?=
 =?utf-8?B?TkY2c29jN3l2K1pzdDVhcFYxZE4rTFQydkg2TlBEbDFLNEM5Z3VnN2x1VmVM?=
 =?utf-8?B?TEM4VzRoMWpuQ05IckJObEFJMXVaV0c5Z09EWnhLaHVqNHBCblpvQ2Vsb1VY?=
 =?utf-8?B?Uk5IL2tIbC8yMUFWdzd2RzN3SHVQU0FUVzRFZGZMMEtNZEhqeTZkVGJ6eGEx?=
 =?utf-8?Q?AOo7cGNGAlwYQD52DWrvosrBm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d110609-d222-49d1-2181-08dca134011e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 22:59:51.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymeQgigO3GcSVMFNrQHAFWIZYytQyHoOeuHDgWv3gy2PN7cQEdz2rDD1PLOn/4Pb8DXFiudpyaxqP0WeZC8t6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603



On 7/10/2024 04:38, Borislav Petkov wrote:
> On Tue, Jul 09, 2024 at 01:27:25AM -0500, Naik, Avadhut wrote:
> 
>> Userspace error decoding tools like the rasdaemon gather related hardware error
>> information through the tracepoints. As such, its important to have these two
>> registers in the tracepoint so that the tools like rasdaemon can parse them
>> and output the supplemental error information like FRU Text contained in them.
> 
> Put *that* in the commit message - do not explain what the patch does.
> 
Will do.
 
>> With this set, the first two elements of the vendor data dynamic array are SYND 1/2
>> registers while the third element is MCA_CONFIG (added through patch 4 of the set).
>> Now, in rasdaemon, SYND1/2 register contents (i.e. first two fields) are interpreted
>> as FRU Text only if BIT(9) of MCA_CONFIG (third field) is set.
>>
>> Thus, we depend on array's layout for accurate FRU Text decoding in the rasdaemon.
> 
> So it sounds to me like we want to document and thus freeze the
> vendor-specific blob layout because tools are going to be using and parsing
> it. And this will spare us the kernel version checks.
> 
> And new additions to that AMD-specific blob will come at the end and will
> have to be documented too.
> 
> That sounds like an ok compromise to me...
> 
> Thx.
>
Sounds good!
Is it okay to document this where the new wrapper and vendor-specific data
structures are being defined, in arch/x86/include/asm/mce.h?
Similar approach has been taken for struct mce.
Or do you have any other recommendations?

-- 
Thanks,
Avadhut Naik

